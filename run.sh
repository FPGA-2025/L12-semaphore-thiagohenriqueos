#!/bin/sh

if [ -z "$1" ]; then
    echo "Erro: É preciso especificar o número do teste"
    exit 1
fi

iverilog -o tb *.v
rm -f saida.out
cp test/teste$1.txt teste.txt
./tb > saida.out
cp saida.out test/saida$1.out
cp saida.vcd test/saida$1.vcd
rm -f saida.out saida.vcd

# Sem usar <( ), usamos arquivo temporário:
grep '===' test/saida$1.out > temp_diff.txt

diff -Z temp_diff.txt test/saida$1.ok >/dev/null

if [ $? -eq 0 ]; then
    echo "OK"
    exit 0
else
    echo "ERRO"
    exit 1
fi

rm -f temp_diff.txt
