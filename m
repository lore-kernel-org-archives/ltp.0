Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MLOAQ-0006ff-Qt
	for ltp-list@lists.sourceforge.net; Mon, 29 Jun 2009 21:13:34 +0000
Received: from mail-gx0-f227.google.com ([209.85.217.227])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLO9i-000766-Vs
	for ltp-list@lists.sourceforge.net; Mon, 29 Jun 2009 21:13:33 +0000
Received: by gxk27 with SMTP id 27so16369058gxk.10
	for <ltp-list@lists.sourceforge.net>;
	Mon, 29 Jun 2009 14:12:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f5a7b3810906290953k7326b82ds617ee7bfdac92e48@mail.gmail.com>
References: <f5a7b3810906290953k7326b82ds617ee7bfdac92e48@mail.gmail.com>
Date: Mon, 29 Jun 2009 14:12:49 -0700
Message-ID: <364299f40906291412o1c24953n587406adcc465139@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [FIX-PATCH]Build-issue-cacheflush01.c on MIPS
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
To: naresh kamboju <naresh.kernel@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>, Jiri Palecek <jpalecek@web.de>, maxin john <maxinbjohn@gmail.com>, brinda_mn@yahoo.co.in, Manas Kumar Nayak <maknayak@in.ibm.com>

On Mon, Jun 29, 2009 at 9:53 AM, naresh kamboju<naresh.kernel@gmail.com> wr=
ote:
> Hi,
>
> I have noticed build error for cacheflush01.c on MIPS.
> There is edit issue from Windows to Linux text file.
> Now build issue is resolved.
> Please find attached patch and below.
>
> Best Regards
> Naresh Kamboju
>
> Build-Error:
>
> cacheflush01.c =A0-L../../../../lib -lltp -o cacheflush01
> cacheflush01.c: In function 'cacheflush':
> cacheflush01.c:52: error: 'B' undeclared (first use in this function)
> cacheflush01.c:52: error: (Each undeclared identifier is reported only on=
ce
> cacheflush01.c:52: error: for each function it appears in.)
> cacheflush01.c:52: error: expected ';' before 'B'
> cacheflush01.c:53: warning: control reaches end of non-void function
> make: *** [cacheflush01] Error 1
>
>
> Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >
>
> diff -Naurb a/testcases/kernel/syscalls/cacheflush/cacheflush01.c
> b/testcases/kernel/syscalls/cacheflush/cacheflush01.c
> --- a/testcases/kernel/syscalls/cacheflush/cacheflush01.c =A0 =A0 =A0 200=
9-04-15
> 12:02:35.000000000 +0530
> +++ b/testcases/kernel/syscalls/cacheflush/cacheflush01.c =A0 =A0 =A0 200=
9-06-29
> 21:38:42.000000000 +0530
> @@ -49,7 +49,7 @@
> =A0#include <asm/cachectl.h>
> =A0int cacheflush(char *addr, int nbytes, int cache)
> =A0{
> -B =A0B =A0B =A0B return syscall(__NR_cacheflush, addr, nbytes, cache);
> + =A0 =A0 =A0 =A0 =A0 return syscall(__NR_cacheflush, addr, nbytes, cache=
);
> =A0}
> =A0#endif /* __mips__ */

Nice catch... Heh.
-Garrett

---------------------------------------------------------------------------=
---
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
