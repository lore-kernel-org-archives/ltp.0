From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 3 Mar 2021 16:26:37 +0100
Subject: [LTP] [PATCH] syscalls/chdir04: Convert to the new API
In-Reply-To: <20210303022221.1044234-1-ruansy.fnst@fujitsu.com>
References: <20210303022221.1044234-1-ruansy.fnst@fujitsu.com>
Message-ID: <YD+qrfp1cuX96Ftd@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static struct test_case_t {
> +	char *dir_name;
> +	int expected_error;
> +} testcase_list[] = {
> +	{bad_dir, ENAMETOOLONG},
> +	{noexist_dir, ENOENT},
> +	{(void *)-1, EFAULT}
> +};

This is way to verbose, we can just name these:

struct test_case_t -> struct tcase
testcase_list -> tcases
dir_name -> dir
expected_error -> exp_errno

without loosing any information.

> -void setup(void)
> +static void setup(void)
>  {
> -
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	tst_tmpdir();
> -
>  #ifdef UCLINUX
>  	bad_addr = mmap(0, 1, PROT_NONE,
>  			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
>  	if (bad_addr == MAP_FAILED)
> -		tst_brkm(TBROK | TERRNO, cleanup, "mmap() failed");
> -	TC[2].dname = bad_addr;
> +		tst_brk(TBROK | TERRNO, "mmap() failed");
> +	testcase_list[2].dir_name = bad_addr;
> +#endif
> +}
> +
> +static void cleanup(void)
> +{
> +#ifdef UCLINUX
> +	munmap(bad_addr, 1);
>  #endif
>  }

We do not support uClinux anymore, please remove that part as well.

> -void cleanup(void)
> +static void verify_chdir(unsigned int i)
>  {
> -	tst_rmdir();
> +	TEST(chdir(testcase_list[i].dir_name));
> +
> +	if (TST_RET != -1) {
> +		tst_res(TFAIL, "call succeeded unexpectedly");
> +		return;
> +	}
>  
> +	if (TST_ERR == testcase_list[i].expected_error)
> +		tst_res(TPASS | TTERRNO, "failed as expected");
> +	else {
> +		tst_res(TFAIL | TTERRNO,
> +			"didn't fail as expected (expected %d)",
> +			testcase_list[i].expected_error);
> +	}

We do have TST_EXP_FAIL() macro that should replace all of this.

>  }
> +
> +static struct tst_test test = {
> +	.needs_tmpdir = 1,
> +	.test = verify_chdir,
> +	.tcnt = ARRAY_SIZE(testcase_list),
> +	.setup = setup,
> +	.cleanup = cleanup,
> +};
> -- 
> 2.30.1
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
