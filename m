From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 01 Jul 2021 08:17:53 +0100
Subject: [LTP] [PATCH 6/7] doc: Document TEST macro and state
 TST_RET/ERR rule LTP-002
In-Reply-To: <20210629072710.23800-7-rpalethorpe@suse.com>
References: <20210629072710.23800-1-rpalethorpe@suse.com>
 <20210629072710.23800-7-rpalethorpe@suse.com>
Message-ID: <87fswy33ku.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Richard Palethorpe via ltp <ltp@lists.linux.it> writes:

>  
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
> +This and similar macros take optional variadic arguments. These begin
> +with a format string and then appropriate values to be formatted.
> +
> +[source,c]
> +-------------------------------------------------------------------------------
> +TST_EXP_PASS(chown("a/file", uid, gid), "chown(%s,%d,%d)",
> +	     "a/file", uid, gid);
> +-------------------------------------------------------------------------------
> +
> +Expects +chown+ to return 0 and emits a pass or a fail. The arguments
> +to +chown+ will be printed in either case. There are many similar
> +macros, please see 'tst_test_macros.h'.

It appears that TST_EXP* macros (but not TEST) are documented
elsewhere. So I should probably combine these comments with the existing
docs.

-- 
Thank you,
Richard.
