Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QrVvP-0006dX-UT
	for ltp-list@lists.sourceforge.net; Thu, 11 Aug 2011 14:07:55 +0000
Date: Thu, 11 Aug 2011 16:11:55 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110811141155.GB16435@saboteur.suse.cz>
References: <15c8ac922d2c4548bb9171b55df4b143b65e21d4.1312342893.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <15c8ac922d2c4548bb9171b55df4b143b65e21d4.1312342893.git.czhang@redhat.com>
Subject: Re: [LTP] [PATCH] syscalls/mprotect02: hide sigfault info from dmesg
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
To: Caspar Zhang <czhang@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> mprotect02 triggered an expected SIGSEGV in test, but it puts this
> information in dmesg, which might cause confusion when checking results:
> 
> mprotect02[11416]: segfault at 7f9ca0060000 ip 0000003a8e3382ff sp 00007fff7aeecb68 error 6 in libc-2.12.so[3a8e200000+197000]
> 
> This patch hides the sigfault information from dmesg.
> 
> Signed-off-by: Caspar Zhang <czhang@redhat.com>
> ---
>  testcases/kernel/syscalls/mprotect/mprotect02.c |   20 +++++++++++++-------
>  1 files changed, 13 insertions(+), 7 deletions(-)
> 

> diff --git a/testcases/kernel/syscalls/mprotect/mprotect02.c b/testcases/kernel/syscalls/mprotect/mprotect02.c
> index 97250c5..1d1fad0 100644
> --- a/testcases/kernel/syscalls/mprotect/mprotect02.c
> +++ b/testcases/kernel/syscalls/mprotect/mprotect02.c
> @@ -60,6 +60,7 @@
>  
>  #include "safe_macros.h"
>  
> +static void sighandler(int sig);
>  static void cleanup(void);
>  static void setup(void);
>  
> @@ -121,13 +122,6 @@ int main(int ac, char **av)
>  		if (waitpid(pid, &status, 0) == -1)
>  			tst_brkm(TBROK|TERRNO, cleanup, "waitpid failed");
>  
> -		if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV)
> -			tst_resm(TPASS, "got SIGSEGV as expected");
> -		else
> -			tst_brkm(TBROK, cleanup,
> -			    "child exited abnormally; wait status = %d",
> -			    status);
> -
>  		/* Change the protection to WRITE. */
>  		TEST(mprotect(addr, sizeof(buf), PROT_WRITE));
>  
> @@ -185,9 +179,21 @@ int main()
>  
>  #endif /* UCLINUX */
>  
> +static void sighandler(int sig)
> +{
> +	if (sig == SIGSEGV) {
> +		tst_resm(TPASS, "got SIGSEGV as expected");
> +		tst_exit();
> +	} else
> +		tst_brkm(TBROK, cleanup, "child exited abnormally: %d",
> +			sig);
> +}

Same as previous, please use the signal to propagete the return value to
parent using _exit().

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. 
http://p.sf.net/sfu/wandisco-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
