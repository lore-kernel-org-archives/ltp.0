Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1X1xqe-0006rA-2F
	for ltp-list@lists.sourceforge.net; Tue, 01 Jul 2014 13:11:48 +0000
Date: Tue, 1 Jul 2014 15:11:27 +0200
From: chrubis@suse.cz
Message-ID: <20140701131127.GB23601@rei.scz.novell.com>
References: <1404125304-28650-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1404125304-28650-4-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1404125304-28650-4-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH 3/3] syscalls: use tst_get_unused_pid()
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
> --- a/testcases/kernel/syscalls/move_pages/move_pages07.c
> +++ b/testcases/kernel/syscalls/move_pages/move_pages07.c
> @@ -95,7 +95,7 @@ int main(int argc, char **argv)
>  		void *pages[TEST_PAGES] = { 0 };
>  		int nodes[TEST_PAGES];
>  		int status[TEST_PAGES];
> -		int ipid;
> +		pid_t ipid;
>  
>  		/* reset tst_count in case we are looping */
>  		tst_count = 0;
> @@ -107,15 +107,7 @@ int main(int argc, char **argv)
>  		for (i = 0; i < TEST_PAGES; i++)
>  			nodes[i] = to_node;
>  
> -		ipid = fork();
> -		if (ipid == -1) {
> -			tst_resm(TBROK | TERRNO, "fork failed");
> -			goto err_free_pages;
> -		}
> -		if (ipid == 0)
> -			exit(0);
> -
> -		wait(NULL);
> +		ipid = tst_get_unused_pid(cleanup);
>  
>  		ret = numa_move_pages(ipid, TEST_PAGES, pages, nodes,
>  				      status, MPOL_MF_MOVE);
> @@ -125,9 +117,6 @@ int main(int argc, char **argv)
>  		else
>  			tst_resm(TFAIL|TERRNO, "move pages did not fail "
>  				 "with ESRCH ret: %d", ret);
> -
> -err_free_pages:
> -		free_pages(pages, TEST_PAGES);

The free_pages() should stay here because the codepath gets here
eventually even if the goto does not happen.

>  	}
>  #else
>  	tst_resm(TCONF, "move_pages support not found.");

...

> diff --git a/testcases/kernel/syscalls/setpgid/setpgid02.c b/testcases/kernel/syscalls/setpgid/setpgid02.c
> index 404c798..40180a2 100644
> --- a/testcases/kernel/syscalls/setpgid/setpgid02.c
> +++ b/testcases/kernel/syscalls/setpgid/setpgid02.c
> @@ -55,16 +55,17 @@
>  #include "test.h"
>  #include "usctest.h"
>  
> -void setup();
> -void cleanup();
> +static void setup();
> +static void cleanup();

Add void to the parameters since you are touching it.

>  char *TCID = "setpgid02";
>  int TST_TOTAL = 3;
>  
> -pid_t pgid, pid;
> -pid_t bad_pid = -1;
> -pid_t zero_pid = 0;
> -pid_t inval_pid = 99999;
> +static pid_t pgid, pid;
> +static pid_t bad_pid = -1;
> +static pid_t zero_pid;
> +static pid_t unused_pid;
> +static pid_t inval_pid = 99999;


The rest of the patchset looks good to me, acked (with these two issues
above fixed).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
