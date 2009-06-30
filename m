Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MLY2U-0002Y1-D5
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 07:46:02 +0000
Received: from [32.97.110.149] (helo=e31.co.us.ibm.com)
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLY2S-00036o-Mx
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 07:46:02 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090625113420.606.55089.sendpatchset@subratamodak.linux.ibm.com>
References: <20090625113420.606.55089.sendpatchset@subratamodak.linux.ibm.com>
Date: Tue, 30 Jun 2009 13:11:18 +0530
Message-Id: <1246347678.4819.30.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Re::personality test case build fails
Reply-To: subrata@linux.vnet.ibm.com
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
To: Pradeep K Surisetty <pradeepkumars@in.ibm.com>
Cc: ltp-list <ltp-list@lists.sf.net>

On Thu, 2009-06-25 at 17:04 +0530, Subrata Modak wrote: 
> Hi Pradeep,
> 
> >On Tue, 2009-06-23 at 18:39 +0530, Pradeep K Surisetty wrote:
> >Here is the list of platforms on which "personality test case" fails.
> > 
> > Platforms:
> > e326,x366
> > 
> > kernel:
> > 2.6.16.60-0.46.6-smp
> > 
> > Build Failure:
> > 
> > cc -I../../../../include -Wall    personality01.c  -L../../../../lib -lltp
> > -o personality01
> > /tmp/cc2aVCsG.o: In function `main':
> > personality01.c:(.text+0x58): undefined reference to `personality'
> > personality01.c:(.text+0xb6): undefined reference to `personality'
> > personality01.c:(.text+0x1a5): undefined reference to `personality'
> > collect2: ld returned 1 exit status
> > make: *** [personality01] Error 1
> > 
> > Subrata,
> > Can you point me, if any work around exists for this.
> 
> The following patch will probably fix the issue on your system. Please
> test this patch and let me know.
> 
> Signed-off-by: Subrata Modak <subrata@linux.vnet.ibm.com>,

I checked in this.

Regards--
Subrata

> ---
> 
> --- ltp-intermediate-20090622/testcases/kernel/syscalls/personality/personality01.c.orig	2009-06-25 16:45:55.000000000 +0530
> +++ ltp-intermediate-20090622/testcases/kernel/syscalls/personality/personality01.c	2009-06-25 16:59:15.000000000 +0530
> @@ -58,7 +58,7 @@
>  #include "usctest.h"
> 
>  #include <errno.h>
> -#include <linux/personality.h>
> +#include <sys/personality.h>
>  #undef personality
> 
>  extern int personality(unsigned long);
> @@ -75,6 +75,7 @@ int pers[] = { PER_LINUX, PER_LINUX_32BI
>  	PER_IRIX32, PER_IRIXN32, PER_IRIX64
>  };
> 
> +#ifdef __NR_personality
>  int main(int ac, char **av)
>  {
>  	int lc;			/* loop counter */
> @@ -146,6 +147,13 @@ int main(int ac, char **av)
> 
>  	 /*NOTREACHED*/ return 0;
>  }
> +#else
> +int main(int ac, char **av)
> +{
> +	tst_resm(TCONF, "personality() not defined in your system");
> +	tst_exit();
> +}
> +#endif
> 
>  /*
>   * setup() - performs all the ONE TIME setup for this test.
> --- ltp-intermediate-20090622/testcases/kernel/syscalls/personality/personality02.c.orig	2009-06-25 16:46:02.000000000 +0530
> +++ ltp-intermediate-20090622/testcases/kernel/syscalls/personality/personality02.c	2009-06-25 16:59:25.000000000 +0530
> @@ -79,6 +79,7 @@ extern int Tst_count;
> 
>  #define	PER_BAD	0x00dd		/* A non-existent personality type */
> 
> +#ifdef __NR_personality
>  int main(int ac, char **av)
>  {
>  	int lc;			/* loop counter */
> @@ -128,6 +129,14 @@ int main(int ac, char **av)
> 
>  	 /*NOTREACHED*/ return 0;
>  }
> +#else
> +int main(int ac, char **av)
> +{
> +	tst_resm(TCONF, "personality() not defined in your system");
> +	tst_exit();
> +}
> +#endif
> +
> 
>  /*
>   * setup() - performs all the ONE TIME setup for this test.
> 
> ---
> Regards--
> Subrata
> 
> > 
> > -Pradeep
> > 
> > 


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
