Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1V9HBs-0006td-UC
	for ltp-list@lists.sourceforge.net; Tue, 13 Aug 2013 16:11:25 +0000
Date: Tue, 13 Aug 2013 18:11:22 +0200
From: chrubis@suse.cz
Message-ID: <20130813161122.GA29678@rei>
References: <1376369417-13511-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1376369417-13511-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH] rt_sigaction: headers are included in a uniform
	way
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
> index 5beabef..0e2915e 100644
> --- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
> +++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
> @@ -46,28 +46,11 @@
>  #include <sys/syscall.h>
>  #include <string.h>
>  
> +#define LTP_RT_SIG_TEST

As far as I see these two testcases does not use the interface exposed
after this is defined. If this is so there is no need to define it here.

> diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
> index 646c37d..b160f2b 100644
> --- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
> +++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
> @@ -46,9 +46,11 @@
>  #include <sys/syscall.h>
>  #include <string.h>
>  
> +#define LTP_RT_SIG_TEST

Here as well.


Otherwise it looks ok.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
