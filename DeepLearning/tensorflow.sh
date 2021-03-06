#!/bin/bash

###### Clear Old virtualenvs #######################
for i in tf1.0cp27 tf1.0cp36 tf1.1cp27 tf1.1cp36 tf1.2cp27 tf1.2cp36 tf1.3cp27 tf1.3cp36 tf1.4cp27; do
    echo "rm -rf ${HOME}/.virtualenvs/$i"
    rm -rf ${HOME}/.virtualenvs/$i
done

###### Virtualenvs Setting###########################

# Check Cuda env and setting
x=`echo $CUDA_HOME`
if [ ${#x} -eq 0 ];then
	cat>>${HOME}/.bashrc<<EOF
export PATH=${HOME}/.local/bin:/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64"
export CUDA_HOME=/usr/local/cuda
EOF
	. ${HOME}/.bashrc
fi

# Check Virtualenvs and install
x=`pip list --format=columns|grep virtualenvwrapper|wc -l`
if [ $x = "0" ]; then
    sudo -H pip install virtualenv virtualenvwrapper
fi

# Check Virtualenvs env and setting
x=`echo $WORKON_HOME`
if [ ${#x} -eq 0 ];then
    cat>>~/.bashrc<<EOF
export WORKON_HOME=${HOME}/.virtualenvs
. /usr/local/bin/virtualenvwrapper.sh
EOF
	. ${HOME}/.bashrc
fi

###### Install the jupyter notebook ################

# Check jupyter and install
x=`pip list --format=columns|grep jupyter|wc -l`
if [ $x = "0" ]; then
	pip install jupyter
fi

###### Tensorflow Install ##########################
mkvirtualenv -p python2.7 tf1.0cp27
pip install ipython ipykernel seaborn
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.0.0rc2-cp27-none-linux_x86_64.whl
pip install --upgrade $TF_BINARY_URL
python -m ipykernel install --user --name=tf1.0cp27

mkvirtualenv -p python3.6 tf1.0cp36
pip install ipython ipykernel seaborn
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.0.0rc2-cp36-cp36m-linux_x86_64.whl
pip install --upgrade $TF_BINARY_URL
python -m ipykernel install --user --name=tf1.0cp36


mkvirtualenv -p python2.7 tf1.1cp27
pip install ipython ipykernel seaborn
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.1.0rc2-cp27-none-linux_x86_64.whl
pip install --upgrade $TF_BINARY_URL
python -m ipykernel install --user --name=tf1.1cp27

mkvirtualenv -p python3.6 tf1.1cp36
pip install ipython ipykernel seaborn
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.1.0rc2-cp36-cp36m-linux_x86_64.whl
pip install --upgrade $TF_BINARY_URL
python -m ipykernel install --user --name=tf1.1cp36


mkvirtualenv -p python2.7 tf1.2cp27
pip install ipython ipykernel seaborn
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.2.1-cp27-none-linux_x86_64.whl
pip install --upgrade $TF_BINARY_URL
python -m ipykernel install --user --name=tf1.2cp27

mkvirtualenv -p python3.6 tf1.2cp36
pip install ipython ipykernel seaborn
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.2.1-cp36-cp36m-linux_x86_64.whl
pip install --upgrade $TF_BINARY_URL
python -m ipykernel install --user --name=tf1.2cp36


mkvirtualenv -p python2.7 tf1.3cp27
pip install ipython ipykernel seaborn
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.3.0rc2-cp27-none-linux_x86_64.whl
pip install --upgrade $TF_BINARY_URL
python -m ipykernel install --user --name=tf1.3cp27

mkvirtualenv -p python3.6 tf1.3cp36
pip install ipython ipykernel seaborn
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.3.0rc2-cp36-cp36m-linux_x86_64.whl
pip install --upgrade $TF_BINARY_URL
python -m ipykernel install --user --name=tf1.3cp36


mkvirtualenv -p python2.7 tf1.4cp27
pip install ipython ipykernel seaborn
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.4.0rc1-cp27-none-linux_x86_64.whl
pip install --upgrade $TF_BINARY_URL
python -m ipykernel install --user --name=tf1.4cp27

###### Check #######################################
echo "
from __future__ import print_function
import tensorflow as tf
import sys
print(tf.__version__, sys.version_info)
">${HOME}/.test.py
echo ""> ${HOME}/.test.txt

workon tf1.0cp27
python ${HOME}/.test.py >> ${HOME}/.test.txt
workon tf1.0cp36
python ${HOME}/.test.py >> ${HOME}/.test.txt
workon tf1.1cp27
python ${HOME}/.test.py >> ${HOME}/.test.txt
workon tf1.1cp36
python ${HOME}/.test.py >> ${HOME}/.test.txt
workon tf1.2cp27
python ${HOME}/.test.py >> ${HOME}/.test.txt
workon tf1.2cp36
python ${HOME}/.test.py >> ${HOME}/.test.txt
workon tf1.3cp27
python ${HOME}/.test.py >> ${HOME}/.test.txt
workon tf1.3cp36
python ${HOME}/.test.py >> ${HOME}/.test.txt
workon tf1.4cp27
python ${HOME}/.test.py >> ${HOME}/.test.txt

cat ${HOME}/.test.txt
rm ${HOME}/.test.txt
