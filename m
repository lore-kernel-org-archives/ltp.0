Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Bhushan.Kumar@mphasis.com>) id 1TXtrW-0007I9-DE
	for ltp-list@lists.sourceforge.net; Mon, 12 Nov 2012 13:15:38 +0000
Received: from mpbam6ip2.mphasis.com ([203.12.223.66])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TXtrQ-0003Mz-5W
	for ltp-list@lists.sourceforge.net; Mon, 12 Nov 2012 13:15:38 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Mon, 12 Nov 2012 18:42:49 +0530
Message-ID: <E351E450E8B9F54684A699D42DC5ADF2273FB445@MPBAGVEX02.corp.mphasis.com>
From: "Bhushan Kumar" <Bhushan.Kumar@mphasis.com>
Subject: [LTP] if6-updown test case get fail with this message ::if6-updown
	1 TBROK : Link-local address is not found at eth1 on the remote host
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0660974721634670976=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0660974721634670976==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CDC0D7.C0B71F85"

This is a multi-part message in MIME format.

------_=_NextPart_001_01CDC0D7.C0B71F85
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

 =


I am getting  error when I am running network stress test for interface
i.e. if6-updown get fails. I am adding error message below =


=3D=3D=3D=3D=3D=3D=3D

tag=3Dif6-updown stime=3D1352723357

cmdline=3D" if6-updown"

contacts=3D""

analysis=3Dexit

<<<test_output>>>

if6-updown    1  TBROK  :  Link-local address is not found at eth1 on
the remote host

incrementing stop

<<<execution_status>>>

initiation_status=3D"ok"

duration=3D1 termination_type=3Dexited termination_id=3D2 corefile=3Dno

cutime=3D5 cstime=3D4

<<<test_end>>>

INFO: ltp-pan reported some tests FAIL

LTP Version: 20120903

 =


I will be thankful for your suggestion/guidance  to fix this .

 =


Thanking you

Bhushan  =


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

------_=_NextPart_001_01CDC0D7.C0B71F85
MIME-Version: 1.0
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><meta http-equiv=3DContent-Type content=
=3D"text/html; charset=3Dus-ascii"><meta name=3DGenerator content=3D"Micros=
oft Word 12 (filtered medium)"><style><!--
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
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue vli=
nk=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal>Hi,<o:p></o:p></=
p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>I am getti=
ng &nbsp;error when I am running network stress test for interface i.e. if6=
-updown get fails. I am adding error message below <o:p></o:p></p><p class=
=3DMsoNormal>=3D=3D=3D=3D=3D=3D=3D<o:p></o:p></p><p class=3DMsoNormal>tag=
=3Dif6-updown stime=3D1352723357<o:p></o:p></p><p class=3DMsoNormal>cmdline=
=3D&quot; if6-updown&quot;<o:p></o:p></p><p class=3DMsoNormal>contacts=3D&q=
uot;&quot;<o:p></o:p></p><p class=3DMsoNormal>analysis=3Dexit<o:p></o:p></p=
><p class=3DMsoNormal>&lt;&lt;&lt;test_output&gt;&gt;&gt;<o:p></o:p></p><p =
class=3DMsoNormal>if6-updown&nbsp;&nbsp;&nbsp; 1&nbsp; TBROK&nbsp; :&nbsp; =
Link-local address is not found at eth1 on the remote host<o:p></o:p></p><p=
 class=3DMsoNormal>incrementing stop<o:p></o:p></p><p class=3DMsoNormal>&lt=
;&lt;&lt;execution_status&gt;&gt;&gt;<o:p></o:p></p><p class=3DMsoNormal>in=
itiation_status=3D&quot;ok&quot;<o:p></o:p></p><p class=3DMsoNormal>duratio=
n=3D1 termination_type=3Dexited termination_id=3D2 corefile=3Dno<o:p></o:p>=
</p><p class=3DMsoNormal>cutime=3D5 cstime=3D4<o:p></o:p></p><p class=3DMso=
Normal>&lt;&lt;&lt;test_end&gt;&gt;&gt;<o:p></o:p></p><p class=3DMsoNormal>=
INFO: ltp-pan reported some tests FAIL<o:p></o:p></p><div style=3D'mso-elem=
ent:para-border-div;border:none;border-bottom:double windowtext 2.25pt;padd=
ing:0in 0in 1.0pt 0in'><p class=3DMsoNormal style=3D'border:none;padding:0i=
n'>LTP Version: 20120903<o:p></o:p></p></div><p class=3DMsoNormal><o:p>&nbs=
p;</o:p></p><p class=3DMsoNormal>I will be thankful for your suggestion/gui=
dance &nbsp;to fix this .<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o=
:p></p><p class=3DMsoNormal>Thanking you<o:p></o:p></p><p class=3DMsoNormal=
>Bhushan &nbsp;<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p></d=
iv><p><br>
Information transmitted by this e-mail is proprietary to MphasiS, its assoc=
iated companies and/ or its customers and is intended <br>
for use only by the individual or entity to which it is addressed, and may =
contain information that is privileged, confidential or <br>
exempt from disclosure under applicable law. If you are not the intended re=
cipient or it appears that this mail has been forwarded <br>
to you without proper authority, you are notified that any use or dissemina=
tion of this information in any manner is strictly <br>
prohibited. In such cases, please notify us immediately at mailmaster@mphas=
is.com and delete this mail from your records.</p></body></html>
------_=_NextPart_001_01CDC0D7.C0B71F85--



--===============0660974721634670976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_nov
--===============0660974721634670976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0660974721634670976==--


