Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <suzuki@in.ibm.com>) id 1OJTaH-0001Wm-DB
	for ltp-list@lists.sourceforge.net; Tue, 01 Jun 2010 15:40:53 +0000
Received: from e23smtp04.au.ibm.com ([202.81.31.146])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OJTaG-0001Zu-7f
	for ltp-list@lists.sourceforge.net; Tue, 01 Jun 2010 15:40:53 +0000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp04.au.ibm.com (8.14.4/8.13.1) with ESMTP id o51FabxJ014213
	for <ltp-list@lists.sourceforge.net>; Wed, 2 Jun 2010 01:36:37 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o51Feigp1421556
	for <ltp-list@lists.sourceforge.net>; Wed, 2 Jun 2010 01:40:44 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o51Feh7F019249
	for <ltp-list@lists.sourceforge.net>; Wed, 2 Jun 2010 01:40:44 +1000
Message-ID: <4C0529F8.8060906@in.ibm.com>
Date: Tue, 01 Jun 2010 21:10:40 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
References: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
	<20100506065801.23879.92449.sendpatchset@subratamodak.linux.ibm.com>
	<4BE26A1A.1000102@in.ibm.com>
	<239C044B-6014-4FA7-AC8B-6D71AFE8FEDA@gmail.com>
	<4BE285FF.9030104@in.ibm.com>
In-Reply-To: <4BE285FF.9030104@in.ibm.com>
Content-Type: multipart/mixed; boundary="------------020601030509040102090901"
Subject: Re: [LTP] [08/12 FAILURE] LTPE clock gettime03 fails
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: Linus Test Project <ltp-list@lists.sourceforge.net>, B N Poornima <bnpoorni@in.ibm.com>, Sachin P Sant <ssant@in.ibm.com>, Sharyathi Nagesh <sharyath@in.ibm.com>

This is a multi-part message in MIME format.
--------------020601030509040102090901
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by e23smtp04.au.ibm.com id
	o51FabxJ014213

On =E0=B4=B5=E0=B5=8D=E0=B4=AF=E0=B4=BE=E0=B4=B4=E0=B4=82 06 =E0=B4=AE=E0=
=B5=86=E0=B4=AF=E0=B5=8D 2010 02:33 =E0=B4=B5=E0=B5=88=E0=B4=95=E0=B5=81,=
 Suzuki Poulose wrote:
> On =E0=B4=B5=E0=B5=8D=E0=B4=AF=E0=B4=BE=E0=B4=B4=E0=B4=82 06 =E0=B4=AE=E0=
=B5=86=E0=B4=AF=E0=B5=8D 2010 01:25 =E0=B4=B5=E0=B5=88=E0=B4=95=E0=B5=81,=
 Garrett Cooper wrote:
>> On May 6, 2010, at 12:04 AM, Suzuki Poulose wrote:
>>
>>> <fix-timer-tests-bad-header.diff>
>>
>> Maybe a better solution would be to NULL terminate the array (well, or
>> do similar)? Using two units of measurement just seems like it'd
>> complicate how things are being performed...
>
> Used MAX_CLOCKS to mark the end of clock list array. Patch attached.

Just realized that, I sent the very old patch not the updated one. Here=20
is the updated one:


>
>
> Thanks
>
> Suzuki
>> Thanks,
>> -Garrett
>


--------------020601030509040102090901
Content-Type: text/plain;
 name="fix-timer-tests-bad-header.diff"
Content-Disposition: attachment;
 filename="fix-timer-tests-bad-header.diff"
Content-Transfer-Encoding: base64

VGhlIE1BWF9DTE9DS1Mgc3VwcG9ydGVkIGJ5IHRoZSBrZXJuZWwgaXMgMTYuIEJ1dCB0aGUg
a2VybmVsIG1heSBub3QgaGF2ZSBhbGwKdGhlIGNsb2NrIHNvdXJjZXMgZGVmaW5lZCBpbiB0
aGUgcmFuZ2UgMC0xNS4KCkhlbmNlLCB0byB0ZXN0IHdoZXRoZXIga2VybmVsIHJldHVybnMg
ZXJyb3IgZm9yIGFuIElOVkFMSUQgY2xvY2sgc291cmNlIGlkLAp3ZSBzaG91bGQgdXNlIHRo
ZSB1cHBlciBsaW1pdCBNQVhfQ0xPQ0tTICgxNiBhdCB0aGUgbW9tZW50KS4KCkJ1dCB0byB2
ZXJpZnkgdGhlIHRoZSBkZWZpbmVkIGNsb2NrcyB3b3JrIGZpbmUsIHdlIHNob3VsZCBsb29w
IHRocm91Z2ggdGhlICJsaXN0IgpvZiBjbG9jayBzb3VyY2VzIGRlZmluZWQgZm9yIHN1cmUu
IE1BWF9DTE9DS1MgbWFyc2sgdGhlIGVuZCBvZiB0aGUgY2xvY2sgc291cmNlcyBpbiB0aGUg
CmFycmF5LgoKU2lnbmVkLW9mZi1ieTogCVN1enVraSBLIFAgPHN1enVraUBpbi5pYm0uY29t
PgpDYzoJCUdhcnJldHQgQ29vcGVyIDx5YW5lZ29taUBnbWFpbC5jb20+CgpJbmRleDogbHRw
L3Rlc3RjYXNlcy9rZXJuZWwvdGltZXJzL2luY2x1ZGUvY29tbW9uX3RpbWVycy5oCj09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0KLS0tIGx0cC5vcmlnL3Rlc3RjYXNlcy9rZXJuZWwvdGltZXJzL2luY2x1ZGUv
Y29tbW9uX3RpbWVycy5oCTIwMTAtMDYtMDEgMTU6Mjg6MDQuMDAwMDAwMDAwICswMDAwCisr
KyBsdHAvdGVzdGNhc2VzL2tlcm5lbC90aW1lcnMvaW5jbHVkZS9jb21tb25fdGltZXJzLmgJ
MjAxMC0wNi0wMSAxNTozNDozMy4wMDAwMDAwMDAgKzAwMDAKQEAgLTI4LDE0ICsyOCwxOCBA
QAogI2lmbmRlZiBDTE9DS19NT05PVE9OSUNfUkFXCiAjZGVmaW5lIENMT0NLX01PTk9UT05J
Q19SQVcgNAogI2VuZGlmCisKKy8qIE1BWF9DTE9DS1MgaXMgdGhlIG1heGltdW0gbnVtYmVy
IG9mIGNsb2NrIHNvdXJjZXMgc3VwcG9ydGVkIGJ5IGtlcm5lbCAqLworI2RlZmluZSBNQVhf
Q0xPQ0tTIDE2CisKIGNsb2NrX3QgY2xvY2tfbGlzdFtdID0gewogCUNMT0NLX1JFQUxUSU1F
LAogCUNMT0NLX01PTk9UT05JQywKIAlDTE9DS19QUk9DRVNTX0NQVVRJTUVfSUQsCiAJQ0xP
Q0tfVEhSRUFEX0NQVVRJTUVfSUQsCiAJQ0xPQ0tfTU9OT1RPTklDX1JBVywKKwlNQVhfQ0xP
Q0tTCiB9OwotI2RlZmluZSBNQVhfQ0xPQ0tTIChzaXplb2YoY2xvY2tfbGlzdCkgLyBzaXpl
b2YoKmNsb2NrX2xpc3QpKQogCiBjb25zdCBjaGFyICpnZXRfY2xvY2tfc3RyKGNvbnN0IGlu
dCBjbG9ja19pZCkKIHsKSW5kZXg6IGx0cC90ZXN0Y2FzZXMva2VybmVsL3RpbWVycy90aW1l
cl9jcmVhdGUvdGltZXJfY3JlYXRlMDIuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsdHAub3JpZy90
ZXN0Y2FzZXMva2VybmVsL3RpbWVycy90aW1lcl9jcmVhdGUvdGltZXJfY3JlYXRlMDIuYwky
MDEwLTA2LTAxIDE1OjI4OjA0LjAwMDAwMDAwMCArMDAwMAorKysgbHRwL3Rlc3RjYXNlcy9r
ZXJuZWwvdGltZXJzL3RpbWVyX2NyZWF0ZS90aW1lcl9jcmVhdGUwMi5jCTIwMTAtMDYtMDEg
MTU6MzQ6NTYuMDAwMDAwMDAwICswMDAwCkBAIC0xMTMsNyArMTEzLDcgQEAKIAogCQkJc2V0
dXBfdGVzdChpKTsKIAotCQkJZm9yIChqID0gMDsgaiA8IE1BWF9DTE9DS1M7ICsraikgewor
CQkJZm9yIChqID0gMDsgY2xvY2tfbGlzdFtqXSAhPSBNQVhfQ0xPQ0tTOyArK2opIHsKIAog
CQkJCWlmIChzdHJzdHIoZ2V0X2Nsb2NrX3N0cihjbG9ja19saXN0W2pdKSwKIAkJCQkJCSJD
UFVUSU1FX0lEIikpIHsK
--------------020601030509040102090901
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------


--------------020601030509040102090901
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------020601030509040102090901--

