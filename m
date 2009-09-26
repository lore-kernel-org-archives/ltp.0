Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Mrerx-00027d-UH
	for ltp-list@lists.sourceforge.net; Sat, 26 Sep 2009 21:31:53 +0000
Received: from mail-qy0-f204.google.com ([209.85.221.204])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mrerr-0003JF-FJ
	for ltp-list@lists.sourceforge.net; Sat, 26 Sep 2009 21:31:53 +0000
Received: by qyk42 with SMTP id 42so2906294qyk.28
	for <ltp-list@lists.sourceforge.net>;
	Sat, 26 Sep 2009 14:31:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1253964859-23928-2-git-send-email-avagin@gmail.com>
References: <1253964859-23928-1-git-send-email-avagin@gmail.com>
	<1253964859-23928-2-git-send-email-avagin@gmail.com>
Date: Sat, 26 Sep 2009 14:31:41 -0700
Message-ID: <364299f40909261431u389b1a1cnea82a829c252c54d@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 2/3] fsstress: fix memory leak in fread_d
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
> 1. check result from operation open before set flags
> 2. close descriptor and free path if set flags failed
>
> valgrind --leak-check=3Dfull --show-reachable=3Dyes ./fsstress -d /home/s=
hpagin/git-archive/ltp/testcases/kernel/fs/fsstress/tmp -l 10 -n 100
>
> =3D=3D23212=3D=3D 1,134 bytes in 108 blocks are definitely lost in loss r=
ecord 4 of 5
> =3D=3D23212=3D=3D =A0 =A0at 0x4A0776F: realloc (vg_replace_malloc.c:429)
> =3D=3D23212=3D=3D =A0 =A0by 0x401E6A: append_pathname (fsstress.c:528)
> =3D=3D23212=3D=3D =A0 =A0by 0x4024E3: fent_to_name (fsstress.c:760)
> =3D=3D23212=3D=3D =A0 =A0by 0x40284F: get_fname (fsstress.c:846)
> =3D=3D23212=3D=3D =A0 =A0by 0x4041E0: dread_f (fsstress.c:1757)
> =3D=3D23212=3D=3D =A0 =A0by 0x402368: doproc (fsstress.c:728)
> =3D=3D23212=3D=3D =A0 =A0by 0x401CC1: main (fsstress.c:463)
>
>
> ---
> =A0testcases/kernel/fs/fsstress/fsstress.c | =A0 16 +++++++++++-----
> =A01 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/testcases/kernel/fs/fsstress/fsstress.c b/testcases/kernel/f=
s/fsstress/fsstress.c
> index 3df0ce5..db6b358 100644
> --- a/testcases/kernel/fs/fsstress/fsstress.c
> +++ b/testcases/kernel/fs/fsstress/fsstress.c
> @@ -1764,10 +1764,6 @@ dread_f(int opno, long r)
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0fd =3D open_path(&f, O_RDONLY);
>
> - =A0 =A0 =A0 if (!setdirect(fd)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> - =A0 =A0 =A0 }
> -
> =A0 =A0 =A0 =A0e =3D fd < 0 ? errno : 0;
> =A0 =A0 =A0 =A0check_cwd();
> =A0 =A0 =A0 =A0if (fd < 0) {
> @@ -1777,6 +1773,13 @@ dread_f(int opno, long r)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free_pathname(&f);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 if (!setdirect(fd)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 close(fd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_pathname(&f);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0if (fstat64(fd, &stb) < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (v)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf("%d/%d: dread - fst=
at64 %s failed %d\n",
> @@ -1864,8 +1867,11 @@ dwrite_f(int opno, long r)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (!setdirect(fd))
> + =A0 =A0 =A0 if (!setdirect(fd)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_pathname(&f);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 close(fd);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0if (fstat64(fd, &stb) < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (v)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf("%d/%d: dwrite - fs=
tat64 %s failed %d\n",

Andrew,
    This change looks good, but the indentation is a bit catywampus.
Please fix and run with checkpatch.pl.
Thanks!
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
