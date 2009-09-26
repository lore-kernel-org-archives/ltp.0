Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Mrepf-0001zt-Ua
	for ltp-list@lists.sourceforge.net; Sat, 26 Sep 2009 21:29:31 +0000
Received: from qw-out-1920.google.com ([74.125.92.150])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mrepb-0005RD-Ce
	for ltp-list@lists.sourceforge.net; Sat, 26 Sep 2009 21:29:31 +0000
Received: by qw-out-1920.google.com with SMTP id 5so1121085qwc.4
	for <ltp-list@lists.sourceforge.net>;
	Sat, 26 Sep 2009 14:29:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1253964859-23928-1-git-send-email-avagin@gmail.com>
References: <1253964859-23928-1-git-send-email-avagin@gmail.com>
Date: Sat, 26 Sep 2009 14:29:19 -0700
Message-ID: <364299f40909261429k75a74d3ej709c42e5e207c548@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 1/3] fsstress: fix memory leaks
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Andrew Vagin <avagin@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On Sat, Sep 26, 2009 at 4:34 AM, Andrew Vagin <avagin@gmail.com> wrote:
> =3D=3D11424=3D=3D 156 bytes in 1 blocks are definitely lost in loss recor=
d 2 of 2
> =3D=3D11424=3D=3D =A0 =A0at 0x4A0763E: malloc (vg_replace_malloc.c:207)
> =3D=3D11424=3D=3D =A0 =A0by 0x402E4C: make_freq_table (fsstress.c:986)
> =3D=3D11424=3D=3D =A0 =A0by 0x401C26: main (fsstress.c:410)
>
> make_freq_table is executed on each iterations, but freq_table is not
> changed during test, so this patch moves it from the loop
> ---
> =A0testcases/kernel/fs/fsstress/fsstress.c | =A0 30 ++++++++++++++++-----=
---------
> =A01 files changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/testcases/kernel/fs/fsstress/fsstress.c b/testcases/kernel/f=
s/fsstress/fsstress.c
> index 1f11f6e..3df0ce5 100644
> --- a/testcases/kernel/fs/fsstress/fsstress.c
> +++ b/testcases/kernel/fs/fsstress/fsstress.c
> @@ -375,21 +375,24 @@ int main(int argc, char **argv)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0while ( (loopcntr <=3D loops) || (loops =3D=3D 0) )
> - =A0 =A0 =A0 =A0{
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (no_xfs && errtag) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fprintf(stderr, "error inje=
ction only works on XFS\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit(1);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (no_xfs) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int i;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; ops+i < ops_e=
nd; ++i) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ops[i].=
isxfs)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 ops[i].freq =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (no_xfs && errtag) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fprintf(stderr, "error injection only works=
 on XFS\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit(1);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (no_xfs) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; ops+i < ops_end; ++i) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ops[i].isxfs)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ops[i].freq=
 =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> -
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 make_freq_table();
> +
> + =A0 =A0 =A0 =A0while ( (loopcntr <=3D loops) || (loops =3D=3D 0) )
> + =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!dirname) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* no directory specified =
*/
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!nousage) usage();
> @@ -407,7 +410,6 @@ int main(int argc, char **argv)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0maxfsize =3D (off64_t)MAXF=
SIZE32;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0maxfsize =3D (off64_t)MAXF=
SIZE;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 make_freq_table();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dcache_init();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0setlinebuf(stdout);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!seed) {
> --
> 1.6.2.5

Andrew,
    Please use tabs instead of spaces for indentation. Run
checkpatch.pl after everything's said and done to validate style.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay =

ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
