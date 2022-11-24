

La herramienta `ldapsearch`, provista por el paquete, resulta muy conveniente al momento de hacer consultas sobre los datos dentro de un directorio LDAP desde línea de comandos. Este artículo presenta una serie de consultas de ejemplo que pueden resultar muy útiles para obtener información valiosa de un árbol LDAP.

#### Obtener todos los objetos de un directorio

Para obtener todos los objetos en un directorio (dn) a partir de cierta base (`dc=linuxito,dc=com`) y sin límite de para la respuesta, utilizar una consulta como la siguiente:

<pre>ldapsearch -z 0 -H ldap://localhost:389 -W -D "cn=root,dc=linuxito,dc=com" -b "dc=linuxito,dc=com" "(objectclass=*)
</pre>

*   `-z 0`: evita cortar la respuesta una vez alcanzado cierto límite (cantidad de entradas).
*   `-H ldap://localhost:389`: indica que consulte al servidor LDAP en el puerto 389 del host local.
*   `-W`: indica que solicite la contraseña para el método de autenticación simple de manera interactiva.
*   `-D "cn=root,dc=linuxito,dc=com"`: especifica el usuario con el cual se autentica en el servidor LDAP.
*   `-b "dc=linuxito,dc=com"`: especifica la base desde donde comenzar la búsqueda (en este caso se trata de la raíz del directorio).
*   `"(objectclass=*)"`: especifica el filtro para la búsqueda (en este ejemplo todos los objetos, este a su vez es el filtro por defecto).

El punto importante es no olvidar especificar la base (`-b`). De lo contrario probablemente no haya resultados en la búsqueda:

<pre># search result
search: 2
result: 32 No such object
</pre>

Ejemplo (utilizando `grep` para filtrar sólo los dn):

<pre class="konsole">root@debian:~# ldapsearch -z 0 -H ldap://localhost:389 -W -D "cn=root,dc=linuxito,dc=com" -b "dc=linuxito,dc=com" "(objectclass=*)" | grep "dn:"
Enter LDAP Password: 
dn: dc=linuxito,dc=com
dn: cn=Manager,dc=linuxito,dc=com
dn: ou=users,dc=linuxito,dc=com
dn: uid=emiliano,ou=users,dc=linuxito,dc=com
dn: uid=test,ou=users,dc=linuxito,dc=com
dn: ou=fusiondirectory,dc=linuxito,dc=com
dn: cn=config,ou=fusiondirectory,dc=linuxito,dc=com
dn: ou=aclroles,dc=linuxito,dc=com
dn: cn=admin,ou=aclroles,dc=linuxito,dc=com
dn: ou=people,dc=linuxito,dc=com
dn: uid=fd-admin,ou=people,dc=linuxito,dc=com
dn: cn=manager,ou=aclroles,dc=linuxito,dc=com
dn: cn=editowninfos,ou=aclroles,dc=linuxito,dc=com
dn: cn=editownpwd,ou=aclroles,dc=linuxito,dc=com
dn: ou=recovery,ou=fusiondirectory,dc=linuxito,dc=com
dn: ou=reminder,ou=fusiondirectory,dc=linuxito,dc=com
dn: ou=locks,ou=fusiondirectory,dc=linuxito,dc=com
dn: ou=snapshots,dc=linuxito,dc=com
</pre>

Recordar que hay exactamente un [dn](https://www.ldap.com/ldap-dns-and-rdns) (_distinguished name_) por cada entrada en el árbol.

Por supuesto al salida es muy extensa y presenta todos los atributos para cada entrada en el árbol. Se recomienda utilizar `grep` para filtrar y lograr una salida más legible (recuperar sólo aquella información que nos interesa).

#### Obtener todas las unidades organizacionales

Las [ou](https://technet.microsoft.com/en-us/library/cc978003.aspx) (_Organizational Unit_) definen la jerarquía dentro de un dominio. Generalmente se utilizan para definir los departamentos o áreas dentro de una organización (empresa, red, sociedad, etc.).

Para obtener una lista de todas las ou presentes en un directorio, se puede utilizar el filtro `"(ou=*)"`:

<pre>ldapsearch -z 0 -H ldap://localhost:389 -W -D "cn=root,dc=linuxito,dc=com" -b "dc=linuxito,dc=com" "(ou=*)"
</pre>

Ejemplo:

<pre class="konsole">root@debian:~# ldapsearch -z 0 -H ldap://localhost:389 -W -D "cn=root,dc=linuxito,dc=com" -b "dc=linuxito,dc=com" "(ou=*)" | grep "dn:"
Enter LDAP Password: 
dn: dc=linuxito,dc=com
dn: ou=users,dc=linuxito,dc=com
dn: ou=fusiondirectory,dc=linuxito,dc=com
dn: ou=aclroles,dc=linuxito,dc=com
dn: ou=people,dc=linuxito,dc=com
dn: ou=recovery,ou=fusiondirectory,dc=linuxito,dc=com
dn: ou=reminder,ou=fusiondirectory,dc=linuxito,dc=com
dn: ou=locks,ou=fusiondirectory,dc=linuxito,dc=com
dn: ou=snapshots,dc=linuxito,dc=com
</pre>

#### Listar todos los usuarios

Esta consulta depende de la jerarquía y la clase utilizada para almacenar usuarios dentro de un árbol LDAP. Sin embargo, generalmente se utiliza la clase [inetOrgPerson](https://tools.ietf.org/html/rfc2798) para almacenar usuarios dentro de un directorio LDAP, la cual posee el atributo `uid`.

De esta forma, para listar todos los usuarios presentes en un directorio, simplemente recurrir al filtro `"(uid=*)"`:

<pre>ldapsearch -z 0 -H ldap://localhost:389 -W -D "cn=root,dc=linuxito,dc=com" -b "dc=linuxito,dc=com" "(uid=*)"
</pre>

Por ejemplo:

<pre class="konsole">root@debian:~# ldapsearch -z 0 -H ldap://localhost:389 -W -D "cn=root,dc=linuxito,dc=com" -b "dc=linuxito,dc=com" "(uid=*)" | grep -B 1 "dn:"
Enter LDAP Password: 
# emiliano, users, linuxito.com
dn: uid=emiliano,ou=users,dc=linuxito,dc=com
--
# test, users, linuxito.com
dn: uid=test,ou=users,dc=linuxito,dc=com
--
# fd-admin, people, linuxito.com
dn: uid=fd-admin,ou=people,dc=linuxito,dc=com
</pre>

#### Determinar todas las clases en uso

Las clases de un directorio LDAP determinan el formato con el que se representan los datos de los objetos almacenados en el árbol. Cada objeto (entrada en un directorio LDAP) pertenece a al menos una clase. Sin embargo es común que cada objeto pertenezca a varias clases. Básicamente las clases definen qué atributos y de qué formato puede poseer un objeto.

Para listar todas las clases actualmente en uso por todos los objetos, es necesario volcar todo el contenido del árbol y filtrar con `grep`:

<pre>ldapsearch -z 0 -H ldap://localhost:389 -W -D "cn=root,dc=linuxito,dc=com" -b "dc=linuxito,dc=com" "(objectclass=*)" | grep objectClass | sort | uniq
</pre>

Por ejemplo:

<pre class="konsole">root@debian:~# ldapsearch -z 0 -H ldap://localhost:389 -W -D "cn=root,dc=linuxito,dc=com" -b "dc=linuxito,dc=com" "(objectclass=*)" | grep objectClass | sort | uniq
Enter LDAP Password: 
objectClass: account
objectClass: dcObject
objectClass: fdAliasPluginConf
objectClass: fdApplicationsPluginConf
objectClass: fdAuditPluginConf
objectClass: fdAutofsPluginConf
objectClass: fdCommunityPluginConf
objectClass: fdDashboardPluginConf
objectClass: fdDhcpPluginConf
objectClass: fdDnsPluginConf
objectClass: fdDsaPluginConf
objectClass: fdEjbcaPluginConf
objectClass: fdFaiPluginConf
objectClass: fdInventoryPluginConf
objectClass: fdMailPluginConf
objectClass: fdNagiosPluginConf
objectClass: fdNetgroupPluginConf
objectClass: fdNewsletterPluginConf
objectClass: fdOpsiPluginConf
objectClass: fdPasswordRecoveryConf
objectClass: fdPersonalPluginConf
objectClass: fdPpolicyPluginConf
objectClass: fdRepositoryPluginConf
objectClass: fdSambaPluginConf
objectClass: fdSogoPluginConf
objectClass: fdSudoPluginConf
objectClass: fdSupannPluginConf
objectClass: fdSympaPluginConf
objectClass: fdSystemsPluginConf
objectClass: fdUserReminderPluginConf
objectClass: fdWebservicePluginConf
objectClass: fusionDirectoryConf
objectClass: fusionDirectoryPluginsConf
objectClass: gosaAcl
objectClass: gosaDepartment
objectClass: gosaRole
objectClass: inetOrgPerson
objectClass: organization
objectClass: organizationalPerson
objectClass: organizationalRole
objectClass: organizationalUnit
objectClass: person
objectClass: posixAccount
objectClass: shadowAccount
objectClass: top
</pre>

Esta consulta permitirá identificar qué _schemas_ dentro de una servidor LDAP están siendo utilizados y cuáles no.

#### Referencias

*   [Object Naming - Microsoft TechNet](https://technet.microsoft.com/en-us/library/cc977992.aspx)
*   [Organizational Units - Microsoft TechNet](https://technet.microsoft.com/en-us/library/cc978003.aspx)
*   [LDAP DNs and RDNs](https://www.ldap.com/ldap-dns-and-rdns)
*   [LDAP Object Classes](http://www.ldapexplorer.com/en/manual/107060000-ldap-object-classes.htm)
*   [RFC 2798 - Definition of the inetOrgPerson LDAP Object Class](https://tools.ietf.org/html/rfc2798)