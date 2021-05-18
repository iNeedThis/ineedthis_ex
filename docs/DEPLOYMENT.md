# ineedthis

## Deployment
You need a key installed on the server you target, and the git remote installed in your ssh configuration.

    git remote add production ineedthis@<serverip>:ineedthis/

The general syntax is:

    git push production master

And if everything goes wrong:

    git reset HEAD^ --hard
    git push -f production master

(to be repeated until it works again)
