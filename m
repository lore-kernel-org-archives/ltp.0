Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ccnandi@yahoo.com>) id 1UNYzt-0001TZ-MK
	for ltp-list@lists.sourceforge.net; Thu, 04 Apr 2013 01:29:49 +0000
Received: from nm33-vm5.bullet.mail.ne1.yahoo.com ([98.138.229.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UNYzr-0007QV-RZ
	for ltp-list@lists.sourceforge.net; Thu, 04 Apr 2013 01:29:49 +0000
Message-ID: <1365038982.96284.YahooMailClassic@web120802.mail.ne1.yahoo.com>
Date: Wed, 3 Apr 2013 18:29:42 -0700 (PDT)
From: C Nandi <ccnandi@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="1499272879-1085041809-1365038982=:96284"
Subject: [LTP] ltp network multicast test cases
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--1499272879-1085041809-1365038982=:96284
Content-Type: multipart/alternative;
	boundary="1499272879-1882003588-1365038982=:96284"

--1499272879-1882003588-1365038982=:96284
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=0A=0ABelow LTP test cases are failing in Debian based systems.=0A=0A1)=C2=
=A0=C2=A0=C2=A0 ltp-full-20130109/testcases/network/multicast/mc_cmds/ mc_c=
mds=0A=0A2)=C2=A0=C2=A0=C2=A0 ltp-full-20130109/testcases/network/multicast=
/mc_commo/mc_commo=0A=0A=C2=A0=0A=0A=C2=A0=0A=0APlease find analysis and co=
de changes as below; I=0Ahave also attached the code chages with this e-mai=
l:=0A=0A1)=C2=A0=C2=A0=C2=A0 =C2=A0ltp-full-20130109/testcases/network/mult=
icast/mc_cmds/=0Amc_cmds=0A=0A=C2=A0=0A=0Anet/ipv4/icmp.c=0A( In upstream k=
ernel)=0A=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Control parameter=
s for ECHO replies. */=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net->ipv4.=
sysctl_icmp_echo_ignore_all =3D 0;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 net->ipv4.sysctl_icmp_echo_ignore_broadcasts =3D 1;=C2=A0In =E2=80=9Cmc=
_cmds=E2=80=9D test case we have code as below:=C2=A0=C2=A0 =C2=A0cat /proc=
/sys/net/ipv4/icmp_echo_ignore_broadcasts | grep 1 > /dev/null=C2=A0=C2=A0 =
if [ $? -eq 0 ]=C2=A0=C2=A0 then=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end_te=
stcase "Multicast ping disabled on this system (this is normal on post year=
:2005 kernels)"=C2=A0=C2=A0 fiHence the test tcase will fail always as icmp=
_echo_ignore_broadcasts is set to 1(which is default).=C2=A0Can we go with =
below patch for this problem?=C2=A0--- mc_cmds.Orig=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 2013-04-03 14:36:14.000000000 -0600+++ mc_cmds=C2=A0=C2=
=A0=C2=A0=C2=A0 2013-04-03 14:39:02.000000000 -0600@@ -128,6 +128,9 @@=C2=
=A0=C2=A0=C2=A0 if [ $? -eq 0 ]=C2=A0=C2=A0=C2=A0 then=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 end_testcase "Multicast ping disabled on this system =
(this is normal on post year:2005 kernels)"+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 echo "Temporarily enable multicast ping for testing
 purposes."+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo 0 > /proc/sys/net/ipv=
4/icmp_echo_ignore_broadcasts+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 icmp_nee=
d_reset=3D1=C2=A0=C2=A0=C2=A0 fi=C2=A0=C2=A0=C2=A0=C2=A0 # Do the ping test=
s: Execute ping 224.0.0.1 - Verify that the proper@@ -166,6 +169,10 @@ {=C2=
=A0=C2=A0=C2=A0 $trace_logic=C2=A0=C2=A0=C2=A0 echo "$this_file: doing $0."=
+=C2=A0=C2=A0 if [ -n "$icmp_need_reset" ]; then+=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts+=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "Restored multicast ping setting."+=C2=
=A0=C2=A0 fi=C2=A0=C2=A0=C2=A0 rm -rf $PING_OUT }=C2=A0=0A=0A2)=C2=A0=C2=A0=
=C2=A0 ltp-full-20130109/testcases/network/multicast/mc_commo/mc_commo=0A=
=0A=C2=A0=0A=0A=C2=A0=0A=0AIn Debian,=0A"/etc/hosts" looks like the followi=
ng.=0A=0A=C2=A0=0A=0A127.0.0.1 localhost=0A=0A127.0.1.1=0A<host_name>.<doma=
in_name> <host_name>=0A=0A=C2=A0=0A=0A# The following lines are desirable f=
or IPv6 capable=0Ahosts=0A=0A::1=C2=A0=C2=A0=C2=A0=C2=A0=0Aip6-localhost ip=
6-loopback=0A=0Afe00::0 ip6-localnet=0A=0Aff00::0 ip6-mcastprefix=0A=0Aff02=
::1 ip6-allnodes=0A=0Aff02::2 ip6-allrouters=0A=0Aff02::3 ip6-allhosts=0A=
=0A=C2=A0=0A=0AThe second line=0Ain this file is as a workaround for some s=
oftwares. (Ref: http://bugs.debian.org/316099 )=0A=0A=C2=A0=0A=0ASince the =
host=0AIP value will be taken as 127.0.1.1 during test case execution test =
fails. =0A=0A=C2=A0=0A=0ACan we go with the=0Abelow code changes?=0A=0A=C2=
=A0=0A=0A--- mc_commo.Orig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2013-04-03 1=
5:28:56.000000000 -0600=0A=0A+++ mc_commo=C2=A0=C2=A0=C2=A0=0A2013-04-03 15=
:35:00.000000000 -0600=0A=0A@@ -50,6 +50,11 @@=0A=0A=C2=A0OUTFILE=3D$TCtmp/=
mc_commo_out=0A=0A=C2=A0NUMLOOPS=3D${NUMLOOPS:-2}=0A=0A=C2=A0INTERFACE=3D${=
INTERFACE:-$("$LTPROOT/bin/gethost"=0A`hostname` | grep addresses: | awk '{=
print $2}')}=0A=0A+IPV4_NETWORK=3D${IPV4_NETWORK:-"192.168.100"}=0A=0A+IPV4=
_LHOST=3D${LHOST_IPV4_HOST:-"1"}=0A=0A+IPV4_RHOST=3D${LHOST_IPV4_HOST:-"2"}=
=0A=0A+LINK_NUM=3D${LINK_NUM-"0"}=0A=0A+declare -A RHOST_LIST=0A=0A=C2=A0=
=0A=0A=C2=A0this_file=3D${0##*/}=0A=0A=C2=A0trap=0A"interrupt_test" 2=0A=0A=
@@ -58,6 +63,25 @@=0A=0A=C2=A0=C2=A0 mkdir -p=0A$TCtmp=0A=0A=C2=A0=C2=A0 OC=
TET=3D`ps=0A-ewf | grep [m]c_commo | wc -l | awk '{print $1}'`=0A=0A=C2=A0=
=C2=A0=0AGROUP_ADDR=3D224.0.0.$OCTET=0A=0A+=0A=0A+=C2=A0 if=C2=A0 [ $RHOST =
!=3D `hostname` ]; then=0A=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=0Ainitia=
lize_if lhost $LINK_NUM=0A=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ $? =3D=
=0A0 ] || end_testcase "Could NOT initialize local host link"=0A=0A+=0A=0A+=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=0Ainitialize_if rhost $LINK_NUM=0A=0A+=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ $? =3D=0A0 ] || end_testcase "Could =
NOT initialize remote host link"=0A=0A+=0A=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=0Aset_ipv4addr lhost $LINK_NUM ${IPV4_NETWORK} ${IPV4_LHOST}=0A=
=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ $? =3D=0A0 ] || end_testcase "Fa=
iled to set ipv4 address to local host"=0A=0A+=0A=0A+=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=0Aset_ipv4addr rhost $LINK_NUM ${IPV4_NETWORK} ${IPV4_RHOST=
}=0A=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ $? =3D=0A0 ] || end_testcase=
 "Failed to set ipv4 address to remote host"=0A=0A+=0A=0A+=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=0AINTERFACE=3D${IPV4_NETWORK}.${IPV4_LHOST}=0A=0A+=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=0ARHOST_LIST[$RHOST]=3D${IPV4_NETWORK}.${=
IPV4_RHOST}=0A=0A+=C2=A0 else=0A=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=0A=
RHOST_LIST[$RHOST]=3D`hostname`=0A=0A+=C2=A0 fi=0A=0A=C2=A0}=0A=0A=C2=A0=0A=
=0A=C2=A0#*****************************************************************=
**************=0A=0A@@ -129,7 +153,7 @@=0A=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 echo=0A"Running on $HOST mc_send $GROUP_ADDR $HOST=
 $PORT $TTL"=0A=0A=C2=A0=0A=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 rsh=0A-n -l root $HOST "$LTPROOT/testcases/bin/$REMOTE_EXEC" $GRO=
UP_ADDR \=0A=0A-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $HOST=0A$PORT $T=
TL >/dev/null &=0A=0A+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=0A${RHOST_=
LIST[$HOST]} $PORT $TTL >/dev/null &=0A=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=0Asleep 10=0A=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 rsh -n=0A-l root $HOST "ps -ewf | grep mc_send | grep -v grep"=0A=0A=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [=0A$? =3D 0 ]=
 || end_testcase "Could NOT start mc_send on $HOST"=0A=0A@@ -143,7 +167,7 @=
@=0A=0A=C2=A0=C2=A0=C2=A0 #test if=0Adatagrams has been sent=0A=0A=C2=A0=C2=
=A0=C2=A0 for HOST=0Ain $RHOST=0A=0A=C2=A0=C2=A0=C2=A0 do=0A=0A-=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 grep -q=0A"$HOST [0-9] [0-9]" $OUTFILE=0A=0A+=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 grep -q=0A"${RHOST_LIST[$HOST]} [0-9] [0-9]" $OUTF=
ILE=0A=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ $? =3D=0A0 ] || end_testcas=
e "NO Datagrams received from $HOST"=0A=0A=C2=A0=C2=A0=C2=A0 done=0A=0A=C2=
=A0}=0A=0A@@ -175,6 +199,9 @@=0A=0A=C2=A0=C2=A0=C2=A0 rm -rf=0A$TCtmp/pingf=
ile=0A=0A=C2=A0=C2=A0=C2=A0 rm -rf=0A$TCtmp/mc_commo_out=0A=0A=C2=A0=C2=A0=
=C2=A0 rm -rf=0A$TCtmp=0A=0A+=0A=0A+=C2=A0=C2=A0=0Ainitialize_if lhost $LIN=
K_NUM=0A=0A+=C2=A0=C2=A0=0Ainitialize_if rhost $LINK_NUM=0A=0A=C2=A0}=0A=0A=
=C2=A0=0A=0A=C2=A0#=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=0A=C2=A0=0A=0AThanks,=0A=0ANandi=0A=0A=C2=A0=
=0A=0A=C2=A0=0A=0A=C2=A0=0A=0A=C2=A0=0A=0A=C2=A0=0A=0A
--1499272879-1882003588-1365038982=:96284
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;"><!--[if gte mso 9]><xml>=0A <w:WordDocument>=
=0A  <w:View>Normal</w:View>=0A  <w:Zoom>0</w:Zoom>=0A  <w:TrackMoves/>=0A =
 <w:TrackFormatting/>=0A  <w:PunctuationKerning/>=0A  <w:ValidateAgainstSch=
emas/>=0A  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>=0A  <w:IgnoreMixe=
dContent>false</w:IgnoreMixedContent>=0A  <w:AlwaysShowPlaceholderText>fals=
e</w:AlwaysShowPlaceholderText>=0A  <w:DoNotPromoteQF/>=0A  <w:LidThemeOthe=
r>EN-US</w:LidThemeOther>=0A  <w:LidThemeAsian>X-NONE</w:LidThemeAsian>=0A =
 <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>=0A  <w:Compatibi=
lity>=0A   <w:BreakWrappedTables/>=0A   <w:SnapToGridInCell/>=0A   <w:WrapT=
extWithPunct/>=0A   <w:UseAsianBreakRules/>=0A   <w:DontGrowAutofit/>=0A   =
<w:SplitPgBreakAndParaMark/>=0A   <w:EnableOpenTypeKerning/>=0A   <w:DontFl=
ipMirrorIndents/>=0A   <w:OverrideTableStyleHps/>=0A  </w:Compatibility>=0A=
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>=0A  <m:mathPr=
>=0A   <m:mathFont m:val=3D"Cambria Math"/>=0A   <m:brkBin m:val=3D"before"=
/>=0A   <m:brkBinSub m:val=3D"&#45;-"/>=0A   <m:smallFrac m:val=3D"off"/>=
=0A   <m:dispDef/>=0A   <m:lMargin m:val=3D"0"/>=0A   <m:rMargin m:val=3D"0=
"/>=0A   <m:defJc m:val=3D"centerGroup"/>=0A   <m:wrapIndent m:val=3D"1440"=
/>=0A   <m:intLim m:val=3D"subSup"/>=0A   <m:naryLim m:val=3D"undOvr"/>=0A =
 </m:mathPr></w:WordDocument>=0A</xml><![endif]-->=0A=0A<p class=3D"MsoNorm=
al"><span style=3D"font-size:9.5pt;font-family:&quot;Verdana&quot;,&quot;sa=
ns-serif&quot;;=0Amso-bidi-font-family:Tahoma">Below LTP test cases are <i =
style=3D"mso-bidi-font-style:=0Anormal">failing</i> in Debian based systems=
.</span></p>=0A=0A<p class=3D"MsoListParagraph" style=3D"text-indent:-.25in=
;mso-list:l1 level1 lfo1"><span style=3D"font-size:9.5pt;font-family:&quot;=
Verdana&quot;,&quot;sans-serif&quot;;mso-fareast-font-family:=0AVerdana;mso=
-bidi-font-family:Verdana"><span style=3D"mso-list:Ignore">1)<span style=3D=
"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp; </span></span><=
/span><span style=3D"font-size:9.5pt;font-family:&quot;Verdana&quot;,&quot;=
sans-serif&quot;;mso-bidi-font-family:=0ATahoma">ltp-full-20130109/testcase=
s/network/multicast/mc_cmds/</span> <span style=3D"font-size:9.5pt;font-fam=
ily:&quot;Verdana&quot;,&quot;sans-serif&quot;;mso-bidi-font-family:=0ATaho=
ma">mc_cmds</span></p>=0A=0A<p class=3D"MsoListParagraph" style=3D"text-ind=
ent:-.25in;mso-list:l1 level1 lfo1"><span style=3D"font-size:9.5pt;font-fam=
ily:&quot;Verdana&quot;,&quot;sans-serif&quot;;mso-fareast-font-family:=0AV=
erdana;mso-bidi-font-family:Verdana"><span style=3D"mso-list:Ignore">2)<spa=
n style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp; </spa=
n></span></span><span style=3D"font-size:9.5pt;font-family:&quot;Verdana&qu=
ot;,&quot;sans-serif&quot;;mso-bidi-font-family:=0ATahoma">ltp-full-2013010=
9/testcases/network/multicast/mc_commo/mc_commo</span></p>=0A=0A<p class=3D=
"MsoListParagraph"><span style=3D"font-size:9.5pt;font-family:&quot;Verdana=
&quot;,&quot;sans-serif&quot;;=0Amso-bidi-font-family:Tahoma">&nbsp;</span>=
</p>=0A=0A<p class=3D"MsoNormal"><span style=3D"font-size:9.5pt;font-family=
:&quot;Verdana&quot;,&quot;sans-serif&quot;;=0Amso-bidi-font-family:Tahoma"=
>&nbsp;</span></p>=0A=0A<p class=3D"MsoNormal"><span style=3D"font-size:9.5=
pt;font-family:&quot;Verdana&quot;,&quot;sans-serif&quot;;=0Amso-bidi-font-=
family:Tahoma">Please find analysis and code changes as below; I=0Ahave als=
o attached the code chages with this e-mail:</span></p>=0A=0A<p class=3D"Ms=
oListParagraph" style=3D"text-indent:-.25in;mso-list:l0 level1 lfo2"><span =
style=3D"font-size:9.5pt;font-family:&quot;Verdana&quot;,&quot;sans-serif&q=
uot;;mso-fareast-font-family:=0AVerdana;mso-bidi-font-family:Verdana"><span=
 style=3D"mso-list:Ignore">1)<span style=3D"font:7.0pt &quot;Times New Roma=
n&quot;">&nbsp;&nbsp;&nbsp; </span></span></span><span style=3D"font-size:9=
.5pt;font-family:&quot;Verdana&quot;,&quot;sans-serif&quot;;mso-bidi-font-f=
amily:=0ATahoma"><span style=3D"mso-spacerun:yes">&nbsp;</span>ltp-full-201=
30109/testcases/network/multicast/mc_cmds/</span>=0A<span style=3D"font-siz=
e:9.5pt;font-family:&quot;Verdana&quot;,&quot;sans-serif&quot;;mso-bidi-fon=
t-family:=0ATahoma">mc_cmds</span></p>=0A=0A<p class=3D"MsoNormal"><span st=
yle=3D"font-size:9.5pt;font-family:&quot;Verdana&quot;,&quot;sans-serif&quo=
t;;=0Amso-bidi-font-family:Tahoma">&nbsp;</span></p>=0A=0A<p class=3D"MsoNo=
rmal" style=3D"margin-left:.5in"><span style=3D"font-size:9.5pt;=0Afont-fam=
ily:&quot;Verdana&quot;,&quot;sans-serif&quot;;mso-bidi-font-family:Tahoma"=
>net/ipv4/icmp.c=0A( In upstream kernel)</span></p>=0A=0A<pre style=3D"marg=
in-left:.5in"><span style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; </span><span class=3D"comment">/* Control parameters for ECH=
O replies. */</span></pre><pre style=3D"margin-left:.5in"><span style=3D"ms=
o-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>net-&gt;i=
pv4.sysctl_icmp_echo_ignore_all =3D 0;</pre><pre style=3D"margin-left:.5in"=
><span style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; </span>net-&gt;ipv4.sysctl_icmp_echo_ignore_broadcasts =3D 1;</pre><pre s=
tyle=3D"margin-left:.5in">&nbsp;</pre><pre style=3D"margin-left:.5in"><span=
 style=3D"font-size:9.5pt;font-family:&quot;Verdana&quot;,&quot;sans-serif&=
quot;;mso-bidi-font-family:=0ATahoma">In =E2=80=9Cmc_cmds=E2=80=9D test cas=
e we have code as below:</span></pre><pre style=3D"margin-left:.5in"><span =
style=3D"font-size:9.5pt;font-family:&quot;Verdana&quot;,&quot;sans-serif&q=
uot;;=0Amso-bidi-font-family:Tahoma">&nbsp;</span></pre><pre style=3D"margi=
n-left:.5in"><span style=3D"mso-spacerun:yes">&nbsp; </span><span style=3D"=
mso-spacerun:yes">&nbsp;</span>cat /proc/sys/net/ipv4/icmp_echo_ignore_broa=
dcasts | grep 1 &gt; /dev/null</pre><pre style=3D"margin-left:.5in"><span s=
tyle=3D"mso-spacerun:yes">&nbsp;&nbsp; </span>if [ $? -eq 0 ]</pre><pre sty=
le=3D"margin-left:.5in"><span style=3D"mso-spacerun:yes">&nbsp;&nbsp; </spa=
n>then</pre><pre style=3D"margin-left:.5in"><span style=3D"mso-spacerun:yes=
">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>end_testcase "Multicast ping =
disabled on this system (this is normal on post year:2005 kernels)"</pre><p=
re style=3D"margin-left:.5in"><span style=3D"mso-spacerun:yes">&nbsp;&nbsp;=
 </span>fi</pre><pre style=3D"margin-left:.5in"><span style=3D"font-size:9.=
5pt;font-family:&quot;Verdana&quot;,&quot;sans-serif&quot;;=0Amso-bidi-font=
-family:Tahoma">Hence the test tcase will fail always as</span> icmp_echo_i=
gnore_broadcasts <span style=3D"font-size:9.5pt;font-family:&quot;Verdana&q=
uot;,&quot;sans-serif&quot;;mso-bidi-font-family:=0ATahoma">is set to </spa=
n>1<span style=3D"font-size:9.5pt;font-family:&quot;Verdana&quot;,&quot;san=
s-serif&quot;;=0Amso-bidi-font-family:Tahoma">(which is default).</span></p=
re><pre style=3D"margin-left:.5in"><span style=3D"font-size:9.5pt;font-fami=
ly:&quot;Verdana&quot;,&quot;sans-serif&quot;;=0Amso-bidi-font-family:Tahom=
a">&nbsp;</span></pre><pre style=3D"margin-left:.5in"><span style=3D"font-s=
ize:9.5pt;font-family:&quot;Verdana&quot;,&quot;sans-serif&quot;;=0Amso-bid=
i-font-family:Tahoma">Can we go with below patch for this problem?</span></=
pre><pre style=3D"margin-left:.5in"><span style=3D"font-size:9.5pt;font-fam=
ily:&quot;Verdana&quot;,&quot;sans-serif&quot;;=0Amso-bidi-font-family:Taho=
ma">&nbsp;</span></pre><pre style=3D"margin-left:.5in">--- mc_cmds.Orig<spa=
n style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </s=
pan>2013-04-03 14:36:14.000000000 -0600</pre><pre style=3D"margin-left:.5in=
">+++ mc_cmds<span style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp; </sp=
an>2013-04-03 14:39:02.000000000 -0600</pre><pre style=3D"margin-left:.5in"=
>@@ -128,6 +128,9 @@</pre><pre style=3D"margin-left:.5in"><span style=3D"ms=
o-spacerun:yes">&nbsp;&nbsp;&nbsp; </span>if [ $? -eq 0 ]</pre><pre style=
=3D"margin-left:.5in"><span style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp; <=
/span>then</pre><pre style=3D"margin-left:.5in"><span style=3D"mso-spacerun=
:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>end_testcase "Multi=
cast ping disabled on this system (this is normal on post year:2005 kernels=
)"</pre><pre style=3D"margin-left:.5in">+<span style=3D"mso-spacerun:yes">&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>echo "Temporarily enable
 multicast ping for testing purposes."</pre><pre style=3D"margin-left:.5in"=
>+<span style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </s=
pan>echo 0 &gt; /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts</pre><pre st=
yle=3D"margin-left:.5in">+<span style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; </span>icmp_need_reset=3D1</pre><pre style=3D"margin-l=
eft:.5in"><span style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp; </span>fi</pr=
e><pre style=3D"margin-left:.5in">&nbsp;</pre><pre style=3D"margin-left:.5i=
n"><span style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp; </span># Do the ping=
 tests: Execute ping 224.0.0.1 - Verify that the proper</pre><pre style=3D"=
margin-left:.5in">@@ -166,6 +169,10 @@</pre><pre style=3D"margin-left:.5in"=
> {</pre><pre style=3D"margin-left:.5in"><span style=3D"mso-spacerun:yes">&=
nbsp;&nbsp;&nbsp; </span>$trace_logic</pre><pre style=3D"margin-left:.5in">=
<span style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp; </span>echo "$this_file=
: doing $0."</pre><pre
 style=3D"margin-left:.5in">+<span style=3D"mso-spacerun:yes">&nbsp;&nbsp; =
</span>if [ -n "$icmp_need_reset" ]; then</pre><pre style=3D"margin-left:.5=
in">+<span style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span>echo 1 &gt; /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts</pre><pre=
 style=3D"margin-left:.5in">+<span style=3D"mso-spacerun:yes">&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; </span>echo "Restored multicast ping setting."</pre=
><pre style=3D"margin-left:.5in">+<span style=3D"mso-spacerun:yes">&nbsp;&n=
bsp; </span>fi</pre><pre style=3D"margin-left:.5in"><span style=3D"mso-spac=
erun:yes">&nbsp;&nbsp;&nbsp; </span>rm -rf $PING_OUT</pre><pre style=3D"mar=
gin-left:.5in"> }</pre><pre style=3D"margin-left:.5in">&nbsp;</pre>=0A=0A<p=
 class=3D"MsoListParagraph" style=3D"text-indent:-.25in;mso-list:l0 level1 =
lfo2"><span style=3D"font-size:9.5pt;font-family:&quot;Verdana&quot;,&quot;=
sans-serif&quot;;mso-fareast-font-family:=0AVerdana;mso-bidi-font-family:Ve=
rdana"><span style=3D"mso-list:Ignore">2)<span style=3D"font:7.0pt &quot;Ti=
mes New Roman&quot;">&nbsp;&nbsp;&nbsp; </span></span></span><span style=3D=
"font-size:9.5pt;font-family:&quot;Verdana&quot;,&quot;sans-serif&quot;;mso=
-bidi-font-family:=0ATahoma">ltp-full-20130109/testcases/network/multicast/=
mc_commo/mc_commo</span></p>=0A=0A<pre style=3D"margin-left:.5in">&nbsp;</p=
re>=0A=0A<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"f=
ont-size:9.5pt;=0Afont-family:&quot;Verdana&quot;,&quot;sans-serif&quot;;ms=
o-bidi-font-family:Tahoma">&nbsp;</span></p>=0A=0A<p class=3D"MsoNormal" st=
yle=3D"margin-left:.5in"><span style=3D"font-size:9.5pt;=0Afont-family:&quo=
t;Verdana&quot;,&quot;sans-serif&quot;;mso-bidi-font-family:Tahoma">In Debi=
an,=0A"/etc/hosts" looks like the following.</span></p>=0A=0A<p class=3D"Ms=
oNormal" style=3D"margin-left:.5in"><span style=3D"font-size:9.5pt;=0Afont-=
family:&quot;Verdana&quot;,&quot;sans-serif&quot;;mso-bidi-font-family:Taho=
ma">&nbsp;</span></p>=0A=0A<p class=3D"MsoNormal" style=3D"margin-left:.5in=
"><span style=3D"font-size:10.0pt;=0Afont-family:&quot;Courier New&quot;">1=
27.0.0.1 localhost</span></p>=0A=0A<p class=3D"MsoNormal" style=3D"margin-l=
eft:.5in"><b style=3D"mso-bidi-font-weight:=0Anormal"><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Courier New&quot;">127.0.1.1=0A&lt;host_name&g=
t;.&lt;domain_name&gt; &lt;host_name&gt;</span></b></p>=0A=0A<p class=3D"Ms=
oNormal" style=3D"margin-left:.5in"><span style=3D"font-size:10.0pt;=0Afont=
-family:&quot;Courier New&quot;">&nbsp;</span></p>=0A=0A<p class=3D"MsoNorm=
al" style=3D"margin-left:.5in"><span style=3D"font-size:10.0pt;=0Afont-fami=
ly:&quot;Courier New&quot;"># The following lines are desirable for IPv6 ca=
pable=0Ahosts</span></p>=0A=0A<p class=3D"MsoNormal" style=3D"margin-left:.=
5in"><span style=3D"font-size:10.0pt;=0Afont-family:&quot;Courier New&quot;=
">::1<span style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;=0A</span>ip6=
-localhost ip6-loopback</span></p>=0A=0A<p class=3D"MsoNormal" style=3D"mar=
gin-left:.5in"><span style=3D"font-size:10.0pt;=0Afont-family:&quot;Courier=
 New&quot;">fe00::0 ip6-localnet</span></p>=0A=0A<p class=3D"MsoNormal" sty=
le=3D"margin-left:.5in"><span style=3D"font-size:10.0pt;=0Afont-family:&quo=
t;Courier New&quot;">ff00::0 ip6-mcastprefix</span></p>=0A=0A<p class=3D"Ms=
oNormal" style=3D"margin-left:.5in"><span style=3D"font-size:10.0pt;=0Afont=
-family:&quot;Courier New&quot;">ff02::1 ip6-allnodes</span></p>=0A=0A<p cl=
ass=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:10.0p=
t;=0Afont-family:&quot;Courier New&quot;">ff02::2 ip6-allrouters</span></p>=
=0A=0A<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font=
-size:10.0pt;=0Afont-family:&quot;Courier New&quot;">ff02::3 ip6-allhosts</=
span></p>=0A=0A<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span styl=
e=3D"font-size:9.5pt;=0Afont-family:&quot;Verdana&quot;,&quot;sans-serif&qu=
ot;;mso-bidi-font-family:Tahoma">&nbsp;</span></p>=0A=0A<p class=3D"MsoNorm=
al" style=3D"margin-left:.5in"><span style=3D"font-size:9.5pt;=0Afont-famil=
y:&quot;Verdana&quot;,&quot;sans-serif&quot;;mso-bidi-font-family:Tahoma">T=
he second line=0Ain this file is as a workaround for some softwares. (Ref: =
</span><span style=3D"font-size:10.0pt;font-family:Consolas"><a href=3D"htt=
p://bugs.debian.org/316099">http://bugs.debian.org/316099</a> </span><span =
style=3D"font-size:9.5pt;font-family:&quot;Verdana&quot;,&quot;sans-serif&q=
uot;;mso-bidi-font-family:=0ATahoma">)</span></p>=0A=0A<p class=3D"MsoNorma=
l" style=3D"margin-left:.5in"><span style=3D"font-size:9.5pt;=0Afont-family=
:&quot;Verdana&quot;,&quot;sans-serif&quot;;mso-bidi-font-family:Tahoma">&n=
bsp;</span></p>=0A=0A<p class=3D"MsoNormal" style=3D"margin-left:.5in"><spa=
n style=3D"font-size:9.5pt;=0Afont-family:&quot;Verdana&quot;,&quot;sans-se=
rif&quot;;mso-bidi-font-family:Tahoma">Since the host=0AIP value will be ta=
ken as </span><b style=3D"mso-bidi-font-weight:normal"><span style=3D"font-=
size:10.0pt;font-family:&quot;Courier New&quot;">127.0.1.1 </span></b><span=
 style=3D"font-size:9.5pt;font-family:&quot;Verdana&quot;,&quot;sans-serif&=
quot;;mso-bidi-font-family:=0ATahoma">during test case execution test fails=
. </span></p>=0A=0A<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span =
style=3D"font-size:9.5pt;=0Afont-family:&quot;Verdana&quot;,&quot;sans-seri=
f&quot;;mso-bidi-font-family:Tahoma">&nbsp;</span></p>=0A=0A<p class=3D"Mso=
Normal" style=3D"margin-left:.5in"><span style=3D"font-size:9.5pt;=0Afont-f=
amily:&quot;Verdana&quot;,&quot;sans-serif&quot;;mso-bidi-font-family:Tahom=
a">Can we go with the=0Abelow code changes?</span></p>=0A=0A<p class=3D"Mso=
Normal" style=3D"margin-left:.5in"><span style=3D"font-size:9.5pt;=0Afont-f=
amily:&quot;Verdana&quot;,&quot;sans-serif&quot;;mso-bidi-font-family:Tahom=
a">&nbsp;</span></p>=0A=0A<p class=3D"MsoNormal" style=3D"margin-left:.5in"=
><span style=3D"font-size:10.0pt;=0Afont-family:&quot;Courier New&quot;">--=
- mc_commo.Orig<span style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; </span>2013-04-03 15:28:56.000000000 -0600</span></p>=0A=0A<p cla=
ss=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:10.0pt=
;=0Afont-family:&quot;Courier New&quot;">+++ mc_commo<span style=3D"mso-spa=
cerun:yes">&nbsp;&nbsp;&nbsp;=0A</span>2013-04-03 15:35:00.000000000 -0600<=
/span></p>=0A=0A<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span sty=
le=3D"font-size:10.0pt;=0Afont-family:&quot;Courier New&quot;">@@ -50,6 +50=
,11 @@</span></p>=0A=0A<p class=3D"MsoNormal" style=3D"margin-left:.5in"><s=
pan style=3D"font-size:10.0pt;=0Afont-family:&quot;Courier New&quot;"><span=
 style=3D"mso-spacerun:yes">&nbsp;</span>OUTFILE=3D$TCtmp/mc_commo_out</spa=
n></p>=0A=0A<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=
=3D"font-size:10.0pt;=0Afont-family:&quot;Courier New&quot;"><span style=3D=
"mso-spacerun:yes">&nbsp;</span>NUMLOOPS=3D${NUMLOOPS:-2}</span></p>=0A=0A<=
p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:1=
0.0pt;=0Afont-family:&quot;Courier New&quot;"><span style=3D"mso-spacerun:y=
es">&nbsp;</span>INTERFACE=3D${INTERFACE:-$("$LTPROOT/bin/gethost"=0A`hostn=
ame` | grep addresses: | awk '{print $2}')}</span></p>=0A=0A<p class=3D"Mso=
Normal" style=3D"margin-left:.5in"><span style=3D"font-size:10.0pt;=0Afont-=
family:&quot;Courier New&quot;">+IPV4_NETWORK=3D${IPV4_NETWORK:-"192.168.10=
0"}</span></p>=0A=0A<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span=
 style=3D"font-size:10.0pt;=0Afont-family:&quot;Courier New&quot;">+IPV4_LH=
OST=3D${LHOST_IPV4_HOST:-"1"}</span></p>=0A=0A<p class=3D"MsoNormal" style=
=3D"margin-left:.5in"><span style=3D"font-size:10.0pt;=0Afont-family:&quot;=
Courier New&quot;">+IPV4_RHOST=3D${LHOST_IPV4_HOST:-"2"}</span></p>=0A=0A<p=
 class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:10=
.0pt;=0Afont-family:&quot;Courier New&quot;">+LINK_NUM=3D${LINK_NUM-"0"}</s=
pan></p>=0A=0A<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=
=3D"font-size:10.0pt;=0Afont-family:&quot;Courier New&quot;">+declare -A RH=
OST_LIST</span></p>=0A=0A<p class=3D"MsoNormal" style=3D"margin-left:.5in">=
<span style=3D"font-size:10.0pt;=0Afont-family:&quot;Courier New&quot;">&nb=
sp;</span></p>=0A=0A<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span=
 style=3D"font-size:10.0pt;=0Afont-family:&quot;Courier New&quot;"><span st=
yle=3D"mso-spacerun:yes">&nbsp;</span>this_file=3D${0##*/}</span></p>=0A=0A=
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
10.0pt;=0Afont-family:&quot;Courier New&quot;"><span style=3D"mso-spacerun:=
yes">&nbsp;</span>trap=0A"interrupt_test" 2</span></p>=0A=0A<p class=3D"Mso=
Normal" style=3D"margin-left:.5in"><span style=3D"font-size:10.0pt;=0Afont-=
family:&quot;Courier New&quot;">@@ -58,6 +63,25 @@</span></p>=0A=0A<p class=
=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:10.0pt;=
=0Afont-family:&quot;Courier New&quot;"><span style=3D"mso-spacerun:yes">&n=
bsp;&nbsp; </span>mkdir -p=0A$TCtmp</span></p>=0A=0A<p class=3D"MsoNormal" =
style=3D"margin-left:.5in"><span style=3D"font-size:10.0pt;=0Afont-family:&=
quot;Courier New&quot;"><span style=3D"mso-spacerun:yes">&nbsp;&nbsp; </spa=
n>OCTET=3D`ps=0A-ewf | grep [m]c_commo | wc -l | awk '{print $1}'`</span></=
p>=0A=0A<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"fo=
nt-size:10.0pt;=0Afont-family:&quot;Courier New&quot;"><span style=3D"mso-s=
pacerun:yes">&nbsp;&nbsp;=0A</span>GROUP_ADDR=3D224.0.0.$OCTET</span></p>=
=0A=0A<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font=
-size:10.0pt;=0Afont-family:&quot;Courier New&quot;">+</span></p>=0A=0A<p c=
lass=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:10.0=
pt;=0Afont-family:&quot;Courier New&quot;">+<span style=3D"mso-spacerun:yes=
">&nbsp; </span>if<span style=3D"mso-spacerun:yes">&nbsp; </span>[ $RHOST !=
=3D `hostname` ]; then</span></p>=0A=0A<p class=3D"MsoNormal" style=3D"marg=
in-left:.5in"><span style=3D"font-size:10.0pt;=0Afont-family:&quot;Courier =
New&quot;">+<span style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;=0A</span>initialize_if lhost $LINK_NUM</span></p>=0A=0A<p class=3D"M=
soNormal" style=3D"margin-left:.5in"><span style=3D"font-size:10.0pt;=0Afon=
t-family:&quot;Courier New&quot;">+<span style=3D"mso-spacerun:yes">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>[ $? =3D=0A0 ] || end_testcase "Could =
NOT initialize local host link"</span></p>=0A=0A<p class=3D"MsoNormal" styl=
e=3D"margin-left:.5in"><span style=3D"font-size:10.0pt;=0Afont-family:&quot=
;Courier New&quot;">+</span></p>=0A=0A<p class=3D"MsoNormal" style=3D"margi=
n-left:.5in"><span style=3D"font-size:10.0pt;=0Afont-family:&quot;Courier N=
ew&quot;">+<span style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;=0A</span>initialize_if rhost $LINK_NUM</span></p>=0A=0A<p class=3D"Ms=
oNormal" style=3D"margin-left:.5in"><span style=3D"font-size:10.0pt;=0Afont=
-family:&quot;Courier New&quot;">+<span style=3D"mso-spacerun:yes">&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>[ $? =3D=0A0 ] || end_testcase "Could N=
OT initialize remote host link"</span></p>=0A=0A<p class=3D"MsoNormal" styl=
e=3D"margin-left:.5in"><span style=3D"font-size:10.0pt;=0Afont-family:&quot=
;Courier New&quot;">+</span></p>=0A=0A<p class=3D"MsoNormal" style=3D"margi=
n-left:.5in"><span style=3D"font-size:10.0pt;=0Afont-family:&quot;Courier N=
ew&quot;">+<span style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;=0A</span>set_ipv4addr lhost $LINK_NUM ${IPV4_NETWORK} ${IPV4_LHOST}</=
span></p>=0A=0A<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span styl=
e=3D"font-size:10.0pt;=0Afont-family:&quot;Courier New&quot;">+<span style=
=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>[ $? =3D=
=0A0 ] || end_testcase "Failed to set ipv4 address to local host"</span></p=
>=0A=0A<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"fon=
t-size:10.0pt;=0Afont-family:&quot;Courier New&quot;">+</span></p>=0A=0A<p =
class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:10.=
0pt;=0Afont-family:&quot;Courier New&quot;">+<span style=3D"mso-spacerun:ye=
s">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=0A</span>set_ipv4addr rhost $LINK_N=
UM ${IPV4_NETWORK} ${IPV4_RHOST}</span></p>=0A=0A<p class=3D"MsoNormal" sty=
le=3D"margin-left:.5in"><span style=3D"font-size:10.0pt;=0Afont-family:&quo=
t;Courier New&quot;">+<span style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; </span>[ $? =3D=0A0 ] || end_testcase "Failed to set ipv4 =
address to remote host"</span></p>=0A=0A<p class=3D"MsoNormal" style=3D"mar=
gin-left:.5in"><span style=3D"font-size:10.0pt;=0Afont-family:&quot;Courier=
 New&quot;">+</span></p>=0A=0A<p class=3D"MsoNormal" style=3D"margin-left:.=
5in"><span style=3D"font-size:10.0pt;=0Afont-family:&quot;Courier New&quot;=
">+<span style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=0A=
</span>INTERFACE=3D${IPV4_NETWORK}.${IPV4_LHOST}</span></p>=0A=0A<p class=
=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:10.0pt;=
=0Afont-family:&quot;Courier New&quot;">+<span style=3D"mso-spacerun:yes">&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=0A</span>RHOST_LIST[$RHOST]=3D${IPV4_NE=
TWORK}.${IPV4_RHOST}</span></p>=0A=0A<p class=3D"MsoNormal" style=3D"margin=
-left:.5in"><span style=3D"font-size:10.0pt;=0Afont-family:&quot;Courier Ne=
w&quot;">+<span style=3D"mso-spacerun:yes">&nbsp; </span>else</span></p>=0A=
=0A<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-si=
ze:10.0pt;=0Afont-family:&quot;Courier New&quot;">+<span style=3D"mso-space=
run:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=0A</span>RHOST_LIST[$RHOST]=
=3D`hostname`</span></p>=0A=0A<p class=3D"MsoNormal" style=3D"margin-left:.=
5in"><span style=3D"font-size:10.0pt;=0Afont-family:&quot;Courier New&quot;=
">+<span style=3D"mso-spacerun:yes">&nbsp; </span>fi</span></p>=0A=0A<p cla=
ss=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:10.0pt=
;=0Afont-family:&quot;Courier New&quot;"><span style=3D"mso-spacerun:yes">&=
nbsp;</span>}</span></p>=0A=0A<p class=3D"MsoNormal" style=3D"margin-left:.=
5in"><span style=3D"font-size:10.0pt;=0Afont-family:&quot;Courier New&quot;=
">&nbsp;</span></p>=0A=0A<p class=3D"MsoNormal" style=3D"margin-left:.5in">=
<span style=3D"font-size:10.0pt;=0Afont-family:&quot;Courier New&quot;"><sp=
an style=3D"mso-spacerun:yes">&nbsp;</span>#*******************************=
************************************************</span></p>=0A=0A<p class=
=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:10.0pt;=
=0Afont-family:&quot;Courier New&quot;">@@ -129,7 +153,7 @@</span></p>=0A=
=0A<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-si=
ze:10.0pt;=0Afont-family:&quot;Courier New&quot;"><span style=3D"mso-spacer=
un:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>echo=
=0A"Running on $HOST mc_send $GROUP_ADDR $HOST $PORT $TTL"</span></p>=0A=0A=
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
10.0pt;=0Afont-family:&quot;Courier New&quot;">&nbsp;</span></p>=0A=0A<p cl=
ass=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:10.0p=
t;=0Afont-family:&quot;Courier New&quot;"><span style=3D"mso-spacerun:yes">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>rsh=0A-n -l r=
oot $HOST "$LTPROOT/testcases/bin/$REMOTE_EXEC" $GROUP_ADDR \</span></p>=0A=
=0A<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-si=
ze:10.0pt;=0Afont-family:&quot;Courier New&quot;">-<span style=3D"mso-space=
run:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>$HOST=0A$PORT $T=
TL &gt;/dev/null &amp;</span></p>=0A=0A<p class=3D"MsoNormal" style=3D"marg=
in-left:.5in"><span style=3D"font-size:10.0pt;=0Afont-family:&quot;Courier =
New&quot;">+<span style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;=0A</span>${RHOST_LIST[$HOST]} $PORT $TTL &gt;/dev/null &amp;</=
span></p>=0A=0A<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span styl=
e=3D"font-size:10.0pt;=0Afont-family:&quot;Courier New&quot;"><span style=
=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;=0A</span>sleep 10</span></p>=0A=0A<p class=3D"MsoNormal" style=3D"margin-=
left:.5in"><span style=3D"font-size:10.0pt;=0Afont-family:&quot;Courier New=
&quot;"><span style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; </span>rsh -n=0A-l root $HOST "ps -ewf | grep mc_send | grep -v gr=
ep"</span></p>=0A=0A<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span=
 style=3D"font-size:10.0pt;=0Afont-family:&quot;Courier New&quot;"><span st=
yle=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; </span>[=0A$? =3D 0 ] || end_testcase "Could NOT start mc_send o=
n $HOST"</span></p>=0A=0A<p class=3D"MsoNormal" style=3D"margin-left:.5in">=
<span style=3D"font-size:10.0pt;=0Afont-family:&quot;Courier New&quot;">@@ =
-143,7 +167,7 @@</span></p>=0A=0A<p class=3D"MsoNormal" style=3D"margin-lef=
t:.5in"><span style=3D"font-size:10.0pt;=0Afont-family:&quot;Courier New&qu=
ot;"><span style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp; </span>#test if=0A=
datagrams has been sent</span></p>=0A=0A<p class=3D"MsoNormal" style=3D"mar=
gin-left:.5in"><span style=3D"font-size:10.0pt;=0Afont-family:&quot;Courier=
 New&quot;"><span style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp; </span>for =
HOST=0Ain $RHOST</span></p>=0A=0A<p class=3D"MsoNormal" style=3D"margin-lef=
t:.5in"><span style=3D"font-size:10.0pt;=0Afont-family:&quot;Courier New&qu=
ot;"><span style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp; </span>do</span></=
p>=0A=0A<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"fo=
nt-size:10.0pt;=0Afont-family:&quot;Courier New&quot;">-<span style=3D"mso-=
spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>grep -q=0A"$HOST [0-9] =
[0-9]" $OUTFILE</span></p>=0A=0A<p class=3D"MsoNormal" style=3D"margin-left=
:.5in"><span style=3D"font-size:10.0pt;=0Afont-family:&quot;Courier New&quo=
t;">+<span style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span=
>grep -q=0A"${RHOST_LIST[$HOST]} [0-9] [0-9]" $OUTFILE</span></p>=0A=0A<p c=
lass=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:10.0=
pt;=0Afont-family:&quot;Courier New&quot;"><span style=3D"mso-spacerun:yes"=
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>[ $? =3D=0A0 ] || end_testcase=
 "NO Datagrams received from $HOST"</span></p>=0A=0A<p class=3D"MsoNormal" =
style=3D"margin-left:.5in"><span style=3D"font-size:10.0pt;=0Afont-family:&=
quot;Courier New&quot;"><span style=3D"mso-spacerun:yes">&nbsp;&nbsp;&nbsp;=
 </span>done</span></p>=0A=0A<p class=3D"MsoNormal" style=3D"margin-left:.5=
in"><span style=3D"font-size:10.0pt;=0Afont-family:&quot;Courier New&quot;"=
><span style=3D"mso-spacerun:yes">&nbsp;</span>}</span></p>=0A=0A<p class=
=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:10.0pt;=
=0Afont-family:&quot;Courier New&quot;">@@ -175,6 +199,9 @@</span></p>=0A=
=0A<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-si=
ze:10.0pt;=0Afont-family:&quot;Courier New&quot;"><span style=3D"mso-spacer=
un:yes">&nbsp;&nbsp;&nbsp; </span>rm -rf=0A$TCtmp/pingfile</span></p>=0A=0A=
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
10.0pt;=0Afont-family:&quot;Courier New&quot;"><span style=3D"mso-spacerun:=
yes">&nbsp;&nbsp;&nbsp; </span>rm -rf=0A$TCtmp/mc_commo_out</span></p>=0A=
=0A<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-si=
ze:10.0pt;=0Afont-family:&quot;Courier New&quot;"><span style=3D"mso-spacer=
un:yes">&nbsp;&nbsp;&nbsp; </span>rm -rf=0A$TCtmp</span></p>=0A=0A<p class=
=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:10.0pt;=
=0Afont-family:&quot;Courier New&quot;">+</span></p>=0A=0A<p class=3D"MsoNo=
rmal" style=3D"margin-left:.5in"><span style=3D"font-size:10.0pt;=0Afont-fa=
mily:&quot;Courier New&quot;">+<span style=3D"mso-spacerun:yes">&nbsp;&nbsp=
;=0A</span>initialize_if lhost $LINK_NUM</span></p>=0A=0A<p class=3D"MsoNor=
mal" style=3D"margin-left:.5in"><span style=3D"font-size:10.0pt;=0Afont-fam=
ily:&quot;Courier New&quot;">+<span style=3D"mso-spacerun:yes">&nbsp;&nbsp;=
=0A</span>initialize_if rhost $LINK_NUM</span></p>=0A=0A<p class=3D"MsoNorm=
al" style=3D"margin-left:.5in"><span style=3D"font-size:10.0pt;=0Afont-fami=
ly:&quot;Courier New&quot;"><span style=3D"mso-spacerun:yes">&nbsp;</span>}=
</span></p>=0A=0A<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span st=
yle=3D"font-size:10.0pt;=0Afont-family:&quot;Courier New&quot;">&nbsp;</spa=
n></p>=0A=0A<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=
=3D"font-size:10.0pt;=0Afont-family:&quot;Courier New&quot;"><span style=3D=
"mso-spacerun:yes">&nbsp;</span>#=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span></p>=0A=0A<p class=3D"MsoNorm=
al" style=3D"margin-left:.5in"><span style=3D"font-size:9.5pt;=0Afont-famil=
y:&quot;Verdana&quot;,&quot;sans-serif&quot;;mso-bidi-font-family:Tahoma">&=
nbsp;</span></p>=0A=0A<p class=3D"MsoNormal"><span style=3D"font-size:9.5pt=
;font-family:&quot;Verdana&quot;,&quot;sans-serif&quot;;=0Amso-bidi-font-fa=
mily:Tahoma">Thanks,</span></p>=0A=0A<p class=3D"MsoNormal"><span style=3D"=
font-size:9.5pt;font-family:&quot;Verdana&quot;,&quot;sans-serif&quot;;=0Am=
so-bidi-font-family:Tahoma">Nandi</span></p>=0A=0A<p class=3D"MsoNormal"><s=
pan style=3D"font-size:9.5pt;font-family:&quot;Verdana&quot;,&quot;sans-ser=
if&quot;;=0Amso-bidi-font-family:Tahoma">&nbsp;</span></p>=0A=0A<p class=3D=
"MsoNormal"><span style=3D"font-size:9.5pt;font-family:&quot;Verdana&quot;,=
&quot;sans-serif&quot;;=0Amso-bidi-font-family:Tahoma">&nbsp;</span></p>=0A=
=0A<p class=3D"MsoNormal"><span style=3D"font-size:9.5pt;font-family:&quot;=
Verdana&quot;,&quot;sans-serif&quot;;=0Amso-bidi-font-family:Tahoma">&nbsp;=
</span></p>=0A=0A<p class=3D"MsoNormal"><span style=3D"font-size:9.5pt;font=
-family:&quot;Verdana&quot;,&quot;sans-serif&quot;;=0Amso-bidi-font-family:=
Tahoma">&nbsp;</span></p>=0A=0A<p class=3D"MsoNormal"><span style=3D"font-s=
ize:9.5pt;font-family:&quot;Verdana&quot;,&quot;sans-serif&quot;;=0Amso-bid=
i-font-family:Tahoma">&nbsp;</span></p>=0A=0A<!--[if gte mso 9]><xml>=0A <w=
:LatentStyles DefLockedState=3D"false" DefUnhideWhenUsed=3D"true"=0A  DefSe=
miHidden=3D"true" DefQFormat=3D"false" DefPriority=3D"99"=0A  LatentStyleCo=
unt=3D"267">=0A  <w:LsdException Locked=3D"false" Priority=3D"0" SemiHidden=
=3D"false"=0A   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Normal"/>=
=0A  <w:LsdException Locked=3D"false" Priority=3D"9" SemiHidden=3D"false"=
=0A   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"heading 1"/>=0A  <w=
:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" Name=3D"head=
ing 2"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"tru=
e" Name=3D"heading 3"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"9"=
 QFormat=3D"true" Name=3D"heading 4"/>=0A  <w:LsdException Locked=3D"false"=
 Priority=3D"9" QFormat=3D"true" Name=3D"heading 5"/>=0A  <w:LsdException L=
ocked=3D"false" Priority=3D"9" QFormat=3D"true" Name=3D"heading 6"/>=0A  <w=
:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" Name=3D"head=
ing 7"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"tru=
e" Name=3D"heading 8"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"9"=
 QFormat=3D"true" Name=3D"heading 9"/>=0A  <w:LsdException Locked=3D"false"=
 Priority=3D"39" Name=3D"toc 1"/>=0A  <w:LsdException Locked=3D"false" Prio=
rity=3D"39" Name=3D"toc 2"/>=0A  <w:LsdException Locked=3D"false" Priority=
=3D"39" Name=3D"toc 3"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"3=
9" Name=3D"toc 4"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"39" Na=
me=3D"toc 5"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"39" Name=3D=
"toc 6"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc =
7"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 8"/>=
=0A  <w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 9"/>=0A  =
<w:LsdException Locked=3D"false" Priority=3D"35" QFormat=3D"true" Name=3D"c=
aption"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"10" SemiHidden=
=3D"false"=0A   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Title"/>=
=0A  <w:LsdException Locked=3D"false" Priority=3D"1" Name=3D"Default Paragr=
aph Font"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"11" SemiHidden=
=3D"false"=0A   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Subtitle"=
/>=0A  <w:LsdException Locked=3D"false" Priority=3D"22" SemiHidden=3D"false=
"=0A   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Strong"/>=0A  <w:L=
sdException Locked=3D"false" Priority=3D"20" SemiHidden=3D"false"=0A   Unhi=
deWhenUsed=3D"false" QFormat=3D"true" Name=3D"Emphasis"/>=0A  <w:LsdExcepti=
on Locked=3D"false" Priority=3D"59" SemiHidden=3D"false"=0A   UnhideWhenUse=
d=3D"false" Name=3D"Table Grid"/>=0A  <w:LsdException Locked=3D"false" Unhi=
deWhenUsed=3D"false" Name=3D"Placeholder Text"/>=0A  <w:LsdException Locked=
=3D"false" Priority=3D"1" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"false=
" QFormat=3D"true" Name=3D"No Spacing"/>=0A  <w:LsdException Locked=3D"fals=
e" Priority=3D"60" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"false" Name=
=3D"Light Shading"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"61" S=
emiHidden=3D"false"=0A   UnhideWhenUsed=3D"false" Name=3D"Light List"/>=0A =
 <w:LsdException Locked=3D"false" Priority=3D"62" SemiHidden=3D"false"=0A  =
 UnhideWhenUsed=3D"false" Name=3D"Light Grid"/>=0A  <w:LsdException Locked=
=3D"false" Priority=3D"63" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"fals=
e" Name=3D"Medium Shading 1"/>=0A  <w:LsdException Locked=3D"false" Priorit=
y=3D"64" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"false" Name=3D"Medium =
Shading 2"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"65" SemiHidde=
n=3D"false"=0A   UnhideWhenUsed=3D"false" Name=3D"Medium List 1"/>=0A  <w:L=
sdException Locked=3D"false" Priority=3D"66" SemiHidden=3D"false"=0A   Unhi=
deWhenUsed=3D"false" Name=3D"Medium List 2"/>=0A  <w:LsdException Locked=3D=
"false" Priority=3D"67" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"false" =
Name=3D"Medium Grid 1"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"6=
8" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 2=
"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"69" SemiHidden=3D"fals=
e"=0A   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 3"/>=0A  <w:LsdExcepti=
on Locked=3D"false" Priority=3D"70" SemiHidden=3D"false"=0A   UnhideWhenUse=
d=3D"false" Name=3D"Dark List"/>=0A  <w:LsdException Locked=3D"false" Prior=
ity=3D"71" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"false" Name=3D"Color=
ful Shading"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"72" SemiHid=
den=3D"false"=0A   UnhideWhenUsed=3D"false" Name=3D"Colorful List"/>=0A  <w=
:LsdException Locked=3D"false" Priority=3D"73" SemiHidden=3D"false"=0A   Un=
hideWhenUsed=3D"false" Name=3D"Colorful Grid"/>=0A  <w:LsdException Locked=
=3D"false" Priority=3D"60" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"fals=
e" Name=3D"Light Shading Accent 1"/>=0A  <w:LsdException Locked=3D"false" P=
riority=3D"61" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"false" Name=3D"L=
ight List Accent 1"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"62" =
SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"false" Name=3D"Light Grid Accen=
t 1"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"63" SemiHidden=3D"f=
alse"=0A   UnhideWhenUsed=3D"false" Name=3D"Medium Shading 1 Accent 1"/>=0A=
  <w:LsdException Locked=3D"false" Priority=3D"64" SemiHidden=3D"false"=0A =
  UnhideWhenUsed=3D"false" Name=3D"Medium Shading 2 Accent 1"/>=0A  <w:LsdE=
xception Locked=3D"false" Priority=3D"65" SemiHidden=3D"false"=0A   UnhideW=
henUsed=3D"false" Name=3D"Medium List 1 Accent 1"/>=0A  <w:LsdException Loc=
ked=3D"false" UnhideWhenUsed=3D"false" Name=3D"Revision"/>=0A  <w:LsdExcept=
ion Locked=3D"false" Priority=3D"34" SemiHidden=3D"false"=0A   UnhideWhenUs=
ed=3D"false" QFormat=3D"true" Name=3D"List Paragraph"/>=0A  <w:LsdException=
 Locked=3D"false" Priority=3D"29" SemiHidden=3D"false"=0A   UnhideWhenUsed=
=3D"false" QFormat=3D"true" Name=3D"Quote"/>=0A  <w:LsdException Locked=3D"=
false" Priority=3D"30" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"false" Q=
Format=3D"true" Name=3D"Intense Quote"/>=0A  <w:LsdException Locked=3D"fals=
e" Priority=3D"66" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"false" Name=
=3D"Medium List 2 Accent 1"/>=0A  <w:LsdException Locked=3D"false" Priority=
=3D"67" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"false" Name=3D"Medium G=
rid 1 Accent 1"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"68" Semi=
Hidden=3D"false"=0A   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 2 Accent=
 1"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"69" SemiHidden=3D"fa=
lse"=0A   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 3 Accent 1"/>=0A  <w=
:LsdException Locked=3D"false" Priority=3D"70" SemiHidden=3D"false"=0A   Un=
hideWhenUsed=3D"false" Name=3D"Dark List Accent 1"/>=0A  <w:LsdException Lo=
cked=3D"false" Priority=3D"71" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"=
false" Name=3D"Colorful Shading Accent 1"/>=0A  <w:LsdException Locked=3D"f=
alse" Priority=3D"72" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"false" Na=
me=3D"Colorful List Accent 1"/>=0A  <w:LsdException Locked=3D"false" Priori=
ty=3D"73" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"false" Name=3D"Colorf=
ul Grid Accent 1"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"60" Se=
miHidden=3D"false"=0A   UnhideWhenUsed=3D"false" Name=3D"Light Shading Acce=
nt 2"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"61" SemiHidden=3D"=
false"=0A   UnhideWhenUsed=3D"false" Name=3D"Light List Accent 2"/>=0A  <w:=
LsdException Locked=3D"false" Priority=3D"62" SemiHidden=3D"false"=0A   Unh=
ideWhenUsed=3D"false" Name=3D"Light Grid Accent 2"/>=0A  <w:LsdException Lo=
cked=3D"false" Priority=3D"63" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"=
false" Name=3D"Medium Shading 1 Accent 2"/>=0A  <w:LsdException Locked=3D"f=
alse" Priority=3D"64" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"false" Na=
me=3D"Medium Shading 2 Accent 2"/>=0A  <w:LsdException Locked=3D"false" Pri=
ority=3D"65" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"false" Name=3D"Med=
ium List 1 Accent 2"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"66"=
 SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"false" Name=3D"Medium List 2 A=
ccent 2"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"67" SemiHidden=
=3D"false"=0A   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 1 Accent 2"/>=
=0A  <w:LsdException Locked=3D"false" Priority=3D"68" SemiHidden=3D"false"=
=0A   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 2 Accent 2"/>=0A  <w:Lsd=
Exception Locked=3D"false" Priority=3D"69" SemiHidden=3D"false"=0A   Unhide=
WhenUsed=3D"false" Name=3D"Medium Grid 3 Accent 2"/>=0A  <w:LsdException Lo=
cked=3D"false" Priority=3D"70" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"=
false" Name=3D"Dark List Accent 2"/>=0A  <w:LsdException Locked=3D"false" P=
riority=3D"71" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"false" Name=3D"C=
olorful Shading Accent 2"/>=0A  <w:LsdException Locked=3D"false" Priority=
=3D"72" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"false" Name=3D"Colorful=
 List Accent 2"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"73" Semi=
Hidden=3D"false"=0A   UnhideWhenUsed=3D"false" Name=3D"Colorful Grid Accent=
 2"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"60" SemiHidden=3D"fa=
lse"=0A   UnhideWhenUsed=3D"false" Name=3D"Light Shading Accent 3"/>=0A  <w=
:LsdException Locked=3D"false" Priority=3D"61" SemiHidden=3D"false"=0A   Un=
hideWhenUsed=3D"false" Name=3D"Light List Accent 3"/>=0A  <w:LsdException L=
ocked=3D"false" Priority=3D"62" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D=
"false" Name=3D"Light Grid Accent 3"/>=0A  <w:LsdException Locked=3D"false"=
 Priority=3D"63" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"false" Name=3D=
"Medium Shading 1 Accent 3"/>=0A  <w:LsdException Locked=3D"false" Priority=
=3D"64" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"false" Name=3D"Medium S=
hading 2 Accent 3"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"65" S=
emiHidden=3D"false"=0A   UnhideWhenUsed=3D"false" Name=3D"Medium List 1 Acc=
ent 3"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"66" SemiHidden=3D=
"false"=0A   UnhideWhenUsed=3D"false" Name=3D"Medium List 2 Accent 3"/>=0A =
 <w:LsdException Locked=3D"false" Priority=3D"67" SemiHidden=3D"false"=0A  =
 UnhideWhenUsed=3D"false" Name=3D"Medium Grid 1 Accent 3"/>=0A  <w:LsdExcep=
tion Locked=3D"false" Priority=3D"68" SemiHidden=3D"false"=0A   UnhideWhenU=
sed=3D"false" Name=3D"Medium Grid 2 Accent 3"/>=0A  <w:LsdException Locked=
=3D"false" Priority=3D"69" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"fals=
e" Name=3D"Medium Grid 3 Accent 3"/>=0A  <w:LsdException Locked=3D"false" P=
riority=3D"70" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"false" Name=3D"D=
ark List Accent 3"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"71" S=
emiHidden=3D"false"=0A   UnhideWhenUsed=3D"false" Name=3D"Colorful Shading =
Accent 3"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"72" SemiHidden=
=3D"false"=0A   UnhideWhenUsed=3D"false" Name=3D"Colorful List Accent 3"/>=
=0A  <w:LsdException Locked=3D"false" Priority=3D"73" SemiHidden=3D"false"=
=0A   UnhideWhenUsed=3D"false" Name=3D"Colorful Grid Accent 3"/>=0A  <w:Lsd=
Exception Locked=3D"false" Priority=3D"60" SemiHidden=3D"false"=0A   Unhide=
WhenUsed=3D"false" Name=3D"Light Shading Accent 4"/>=0A  <w:LsdException Lo=
cked=3D"false" Priority=3D"61" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"=
false" Name=3D"Light List Accent 4"/>=0A  <w:LsdException Locked=3D"false" =
Priority=3D"62" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"false" Name=3D"=
Light Grid Accent 4"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"63"=
 SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"false" Name=3D"Medium Shading =
1 Accent 4"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"64" SemiHidd=
en=3D"false"=0A   UnhideWhenUsed=3D"false" Name=3D"Medium Shading 2 Accent =
4"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"65" SemiHidden=3D"fal=
se"=0A   UnhideWhenUsed=3D"false" Name=3D"Medium List 1 Accent 4"/>=0A  <w:=
LsdException Locked=3D"false" Priority=3D"66" SemiHidden=3D"false"=0A   Unh=
ideWhenUsed=3D"false" Name=3D"Medium List 2 Accent 4"/>=0A  <w:LsdException=
 Locked=3D"false" Priority=3D"67" SemiHidden=3D"false"=0A   UnhideWhenUsed=
=3D"false" Name=3D"Medium Grid 1 Accent 4"/>=0A  <w:LsdException Locked=3D"=
false" Priority=3D"68" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"false" N=
ame=3D"Medium Grid 2 Accent 4"/>=0A  <w:LsdException Locked=3D"false" Prior=
ity=3D"69" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"false" Name=3D"Mediu=
m Grid 3 Accent 4"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"70" S=
emiHidden=3D"false"=0A   UnhideWhenUsed=3D"false" Name=3D"Dark List Accent =
4"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"71" SemiHidden=3D"fal=
se"=0A   UnhideWhenUsed=3D"false" Name=3D"Colorful Shading Accent 4"/>=0A  =
<w:LsdException Locked=3D"false" Priority=3D"72" SemiHidden=3D"false"=0A   =
UnhideWhenUsed=3D"false" Name=3D"Colorful List Accent 4"/>=0A  <w:LsdExcept=
ion Locked=3D"false" Priority=3D"73" SemiHidden=3D"false"=0A   UnhideWhenUs=
ed=3D"false" Name=3D"Colorful Grid Accent 4"/>=0A  <w:LsdException Locked=
=3D"false" Priority=3D"60" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"fals=
e" Name=3D"Light Shading Accent 5"/>=0A  <w:LsdException Locked=3D"false" P=
riority=3D"61" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"false" Name=3D"L=
ight List Accent 5"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"62" =
SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"false" Name=3D"Light Grid Accen=
t 5"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"63" SemiHidden=3D"f=
alse"=0A   UnhideWhenUsed=3D"false" Name=3D"Medium Shading 1 Accent 5"/>=0A=
  <w:LsdException Locked=3D"false" Priority=3D"64" SemiHidden=3D"false"=0A =
  UnhideWhenUsed=3D"false" Name=3D"Medium Shading 2 Accent 5"/>=0A  <w:LsdE=
xception Locked=3D"false" Priority=3D"65" SemiHidden=3D"false"=0A   UnhideW=
henUsed=3D"false" Name=3D"Medium List 1 Accent 5"/>=0A  <w:LsdException Loc=
ked=3D"false" Priority=3D"66" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"f=
alse" Name=3D"Medium List 2 Accent 5"/>=0A  <w:LsdException Locked=3D"false=
" Priority=3D"67" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"false" Name=
=3D"Medium Grid 1 Accent 5"/>=0A  <w:LsdException Locked=3D"false" Priority=
=3D"68" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"false" Name=3D"Medium G=
rid 2 Accent 5"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"69" Semi=
Hidden=3D"false"=0A   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 3 Accent=
 5"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"70" SemiHidden=3D"fa=
lse"=0A   UnhideWhenUsed=3D"false" Name=3D"Dark List Accent 5"/>=0A  <w:Lsd=
Exception Locked=3D"false" Priority=3D"71" SemiHidden=3D"false"=0A   Unhide=
WhenUsed=3D"false" Name=3D"Colorful Shading Accent 5"/>=0A  <w:LsdException=
 Locked=3D"false" Priority=3D"72" SemiHidden=3D"false"=0A   UnhideWhenUsed=
=3D"false" Name=3D"Colorful List Accent 5"/>=0A  <w:LsdException Locked=3D"=
false" Priority=3D"73" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"false" N=
ame=3D"Colorful Grid Accent 5"/>=0A  <w:LsdException Locked=3D"false" Prior=
ity=3D"60" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"false" Name=3D"Light=
 Shading Accent 6"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"61" S=
emiHidden=3D"false"=0A   UnhideWhenUsed=3D"false" Name=3D"Light List Accent=
 6"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"62" SemiHidden=3D"fa=
lse"=0A   UnhideWhenUsed=3D"false" Name=3D"Light Grid Accent 6"/>=0A  <w:Ls=
dException Locked=3D"false" Priority=3D"63" SemiHidden=3D"false"=0A   Unhid=
eWhenUsed=3D"false" Name=3D"Medium Shading 1 Accent 6"/>=0A  <w:LsdExceptio=
n Locked=3D"false" Priority=3D"64" SemiHidden=3D"false"=0A   UnhideWhenUsed=
=3D"false" Name=3D"Medium Shading 2 Accent 6"/>=0A  <w:LsdException Locked=
=3D"false" Priority=3D"65" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"fals=
e" Name=3D"Medium List 1 Accent 6"/>=0A  <w:LsdException Locked=3D"false" P=
riority=3D"66" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"false" Name=3D"M=
edium List 2 Accent 6"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"6=
7" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 1=
 Accent 6"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"68" SemiHidde=
n=3D"false"=0A   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 2 Accent 6"/>=
=0A  <w:LsdException Locked=3D"false" Priority=3D"69" SemiHidden=3D"false"=
=0A   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 3 Accent 6"/>=0A  <w:Lsd=
Exception Locked=3D"false" Priority=3D"70" SemiHidden=3D"false"=0A   Unhide=
WhenUsed=3D"false" Name=3D"Dark List Accent 6"/>=0A  <w:LsdException Locked=
=3D"false" Priority=3D"71" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"fals=
e" Name=3D"Colorful Shading Accent 6"/>=0A  <w:LsdException Locked=3D"false=
" Priority=3D"72" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"false" Name=
=3D"Colorful List Accent 6"/>=0A  <w:LsdException Locked=3D"false" Priority=
=3D"73" SemiHidden=3D"false"=0A   UnhideWhenUsed=3D"false" Name=3D"Colorful=
 Grid Accent 6"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"19" Semi=
Hidden=3D"false"=0A   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Sub=
tle Emphasis"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"21" SemiHi=
dden=3D"false"=0A   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Inten=
se Emphasis"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"31" SemiHid=
den=3D"false"=0A   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Subtle=
 Reference"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"32" SemiHidd=
en=3D"false"=0A   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Intense=
 Reference"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"33" SemiHidd=
en=3D"false"=0A   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Book Ti=
tle"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"37" Name=3D"Bibliog=
raphy"/>=0A  <w:LsdException Locked=3D"false" Priority=3D"39" QFormat=3D"tr=
ue" Name=3D"TOC Heading"/>=0A </w:LatentStyles>=0A</xml><![endif]--><!--[if=
 gte mso 10]>=0A<style>=0A /* Style Definitions */=0A table.MsoNormalTable=
=0A=09{mso-style-name:"Table Normal";=0A=09mso-tstyle-rowband-size:0;=0A=09=
mso-tstyle-colband-size:0;=0A=09mso-style-noshow:yes;=0A=09mso-style-priori=
ty:99;=0A=09mso-style-parent:"";=0A=09mso-padding-alt:0in 5.4pt 0in 5.4pt;=
=0A=09mso-para-margin:0in;=0A=09mso-para-margin-bottom:.0001pt;=0A=09mso-pa=
gination:widow-orphan;=0A=09font-size:11.0pt;=0A=09font-family:"Calibri","s=
ans-serif";=0A=09mso-ascii-font-family:Calibri;=0A=09mso-ascii-theme-font:m=
inor-latin;=0A=09mso-hansi-font-family:Calibri;=0A=09mso-hansi-theme-font:m=
inor-latin;=0A=09mso-bidi-font-family:"Times New Roman";=0A=09mso-bidi-them=
e-font:minor-bidi;}=0A</style>=0A<![endif]--><div><div><p></p></div></div><=
/td></tr></table>
--1499272879-1882003588-1365038982=:96284--

--1499272879-1085041809-1365038982=:96284
Content-Type: text/plain; name="mc_cmds.diff.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="mc_cmds.diff.txt"

LS0tIG1jX2NtZHMuT3JpZyAgICAgICAgMjAxMy0wNC0wMyAxNDozNjoxNC4w
MDAwMDAwMDAgLTA2MDANCisrKyBtY19jbWRzICAgICAyMDEzLTA0LTAzIDE0
OjM5OjAyLjAwMDAwMDAwMCAtMDYwMA0KQEAgLTEyOCw2ICsxMjgsOSBAQA0K
ICAgIGlmIFsgJD8gLWVxIDAgXQ0KICAgIHRoZW4NCiAgICAgICAgZW5kX3Rl
c3RjYXNlICJNdWx0aWNhc3QgcGluZyBkaXNhYmxlZCBvbiB0aGlzIHN5c3Rl
bSAodGhpcyBpcyBub3JtYWwgb24gcG9zdCB5ZWFyOjIwMDUga2VybmVscyki
DQorICAgICAgIGVjaG8gIlRlbXBvcmFyaWx5IGVuYWJsZSBtdWx0aWNhc3Qg
cGluZyBmb3IgdGVzdGluZyBwdXJwb3Nlcy4iDQorICAgICAgIGVjaG8gMCA+
IC9wcm9jL3N5cy9uZXQvaXB2NC9pY21wX2VjaG9faWdub3JlX2Jyb2FkY2Fz
dHMNCisgICAgICAgaWNtcF9uZWVkX3Jlc2V0PTENCiAgICBmaQ0KDQogICAg
IyBEbyB0aGUgcGluZyB0ZXN0czogRXhlY3V0ZSBwaW5nIDIyNC4wLjAuMSAt
IFZlcmlmeSB0aGF0IHRoZSBwcm9wZXINCkBAIC0xNjYsNiArMTY5LDEwIEBA
DQogew0KICAgICR0cmFjZV9sb2dpYw0KICAgIGVjaG8gIiR0aGlzX2ZpbGU6
IGRvaW5nICQwLiINCisgICBpZiBbIC1uICIkaWNtcF9uZWVkX3Jlc2V0IiBd
OyB0aGVuDQorICAgICAgIGVjaG8gMSA+IC9wcm9jL3N5cy9uZXQvaXB2NC9p
Y21wX2VjaG9faWdub3JlX2Jyb2FkY2FzdHMNCisgICAgICAgZWNobyAiUmVz
dG9yZWQgbXVsdGljYXN0IHBpbmcgc2V0dGluZy4iDQorICAgZmkNCiAgICBy
bSAtcmYgJFBJTkdfT1VUDQogfQ0K

--1499272879-1085041809-1365038982=:96284
Content-Type: text/plain; name="mc_commo.diff.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="mc_commo.diff.txt"

LS0tIG1jX2NvbW1vLk9yaWcgICAgICAgMjAxMy0wNC0wMyAxNToyODo1Ni4w
MDAwMDAwMDAgLTA2MDANCisrKyBtY19jb21tbyAgICAyMDEzLTA0LTAzIDE1
OjM1OjAwLjAwMDAwMDAwMCAtMDYwMA0KQEAgLTUwLDYgKzUwLDExIEBADQog
T1VURklMRT0kVEN0bXAvbWNfY29tbW9fb3V0DQogTlVNTE9PUFM9JHtOVU1M
T09QUzotMn0NCiBJTlRFUkZBQ0U9JHtJTlRFUkZBQ0U6LSQoIiRMVFBST09U
L2Jpbi9nZXRob3N0IiBgaG9zdG5hbWVgIHwgZ3JlcCBhZGRyZXNzZXM6IHwg
YXdrICd7cHJpbnQgJDJ9Jyl9DQorSVBWNF9ORVRXT1JLPSR7SVBWNF9ORVRX
T1JLOi0iMTkyLjE2OC4xMDAifQ0KK0lQVjRfTEhPU1Q9JHtMSE9TVF9JUFY0
X0hPU1Q6LSIxIn0NCitJUFY0X1JIT1NUPSR7TEhPU1RfSVBWNF9IT1NUOi0i
MiJ9DQorTElOS19OVU09JHtMSU5LX05VTS0iMCJ9DQorZGVjbGFyZSAtQSBS
SE9TVF9MSVNUDQoNCiB0aGlzX2ZpbGU9JHswIyMqL30NCiB0cmFwICJpbnRl
cnJ1cHRfdGVzdCIgMg0KQEAgLTU4LDYgKzYzLDI1IEBADQogICBta2RpciAt
cCAkVEN0bXANCiAgIE9DVEVUPWBwcyAtZXdmIHwgZ3JlcCBbbV1jX2NvbW1v
IHwgd2MgLWwgfCBhd2sgJ3twcmludCAkMX0nYA0KICAgR1JPVVBfQUREUj0y
MjQuMC4wLiRPQ1RFVA0KKw0KKyAgaWYgIFsgJFJIT1NUICE9IGBob3N0bmFt
ZWAgXTsgdGhlbg0KKyAgICAgICBpbml0aWFsaXplX2lmIGxob3N0ICRMSU5L
X05VTQ0KKyAgICAgICBbICQ/ID0gMCBdIHx8IGVuZF90ZXN0Y2FzZSAiQ291
bGQgTk9UIGluaXRpYWxpemUgbG9jYWwgaG9zdCBsaW5rIg0KKw0KKyAgICAg
ICBpbml0aWFsaXplX2lmIHJob3N0ICRMSU5LX05VTQ0KKyAgICAgICBbICQ/
ID0gMCBdIHx8IGVuZF90ZXN0Y2FzZSAiQ291bGQgTk9UIGluaXRpYWxpemUg
cmVtb3RlIGhvc3QgbGluayINCisNCisgICAgICAgc2V0X2lwdjRhZGRyIGxo
b3N0ICRMSU5LX05VTSAke0lQVjRfTkVUV09SS30gJHtJUFY0X0xIT1NUfQ0K
KyAgICAgICBbICQ/ID0gMCBdIHx8IGVuZF90ZXN0Y2FzZSAiRmFpbGVkIHRv
IHNldCBpcHY0IGFkZHJlc3MgdG8gbG9jYWwgaG9zdCINCisNCisgICAgICAg
c2V0X2lwdjRhZGRyIHJob3N0ICRMSU5LX05VTSAke0lQVjRfTkVUV09SS30g
JHtJUFY0X1JIT1NUfQ0KKyAgICAgICBbICQ/ID0gMCBdIHx8IGVuZF90ZXN0
Y2FzZSAiRmFpbGVkIHRvIHNldCBpcHY0IGFkZHJlc3MgdG8gcmVtb3RlIGhv
c3QiDQorDQorICAgICAgIElOVEVSRkFDRT0ke0lQVjRfTkVUV09SS30uJHtJ
UFY0X0xIT1NUfQ0KKyAgICAgICBSSE9TVF9MSVNUWyRSSE9TVF09JHtJUFY0
X05FVFdPUkt9LiR7SVBWNF9SSE9TVH0NCisgIGVsc2UNCisgICAgICAgUkhP
U1RfTElTVFskUkhPU1RdPWBob3N0bmFtZWANCisgIGZpDQogfQ0KDQogIyoq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioNCkBAIC0xMjksNyAr
MTUzLDcgQEANCiAgICAgICAgICBlY2hvICJSdW5uaW5nIG9uICRIT1NUIG1j
X3NlbmQgJEdST1VQX0FERFIgJEhPU1QgJFBPUlQgJFRUTCINCg0KICAgICAg
ICAgIHJzaCAtbiAtbCByb290ICRIT1NUICIkTFRQUk9PVC90ZXN0Y2FzZXMv
YmluLyRSRU1PVEVfRVhFQyIgJEdST1VQX0FERFIgXA0KLSAgICAgICAgJEhP
U1QgJFBPUlQgJFRUTCA+L2Rldi9udWxsICYNCisgICAgICAgICR7UkhPU1Rf
TElTVFskSE9TVF19ICRQT1JUICRUVEwgPi9kZXYvbnVsbCAmDQogICAgICAg
ICAgc2xlZXAgMTANCiAgICAgICAgcnNoIC1uIC1sIHJvb3QgJEhPU1QgInBz
IC1ld2YgfCBncmVwIG1jX3NlbmQgfCBncmVwIC12IGdyZXAiDQogICAgICAg
ICAgIFsgJD8gPSAwIF0gfHwgZW5kX3Rlc3RjYXNlICJDb3VsZCBOT1Qgc3Rh
cnQgbWNfc2VuZCBvbiAkSE9TVCINCkBAIC0xNDMsNyArMTY3LDcgQEANCiAg
ICAjdGVzdCBpZiBkYXRhZ3JhbXMgaGFzIGJlZW4gc2VudA0KICAgIGZvciBI
T1NUIGluICRSSE9TVA0KICAgIGRvDQotICAgICAgZ3JlcCAtcSAiJEhPU1Qg
WzAtOV0gWzAtOV0iICRPVVRGSUxFDQorICAgICAgZ3JlcCAtcSAiJHtSSE9T
VF9MSVNUWyRIT1NUXX0gWzAtOV0gWzAtOV0iICRPVVRGSUxFDQogICAgICAg
WyAkPyA9IDAgXSB8fCBlbmRfdGVzdGNhc2UgIk5PIERhdGFncmFtcyByZWNl
aXZlZCBmcm9tICRIT1NUIg0KICAgIGRvbmUNCiB9DQpAQCAtMTc1LDYgKzE5
OSw5IEBADQogICAgcm0gLXJmICRUQ3RtcC9waW5nZmlsZQ0KICAgIHJtIC1y
ZiAkVEN0bXAvbWNfY29tbW9fb3V0DQogICAgcm0gLXJmICRUQ3RtcA0KKw0K
KyAgIGluaXRpYWxpemVfaWYgbGhvc3QgJExJTktfTlVNDQorICAgaW5pdGlh
bGl6ZV9pZiByaG9zdCAkTElOS19OVU0NCiB9DQoNCiAjPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0NCg==

--1499272879-1085041809-1365038982=:96284
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Minimize network downtime and maximize team effectiveness.
Reduce network management and security costs.Learn how to hire 
the most talented Cisco Certified professionals. Visit the 
Employer Resources Portal
http://www.cisco.com/web/learning/employer_resources/index.html
--1499272879-1085041809-1365038982=:96284
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--1499272879-1085041809-1365038982=:96284--

