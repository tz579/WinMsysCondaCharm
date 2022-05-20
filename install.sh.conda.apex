git clone https://github.com/NVIDIA/apex
git -C apex clean -xfdf
git -C apex pull
pip install --no-cache-dir --disable-pip-version-check -v -e apex # pure-python version, no cuda matching requirement
#pip install --no-cache-dir --disable-pip-version-check -v -e apex --global-option="--cpp_ext" --global-option="--cuda_ext" # strict cuda matching requirement
