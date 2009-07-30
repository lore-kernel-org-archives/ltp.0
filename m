Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MWMAw-0003E1-Oe
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 03:19:26 +0000
Received: from mail-px0-f190.google.com ([209.85.216.190])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MWMAq-0008Qf-1Q
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 03:19:26 +0000
Received: by pxi28 with SMTP id 28so100940pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 Jul 2009 20:19:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A70F86E.50608@cn.fujitsu.com>
References: <4A70F86E.50608@cn.fujitsu.com>
Date: Wed, 29 Jul 2009 20:19:14 -0700
Message-ID: <364299f40907292019r494348dt1e895f0c180f3f58@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Fix failure of the utimensat01 test
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
To: Wang Yong <wangyong2009@cn.fujitsu.com>
Cc: LTP <ltp-list@lists.sourceforge.net>

On Wed, Jul 29, 2009 at 6:33 PM, Wang Yong<wangyong2009@cn.fujitsu.com> wro=
te:
> The error handling for "RW" opt of run_test brought about error results.
> This patch fixed that.
>
> Signed-off-by: WangYong <wangyong2009@cn.fujitsu.com>
>
> diff -Nurp a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
> b/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
> --- a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh =A0 =A02009-=
07-28 16:23:39.000000000 +0800
> +++ b/testcases/kernel/syscalls/utimensat/utimensat_tests.sh =A0 =A02009-=
07-28 17:32:26.000000000 +0800
> @@ -260,22 +260,22 @@ echo "Testing read-only file, owned by s
> =A0echo

[...]

Don't these changes actually conflict with the testcase's purpose,
given the messages echoed placed directly above the commands?
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with =

Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
