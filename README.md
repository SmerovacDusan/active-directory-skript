# active-directory-skript
Powershell skript pro vytvoření OU, skupin, uživatelů a přidání vytvořených uživatelů do vytvořených OU a skupin.

## Atributy  csv souborů
### OU.csv
- **OUJmeno** - jméno OU, která bude vytvořena
- **cestaOU** - cesta kam bude OU vytvořena počínaje nejnižsí úrovní v hierarchii

<pre>
└── domena.local
    ├── Builtin
    ├── Computers
    ├── Domain Controllers
    ├── Firma
    ├── ForeignSecurityPrincipals
    ├── ManagedServiceAccounts
    └── Users
</pre>

***Pokud budeme uvažovat strukturu AD výše a budeme chtít vytvořit OU s názvem IT do OU s názvem Firma, tak jako hodnotu atributu použijeme OU=Firma,DC=domena,DC=local.***
***Pokud budeme chtít vytvořit OU přímo pod domena.local (jako OU Firma), použijeme pouze DC=domena,DC=local.***

### skupiny.csv
- **jmenoSkupiny** - jméno skupiny, která bude vytvořena
- **typSkupiny** - hodnota Security nebo 1 pro skupinu se zabezpečením, hodnota Distributed nebo 0 pro skupinu distribuční
- **rozsah** - hodnota DomainLocal nebo 0 pro místní doménovou skupinu, hodnota Global nebo 1 pro globální skupinu, hodnota Universal nebo 2 pro univerzální skupinu
- **cestaSkupiny** - stejné jako u OU

<pre>
└── domena.local
    ├── Builtin
    ├── Computers
    ├── Domain Controllers
    ├── Firma
        └── IT
    ├── ForeignSecurityPrincipals
    ├── ManagedServiceAccounts
    └── Users
</pre>

***Pokud budeme chtít do struktury výše vytvořit do OU IT skupinu IT_skupina, tak hodnota atributu cestaSkupiny použijeme OU=IT,OU=Firma,DC=domena,DC=local.***

### uzivatele.csv
- **jmeno** - křestní jméno uživatele
- **prijmeni** - příjmení uživatele
- **login** - přihlašovací jméno uživatele, **nutné použít u -SamAccountName ve skriptu, aby se uživatel mohl přihlásit k počítači**
- **email** - email uživatele
- **heslo** - defaultní heslo uživatele
- **ou** - stejné jako u OU
- **skupina** - název skupiny, kam bude uživatel umístěn

<pre>
└── domena.local
    ├── Builtin
    ├── Computers
    ├── Domain Controllers
    ├── Firma
        └── IT
            ├── Dušan Skočdopole
            └── IT_skupina
    ├── ForeignSecurityPrincipals
    ├── ManagedServiceAccounts
    └── Users
</pre>

***Do struktury výše byl vytvořen uživatel Dušan Skočdopole. Hodnota atributu ou byla OU=IT,OU=Firma,DC=domena,DC=local.***
***Uživatel byl po vytvoření přidán do skupiny IT_skupina, která se nachází ve stejné OU.***

## Skript
### Některé věci, které řeší skript
1. **Cesty k csv souborům**
2. **Delimiter csv souborů**
3. **GroupCategory je defaultně nastaveno na Security**
4. **GroupScope je defaultně nastav na Global**
5. **UserPrincipalName je string složený z loginu uživatele a názvu domény (domena.local)**
6. **Účet uživatele je povolen pomocí Enabled 1**
7. **Uživatel je nucen změnit defaultní heslo při prvním přihlášení pomocí ChangePasswordAtLogOn 1**
8. **Přidání uživatele do skupiny**

## Úpravy skriptu a csv souborů
Vše se dá upravit podle vlastních potřeb. Od jmen přes cesty k objektům až po celý skript. K úpravám doporučuji stránky od Microsoftu s informacemi o atributech k [vytvoření OU](https://learn.microsoft.com/en-us/powershell/module/activedirectory/new-adorganizationalunit?view=windowsserver2022-ps), [vytvoření skupin](https://learn.microsoft.com/en-us/powershell/module/activedirectory/new-adgroup?view=windowsserver2022-ps), [vytvoření uživatelů](https://learn.microsoft.com/en-us/powershell/module/activedirectory/new-aduser?view=windowsserver2022-ps) a [přidání uživatelů do skupiny](https://learn.microsoft.com/en-us/powershell/module/activedirectory/add-adgroupmember?view=windowsserver2022-ps).
