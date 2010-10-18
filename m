Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1P7mST-0007NI-Hy
	for ltp-list@lists.sourceforge.net; Mon, 18 Oct 2010 09:56:45 +0000
Received: from mail-yx0-f175.google.com ([209.85.213.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P7mSS-00040b-GJ
	for ltp-list@lists.sourceforge.net; Mon, 18 Oct 2010 09:56:45 +0000
Received: by yxt3 with SMTP id 3so300443yxt.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 18 Oct 2010 02:56:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4CBC1431.1080808@cn.fujitsu.com>
References: <4CBC1431.1080808@cn.fujitsu.com>
Date: Mon, 18 Oct 2010 02:56:39 -0700
Message-ID: <AANLkTinQjHvu=F1rnB19Bzv4g27anHt4QM9JJJAh_bBA@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Content-Type: multipart/mixed; boundary=90e6ba21236f4a09760492e131d1
Subject: Re: [LTP] [PATCH] open_posix_testsuite: Fix variable type error
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
To: Gui Jianfeng <guijianfeng@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

--90e6ba21236f4a09760492e131d1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 18, 2010 at 2:32 AM, Gui Jianfeng
<guijianfeng@cn.fujitsu.com> wrote:
> Hi
>
> Currently, the variable "timeout" type is int, We should make it to be "u=
nsigned long".
> Otherwise, we'll get an unexpected value in thread function, consequently=
, test fails.
>
> Signed-off-by: Gui Jianfeng <guijianfeng@cn.fujitsu.com>
> ---
> =A0.../functional/threads/pi_test/pitest-1.c =A0 =A0 =A0 =A0 =A0| =A0 =A0=
2 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/testcases/ /functional/threads/pi_test/pitest-1.c b/testcase=
s/open_posix_testsuite/functional/threads/pi_test/pitest-1.c
> index b8969a8..9fac992 100644
> --- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-1.=
c
> +++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-1.=
c
> @@ -296,7 +296,7 @@ int main(int argc, char **argv)
>
> =A0 =A0 =A0 =A0/* Start TB thread (boosting thread) */
> =A0 =A0 =A0 =A0DPRINTF(stderr,"Main Thread: start TB thread\n");
> - =A0 =A0 =A0 int timeout =3D multiplier * 20;
> + =A0 =A0 =A0 unsigned long timeout =3D multiplier * 20;
> =A0 =A0 =A0 =A0rc =3D pthread_create(&threadtb, &threadattr, thread_tb,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&timeout);
> =A0 =A0 =A0 =A0 if (rc !=3D 0) {

    Please try this patch out instead and let me know how it goes.
Thanks,
-Garrett

--90e6ba21236f4a09760492e131d1
Content-Type: application/octet-stream; name="pitest-1-use-time_t.diff"
Content-Disposition: attachment; filename="pitest-1-use-time_t.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gff657660

ZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9mdW5jdGlvbmFsL3Ro
cmVhZHMvcGlfdGVzdC9waXRlc3QtMS5jIGIvdGVzdGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1aXRl
L2Z1bmN0aW9uYWwvdGhyZWFkcy9waV90ZXN0L3BpdGVzdC0xLmMKaW5kZXggYjg5NjlhOC4uZmUw
M2NjZiAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1aXRlL2Z1bmN0aW9u
YWwvdGhyZWFkcy9waV90ZXN0L3BpdGVzdC0xLmMKKysrIGIvdGVzdGNhc2VzL29wZW5fcG9zaXhf
dGVzdHN1aXRlL2Z1bmN0aW9uYWwvdGhyZWFkcy9waV90ZXN0L3BpdGVzdC0xLmMKQEAgLTE5Nyw3
ICsxOTcsNyBAQCB2b2lkICp0aHJlYWRfc2FtcGxlKHZvaWQgKmFyZykKIAogdm9pZCAqdGhyZWFk
X3RiKHZvaWQgKmFyZykKIHsKLQl1bnNpZ25lZCBsb25nIHRpbWVvdXRzZWM7CisJdGltZV90IHRp
bWVvdXRzZWM7CiAJc3RydWN0IHRpbWVzcGVjIGJvb3N0X3RpbWU7CiAJZG91YmxlIHNlY29uZHMs
IHQwLCB0MTsKIAlpbnQgcmM7CkBAIC0yMDYsOCArMjA2LDcgQEAgdm9pZCAqdGhyZWFkX3RiKHZv
aWQgKmFyZykKIAkKIAlEUFJJTlRGKHN0ZG91dCwgIiNFVkVOVCAlZiBUQiBTdGFydHNcbiIsIHNl
Y29uZHNfcmVhZCgpIC0gYmFzZV90aW1lKTsKIAotCXRpbWVvdXRzZWMgPSAqKHVuc2lnbmVkIGxv
bmcqKSBhcmc7Ci0JYm9vc3RfdGltZS50dl9zZWMgPSB0aW1lKE5VTEwpICsgKHRpbWVfdCl0aW1l
b3V0c2VjOworCWJvb3N0X3RpbWUudHZfc2VjID0gdGltZShOVUxMKSArICooKHRpbWVfdCopIGFy
Zyk7CiAJYm9vc3RfdGltZS50dl9uc2VjID0gMDsKIAkKIAl0MCA9IHNlY29uZHNfcmVhZCgpOwpA
QCAtMjk2LDggKzI5NSw4IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikKIAogCS8q
IFN0YXJ0IFRCIHRocmVhZCAoYm9vc3RpbmcgdGhyZWFkKSAqLwogCURQUklOVEYoc3RkZXJyLCJN
YWluIFRocmVhZDogc3RhcnQgVEIgdGhyZWFkXG4iKTsKLQlpbnQgdGltZW91dCA9IG11bHRpcGxp
ZXIgKiAyMDsKLQlyYyA9IHB0aHJlYWRfY3JlYXRlKCZ0aHJlYWR0YiwgJnRocmVhZGF0dHIsIHRo
cmVhZF90YiwgCisJdGltZV90IHRpbWVvdXQgPSBtdWx0aXBsaWVyICogMjA7CisJcmMgPSBwdGhy
ZWFkX2NyZWF0ZSgmdGhyZWFkdGIsICZ0aHJlYWRhdHRyLCB0aHJlYWRfdGIsCiAJCQkgICAgJnRp
bWVvdXQpOwogICAgICAgICBpZiAocmMgIT0gMCkgewogICAgICAgICAgICAgICAgIEVQUklOVEYo
IlVOUkVTT0xWRUQ6IHB0aHJlYWRfY3JlYXRlOiAlZCAlcyIsCg==
--90e6ba21236f4a09760492e131d1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly 
Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev
--90e6ba21236f4a09760492e131d1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--90e6ba21236f4a09760492e131d1--

