Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <francesco.rundo@st.com>) id 1PHtiZ-0004L6-Th
	for ltp-list@lists.sourceforge.net; Mon, 15 Nov 2010 07:43:11 +0000
Received: from eu1sys200aog109.obsmtp.com ([207.126.144.127])
	by sog-mx-2.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PHtiX-0005f8-AQ
	for ltp-list@lists.sourceforge.net; Mon, 15 Nov 2010 07:43:11 +0000
Received: from zeta.dmz-us.st.com (ns4.st.com [167.4.80.115])
	by beta.dmz-us.st.com (STMicroelectronics) with ESMTP id D336EBD
	for <ltp-list@lists.sourceforge.net>;
	Mon, 15 Nov 2010 07:43:00 +0000 (GMT)
Received: from Webmail-eu.st.com (safex1hubcas6.st.com [10.75.90.73])
	by zeta.dmz-us.st.com (STMicroelectronics) with ESMTP id 3C1B718E
	for <ltp-list@lists.sourceforge.net>;
	Mon, 15 Nov 2010 07:43:00 +0000 (GMT)
From: Francesco RUNDO <francesco.rundo@st.com>
Date: Mon, 15 Nov 2010 08:42:20 +0100
Message-ID: <0A8C979C21B8D745A471962AD91DBAD844DD247AA3@SAFEX1MAIL4.st.com>
Content-Language: en-US
Content-Type: multipart/mixed;
	boundary="_006_0A8C979C21B8D745A471962AD91DBAD844DD247AA3SAFEX1MAIL4st_"
MIME-Version: 1.0
Subject: [LTP] FW: Removed unused variables on getdelay.c file
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

--_006_0A8C979C21B8D745A471962AD91DBAD844DD247AA3SAFEX1MAIL4st_
Content-Type: multipart/alternative;
	boundary="_000_0A8C979C21B8D745A471962AD91DBAD844DD247AA3SAFEX1MAIL4st_"

--_000_0A8C979C21B8D745A471962AD91DBAD844DD247AA3SAFEX1MAIL4st_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Any updates about the issue related to getdelays.c file ?
Subrata,
Please, can you send me your feedback about the patch I want to submit for =
fixing the getdelays issue ?

Thanks in advance
Best Regards
Francesco Rundo

From: Francesco RUNDO [mailto:francesco.rundo@st.com]
Sent: Tuesday, November 09, 2010 11:06 AM
To: ltp-list@lists.sourceforge.net
Subject: [LTP] Removed unused variables on getdelay.c file

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



--_000_0A8C979C21B8D745A471962AD91DBAD844DD247AA3SAFEX1MAIL4st_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
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

<p class=3DMsoNormal><span style=3D'color:#1F497D'>Any updates about the is=
sue related
to getdelays.c file ?<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>Subrata, <o:p></o:p></sp=
an></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>Please, can you send me =
your
feedback about the patch I want to submit for fixing the getdelays issue ?<=
o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span>=
</p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>Thanks in advance<o:p></=
o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>Best Regards<o:p></o:p><=
/span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>Francesco Rundo<o:p></o:=
p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span>=
</p>

<div>

<div style=3D'border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in'>

<p class=3DMsoNormal><b><span style=3D'font-size:10.0pt;font-family:"Tahoma=
","sans-serif"'>From:</span></b><span
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'> Francesco RUN=
DO
[mailto:francesco.rundo@st.com] <br>
<b>Sent:</b> Tuesday, November 09, 2010 11:06 AM<br>
<b>To:</b> ltp-list@lists.sourceforge.net<br>
<b>Subject:</b> [LTP] Removed unused variables on getdelay.c file<o:p></o:p=
></span></p>

</div>

</div>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Dears,<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I&#8217;m porting the recent LTP release -20101031- fo=
r SH
platforms both glibc and uClibc.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I&#8217;ve noted unused variables &#8211;&#8220;stime&=
#8221; and &#8220;utime&#8221;- declared
on the file getdelays.c (you find it under
$LTPROOT/testcases/kernel/controllers/cgroup/). The above variables are bot=
h
&#8220;__u64&#8221;.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Moreover -and only for uClibc build-, the variable &#8=
220;stime&#8221;
causes an error of &#8220;variable redeclared as different kind of symbol&#=
8221;, as there
is a function &#8220;stime&#8221; exported on the standard &#8220;time.h&#8=
221; header file of the uClibc
target.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I think the above variables should be removed on the f=
ile
&#8220;getdelays.c&#8221; both because they are unused and because they cau=
ses an error
during LTP build for uClibc (for SH platforms).<o:p></o:p></p>

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

--_000_0A8C979C21B8D745A471962AD91DBAD844DD247AA3SAFEX1MAIL4st_--

--_006_0A8C979C21B8D745A471962AD91DBAD844DD247AA3SAFEX1MAIL4st_
Content-Type: application/octet-stream;
	name="ltp-full-20101031-delete-unused-variables.patch"
Content-Description: ltp-full-20101031-delete-unused-variables.patch
Content-Disposition: attachment;
	filename="ltp-full-20101031-delete-unused-variables.patch"; size=629;
	creation-date="Tue, 09 Nov 2010 12:01:11 GMT";
	modification-date="Tue, 09 Nov 2010 11:52:32 GMT"
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

--_006_0A8C979C21B8D745A471962AD91DBAD844DD247AA3SAFEX1MAIL4st_
Content-Type: text/plain; name="ATT00001..c"
Content-Description: ATT00001..c
Content-Disposition: attachment; filename="ATT00001..c"; size=365;
	creation-date="Tue, 09 Nov 2010 11:27:51 GMT";
	modification-date="Tue, 09 Nov 2010 11:27:51 GMT"
Content-Transfer-Encoding: base64

LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpUaGUgTmV4dCA4MDAgQ29tcGFuaWVzIHRvIExlYWQgQW1l
cmljYSdzIEdyb3d0aDogTmV3IFZpZGVvIFdoaXRlcGFwZXINCkRhdmlkIEcuIFRob21zb24sIGF1
dGhvciBvZiB0aGUgYmVzdC1zZWxsaW5nIGJvb2sgIkJsdWVwcmludCB0byBhIA0KQmlsbGlvbiIg
c2hhcmVzIGhpcyBpbnNpZ2h0cyBhbmQgYWN0aW9ucyB0byBoZWxwIHByb3BlbCB5b3VyIA0KYnVz
aW5lc3MgZHVyaW5nIHRoZSBuZXh0IGdyb3d0aCBjeWNsZS4gTGlzdGVuIE5vdyENCmh0dHA6Ly9w
LnNmLm5ldC9zZnUvU0FQLWRldjJkZXY=

--_006_0A8C979C21B8D745A471962AD91DBAD844DD247AA3SAFEX1MAIL4st_
Content-Type: text/plain; name="ATT00002..c"
Content-Description: ATT00002..c
Content-Disposition: attachment; filename="ATT00002..c"; size=159;
	creation-date="Tue, 09 Nov 2010 11:27:51 GMT";
	modification-date="Tue, 09 Nov 2010 11:27:51 GMT"
Content-Transfer-Encoding: base64

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCkx0cC1saXN0
IG1haWxpbmcgbGlzdA0KTHRwLWxpc3RAbGlzdHMuc291cmNlZm9yZ2UubmV0DQpodHRwczovL2xp
c3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9sdHAtbGlzdA0K

--_006_0A8C979C21B8D745A471962AD91DBAD844DD247AA3SAFEX1MAIL4st_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Centralized Desktop Delivery: Dell and VMware Reference Architecture
Simplifying enterprise desktop deployment and management using
Dell EqualLogic storage and VMware View: A highly scalable, end-to-end
client virtualization framework. Read more!
http://p.sf.net/sfu/dell-eql-dev2dev
--_006_0A8C979C21B8D745A471962AD91DBAD844DD247AA3SAFEX1MAIL4st_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--_006_0A8C979C21B8D745A471962AD91DBAD844DD247AA3SAFEX1MAIL4st_--

