:set paste 

 1332  cd pdks/
 1333  ll
 1334  gcl git@github.com:VLSIDA/skywater-tech.git
 1335  cd ../tools/
 1336  cd openram/
 1337  ll
 1338  cd ..
 1339  rm -rf openram
 1340  gcl git@github.com:VLSIDA/OpenRAM.git
 1341  ll
 1342  ll OpenRAM/
 1343  more OpenRAM/setpaths.sh 
 1344  cd OpenRAM/
 1345  ./setpaths.sh 
 1346  cat ./setpaths.sh 
 1347  export OPENRAM_HOME="`pwd`/compiler"
 1348  hh pyth
 1349  export OPENRAM_HOME=$BASE/toos/OpenRAM/compiler ; export OPENRAM_TECH=$BASE/pdks/skywater-tech
 1350  ls
 1351  cd ..
 1352  ll
 1353  ll ../pdks/skywater-tech/
 1354  ll ../pdks/skywater-tech/sky130/
 1355  export BASE=/home/mk/foss ;export OPENRAM_HOME=$BASE/toos/OpenRAM/compiler ; export OPENRAM_TECH=$BASE/pdks/skywater-tech
 1356  echo $BASE $OPENRAM_TECH $OPENRAM_HOME
 1357  export BASE=/home/mk/foss ;export OPENRAM_HOME=$BASE/toos/OpenRAM/compiler ; export OPENRAM_TECH=$BASE/pdks/skywater-tech ;  echo $BASE; echo $OPENRAM_TECH ; echo  $OPENRAM_HOME
 1358  hh py
 1359  ll
 1360  ll OpenRAM/
 1361  mv  ../pdks/skywater-tech/macros ../designs/sram-macros
 1362  ll ../designs/
 1363  ll ../designs/sram-macros/configs/
 1364  ll ../designs/sram-macros/configs/riscv-sky130-1kbyte.py 
 1365  export BASE=/home/mk/foss ;export OPENRAM_HOME=$BASE/toos/OpenRAM/compiler ; export OPENRAM_TECH=$BASE/pdks/skywater-tech ;  echo $BASE; echo $OPENRAM_TECH ; echo  $OPENRAM_HOME ; python3 $OPENRAM_HOME/openram.py $BASE/design/sram-macros-configs/riscv-sky130-1kbyte.py -d
 1366  export BASE=/home/mk/foss ;export OPENRAM_HOME=$BASE/tools/OpenRAM/compiler ; export OPENRAM_TECH=$BASE/pdks/skywater-tech ;  echo $BASE; echo $OPENRAM_TECH ; echo  $OPENRAM_HOME ; python3 $OPENRAM_HOME/openram.py $BASE/design/sram-macros-configs/riscv-sky130-1kbyte.py -d
 1367  export BASE=/home/mk/foss ;export OPENRAM_HOME=$BASE/tools/OpenRAM/compiler ; export OPENRAM_TECH=$BASE/pdks/skywater-tech ;  echo $BASE; echo $OPENRAM_TECH ; echo  $OPENRAM_HOME ; python3 $OPENRAM_HOME/openram.py $BASE/design/sram-macros/configs/riscv-sky130-1kbyte.py -d
 1368  export BASE=/home/mk/foss ;export OPENRAM_HOME=$BASE/tools/OpenRAM/compiler ; export OPENRAM_TECH=$BASE/pdks/skywater-tech ;  echo $BASE; echo $OPENRAM_TECH ; echo  $OPENRAM_HOME ; python3 $OPENRAM_HOME/openram.py $BASE/designs/sram-macros/configs/riscv-sky130-1kbyte.py -d
 1369  export BASE=/home/mk/foss ; export SW_PDK_ROOT=/ef/tech/SW.2 ; export OPENRAM_HOME=$BASE/tools/OpenRAM/compiler ; export OPENRAM_TECH=$BASE/pdks/skywater-tech ;  echo $BASE; echo $OPENRAM_TECH ; echo  $OPENRAM_HOME ; python3 $OPENRAM_HOME/openram.py $BASE/designs/sram-macros/configs/riscv-sky130-1kbyte.py -d
 1370  cd ../pdks/
 1371  cd skywater-tech/
 1372  make
 1373  h

