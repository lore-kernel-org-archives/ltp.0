From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 Aug 2021 14:57:41 +0200
Subject: [LTP] [PATCH] [v2,
 5/6] syscalls/sysfs: Convert sysfs05 to the new API
In-Reply-To: <20210811122235.1627-1-sujiaxun@uniontech.com>
References: <20210811122235.1627-1-sujiaxun@uniontech.com>
Message-ID: <YRUaxQjWFSw9Y4J1@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -char *TCID = "sysfs05";
> -static int option[3] = { 1, 4, 1 };	/* valid and invalid option */
> -static char *fsname[] = { "ext0", " ext2", (char *)-1 };
> -
> -static struct test_case_t {
> -	char *err_desc;		/*error description */
> -	int exp_errno;		/* expected error number */
> -	char *exp_errval;	/*Expected errorvalue string */
> -} testcase[] = {
> -	{
> -	"Invalid option", EINVAL, "EINVAL"}, {
> -	"Invalid filesystem name", EINVAL, "EINVAL "}, {
> -	"Address is out of your address space", EFAULT, "EFAULT "}
> +
> +char *bad_addr;
> +
> +static struct test_case {
> +	int option;
> +	char *fsname;
> +	int fsindex;
> +	char *err_desc;
> +	int exp_errno;
> +} tcases[] = {
> +	{1, "ext0", 0, "Invalid filesystem name", EINVAL},
> +	{4, "ext4", 0, "Invalid option", EINVAL},
> +	{1, (char *)-1, 0, "Address is out of your address space", EFAULT},
> +	{2, NULL, 1000, "fs_index is out of bounds", EINVAL}
>  };
> 
> -int TST_TOTAL = ARRAY_SIZE(testcase);
> -
> -int main(int ac, char **av)
> +static void verify_sysfs05(unsigned int nr)
>  {
> -	int lc, i;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		for (i = 0; i < TST_TOTAL; i++) {
> -
> -			tst_count = 0;
> -			TEST(ltp_syscall(__NR_sysfs, option[i], fsname[i]));
> +
> +	if (nr < 3)
> +		TST_EXP_FAIL(tst_syscall(__NR_sysfs, tcases[nr].option, tcases[nr].fsname),
> +					tcases[nr].exp_errno, "%s", tcases[nr].err_desc);
> +	else
> +		TST_EXP_FAIL(tst_syscall(__NR_sysfs, tcases[nr].option, tcases[nr].fsindex, bad_addr),
> +					tcases[nr].exp_errno, "%s", tcases[nr].err_desc);

Depending on the index here is ugly hack and there is absolutelly no
reason to do so. We can switch on the option easily instead with:

	if (tcases[nr].option == 1) {
		/* call with fsname */
	} else {
		/* call with fs index */
	}


Also tests usually store a pointer to the current testcases at the start
of the verify function to make the code slightly shorter as:

static void verify_foo(unsigned int n)
{
	struct tcase *tc = &tcases[n];

	if (tc->option == 1) {

...

}

> -			/* check return code */
> -			if ((TEST_RETURN == -1)
> -			    && (TEST_ERRNO == testcase[i].exp_errno)) {
> -				tst_resm(TPASS,
> -					 "sysfs(2) expected failure;"
> -					 " Got errno - %s : %s",
> -					 testcase[i].exp_errval,
> -					 testcase[i].err_desc);
> -			} else {
> -				tst_resm(TFAIL, "sysfs(2) failed to produce"
> -					 " expected error; %d, errno"
> -					 ": %s and got %d",
> -					 testcase[i].exp_errno,
> -					 testcase[i].exp_errval, TEST_ERRNO);
> -			}
> -
> -		}		/*End of TEST LOOPS */
> -	}
> -
> -	/*Clean up and exit */
> -	cleanup();
> -
> -	tst_exit();
> -}				/*End of main */
> +}
> 
> -/* setup() - performs all ONE TIME setup for this test */
>  void setup(void)

missing static

>  {
> -
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> +	bad_addr = tst_get_bad_addr(NULL);

Isn't the bad address unused here?

What we should do instead is to loop over the tcases array here and set
the fsname to the bad address when exp_errno is set to EFAULT.

>  }
> 
> -/*
> -* cleanup() - Performs one time cleanup for this test at
> -* completion or premature exit
> -*/
> -void cleanup(void)
> -{
> +static struct tst_test test = {
> +	.setup = setup,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = verify_sysfs05,
> +};
> 
> -}
> --
> 2.20.1
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
