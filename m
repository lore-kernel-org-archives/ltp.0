Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <y_yao@ryobi.co.jp>) id 1NeIwk-000865-Jc
	for ltp-list@lists.sourceforge.net; Mon, 08 Feb 2010 02:01:54 +0000
Received: from out05.sjc.mx.trendmicro.com ([216.99.131.18])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NeIwi-0000Ll-IX
	for ltp-list@lists.sourceforge.net; Mon, 08 Feb 2010 02:01:54 +0000
Received: from out07.sjc.mx.trendmicro.com (unknown [216.99.131.23])
	by out05.sjc.mx.trendmicro.com (Postfix) with ESMTP id ACD3239DAFC
	for <ltp-list@lists.sourceforge.net>;
	Mon,  8 Feb 2010 01:33:04 +0000 (UTC)
Received: from relay03.sjc.mx.trendmicro.com (unknown [10.30.239.5])
	by out07.sjc.mx.trendmicro.com (Postfix) with ESMTP id 1E1A1B7A458
	for <ltp-list@lists.sourceforge.net>;
	Mon,  8 Feb 2010 01:33:04 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay03.sjc.mx.trendmicro.com (Postfix) with ESMTP id 2160C3DD020
	for <ltp-list@lists.sourceforge.net>;
	Mon,  8 Feb 2010 01:33:02 +0000 (UTC)
Received: from 5108637 ([10.113.10.201]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Mon, 8 Feb 2010 10:33:00 +0900
From: "Yuki Yao" <y_yao@ryobi.co.jp>
Date: Mon, 8 Feb 2010 10:33:00 +0900
Message-ID: <000001caa85e$a6855ab0$f3901010$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] [PATCH]logrotate: /var/log/messages* disappeared
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0475950240629306715=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0475950240629306715==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0001_01CAA8AA.166D02B0"
Content-Language: ja

This is a multi-part message in MIME format.

------=_NextPart_000_0001_01CAA8AA.166D02B0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

 

I found a problem on LTP when I execute ./runltp.

After execute ./runltp, all log files such as /var/log/messages*
disappeared, 

and there is only new log files that were created after the test...

 

This seems a problem that occurs after the "logrotate01" test. 

I found that the past log files disappeared by forcing a rotate (logrotate
-fv $LTPTMP/tst_logrotate.conf).

 

Besides, "logrotate"'s shell script
./testcases/commands/logrotate/logrotate_tests.sh creats 

logrotate configuration file ($LTPTMP/tst_logrotate.conf) for the test, and
this config file includes 

/etc/logrotate.d as follows:

[ ./testcases/commands/logrotate/logrotate_tests.sh line:156~ ]

----------

# create config file.

              cat >$LTPTMP/tst_logrotate.conf <<-EOF

              #****** Begin Config file *******

              # create new (empty) log files after rotating old ones

              create

 

              # compress the log files

              compress

 

              # RPM packages drop log rotation information into this
directory

              include /etc/logrotate.d

 

              /var/log/tst_logfile {

                            rotate 5

                            weekly

              }

              #****** End Config file *******

              EOF

----------

 

By this, not only a log file for the test (/var/log/tst_logfile), but also
30 fies in my system 

such as /var/log/messages* become "logrotate" command target.

Therefore, only a log file for this test must be made a target of the forced
execution of "logrotate".

 

To resolve this problem, we have to change this not to include
/etc/logrotate.d, I think.

 

Index: testcases/commands/logrotate/logrotate_tests.sh

==============================

--- logrotate_tests.sh           2008-10-21 15:54:15.000000000 +0900

+++ logrotate_tests.sh.new  2010-02-05 18:56:14.000000000 +0900

@@ -163,7 +163,7 @@

             compress

 

             # RPM packages drop log rotation information into this
directory

-             include /etc/logrotate.d

+            # include /etc/logrotate.d

 

             /var/log/tst_logfile {

                           rotate 5

@@ -200,7 +200,7 @@

                           # check if  /etc/logrotate.d is included/

                           # check if 5 rotations are forced.

         # check if compression is done.

-                           grep "including /etc/logrotate.d"
$LTPTMP/tst_logrotate.out \

+                          # grep "including /etc/logrotate.d"
$LTPTMP/tst_logrotate.out \

                                         > $LTPTMP/tst_logrotate.err 2>&1 ||
RC=$?

                           grep "reading config file
$LTPTMP/tst_logrotate.conf" \

                                         $LTPTMP/tst_logrotate.out   >
$LTPTMP/tst_logrotate.err 2>&1 || RC=$?

 

Thank you,

  --Yuki Yao


------=_NextPart_000_0001_01CAA8AA.166D02B0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"\FF2D\FF33 \30B4\30B7\30C3\30AF";
	panose-1:2 11 6 9 7 2 5 8 2 4;}
@font-face
	{font-family:"\FF2D\FF33 \30B4\30B7\30C3\30AF";
	panose-1:2 11 6 9 7 2 5 8 2 4;}
@font-face
	{font-family:"\@\FF2D\FF33 \30B4\30B7\30C3\30AF";
	panose-1:2 11 6 9 7 2 5 8 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0mm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Arial","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.17
	{mso-style-type:personal-compose;
	font-family:"Arial","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
 /* Page Definitions */
 @page Section1
	{size:612.0pt 792.0pt;
	margin:99.25pt 30.0mm 30.0mm 30.0mm;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026">
  <v:textbox inset=3D"5.85pt,.7pt,5.85pt,.7pt" />
 </o:shapedefaults></xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DJA link=3Dblue vlink=3Dpurple =
style=3D'text-justify-trim:punctuation'>

<div class=3DSection1>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>Hi,<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt'>I =
found a problem
on LTP when I execute ./runltp.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt'>After =
execute
./runltp, all log files such as /var/log/messages* disappeared, =
<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt'>and =
there is only
new log files that were created after the test...<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt'>This =
seems a
problem that occurs after the &quot;logrotate01&quot; test. =
<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt'>I =
found that the
past log files disappeared by forcing a rotate (logrotate -fv
$LTPTMP/tst_logrotate.conf).<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>Besides,
&quot;logrotate&quot;'s shell script
./testcases/commands/logrotate/logrotate_tests.sh creats =
<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>logrotate
configuration file ($LTPTMP/tst_logrotate.conf) for the test, and this =
config
file includes <o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>/etc/logrotate.d
as follows:<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt'>[
./testcases/commands/logrotate/logrotate_tests.sh line:156~ =
]<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>----------<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt'># =
create config
file.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cat
&gt;$LTPTMP/tst_logrotate.conf &lt;&lt;-EOF<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #******
Begin Config file *******<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #
create new (empty) log files after rotating old =
ones<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; create<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #
compress the log files<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compress<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #
RPM packages drop log rotation information into this =
directory<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; include
/etc/logrotate.d<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /var/log/tst_logfile
{<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rotate
5<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; weekly<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #******
End Config file *******<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; EOF<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>----------<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt'>By =
this, not only
a log file for the test (/var/log/tst_logfile), but also 30 fies in my =
system <o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt'>such =
as
/var/log/messages* become &quot;logrotate&quot; command =
target.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>Therefore, only a
log file for this test must be made a target of the forced execution of
&quot;logrotate&quot;.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt'>To =
resolve this
problem, we have to change this not to include /etc/logrotate.d, I =
think.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>Index:
testcases/commands/logrotate/logrotate_tests.sh<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt'>---
logrotate_tests.sh&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 2008-10-21
15:54:15.000000000 +0900<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt'>+++
logrotate_tests.sh.new&nbsp; 2010-02-05 18:56:14.000000000 =
+0900<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt'>@@ =
-163,7 +163,7
@@<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; compress<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; #
RPM packages drop log rotation information into this =
directory<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; include
/etc/logrotate.d<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; #
include /etc/logrotate.d<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; /var/log/tst_logfile
{<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rotate
5<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt'>@@ =
-200,7 +200,7
@@<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #
check if&nbsp; /etc/logrotate.d is included/<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #
check if 5 rotations are forced.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;# check if compression is done.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; grep
&quot;including /etc/logrotate.d&quot; $LTPTMP/tst_logrotate.out =
\<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #
grep &quot;including /etc/logrotate.d&quot; $LTPTMP/tst_logrotate.out =
\<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;
$LTPTMP/tst_logrotate.err 2&gt;&amp;1 || RC=3D$?<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; grep
&quot;reading config file $LTPTMP/tst_logrotate.conf&quot; =
\<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
$LTPTMP/tst_logrotate.out&nbsp;&nbsp;
&gt; $LTPTMP/tst_logrotate.err 2&gt;&amp;1 || =
RC=3D$?<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt'>Thank =
you,<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp; --Yuki Yao<o:p></o:p></span></p>

</div>

</body>

</html>

------=_NextPart_000_0001_01CAA8AA.166D02B0--




--===============0475950240629306715==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
--===============0475950240629306715==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0475950240629306715==--



