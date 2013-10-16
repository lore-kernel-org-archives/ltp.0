Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <B25230@freescale.com>) id 1VWJg4-00020C-QF
	for ltp-list@lists.sourceforge.net; Wed, 16 Oct 2013 05:29:48 +0000
Received: from mail-db8lp0185.outbound.messaging.microsoft.com
	([213.199.154.185] helo=db8outboundpool.messaging.microsoft.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1VWJg2-0001Ym-Jo
	for ltp-list@lists.sourceforge.net; Wed, 16 Oct 2013 05:29:48 +0000
Received: from mail166-db8 (localhost [127.0.0.1])	by
	mail166-db8-R.bigfish.com (Postfix) with ESMTP id 512D4A800F9	for
	<ltp-list@lists.sourceforge.net>; Wed, 16 Oct 2013 05:29:40 +0000 (UTC)
Received: from DB8EHSMHS008.bigfish.com (unknown [10.174.8.230])	by
	mail166-db8.bigfish.com (Postfix) with ESMTP id D13026C0041	for
	<ltp-list@lists.sourceforge.net>; Wed, 16 Oct 2013 05:29:38 +0000 (UTC)
From: Liao Guoqi-B25230 <B25230@freescale.com>
Date: Wed, 16 Oct 2013 05:29:36 +0000
Message-ID: <9C261B4871671149A8D67C0E65957391507046@039-SN1MPN1-003.039d.mgd.msft.net>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] "cpu_hotplug/functional/cpuhotplug05.sh" failed
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6652679000748833590=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--===============6652679000748833590==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_9C261B4871671149A8D67C0E65957391507046039SN1MPN1003039d_"

--_000_9C261B4871671149A8D67C0E65957391507046039SN1MPN1003039d_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All:

When I run cpuhotplug05 cases on our platform(powerpc), it failed:
Name:   cpuhotplug05
Date:   Wed Oct 16 10:49:31 UTC 2013
Desc:   Does sar behave properly during CPU hotplug events?

CPU is 1
cpuhotplug05    1  TFAIL  :  CPU1 Not Found on SAR!

After some investigation:

the following code:

        while ! grep -iq nan $TMP/log_$$; do

                tst_resm TFAIL "CPU${CPU_TO_TEST} Not Found on SAR!"

                exit_clean 1

        done

root cause:
output of command "sar" has been changed, the log from "sar" output did NOT=
 include "nan".

Enrionment:
Sysstat version: 10.1.4
Ltp version: 20130109-r0

B.R.
Guoqi



--_000_9C261B4871671149A8D67C0E65957391507046039SN1MPN1003039d_
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
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
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
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:727192186;
	mso-list-type:hybrid;
	mso-list-template-ids:-1683727714 67698703 67698713 67698715 67698703 6769=
8713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi All:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">When I run cpuhotplug05 cases on our platform(powerp=
c), it failed:<o:p></o:p></p>
<p class=3D"MsoNormal">Name:&nbsp;&nbsp; cpuhotplug05<o:p></o:p></p>
<p class=3D"MsoNormal">Date:&nbsp;&nbsp; Wed Oct 16 10:49:31 UTC 2013<o:p><=
/o:p></p>
<p class=3D"MsoNormal">Desc:&nbsp;&nbsp; Does sar behave properly during CP=
U hotplug events?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">CPU is 1<o:p></o:p></p>
<p class=3D"MsoNormal">cpuhotplug05&nbsp;&nbsp;&nbsp; 1&nbsp; TFAIL&nbsp; :=
&nbsp; CPU1 Not Found on SAR!<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">After some investigation:<o:p></o:p></p>
<p class=3D"MsoListParagraph">the following code:<o:p></o:p></p>
<p class=3D"MsoListParagraph">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wh=
ile ! grep -iq <span style=3D"color:red">nan</span> $TMP/log_$$; do<o:p></o=
:p></p>
<p class=3D"MsoListParagraph">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tst_resm TFAIL &quot;CPU${CPU=
_TO_TEST} Not Found on SAR!&quot;<o:p></o:p></p>
<p class=3D"MsoListParagraph">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exit_clean 1<o:p></o:p></p>
<p class=3D"MsoListParagraph">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do=
ne<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">root cause:<o:p></o:p></p>
<p class=3D"MsoNormal">output of command &#8220;sar&#8221; has been changed=
, the log from &#8220;sar&#8221; output did NOT include &#8220;nan&#8221;.<=
o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Enrionment:<o:p></o:p></p>
<p class=3D"MsoNormal">Sysstat version: 10.1.4<o:p></o:p></p>
<p class=3D"MsoNormal">Ltp version: 20130109-r0<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">B.R.<o:p></o:p></p>
<p class=3D"MsoNormal">Guoqi<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_9C261B4871671149A8D67C0E65957391507046039SN1MPN1003039d_--


--===============6652679000748833590==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135031&iu=/4140/ostg.clktrk
--===============6652679000748833590==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6652679000748833590==--

