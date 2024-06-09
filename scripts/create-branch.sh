#!/bin/zsh

create_branch() {
  local type=$1
  local name=$2
  local branch_name="${type}/${name}"

  # Check if the development branch exists
  if ! git show-ref --verify --quiet refs/heads/development; then
    echo ":: Development branch does not exist. Creating it from main branch."
    git checkout main
    git pull origin main
    git checkout -b development
    git push -u origin development
  fi

  # Checkout development branch and pull the latest changes
  git checkout development
  git pull origin development

  # Create the new branch and push it to the remote repository
  git checkout -b "$branch_name"
  git push -u origin "$branch_name"
  echo ":: Branch '$branch_name' created and pushed to remote."
}

# Prompt for branch type if not provided as an argument
if [ "$#" -ne 1 ]; then
  echo ":: Please select the branch type:"
  echo "1) feat"
  echo "2) fix"
  echo "3) docs"
  echo "4) style"
  echo "5) refactor"
  echo "6) perf"
  echo "7) test"
  echo "8) chore"
  echo -n "Enter your choice (1-8): "
  read choice

  case $choice in
    1)
      type="feat"
      ;;
    2)
      type="fix"
      ;;
    3)
      type="docs"
      ;;
    4)
      type="style"
      ;;
    5)
      type="refactor"
      ;;
    6)
      type="perf"
      ;;
    7)
      type="test"
      ;;
    8)
      type="chore"
      ;;
    *)
      echo ":: Invalid choice. Exiting."
      exit 1
      ;;
  esac
else
  type=$1

  # Validate the branch type
  valid_types=("feat" "fix" "docs" "style" "refactor" "perf" "test" "chore")
  if [[ ! " ${valid_types[@]} " =~ " ${type} " ]]; then
    echo ":: Invalid branch type. Use one of: ${valid_types[*]}."
    exit 1
  fi
fi

echo -n ":: Enter the branch name: "
read name

# Validate the branch name (optional, you can add more rules if needed)
if [[ -z "$name" ]]; then
  echo ":: Branch name cannot be empty."
  exit 1
fi

create_branch "$type" "$name"
