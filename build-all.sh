# MUST SET PDK_ROOT

export PDK_ROOT=~/zooz
cd $PDK_ROOT

git clone git@github.com:google/skywater-pdk -b master
cd skywater-pdk
git checkout 4e5e318e0cc578090e1ae7d6f2cb1ec99f363120

git submodule update --init libraries/sky130_fd_sc_hd/latest
# git submodule update --init libraries/sky130_fd_sc_hs/latest
# git submodule update --init libraries/sky130_fd_sc_ms/latest
# git submodule update --init libraries/sky130_fd_sc_ls/latest
# git submodule update --init libraries/sky130_fd_sc_hdll/latest

# make timing
make sky130_fd_sc_hd

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


docker run  -v $(pwd):/openLANE_flow -v $PDK_ROOT:$PDK_ROOT -e PDK_ROOT=$PDK_ROOT -u $(id -u $USER):$(id -g $USER) openlane:rc2 bash -c "./flow.tcl -design spm"
docker run  -v $(pwd):/openLANE_flow -v $PDK_ROOT:$PDK_ROOT -e PDK_ROOT=$PDK_ROOT -u $(id -u $USER):$(id -g $USER) openlane:rc2 bash -c "./flow.tcl -design xtea"
docker run  -v $(pwd):/openLANE_flow -v $PDK_ROOT:$PDK_ROOT -e PDK_ROOT=$PDK_ROOT -u $(id -u $USER):$(id -g $USER) openlane:rc2 bash -c "./flow.tcl -design md5"
