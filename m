Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MxPd1-00029M-Ee
	for ltp-list@lists.sourceforge.net; Mon, 12 Oct 2009 18:28:15 +0000
Received: from mail-pz0-f188.google.com ([209.85.222.188])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MxPcu-000588-54
	for ltp-list@lists.sourceforge.net; Mon, 12 Oct 2009 18:28:10 +0000
Received: by pzk26 with SMTP id 26so8268017pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Mon, 12 Oct 2009 11:28:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4AD2F942.1090004@cn.fujitsu.com>
References: <4AD2F942.1090004@cn.fujitsu.com>
Date: Mon, 12 Oct 2009 11:28:02 -0700
Message-ID: <364299f40910121128w48dbef1bpb8ab9fe4b48029ec@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] ppoll01: Fix to set the signal handler of SIGINT
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
To: liubo <liubo-fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Mon, Oct 12, 2009 at 2:39 AM, liubo <liubo-fnst@cn.fujitsu.com> wrote:
> The test case ppoll01 does not register the signal handler
> of SIGINT, so the program will be terminated by SIGINT
> from child process.
>
> Then, the rest cases will not be tested.
>
> This patch fixed the problem.
>
> Signed-off-by: Liu Bo <liubo-fnst@cn.fujitsu.com>
> ---
> diff --git a/testcases/kernel/syscalls/ppoll/ppoll01.c b/testcases/kernel=
/syscalls/ppoll/ppoll01.c
> index f76d61f..585297c 100644
> --- a/testcases/kernel/syscalls/ppoll/ppoll01.c
> +++ b/testcases/kernel/syscalls/ppoll/ppoll01.c
> @@ -124,9 +124,17 @@ extern void cleanup() {
> =A0/* =A0 =A0 =A0 =A0 =A0 =A0 =A0On success - returns 0. =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0/* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0*/
> =A0/*********************************************************************=
*********/
> +/*
> + * sighandler()
> + */
> +void sighandler(int sig)
> +{
> + =A0 =A0 =A0 return;
> +}
> =A0void setup() {
> =A0 =A0 =A0 =A0 /* Capture signals if any */
> - =A0 =A0 =A0 =A0/* Create temporary directories */
> + =A0 =A0 =A0 signal(SIGINT, sighandler);
> + =A0 =A0 =A0 /* Create temporary directories */
> =A0 =A0 =A0 =A0 TEST_PAUSE;
> =A0 =A0 =A0 =A0 tst_tmpdir();
> =A0}
> @@ -404,16 +412,6 @@ TEST_END:
> =A0}
>
>
> -/*
> - * sighandler()
> - */
> -void sighandler(int sig)
> -{
> - =A0 =A0 =A0 =A0if (sig =3D=3D SIGINT)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> - =A0 =A0 =A0 =A0// NOTREACHED
> - =A0 =A0 =A0 =A0return;
> -}

1. If all that the signal handler does is just return, it should have
been doing SIG_IGN from the beginning.
2. I don't understand how your change fixes this because the signal
handler's function is almost the same (the original handler was more
generic).
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay =

ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
