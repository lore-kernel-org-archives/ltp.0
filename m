Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <francesco.rundo@st.com>) id 1PKXaa-0002Xe-OK
	for ltp-list@lists.sourceforge.net; Mon, 22 Nov 2010 14:41:52 +0000
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149])
	by sog-mx-1.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PKXaX-0000B8-Uw
	for ltp-list@lists.sourceforge.net; Mon, 22 Nov 2010 14:41:52 +0000
Received: from zeta.dmz-us.st.com (ns4.st.com [167.4.80.115])
	by beta.dmz-us.st.com (STMicroelectronics) with ESMTP id D5F5F102
	for <ltp-list@lists.sourceforge.net>;
	Mon, 22 Nov 2010 14:41:41 +0000 (GMT)
Received: from Webmail-eu.st.com (safex1hubcas2.st.com [10.75.90.16])
	by zeta.dmz-us.st.com (STMicroelectronics) with ESMTP id 3A1A71BE
	for <ltp-list@lists.sourceforge.net>;
	Mon, 22 Nov 2010 14:41:41 +0000 (GMT)
From: Francesco RUNDO <francesco.rundo@st.com>
Date: Mon, 22 Nov 2010 15:41:21 +0100
Message-ID: <0A8C979C21B8D745A471962AD91DBAD8495BB8736E@SAFEX1MAIL4.st.com>
Content-Language: en-US
Content-Type: multipart/mixed;
	boundary="_004_0A8C979C21B8D745A471962AD91DBAD8495BB8736ESAFEX1MAIL4st_"
MIME-Version: 1.0
Subject: [LTP] Patch to cover fallocate issue
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

--_004_0A8C979C21B8D745A471962AD91DBAD8495BB8736ESAFEX1MAIL4st_
Content-Type: multipart/alternative;
	boundary="_000_0A8C979C21B8D745A471962AD91DBAD8495BB8736ESAFEX1MAIL4st_"

--_000_0A8C979C21B8D745A471962AD91DBAD8495BB8736ESAFEX1MAIL4st_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

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

--_000_0A8C979C21B8D745A471962AD91DBAD8495BB8736ESAFEX1MAIL4st_
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

<p class=3DMsoNormal>Dear All,<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I&#8217;m using latest LTP-full-20101031 cross-built f=
or SH
based platforms.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I&#8217;d like to submit a fix related to &#8220;fallo=
cate&#8221;
testcase (fallocate01,fallocate02,fallocate03). <o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Currently, the testcase checks the fallocate syscall a=
lso in
case of &#8220;such&#8221; (and not &#8220;all&#8221;) architectures with w=
ordsize=3D32:
ppc64, ppc, x86_64. Clearly, the testcase manages the parameters -for the f=
allocate
syscall- according to the endianess supported by the above archs.<o:p></o:p=
></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>The so developed testcase will fail for all the
architectures -with wordsize=3D32- and/or different endianess, with respect=
 to
the ones (board and/or endianess) above described and currently supported i=
n
the tests (for instance, the test failed in case of execution on SH based
platforms!).<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Please, find in attach a patch which aim is to extend =
the
fallocate testcase(all subtests: fallocate01,fallocate02,fallocate03) to al=
l
the architectures with wordsize=3D32 both big and little endian.<o:p></o:p>=
</p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Regards,<o:p></o:p></p>

<p class=3DMsoNormal>Francesco<o:p></o:p></p>

</div>

</body>

</html>

--_000_0A8C979C21B8D745A471962AD91DBAD8495BB8736ESAFEX1MAIL4st_--

--_004_0A8C979C21B8D745A471962AD91DBAD8495BB8736ESAFEX1MAIL4st_
Content-Type: application/octet-stream;
	name="ltp-full-20101031-fix-fallocate_syscall_test.patch"
Content-Description: ltp-full-20101031-fix-fallocate_syscall_test.patch
Content-Disposition: attachment;
	filename="ltp-full-20101031-fix-fallocate_syscall_test.patch"; size=3743;
	creation-date="Mon, 22 Nov 2010 15:34:26 GMT";
	modification-date="Mon, 22 Nov 2010 15:33:53 GMT"
Content-Transfer-Encoding: base64

Rml4ZWQgZmFsbG9jYXRlIHN5c2NhbGwgdGVzdHMgY292ZXJpbmcgYWxsIDMyYml0cyB3b3Jkc2l6
ZSBhcmNoaXRlY3R1cmVzIGJvdGggYmlnIGFuZCBsaXR0bGUgZW5kaWFuLgpTaWduZWQtb2ZmLWJ5
OiBGcmFuY2VzY28gUnVuZG8gPGZyYW5jZXNjby5ydW5kb0BzdC5jb20+Ci0tLSBsdHAtZnVsbC0y
MDEwMTAzMS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZhbGxvY2F0ZS9mYWxsb2NhdGUwMS5j
Lm9yaWcJMjAxMC0xMS0yMiAxMzo1MDozMC4wOTE2MzAwMDAgKzAxMDAKKysrIGx0cC1mdWxsLTIw
MTAxMDMxL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFsbG9jYXRlL2ZhbGxvY2F0ZTAxLmMJ
MjAxMC0xMS0yMiAxNDowMjoxMC4xNzg5MjYwMDAgKzAxMDAKQEAgLTk3LDYgKzk3LDggQEAKICNp
bmNsdWRlIDxlcnJvci5oPgogI2luY2x1ZGUgPGludHR5cGVzLmg+CiAjaW5jbHVkZSA8c3lzL3V0
c25hbWUuaD4KKy8qIEdldCB0aGUgcmlnaHQgYXJjaCBlbmRpYW5lc3MgKi8KKyNpbmNsdWRlIDxl
bmRpYW4uaD4KIAogLyogSGFybmVzcyBTcGVjaWZpYyBJbmNsdWRlIEZpbGVzLiAqLwogI2luY2x1
ZGUgInRlc3QuaCIKQEAgLTI2MSwxOCArMjYzLDkgQEAKIHN0YXRpYyBpbmxpbmUgbG9uZyBmYWxs
b2NhdGUoaW50IGZkLCBpbnQgbW9kZSwgbG9mZl90IG9mZnNldCwgbG9mZl90IGxlbikKIHsKICNp
ZiBfX1dPUkRTSVpFID09IDMyCi0Jc3RydWN0IHV0c25hbWUgYnVmOwotCWlmICh1bmFtZSgmYnVm
KSA9PSAwKSB7Ci0JCWlmICghc3RyY21wKGJ1Zi5tYWNoaW5lLCAicHBjNjQiKQotCQkgICAgfHwg
IXN0cmNtcChidWYubWFjaGluZSwgInBwYyIpCi0JCSAgICB8fCAhc3RyY21wKGJ1Zi5tYWNoaW5l
LCAieDg2XzY0IikpCi0JCQlyZXR1cm4gc3lzY2FsbChfX05SX2ZhbGxvY2F0ZSwgZmQsIG1vZGUs
Ci0JCQkJICAgICAgIChpbnQpKG9mZnNldCA+PiAzMiksIChpbnQpb2Zmc2V0LAotCQkJCSAgICAg
ICAoaW50KShsZW4gPj4gMzIpLCAoaW50KWxlbik7Ci0JfSBlbHNlIHsKLQkJcGVycm9yKCJ1bmFt
ZToiKTsKLQkJcmV0dXJuIC0xOwotCX0KKyAgICAgICAgcmV0dXJuIChsb25nKSBzeXNjYWxsKF9f
TlJfZmFsbG9jYXRlLCBmZCwgbW9kZSwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgX19M
T05HX0xPTkdfUEFJUiAoKF9fb2ZmX3QpKG9mZnNldCA+PiAzMiksIChfX29mZl90KW9mZnNldCks
CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF9fTE9OR19MT05HX1BBSVIgKChfX29mZl90
KShsZW4gPj4gMzIpLCAoX19vZmZfdClsZW4pKTsKICNlbmRpZgogCXJldHVybiBzeXNjYWxsKF9f
TlJfZmFsbG9jYXRlLCBmZCwgbW9kZSwgb2Zmc2V0LCBsZW4pOwogfQotLS0gbHRwLWZ1bGwtMjAx
MDEwMzEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYWxsb2NhdGUvZmFsbG9jYXRlMDIuYy5v
cmlnCTIwMTAtMTEtMjIgMTM6NTA6MzUuMjQ4NDIxMDAwICswMTAwCisrKyBsdHAtZnVsbC0yMDEw
MTAzMS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZhbGxvY2F0ZS9mYWxsb2NhdGUwMi5jCTIw
MTAtMTEtMjIgMTQ6MDM6MTYuMDU1MjQ4MDAwICswMTAwCkBAIC05Myw2ICs5Myw4IEBACiAjaW5j
bHVkZSA8ZmNudGwuaD4KICNpbmNsdWRlIDxpbnR0eXBlcy5oPgogI2luY2x1ZGUgPHN5cy91dHNu
YW1lLmg+CisvKiBHZXQgdGhlIHJpZ2h0IGFyY2ggZW5kaWFuZXNzICovCisjaW5jbHVkZSA8ZW5k
aWFuLmg+CiAKIC8qIEhhcm5lc3MgU3BlY2lmaWMgSW5jbHVkZSBGaWxlcy4gKi8KICNpbmNsdWRl
ICJ0ZXN0LmgiCkBAIC0yNDIsMTggKzI0NCw5IEBACiBzdGF0aWMgaW5saW5lIGxvbmcgZmFsbG9j
YXRlKGludCBmZCwgaW50IG1vZGUsIGxvZmZfdCBvZmZzZXQsIGxvZmZfdCBsZW4pCiB7CiAjaWYg
X19XT1JEU0laRSA9PSAzMgotCXN0cnVjdCB1dHNuYW1lIGJ1ZjsKLQlpZiAodW5hbWUoJmJ1Zikg
PT0gMCkgewotCQlpZiAoIXN0cmNtcChidWYubWFjaGluZSwgInBwYzY0IikKLQkJICAgIHx8ICFz
dHJjbXAoYnVmLm1hY2hpbmUsICJwcGMiKQotCQkgICAgfHwgIXN0cmNtcChidWYubWFjaGluZSwg
Ing4Nl82NCIpKQotCQkJcmV0dXJuIHN5c2NhbGwoX19OUl9mYWxsb2NhdGUsIGZkLCBtb2RlLAot
CQkJCSAgICAgICAoaW50KShvZmZzZXQgPj4gMzIpLCAoaW50KW9mZnNldCwKLQkJCQkgICAgICAg
KGludCkobGVuID4+IDMyKSwgKGludClsZW4pOwotCX0gZWxzZSB7Ci0JCXBlcnJvcigidW5hbWU6
Iik7Ci0JCXJldHVybiAtMTsKLQl9CisgICAgICAgIHJldHVybiAobG9uZykgc3lzY2FsbChfX05S
X2ZhbGxvY2F0ZSwgZmQsIG1vZGUsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF9fTE9O
R19MT05HX1BBSVIgKChfX29mZl90KShvZmZzZXQgPj4gMzIpLCAoX19vZmZfdClvZmZzZXQpLAor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBfX0xPTkdfTE9OR19QQUlSICgoX19vZmZfdCko
bGVuID4+IDMyKSwgKF9fb2ZmX3QpbGVuKSk7CiAjZW5kaWYKIAlyZXR1cm4gc3lzY2FsbChfX05S
X2ZhbGxvY2F0ZSwgZmQsIG1vZGUsIG9mZnNldCwgbGVuKTsKIH0KLS0tIGx0cC1mdWxsLTIwMTAx
MDMxL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFsbG9jYXRlL2ZhbGxvY2F0ZTAzLmMub3Jp
ZwkyMDEwLTExLTIyIDEzOjUwOjM5LjYwODIxNjAwMCArMDEwMAorKysgbHRwLWZ1bGwtMjAxMDEw
MzEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYWxsb2NhdGUvZmFsbG9jYXRlMDMuYwkyMDEw
LTExLTIyIDE0OjAzOjMwLjg2ODY0OTAwMCArMDEwMApAQCAtOTIsNiArOTIsOCBAQAogI2luY2x1
ZGUgPHVuaXN0ZC5oPgogI2luY2x1ZGUgPGludHR5cGVzLmg+CiAjaW5jbHVkZSA8c3lzL3V0c25h
bWUuaD4KKy8qIEdldCB0aGUgcmlnaHQgYXJjaCBlbmRpYW5lc3MgKi8KKyNpbmNsdWRlIDxlbmRp
YW4uaD4KIAogLyogSGFybmVzcyBTcGVjaWZpYyBJbmNsdWRlIEZpbGVzLiAqLwogI2luY2x1ZGUg
InRlc3QuaCIKQEAgLTIzMCwxOCArMjMyLDkgQEAKIHN0YXRpYyBpbmxpbmUgbG9uZyBmYWxsb2Nh
dGUoaW50IGZkLCBpbnQgbW9kZSwgbG9mZl90IG9mZnNldCwgbG9mZl90IGxlbikKIHsKICNpZiBf
X1dPUkRTSVpFID09IDMyCi0Jc3RydWN0IHV0c25hbWUgYnVmOwotCWlmICh1bmFtZSgmYnVmKSA9
PSAwKSB7Ci0JCWlmICghc3RyY21wKGJ1Zi5tYWNoaW5lLCAicHBjNjQiKQotCQkgICAgfHwgIXN0
cmNtcChidWYubWFjaGluZSwgInBwYyIpCi0JCSAgICB8fCAhc3RyY21wKGJ1Zi5tYWNoaW5lLCAi
eDg2XzY0IikpCi0JCQlyZXR1cm4gc3lzY2FsbChfX05SX2ZhbGxvY2F0ZSwgZmQsIG1vZGUsCi0J
CQkJICAgICAgIChpbnQpKG9mZnNldCA+PiAzMiksIChpbnQpb2Zmc2V0LAotCQkJCSAgICAgICAo
aW50KShsZW4gPj4gMzIpLCAoaW50KWxlbik7Ci0JfSBlbHNlIHsKLQkJcGVycm9yKCJ1bmFtZToi
KTsKLQkJcmV0dXJuIC0xOwotCX0KKyAgICAgICAgcmV0dXJuIChsb25nKSBzeXNjYWxsKF9fTlJf
ZmFsbG9jYXRlLCBmZCwgbW9kZSwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgX19MT05H
X0xPTkdfUEFJUiAoKF9fb2ZmX3QpKG9mZnNldCA+PiAzMiksIChfX29mZl90KW9mZnNldCksCisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIF9fTE9OR19MT05HX1BBSVIgKChfX29mZl90KShs
ZW4gPj4gMzIpLCAoX19vZmZfdClsZW4pKTsKICNlbmRpZgogCXJldHVybiBzeXNjYWxsKF9fTlJf
ZmFsbG9jYXRlLCBmZCwgbW9kZSwgb2Zmc2V0LCBsZW4pOwogfQo=

--_004_0A8C979C21B8D745A471962AD91DBAD8495BB8736ESAFEX1MAIL4st_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
--_004_0A8C979C21B8D745A471962AD91DBAD8495BB8736ESAFEX1MAIL4st_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--_004_0A8C979C21B8D745A471962AD91DBAD8495BB8736ESAFEX1MAIL4st_--

