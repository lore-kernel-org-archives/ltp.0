Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Bhushan.Kumar@mphasis.com>) id 1U1HEq-000371-2E
	for ltp-list@lists.sourceforge.net; Fri, 01 Feb 2013 14:05:08 +0000
Received: from mpbam6ip2.mphasis.com ([203.12.223.66])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1U1HEl-0006Q8-Pv
	for ltp-list@lists.sourceforge.net; Fri, 01 Feb 2013 14:05:07 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Fri, 1 Feb 2013 19:34:21 +0530
Message-ID: <E351E450E8B9F54684A699D42DC5ADF224468DAC@MPBAGVEX02.corp.mphasis.com>
From: "Bhushan Kumar" <Bhushan.Kumar@mphasis.com>
Subject: [LTP] LTP] [PATCH ]: network stress interfaces part of the LTP
	stress fails
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1948027876105416113=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1948027876105416113==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CE0085.08D7B687"

This is a multi-part message in MIME format.

------_=_NextPart_001_01CE0085.08D7B687
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi All ,

 =


Description of problem:

 =


I am getting error while running   if4-mtu-change and if6-updown  network s=
tress interfaces test case  from LTP version  20120903 (ltp-full-20120903.t=
ar) i.e.  on Linux 3.2 kernel. Below are the outputs for error.

 =


 =


The Network stress interfaces part of the LTP stress fails.

 =


network_stress.interface:if4-mtu-change                 FAIL       2    =


network_stress.interface:if6-updown                     FAIL       2  =



 =


Below are the cause for failing above mentioned testcase:

 =


if4-mtu-change01    0  TINFO  :  Verify the IPv4 connectivity is not broken=
 when ifconfig command changes MTU 128 times every 5 seconds

if4-mtu-change01    1  TFAIL  :  eth1 is broken.

if4-mtu-change02    0  TINFO  :  Verify the IPv4 connectivity is not broken=
 when ip command changes MTU 128 times every 5 seconds

if4-mtu-change02    2  TBROK  :  Test Link 0 is somthing wrong.

 =


if6-updown    1  TBROK  :  Link-local address is not found at eth1 on the r=
emote host

 =


Suggested Code changes:

 =


To  resolve above mentioned  error  by making  changes in  ltp-full-2012090=
3/testcases/network/stress/interface/if4-mtu-change  and  ltp-full-20120903=
/testcases/network/stress/interface/if6-updown b/ltp-full-20120903/testcase=
s/network/stress/interface/if6-updown  file. Below are the code changes:

 =


 =


diff -Nurp a/ltp-full-20120903/testcases/network/stress/interface/if4-mtu-c=
hange b/ltp-full-20120903/testcases/network/stress/interface/if4-mtu-change

--- a/ltp-full-20120903/testcases/network/stress/interface/if4-mtu-change  =
     2013-01-09 02:07:21.000000000 -0700

+++ b/ltp-full-20120903/testcases/network/stress/interface/if4-mtu-change  =
     2013-02-01 05:09:51.000000000 -0700

@@ -190,6 +190,7 @@ test_body()

 =


     # Check the connctivity

     check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr

+    sleep 5

     if [ $? -ne 0 ]; then

        tst_resm TBROK "Test Link $LINK_NUM is somthing wrong."

        return 1

@@ -237,6 +238,7 @@ test_body()

 =


     # Check the connectivity again

     check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr

+    sleep 5

     if [ $? -ne 0 ]; then

        tst_resm TFAIL "$lhost_ifname is broken."

        return 1

diff -Nurp a/ltp-full-20120903/testcases/network/stress/interface/if6-updow=
n b/ltp-full-20120903/testcases/network/stress/interface/if6-updown

--- a/ltp-full-20120903/testcases/network/stress/interface/if6-updown   201=
3-01-09 02:07:21.000000000 -0700

+++ b/ltp-full-20120903/testcases/network/stress/interface/if6-updown   201=
3-02-01 05:12:40.000000000 -0700

@@ -93,7 +93,7 @@ do_setup()

     # Initialize the interfaces

     initialize_if lhost ${LINK_NUM}

     initialize_if rhost ${LINK_NUM}

-

+    sleep 5

     # Get the Interface name of local host

     lhost_ifname=3D`get_ifname lhost ${LINK_NUM}`

     if [ $? -ne 0 ]; then

 =


After the mentioned changes I got output =


 =


<<<test_output>>>

/opt/ltp/testcases/bin/bg_tcp_traffic: line 269: $2: unbound variable

if4-mtu-change01    0  TINFO  :  Verify the IPv4 connectivity is not broken=
 when ifconfig command changes MTU 128 times every 5 seconds

/opt/ltp/testcases/bin/bg_tcp_traffic: line 269: $2: unbound variable

if4-mtu-change01    1  TPASS  :  Test is finished correctly.

if4-mtu-change02    0  TINFO  :  Verify the IPv4 connectivity is not broken=
 when ip command changes MTU 128 times every 5 seconds

if4-mtu-change02    2  TPASS  :  Test is finished correctly.

<<<execution_status>>>

tag=3Dif6-updown stime=3D1359722982

cmdline=3D" if6-updown"

contacts=3D""

analysis=3Dexit

<<<test_output>>>

if6-updown01    0  TINFO  :  Verify the IPv6 connectivity is not broken whe=
n the ifconfig command ups, then downs an interface 128 times

if6-updown01    1  TPASS  :  Test is finished successfully.

if6-updown02    0  TINFO  :  Verify the IPv6 connectivity is not broken whe=
n the ip command ups, then downs an interface 128 times

if6-updown02    2  TPASS  :  Test is finished successfully.

incrementing stop

<<<execution_status>>>

initiation_status=3D"ok"

duration=3D1449 termination_type=3Dexited termination_id=3D0 corefile=3Dno

cutime=3D103 cstime=3D456

<<<test_end>>>

 =


Could you please let me know that above code changes are valid or not ? Ple=
ase suggest me if there are any other solutions to resolve above error.

Any help would be appreciated !!!!

 =


Thanks,

Bhushan =


 =

 =


Information transmitted by this e-mail is proprietary to MphasiS, its assoc=
iated companies and/ or its customers and is intended =

for use only by the individual or entity to which it is addressed, and may =
contain information that is privileged, confidential or =

exempt from disclosure under applicable law. If you are not the intended re=
cipient or it appears that this mail has been forwarded =

to you without proper authority, you are notified that any use or dissemina=
tion of this information in any manner is strictly =

prohibited. In such cases, please notify us immediately at mailmaster@mphas=
is.com and delete this mail from your records.

------_=_NextPart_001_01CE0085.08D7B687
MIME-Version: 1.0
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML dir=3Dltr><HEAD>
<META content=3D"text/html; charset=3Dunicode" http-equiv=3DContent-Type>
<META name=3DGENERATOR content=3D"MSHTML 8.00.6001.19393"></HEAD>
<BODY>
<DIV dir=3Dltr id=3DidOWAReplyText85463>
<DIV dir=3Dltr><FONT color=3D#000000 size=3D2 face=3DArial>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT face=3DCalibri><FO=
NT size=3D3>Hi All</FONT><SPAN style=3D"FONT-SIZE: 10pt"> ,<?xml:namespace =
prefix =3D o ns =3D "urn:schemas-microsoft-com:office:office" /><o:p></o:p>=
</SPAN></FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><SPAN style=3D"FONT-SIZE=
: 10pt"><o:p><FONT face=3DCalibri>&nbsp;</FONT></o:p></SPAN></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><B><FONT size=3D3><FONT =
face=3DCalibri>Description of problem:<o:p></o:p></FONT></FONT></B></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><o:p><FONT size=3D3 face=
=3DCalibri>&nbsp;</FONT></o:p></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT face=3DCalibri><SP=
AN style=3D"FONT-SIZE: 10pt">I </SPAN><FONT size=3D3>am getting error while=
 running&nbsp; &nbsp;if4-mtu-change and if6-updown &nbsp;network stress int=
erfaces test case &nbsp;from LTP version&nbsp; 20120903 (ltp-full-20120903.=
tar) i.e. &nbsp;on<B> Linux 3.2 kernel</B>. Below are the outputs for error=
.<SPAN style=3D"FONT-SIZE: 10pt"><o:p></o:p></SPAN></FONT></FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><o:p><FONT size=3D3 face=
=3DCalibri>&nbsp;</FONT></o:p></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><o:p><FONT size=3D3 face=
=3DCalibri>&nbsp;</FONT></o:p></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>The Network stress interfaces part of the LTP stress fails.</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><o:p><FONT size=3D3 face=
=3DCalibri>&nbsp;</FONT></o:p></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>network_stress.interface:if4-mtu-change&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FAIL&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp;&nbsp;&nbsp; </FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>network_stress.interface:if6-updown&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; FAIL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp; </FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><SPAN style=3D"FONT-SIZE=
: 10pt"><BR><FONT face=3DCalibri>&nbsp;</FONT></SPAN></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>Below are the cause for failing above mentioned testcase:</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><SPAN style=3D"FONT-SIZE=
: 10pt"><o:p><FONT face=3DCalibri>&nbsp;</FONT></o:p></SPAN></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>if4-mtu-change01&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; Verify=
 the IPv4 connectivity is not broken when ifconfig command changes MTU 128 =
times every 5 seconds</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>if4-mtu-change01&nbsp;&nbsp;&nbsp; 1&nbsp; TFAIL&nbsp; :&nbsp; eth1 i=
s broken.</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>if4-mtu-change02&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; Verify=
 the IPv4 connectivity is not broken when ip command changes MTU 128 times =
every 5 seconds</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>if4-mtu-change02&nbsp;&nbsp;&nbsp; 2&nbsp; TBROK&nbsp; :&nbsp; Test L=
ink 0 is somthing wrong.</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><o:p><FONT size=3D3 face=
=3DCalibri>&nbsp;</FONT></o:p></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>if6-updown&nbsp;&nbsp;&nbsp; 1&nbsp; TBROK&nbsp; :&nbsp; Link-local a=
ddress is not found at eth1 on the remote host</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><o:p><FONT size=3D3 face=
=3DCalibri>&nbsp;</FONT></o:p></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><B><FONT size=3D3><FONT =
face=3DCalibri>Suggested Code changes:<o:p></o:p></FONT></FONT></B></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><o:p><FONT size=3D3 face=
=3DCalibri>&nbsp;</FONT></o:p></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT face=3DCalibri><FO=
NT size=3D3>To &nbsp;resolve above mentioned &nbsp;error&nbsp; by making &n=
bsp;changes in &nbsp;ltp-full-20120903/testcases/network/stress/interface/i=
f4-mtu-change &nbsp;and &nbsp;ltp-full-20120903/testcases/network/stress/in=
terface/if6-updown b/ltp-full-20120903/testcases/network/stress/interface/i=
f6-updown &nbsp;file.</FONT><SPAN style=3D"FONT-SIZE: 10pt"> </SPAN><FONT s=
ize=3D3>Below are the code changes:</FONT></FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><SPAN style=3D"FONT-SIZE=
: 10pt"><o:p><FONT face=3DCalibri>&nbsp;</FONT></o:p></SPAN></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><SPAN style=3D"FONT-SIZE=
: 10pt"><o:p><FONT face=3DCalibri>&nbsp;</FONT></o:p></SPAN></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>diff -Nurp a/ltp-full-20120903/testcases/network/stress/interface/if4=
-mtu-change b/ltp-full-20120903/testcases/network/stress/interface/if4-mtu-=
change</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>--- a/ltp-full-20120903/testcases/network/stress/interface/if4-mtu-ch=
ange&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2013-01-09 02:07:21.000000000 -070=
0</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>+++ b/ltp-full-20120903/testcases/network/stress/interface/if4-mtu-ch=
ange&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2013-02-01 05:09:51.000000000 -070=
0</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>@@ -190,6 +190,7 @@ test_body()</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><o:p><FONT size=3D3 face=
=3DCalibri>&nbsp;</FONT></o:p></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>&nbsp; &nbsp;&nbsp;&nbsp;# Check the connctivity</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>&nbsp;&nbsp;&nbsp;&nbsp; check_icmpv4_connectivity $lhost_ifname $rho=
st_ipv4addr</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>+&nbsp;&nbsp;&nbsp; sleep 5</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>&nbsp;&nbsp;&nbsp;&nbsp; if [ $? -ne 0 ]; then</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tst_resm TBROK "Test Link =
$LINK_NUM is somthing wrong."</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 1</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>@@ -237,6 +238,7 @@ test_body()</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><o:p><FONT size=3D3 face=
=3DCalibri>&nbsp;</FONT></o:p></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>&nbsp;&nbsp;&nbsp;&nbsp; # Check the connectivity again</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>&nbsp;&nbsp;&nbsp;&nbsp; check_icmpv4_connectivity $lhost_ifname $rho=
st_ipv4addr</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>+&nbsp;&nbsp;&nbsp; sleep 5</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>&nbsp;&nbsp;&nbsp;&nbsp; if [ $? -ne 0 ]; then</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tst_resm TFAIL "$lhost_ifn=
ame is broken."</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 1</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>diff -Nurp a/ltp-full-20120903/testcases/network/stress/interface/if6=
-updown b/ltp-full-20120903/testcases/network/stress/interface/if6-updown</=
FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>--- a/ltp-full-20120903/testcases/network/stress/interface/if6-updown=
&nbsp;&nbsp; 2013-01-09 02:07:21.000000000 -0700</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>+++ b/ltp-full-20120903/testcases/network/stress/interface/if6-updown=
&nbsp;&nbsp; 2013-02-01 05:12:40.000000000 -0700</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>@@ -93,7 +93,7 @@ do_setup()</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>&nbsp;&nbsp;&nbsp;&nbsp; # Initialize the interfaces</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>&nbsp;&nbsp;&nbsp;&nbsp; initialize_if lhost ${LINK_NUM}</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>&nbsp;&nbsp;&nbsp;&nbsp; initialize_if rhost ${LINK_NUM}</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>-</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>+&nbsp;&nbsp;&nbsp; sleep 5</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>&nbsp;&nbsp;&nbsp;&nbsp; # Get the Interface name of local host</FONT=
></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>&nbsp;&nbsp;&nbsp;&nbsp; lhost_ifname=3D`get_ifname lhost ${LINK_NUM}=
`</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>&nbsp;&nbsp;&nbsp;&nbsp; if [ $? -ne 0 ]; then</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><o:p><FONT size=3D3 face=
=3DCalibri>&nbsp;</FONT></o:p></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>After the mentioned changes I got output </FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><o:p><FONT size=3D3 face=
=3DCalibri>&nbsp;</FONT></o:p></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>&lt;&lt;&lt;test_output&gt;&gt;&gt;</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>/opt/ltp/testcases/bin/bg_tcp_traffic: line 269: $2: unbound variable=
</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>if4-mtu-change01&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; Verify=
 the IPv4 connectivity is not broken when ifconfig command changes MTU 128 =
times every 5 seconds</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>/opt/ltp/testcases/bin/bg_tcp_traffic: line 269: $2: unbound variable=
</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>if4-mtu-change01&nbsp;&nbsp;&nbsp; 1&nbsp; TPASS&nbsp; :&nbsp; Test i=
s finished correctly.</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>if4-mtu-change02&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; Verify=
 the IPv4 connectivity is not broken when ip command changes MTU 128 times =
every 5 seconds</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>if4-mtu-change02&nbsp;&nbsp;&nbsp; 2&nbsp; TPASS&nbsp; :&nbsp; Test i=
s finished correctly.</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>&lt;&lt;&lt;execution_status&gt;&gt;&gt;</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>tag=3Dif6-updown stime=3D1359722982</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>cmdline=3D" if6-updown"</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>contacts=3D""</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>analysis=3Dexit</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>&lt;&lt;&lt;test_output&gt;&gt;&gt;</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>if6-updown01&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; Verify the=
 IPv6 connectivity is not broken when the ifconfig command ups, then downs =
an interface 128 times</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>if6-updown01&nbsp;&nbsp;&nbsp; 1&nbsp; TPASS&nbsp; :&nbsp; Test is fi=
nished successfully.</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>if6-updown02&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; Verify the=
 IPv6 connectivity is not broken when the ip command ups, then downs an int=
erface 128 times</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>if6-updown02&nbsp;&nbsp;&nbsp; 2&nbsp; TPASS&nbsp; :&nbsp; Test is fi=
nished successfully.</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>incrementing stop</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>&lt;&lt;&lt;execution_status&gt;&gt;&gt;</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>initiation_status=3D"ok"</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>duration=3D1449 termination_type=3Dexited termination_id=3D0 corefile=
=3Dno</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>cutime=3D103 cstime=3D456</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>&lt;&lt;&lt;test_end&gt;&gt;&gt;</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><o:p><FONT size=3D3 face=
=3DCalibri>&nbsp;</FONT></o:p></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>Could you please let me know that above code changes are valid or not=
 ? Please suggest me if there are any other solutions to resolve above erro=
r.</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>Any help would be appreciated !!!!</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><o:p><FONT size=3D3 face=
=3DCalibri>&nbsp;</FONT></o:p></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>Thanks,</FONT></P>
<P style=3D"MARGIN: 0in 0in 0pt" class=3DMsoNormal><FONT size=3D3 face=3DCa=
libri>Bhushan </FONT></P></FONT></DIV>
<DIV dir=3Dltr><FONT color=3D#000000 size=3D2 face=3DArial></FONT>&nbsp;</D=
IV></DIV>
<DIV dir=3Dltr id=3DidSignature90577>&nbsp;</DIV><p><br>
Information transmitted by this e-mail is proprietary to MphasiS, its assoc=
iated companies and/ or its customers and is intended <br>
for use only by the individual or entity to which it is addressed, and may =
contain information that is privileged, confidential or <br>
exempt from disclosure under applicable law. If you are not the intended re=
cipient or it appears that this mail has been forwarded <br>
to you without proper authority, you are notified that any use or dissemina=
tion of this information in any manner is strictly <br>
prohibited. In such cases, please notify us immediately at mailmaster@mphas=
is.com and delete this mail from your records.</p></BODY></HTML>
------_=_NextPart_001_01CE0085.08D7B687--



--===============1948027876105416113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_jan
--===============1948027876105416113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1948027876105416113==--


