Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Mresl-00041i-72
	for ltp-list@lists.sourceforge.net; Sat, 26 Sep 2009 21:32:43 +0000
Received: from mail-qy0-f204.google.com ([209.85.221.204])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mresc-0003Pd-6W
	for ltp-list@lists.sourceforge.net; Sat, 26 Sep 2009 21:32:43 +0000
Received: by qyk42 with SMTP id 42so2906524qyk.28
	for <ltp-list@lists.sourceforge.net>;
	Sat, 26 Sep 2009 14:32:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1253964859-23928-3-git-send-email-avagin@gmail.com>
References: <1253964859-23928-1-git-send-email-avagin@gmail.com>
	<1253964859-23928-2-git-send-email-avagin@gmail.com>
	<1253964859-23928-3-git-send-email-avagin@gmail.com>
Date: Sat, 26 Sep 2009 14:32:28 -0700
Message-ID: <364299f40909261432n29f927e3ne8c8d17c26021ec8@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 3/3] fsstress: renew flist if clean up test
	directory
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
> flist contain all files created by fsstress. If test clean up direcory
> on each interations that it should reinitilize flist.
>
> ---
> =A0testcases/kernel/fs/fsstress/fsstress.c | =A0 =A07 +++++++
> =A01 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/testcases/kernel/fs/fsstress/fsstress.c b/testcases/kernel/f=
s/fsstress/fsstress.c
> index db6b358..bf5df7c 100644
> --- a/testcases/kernel/fs/fsstress/fsstress.c
> +++ b/testcases/kernel/fs/fsstress/fsstress.c
> @@ -491,6 +491,13 @@ int main(int argc, char **argv)
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0sprintf(cmd,"rm -rf %s/*",dirname);
> =A0 =A0 =A0 =A0 =A0system(cmd);
> + =A0 =A0 =A0 =A0 for (i =3D 0; i < FT_nft; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flist[i].nslots =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flist[i].nfiles =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free(flist[i].fents);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flist[i].fents =3D NULL;
> + =A0 =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 loopcntr++;
> =A0 =A0 =A0 =A0}

    Looks good :).
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
