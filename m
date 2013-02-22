Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <bhushan.kumar@hp.com>) id 1U8tfP-0005Pq-3H
	for ltp-list@lists.sourceforge.net; Fri, 22 Feb 2013 14:32:03 +0000
Received: from g1t0027.austin.hp.com ([15.216.28.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1U8tfI-0000UN-PE
	for ltp-list@lists.sourceforge.net; Fri, 22 Feb 2013 14:32:02 +0000
From: "KUMAR, BHUSHAN" <bhushan.kumar@hp.com>
Date: Fri, 22 Feb 2013 14:30:40 +0000
Message-ID: <C4EE7EE7BE404C459168BE7FE14AF346BF484B@G2W2430.americas.hpqcorp.net>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP]  LTP] [PATCH ]: containers from LTP  stress fails
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2311382393783865261=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--===============2311382393783865261==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_C4EE7EE7BE404C459168BE7FE14AF346BF484BG2W2430americashp_"

--_000_C4EE7EE7BE404C459168BE7FE14AF346BF484BG2W2430americashp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,

Description of problem:

I am getting error while running  containers   from  LTP  Kernel stress tes=
t case, from LTP version  20120903 (ltp-full-20120903.tar) i.e. on Linux 3.=
2 kernel. Below are the outputs for error.

containers from LTP stress  fails

Containers                     FAIL       1

Below are the cause for failing above mentioned testcase:


child.sh: line 38: tst_resm: command not found
/opt/ltp/testcases/bin/child_2.sh: line 65: tst_resm: command not found
/opt/ltp/testcases/bin/child_1.sh: line 71: tst_resm: command not found
rename_net.sh: line 50: tst_resm: command not found
/opt/ltp/testcases/bin/childipv6.sh: line 72: tst_resm: command not found
parentns.sh    0  TINFO  :  Pinging ChildNS from ParentNS
Error: Can't cd
ch_ftp.sh: line 40: tst_resm: command not found
Error while running the script


Suggested Code changes:

Below are the code changes:

diff -Nurp a/ltp-full-20130109/testcases/kernel/containers/netns/ch_ftp.sh =
b/ltp-full-20130109/testcases/kernel/containers/netns/ch_ftp.sh
--- a/ltp-full-20130109/testcases/kernel/containers/netns/ch_ftp.sh     201=
3-01-09 02:07:20.000000000 -0700
+++ b/ltp-full-20130109/testcases/kernel/containers/netns/ch_ftp.sh     201=
3-02-20 00:48:58.000000000 -0700
@@ -27,6 +27,7 @@ TST_COUNT=3D1
export TCID
export TST_COUNT
export TST_TOTAL
+export PATH=3D$PATH:`dirname $0`
     ping -q -c 2 $IP1 > /dev/null
     if [ $? -ne 0 ] ; then
diff -Nurp a/ltp-full-20130109/testcases/kernel/containers/netns/child_1.sh=
 b/ltp-full-20130109/testcases/kernel/containers/netns/child_1.sh
--- a/ltp-full-20130109/testcases/kernel/containers/netns/child_1.sh    201=
3-01-09 02:07:20.000000000 -0700
+++ b/ltp-full-20130109/testcases/kernel/containers/netns/child_1.sh    201=
3-02-20 00:27:14.000000000 -0700
@@ -28,6 +28,7 @@ TST_COUNT=3D1
export TCID
export TST_COUNT
export TST_TOTAL
+export PATH=3D$PATH:`dirname $0`
 . initialize.sh
status=3D0
diff -Nurp a/ltp-full-20130109/testcases/kernel/containers/netns/child_2.sh=
 b/ltp-full-20130109/testcases/kernel/containers/netns/child_2.sh
--- a/ltp-full-20130109/testcases/kernel/containers/netns/child_2.sh    201=
3-01-09 02:07:20.000000000 -0700
+++ b/ltp-full-20130109/testcases/kernel/containers/netns/child_2.sh    201=
3-02-20 00:28:36.000000000 -0700
@@ -28,6 +28,7 @@ TST_COUNT=3D1
export TCID
export TST_COUNT
export TST_TOTAL
+export PATH=3D$PATH:`dirname $0`
. initialize.sh
status=3D0
diff -Nurp a/ltp-full-20130109/testcases/kernel/containers/netns/childipv6.=
sh b/ltp-full-20130109/testcases/kernel/containers/netns/childipv6.sh
--- a/ltp-full-20130109/testcases/kernel/containers/netns/childipv6.sh  201=
3-01-09 02:07:20.000000000 -0700
+++ b/ltp-full-20130109/testcases/kernel/containers/netns/childipv6.sh  201=
3-02-20 00:29:38.000000000 -0700
@@ -37,6 +37,7 @@ TST_COUNT=3D1
export TCID
export TST_COUNT
export TST_TOTAL
+export PATH=3D$PATH:`dirname $0`
.  initialize.sh
status=3D0
diff -Nurp a/ltp-full-20130109/testcases/kernel/containers/netns/childns.sh=
 b/ltp-full-20130109/testcases/kernel/containers/netns/childns.sh
--- a/ltp-full-20130109/testcases/kernel/containers/netns/childns.sh    201=
3-01-09 02:07:20.000000000 -0700
+++ b/ltp-full-20130109/testcases/kernel/containers/netns/childns.sh    201=
3-02-20 00:30:28.000000000 -0700
@@ -33,6 +33,7 @@
# The test case ID, the test case count and the total number of test case
 export TCID=3D${TCID:-childns.sh}
+export PATH=3D$PATH:`dirname $0`
. cmdlib.sh
exists awk grep ip ping sshd
. initialize.sh
diff -Nurp a/ltp-full-20130109/testcases/kernel/containers/netns/container_=
ftp.pl b/ltp-full-20130109/testcases/kernel/containers/netns/container_ftp.=
pl
--- a/ltp-full-20130109/testcases/kernel/containers/netns/container_ftp.pl =
   2013-01-09 02:07:20.000000000 -0700
+++ b/ltp-full-20130109/testcases/kernel/containers/netns/container_ftp.pl =
   2013-02-20 00:34:24.000000000 -0700
@@ -36,8 +36,8 @@ my $i =3D 0;
my $kount =3D 51;
my $file=3D"junkfile";
-my $tmpdir =3D "/var/ftp";
-
+#my $tmpdir =3D "/var/ftp";
+my $tmpdir =3D "/home/ftp";
my $dir;
$dir =3D tempdir("container_ftp.XXXXXXX", DIR =3D> $tmpdir);
if (!defined($dir)) {
diff -Nurp a/ltp-full-20130109/testcases/kernel/containers/netns/par_ftp.sh=
 b/ltp-full-20130109/testcases/kernel/containers/netns/par_ftp.sh
--- a/ltp-full-20130109/testcases/kernel/containers/netns/par_ftp.sh    201=
3-01-09 02:07:20.000000000 -0700
+++ b/ltp-full-20130109/testcases/kernel/containers/netns/par_ftp.sh    201=
3-02-20 00:32:18.000000000 -0700
@@ -32,6 +32,7 @@ TST_COUNT=3D1
export TCID
export TST_COUNT
export TST_TOTAL
+export PATH=3D$PATH:`dirname $0`
     ping -q -c 2 $IP2 > /dev/null
diff -Nurp a/ltp-full-20130109/testcases/kernel/containers/netns/rename_net=
.sh b/ltp-full-20130109/testcases/kernel/containers/netns/rename_net.sh
--- a/ltp-full-20130109/testcases/kernel/containers/netns/rename_net.sh 201=
3-01-09 02:07:20.000000000 -0700
+++ b/ltp-full-20130109/testcases/kernel/containers/netns/rename_net.sh 201=
3-02-20 00:32:59.000000000 -0700
@@ -30,6 +30,7 @@ TST_COUNT=3D1
export TCID
export TST_COUNT
export TST_TOTAL
+export PATH=3D$PATH:`dirname $0`
     # Find the free dev name
     for i in `seq 1 100`


Containers testcase is passed with mentioned above code changes.


Could you please let me know that above code changes are valid or not ? Ple=
ase suggest me if there are any other solutions to resolve above error.

Any help would be appreciated !!!!

Thanks,
Bhushan


--_000_C4EE7EE7BE404C459168BE7FE14AF346BF484BG2W2430americashp_
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
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">Hi All,
<br>
<br>
</span><b><span style=3D"font-size:12.0pt;font-family:&quot;Courier New&quo=
t;">Description of problem:<o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;"><br>
I am getting error while running&nbsp;&nbsp;</span>containers &nbsp;&nbsp;f=
rom &nbsp;LTP <span style=3D"font-size:10.0pt;font-family:&quot;Courier New=
&quot;">
&nbsp;Kernel stress test case,&nbsp;from LTP version&nbsp; 20120903 (ltp-fu=
ll-20120903.tar) i.e.&nbsp;on Linux 3.2 kernel. Below are the outputs for e=
rror.<br>
<br>
</span><b><span style=3D"font-size:12.0pt">containers from LTP stress &nbsp=
;fails</span></b><b><span style=3D"font-size:12.0pt;font-family:&quot;Couri=
er New&quot;"><br>
</span></b><span style=3D"font-size:10.0pt;font-family:&quot;Courier New&qu=
ot;"><br>
Containers&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FAIL&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 1<br>
<br>
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">Below are the cause for failing above mentioned testcase:<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;"><br>
child.sh: line 38: tst_resm: command not found<br>
/opt/ltp/testcases/bin/child_2.sh: line 65: tst_resm: command not found<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">/opt/ltp/testcases/bin/child_1.sh: line 71: tst_resm: comm=
and not found<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">rename_net.sh: line 50: tst_resm: command not found<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">/opt/ltp/testcases/bin/childipv6.sh: line 72: tst_resm: co=
mmand not found<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">parentns.sh&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
Pinging ChildNS from ParentNS<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">Error: Can't cd<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">ch_ftp.sh: line 40: tst_resm: command not found<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">Error while running the script<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;"><br>
<br>
</span><b><span style=3D"font-size:12.0pt">Suggested Code changes:</span></=
b><span style=3D"font-size:10.0pt;font-family:&quot;Courier New&quot;"><br>
<br>
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;"><b>Below are the code change=
s:<br>
</b><br>
diff -Nurp a/ltp-full-20130109/testcases/kernel/containers/netns/ch_ftp.sh =
b/ltp-full-20130109/testcases/kernel/containers/netns/ch_ftp.sh<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">--- a/ltp-full-20130109/test=
cases/kernel/containers/netns/ch_ftp.sh&nbsp;&nbsp;&nbsp;&nbsp; 2013-01-09 =
02:07:20.000000000 -0700<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">&#43;&#43;&#43; b/ltp-full-2=
0130109/testcases/kernel/containers/netns/ch_ftp.sh&nbsp;&nbsp;&nbsp;&nbsp;=
 2013-02-20 00:48:58.000000000 -0700<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">@@ -27,6 &#43;27,7 @@ TST_CO=
UNT=3D1<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">export TCID<o:p></o:p></span=
></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">export TST_COUNT<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">export TST_TOTAL<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">&#43;export PATH=3D$PATH:`di=
rname $0`<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;ping -q -c 2 $IP1 &gt; /dev/null<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">&nbsp;&nbsp;&nbsp;&nbsp; if =
[ $? -ne 0 ] ; then<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">diff -Nurp a/ltp-full-201301=
09/testcases/kernel/containers/netns/child_1.sh b/ltp-full-20130109/testcas=
es/kernel/containers/netns/child_1.sh<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">--- a/ltp-full-20130109/test=
cases/kernel/containers/netns/child_1.sh&nbsp;&nbsp;&nbsp; 2013-01-09 02:07=
:20.000000000 -0700<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">&#43;&#43;&#43; b/ltp-full-2=
0130109/testcases/kernel/containers/netns/child_1.sh&nbsp;&nbsp;&nbsp; 2013=
-02-20 00:27:14.000000000 -0700<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">@@ -28,6 &#43;28,7 @@ TST_CO=
UNT=3D1<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">export TCID<o:p></o:p></span=
></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">export TST_COUNT<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">export TST_TOTAL<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">&#43;export PATH=3D$PATH:`di=
rname $0`<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">&nbsp;. initialize.sh<o:p></=
o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">status=3D0<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">diff -Nurp a/ltp-full-201301=
09/testcases/kernel/containers/netns/child_2.sh b/ltp-full-20130109/testcas=
es/kernel/containers/netns/child_2.sh<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">--- a/ltp-full-20130109/test=
cases/kernel/containers/netns/child_2.sh&nbsp;&nbsp;&nbsp; 2013-01-09 02:07=
:20.000000000 -0700<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">&#43;&#43;&#43; b/ltp-full-2=
0130109/testcases/kernel/containers/netns/child_2.sh&nbsp;&nbsp;&nbsp; 2013=
-02-20 00:28:36.000000000 -0700<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">@@ -28,6 &#43;28,7 @@ TST_CO=
UNT=3D1<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">export TCID<o:p></o:p></span=
></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">export TST_COUNT<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">export TST_TOTAL<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">&#43;export PATH=3D$PATH:`di=
rname $0`<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">. initialize.sh<o:p></o:p></=
span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">status=3D0<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">diff -Nurp a/ltp-full-201301=
09/testcases/kernel/containers/netns/childipv6.sh b/ltp-full-20130109/testc=
ases/kernel/containers/netns/childipv6.sh<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">--- a/ltp-full-20130109/test=
cases/kernel/containers/netns/childipv6.sh&nbsp; 2013-01-09 02:07:20.000000=
000 -0700<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">&#43;&#43;&#43; b/ltp-full-2=
0130109/testcases/kernel/containers/netns/childipv6.sh&nbsp; 2013-02-20 00:=
29:38.000000000 -0700<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">@@ -37,6 &#43;37,7 @@ TST_CO=
UNT=3D1<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">export TCID<o:p></o:p></span=
></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">export TST_COUNT<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">export TST_TOTAL<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">&#43;export PATH=3D$PATH:`di=
rname $0`<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">.&nbsp; initialize.sh<o:p></=
o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">status=3D0<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">diff -Nurp a/ltp-full-201301=
09/testcases/kernel/containers/netns/childns.sh b/ltp-full-20130109/testcas=
es/kernel/containers/netns/childns.sh<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">--- a/ltp-full-20130109/test=
cases/kernel/containers/netns/childns.sh&nbsp;&nbsp;&nbsp; 2013-01-09 02:07=
:20.000000000 -0700<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">&#43;&#43;&#43; b/ltp-full-2=
0130109/testcases/kernel/containers/netns/childns.sh&nbsp;&nbsp;&nbsp; 2013=
-02-20 00:30:28.000000000 -0700<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">@@ -33,6 &#43;33,7 @@<o:p></=
o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;"># The test case ID, the test=
 case count and the total number of test case<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">&nbsp;export TCID=3D${TCID:-=
childns.sh}<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">&#43;export PATH=3D$PATH:`di=
rname $0`<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">. cmdlib.sh<o:p></o:p></span=
></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">exists awk grep ip ping sshd=
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">. initialize.sh<o:p></o:p></=
span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">diff -Nurp a/ltp-full-201301=
09/testcases/kernel/containers/netns/container_ftp.pl b/ltp-full-20130109/t=
estcases/kernel/containers/netns/container_ftp.pl<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">--- a/ltp-full-20130109/test=
cases/kernel/containers/netns/container_ftp.pl&nbsp;&nbsp;&nbsp; 2013-01-09=
 02:07:20.000000000 -0700<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">&#43;&#43;&#43; b/ltp-full-2=
0130109/testcases/kernel/containers/netns/container_ftp.pl&nbsp;&nbsp;&nbsp=
; 2013-02-20 00:34:24.000000000 -0700<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">@@ -36,8 &#43;36,8 @@ my $i =
=3D 0;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">my $kount =3D 51;<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">my $file=3D&quot;junkfile&qu=
ot;;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">-my $tmpdir =3D &quot;/var/f=
tp&quot;;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">-<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">&#43;#my $tmpdir =3D &quot;/=
var/ftp&quot;;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">&#43;my $tmpdir =3D &quot;/h=
ome/ftp&quot;;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">my $dir;<o:p></o:p></span></=
p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">$dir =3D tempdir(&quot;conta=
iner_ftp.XXXXXXX&quot;, DIR =3D&gt; $tmpdir);<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">if (!defined($dir)) {<o:p></=
o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">diff -Nurp a/ltp-full-201301=
09/testcases/kernel/containers/netns/par_ftp.sh b/ltp-full-20130109/testcas=
es/kernel/containers/netns/par_ftp.sh<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">--- a/ltp-full-20130109/test=
cases/kernel/containers/netns/par_ftp.sh&nbsp;&nbsp;&nbsp; 2013-01-09 02:07=
:20.000000000 -0700<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">&#43;&#43;&#43; b/ltp-full-2=
0130109/testcases/kernel/containers/netns/par_ftp.sh&nbsp;&nbsp;&nbsp; 2013=
-02-20 00:32:18.000000000 -0700<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">@@ -32,6 &#43;32,7 @@ TST_CO=
UNT=3D1<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">export TCID<o:p></o:p></span=
></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">export TST_COUNT<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">export TST_TOTAL<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">&#43;export PATH=3D$PATH:`di=
rname $0`<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;ping -q -c 2 $IP2 &gt; /dev/null<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">diff -Nurp a/ltp-full-201301=
09/testcases/kernel/containers/netns/rename_net.sh b/ltp-full-20130109/test=
cases/kernel/containers/netns/rename_net.sh<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">--- a/ltp-full-20130109/test=
cases/kernel/containers/netns/rename_net.sh 2013-01-09 02:07:20.000000000 -=
0700<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">&#43;&#43;&#43; b/ltp-full-2=
0130109/testcases/kernel/containers/netns/rename_net.sh 2013-02-20 00:32:59=
.000000000 -0700<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">@@ -30,6 &#43;30,7 @@ TST_CO=
UNT=3D1<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">export TCID<o:p></o:p></span=
></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">export TST_COUNT<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">export TST_TOTAL<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">&#43;export PATH=3D$PATH:`di=
rname $0`<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;# Find the free dev name<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;">&nbsp;&nbsp;&nbsp;&nbsp; for=
 i in `seq 1 100`<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;"><br>
Containers testcase is passed with mentioned above code changes.<br>
<br>
<br>
Could you please let me know that above code changes are valid or not ? Ple=
ase suggest me if there are any other solutions to resolve above error.<br>
<br>
Any help would be appreciated !!!!<br>
<br>
Thanks,<br>
Bhushan<br>
<br>
<o:p></o:p></span></p>
</div>
</body>
</html>

--_000_C4EE7EE7BE404C459168BE7FE14AF346BF484BG2W2430americashp_--


--===============2311382393783865261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_feb
--===============2311382393783865261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2311382393783865261==--

