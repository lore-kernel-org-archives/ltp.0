Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1W8oyb-0001W1-69
	for ltp-list@lists.sourceforge.net; Thu, 30 Jan 2014 10:36:05 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1W8oyY-0004MJ-PJ
	for ltp-list@lists.sourceforge.net; Thu, 30 Jan 2014 10:36:04 +0000
Date: Thu, 30 Jan 2014 05:35:56 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1421375175.1655489.1391078156014.JavaMail.root@redhat.com>
In-Reply-To: <20140129224307.GL30688@tarantula.localdomain>
References: <20140129224307.GL30688@tarantula.localdomain>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] fix glb_run type for disktest
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
> Sent: Wednesday, 29 January, 2014 11:43:07 PM
> Subject: [LTP] [PATCH] fix glb_run type for disktest
> 
> disktest/main.c and disktest/timer.c fail to compile on certain
> platforms due to mismatch in types -- short vs long -- with a
> gcc error "relocation truncated to fit"
> 
> Thanks to Kyle McMartin for the hint on how to fix the error!
> ---

Hi Jeff,

pushed with added "Signed-off-by" line.

Regards,
Jan

>  testcases/kernel/io/disktest/main.c  | 2 +-
>  testcases/kernel/io/disktest/timer.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/io/disktest/main.c
> b/testcases/kernel/io/disktest/main.c
> index 5e5b91a37a12..9484ec103601 100644
> --- a/testcases/kernel/io/disktest/main.c
> +++ b/testcases/kernel/io/disktest/main.c
> @@ -290,7 +290,7 @@ void *threadedMain(void *vtest)
>  	int i;
>  	unsigned char *sharedMem;
>  
> -	extern unsigned long glb_run;
> +	extern unsigned short glb_run;
>  	extern int signal_action;
>  
>  	test->args->pid = GETPID();
> diff --git a/testcases/kernel/io/disktest/timer.c
> b/testcases/kernel/io/disktest/timer.c
> index 45ae09f17b38..f47fa7dde496 100644
> --- a/testcases/kernel/io/disktest/timer.c
> +++ b/testcases/kernel/io/disktest/timer.c
> @@ -86,7 +86,7 @@ void *ChildTimer(void *vtest)
>  	test_env_t *env = test->env;
>  
>  	extern int signal_action;
> -	extern unsigned long glb_run;
> +	extern unsigned short glb_run;
>  
>  #ifdef _DEBUG
>  	PDBG3(DBUG, args, "In timer %lu, %d\n", time(NULL), env->bContinue);
> --
> 1.8.3.1
> 
> 
> ------------------------------------------------------------------------------
> WatchGuard Dimension instantly turns raw network data into actionable
> security intelligence. It gives you real-time visual feedback on key
> security issues and trends.  Skip the complicated setup - simply import
> a virtual appliance and go from zero to informed in seconds.
> http://pubads.g.doubleclick.net/gampad/clk?id=123612991&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
WatchGuard Dimension instantly turns raw network data into actionable 
security intelligence. It gives you real-time visual feedback on key
security issues and trends.  Skip the complicated setup - simply import
a virtual appliance and go from zero to informed in seconds.
http://pubads.g.doubleclick.net/gampad/clk?id=123612991&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
