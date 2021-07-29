From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 29 Jul 2021 17:27:09 +0200
Subject: [LTP] [PATCH v3 5/8] doc: Document TEST macro and state
 TST_RET/ERR rule LTP-002
In-Reply-To: <20210728123412.31858-6-rpalethorpe@suse.com>
References: <20210728123412.31858-1-rpalethorpe@suse.com>
 <20210728123412.31858-6-rpalethorpe@suse.com>
Message-ID: <YQLIzZJiDUKznZ/d@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've pushed all but this patch, see below.

>  -------------------------------------------------------------------------------
>  
> -The 'TST_EXP_FAIL2()' is the same as 'TST_EXP_FAIL()' except the return value
> -is expected to be non-negative integer if call passes.
> +The 'TST_EXP_FAIL2()' is the same as 'TST_EXP_FAIL()' except the
> +return value is expected to be non-negative integer if call
> +passes. These macros build upon the +TEST()+ macro and associated
> +variables.
> +
> +[source,c]
> +-------------------------------------------------------------------------------
> +TEST(socket(AF_INET, SOCK_RAW, 1));
> +if (TST_RET > -1) {
> +	tst_res(TFAIL, "Created raw socket");
> +	SAFE_CLOSE(TST_RET);
> +} else if (TST_ERR != EPERM) {
> +	tst_res(TFAIL | TTERRNO,
> +		"Failed to create socket for wrong reason");
> +} else {
> +	tst_res(TPASS | TTERRNO, "Didn't create raw socket");
> +}
> +-------------------------------------------------------------------------------
> +
> +The +TEST+ macro sets +TST_RET+ to its argument's return value and
> ++TST_ERR+ to +errno+. The +TTERNO+ flag can be used to print the error
> +number's symbolic value.
> +
> +No LTP library function or macro, except those in 'tst_test_macros.h',
> +will write to these variables (rule 'LTP-002'). So their values will
> +not be changed unexpectedly.
> +
> +[source,c]
> +-------------------------------------------------------------------------------
> +TST_EXP_POSITIVE(wait(&status));
> +
> +if (!TST_PASS)
> +	return;
> +-------------------------------------------------------------------------------
> +
> +If the return value of 'wait' is positive. This macro will print a
> +pass result and set +TST_PASS+ appropriately. If the return value is
> +zero or negative, then it will print fail.
> +
> +As seen above, this and similar macros take optional variadic
> +arguments. These begin with a format string and then appropriate
> +values to be formatted. So
> +
> +[source,c]
> +-------------------------------------------------------------------------------
> +TST_EXP_PASS(chown("a/file", uid, gid), "chown(%s,%d,%d)",
> +	     "a/file", uid, gid);
> +-------------------------------------------------------------------------------
> +
> +expects +chown+ to return 0 and emits a pass or a fail. The arguments
> +to +chown+ will be printed in either case. There are many similar
> +macros to those shown here, please see 'tst_test_macros.h'.

There is already TST_EXP_PASS description before the TST_EXP_FAIL so
this duplicates it. Other than that the rest looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
