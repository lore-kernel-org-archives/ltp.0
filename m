From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 7 May 2021 19:26:10 +0200
Subject: [LTP] [PATCH 4/4 v2] syscalls/fcntl: Replace TINFO with TPASS
 or TFAIL
In-Reply-To: <20210506050047.935-1-zhaogongyi@huawei.com>
References: <20210506050047.935-1-zhaogongyi@huawei.com>
Message-ID: <YJV4MtK/5NvpIXbU@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Zhao,

> 1)remove redundant variable
> 2)remove redundant log
> 3)replace TINFO with TPASS or TFAIL

> For those:
> 	testcases/kernel/syscalls/fcntl/fcntl16.c
> 	testcases/kernel/syscalls/fcntl/fcntl18.c
nit: we have git log to see what files has been changed.
IMHO it's better to add fcntl18{16,18}: to the first line.

> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
> v1->v2:
> 	1)correct the patch's format error
> 	2)remove the useless//block1: comments
>  testcases/kernel/syscalls/fcntl/fcntl16.c | 73 +++++++----------------
>  testcases/kernel/syscalls/fcntl/fcntl18.c | 43 ++-----------
>  2 files changed, 27 insertions(+), 89 deletions(-)

> diff --git a/testcases/kernel/syscalls/fcntl/fcntl16.c b/testcases/kernel/syscalls/fcntl/fcntl16.c
> index a77a81298..c5c49284a 100644
> --- a/testcases/kernel/syscalls/fcntl/fcntl16.c
> +++ b/testcases/kernel/syscalls/fcntl/fcntl16.c
> @@ -441,7 +441,7 @@ void setup(void)
>  	sigaction(SIGALRM, &sact, NULL);
>  }

> -int run_test(int file_flag, int file_mode, int start, int end)
> +static void run_test(int file_flag, int file_mode, int start, int end)
>  {
>  	int child_count;
>  	int child;
> @@ -468,7 +468,7 @@ int run_test(int file_flag, int file_mode, int start, int end)
>  				 errno);
>  			close(fd);
>  			unlink(tmpname);
> -			return 1;
> +			goto err;
not sure if change to use goto satisfied Cyril's requirement:

we should rather skip the test in the main instead
as it was done in the original code as:

	if (NO_NFS)
		run_test(...);
	else
		tst_resm(TCONF, "Skipping mandatory locking on NFS");

other than that LGTM
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Also test ignores -i N parameter, because it does not use TEST_LOOPING().
But that's another issue which should be fixed by rewriting the test to new API.

Kind regards,
Petr
