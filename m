Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <francesco.rundo@st.com>) id 1PFl6T-0006j4-1t
	for ltp-list@lists.sourceforge.net; Tue, 09 Nov 2010 10:07:01 +0000
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149])
	by sog-mx-1.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PFl6R-0007LX-6Y
	for ltp-list@lists.sourceforge.net; Tue, 09 Nov 2010 10:07:00 +0000
Received: from zeta.dmz-us.st.com (ns4.st.com [167.4.80.115])
	by beta.dmz-us.st.com (STMicroelectronics) with ESMTP id A9A6AF4
	for <ltp-list@lists.sourceforge.net>;
	Tue,  9 Nov 2010 10:06:29 +0000 (GMT)
Received: from Webmail-eu.st.com (safex1hubcas6.st.com [10.75.90.73])
	by zeta.dmz-us.st.com (STMicroelectronics) with ESMTP id B811F14E
	for <ltp-list@lists.sourceforge.net>;
	Tue,  9 Nov 2010 10:06:28 +0000 (GMT)
From: Francesco RUNDO <francesco.rundo@st.com>
Date: Tue, 9 Nov 2010 11:06:02 +0100
Message-ID: <0A8C979C21B8D745A471962AD91DBAD844DD1A5207@SAFEX1MAIL4.st.com>
Content-Language: en-US
Content-Type: multipart/mixed;
	boundary="_004_0A8C979C21B8D745A471962AD91DBAD844DD1A5207SAFEX1MAIL4st_"
MIME-Version: 1.0
Subject: [LTP] Removed unused variables on getdelay.c file
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--_004_0A8C979C21B8D745A471962AD91DBAD844DD1A5207SAFEX1MAIL4st_
Content-Type: multipart/alternative;
	boundary="_000_0A8C979C21B8D745A471962AD91DBAD844DD1A5207SAFEX1MAIL4st_"

--_000_0A8C979C21B8D745A471962AD91DBAD844DD1A5207SAFEX1MAIL4st_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Dears,

I'm porting the recent LTP release -20101031- for SH platforms both glibc a=
nd uClibc.

I've noted unused variables -"stime" and "utime"- declared on the file getd=
elays.c (you find it under $LTPROOT/testcases/kernel/controllers/cgroup/). =
The above variables are both "__u64".

Moreover -and only for uClibc build-, the variable "stime" causes an error =
of "variable redeclared as different kind of symbol", as there is a functio=
n "stime" exported on the standard "time.h" header file of the uClibc targe=
t.

I think the above variables should be removed on the file "getdelays.c" bot=
h because they are unused and because they causes an error during LTP build=
 for uClibc (for SH platforms).

I've attached a patch to do that.

Best Regards,
Francesco Rundo



--_000_0A8C979C21B8D745A471962AD91DBAD844DD1A5207SAFEX1MAIL4st_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
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
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DWordSection1>

<p class=3DMsoNormal>Dears,<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I&#8217;m porting the recent LTP release -20101031- fo=
r SH
platforms both glibc and uClibc.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I&#8217;ve noted unused variables &#8211;&#8220;stime&=
#8221;
and &#8220;utime&#8221;- declared on the file getdelays.c (you find it unde=
r $LTPROOT/testcases/kernel/controllers/cgroup/).
The above variables are both &#8220;__u64&#8221;.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Moreover -and only for uClibc build-, the variable &#8=
220;stime&#8221;
causes an error of &#8220;variable redeclared as different kind of symbol&#=
8221;,
as there is a function &#8220;stime&#8221; exported on the standard &#8220;=
time.h&#8221;
header file of the uClibc target.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I think the above variables should be removed on the f=
ile &#8220;getdelays.c&#8221;
both because they are unused and because they causes an error during LTP bu=
ild
for uClibc (for SH platforms).<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I&#8217;ve attached a patch to do that.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Best Regards,<o:p></o:p></p>

<p class=3DMsoNormal>Francesco Rundo<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

--_000_0A8C979C21B8D745A471962AD91DBAD844DD1A5207SAFEX1MAIL4st_--

--_004_0A8C979C21B8D745A471962AD91DBAD844DD1A5207SAFEX1MAIL4st_
Content-Type: application/octet-stream;
	name="ltp-full-20101031-delete-unused-variables.patch"
Content-Description: ltp-full-20101031-delete-unused-variables.patch
Content-Disposition: attachment;
	filename="ltp-full-20101031-delete-unused-variables.patch"; size=629;
	creation-date="Tue, 09 Nov 2010 11:01:11 GMT";
	modification-date="Tue, 09 Nov 2010 10:52:32 GMT"
Content-Transfer-Encoding: base64

RGVsZXRlZCB1bnVzZWQgInN0aW1lIiwgInV0aW1lIiB2YXJpYWJsZXMuIE1vcmVvdmVyIGFuZCBv
bmx5IGZvciB1Q2xpYmMsIHRoZSB2YXJpYWJsZSAic3RpbWUiIGNhdXNlcyBjb25mbGljdCB3aXRo
IHRoZSBmdW5jdGlvbiAic3RpbWUiIGRlY2xhcmVkIGluIHRoZSAidGltZS5oIiBoZWFkZXIgZmls
ZS4KU2lnbmVkLW9mZi1ieTogRnJhbmNlc2NvIFJ1bmRvIDxmcmFuY2VzY28ucnVuZG9Ac3QuY29t
PgotLS0gbHRwLWZ1bGwtMjAxMDEwMzEvdGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy9jZ3Jv
dXAvZ2V0ZGVsYXlzLmMub3JpZwkyMDEwLTExLTA5IDA5OjIxOjQ0Ljk5OTk4NTAwMCArMDEwMAor
KysgbHRwLWZ1bGwtMjAxMDEwMzEvdGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy9jZ3JvdXAv
Z2V0ZGVsYXlzLmMJMjAxMC0xMS0wOSAwOToyMjoxMi43Njg4MzcwMDAgKzAxMDAKQEAgLTYwLDcg
KzYwLDYgQEAKIGludCBwcmludF9kZWxheXM7CiBpbnQgcHJpbnRfaW9fYWNjb3VudGluZzsKIGlu
dCBwcmludF90YXNrX2NvbnRleHRfc3dpdGNoX2NvdW50czsKLV9fdTY0IHN0aW1lLCB1dGltZTsK
IAogI2RlZmluZSBQUklOVEYoZm10LCBhcmcuLi4pIHsJCQlcCiAJICAgIGlmIChkYmcpIHsJCQkJ
XAo=

--_004_0A8C979C21B8D745A471962AD91DBAD844DD1A5207SAFEX1MAIL4st_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
The Next 800 Companies to Lead America's Growth: New Video Whitepaper
David G. Thomson, author of the best-selling book "Blueprint to a 
Billion" shares his insights and actions to help propel your 
business during the next growth cycle. Listen Now!
http://p.sf.net/sfu/SAP-dev2dev
--_004_0A8C979C21B8D745A471962AD91DBAD844DD1A5207SAFEX1MAIL4st_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--_004_0A8C979C21B8D745A471962AD91DBAD844DD1A5207SAFEX1MAIL4st_--

