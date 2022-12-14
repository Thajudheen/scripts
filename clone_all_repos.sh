!/bin/bash
# GitHub API Token
GH_API_TOKEN=''
# GitHub User Name
GH_USER='abcd'
# 1st workiking CLI to clone repos thro API call
curl -X GET -u $GH_USER:aaaaa https://api.github.com/users/$GH_USER/repos | grep -e 'clone_url*' |\
  cut -d \" -f 4 |\
  xargs -L1 git clone

# 2nd working CLI
curl -X GET -u $GH_USER:bbbbb https://api.github.com/users/$GH_USER/repos | grep -o 'git@[^"]*' | xargs -L1 git clone


# 3rd  working CLI
curl -H 'Authorization:ccccc' "https://api.github.com/users/$GH_USER/repos?&per_page=1000" | grep -w clone_url | grep -o '[^"]\+://.\+.git' | xargs -L1 git clone
# 4th   working CLI

curl -H 'Authorization:ddddd' "https://api.github.com/users/$GHUSER/repos?&per_page=1000" | jq -r '.[]|.clone_url' | xargs -L1 git clone

# Call the function in Bash script. Usage: gh-clone-user (user)
gh-clone-user() {
  curl -sL "https://api.github.com/users/$GH_USER/repos?per_page=1000" | jq -r '.[]|.clone_url' | xargs -L1 git clone
}

