Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <raju.biswas@samsung.com>) id 1Yb66o-0002iq-BG
	for ltp-list@lists.sourceforge.net; Thu, 26 Mar 2015 11:37:58 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Yb66m-0004Kn-3i
	for ltp-list@lists.sourceforge.net; Thu, 26 Mar 2015 11:37:58 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NLT007AYHN0TRB0@mailout4.samsung.com> for
	ltp-list@lists.sourceforge.net; Thu, 26 Mar 2015 20:37:48 +0900 (KST)
Received: from rajub ([107.109.154.185])
	by mmp1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
	64bit
	(built May 5 2014)) with ESMTPA id <0NLT00246HMX6Z50@mmp1.samsung.com>
	for
	ltp-list@lists.sourceforge.net; Thu, 26 Mar 2015 20:37:48 +0900 (KST)
From: Raju <raju.biswas@samsung.com>
Date: Thu, 26 Mar 2015 17:09:03 +0530
Message-id: <001401d067b9$7788d050$669a70f0$@samsung.com>
MIME-version: 1.0
Content-language: en-us
Subject: [LTP] Error in IPC test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5448701520587050649=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multipart message in MIME format.

--===============5448701520587050649==
Content-type: multipart/alternative;
	boundary="----=_NextPart_000_0015_01D067E7.91504E90"
Content-language: en-us

This is a multipart message in MIME format.

------=_NextPart_000_0015_01D067E7.91504E90
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello All,

 

I ran the "message_queue_test_01" test and I am getting this below error.

 

message_queue_test_01: IPC Message Queue TestSuite program

 

        Create message queue, id: 0x00010002

Forking : -1093515576

I am in child process

 

        Child:  received message queue id: 65538

 

        Child:  sending message:  "message queue transmission test...." and
msqid = 65538

ERROR [line: 227] msgsnd failed: Permission denied

 

Does anyone have any idea of that.

 

Regards,

Raju


------=_NextPart_000_0015_01D067E7.91504E90
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
All,<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>I ran the &#8220;message_queue_test_01&#8221; test and =
I am getting this below error.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal><b>message_queue_test_01: IPC Message Queue TestSuite =
program<o:p></o:p></b></p><p =
class=3DMsoNormal><b><o:p>&nbsp;</o:p></b></p><p =
class=3DMsoNormal><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Create =
message queue, id: 0x00010002<o:p></o:p></b></p><p =
class=3DMsoNormal><b>Forking : -1093515576<o:p></o:p></b></p><p =
class=3DMsoNormal><b>I am in child process<o:p></o:p></b></p><p =
class=3DMsoNormal><b><o:p>&nbsp;</o:p></b></p><p =
class=3DMsoNormal><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Child:&nbsp; received message queue id: 65538<o:p></o:p></b></p><p =
class=3DMsoNormal><b><o:p>&nbsp;</o:p></b></p><p =
class=3DMsoNormal><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Child:&nbsp; sending message:&nbsp; &quot;message queue transmission =
test....&quot; and msqid =3D 65538<o:p></o:p></b></p><p =
class=3DMsoNormal><b>ERROR [line: 227] msgsnd failed: Permission =
denied<o:p></o:p></b></p><p =
class=3DMsoNormal><b><o:p>&nbsp;</o:p></b></p><p class=3DMsoNormal>Does =
anyone have any idea of that.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Regards,<o:p></o:p></p><p =
class=3DMsoNormal>Raju<b><o:p></o:p></b></p></div></body></html>
------=_NextPart_000_0015_01D067E7.91504E90--



--===============5448701520587050649==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
--===============5448701520587050649==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5448701520587050649==--


