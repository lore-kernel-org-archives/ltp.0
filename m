Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <pramod_gajula@infosys.com>) id 1RXYEH-0006Ee-M1
	for ltp-list@lists.sourceforge.net; Mon, 05 Dec 2011 13:05:09 +0000
Received: from kecgate02.infosys.com ([122.98.14.32])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RXYEA-0006Qg-Pl
	for ltp-list@lists.sourceforge.net; Mon, 05 Dec 2011 13:05:09 +0000
From: Pramod Gajula <pramod_gajula@infosys.com>
Date: Mon, 5 Dec 2011 18:34:28 +0530
Message-ID: <82BEC95A68153C46932D3E196B922B7217E79C0E0A@BLRKECMBX07.ad.infosys.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] LTP on IMX53 QSB Board
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1027494728633097735=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--===============1027494728633097735==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_82BEC95A68153C46932D3E196B922B7217E79C0E0ABLRKECMBX07ad_"

--_000_82BEC95A68153C46932D3E196B922B7217E79C0E0ABLRKECMBX07ad_
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I have known LTP for a month and wanted to test Linux kernel through LTP.=
 I'm blocked at the below issue. Kindly read through.

OS: Linux Kernel Version 2.6 (Ubuntu) Target Board: IMX53 QSB Board(frees=
cale) & logged in as root.

Problem:
I have mounted rootfs folder and /opt/ltp folder onto the target board an=
d executed this command

=D8  ./ltp-pan  -a $$  -n $$  ../testcases/bin/access01
Error: "Could not open zoo as "2165", errno:13 Permission denied"
(Permission is denied to even create a file.)
Suggestions are welcomed to overcome this issue.
Thanks.

Regards,
Pramod.

**************** CAUTION - Disclaimer *****************
This e-mail contains PRIVILEGED AND CONFIDENTIAL INFORMATION intended sol=
ely 
for the use of the addressee(s). If you are not the intended recipient, p=
lease 
notify the sender by e-mail and delete the original message. Further, you=
 are not 
to copy, disclose, or distribute this e-mail or its contents to any other=
 person and 
any such actions are unlawful. This e-mail may contain viruses. Infosys h=
as taken 
every reasonable precaution to minimize this risk, but is not liable for =
any damage 
you may sustain as a result of any virus in this e-mail. You should carry=
 out your 
own virus checks before opening the e-mail or attachment. Infosys reserve=
s the 
right to monitor and review the content of all messages sent to or from t=
his e-mail 
address. Messages sent to or from this e-mail address may be stored on th=
e 
Infosys e-mail system.
***INFOSYS******** End of Disclaimer ********INFOSYS***

--_000_82BEC95A68153C46932D3E196B922B7217E79C0E0ABLRKECMBX07ad_
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-mi=
crosoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:wo=
rd" xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D=
"http://www.w3.org/TR/REC-html40"><head><meta http-equiv=3DContent-Type c=
ontent=3D"text/html; charset=3Diso-8859-1"><meta name=3DGenerator content=
=3D"Microsoft Word 14 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
=09{font-family:Wingdings;
=09panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
=09{font-family:Wingdings;
=09panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
=09{font-family:Calibri;
=09panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
=09{margin:0in;
=09margin-bottom:.0001pt;
=09font-size:11.0pt;
=09font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
=09{mso-style-priority:99;
=09color:blue;
=09text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
=09{mso-style-priority:99;
=09color:purple;
=09text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
=09{mso-style-priority:34;
=09margin-top:0in;
=09margin-right:0in;
=09margin-bottom:0in;
=09margin-left:.5in;
=09margin-bottom:.0001pt;
=09font-size:11.0pt;
=09font-family:"Calibri","sans-serif";}
span.EmailStyle17
=09{mso-style-type:personal-compose;
=09font-family:"Calibri","sans-serif";
=09color:windowtext;}
.MsoChpDefault
=09{mso-style-type:export-only;
=09font-family:"Calibri","sans-serif";}
@page WordSection1
=09{size:8.5in 11.0in;
=09margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
=09{page:WordSection1;}
/* List Definitions */
@list l0
=09{mso-list-id:525797272;
=09mso-list-type:hybrid;
=09mso-list-template-ids:-1547504422 553679306 67698691 67698693 67698689=
 67698691 67698693 67698689 67698691 67698693;}
@list l0:level1
=09{mso-level-start-at:0;
=09mso-level-number-format:bullet;
=09mso-level-text:\F0D8;
=09mso-level-tab-stop:none;
=09mso-level-number-position:left;
=09text-indent:-.25in;
=09font-family:Wingdings;
=09mso-fareast-font-family:Calibri;
=09mso-bidi-font-family:"Times New Roman";}
@list l0:level2
=09{mso-level-number-format:bullet;
=09mso-level-text:o;
=09mso-level-tab-stop:none;
=09mso-level-number-position:left;
=09text-indent:-.25in;
=09font-family:"Courier New";}
@list l0:level3
=09{mso-level-number-format:bullet;
=09mso-level-text:\F0A7;
=09mso-level-tab-stop:none;
=09mso-level-number-position:left;
=09text-indent:-.25in;
=09font-family:Wingdings;}
@list l0:level4
=09{mso-level-number-format:bullet;
=09mso-level-text:\F0B7;
=09mso-level-tab-stop:none;
=09mso-level-number-position:left;
=09text-indent:-.25in;
=09font-family:Symbol;}
@list l0:level5
=09{mso-level-number-format:bullet;
=09mso-level-text:o;
=09mso-level-tab-stop:none;
=09mso-level-number-position:left;
=09text-indent:-.25in;
=09font-family:"Courier New";}
@list l0:level6
=09{mso-level-number-format:bullet;
=09mso-level-text:\F0A7;
=09mso-level-tab-stop:none;
=09mso-level-number-position:left;
=09text-indent:-.25in;
=09font-family:Wingdings;}
@list l0:level7
=09{mso-level-number-format:bullet;
=09mso-level-text:\F0B7;
=09mso-level-tab-stop:none;
=09mso-level-number-position:left;
=09text-indent:-.25in;
=09font-family:Symbol;}
@list l0:level8
=09{mso-level-number-format:bullet;
=09mso-level-text:o;
=09mso-level-tab-stop:none;
=09mso-level-number-position:left;
=09text-indent:-.25in;
=09font-family:"Courier New";}
@list l0:level9
=09{mso-level-number-format:bullet;
=09mso-level-text:\F0A7;
=09mso-level-tab-stop:none;
=09mso-level-number-position:left;
=09text-indent:-.25in;
=09font-family:Wingdings;}
ol
=09{margin-bottom:0in;}
ul
=09{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue v=
link=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal>Hi,<o:p></o:=
p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>I ha=
ve known LTP for a month and wanted to test Linux kernel through LTP. I&#=
8216;m blocked at the below issue. Kindly read through.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>OS: Linux Ker=
nel Version 2.6 (Ubuntu) Target Board: IMX53 QSB Board(freescale) &amp; l=
ogged in as root.<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p=
><p class=3DMsoNormal>Problem: <o:p></o:p></p><p class=3DMsoNormal>I have=
 mounted rootfs folder and /opt/ltp folder onto the target board and exec=
uted this command <o:p></o:p></p><p class=3DMsoListParagraph style=3D'tex=
t-indent:-.25in;mso-list:l0 level1 lfo1'><![if !supportLists]><span style=
=3D'font-family:Wingdings'><span style=3D'mso-list:Ignore'>=D8<span style=
=3D'font:7.0pt "Times New Roman"'>&nbsp; </span></span></span><![endif]>.=
/ltp-pan =A0-a $$ =A0-n $$=A0 ../testcases/bin/access01<o:p></o:p></p><p =
class=3DMsoNormal>Error: &#8220;Could not open zoo as &#8220;2165&#8221;,=
 errno:13 Permission denied&#8221; <o:p></o:p></p><p class=3DMsoNormal>(P=
ermission is denied to even create a file.)<o:p></o:p></p><p class=3DMsoN=
ormal> <o:p></o:p></p><p class=3DMsoNormal>Suggestions are welcomed to ov=
ercome this issue.<o:p></o:p></p><p class=3DMsoNormal>Thanks.<o:p></o:p><=
/p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Regards=
,<o:p></o:p></p><p class=3DMsoNormal>Pramod.<o:p></o:p></p></div></body><=
/html>
<table><tr><td bgcolor=3D#ffffff><font color=3D#000000><pre>*************=
*** CAUTION - Disclaimer *****************
This e-mail contains PRIVILEGED AND CONFIDENTIAL INFORMATION intended sol=
ely 
for the use of the addressee(s). If you are not the intended recipient, p=
lease 
notify the sender by e-mail and delete the original message. Further, you=
 are not 
to copy, disclose, or distribute this e-mail or its contents to any other=
 person and 
any such actions are unlawful. This e-mail may contain viruses. Infosys h=
as taken 
every reasonable precaution to minimize this risk, but is not liable for =
any damage 
you may sustain as a result of any virus in this e-mail. You should carry=
 out your 
own virus checks before opening the e-mail or attachment. Infosys reserve=
s the 
right to monitor and review the content of all messages sent to or from t=
his e-mail 
address. Messages sent to or from this e-mail address may be stored on th=
e 
Infosys e-mail system.
***INFOSYS******** End of Disclaimer ********INFOSYS***</pre></font></td>=
</tr></table>

--_000_82BEC95A68153C46932D3E196B922B7217E79C0E0ABLRKECMBX07ad_--


--===============1027494728633097735==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
--===============1027494728633097735==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1027494728633097735==--

