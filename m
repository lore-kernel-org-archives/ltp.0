Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <bhushan.kumar@hp.com>) id 1U1GjY-0000cw-G0
	for ltp-list@lists.sourceforge.net; Fri, 01 Feb 2013 13:32:48 +0000
Received: from g1t0028.austin.hp.com ([15.216.28.35])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1U1GjW-0003lZ-P2
	for ltp-list@lists.sourceforge.net; Fri, 01 Feb 2013 13:32:48 +0000
From: "KUMAR, BHUSHAN" <bhushan.kumar@hp.com>
Date: Fri, 1 Feb 2013 13:32:00 +0000
Message-ID: <C4EE7EE7BE404C459168BE7FE14AF346252633@G1W3644.americas.hpqcorp.net>
Content-Language: en-US
MIME-Version: 1.0
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
Content-Type: multipart/mixed; boundary="===============2363155904565551074=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--===============2363155904565551074==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_C4EE7EE7BE404C459168BE7FE14AF346252633G1W3644americashp_"

--_000_C4EE7EE7BE404C459168BE7FE14AF346252633G1W3644americashp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All ,

Description of problem:

I am getting error while running   if4-mtu-change and if6-updown  network s=
tress interfaces test case  from LTP version  20120903 (ltp-full-20120903.t=
ar) i.e.  on Linux 3.2 kernel. Below are the outputs for error.


The Network stress interfaces part of the LTP stress fails.

network_stress.interface:if4-mtu-change                 FAIL       2
network_stress.interface:if6-updown                     FAIL       2


Below are the cause for failing above mentioned testcase:

if4-mtu-change01    0  TINFO  :  Verify the IPv4 connectivity is not broken=
 when ifconfig command changes MTU 128 times every 5 seconds
if4-mtu-change01    1  TFAIL  :  eth1 is broken.
if4-mtu-change02    0  TINFO  :  Verify the IPv4 connectivity is not broken=
 when ip command changes MTU 128 times every 5 seconds
if4-mtu-change02    2  TBROK  :  Test Link 0 is somthing wrong.

if6-updown    1  TBROK  :  Link-local address is not found at eth1 on the r=
emote host

Suggested Code changes:

To  resolve above mentioned  error  by making  changes in  ltp-full-2012090=
3/testcases/network/stress/interface/if4-mtu-change  and  ltp-full-20120903=
/testcases/network/stress/interface/if6-updown b/ltp-full-20120903/testcase=
s/network/stress/interface/if6-updown  file. Below are the code changes:


diff -Nurp a/ltp-full-20120903/testcases/network/stress/interface/if4-mtu-c=
hange b/ltp-full-20120903/testcases/network/stress/interface/if4-mtu-change
--- a/ltp-full-20120903/testcases/network/stress/interface/if4-mtu-change  =
     2013-01-09 02:07:21.000000000 -0700
+++ b/ltp-full-20120903/testcases/network/stress/interface/if4-mtu-change  =
     2013-02-01 05:09:51.000000000 -0700
@@ -190,6 +190,7 @@ test_body()

     # Check the connctivity
     check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr
+    sleep 5
     if [ $? -ne 0 ]; then
        tst_resm TBROK "Test Link $LINK_NUM is somthing wrong."
        return 1
@@ -237,6 +238,7 @@ test_body()

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

After the mentioned changes I got output

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

Could you please let me know that above code changes are valid or not ? Ple=
ase suggest me if there are any other solutions to resolve above error.
Any help would be appreciated !!!!

Thanks,
Bhushan

--_000_C4EE7EE7BE404C459168BE7FE14AF346252633G1W3644americashp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 12 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi All<span style=3D"font-size:10.0pt"> ,<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><b>Description of problem:<o:p></o:p></b></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt">I </span>am getting=
 error while running&nbsp; &nbsp;if4-mtu-change and if6-updown &nbsp;networ=
k stress interfaces test case &nbsp;from LTP version&nbsp; 20120903 (ltp-fu=
ll-20120903.tar) i.e. &nbsp;on<b> Linux 3.2 kernel</b>. Below are
 the outputs for error.<span style=3D"font-size:10.0pt"><o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The Network stress interfaces part of the LTP stress=
 fails.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">network_stress.interface:if4-mtu-change&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; FAIL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">network_stress.interface:if6-updown&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; FAIL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2&nbs=
p;
<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt"><br>
&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal">Below are the cause for failing above mentioned test=
case:<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal">if4-mtu-change01&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbs=
p; :&nbsp; Verify the IPv4 connectivity is not broken when ifconfig command=
 changes MTU 128 times every 5 seconds<o:p></o:p></p>
<p class=3D"MsoNormal">if4-mtu-change01&nbsp;&nbsp;&nbsp; 1&nbsp; TFAIL&nbs=
p; :&nbsp; eth1 is broken.<o:p></o:p></p>
<p class=3D"MsoNormal">if4-mtu-change02&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbs=
p; :&nbsp; Verify the IPv4 connectivity is not broken when ip command chang=
es MTU 128 times every 5 seconds<o:p></o:p></p>
<p class=3D"MsoNormal">if4-mtu-change02&nbsp;&nbsp;&nbsp; 2&nbsp; TBROK&nbs=
p; :&nbsp; Test Link 0 is somthing wrong.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">if6-updown&nbsp;&nbsp;&nbsp; 1&nbsp; TBROK&nbsp; :&n=
bsp; Link-local address is not found at eth1 on the remote host<o:p></o:p><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><b>Suggested Code changes:<o:p></o:p></b></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">To &nbsp;resolve above mentioned &nbsp;error&nbsp; b=
y making &nbsp;changes in &nbsp;ltp-full-20120903/testcases/network/stress/=
interface/if4-mtu-change &nbsp;and &nbsp;ltp-full-20120903/testcases/networ=
k/stress/interface/if6-updown b/ltp-full-20120903/testcases/network/stress/=
interface/if6-updown
 &nbsp;file.<span style=3D"font-size:10.0pt"> </span>Below are the code cha=
nges:<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal">diff -Nurp a/ltp-full-20120903/testcases/network/str=
ess/interface/if4-mtu-change b/ltp-full-20120903/testcases/network/stress/i=
nterface/if4-mtu-change<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/ltp-full-20120903/testcases/network/stress/int=
erface/if4-mtu-change&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2013-01-09 02:07:=
21.000000000 -0700<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&#43;&#43; b/ltp-full-20120903/testcases/networ=
k/stress/interface/if4-mtu-change&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2013-=
02-01 05:09:51.000000000 -0700<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -190,6 &#43;190,7 @@ test_body()<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp; &nbsp;&nbsp;&nbsp;# Check the connctivity<o:p=
></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; check_icmpv4_connectivity $=
lhost_ifname $rhost_ipv4addr<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; sleep 5<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; if [ $? -ne 0 ]; then<o:p><=
/o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tst_resm =
TBROK &quot;Test Link $LINK_NUM is somthing wrong.&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 1<=
o:p></o:p></p>
<p class=3D"MsoNormal">@@ -237,6 &#43;238,7 @@ test_body()<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; # Check the connectivity ag=
ain<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; check_icmpv4_connectivity $=
lhost_ifname $rhost_ipv4addr<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; sleep 5<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; if [ $? -ne 0 ]; then<o:p><=
/o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tst_resm =
TFAIL &quot;$lhost_ifname is broken.&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 1<=
o:p></o:p></p>
<p class=3D"MsoNormal">diff -Nurp a/ltp-full-20120903/testcases/network/str=
ess/interface/if6-updown b/ltp-full-20120903/testcases/network/stress/inter=
face/if6-updown<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/ltp-full-20120903/testcases/network/stress/int=
erface/if6-updown&nbsp;&nbsp; 2013-01-09 02:07:21.000000000 -0700<o:p></o:p=
></p>
<p class=3D"MsoNormal">&#43;&#43;&#43; b/ltp-full-20120903/testcases/networ=
k/stress/interface/if6-updown&nbsp;&nbsp; 2013-02-01 05:12:40.000000000 -07=
00<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -93,7 &#43;93,7 @@ do_setup()<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; # Initialize the interfaces=
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; initialize_if lhost ${LINK_=
NUM}<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; initialize_if rhost ${LINK_=
NUM}<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; sleep 5<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; # Get the Interface name of=
 local host<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; lhost_ifname=3D`get_ifname =
lhost ${LINK_NUM}`<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; if [ $? -ne 0 ]; then<o:p><=
/o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">After the mentioned changes I got output <o:p></o:p>=
</p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&lt;&lt;&lt;test_output&gt;&gt;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">/opt/ltp/testcases/bin/bg_tcp_traffic: line 269: $2:=
 unbound variable<o:p></o:p></p>
<p class=3D"MsoNormal">if4-mtu-change01&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbs=
p; :&nbsp; Verify the IPv4 connectivity is not broken when ifconfig command=
 changes MTU 128 times every 5 seconds<o:p></o:p></p>
<p class=3D"MsoNormal">/opt/ltp/testcases/bin/bg_tcp_traffic: line 269: $2:=
 unbound variable<o:p></o:p></p>
<p class=3D"MsoNormal">if4-mtu-change01&nbsp;&nbsp;&nbsp; 1&nbsp; TPASS&nbs=
p; :&nbsp; Test is finished correctly.<o:p></o:p></p>
<p class=3D"MsoNormal">if4-mtu-change02&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbs=
p; :&nbsp; Verify the IPv4 connectivity is not broken when ip command chang=
es MTU 128 times every 5 seconds<o:p></o:p></p>
<p class=3D"MsoNormal">if4-mtu-change02&nbsp;&nbsp;&nbsp; 2&nbsp; TPASS&nbs=
p; :&nbsp; Test is finished correctly.<o:p></o:p></p>
<p class=3D"MsoNormal">&lt;&lt;&lt;execution_status&gt;&gt;&gt;<o:p></o:p><=
/p>
<p class=3D"MsoNormal">tag=3Dif6-updown stime=3D1359722982<o:p></o:p></p>
<p class=3D"MsoNormal">cmdline=3D&quot; if6-updown&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">contacts=3D&quot;&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">analysis=3Dexit<o:p></o:p></p>
<p class=3D"MsoNormal">&lt;&lt;&lt;test_output&gt;&gt;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">if6-updown01&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :=
&nbsp; Verify the IPv6 connectivity is not broken when the ifconfig command=
 ups, then downs an interface 128 times<o:p></o:p></p>
<p class=3D"MsoNormal">if6-updown01&nbsp;&nbsp;&nbsp; 1&nbsp; TPASS&nbsp; :=
&nbsp; Test is finished successfully.<o:p></o:p></p>
<p class=3D"MsoNormal">if6-updown02&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :=
&nbsp; Verify the IPv6 connectivity is not broken when the ip command ups, =
then downs an interface 128 times<o:p></o:p></p>
<p class=3D"MsoNormal">if6-updown02&nbsp;&nbsp;&nbsp; 2&nbsp; TPASS&nbsp; :=
&nbsp; Test is finished successfully.<o:p></o:p></p>
<p class=3D"MsoNormal">incrementing stop<o:p></o:p></p>
<p class=3D"MsoNormal">&lt;&lt;&lt;execution_status&gt;&gt;&gt;<o:p></o:p><=
/p>
<p class=3D"MsoNormal">initiation_status=3D&quot;ok&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">duration=3D1449 termination_type=3Dexited terminatio=
n_id=3D0 corefile=3Dno<o:p></o:p></p>
<p class=3D"MsoNormal">cutime=3D103 cstime=3D456<o:p></o:p></p>
<p class=3D"MsoNormal">&lt;&lt;&lt;test_end&gt;&gt;&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Could you please let me know that above code changes=
 are valid or not ? Please suggest me if there are any other solutions to r=
esolve above error.<o:p></o:p></p>
<p class=3D"MsoNormal">Any help would be appreciated !!!!<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Bhushan <o:p></o:p></p>
</div>
</body>
</html>

--_000_C4EE7EE7BE404C459168BE7FE14AF346252633G1W3644americashp_--


--===============2363155904565551074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_feb
--===============2363155904565551074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2363155904565551074==--

