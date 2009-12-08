Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1NI6DG-00024h-Ux
	for ltp-list@lists.sourceforge.net; Tue, 08 Dec 2009 19:59:10 +0000
Received: from [206.112.117.47] (helo=gateway-1237.mvista.com)
	by sfi-mx-2.v28.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1NI6DA-0002aK-EU
	for ltp-list@lists.sourceforge.net; Tue, 08 Dec 2009 19:59:10 +0000
Received: from svexch01.mvista.com (svexch01.mvista.com [10.0.0.82])
	by hermes.mvista.com (Postfix) with ESMTP id 09ECC1D5AD
	for <ltp-list@lists.sourceforge.net>;
	Tue,  8 Dec 2009 11:57:58 -0800 (PST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CA7840.BD0FF748"
Date: Tue, 8 Dec 2009 11:57:58 -0800
Message-ID: <8368651DACC1964480F951191B94A07801926FEF@svexch01.mvista.com>
From: "Henry Yei" <hyei@mvista.com>
Subject: [LTP] [PATCH] math/float/thread_code.c,
	revert previous patch which added check for NaN
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
To: LTP Mailing List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA7840.BD0FF748
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01CA7840.BD0FF748"


------_=_NextPart_002_01CA7840.BD0FF748
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Here is a patch that reverts the previous patch applied to thread_cod.c. =
Some of the float tests were reporting a failure where it detected the =
difference between the result and expected result was NaN(not a number). =
 As some of the results and expected results resolved to inf(infinity), =
the difference calculation would result in NaN.

=20

With the previous patch, float_power and float_bessel tests were =
consistently failing on all architectures tried=20

=20

Signed-off by: Henry Yei <hyei@mvista.com>

=20


------_=_NextPart_002_01CA7840.BD0FF748
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
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
	font-size:10.0pt;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.Section1
	{page:Section1;}
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

<div class=3DSection1>

<p class=3DMsoNormal>Here is a patch that reverts the previous patch =
applied to
thread_cod.c. Some of the float tests were reporting a failure where it
detected the difference between the result and expected result was =
NaN(not a
number).=A0 As some of the results and expected results resolved to =
inf(infinity),
the difference calculation would result in NaN.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>With the previous patch, float_power and =
float_bessel tests
were consistently failing on all architectures tried <o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<div>

<p class=3DMsoNormal>Signed-off by: Henry Yei =
&lt;hyei@mvista.com&gt;<o:p></o:p></p>

</div>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

------_=_NextPart_002_01CA7840.BD0FF748--

------_=_NextPart_001_01CA7840.BD0FF748
Content-Type: application/octet-stream;
	name="thread_code.patch"
Content-Transfer-Encoding: base64
Content-Description: thread_code.patch
Content-Disposition: attachment;
	filename="thread_code.patch"

LS0tIGx0cC90ZXN0Y2FzZXMvbWlzYy9tYXRoL2Zsb2F0L3RocmVhZF9jb2RlLmMJMjAwOS0xMC0x
MyAwNDoyMzozNC4wMDAwMDAwMDAgLTA3MDAKKysrIGx0cC13ZGlyL3Rlc3RjYXNlcy9taXNjL21h
dGgvZmxvYXQvdGhyZWFkX2NvZGUuYwkyMDA5LTEyLTA4IDExOjAyOjEzLjkzNTcxMTc4OCAtMDgw
MApAQCAtMTI0LDcgKzEyNCw3IEBAIHN0YXRpYyB2b2lkIGNoZWNrX2Vycm9yKFRIX0RBVEEgKnRo
X2RhdGEKIAogCXggPSBmYWJzKHIgLSBlKTsgLyogZGlmZiBleHBlY3RlZC9jb21wdXRlZCAqLwog
Ci0JaWYgKCh4ID4gRVBTKSB8fCAoeCAhPSB4KSkgeyAvKiBlcnJvciA/ICovCisJaWYgKHggPiBF
UFMpIHsgLyogZXJyb3IgPyAqLwogCQkvKiBjb21wdXRlIGV4cG9uZW50IHBhcnRzICovCiAJCSh2
b2lkKWZyZXhwKHIsICZwcik7IC8qIGZvciBjb21wdXRlZCAqLwogCQkodm9pZClmcmV4cCh4LCAm
cHgpOyAvKiBmb3IgZGlmZmVyZW5jZSAqLwpAQCAtMzY1LDcgKzM2NSw3IEBAIGZpbGVfc2l6ZV9l
cnJvcjoKIAogCWltYXggPSBmc2l6ZSAvIHNpemVvZihkb3VibGUpOwogCi0Jd2hpbGUodGhfZGF0
YS0+dGhfbmxvb3AgPD0gbnVtX2xvb3BzKSB7ICAgCisJd2hpbGUodGhfZGF0YS0+dGhfbmxvb3Ag
PD0gbnVtX2xvb3BzKSB7CiAJLyogbG9vcCBzdG9wcGVkIGJ5IHB0aHJlYWRfY2FuY2VsICovCiAK
IAkJZm9yKGluZGV4ID0gdGhfZGF0YS0+dGhfbnVtOwo=

------_=_NextPart_001_01CA7840.BD0FF748
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev

------_=_NextPart_001_01CA7840.BD0FF748
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------_=_NextPart_001_01CA7840.BD0FF748--

