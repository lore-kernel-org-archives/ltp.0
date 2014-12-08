Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <raju.biswas@samsung.com>) id 1XxttD-0004Wa-2T
	for ltp-list@lists.sourceforge.net; Mon, 08 Dec 2014 08:41:55 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1XxttA-0003gl-PG
	for ltp-list@lists.sourceforge.net; Mon, 08 Dec 2014 08:41:55 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0NG9007HK9HKFR20@mailout2.samsung.com> for
	ltp-list@lists.sourceforge.net; Mon, 08 Dec 2014 17:41:44 +0900 (KST)
Received: from rajub ([107.109.154.185])
	by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
	(7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTPA id <0NG900A359HH9W10@mmp1.samsung.com> for
	ltp-list@lists.sourceforge.net; Mon, 08 Dec 2014 17:41:44 +0900 (KST)
From: Raju <raju.biswas@samsung.com>
Date: Mon, 08 Dec 2014 14:12:20 +0530
Message-id: <001701d012c2$e2ae8d30$a80ba790$@samsung.com>
MIME-version: 1.0
Content-language: en-us
Subject: [LTP] How to compile indiviual packages/modules in LTP
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5680552162453105706=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multipart message in MIME format.

--===============5680552162453105706==
Content-type: multipart/alternative;
	boundary="----=_NextPart_000_0018_01D012F0.FC684FD0"
Content-language: en-us

This is a multipart message in MIME format.

------=_NextPart_000_0018_01D012F0.FC684FD0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Sir,

 

There are lot of test suit modules / packages currently under LTP.

Examples :

 

/ltp-full-20140828/testcases/commands/

 

ade  at  cpio  cron  eject  fileutils  gzip  logrotate  mail  Makefile  sssd
su  tar  tpm-tools  unzip

 

/ltp-full-20140828/testcases/kernel

 

connectors  controllers     firmware  hotplug  io   lib      Makefile  mem
numa              pty    security  timers

containers  device-drivers  fs        include  ipc  logging  mce-test
module  power_management  sched  syscalls  tracing

 

etc.

 

Currently we have option to compile the whole LTP package. But suppose I do
not want some modules to get compiled Ex. Ade , gzip , security , timers etc
, but compile the rest of the LTP test suit. How can I do it ?

 

I do not want to whole LTP to get compiled but compile only the selected
test package.  How can I select the packages to compile.  It is just like we
do not compile the complete kernel but compile what is required for our
need. Similar to that how can we compile what we need and not the complete
package. 

 

Request help to compile selected package in LTP. 

 

Regards,

Raju Biswas

 


------=_NextPart_000_0018_01D012F0.FC684FD0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><META =
HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 14 =
(filtered medium)"><style><!--
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
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
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
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue =
vlink=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal>Hello =
Sir,<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>There are lot of test suit modules / packages =
currently under LTP.<o:p></o:p></p><p class=3DMsoNormal>Examples =
:<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal><b>/ltp-full-20140828/testcases/commands/<o:p></o:p></b=
></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal><b>ade&nbsp; at&nbsp; cpio&nbsp; cron&nbsp; =
eject&nbsp; fileutils&nbsp; gzip&nbsp; logrotate&nbsp; mail&nbsp; =
Makefile&nbsp; sssd&nbsp; su&nbsp; tar&nbsp; tpm-tools&nbsp; =
unzip<o:p></o:p></b></p><p =
class=3DMsoNormal><b><o:p>&nbsp;</o:p></b></p><p =
class=3DMsoNormal><b>/ltp-full-20140828/testcases/kernel<o:p></o:p></b></=
p><p class=3DMsoNormal><b><o:p>&nbsp;</o:p></b></p><p =
class=3DMsoNormal><b>connectors&nbsp; =
controllers&nbsp;&nbsp;&nbsp;&nbsp; firmware&nbsp; hotplug&nbsp; =
io&nbsp;&nbsp; lib&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Makefile&nbsp; =
mem&nbsp;&nbsp;&nbsp;&nbsp; =
numa&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; pty&nbsp;&nbsp;&nbsp; security&nbsp; =
timers<o:p></o:p></b></p><p class=3DMsoNormal><b>containers&nbsp; =
device-drivers&nbsp; fs&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
include&nbsp; ipc&nbsp; logging&nbsp; mce-test&nbsp; module&nbsp; =
power_management&nbsp; sched&nbsp; syscalls&nbsp; =
tracing<o:p></o:p></b></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>etc.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Currently we =
have option to compile the whole LTP package. But suppose I do not want =
some modules to get compiled Ex. Ade , gzip , security , timers etc , =
but compile the rest of the LTP test suit. How can I do it =
?<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>I do not want to whole LTP to get compiled but compile =
only the selected test package. &nbsp;How can I select the packages to =
compile. &nbsp;It is just like we do not compile the complete kernel but =
compile what is required for our need. Similar to that how can we =
compile what we need and not the complete package. <o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Request help =
to compile selected package in LTP. <o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Regards,<o:p></o:p></p><p class=3DMsoNormal>Raju =
Biswas<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p></div></body></html>
------=_NextPart_000_0018_01D012F0.FC684FD0--



--===============5680552162453105706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
--===============5680552162453105706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5680552162453105706==--


