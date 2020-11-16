#!/bin/bash

sed -ie 's/ a=[^ ]*//g' $1
sed -ie 's/ p=[^ ]*//g' $1
sed -ie 's/ mult=[^ ]*//g' $1
sed -ie 's/ r=[^ ]*//g' $1
sed -ie 's/ m=\([^ ]*\)/ m=(\1)/g' $1
sed -ie 's/ A=[^ ]*//g' $1
sed -ie 's/ P=[^ ]*//g' $1
sed -ie 's/ MULT=[^ ]*//g' $1
sed -ie 's/ R=[^ ]*//g' $1

