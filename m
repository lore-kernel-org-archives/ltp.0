From: Xiao Yang <ice_yangxiao@163.com>
Date: Fri, 19 Mar 2021 22:41:45 +0800
Subject: [LTP] [PATCH v2] syscalls/swapon/swapon0{1..3}: Remove the
 check for BTRFS
In-Reply-To: <20210319134511.1844348-1-qi.fuli@fujitsu.com>
References: <20210319134511.1844348-1-qi.fuli@fujitsu.com>
Message-ID: <f8ee64cb-40ba-441c-1fbf-bb1de6583b28@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Qi,

LGTM.

Reviewed-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Best Regards,

Xiao Yang

On 3/19/21 9:45 PM, QI Fuli wrote:
> remove redundant tasks as BTRFS is checked in is_swap_supported()
> Fixes: caf453532("syscalls/swapon/swapon0{1..3}: use helpers to check
> 	support status")
>
> Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
> ---
>   testcases/kernel/syscalls/swapon/swapon01.c |  7 -------
>   testcases/kernel/syscalls/swapon/swapon02.c | 14 +++-----------
>   testcases/kernel/syscalls/swapon/swapon03.c | 15 +--------------
>   3 files changed, 4 insertions(+), 32 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/swapon/swapon01.c b/testcases/kernel/syscalls/swapon/swapon01.c
> index f95ce0ab2..aff842e4c 100644
> --- a/testcases/kernel/syscalls/swapon/swapon01.c
> +++ b/testcases/kernel/syscalls/swapon/swapon01.c
> @@ -32,18 +32,11 @@ static void cleanup(void);
>   char *TCID = "swapon01";
>   int TST_TOTAL = 1;
>
> -static long fs_type;
> -
>   static void verify_swapon(void)
>   {
>   	TEST(ltp_syscall(__NR_swapon, "./swapfile01", 0));
>
>   	if (TEST_RETURN == -1) {
> -		if (fs_type == TST_BTRFS_MAGIC && errno == EINVAL) {
> -			tst_brkm(TCONF, cleanup,
> -			         "Swapfile on BTRFS not implemeted");
> -			return;
> -		}
>   		tst_resm(TFAIL | TTERRNO, "Failed to turn on swapfile");
>   	} else {
>   		tst_resm(TPASS, "Succeeded to turn on swapfile");
> diff --git a/testcases/kernel/syscalls/swapon/swapon02.c b/testcases/kernel/syscalls/swapon/swapon02.c
> index 3d49d0c6b..f0f99619d 100644
> --- a/testcases/kernel/syscalls/swapon/swapon02.c
> +++ b/testcases/kernel/syscalls/swapon/swapon02.c
> @@ -47,7 +47,6 @@ int TST_TOTAL = 4;
>
>   static uid_t nobody_uid;
>   static int do_swapoff;
> -static long fs_type;
>
>   static struct test_case_t {
>   	char *err_desc;
> @@ -81,11 +80,6 @@ static void verify_swapon(struct test_case_t *test)
>   		return;
>   	}
>
> -	if (fs_type == TST_BTRFS_MAGIC && errno == EINVAL) {
> -		tst_resm(TCONF, "Swapfile on BTRFS not implemeted");
> -			return;
> -	}
> -
>   	tst_resm(TFAIL, "swapon(2) failed to produce expected error:"
>   	         " %d, errno: %s and got %d.", test->exp_errno,
>   	         test->exp_errval, TEST_ERRNO);
> @@ -138,12 +132,10 @@ static void setup(void)
>   	make_swapfile(cleanup, "swapfile01", 0);
>   	make_swapfile(cleanup, "alreadyused", 0);
>
> -	if (ltp_syscall(__NR_swapon, "alreadyused", 0)) {
> -		if (fs_type != TST_BTRFS_MAGIC || errno != EINVAL)
> -			tst_resm(TWARN | TERRNO, "swapon(alreadyused) failed");
> -	} else {
> +	if (ltp_syscall(__NR_swapon, "alreadyused", 0))
> +		tst_resm(TWARN | TERRNO, "swapon(alreadyused) failed");
> +	else
>   		do_swapoff = 1;
> -	}
>
>   	TEST_PAUSE;
>   }
> diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
> index cef57150c..19455bfe6 100644
> --- a/testcases/kernel/syscalls/swapon/swapon03.c
> +++ b/testcases/kernel/syscalls/swapon/swapon03.c
> @@ -52,8 +52,6 @@ int TST_TOTAL = 1;
>
>   static int swapfiles;
>
> -static long fs_type;
> -
>   int testfiles = 3;
>   static struct swap_testfile_t {
>   	char *filename;
> @@ -215,9 +213,6 @@ static int setup_swap(void)
>   			/* turn on the swap file */
>   			res = ltp_syscall(__NR_swapon, filename, 0);
>   			if (res != 0) {
> -				if (fs_type == TST_BTRFS_MAGIC && errno == EINVAL)
> -					exit(2);
> -
>   				if (errno == EPERM) {
>   					printf("Successfully created %d "
>   					       "swapfiles\n", j);
> @@ -233,16 +228,8 @@ static int setup_swap(void)
>   	} else
>   		waitpid(pid, &status, 0);
>
> -	switch (WEXITSTATUS(status)) {
> -	case 0:
> -	break;
> -	case 2:
> -		tst_brkm(TCONF, cleanup, "Swapfile on BTRFS not implemeted");
> -	break;
> -	default:
> +	if (WEXITSTATUS(status) == 1)
>   		tst_brkm(TFAIL, cleanup, "Failed to setup swaps");
> -	break;
> -	}
>
>   	/* Create all needed extra swapfiles for testing */
>   	for (j = 0; j < testfiles; j++)
> --
> 2.29.2
>
>

