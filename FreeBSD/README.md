Add to /etc/**login.conf**:
```
russianu|Russian UTF-8 Users Accounts:\
        :charset=UTF-8:\
        :lang=ru_RU.UTF-8:\
        :tc=default:
```
`vipw` - add class **russianu**

`ln -s /usr/share/zoneinfo/Europe/Moscow /etc/localtime`

Color switching in **.bashrc** is not working (like in Arch)! Tried different.
