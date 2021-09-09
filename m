From: pvorel <pvorel@suse.de>
Date: Thu, 09 Sep 2021 18:32:42 +0200
Subject: [LTP] [PATCH 8/8] syscalls/setresuid03: Convert to new API
In-Reply-To: <20210909155126.2720-8-mdoucha@suse.cz>
References: <20210909155126.2720-1-mdoucha@suse.cz>
 <20210909155126.2720-8-mdoucha@suse.cz>
Message-ID: <287a9879ef8b3342cb88225e4e319733@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

LGTM, nits below.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> The original test looks up specific usernames which may not exist on 
> some
> systems. Use any two non-root UIDs instead.
+1

> +static void run(unsigned int n)
>  {
> -	tst_require_root();
> +	const struct test_data_t *tc = test_data + n;
> 
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> +	TEST(SETRESUID(*tc->real_uid, *tc->eff_uid, *tc->sav_uid));
It's a second test where we could use TST_EXP_FAIL_SILENT() if we had it 
defined.
Maybe I'll add it.

> 
> -	if (getpwnam("nobody") == NULL) {
> -		tst_brkm(TBROK, NULL, "nobody must be a valid user.");
> +	if (TST_RET != -1) {
> +		tst_res(TFAIL | TTERRNO, "%s returned unexpected value %ld",
> +			tc->test_msg, TST_RET);
> +		return;
>  	}
> 
> -	if (getpwnam("bin") == NULL) {
> -		tst_brkm(TBROK, NULL, "bin must be a valid user.");
> +	if (TST_ERR != tc->exp_errno) {
nit: checkpatch complains (TST_ERR should be second)

> +		tst_res(TFAIL | TTERRNO, "%s returned unexpected error",
> +			tc->test_msg);
> +		return;
>  	}
> 
