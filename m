Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1V8p9P-0000ht-3a
	for ltp-list@lists.sourceforge.net; Mon, 12 Aug 2013 10:14:59 +0000
Date: Mon, 12 Aug 2013 12:14:56 +0200
From: chrubis@suse.cz
Message-ID: <20130812101456.GC24518@rei>
References: <600498180.46596.1375958364140.JavaMail.zimbra@kalray.eu>
	<155339095.46628.1375958549000.JavaMail.zimbra@kalray.eu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <155339095.46628.1375958549000.JavaMail.zimbra@kalray.eu>
Subject: Re: [LTP] PATCHES: build for uCLinux
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
To: Marta Rybczynska <mrybczyn@kalray.eu>
Cc: ltp-list@lists.sourceforge.net

Hi!
>  testcases/kernel/syscalls/flock/flock03.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/flock/flock03.c b/testcases/kernel/syscalls/flock/flock03.c
> index bacf4f6..d0bd214 100644
> --- a/testcases/kernel/syscalls/flock/flock03.c
> +++ b/testcases/kernel/syscalls/flock/flock03.c
> @@ -92,7 +92,7 @@ int main(int argc, char **argv)
>  				 errno);
>  		if (pid == 0) {
>  #ifdef UCLINUX
> -			if (self_exec(argv[0], "ds", fd, FILENAME) < 0)
> +			if (self_exec(argv[0], "ds", fd, FILE_NAME) < 0)
>  				tst_brkm(TFAIL, cleanup, "self_exec failed, "
>  					 "errno &d", errno);
>  #else

This was allready fixed in git see:

12a9e945976a6ebfa9673ad27a79be704d9414a7

> From 6bc02047452c800eee47c7f7afe34ff524199454 Mon Sep 17 00:00:00 2001
> From: Marta Rybczynska <marta.rybczynska@kalray.eu>
> Date: Tue, 6 Aug 2013 09:39:16 +0200
> Subject: [PATCH 1/2] ebizzy.h: mallopt does not exist on uClinux
> 
> mallopt does not exist on uClibc, it requires MMU.
> 
> Signed-off-by: Marta Rybczynska <marta.rybczynska@kalray.eu>
> ---
>  utils/benchmark/ebizzy-0.3/ebizzy.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/utils/benchmark/ebizzy-0.3/ebizzy.h b/utils/benchmark/ebizzy-0.3/ebizzy.h
> index da1a78c..afc18b5 100644
> --- a/utils/benchmark/ebizzy-0.3/ebizzy.h
> +++ b/utils/benchmark/ebizzy-0.3/ebizzy.h
> @@ -18,7 +18,7 @@
>  /*
>   * FreeBSD compatibility stuff
>   */
> -#ifdef _freebsd
> +#if defined(_freebsd) || defined(__UCLIBC__)
>  #define mallopt(arg1, arg2) do { } while (0);
>  #endif

This one was applied to git, thanks.

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
