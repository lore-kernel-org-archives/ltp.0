From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 25 Aug 2016 13:20:53 +0200
Subject: [LTP] [PATCH V2 04/11] syscalls/waitpid: call reap_children()
 via TST_TRACE()
In-Reply-To: <1472041679-29759-5-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1472041679-29759-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1472041679-29759-5-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20160825112052.GD10490@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
This is obviously correct.

> diff --git a/testcases/kernel/syscalls/waitpid/waitpid11.c b/testcases/kernel/syscalls/waitpid/waitpid11.c
> index 9b51e04..1067bca 100644
> --- a/testcases/kernel/syscalls/waitpid/waitpid11.c
> +++ b/testcases/kernel/syscalls/waitpid/waitpid11.c
> @@ -50,11 +50,12 @@ static void do_child_1(void)
>  
>  	TST_CHECKPOINT_WAKE2(0, MAXKIDS);
>  
> -	if (reap_children(0, 0, fork_kid_pid + (MAXKIDS / 2), MAXKIDS / 2))
> +	if (TST_TRACE(reap_children(0, 0, fork_kid_pid + (MAXKIDS / 2),
> +				    MAXKIDS / 2)))
>  		return;

Hmm, if we drop the useless parenthesis and spaces around / we will fit
into 80 chars:

	if (TST_TRACE(reap_children(0, 0, fork_kid_pid + MAXKIDS/2, MAXKIDS/2)))
		return;
-- 
Cyril Hrubis
chrubis@suse.cz
