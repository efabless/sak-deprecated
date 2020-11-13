# MUST SET PDK_ROOT
export PDK_ROOT=~/zooz
cd $PDK_ROOT
git clone git@github.com:google/skywater-pdk -b master
cd skywater-pdk
git submodule update --init libraries/sky130_fd_sc_hd/latest
# git submodule update --init libraries/sky130_fd_sc_hs/latest
# git submodule update --init libraries/sky130_fd_sc_ms/latest
# git submodule update --init libraries/sky130_fd_sc_ls/latest
# git submodule update --init libraries/sky130_fd_sc_hdll/latest
make timing
cd $PDK_ROOT
git clone git@github.com:efabless/open_pdks.git -b rc2
cd open_pdks
make
make install-local
cd $PDK_ROOT
git clone git@github.com:efabless/openlane -b rc2
cd openlane/docker_build
make merge
cd ..
~                                                                                                                                                                                                                             
~         
