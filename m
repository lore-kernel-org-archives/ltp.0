Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sarath.tadi@gmail.com>) id 1RksCK-0004G7-Gy
	for ltp-list@lists.sourceforge.net; Wed, 11 Jan 2012 07:02:12 +0000
Received: from mail-we0-f175.google.com ([74.125.82.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1RksCG-0008I5-Hu
	for ltp-list@lists.sourceforge.net; Wed, 11 Jan 2012 07:02:12 +0000
Received: by werm13 with SMTP id m13so426336wer.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 10 Jan 2012 23:02:02 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 11 Jan 2012 12:32:02 +0530
Message-ID: <CABhB_e-dCgn75mRkPE5LTb9-51RNK7ds=Tekaem85wkPyTu9Dw@mail.gmail.com>
From: tadimarri sarath <sarath.tadi@gmail.com>
Subject: [LTP] compiling LTP for Android on ARM target board
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8527625775574532401=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============8527625775574532401==
Content-Type: multipart/alternative; boundary=001636d347566c8a7f04b63b35ae

--001636d347566c8a7f04b63b35ae
Content-Type: text/plain; charset=ISO-8859-1

Hi ,

I want to compile the LTP for android on ARM target board.
I tried the patch using the following link.

http://old.nabble.com/-LTP--Porting-of-LTP-on-Android---Patch-p32252920.html


As per the link, I applied the patch on ltp-full-20110228.


But it is failing throwing the errors related "Hunk failed Android.mk"


I have downloaded the Android NDK to get the toolchain.


Please let me know the steps i need to make before applying the patch , so
that the patch applies correctly.


Regards,

Sarath.

--001636d347566c8a7f04b63b35ae
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi , <br><br>I want to compile the LTP for android on ARM target board.<br>=
I tried the patch using the following link.<br><meta http-equiv=3D"Content-=
Type" content=3D"text/html; charset=3Dutf-8"><meta name=3D"ProgId" content=
=3D"Word.Document"><meta name=3D"Generator" content=3D"Microsoft Word 12"><=
meta name=3D"Originator" content=3D"Microsoft Word 12"><link rel=3D"File-Li=
st" href=3D"file:///C:%5CDOCUME%7E1%5CSARATH%7E1%5CLOCALS%7E1%5CTemp%5Cmsoh=
tmlclip1%5C01%5Cclip_filelist.xml"><link rel=3D"themeData" href=3D"file:///=
C:%5CDOCUME%7E1%5CSARATH%7E1%5CLOCALS%7E1%5CTemp%5Cmsohtmlclip1%5C01%5Cclip=
_themedata.thmx"><link rel=3D"colorSchemeMapping" href=3D"file:///C:%5CDOCU=
ME%7E1%5CSARATH%7E1%5CLOCALS%7E1%5CTemp%5Cmsohtmlclip1%5C01%5Cclip_colorsch=
ememapping.xml"><style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;
	mso-font-alt:"Calisto MT";
	mso-font-charset:0;
	mso-generic-font-family:roman;
	mso-font-pitch:variable;
	mso-font-signature:-1610611985 1107304683 0 0 159 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;
	mso-font-alt:Arial;
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:-1610611985 1073750139 0 0 159 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-unhide:no;
	mso-style-qformat:yes;
	mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-fareast-font-family:Calibri;
	mso-fareast-theme-font:minor-latin;
	mso-bidi-font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{mso-style-noshow:yes;
	mso-style-priority:99;
	color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-noshow:yes;
	mso-style-priority:99;
	color:purple;
	mso-themecolor:followedhyperlink;
	text-decoration:underline;
	text-underline:single;}
.MsoChpDefault
	{mso-style-type:export-only;
	mso-default-props:yes;
	font-size:10.0pt;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.WordSection1
	{page:WordSection1;}
-->
</style>

<p class=3D"MsoNormal"><a href=3D"http://old.nabble.com/-LTP--Porting-of-LT=
P-on-Android---Patch-p32252920.html">http://old.nabble.com/-LTP--Porting-of=
-LTP-on-Android---Patch-p32252920.html</a></p><p class=3D"MsoNormal"><br></=
p>
<p class=3D"MsoNormal">As per the link, I applied the patch on ltp-full-201=
10228.<br></p><p class=3D"MsoNormal"><br></p><p class=3D"MsoNormal">But it =
is failing throwing the errors related &quot;Hunk failed Android.mk&quot; <=
br>
</p><p class=3D"MsoNormal"><br></p><p class=3D"MsoNormal">I have downloaded=
 the Android NDK to get the toolchain. <br></p><p class=3D"MsoNormal"><br><=
/p><p class=3D"MsoNormal">Please let me know the steps i need to make befor=
e applying the patch , so that the patch applies correctly.</p>
<p class=3D"MsoNormal"><br></p><p class=3D"MsoNormal">Regards,</p><p class=
=3D"MsoNormal">Sarath.<br></p>


--001636d347566c8a7f04b63b35ae--


--===============8527625775574532401==
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
--===============8527625775574532401==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8527625775574532401==--

