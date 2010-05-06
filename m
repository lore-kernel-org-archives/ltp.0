Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OA5Pw-0001Z6-70
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 18:03:24 +0000
Received: from mail-iw0-f200.google.com ([209.85.223.200])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OA5Pv-0003fh-Bj
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 18:03:24 +0000
Received: by iwn38 with SMTP id 38so178321iwn.10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 06 May 2010 11:03:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4BE28B24.1070801@cn.fujitsu.com>
References: <4BE28B24.1070801@cn.fujitsu.com>
Date: Thu, 6 May 2010 11:01:32 -0700
Message-ID: <q2o364299f41005061101h53710323s534939b9bf0d7087@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] eventfd01: should to check ret in
	overflow_poll_test()
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
To: Shi Weihua <shiwh@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Thu, May 6, 2010 at 2:25 AM, Shi Weihua <shiwh@cn.fujitsu.com> wrote:
> We should to check the return value of trigger_eventfd_overflow()
> in overflow_poll_test().
>
> Signed-off-by: Shi Weihua <shiwh@cn.fujitsu.com>
> ---
> diff --git a/testcases/kernel/syscalls/eventfd/eventfd01.c b/testcases/ke=
rnel/syscalls/eventfd/eventfd01.c
> index 83eb86e..ce55746 100644
> --- a/testcases/kernel/syscalls/eventfd/eventfd01.c
> +++ b/testcases/kernel/syscalls/eventfd/eventfd01.c
> @@ -602,7 +602,7 @@ static void overflow_poll_test(int evfd)
> =A0 =A0 =A0 =A0int ret;
>
> =A0 =A0 =A0 =A0ret =3D trigger_eventfd_overflow(evfd, &fd, &ctx);
> - =A0 =A0 =A0 if (fd =3D=3D -1) {
> + =A0 =A0 =A0 if (ret =3D=3D -1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TBROK, "error triggering eventfd =
overflow");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}

Acked-by: Garrett Cooper <yanegomi@gmail.com>

---------------------------------------------------------------------------=
---
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
