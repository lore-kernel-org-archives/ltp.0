From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 28 Jun 2021 17:02:56 +0200
Subject: [LTP] [PATCH v3 2/3] include/tst_test_macro.h: Add
 TST_EXP_FAIL2 macros
In-Reply-To: <1624512827-3256-2-git-send-email-xuyang2018.jy@fujitsu.com>
References: <YNM4rlDJLzb4xk6v@yuki>
 <1624512827-3256-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1624512827-3256-2-git-send-email-xuyang2018.jy@fujitsu.com>
Message-ID: <YNnkoGkFbv1HftMs@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +[source,c]
> +-------------------------------------------------------------------------------
> +static void test(void)
> +{
> +	...
> +	TST_EXP_FAIL2(msgget(key, flags), EINVAL, "msgget(%i, %i)", key, flags);
> +	...
> +}
> +The 'TST_EXP_FAIL2()' is the same as 'TST_EXP_FAIL' the only difference is that
> +the return value is a non-negative integer if call passes.
> +

I've fixed this part, it was missing the end of the code block (the ----
at the end) and reworded the description a bit and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
