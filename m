Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cristian.iorga@intel.com>) id 1ScAge-00040M-EE
	for ltp-list@lists.sourceforge.net; Wed, 06 Jun 2012 07:29:48 +0000
Received: from mga09.intel.com ([134.134.136.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ScAga-0005tQ-F9
	for ltp-list@lists.sourceforge.net; Wed, 06 Jun 2012 07:29:48 +0000
From: "Iorga, Cristian" <cristian.iorga@intel.com>
Date: Wed, 6 Jun 2012 07:29:00 +0000
Message-ID: <969F26A8BAB325438E7EB80D3C3134FB16155EEE@IRSMSX102.ger.corp.intel.com>
Content-Language: en-US
Content-Type: multipart/mixed;
	boundary="_004_969F26A8BAB325438E7EB80D3C3134FB16155EEEIRSMSX102gercor_"
MIME-Version: 1.0
Subject: [LTP] ltp: Add patch to correct failing build from archive
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

--_004_969F26A8BAB325438E7EB80D3C3134FB16155EEEIRSMSX102gercor_
Content-Type: multipart/alternative;
	boundary="_000_969F26A8BAB325438E7EB80D3C3134FB16155EEEIRSMSX102gercor_"

--_000_969F26A8BAB325438E7EB80D3C3134FB16155EEEIRSMSX102gercor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

ltp: Add patch to correct failing build from archive

Signed-off-by: Cristian Iorga <cristian.iorga@intel.com>

--_000_969F26A8BAB325438E7EB80D3C3134FB16155EEEIRSMSX102gercor_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 12 (filtered medium)">
<style><!--
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
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">ltp: Add patch to correct failing build from archive=
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Cristian Iorga &lt;cristian.iorga@int=
el.com&gt;<o:p></o:p></p>
</div>
</body>
</html>

--_000_969F26A8BAB325438E7EB80D3C3134FB16155EEEIRSMSX102gercor_--

--_004_969F26A8BAB325438E7EB80D3C3134FB16155EEEIRSMSX102gercor_
Content-Type: application/octet-stream; name="fix_building_fom_archive.patch"
Content-Description: fix_building_fom_archive.patch
Content-Disposition: attachment; filename="fix_building_fom_archive.patch";
	size=752; creation-date="Wed, 06 Jun 2012 07:26:58 GMT";
	modification-date="Wed, 06 Jun 2012 07:24:23 GMT"
Content-Transfer-Encoding: base64

bHRwOiBBZGQgcGF0Y2ggdG8gY29ycmVjdCBmYWlsaW5nIGJ1aWxkCiAgICAKICAgIGx0cCBtYWtl
ZmlsZSBkb2VzIG5vdCBpbnRlcnByZXQgY29ycmVjdGx5IHRoZSByZXN1bHQgb2YgZ2l0IGRlc2Ny
aWJlCiAgICBjb21tYW5kIGFuZCBhc3N1bWVzIHRoYXQgaXQgaXMgd29ya2luZyB3aXRoIGEgZ2l0
IHJlcG8sIHdoaWxlIGluIGZhY3QKICAgIHdvcmtpbmcgd2l0aCBhIHNvdXJjZSBjb2RlIGFyY2hp
dmUuCiAgICBBZGRlZCBhIHBhdGNoIHRvIGNvcmVjdCBtYWtlZmlsZSBzeXN0ZW0uCiAgICBUZXN0
ZWQgdXNpbmcgZGFzaCBhcyBzaGVsbC4KClNpZ25lZC1vZmYtYnk6IENyaXN0aWFuIElvcmdhIDxj
cmlzdGlhbi5pb3JnYUBpbnRlbC5jb20+CgpJbmRleDogbHRwLTIwMTIwNDAxL01ha2VmaWxlCj09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0KLS0tIGx0cC0yMDEyMDQwMS5vcmlnL01ha2VmaWxlCisrKyBsdHAtMjAxMjA0MDEv
TWFrZWZpbGUKQEAgLTE3Myw3ICsxNzMsNyBAQCBTUkNESVJfSU5TVEFMTF9UQVJHRVRTCTo9ICQo
U1JDRElSX0lOU1RBCiAjCiAuUEhPTlk6IFZlcnNpb24KIFZlcnNpb246Ci0JaWYgZ2l0IGRlc2Ny
aWJlICY+IC9kZXYvbnVsbDsgdGhlbiBcCisJaWYgZ2l0IGRlc2NyaWJlID4gL2Rldi9udWxsIDI+
JjE7IHRoZW4gXAogCQlnaXQgZGVzY3JpYmUgPiAiJEAiOyBcCiAJZWxzZSBcCiAJCWNwIFZFUlNJ
T04gIiRAIjsgXAo=

--_004_969F26A8BAB325438E7EB80D3C3134FB16155EEEIRSMSX102gercor_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--_004_969F26A8BAB325438E7EB80D3C3134FB16155EEEIRSMSX102gercor_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--_004_969F26A8BAB325438E7EB80D3C3134FB16155EEEIRSMSX102gercor_--

