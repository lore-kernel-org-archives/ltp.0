Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1VWkQn-0008BH-BY
	for ltp-list@lists.sourceforge.net; Thu, 17 Oct 2013 10:03:49 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VWkQl-0006V6-Cl
	for ltp-list@lists.sourceforge.net; Thu, 17 Oct 2013 10:03:49 +0000
Date: Thu, 17 Oct 2013 06:03:40 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <795452447.8347120.1382004220978.JavaMail.root@redhat.com>
In-Reply-To: <1382002005-15348-1-git-send-email-jshao@redhat.com>
References: <1382002005-15348-1-git-send-email-jshao@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] setns: add ns_name in TINFO
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
To: Monson Shao <jshao@redhat.com>
Cc: ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Monson Shao" <jshao@redhat.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Thursday, 17 October, 2013 11:26:45 AM
> Subject: [LTP] [PATCH] setns: add ns_name in TINFO
> 
> Make it clear which namespace is enabled and being tested.

Fine by me, it's easier to read than those flags.

Reviewed-by: Jan Stancek <jstancek@redhat.com>

Regards,
Jan

> 
> before:
> setns01     0  TINFO  :  ns_fds[0]=5, ns_types[0]=0x8000000
> setns01     0  TINFO  :  ns_fds[1]=6, ns_types[1]=0x20000
> setns01     0  TINFO  :  ns_fds[2]=7, ns_types[2]=0x40000000
> setns01     0  TINFO  :  ns_fds[3]=8, ns_types[3]=0x20000000
> setns01     0  TINFO  :  ns_fds[4]=9, ns_types[4]=0x4000000
> 
> after:
> setns01     0  TINFO  :  ns_name=ipc, ns_fds[0]=5, ns_types[0]=0x8000000
> setns01     0  TINFO  :  ns_name=mnt, ns_fds[1]=6, ns_types[1]=0x20000
> setns01     0  TINFO  :  ns_name=net, ns_fds[2]=7, ns_types[2]=0x40000000
> setns01     0  TINFO  :  ns_name=pid, ns_fds[3]=8, ns_types[3]=0x20000000
> setns01     0  TINFO  :  ns_name=uts, ns_fds[4]=9, ns_types[4]=0x4000000
> 
> Signed-off-by: Monson Shao <jshao@redhat.com>
> ---
>  testcases/kernel/syscalls/setns/setns.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/setns/setns.h
> b/testcases/kernel/syscalls/setns/setns.h
> index 23bdb2e..a05e673 100644
> --- a/testcases/kernel/syscalls/setns/setns.h
> +++ b/testcases/kernel/syscalls/setns/setns.h
> @@ -53,8 +53,8 @@ static void init_ns_type(int clone_type, const char
> *proc_name)
>  	if (fd != -1) {
>  		ns_types[ns_total] = clone_type;
>  		ns_fds[ns_total] = fd;
> -		tst_resm(TINFO, "ns_fds[%d]=%d, ns_types[%d]=0x%x", ns_total,
> -			fd, ns_total, clone_type);
> +		tst_resm(TINFO, "ns_name=%s, ns_fds[%d]=%d, ns_types[%d]=0x%x",
> +			 proc_name, ns_total, fd, ns_total, clone_type);
>  		ns_total++;
>  	}
>  }
> --
> 1.8.3.1
> 
> 
> ------------------------------------------------------------------------------
> October Webinars: Code for Performance
> Free Intel webinars can help you accelerate application performance.
> Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from
> the latest Intel processors and coprocessors. See abstracts and register >
> http://pubads.g.doubleclick.net/gampad/clk?id=60135031&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
