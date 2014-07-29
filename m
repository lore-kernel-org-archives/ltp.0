Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XC30i-0007Zn-09
	for ltp-list@lists.sourceforge.net; Tue, 29 Jul 2014 08:43:52 +0000
Date: Tue, 29 Jul 2014 10:43:06 +0200
From: chrubis@suse.cz
Message-ID: <20140729084306.GA15240@rei>
References: <24aca741786196af9ca38705970289a66b12ab9b.1406622527.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <24aca741786196af9ca38705970289a66b12ab9b.1406622527.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] mem/oom: check for multiple outcomes if
 overcommit_memory is 0 or 1
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +/* oom/testoom outcomes */
> +#define EXIT_FLAG 0x100
> +#define SIGNAL_FLAG 0x200
> +#define OUTCOME_MASK 0xff
> +#define EXITED(n) (EXIT_FLAG + (n & OUTCOME_MASK))
> +#define SIGNALLED(n) (SIGNAL_FLAG + (n & OUTCOME_MASK))
> +
> +extern int EXITED_ENOMEM[];
> +extern int ENOMEM_OR_SIGKILL[];

This machinery looks a bit too generic to me. IMHO simple bit flag for
oom() that would allow/disallow the child being killed as a PASS result
would suffice.

Or do you expect that we will need (many) more possible cases to add?

>  long overcommit;
> -void oom(int testcase, int lite);
> -void testoom(int mempolicy, int lite);
> +void oom(int testcase, int lite, int outcome[]);
> +void testoom(int mempolicy, int lite, int outcome[]);
>  
>  /* KSM */
>  
> diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
> index c7910db..f207c58 100644
> --- a/testcases/kernel/mem/lib/mem.c
> +++ b/testcases/kernel/mem/lib/mem.c
> @@ -25,52 +25,73 @@
>  #include "numa_helper.h"
>  
>  /* OOM */
> +int EXITED_ENOMEM[] = { EXITED(ENOMEM), 0 };
> +int ENOMEM_OR_SIGKILL[] =  { EXITED(ENOMEM), SIGNALLED(SIGKILL), 0 };
>  
>  static int alloc_mem(long int length, int testcase)
>  {
> -	void *s;
> +	char *s;
> +	long i;
> +	int pagesz = getpagesize();
>  
>  	tst_resm(TINFO, "allocating %ld bytes.", length);
> +
>  	s = mmap(NULL, length, PROT_READ | PROT_WRITE,
>  		 MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> -	if (s == MAP_FAILED) {
> -		if (testcase == OVERCOMMIT && errno == ENOMEM)
> -			return 1;
> -		else
> -			tst_brkm(TBROK | TERRNO, cleanup, "mmap");
> -	}
> +	if (s == MAP_FAILED)
> +		return errno;
> +
>  	if (testcase == MLOCK && mlock(s, length) == -1)
> -		tst_brkm(TBROK | TERRNO, cleanup, "mlock");
> +		return errno;
>  #ifdef HAVE_MADV_MERGEABLE
>  	if (testcase == KSM && madvise(s, length, MADV_MERGEABLE) == -1)
> -		tst_brkm(TBROK | TERRNO, cleanup, "madvise");
> +		return errno;
>  #endif
> -	memset(s, '\a', length);
> +	for (i = 0; i < length; i += pagesz)
> +		s[i] = '\a';

This is good optimalization but should be either mentioned in the commit
message or ideally commited separately.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
