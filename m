From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 25 Aug 2016 14:07:40 +0200
Subject: [LTP] [PATCH V2 10/11] waitpid13: use the new API
In-Reply-To: <1472041679-29759-11-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1472041679-29759-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1472041679-29759-11-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20160825120740.GH10490@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	if (TST_TRACE(waitpid_ret_test(0, &status, WNOHANG | WUNTRACED,
> +				       0, 0)))
> +		return;
>  
> -static void setup(void)
> -{
> -	TEST_PAUSE;
> -}
> -
> -static void cleanup(void)
> -{
> -}
> +	if (TST_TRACE(waitpid_ret_test(-group, &status, WNOHANG | WUNTRACED,
> +				       0, 0)))
> +		return;
>  
> -static void inthandlr(void)
> -{
> -	intintr++;
> -}
> +	TST_CHECKPOINT_WAKE2(0, MAXKIDS);
>  
> -static void wait_for_parent(void)
> -{
> -	int testvar;
> +	if (TST_TRACE(reap_children(0, WUNTRACED, fork_kid_pid + (MAXKIDS / 2),
> +				    MAXKIDS / 2)))
> +		return;
>  
> -	while (!intintr)
> -		testvar = 0;
> -}
> +	if (TST_TRACE(reap_children(-group, WUNTRACED, fork_kid_pid,
> +				    MAXKIDS / 2)))
> +		return;

Again, these are just cosmetic, but if we shorten the group to just grp
and the waitpid_ret_test to waitpid_test, all but one of these would fit
to one line.

Otherwise this looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
