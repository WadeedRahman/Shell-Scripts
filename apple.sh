#!/bin/bash

task1()
{
cd Desktop
mkdir project
cd project
touch  file.sh
 echo "Done"
}

task2()
{
#Create React App
npx create-react-app myapp
cd myapp
npm start
echo "done"
}

if ! task1;
then
echo "Already done"
exit 1
fi

if ! task2;
 then
echo "Already done"
exit 2
fi

echo "Not perform"
