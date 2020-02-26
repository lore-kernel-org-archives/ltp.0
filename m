From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 26 Feb 2020 22:08:18 +0800
Subject: [LTP] [PATCH V2] syscalls/pidfd_open: Continue with rest of the
 tests on failure
In-Reply-To: <2f579843fb1ff09cfaaa1b991b48437f525740b3.1582673499.git.viresh.kumar@linaro.org>
References: <54a3d6fcef8cfed89a1e4f0b56717f56aa502293.1582611994.git.viresh.kumar@linaro.org>
 <2f579843fb1ff09cfaaa1b991b48437f525740b3.1582673499.git.viresh.kumar@linaro.org>
Message-ID: <5E567BD2.302@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2020/2/26 7:33, Viresh Kumar wrote:
> With tst_brk(), the tests end immediately while what we want to do here
> is to test rest of the failure tests. Use tst_res() to report result and
> continue with rest of the failure tests.
>
> Signed-off-by: Viresh Kumar<viresh.kumar@linaro.org>
> ---
> V2: Use return, instead of if/else blocks.
>
>   testcases/kernel/syscalls/pidfd_open/pidfd_open02.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c
> index d73b5326b3b1..9cdded13525a 100644
> --- a/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c
> +++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c
> @@ -35,14 +35,16 @@ static void run(unsigned int n)
>
>   	if (TST_RET != -1) {
>   		SAFE_CLOSE(TST_RET);
> -		tst_brk(TFAIL, "%s: pidfd_open succeeded unexpectedly (index: %d)",
> +		tst_res(TFAIL, "%s: pidfd_open succeeded unexpectedly (index: %d)",
>   			tc->name, n);
> +		return;
>   	}
>
>   	if (tc->exp_errno != TST_ERR) {
> -		tst_brk(TFAIL | TTERRNO, "%s: pidfd_open() should fail with %s",
> +		tst_res(TFAIL | TTERRNO, "%s: pidfd_open() should fail with %s",
>   			tc->name, tst_strerrno(tc->exp_errno));
> -	}
> +		return;
> +	 }
>
>   	tst_res(TPASS | TTERRNO, "%s: pidfd_open() failed as expected",
>   		tc->name);
  Acked-by: Xiao Yang <ice_yangxiao@163.com>


