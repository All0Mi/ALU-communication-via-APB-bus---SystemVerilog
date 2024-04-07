#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo "$GREEN[Symulation without synthesis]$NC"

# Definiuj listę prawidłowych nazw modułów
valid_modules="left_shift compare bit_change u2_to_sm mux_4to1 register exe_unit_w26"

# Sprawdź, czy podano prawidłową liczbę argumentów
if [ $# -ne 1 ]; then
    echo "Usage: $0 <module_name>"
    exit 1
fi

module_name=$1
valid=false

# Sprawdź, czy module_name znajduje się na liście prawidłowych modułów
case " $valid_modules " in
    *" $module_name "*)
        valid=true
        ;;
esac

if ! $valid; then
    echo "Module name '$module_name' is not valid."
    echo "List of valid modules:"
    echo "$valid_modules"
    exit 1
fi

# Utwórz katalog tymczasowy
echo  "$CYAN[INFO]$NC Creating tmp directory"
mkdir ./tmp/

# Utwórz katalog symulacyjny
echo  "$CYAN[INFO]$NC Creating sim directory"
mkdir ./testbench/sim/

module_dir=./modules/$module_name.sv

cp ./testbench/tb_$module_name.sv ./tmp/tb_${module_name}_original || { echo  "${RED}[ERROR] Failed to copy testbench file to temporary directory.${NC}"; exit 1; }

# Zastąp zmienną ścieżki modułu w pliku testowym
echo  "$CYAN[INFO]$NC Editing testbench"
sed -i "s|%INCLUDE%|$module_dir|" ./testbench/tb_$module_name.sv

echo  "$CYAN[INFO]$NC Running iverilog"
iverilog -g2005-sv -o ./testbench/sim/tb_$module_name ./testbench/tb_$module_name.sv || { echo  "${RED}[ERROR] Compilation with iverilog failed.${NC}"; exit 1; }

echo  "$CYAN[INFO]$NC Running vvp\n"
vvp ./testbench/sim/tb_$module_name || { echo  "${RED}[ERROR] Execution with vvp failed.${NC}"; exit 1; }

# Przywróć oryginalny plik testowy
echo  "$CYAN[INFO]$NC Restoring testbench to orignal state"
mv ./tmp/tb_${module_name}_original ./testbench/tb_$module_name.sv || { echo  "${RED}[ERROR] Failed to restore testbench file.${NC}"; exit 1; }

# Usuń katalog tymczasowy
echo  "$CYAN[INFO]$NC Removing temp directory"
rm -rf ./tmp || { echo  "${RED}[ERROR] Failed to remove temporary directory.${NC}"; exit 1; }

# Wyczyść katalog symulacyjny
# echo  "$CYAN[INFO]$NC Removing sim directory"
# rm -rf ./testbench/sim/ || { echo  "${RED}[ERROR] Failed to clean up sim directory.${NC}"; exit 1; }
