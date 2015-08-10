Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZOmCM-0000W6-3S
	for ltp-list@lists.sourceforge.net; Mon, 10 Aug 2015 12:29:02 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZOmCI-0006ZD-VH
	for ltp-list@lists.sourceforge.net; Mon, 10 Aug 2015 12:29:02 +0000
Date: Mon, 10 Aug 2015 14:28:32 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150810122832.GA25209@rei.suse.de>
References: <1438927624-27401-1-git-send-email-sunyuan3@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1438927624-27401-1-git-send-email-sunyuan3@huawei.com>
Subject: Re: [LTP] [PATCH] Add tst_wait_record_childstatus function.
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
To: Yuan Sun <sunyuan3@huawei.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
> ---
>  doc/test-writing-guidelines.txt               |  7 +++---
>  include/test.h                                |  2 ++
>  lib/tst_res.c                                 | 31 +++++++++++++++++++++++++++
>  testcases/kernel/containers/userns/userns01.c | 13 ++---------
>  4 files changed, 39 insertions(+), 14 deletions(-)
> 
> diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
> index 69b8cb7..8b46a19 100644
> --- a/doc/test-writing-guidelines.txt
> +++ b/doc/test-writing-guidelines.txt
> @@ -631,15 +631,16 @@ If you have to do the test in a child process you have two possibilities:
>  * Or you can stick to plain old 'exit()' with 'TPASS', 'TBROK', 'TFAIL' and
>    'TCONF' constants.
>  
> -Then you call 'tst_record_childstatus()' to records the result of the test
> -(done in child process) which propagates the child result (child exit status)
> -to the parent process correctly.
> +Then you call 'tst_record_childstatus()' or 'tst_wait_record_childstatus' to
> +records the result of the test (done in child process) which propagates the
> +child result (child exit status) to the parent process correctly.
>  
>  [source,c]
>  -------------------------------------------------------------------------------
>  #include "test.h"
>  
>  void tst_record_childstatus(void (*cleanup)(void), pid_t child);
> +void tst_wait_record_childstatus(void (*cleanup)(void));
>  -------------------------------------------------------------------------------
>  
>  This function does a 'waitpid()' on child process and record child process's
> diff --git a/include/test.h b/include/test.h
> index ac00590..15b2139 100644
> --- a/include/test.h
> +++ b/include/test.h
> @@ -194,6 +194,8 @@ pid_t tst_fork(void);
>   */
>  void tst_record_childstatus(void (*cleanup)(void), pid_t child);
>  
> +void tst_wait_record_childstatus(void (*cleanup)(void));
> +
>  extern int tst_count;
>  
>  /* lib/tst_sig.c */
> diff --git a/lib/tst_res.c b/lib/tst_res.c
> index 7a64a50..f21c1d2 100644
> --- a/lib/tst_res.c
> +++ b/lib/tst_res.c
> @@ -572,6 +572,37 @@ void tst_record_childstatus(void (*cleanup)(void), pid_t child)
>  	}
>  }
>  
> +void tst_wait_record_childstatus(void (*cleanup)(void))
> +{
> +	int status, ttype_result;
> +
> +	if (wait(&status) < 0)
> +		tst_brkm(TWARN | TERRNO, NULL, "wait failed");
> +
> +	if (WIFEXITED(status)) {
> +		ttype_result = WEXITSTATUS(status);
> +		ttype_result = TTYPE_RESULT(ttype_result);
> +		T_exitval |= ttype_result;
> +
> +		if (ttype_result == TPASS)
> +			tst_resm(TINFO, "Child process returned TPASS");
> +
> +		if (ttype_result & TFAIL)
> +			tst_resm(TINFO, "Child process returned TFAIL");
> +
> +		if (ttype_result & TBROK)
> +			tst_resm(TINFO, "Child process returned TBROK");
> +
> +		if (ttype_result & TCONF)
> +			tst_resm(TINFO, "Child process returned TCONF");
> +
> +	} else {
> +		tst_brkm(TBROK, cleanup, "child process killed by "
> +			 "unexpected signal %s(%d)",
> +			 tst_strsig(WTERMSIG(status)), WTERMSIG(status));
> +	}
> +}

There is no need for this. If you pass -1 as pid to waitpid() it's the
same as calling wait().

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
