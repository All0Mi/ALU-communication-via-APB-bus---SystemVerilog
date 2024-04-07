#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo "$GREEN[Symulation with synthesis]$NC"

# Zdefiniuj listę prawidłowych nazw modułów
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

# Zapisz oryginalną zawartość pliku
cp ./run.ys ./tmp/run_original.ys || { echo  "${RED}[ERROR] Failed to copy run.ys to temporary directory.${NC}"; exit 1; }

# Edytuj parametr wewnątrz pliku
# Z jakiegoś powodu nie zastępuje wszystkich "%PARAM%" naraz??
echo  "$CYAN[INFO]$NC Editing run.ys to synthesize $module_name module"
sed -i "s/%PARAM%/$module_name/" run.ys
sed -i "s/%PARAM%/$module_name/" run.ys
sleep .5

# Uruchom synteze yosys
echo  "$CYAN[INFO]$NC Running YOSYS (quiet mode)"
yosys -q run.ys || { echo  "${RED}[ERROR] YOSYS synthesis failed.${NC}"; exit 1; }
#yosys -l ./log.txt run.ys || { echo  "${RED}[ERROR] YOSYS synthesis failed.${NC}"; exit 1; }
echo  "$CYAN[INFO]$NC Synthesis result saved as ./synth/${module_name}_rtl.sv"

# Przywróć plik do stanu pierwotnego
echo  "$CYAN[INFO]$NC Restoring run.ys to orignal state"
mv ./tmp/run_original.ys run.ys || { echo  "${RED}[ERROR] Failed to restore run.ys.${NC}"; exit 1; }

synth_module="./synth/${module_name}_rtl.sv"

cp ./testbench/tb_$module_name.sv ./tmp/tb_${module_name}_original || { echo  "${RED}[ERROR] Failed to copy testbench file to temporary directory.${NC}"; exit 1; }

# Zastąp zmienną ścieżki modułu w pliku testowym
echo  "$CYAN[INFO]$NC Editing testbench to test synthesized $module_name module (${module_name}_rtl.sv)"
sed -i "s|%INCLUDE%|$synth_module|" ./testbench/tb_$module_name.sv

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
