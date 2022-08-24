Con nuestro servicio instalado y configurado, el siguiente paso es crear la estructura básica del directorio. Es decir, crearemos la estructura jerárquica del árbol (DIT -- Directory Information Tree).

Una de las formas más sencillas de añadir entradas al directorio es mediante ficheros LDIF (LDAP Data Interchange Format). Básicamente se tratan de ficheros en texto plano con un formato particular que debemos conocer para poder construirlos correctamente. El formato básico de una entrada es el siguiente:

```
# comentario
dn: <nombre distintivo único>
<atributo>: <valor>
<atributo>: <valor>
...
```

Teniendo en cuenta lo anteriormente mencionado, procedemos a crear un fichero base que contenga los tipos de objetos básicos del directorio. 

```
nano base.ldif
```

En él vamos a crear dos entradas referentes a unidades organizativas: «usuarios» y «grupos». Las unidades organizativas, como su propio nombre indica, son atributos que nos van a servir para estructurar de forma idónea nuestro árbol del directorio LDAP. Estas dos entradas serán la base de nuestro árbol ya que de ellas dependerán varias entradas más adelante.

![](https://blog.sysdual.com/wp-content/uploads/2020/12/12.png)

Una vez creado el fichero base.ldif, procedemos a cargarlo en directorio LDAP. Para ello ejecutamos la siguiente instrucción:

```
sudo ldapadd -x -D cn=admin,dc=pandora,dc=ldap -W -f base.ldif
```

![](https://blog.sysdual.com/wp-content/uploads/2020/12/14.png)

Una vez cargadas las entradas, vamos a proceder a crear nuevas entradas que colgarán de las unidades organizativas que acabamos de crear. Vamos a crear una entrada para un grupo y una entrada para un usuario.

Antes que nada, como buena práctica de seguridad, vamos a generar una contraseña cifrada para asignárselas a los usuarios en el fichero LDIF que vamos a crear. Para ello ejecutamos el siguiente comando:

```
slappasswd
```

Escribimos la contraseña dos veces y nos devolverá la misma cifrada por el algoritmo criptográfico SSHA.

![](https://blog.sysdual.com/wp-content/uploads/2020/12/15.png)

Ahora que tenemos la contraseña cifrada creamos nuestro fichero content.ldif, donde vamos a crear dos entradas: un grupo llamado devops que colgará de la unidad organizativa grupos y un usuario llamado mordecai que colgará de la unidad organizativa usuarios y a su vez pertenecerá al grupo devops.

```
nano content.ldif
```

![](https://blog.sysdual.com/wp-content/uploads/2020/12/16.png)

De la misma forma que anteriormente, procedemos a cargar las entradas en el directorio LDAP ejecutando la siguiente instrucción:

```
sudo ldapadd -x -D cn=admin,dc=pandora,dc=ldap -W -f content.ldif
```

![](https://blog.sysdual.com/wp-content/uploads/2020/12/17.png)

Llegados a este punto ya tenemos una estructura jerárquica del árbol creada de la siguiente manera:

![](https://blog.juananpc.es/wp-content/uploads/2021/07/arbol.png)

Para poder ver las diferentes entradas que forman nuestro directorio LDAP ejecutamos el comando slapcat.

```
sudo slapcat
```

```
 dn: dc=pandora,dc=ldap
 objectClass: top
 objectClass: dcObject
 objectClass: organization
 o: pandora
 dc: pandora
 structuralObjectClass: organization
 entryUUID: 7b982cc0-d599-103a-93b2-3d7047cfd04f
 creatorsName: cn=admin,dc=pandora,dc=ldap
 createTimestamp: 20201218162610Z
 entryCSN: 20201218162610.450021Z#000000#000#000000
 modifiersName: cn=admin,dc=pandora,dc=ldap
 modifyTimestamp: 20201218162610Z

 dn: cn=admin,dc=pandora,dc=ldap
 objectClass: simpleSecurityObject
 objectClass: organizationalRole
 cn: admin
 description: LDAP administrator
 userPassword:: e1NTSEF9MmRTdDVqK0ZtVFJpdFAwQ0g4QmkyNUkwK242dFcxakc=
 structuralObjectClass: organizationalRole
 entryUUID: 7b9b37a8-d599-103a-93b3-3d7047cfd04f
 creatorsName: cn=admin,dc=pandora,dc=ldap
 createTimestamp: 20201218162610Z
 entryCSN: 20201218162610.470043Z#000000#000#000000
 modifiersName: cn=admin,dc=pandora,dc=ldap
 modifyTimestamp: 20201218162610Z

 dn: ou=usuarios,dc=pandora,dc=ldap
 objectClass: organizationalUnit
 objectClass: top
 ou: usuarios
 structuralObjectClass: organizationalUnit
 entryUUID: 4159df9c-d74a-103a-86e5-c92b1d7a3d24
 creatorsName: cn=admin,dc=pandora,dc=ldap
 createTimestamp: 20201220200404Z
 entryCSN: 20201220200404.817837Z#000000#000#000000
 modifiersName: cn=admin,dc=pandora,dc=ldap
 modifyTimestamp: 20201220200404Z

 dn: ou=grupos,dc=pandora,dc=ldap
 objectClass: organizationalUnit
 objectClass: top
 ou: grupos
 structuralObjectClass: organizationalUnit
 entryUUID: 416283fe-d74a-103a-86e6-c92b1d7a3d24
 creatorsName: cn=admin,dc=pandora,dc=ldap
 createTimestamp: 20201220200404Z
 entryCSN: 20201220200404.874510Z#000000#000#000000
 modifiersName: cn=admin,dc=pandora,dc=ldap
 modifyTimestamp: 20201220200404Z

 dn: cn=devops,ou=grupos,dc=pandora,dc=ldap
 objectClass: posixGroup
 cn: devops
 gidNumber: 10000
 memberUid: devops
 structuralObjectClass: posixGroup
 entryUUID: fdac9144-d7f4-103a-86e7-c92b1d7a3d24
 creatorsName: cn=admin,dc=pandora,dc=ldap
 createTimestamp: 20201221162615Z
 entryCSN: 20201221162615.215505Z#000000#000#000000
 modifiersName: cn=admin,dc=pandora,dc=ldap
 modifyTimestamp: 20201221162615Z

 dn: uid=mordecai,ou=usuarios,dc=pandora,dc=ldap
 objectClass: inetOrgPerson
 objectClass: posixAccount
 objectClass: shadowAccount
 cn: Mordecai
 sn: Geek
 userPassword:: e1NTSEF9Z0d1eUZkMGlyVld5WkNkSUNRN1AySytUUENPQ0I5ZUI=
 loginShell: /bin/bash
 uidNumber: 10000
 gidNumber: 10000
 homeDirectory: /home/mordecai
 structuralObjectClass: inetOrgPerson
 uid: mordecai
 entryUUID: fdb16106-d7f4-103a-86e8-c92b1d7a3d24
 creatorsName: cn=admin,dc=pandora,dc=ldap
 createTimestamp: 20201221162615Z
 entryCSN: 20201221162615.247033Z#000000#000#000000
 modifiersName: cn=admin,dc=pandora,dc=ldap
 modifyTimestamp: 20201221162615Z
```