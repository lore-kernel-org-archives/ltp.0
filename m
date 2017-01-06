Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Senthil.K@aricent.com>) id 1cPK9g-0002B4-SK
	for ltp-list@lists.sourceforge.net; Fri, 06 Jan 2017 02:21:20 +0000
Received: from mail-ma1ind01on0053.outbound.protection.outlook.com
	([104.47.100.53] helo=IND01-MA1-obe.outbound.protection.outlook.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cPK9e-0006aD-Db
	for ltp-list@lists.sourceforge.net; Fri, 06 Jan 2017 02:21:20 +0000
From: Senthil K <Senthil.K@aricent.com>
Date: Fri, 6 Jan 2017 02:06:42 +0000
Message-ID: <MA1PR01MB05655185FD871E8503C51256F7630@MA1PR01MB0565.INDPRD01.PROD.OUTLOOK.COM>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] LTP for ARM64
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1552625041636044794=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--===============1552625041636044794==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MA1PR01MB05655185FD871E8503C51256F7630MA1PR01MB0565INDP_"

--_000_MA1PR01MB05655185FD871E8503C51256F7630MA1PR01MB0565INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,

We are using user space 32bit and kernel space 64 bit for ARMV8 platform.

We have compiled the LTP using 32 bit tool chain. Follwoing are the steps w=
e have followed

export AR=3Darm-buildroot-linux-ar
export LD=3Darm-buildroot-linux-ld
export CC=3Darm-buildroot-linux-gcc

./configure --host=3Darm-linux --target=3Darm-buildroot-linux --exec-prefix=
=3D/home/
make
make install.

The compilation was successful.

We are observing that there are more failures due to "getpwnam(nobody)" - E=
NOENT.

We have added the  nobody entry in /etc/passwd file but still we are gettin=
g the issue.

Please share your inputs.



Senthil K









"DISCLAIMER: This message is proprietary to Aricent and is intended solely =
for the use of the individual to whom it is addressed. It may contain privi=
leged or confidential information and should not be circulated or used for =
any purpose other than for what it is intended. If you have received this m=
essage in error, please notify the originator immediately. If you are not t=
he intended recipient, you are notified that you are strictly prohibited fr=
om using, copying, altering, or disclosing the contents of this message. Ar=
icent accepts no responsibility for loss or damage arising from the use of =
the information transmitted by this email including damage from virus."

--_000_MA1PR01MB05655185FD871E8503C51256F7630MA1PR01MB0565INDP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" xmlns:m=3D"http://schema=
s.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html=
40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Helvetica;
	panose-1:2 11 6 4 2 2 2 2 2 4;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
9.5pt;font-family:&quot;Arial&quot;,sans-serif;color:#222222">Hi All,<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
9.5pt;font-family:&quot;Arial&quot;,sans-serif;color:#222222"><o:p>&nbsp;</=
o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
9.5pt;font-family:&quot;Arial&quot;,sans-serif;color:#222222">We are using =
user space 32bit and kernel space 64 bit for ARMV8 platform.<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
9.5pt;font-family:&quot;Arial&quot;,sans-serif;color:#222222"><o:p>&nbsp;</=
o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
9.5pt;font-family:&quot;Arial&quot;,sans-serif;color:#222222">We have compi=
led the LTP using 32 bit tool chain. Follwoing are the steps we have follow=
ed<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
9.5pt;font-family:&quot;Arial&quot;,sans-serif;color:#222222"><o:p>&nbsp;</=
o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
9.5pt;font-family:&quot;Arial&quot;,sans-serif;color:#222222">export AR=3Da=
rm-buildroot-linux-ar<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
9.5pt;font-family:&quot;Arial&quot;,sans-serif;color:#222222">export LD=3Da=
rm-buildroot-linux-ld<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
9.5pt;font-family:&quot;Arial&quot;,sans-serif;color:#222222">export CC=3Da=
rm-buildroot-linux-gcc<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
9.5pt;font-family:&quot;Arial&quot;,sans-serif;color:#222222"><o:p>&nbsp;</=
o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
9.5pt;font-family:&quot;Arial&quot;,sans-serif;color:#222222">./configure -=
-host=3Darm-linux --target=3Darm-buildroot-linux --exec-prefix=3D/home/<o:p=
></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
9.5pt;font-family:&quot;Arial&quot;,sans-serif;color:#222222">make&nbsp;<o:=
p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
9.5pt;font-family:&quot;Arial&quot;,sans-serif;color:#222222">make install.=
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
9.5pt;font-family:&quot;Arial&quot;,sans-serif;color:#222222"><o:p>&nbsp;</=
o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
9.5pt;font-family:&quot;Arial&quot;,sans-serif;color:#222222">The compilati=
on was successful.&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
9.5pt;font-family:&quot;Arial&quot;,sans-serif;color:#222222"><o:p>&nbsp;</=
o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
9.5pt;font-family:&quot;Arial&quot;,sans-serif;color:#222222">We are observ=
ing that there are more failures due to &quot;getpwnam(nobody)&quot; - ENOE=
NT.&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
9.5pt;font-family:&quot;Arial&quot;,sans-serif;color:#222222"><o:p>&nbsp;</=
o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
9.5pt;font-family:&quot;Arial&quot;,sans-serif;color:#222222">We have added=
 the &nbsp;nobody entry in /etc/passwd file but still we are getting the is=
sue.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
9.5pt;font-family:&quot;Arial&quot;,sans-serif;color:#222222"><o:p>&nbsp;</=
o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
9.5pt;font-family:&quot;Arial&quot;,sans-serif;color:#222222">Please share =
your inputs.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
9.5pt;font-family:&quot;Arial&quot;,sans-serif;color:#222222">&nbsp;<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<table class=3D"MsoNormalTable" border=3D"0" cellspacing=3D"0" cellpadding=
=3D"0" width=3D"100%" style=3D"width:100.0%">
<tbody>
<tr>
<td style=3D"padding:3.75pt 0in 3.75pt 0in">
<p class=3D"MsoNormal" style=3D"line-height:115%"><b><span style=3D"font-si=
ze:9.0pt;line-height:115%;font-family:&quot;Helvetica&quot;,sans-serif">Sen=
thil K</span></b><span style=3D"font-size:9.0pt;line-height:115%;font-famil=
y:&quot;Helvetica&quot;,sans-serif"><o:p></o:p></span></p>
</td>
</tr>
<tr>
<td style=3D"padding:3.75pt 0in 3.75pt 0in">
<p class=3D"MsoNormal" style=3D"line-height:115%"><span style=3D"font-size:=
9.0pt;line-height:115%;font-family:&quot;Helvetica&quot;,sans-serif"><o:p>&=
nbsp;</o:p></span></p>
</td>
</tr>
<tr>
<td style=3D"padding:3.75pt 0in 3.75pt 0in">
<p class=3D"MsoNormal" style=3D"line-height:115%"><span style=3D"font-size:=
9.0pt;line-height:115%;font-family:&quot;Helvetica&quot;,sans-serif"><o:p>&=
nbsp;</o:p></span></p>
</td>
</tr>
<tr>
<td style=3D"padding:3.75pt 0in 3.75pt 0in">
<p class=3D"MsoNormal" style=3D"line-height:115%"><span style=3D"font-size:=
9.0pt;line-height:115%;font-family:&quot;Helvetica&quot;,sans-serif"><o:p>&=
nbsp;</o:p></span></p>
</td>
</tr>
</tbody>
</table>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
&quot;DISCLAIMER: This message is proprietary to Aricent and is intended so=
lely for the use of the individual to whom it is addressed. It may contain =
privileged or confidential information and should not be circulated or used=
 for any purpose other than for what
 it is intended. If you have received this message in error, please notify =
the originator immediately. If you are not the intended recipient, you are =
notified that you are strictly prohibited from using, copying, altering, or=
 disclosing the contents of this
 message. Aricent accepts no responsibility for loss or damage arising from=
 the use of the information transmitted by this email including damage from=
 virus.&quot;
</body>
</html>

--_000_MA1PR01MB05655185FD871E8503C51256F7630MA1PR01MB0565INDP_--


--===============1552625041636044794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
--===============1552625041636044794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1552625041636044794==--

