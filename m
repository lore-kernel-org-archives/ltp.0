Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <suzuki@in.ibm.com>) id 1O9x07-0001B6-M3
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 09:04:11 +0000
Received: from e23smtp04.au.ibm.com ([202.81.31.146])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O9x06-000279-Ho
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 09:04:11 +0000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp04.au.ibm.com (8.14.3/8.13.1) with ESMTP id o46904UO027310
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 19:00:04 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o468v81I1568886
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 18:57:08 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o46942ii001628
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 19:04:03 +1000
Message-ID: <4BE285FF.9030104@in.ibm.com>
Date: Thu, 06 May 2010 14:33:59 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
References: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
	<20100506065801.23879.92449.sendpatchset@subratamodak.linux.ibm.com>
	<4BE26A1A.1000102@in.ibm.com>
	<239C044B-6014-4FA7-AC8B-6D71AFE8FEDA@gmail.com>
In-Reply-To: <239C044B-6014-4FA7-AC8B-6D71AFE8FEDA@gmail.com>
Content-Type: multipart/mixed; boundary="------------030306090406030802010302"
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
--------------030306090406030802010302
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by e23smtp04.au.ibm.com id
	o46904UO027310

On =E0=B4=B5=E0=B5=8D=E0=B4=AF=E0=B4=BE=E0=B4=B4=E0=B4=82 06 =E0=B4=AE=E0=
=B5=86=E0=B4=AF=E0=B5=8D 2010 01:25 =E0=B4=B5=E0=B5=88=E0=B4=95=E0=B5=81,=
 Garrett Cooper wrote:
> On May 6, 2010, at 12:04 AM, Suzuki Poulose wrote:
>
>> <fix-timer-tests-bad-header.diff>
>
> 	Maybe a better solution would be to NULL terminate the array (well, or=
 do similar)? Using two units of measurement just seems like it'd complic=
ate how things are being performed...

Used MAX_CLOCKS to mark the end of clock list array. Patch attached.


Thanks

Suzuki
> Thanks,
> -Garrett


--------------030306090406030802010302
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
CmFycmF5LgoKU2lnbmVkLW9mZi1ieTogU3V6dWtpIEsgUCA8c3V6dWtpQGluLmlibS5jb20+
CgpJbmRleDogbHRwL3Rlc3RjYXNlcy9rZXJuZWwvdGltZXJzL2luY2x1ZGUvY29tbW9uX3Rp
bWVycy5oCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0KLS0tIGx0cC5vcmlnL3Rlc3RjYXNlcy9rZXJuZWwvdGlt
ZXJzL2luY2x1ZGUvY29tbW9uX3RpbWVycy5oCTIwMDktMTItMDYgMjA6NTM6NDQuMDAwMDAw
MDAwICswMDAwCisrKyBsdHAvdGVzdGNhc2VzL2tlcm5lbC90aW1lcnMvaW5jbHVkZS9jb21t
b25fdGltZXJzLmgJMjAxMC0wNS0wNSAwOToxNzo1OC4wMDAwMDAwMDAgKzAwMDAKQEAgLTM1
LDcgKzM1LDEwIEBACiAJQ0xPQ0tfVEhSRUFEX0NQVVRJTUVfSUQsCiAJQ0xPQ0tfTU9OT1RP
TklDX1JBVywKIH07Ci0jZGVmaW5lIE1BWF9DTE9DS1MgKHNpemVvZihjbG9ja19saXN0KSAv
IHNpemVvZigqY2xvY2tfbGlzdCkpCisvKiBDTE9DS1NfREVGSU5FRCBpcyB0aGUgbnVtYmVy
IG9mIGNsb2NrIHNvdXJjZXMgZGVmaW5lZCBmb3Igc3VyZSAqLworI2RlZmluZSBDTE9DS1Nf
REVGSU5FRCAoc2l6ZW9mKGNsb2NrX2xpc3QpIC8gc2l6ZW9mKCpjbG9ja19saXN0KSkKKy8q
IE1BWF9DTE9DS1MgaXMgdGhlIG1heGltdW0gbnVtYmVyIG9mIGNsb2NrIHNvdXJjZXMgc3Vw
cG9ydGVkIGJ5IGtlcm5lbCAqLworI2RlZmluZSBNQVhfQ0xPQ0tTIDE2CiAKIGNvbnN0IGNo
YXIgKmdldF9jbG9ja19zdHIoY29uc3QgaW50IGNsb2NrX2lkKQogewpJbmRleDogbHRwL3Rl
c3RjYXNlcy9rZXJuZWwvdGltZXJzL3RpbWVyX2NyZWF0ZS90aW1lcl9jcmVhdGUwMi5jCj09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT0KLS0tIGx0cC5vcmlnL3Rlc3RjYXNlcy9rZXJuZWwvdGltZXJzL3RpbWVy
X2NyZWF0ZS90aW1lcl9jcmVhdGUwMi5jCTIwMTAtMDUtMDUgMDk6MTg6MjEuMDAwMDAwMDAw
ICswMDAwCisrKyBsdHAvdGVzdGNhc2VzL2tlcm5lbC90aW1lcnMvdGltZXJfY3JlYXRlL3Rp
bWVyX2NyZWF0ZTAyLmMJMjAxMC0wNS0wNSAwOToxODozOC4wMDAwMDAwMDAgKzAwMDAKQEAg
LTExMyw3ICsxMTMsNyBAQAogCiAJCQlzZXR1cF90ZXN0KGkpOwogCi0JCQlmb3IgKGogPSAw
OyBqIDwgTUFYX0NMT0NLUzsgKytqKSB7CisJCQlmb3IgKGogPSAwOyBqIDwgQ0xPQ0tTX0RF
RklORUQ7ICsraikgewogCiAJCQkJaWYgKHN0cnN0cihnZXRfY2xvY2tfc3RyKGNsb2NrX2xp
c3Rbal0pLAogCQkJCQkJIkNQVVRJTUVfSUQiKSkgewo=
--------------030306090406030802010302
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--------------030306090406030802010302
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------030306090406030802010302--

