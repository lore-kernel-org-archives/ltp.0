Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yicheng.wang@huawei.com>) id 1SpDpJ-00071Q-Da
	for ltp-list@lists.sourceforge.net; Thu, 12 Jul 2012 07:28:41 +0000
Received: from szxga01-in.huawei.com ([119.145.14.64])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SpDpG-0005Cy-Rh
	for ltp-list@lists.sourceforge.net; Thu, 12 Jul 2012 07:28:41 +0000
From: Wangyicheng <yicheng.wang@huawei.com>
Date: Thu, 12 Jul 2012 07:14:13 +0000
Message-ID: <9D7565DAE340BD42B8D00446E021992C28ABAD91@SZXEML506-MBS.china.huawei.com>
Content-Language: zh-CN
Content-Type: multipart/mixed;
	boundary="_004_9D7565DAE340BD42B8D00446E021992C28ABAD91SZXEML506MBSchi_"
MIME-Version: 1.0
Subject: [LTP] testcases/kernel/syscalls/mount test cases of mount2 and
 mount3 faild in JUNE 2012 STABLE :ltp-full-20120614
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
Cc: Dingguofu <dingguofu@huawei.com>

--_004_9D7565DAE340BD42B8D00446E021992C28ABAD91SZXEML506MBSchi_
Content-Type: multipart/alternative;
	boundary="_000_9D7565DAE340BD42B8D00446E021992C28ABAD91SZXEML506MBSchi_"

--_000_9D7565DAE340BD42B8D00446E021992C28ABAD91SZXEML506MBSchi_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SGk6DQogIFdoZW4gSSBydW4gbHRwIHRlc3RjYXNlcyAodGhlIGxhdGVzdCB2ZXJzaW9uLCBKVU5F
IDIwMTIgU1RBQkxFIDpsdHAtZnVsbC0yMDEyMDYxNCksSSBmaW5kIHRvdyB0ZXN0Y2FzZXMgYXJl
IGJyb2tlbiggbW91bnQyIGFuZCBtb3VudDMgaW4gIiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L21vdW50IiBkaXJlY3RvcnkpOg0KDQoNCiMgLi9tb3VudDAyIC1EIC9kZXYvbG9vcDIgLVQgZXh0
Mw0KbW91bnQwMiAgICAgMSAgVFBBU1MgIDogIG1vdW50IGdvdCBleHBlY3RlZCBmYWlsdXJlOiBl
cnJubz1FTk9ERVYoMTkpOiBObyBzdWNoIGRldmljZQ0KbW91bnQwMiAgICAgMiAgVFBBU1MgIDog
IG1vdW50IGdvdCBleHBlY3RlZCBmYWlsdXJlOiBlcnJubz1FTk9UQkxLKDE1KTogQmxvY2sgZGV2
aWNlIHJlcXVpcmVkDQptb3VudDAyICAgICAzICBUUEFTUyAgOiAgbW91bnQgZ290IGV4cGVjdGVk
IGZhaWx1cmU6IGVycm5vPUVCVVNZKDE2KTogRGV2aWNlIG9yIHJlc291cmNlIGJ1c3kNCm1vdW50
MDIgICAgIDQgIFRCUk9LICA6ICB1bW91bnQgb2YgbW50XzE4NjIwIGZhaWxlZDogZXJybm89RUJV
U1koMTYpOiBEZXZpY2Ugb3IgcmVzb3VyY2UgYnVzeQ0KbW91bnQwMiAgICAgNSAgVEJST0sgIDog
IFJlbWFpbmluZyBjYXNlcyBicm9rZW4NCm1vdW50MDIgICAgIDAgIFRXQVJOICA6ICB0c3Rfcm1k
aXI6IHJtb2JqKC90bXAvbW91U3lQYW8xKSBmYWlsZWQ6IHJlbW92ZSgvdG1wL21vdVN5UGFvMS9t
bnRfMTg2MjApIGZhaWxlZDsgZXJybm89MTY6IERldmljZSBvciByZXNvdXJjZSBidXN5DQoNCiMg
Li9tb3VudDAzIC1EIC9kZXYvbG9vcDIgLVQgZXh0Mw0KbW91bnQwMyAgICAgMSAgVEJST0sgIDog
IHN0YXQgZm9yIHNldHVpZF90ZXN0IGZhaWxlZA0KbW91bnQwMyAgICAgMiAgVEJST0sgIDogIFJl
bWFpbmluZyBjYXNlcyBicm9rZW4NCg0KDQpJbiBtb3VudDAyLmMsIHRoZSBnbG9iYWwgYXJyYXkg
dmFyaWFibGUgZXhwX2Vub3MgaXMgZGVmaW5lZCBhcyA6DQogICBzdGF0aWMgaW50IGV4cF9lbm9z
W10gPSB7IEVOT0RFViwgRU5PVEJMSywgRUJVU1ksIEVJTlZBTCwgRUZBVUxULCBFTkFNRVRPT0xP
TkcsIEVOT0VOVCwgRU5PVERJUiwgMH07DQpUaGVyZSBhcmUgZWdpaHQgaXRlbXMgaW4gdGhlIGV4
cF9lbm9zLCBidXQgdGhlIHZhbHVlIG9mIFRTVF9UT1RBTCBpcyAxMywgaXQgbWVhbnMgdGhlcmUg
YXJlIDEzIGNoZWNrcG9pbnRzIGludCB0aGUgdGVzdGNhc2UuICBBcyBhIHJlc3VsdCAsaW4gdGhl
IHNldHVwX3Rlc3QgZnVuY3Rpb24gLCB0aGVyZSBhcmUgMTMgc3dpdGNoLWNhc2VzICggY2FzZSAw
oaJjYXNlMSAuLi4gY2FzZSAxMikNCkJ1dCB0aGUgbnVtYmVyIG9mIHRoZSBleHBlY3QgcmVzdWx0
IGluIHRoZSBleHBfZW5vcyBhcnJheSBpcyBtaXNtYXRjaCB3aXRoIHRoZSBudW1iZXIgb2YgY2hl
Y2twb2ludCwgc28gdGhlIFRCUk9LICBoYXBwZW5kLg0KDQpJbiBtb3VudDAzLmMsIHRoZXJlIGFy
ZSB0aHJlZSBpc3N1ZXM6DQogIDGhokluIHNldHVwIGZ1bmN0aW9uLCAgdGhlIHNldHVpZF90ZXN0
IGZpbGUgaXMgaW4gdGhlIHRlc3Rob21lX3BhdGggaW5zdGVhZCBvZiB0aGUgdGVtcG9yYXJ5IGRp
cmVjdG9yeSBQYXRoX25hbWUuIEl0IHJlc3VsdHMgInN0YXQgZm9yIHNldHVpZF90ZXN0IGZhaWxl
ZCINCiAgMqGiSW4gc2V0dXAgZnVuY3Rpb24sICBzbnByaW50ZihQYXRoX25hbWUsIFBBVEhfTUFY
LCAiJXMvJXMvIiwgUGF0aF9uYW1lLCBtbnRwb2ludCmjrCBpdCBjYW4gbm90IGltcGxlbWVudCBh
cHBlbmRpbmcgdGhlIG1udHBvaW50IHN0cmluZyB0byB0aGUgUGF0aF9uYW1lIHN0cmluZzsNCiAg
M6GiSW4gdGVzdF9yd2ZsYWcgZnVuY3Rpb24sIGluIHRoZSBwYXJ0IG9mICJjYXNlIDIiKGF0IGxp
bmUgMjgwIGluIG1vdW50MDMuYyksIGlmIHRoZSAiZXhlY2xwKGZpbGUsIGJhc2VuYW1lKGZpbGUp
LCBOVUxMKSIgd2lsbCByZXR1cm4gKGFjdHVhbGx5IGl0IHdpbGwgcmV0dXJuKSwNCiAgICAgdGhl
IHJldHVybiB2YWx1ZSBvZiB0ZXN0X3J3ZmxhZyBpcyBhbHdheXMgMSAoMSBtZWFucyBmYWlsKSxz
byB0aGUgdGVzdGNhc2UgaXMgYWx3YXlzIGZhaWxlZDsgQW5vdGhlciBoYW5kLCBpZiBpdCB3aWxs
IG5vdCByZXR1cm4gKGlmIGtlcm5lbCBidWcgZXhpc3RzKSwgdGhlIHByb2Nlc3MNCiAgICAgd2ls
bCB0ZXJtaW5hdGUgdW5leHBlY3RlZGx5Lg0KDQoNCkkgZml4IHRoZW0gaW4gdGhlIHBhdGNoIChT
ZWUgdGhlIGF0dGFjaG1lbnQpLCBhbmQgYm90aCBvZiB0aGUgdG93IHRlc3RjYXNlIGNhbiBnZXQg
cGFzcy4gUGxzIGNoZWNrIHRoZSBwYXRjaCBhdHRhY2htZW50ZWQuDQoNCg0KDQpUaGlzIGUtbWFp
bCBhbmQgaXRzIGF0dGFjaG1lbnRzIGNvbnRhaW4gY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGZy
b20gSFVBV0VJLCB3aGljaA0KaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIHBlcnNvbiBvciBlbnRp
dHkgd2hvc2UgYWRkcmVzcyBpcyBsaXN0ZWQgYWJvdmUuIEFueSB1c2Ugb2YgdGhlDQppbmZvcm1h
dGlvbiBjb250YWluZWQgaGVyZWluIGluIGFueSB3YXkgKGluY2x1ZGluZywgYnV0IG5vdCBsaW1p
dGVkIHRvLCB0b3RhbCBvciBwYXJ0aWFsDQpkaXNjbG9zdXJlLCByZXByb2R1Y3Rpb24sIG9yIGRp
c3NlbWluYXRpb24pIGJ5IHBlcnNvbnMgb3RoZXIgdGhhbiB0aGUgaW50ZW5kZWQNCnJlY2lwaWVu
dChzKSBpcyBwcm9oaWJpdGVkLiBJZiB5b3UgcmVjZWl2ZSB0aGlzIGUtbWFpbCBpbiBlcnJvciwg
cGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGJ5DQpwaG9uZSBvciBlbWFpbCBpbW1lZGlhdGVseSBh
bmQgZGVsZXRlIGl0IQ0K

--_000_9D7565DAE340BD42B8D00446E021992C28ABAD91SZXEML506MBSchi_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 12 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:=CB=CE=CC=E5;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@=CB=CE=CC=E5";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
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
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"blue" vlink=3D"purple" style=3D"text-justify-t=
rim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:=CB=CE=
=CC=E5;color:black">Hi:<o:p></o:p></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:=CB=CE=
=CC=E5;color:black">&nbsp; When I run ltp testcases (the latest version, JU=
NE 2012 STABLE :ltp-full-20120614),I find tow testcases are
 broken( mount2 and mount3 in &quot; testcases/kernel/syscalls/mount&quot; =
directory):<o:p></o:p></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:=CB=CE=
=CC=E5;color:black"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:=CB=CE=
=CC=E5;color:black"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:=CB=CE=
=CC=E5;color:black"># ./mount02 -D /dev/loop2 -T ext3<o:p></o:p></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:=CB=CE=
=CC=E5;color:black">mount02&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp; TPASS&nbsp; :&n=
bsp; mount got expected failure: errno=3DENODEV(19): No such device<o:p></o=
:p></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:=CB=CE=
=CC=E5;color:black">mount02&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp; TPASS&nbsp; :&n=
bsp; mount got expected failure: errno=3DENOTBLK(15): Block device required=
<o:p></o:p></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:=CB=CE=
=CC=E5;color:black">mount02&nbsp;&nbsp;&nbsp;&nbsp; 3&nbsp; TPASS&nbsp; :&n=
bsp; mount got expected failure: errno=3DEBUSY(16): Device or resource busy=
<o:p></o:p></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:=CB=CE=
=CC=E5;color:black">mount02&nbsp;&nbsp;&nbsp;&nbsp; 4&nbsp; TBROK&nbsp; :&n=
bsp; umount of mnt_18620 failed: errno=3DEBUSY(16): Device or resource busy=
<o:p></o:p></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:=CB=CE=
=CC=E5;color:black">mount02&nbsp;&nbsp;&nbsp;&nbsp; 5&nbsp; TBROK&nbsp; :&n=
bsp; Remaining cases broken<o:p></o:p></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:=CB=CE=
=CC=E5;color:black">mount02&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp; TWARN&nbsp; :&n=
bsp; tst_rmdir: rmobj(/tmp/mouSyPao1) failed: remove(/tmp/mouSyPao1/mnt_186=
20) failed; errno=3D16:
 Device or resource busy <o:p></o:p></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:=CB=CE=
=CC=E5;color:black"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:=CB=CE=
=CC=E5;color:black"># ./mount03 -D /dev/loop2 -T ext3<o:p></o:p></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:=CB=CE=
=CC=E5;color:black">mount03&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp; TBROK&nbsp; :&n=
bsp; stat for setuid_test failed<o:p></o:p></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:=CB=CE=
=CC=E5;color:black">mount03&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp; TBROK&nbsp; :&n=
bsp; Remaining cases broken<o:p></o:p></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:=CB=CE=
=CC=E5;color:black"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:=CB=CE=
=CC=E5;color:black"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:=CB=CE=
=CC=E5;color:black">In mount02.c, the global array variable exp_enos is def=
ined as :<o:p></o:p></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:=CB=CE=
=CC=E5;color:black">&nbsp;&nbsp; static int exp_enos[] =3D { ENODEV, ENOTBL=
K, EBUSY, EINVAL, EFAULT, ENAMETOOLONG, ENOENT, ENOTDIR, 0};<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:=CB=CE=
=CC=E5;color:black">There are egiht items in the exp_enos, but the value of=
 TST_TOTAL is 13, it means there are 13 checkpoints int
 the testcase.&nbsp; As a result ,in the setup_test function , there are 13=
 switch-cases ( case 0</span><span style=3D"font-size:10.0pt;font-family:=
=CB=CE=CC=E5;color:black">=A1=A2<span lang=3D"EN-US">case1 ... case 12)<o:p=
></o:p></span></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:=CB=CE=
=CC=E5;color:black">But the number of the expect result in the exp_enos arr=
ay is mismatch with the number of checkpoint, so the
 TBROK&nbsp; happend. <o:p></o:p></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:=CB=CE=
=CC=E5;color:black"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:=CB=CE=
=CC=E5;color:black">In mount03.c, there are three issues:<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:=CB=CE=
=CC=E5;color:black">&nbsp; 1</span><span style=3D"font-size:10.0pt;font-fam=
ily:=CB=CE=CC=E5;color:black">=A1=A2<span lang=3D"EN-US">In setup function,=
&nbsp;
 the setuid_test file is in the testhome_path instead of the temporary dire=
ctory Path_name. It results &quot;stat for setuid_test failed&quot;<o:p></o=
:p></span></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:=CB=CE=
=CC=E5;color:black">&nbsp; 2</span><span style=3D"font-size:10.0pt;font-fam=
ily:=CB=CE=CC=E5;color:black">=A1=A2<span lang=3D"EN-US">In setup function,=
&nbsp;
 snprintf(Path_name, PATH_MAX, &quot;%s/%s/&quot;, Path_name, mntpoint)</sp=
an>=A3=AC<span lang=3D"EN-US"> it can not implement appending the mntpoint =
string to the Path_name string;<o:p></o:p></span></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:=CB=CE=
=CC=E5;color:black">&nbsp; 3</span><span style=3D"font-size:10.0pt;font-fam=
ily:=CB=CE=CC=E5;color:black">=A1=A2<span lang=3D"EN-US">In test_rwflag fun=
ction,
 in the part of &quot;case 2&quot;(at line 280 in mount03.c), if the &quot;=
execlp(file, basename(file), NULL)&quot; will return (actually it will retu=
rn),<o:p></o:p></span></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:=CB=CE=
=CC=E5;color:black">&nbsp;&nbsp;&nbsp;&nbsp; the return value of test_rwfla=
g is always 1 (1 means fail),so the testcase is always failed; Another hand=
,
 if it will not return (if kernel bug exists), the process <o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:=CB=CE=
=CC=E5;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;will terminate unexpected=
ly.<o:p></o:p></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:=CB=CE=
=CC=E5;color:black"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:=CB=CE=
=CC=E5;color:black"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:=CB=CE=
=CC=E5;color:black">I fix them in the patch (See the attachment), and both =
of the tow testcase can get pass. Pls check the patch
 attachmented.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:7.5pt;font-f=
amily:&quot;Arial&quot;,&quot;sans-serif&quot;;color:gray"><o:p>&nbsp;</o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:7.5pt;font-f=
amily:&quot;Arial&quot;,&quot;sans-serif&quot;;color:gray"><o:p>&nbsp;</o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:7.5pt;font-f=
amily:&quot;Arial&quot;,&quot;sans-serif&quot;;color:gray">This e-mail and =
its attachments contain confidential information from HUAWEI, which
<br>
is intended only for the person or entity whose address is listed above. An=
y use of the
<br>
information contained herein in any way (including, but not limited to, tot=
al or partial
<br>
disclosure, reproduction, or dissemination) by persons other than the inten=
ded <br>
recipient(s) is prohibited. If you receive this e-mail in error, please not=
ify the sender by
<br>
phone or email immediately and delete it!</span><span lang=3D"EN-US"><o:p><=
/o:p></span></p>
</div>
</body>
</html>

--_000_9D7565DAE340BD42B8D00446E021992C28ABAD91SZXEML506MBSchi_--

--_004_9D7565DAE340BD42B8D00446E021992C28ABAD91SZXEML506MBSchi_
Content-Type: application/octet-stream; name="fix_mount2_mount3_bug.patch"
Content-Description: fix_mount2_mount3_bug.patch
Content-Disposition: attachment; filename="fix_mount2_mount3_bug.patch";
	size=2601; creation-date="Thu, 12 Jul 2012 03:16:47 GMT";
	modification-date="Thu, 12 Jul 2012 03:16:47 GMT"
Content-Transfer-Encoding: base64

ZGlmZiAtdU5yIGx0cC1mdWxsLTIwMTIwNjE0L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW91
bnQvbW91bnQwMi5jIGx0cC1mdWxsLTIwMTIwNjE0LmJ1Z2ZpeC90ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL21vdW50L21vdW50MDIuYwotLS0gbHRwLWZ1bGwtMjAxMjA2MTQvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9tb3VudC9tb3VudDAyLmMJMjAxMi0wNy0xMiAxMDo1OToyOS4wMDAwMDAw
MDAgKzA4MDAKKysrIGx0cC1mdWxsLTIwMTIwNjE0LmJ1Z2ZpeC90ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL21vdW50L21vdW50MDIuYwkyMDEyLTA3LTEyIDExOjAxOjM3LjAwMDAwMDAwMCArMDgw
MApAQCAtMTIzLDggKzEyMyw4IEBACiBzdGF0aWMgaW50IFRmbGFnID0gMDsKIHN0YXRpYyBpbnQg
RGZsYWcgPSAwOwogCi1zdGF0aWMgaW50IGV4cF9lbm9zW10gPSB7IEVOT0RFViwgRU5PVEJMSywg
RUJVU1ksIEVJTlZBTCwgRUZBVUxULCBFTkFNRVRPT0xPTkcsCi0JRU5PRU5ULCBFTk9URElSLCAw
CitzdGF0aWMgaW50IGV4cF9lbm9zW10gPSB7IEVOT0RFViwgRU5PVEJMSywgRUJVU1ksIEVCVVNZ
LCBFSU5WQUwsIEVJTlZBTCwgRUlOVkFMLEVGQVVMVCwgRUZBVUxULCBFTkFNRVRPT0xPTkcsCisg
ICAgICAgIEVOT0VOVCwgRU5PRU5ULCBFTk9URElSLCAwCiB9OwogCiBpbnQgVFNUX1RPVEFMID0g
KHNpemVvZihleHBfZW5vcykgLyBzaXplb2YoZXhwX2Vub3NbMF0pKSAtIDE7CkBAIC00MjcsNCAr
NDI3LDQgQEAKIAlwcmludGYoIi1UIHR5cGUJICA6IHNwZWNpZmllcyB0aGUgdHlwZSBvZiBmaWxl
c3lzdGVtIHRvIGJlIG1vdW50ZWQuIgogCSAgICAgICAiIERlZmF1bHQgZXh0Mi4gXG4iKTsKIAlw
cmludGYoIi1EIGRldmljZSA6IGRldmljZSB1c2VkIGZvciBtb3VudGluZyBcbiIpOwotfQpcIE5v
IG5ld2xpbmUgYXQgZW5kIG9mIGZpbGUKK30KZGlmZiAtdU5yIGx0cC1mdWxsLTIwMTIwNjE0L3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW91bnQvbW91bnQwMy5jIGx0cC1mdWxsLTIwMTIwNjE0
LmJ1Z2ZpeC90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21vdW50L21vdW50MDMuYwotLS0gbHRw
LWZ1bGwtMjAxMjA2MTQvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tb3VudC9tb3VudDAzLmMJ
MjAxMi0wNy0xMiAxMDo1OToyOS4wMDAwMDAwMDAgKzA4MDAKKysrIGx0cC1mdWxsLTIwMTIwNjE0
LmJ1Z2ZpeC90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21vdW50L21vdW50MDMuYwkyMDEyLTA3
LTEyIDExOjA5OjU3LjAwMDAwMDAwMCArMDgwMApAQCAtMjc3LDcgKzI3Nyw5IEBACiAJCQl0c3Rf
cmVzbShUV0FSTnxURVJSTk8sICJvcGVuaW5nICVzIGZhaWxlZCIsIGZpbGUpOwogCQl9IGVsc2Ug
ewogCQkJY2xvc2UoZmQpOwotCQkJZXhlY2xwKGZpbGUsIGJhc2VuYW1lKGZpbGUpLCBOVUxMKTsK
KwkJCWlmKHN5c3RlbShmaWxlKSkgeworCQkJCXJldHVybiAwOworCQkJfQogCQl9CiAJCXJldHVy
biAxOwogCWNhc2UgMzoKQEAgLTQ2MCwxMSArNDYyLDE4IEBACiAJaWYgKGdldGN3ZChQYXRoX25h
bWUsIHNpemVvZihQYXRoX25hbWUpKSA9PSBOVUxMKSB7CiAJCXRzdF9icmttKFRCUk9LLCBjbGVh
bnVwLCAiZ2V0Y3dkIGZhaWxlZCIpOwogCX0KKwkvKgorCSAqIHVuZGVyIHRlbXBvcmFyeSBkaXJl
Y3RvcnkKKwkgKi8KKwlzbnByaW50ZihQYXRoX25hbWUgKyBzdHJsZW4oUGF0aF9uYW1lKSwgUEFU
SF9NQVgsICIvJXMvIiwgbW50cG9pbnQpOwogCWlmIChjaG1vZChQYXRoX25hbWUsIERJUl9NT0RF
KSAhPSAwKSB7CiAJCXRzdF9icmttKFRCUk9LLCBjbGVhbnVwLCAiY2htb2QoJXMsICUjbykgZmFp
bGVkIiwKIAkJICAgIFBhdGhfbmFtZSwgRElSX01PREUpOwogCX0KLQlzbnByaW50ZihmaWxlLCBQ
QVRIX01BWCwgIiVzc2V0dWlkX3Rlc3QiLCBQYXRoX25hbWUpOworCisJc25wcmludGYodGVzdGhv
bWVfcGF0aCwgUEFUSF9NQVgsICIlcy9zZXR1aWRfdGVzdCIsIHRlc3RfaG9tZSk7CisJCQorCXNu
cHJpbnRmKGZpbGUsIFBBVEhfTUFYLCAiJXMiLCB0ZXN0aG9tZV9wYXRoKTsKIAlpZiAoc3RhdChm
aWxlLCAmc2V0dWlkX3Rlc3Rfc3RhdCkgPCAwKSB7CiAJCXRzdF9icmttKFRCUk9LLCBjbGVhbnVw
LCAic3RhdCBmb3Igc2V0dWlkX3Rlc3QgZmFpbGVkIik7CiAJfSBlbHNlIHsKQEAgLTQ4MCwxNCAr
NDg5LDYgQEAKIAkJfQogCX0KIAotCS8qCi0JICogdW5kZXIgdGVtcG9yYXJ5IGRpcmVjdG9yeQot
CSAqLwotCXNucHJpbnRmKFBhdGhfbmFtZSwgUEFUSF9NQVgsICIlcy8lcy8iLCBQYXRoX25hbWUs
IG1udHBvaW50KTsKLQotCXN0cmNweSh0ZXN0aG9tZV9wYXRoLCB0ZXN0X2hvbWUpOwotCXN0cmNh
dCh0ZXN0aG9tZV9wYXRoLCAiL3NldHVpZF90ZXN0Iik7Ci0KIAlURVNUX1BBVVNFOwogCiB9CkBA
IC01MTcsNCArNTE4LDQgQEAKIAlwcmludGYoIi1UIHR5cGUJICA6IHNwZWNpZmllcyB0aGUgdHlw
ZSBvZiBmaWxlc3lzdGVtIHRvIGJlIG1vdW50ZWQuIgogCSAgICAgICAiIERlZmF1bHQgZXh0Mi4g
XG4iKTsKIAlwcmludGYoIi1EIGRldmljZSA6IGRldmljZSB1c2VkIGZvciBtb3VudGluZyBcbiIp
OwotfQpcIE5vIG5ld2xpbmUgYXQgZW5kIG9mIGZpbGUKK30K

--_004_9D7565DAE340BD42B8D00446E021992C28ABAD91SZXEML506MBSchi_
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
--_004_9D7565DAE340BD42B8D00446E021992C28ABAD91SZXEML506MBSchi_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--_004_9D7565DAE340BD42B8D00446E021992C28ABAD91SZXEML506MBSchi_--

