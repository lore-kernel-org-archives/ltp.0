Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1WBOFz-0006eb-Tg
	for ltp-list@lists.sourceforge.net; Thu, 06 Feb 2014 12:40:39 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WBOFy-0004mp-JZ
	for ltp-list@lists.sourceforge.net; Thu, 06 Feb 2014 12:40:39 +0000
Date: Thu, 6 Feb 2014 07:40:32 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <136022909.5430461.1391690432110.JavaMail.root@redhat.com>
In-Reply-To: <20140204224400.GA8297@tarantula.localdomain>
References: <20140204224400.GA8297@tarantula.localdomain>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] use inotify_init1(0) for inotify tests on aarch64
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
To: Jeffrey Bastian <jbastian@redhat.com>
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Jeffrey Bastian" <jbastian@redhat.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Tuesday, 4 February, 2014 11:44:00 PM
> Subject: [LTP] [PATCH] use inotify_init1(0) for inotify tests on aarch64
> 
> aarch64 (and possibly other new architectures) does not implement
> the __ARCH_WANT_SYSCALL_NO_FLAGS syscalls, so use inotify_init1(0)
> instead of inotify_init(void)
> 
> Signed-off-by: Jeffrey Bastian <jbastian@redhat.com>

Looks good to me.

Reviewed-by: Jan Stancek <jstancek@redhat.com>

Regards,
Jan

> ---
>  testcases/kernel/syscalls/inotify/inotify.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/inotify/inotify.h
> b/testcases/kernel/syscalls/inotify/inotify.h
> index e396947c4f98..68fe3b5f6426 100644
> --- a/testcases/kernel/syscalls/inotify/inotify.h
> +++ b/testcases/kernel/syscalls/inotify/inotify.h
> @@ -30,8 +30,13 @@
>  
>  /* inotify(7) wrappers */
>  
> +#if __NR_inotify_init != __LTP__NR_INVALID_SYSCALL
>  #define	myinotify_init() \
>  	syscall(__NR_inotify_init)
> +#else
> +#define	myinotify_init() \
> +	syscall(__NR_inotify_init1, 0)
> +#endif
>  
>  #define	myinotify_add_watch(fd, pathname, mask)	\
>  	syscall(__NR_inotify_add_watch, fd, pathname, mask)
> --
> 1.8.3.1
> 
> 
> ------------------------------------------------------------------------------
> Managing the Performance of Cloud-Based Applications
> Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
> Read the Whitepaper.
> http://pubads.g.doubleclick.net/gampad/clk?id=121051231&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121051231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
