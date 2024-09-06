#!/bin/sh

echo "Start php-cs-fixer"
FILES=`git status --porcelain | grep -e '^[AM|M| M]\(.*\).php$' | cut -c 3- | tr '\n' ' '`
if [ -z "$FILES" ]
    then
        echo "Files for php-cs-fixer is not found"
    else
        php ./vendor/bin/php-cs-fixer fix --config=.php-cs-fixer.php --using-cache=no -v ${FILES}
fi

printf "\n"
echo "Start php-stan"
FILES=`git status --porcelain | grep -e '^[AM|M| M]\(.*\).php$' | cut -c 3- | tr '\n' ' '`
if [ -z "$FILES" ]
    then
        echo "Files for php-stan is not found"
    else
        echo ${FILES}
        php vendor/bin/phpstan analyse $(printf -- "${FILES}") -c phpstan.neon --memory-limit=4G
fi

