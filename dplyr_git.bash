git init
git add .
git status
#add the access keys from C:\Users\Dave\.ssh\id_rsa.pub to BitBucket
git remote add origin https://djjansz1@bitbucket.org/djjansz1/dplyr_examples.git
git clone https://djjansz1@bitbucket.org/djjansz1/dplyr_examples.git
git pull origin master
cd /c/src/Dplyr_Master/dplyr_examples
git checkout master
#merge changes done in develop into master
git merge develop
