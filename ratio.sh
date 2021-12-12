#!/bin/sh

echo "Enter ID"
read ID

clear

CMD="curl -L -s https://web.archive.org/web/20211014144930/https://www.youtube.com/watch?v=$ID"

V_TITLE=$(eval $CMD | grep -o '<title>.*</title>' | sed 's/<title>//g' | sed 's/<\/title>//g')
V_DATE=$(eval $CMD | grep -o '[A-Z][a-z][a-z] [0-9]*, [0-9][0-9][0-9][0-9]' | head -1)
V_YEAR=$(echo $V_DATE | grep -o '20[0-9][0-9]')
V_MONTH=$(echo $V_DATE | grep -o '[A-Z][a-z][a-z]')
V_DAY=$(echo $V_DATE | grep -o '[0-9]*,' | sed 's/\,//g')

if [ $V_YEAR ] && [ $V_MONTH ] && [ $V_DAY ];
then
  echo $V_TITLE
  if [ "$V_YEAR" -ge 2021 ]; 
  then
    if [ "$V_YEAR" -eq 2021 ]; 
    then
      if [ $V_MONTH != 'Nov' ] && [ $V_MONTH != 'Dec' ];
      then
        eval $CMD | grep -o '[0-9,]* likes' | head -1
        eval $CMD | grep -o '[0-9,]* dislikes' | head -1
      fi
      if [ $V_MONTH = 'Dec' ];
      then
        echo $V_MONTH
      fi
      if [ $V_MONTH = 'Nov' ]; 
      then
        if [ $V_DAY -ge 10 ];
        then
          echo $V_DAY
        else
          eval $CMD | grep -o '[0-9,]* likes' | head -1
          eval $CMD | grep -o '[0-9,]* dislikes' | head -1
        fi
      fi
    fi
    if [ "$V_YEAR" -gt 2021 ];
    then
      echo $V_YEAR
    fi
  else
    eval $CMD | grep -o '[0-9,]* likes' | head -1
    eval $CMD | grep -o '[0-9,]* dislikes' | head -1
  fi
fi

echo Done..
sleep 5
done

