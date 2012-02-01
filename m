Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RscXn-0006tG-7z
	for ltp-list@lists.sourceforge.net; Wed, 01 Feb 2012 15:56:23 +0000
Date: Wed, 1 Feb 2012 17:09:34 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120201160934.GB32485@saboteur.suse.cz>
References: <1328081325-22028-1-git-send-email-jin.li@windriver.com>
	<1328081325-22028-2-git-send-email-jin.li@windriver.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1328081325-22028-2-git-send-email-jin.li@windriver.com>
Subject: Re: [LTP] [PATCH] Fix for msgctl test case msgctl11 on the target
 with more than 4G memory
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
To: Jin Li <jin.li@windriver.com>
Cc: ltp-list@lists.sourceforge.net, haotian.zhang@windriver.com

Hi!
> The test msgctl11 will fail with log as follows once it is on the
> target with more than 4G memory and use default maximum pid value 32768.
> Because in this case, the maxnkids is always 0 which will cause fail
> and exit.
> 
> maxnkids = ((free_pids / 4) / MSGMNI);
> 
> The fix will update the maximum pid value to meet the basic need of
> free pids on the target with more than 4G memory.
> 
> Test msgctl11 fail log
> 
> "msgctl11    1  TBROK  :  Not enough free pids"
> 
> Signed-off-by: Jin Li <jin.li@windriver.com>

First of all, pretty please learn to use checkpatch.pl, it doesn't catch
all the problems, but it's a good start.

> ---
>  lib/system_specific_process_info.c              |   27 ++++++++++++++++++++++
>  testcases/kernel/syscalls/ipc/msgctl/msgctl11.c |   28 +++++++++++++++++++++-
>  2 files changed, 53 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/system_specific_process_info.c b/lib/system_specific_process_info.c
> index d3c9638..aaa7f8b 100644
> --- a/lib/system_specific_process_info.c
> +++ b/lib/system_specific_process_info.c
> @@ -59,6 +59,33 @@ int get_max_pids(void)
>  }
>  
>  
> +int set_max_pids(int pids_max)
> +{
> +#ifdef __linux__
> +
> +        FILE *f;
> +        char buf[BUFSIZE]={0};
> +
> +	snprintf(buf, sizeof(buf), "%d\n", pids_max);
> +
> +        f = fopen("/proc/sys/kernel/pid_max", "w+");
> +        if (!f) {
> +                tst_resm(TBROK, "Could not open /proc/sys/kernel/pid_max");
> +                return -1;
> +        }
> +        if (!(fwrite(buf, BUFSIZE,1,f))) {
> +                fclose(f);
> +                tst_resm(TBROK, "Could not write /proc/sys/kernel/pid_max");
> +                return -1;
> +        }
> +        fclose(f);
> +        return atoi(buf);
> +#else
> +        return SHRT_MAX;
> +#endif
> +}

Heh, that is overly compicated, once you open the proc file with fopen,
you can use fprintf() directly without any additional buffers nd you
should check from return value from fclose() here.

And what exactly is return value from this function? Returns -1 on
failure, that's okay, but isn't the atoi(buf) same as pids_max?

Also I'm missing the function prototype from headers in include.

>  int get_free_pids(void)
>  {
>  	FILE *f;
> diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
> index 57bd184..eb6cb71 100644
> --- a/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
> +++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
> @@ -79,6 +79,9 @@ int TST_TOTAL = 1;		/* Total number of test cases. */
>  
>  int exp_enos[] = { 0 };		/* List must end with 0 */
>  int maxnkids = MAXNKIDS;	/* Used if pid_max is exceeded */
> +int max_pids;
> +int adjust_max_pids = 0 ;
> +
>  
>  key_t keyarray[MAXNPROCS];
>  
> @@ -641,14 +644,29 @@ void setup()
>  		tst_exit();
>  	}
>  
> +	max_pids = get_max_pids();
>  	if ((MSGMNI * MAXNKIDS * 2) > (free_pids / 2)) {
> +            if ( nr_msgqs < 8192 ) {
>  		maxnkids = ((free_pids / 4) / MSGMNI);
>  		if (!maxnkids) {
>  			tst_resm(TBROK, "Not enough free pids");
>  			tst_exit();
>  		}
> -	}
> +	    } else  {
> +		maxnkids = 1;
> +
> +		/* After the update of maximum pid number, the free pids
> +                 * will be MSGMNI * 2 * 2.
> +                 */
> +                adjust_max_pids = MSGMNI * 2 * 2 + max_pids - free_pids ;
> +		if ( (set_max_pids (adjust_max_pids)) < 0 ) {
> +                    tst_resm(TBROK, "cannot adjust max pids");
> +		    tst_exit();
> +		}
> +                free_pids = get_free_pids();
> +            }

Hmm, I'm thinking if this could possible make some problems. Anyway what
exactly does this change do? It computes some limit on maximal pid
number but how does that fix the testing? More verbose patch description
would sure help.

> +        }
>  	tst_resm(TINFO, "Using upto %d pids", free_pids / 2);
>  }
>  
> @@ -682,4 +700,10 @@ void cleanup()
>  	fflush(stdout);
>  	tst_rmdir();
>  
> -}
> \ No newline at end of file
> +	if ( adjust_max_pids > max_pids ) {
> +	    if ( ! set_max_pids(max_pids) ) {
> +                tst_resm(TBROK, "cannot restore the max pids");
> +                tst_exit();

Use tst_brkm() instead of these two.

> +	    }
> +        }
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
