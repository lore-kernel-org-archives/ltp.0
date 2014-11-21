Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <raju.biswas@samsung.com>) id 1XriRA-0006VO-SY
	for ltp-list@lists.sourceforge.net; Fri, 21 Nov 2014 07:15:24 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1XriR7-0000YT-KD
	for ltp-list@lists.sourceforge.net; Fri, 21 Nov 2014 07:15:24 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0NFD0062EO5EVC80@mailout4.samsung.com> for
	ltp-list@lists.sourceforge.net; Fri, 21 Nov 2014 16:15:14 +0900 (KST)
From: Raju <raju.biswas@samsung.com>
References: 
In-reply-to: 
Date: Fri, 21 Nov 2014 12:45:41 +0530
Message-id: <001301d0055a$fb71a930$f254fb90$@samsung.com>
MIME-version: 1.0
Content-language: en-us
Subject: [LTP] Need help to run LTP on Android
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4661717643613383477=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net, manjo@mail.utexas.edu, robbiew@us.ibm.com, subrata@linuc.vnet.ibm.com

This is a multipart message in MIME format.

--===============4661717643613383477==
Content-type: multipart/alternative;
	boundary="----=_NextPart_000_0014_01D00589.152B6BD0"
Content-language: en-us

This is a multipart message in MIME format.

------=_NextPart_000_0014_01D00589.152B6BD0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello All,

 

I have build the LTP source code using the following steps.

 

Set all the env variables to cross compile with tool chain. 

 

After that used the command to configure.

 

./configure AR=arm-none-linux-gnueabi-ar CC=arm-none-linux-gnueabi-gcc
RANLIB=arm-none-linux-gnueabi-ranlib STRIP=arm-none-linux-gnueabi-strip
--host=arm-linux --target=arm-linux

 

Then did ,

make all

make install  

 

Then I copied all the installed in output directory via adb push to
/data/ltp folder.

 

Later to execute the LTP we issued command. 

 

export PATH=/data/ltp:$PATH

export PATH=/data/ltp/testcases/bin:$PATH

export PATH=/data/ltp/runtest:$PATH

 

sh ./runltp -p -l /data/ltp/result.log -o /data/ltp/result-output.log -d
/data/ltp/tmp 

 

When I execute it , it gives me error.

 

root@kanas:/data/ltp # ./runltp -p -l test.log -o test.log  -d /data/ltp/tmp

./runltp -p -l test.log -o test.log  -d /data/ltp/tmp

./runltp[999]: basename: not found

root@kanas:/data/ltp #

 

Can u please suggest me if if I am doing anything wrong that I am getting
this error.  Request your help. If you need any more info please respond
this this e-mail.

 

Regards,

Raju


------=_NextPart_000_0014_01D00589.152B6BD0
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
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
All,<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>I have build the LTP source code using the following =
steps.<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Set all the env variables to cross compile with tool =
chain. <o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>After that used the command to =
configure.<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>./configure AR=3Darm-none-linux-gnueabi-ar =
CC=3Darm-none-linux-gnueabi-gcc RANLIB=3Darm-none-linux-gnueabi-ranlib =
STRIP=3Darm-none-linux-gnueabi-strip --host=3Darm-linux =
--target=3Darm-linux<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Then did =
,<o:p></o:p></p><p class=3DMsoNormal>make all<o:p></o:p></p><p =
class=3DMsoNormal>make install &nbsp;<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Then I =
copied all the installed in output directory via adb push to /data/ltp =
folder.<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Later to execute the LTP we issued command. =
<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>export PATH=3D/data/ltp:$PATH<o:p></o:p></p><p =
class=3DMsoNormal>export =
PATH=3D/data/ltp/testcases/bin:$PATH<o:p></o:p></p><p =
class=3DMsoNormal>export PATH=3D/data/ltp/runtest:$PATH<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>sh ./runltp =
-p -l /data/ltp/result.log -o /data/ltp/result-output.log -d =
/data/ltp/tmp <o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>When I =
execute it , it gives me error.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal><b>root@kanas:/data/ltp # ./runltp -p -l test.log -o =
test.log&nbsp; -d /data/ltp/tmp<o:p></o:p></b></p><p =
class=3DMsoNormal><b>./runltp -p -l test.log -o test.log&nbsp; -d =
/data/ltp/tmp<o:p></o:p></b></p><p class=3DMsoNormal><b>./runltp[999]: =
basename: not found<o:p></o:p></b></p><p =
class=3DMsoNormal><b>root@kanas:/data/ltp #<o:p></o:p></b></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Can u please =
suggest me if if I am doing anything wrong that I am getting this error. =
&nbsp;Request your help. If you need any more info please respond this =
this e-mail.<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Regards,<o:p></o:p></p><p =
class=3DMsoNormal>Raju<o:p></o:p></p></div></body></html>
------=_NextPart_000_0014_01D00589.152B6BD0--



--===============4661717643613383477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
--===============4661717643613383477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4661717643613383477==--


