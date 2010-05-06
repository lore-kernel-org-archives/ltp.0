Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <suzuki@in.ibm.com>) id 1O9v90-0006Km-O0
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 07:05:14 +0000
Received: from e23smtp09.au.ibm.com ([202.81.31.142])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O9v8u-0003Wc-M3
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 07:05:14 +0000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp09.au.ibm.com (8.14.3/8.13.1) with ESMTP id o46751lr011800
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 17:05:01 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o46751gt1826852
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 17:05:01 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o46750dX005545
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 17:05:01 +1000
Message-ID: <4BE26A1A.1000102@in.ibm.com>
Date: Thu, 06 May 2010 12:34:58 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
References: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
	<20100506065801.23879.92449.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20100506065801.23879.92449.sendpatchset@subratamodak.linux.ibm.com>
Content-Type: multipart/mixed; boundary="------------000306090300040409020709"
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: Linus Test Project <ltp-list@lists.sourceforge.net>, B N Poornima <bnpoorni@in.ibm.com>, Sachin P Sant <ssant@in.ibm.com>, Sharyathi Nagesh <sharyath@in.ibm.com>

This is a multi-part message in MIME format.
--------------000306090300040409020709
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by e23smtp09.au.ibm.com id
	o46751lr011800

On =E0=B4=B5=E0=B5=8D=E0=B4=AF=E0=B4=BE=E0=B4=B4=E0=B4=82 06 =E0=B4=AE=E0=
=B5=86=E0=B4=AF=E0=B5=8D 2010 12:28 =E0=B4=B5=E0=B5=88=E0=B4=95=E0=B5=81,=
 Subrata Modak wrote:
> Subject: LTPE=1B clock_gettime03 fails
>
> Issue Description below:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> # ./runltp -s clock_gettime03
> <<<test_output>>>
> clock_gettime03    1  TPASS  :  got expected failure: TEST_ERRNO=3DEFAU=
LT(14):
> Bad address
> clock_gettime03    2  TPASS  :  got expected failure: TEST_ERRNO=3DEFAU=
LT(14):
> Bad address
> clock_gettime03    3  TFAIL  :  failed to produce expected error [expec=
ted
> errno =3D 22 (Invalid argument), TEST_RETURN =3D 0]: TEST_ERRNO=3D???(0=
): Success
> clock_gettime03    4  TFAIL  :  failed to produce expected error [expec=
ted
> errno =3D 22 (Invalid argument), TEST_RETURN =3D 0]: TEST_ERRNO=3D???(0=
): Success
> clock_gettime03    5  TPASS  :  got expected failure: TEST_ERRNO=3DEFAU=
LT(14):
> Bad address
> clock_gettime03    6  TPASS  :  got expected failure: TEST_ERRNO=3DEFAU=
LT(14):
> Bad address
> <<<execution_status>>>
> initiation_status=3D"ok"
> duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=3Dno
> cutime=3D0 cstime=3D1
> <<<test_end>>>
>
> SUZUKI K. POULOSE gave the following patch already. Not sure if it is
> discussed in the mailing list:
> --- include/common_timers.h.orig        2010-04-30 12:39:08.000000000 +=
0000
> +++ include/common_timers.h     2010-04-30 12:39:46.000000000 +0000
> @@ -35,7 +35,8 @@ clock_t clock_list[] =3D {
>          CLOCK_THREAD_CPUTIME_ID,
>          CLOCK_MONOTONIC_RAW,
>   };
> -#define MAX_CLOCKS (sizeof(clock_list) / sizeof(*clock_list))
> +// #define MAX_CLOCKS (sizeof(clock_list) / sizeof(*clock_list))
> +#define MAX_CLOCKS 16
>
>   const char *get_clock_str(const int clock_id)
>   {
>
>
> The above patch fixes the problem. For more info, see linux/time.h for =
the
> MAX_CLOCKS value.

The above patch indeed fixes the two issues, but it causes a regression=20
for timer_create02 testcase. The complete patch is attached with this.


>
> Regards--
> Subrata
>


--------------000306090300040409020709
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
IChVc2VkIGFzIENMT0NLU19ERUZJTkVEIGJlbG93KQoKU2lnbmVkLW9mZi1ieTogU3V6dWtp
IEsgUCA8c3V6dWtpQGluLmlibS5jb20+CgpJbmRleDogbHRwL3Rlc3RjYXNlcy9rZXJuZWwv
dGltZXJzL2luY2x1ZGUvY29tbW9uX3RpbWVycy5oCj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGx0cC5v
cmlnL3Rlc3RjYXNlcy9rZXJuZWwvdGltZXJzL2luY2x1ZGUvY29tbW9uX3RpbWVycy5oCTIw
MDktMTItMDYgMjA6NTM6NDQuMDAwMDAwMDAwICswMDAwCisrKyBsdHAvdGVzdGNhc2VzL2tl
cm5lbC90aW1lcnMvaW5jbHVkZS9jb21tb25fdGltZXJzLmgJMjAxMC0wNS0wNSAwOToxNzo1
OC4wMDAwMDAwMDAgKzAwMDAKQEAgLTM1LDcgKzM1LDEwIEBACiAJQ0xPQ0tfVEhSRUFEX0NQ
VVRJTUVfSUQsCiAJQ0xPQ0tfTU9OT1RPTklDX1JBVywKIH07Ci0jZGVmaW5lIE1BWF9DTE9D
S1MgKHNpemVvZihjbG9ja19saXN0KSAvIHNpemVvZigqY2xvY2tfbGlzdCkpCisvKiBDTE9D
S1NfREVGSU5FRCBpcyB0aGUgbnVtYmVyIG9mIGNsb2NrIHNvdXJjZXMgZGVmaW5lZCBmb3Ig
c3VyZSAqLworI2RlZmluZSBDTE9DS1NfREVGSU5FRCAoc2l6ZW9mKGNsb2NrX2xpc3QpIC8g
c2l6ZW9mKCpjbG9ja19saXN0KSkKKy8qIE1BWF9DTE9DS1MgaXMgdGhlIG1heGltdW0gbnVt
YmVyIG9mIGNsb2NrIHNvdXJjZXMgc3VwcG9ydGVkIGJ5IGtlcm5lbCAqLworI2RlZmluZSBN
QVhfQ0xPQ0tTIDE2CiAKIGNvbnN0IGNoYXIgKmdldF9jbG9ja19zdHIoY29uc3QgaW50IGNs
b2NrX2lkKQogewpJbmRleDogbHRwL3Rlc3RjYXNlcy9rZXJuZWwvdGltZXJzL3RpbWVyX2Ny
ZWF0ZS90aW1lcl9jcmVhdGUwMi5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGx0cC5vcmlnL3Rlc3Rj
YXNlcy9rZXJuZWwvdGltZXJzL3RpbWVyX2NyZWF0ZS90aW1lcl9jcmVhdGUwMi5jCTIwMTAt
MDUtMDUgMDk6MTg6MjEuMDAwMDAwMDAwICswMDAwCisrKyBsdHAvdGVzdGNhc2VzL2tlcm5l
bC90aW1lcnMvdGltZXJfY3JlYXRlL3RpbWVyX2NyZWF0ZTAyLmMJMjAxMC0wNS0wNSAwOTox
ODozOC4wMDAwMDAwMDAgKzAwMDAKQEAgLTExMyw3ICsxMTMsNyBAQAogCiAJCQlzZXR1cF90
ZXN0KGkpOwogCi0JCQlmb3IgKGogPSAwOyBqIDwgTUFYX0NMT0NLUzsgKytqKSB7CisJCQlm
b3IgKGogPSAwOyBqIDwgQ0xPQ0tTX0RFRklORUQ7ICsraikgewogCiAJCQkJaWYgKHN0cnN0
cihnZXRfY2xvY2tfc3RyKGNsb2NrX2xpc3Rbal0pLAogCQkJCQkJIkNQVVRJTUVfSUQiKSkg
ewo=
--------------000306090300040409020709
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--------------000306090300040409020709
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------000306090300040409020709--

