Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <francesco.rundo@st.com>) id 1PNPyb-00040b-Ut
	for ltp-list@lists.sourceforge.net; Tue, 30 Nov 2010 13:10:33 +0000
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123])
	by sog-mx-3.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PNPya-0000CD-0o
	for ltp-list@lists.sourceforge.net; Tue, 30 Nov 2010 13:10:33 +0000
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5B23C1DC
	for <ltp-list@lists.sourceforge.net>;
	Tue, 30 Nov 2010 13:10:20 +0000 (GMT)
Received: from Webmail-eu.st.com (safex1hubcas2.st.com [10.75.90.16])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7047B934
	for <ltp-list@lists.sourceforge.net>;
	Tue, 30 Nov 2010 13:10:20 +0000 (GMT)
From: Francesco RUNDO <francesco.rundo@st.com>
Date: Tue, 30 Nov 2010 14:10:00 +0100
Message-ID: <0A8C979C21B8D745A471962AD91DBAD8495BCEF365@SAFEX1MAIL4.st.com>
References: <0A8C979C21B8D745A471962AD91DBAD8495BB8736E@SAFEX1MAIL4.st.com>
In-Reply-To: <0A8C979C21B8D745A471962AD91DBAD8495BB8736E@SAFEX1MAIL4.st.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [LTP] Patch to cover fallocate issue
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3394796971771068693=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--===============3394796971771068693==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_0A8C979C21B8D745A471962AD91DBAD8495BCEF365SAFEX1MAIL4st_"

--_000_0A8C979C21B8D745A471962AD91DBAD8495BCEF365SAFEX1MAIL4st_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

All,

Any updates about the fallocate() issue I've described (I sent the related =
patch) below reported ?
Thanks in advance
Francesco

From: Francesco RUNDO [mailto:francesco.rundo@st.com]
Sent: Monday, November 22, 2010 3:41 PM
To: ltp-list@lists.sourceforge.net
Subject: [LTP] Patch to cover fallocate issue

Dear All,

I'm using latest LTP-full-20101031 cross-built for SH based platforms.

I'd like to submit a fix related to "fallocate" testcase (fallocate01,fallo=
cate02,fallocate03).

Currently, the testcase checks the fallocate syscall also in case of "such"=
 (and not "all") architectures with wordsize=3D32: ppc64, ppc, x86_64. Clea=
rly, the testcase manages the parameters -for the fallocate syscall- accord=
ing to the endianess supported by the above archs.

The so developed testcase will fail for all the architectures -with wordsiz=
e=3D32- and/or different endianess, with respect to the ones (board and/or =
endianess) above described and currently supported in the tests (for instan=
ce, the test failed in case of execution on SH based platforms!).

Please, find in attach a patch which aim is to extend the fallocate testcas=
e(all subtests: fallocate01,fallocate02,fallocate03) to all the architectur=
es with wordsize=3D32 both big and little endian.

Regards,
Francesco

--_000_0A8C979C21B8D745A471962AD91DBAD8495BCEF365SAFEX1MAIL4st_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><META HTTP-EQUIV=3D"Content-Type" CONTENT=
=3D"text/html; charset=3Dus-ascii"><meta name=3DGenerator content=3D"Micros=
oft Word 12 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
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
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue vli=
nk=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal><span style=3D'c=
olor:#1F497D'>All,<o:p></o:p></span></p><p class=3DMsoNormal><span style=3D=
'color:#1F497D'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span styl=
e=3D'color:#1F497D'>Any updates about the fallocate() issue I&#8217;ve desc=
ribed (I sent the related patch) below reported ?<o:p></o:p></span></p><p c=
lass=3DMsoNormal><span style=3D'color:#1F497D'>Thanks in advance<o:p></o:p>=
</span></p><p class=3DMsoNormal><span style=3D'color:#1F497D'>Francesco<o:p=
></o:p></span></p><p class=3DMsoNormal><span style=3D'color:#1F497D'><o:p>&=
nbsp;</o:p></span></p><div><div style=3D'border:none;border-top:solid #B5C4=
DF 1.0pt;padding:3.0pt 0in 0in 0in'><p class=3DMsoNormal><b><span style=3D'=
font-size:10.0pt;font-family:"Tahoma","sans-serif"'>From:</span></b><span s=
tyle=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'> Francesco RUND=
O [mailto:francesco.rundo@st.com] <br><b>Sent:</b> Monday, November 22, 201=
0 3:41 PM<br><b>To:</b> ltp-list@lists.sourceforge.net<br><b>Subject:</b> [=
LTP] Patch to cover fallocate issue<o:p></o:p></span></p></div></div><p cla=
ss=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Dear All,<o:p></o:=
p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>I&#821=
7;m using latest LTP-full-20101031 cross-built for SH based platforms.<o:p>=
</o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>I&=
#8217;d like to submit a fix related to &#8220;fallocate&#8221; testcase (f=
allocate01,fallocate02,fallocate03). <o:p></o:p></p><p class=3DMsoNormal><o=
:p>&nbsp;</o:p></p><p class=3DMsoNormal>Currently, the testcase checks the =
fallocate syscall also in case of &#8220;such&#8221; (and not &#8220;all&#8=
221;) architectures with wordsize=3D32: ppc64, ppc, x86_64. Clearly, the te=
stcase manages the parameters -for the fallocate syscall- according to the =
endianess supported by the above archs.<o:p></o:p></p><p class=3DMsoNormal>=
<o:p>&nbsp;</o:p></p><p class=3DMsoNormal>The so developed testcase will fa=
il for all the architectures -with wordsize=3D32- and/or different endianes=
s, with respect to the ones (board and/or endianess) above described and cu=
rrently supported in the tests (for instance, the test failed in case of ex=
ecution on SH based platforms!).<o:p></o:p></p><p class=3DMsoNormal><o:p>&n=
bsp;</o:p></p><p class=3DMsoNormal>Please, find in attach a patch which aim=
 is to extend the fallocate testcase(all subtests: fallocate01,fallocate02,=
fallocate03) to all the architectures with wordsize=3D32 both big and littl=
e endian.<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=
=3DMsoNormal>Regards,<o:p></o:p></p><p class=3DMsoNormal>Francesco<o:p></o:=
p></p></div></body></html>=

--_000_0A8C979C21B8D745A471962AD91DBAD8495BCEF365SAFEX1MAIL4st_--


--===============3394796971771068693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
--===============3394796971771068693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3394796971771068693==--

