From: yangx.jy <yangx.jy@cn.fujitsu.com>
Date: Mon, 4 Jan 2021 21:07:03 +0800
Subject: [LTP] [RFC PATCH 2/2] include/tst_test_macros.h: Report TINFO
 when TST_EXP_FD() succeeded
In-Reply-To: <20210104125423.19183-2-yangx.jy@cn.fujitsu.com>
References: <20210104125423.19183-1-yangx.jy@cn.fujitsu.com>
 <20210104125423.19183-2-yangx.jy@cn.fujitsu.com>
Message-ID: <5FF312F7.1060907@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

I will change the TST_EXP_PASS as well if you approve the patch.

Best Regards,
Xiao Yang
On 2021/1/4 20:54, Xiao Yang wrote:
> In Summary output, avoid counting the double passed for one test:
> -------------------------------------
> ./open01
> tst_test.c:1261: TINFO: Timeout per run is 0h 05m 00s
> open01.c:48: TPASS: open() with sticky bit returned fd 3
> open01.c:59: TPASS: sticky bit is set as expected
> open01.c:48: TPASS: open() with sirectory bit returned fd 3
> open01.c:59: TPASS: sirectory bit is set as expected
>
> Summary:
> passed   4
> failed   0
> broken   0
> skipped  0
> warnings 0
> -------------------------------------
>
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  include/tst_test_macros.h               | 2 +-
>  lib/newlib_tests/test_macros01.c        | 3 ++-
>  testcases/kernel/syscalls/open/open11.c | 2 ++
>  3 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
> index 3016d95c2..d1fc3cf70 100644
> --- a/include/tst_test_macros.h
> +++ b/include/tst_test_macros.h
> @@ -64,7 +64,7 @@ extern void *TST_RET_PTR;
>  			break;                                                 \
>  		}                                                              \
>                                                                                 \
> -		TST_MSGP_(TPASS, " returned fd %ld", TST_RET,                  \
> +		TST_MSGP_(TINFO, " returned fd %ld", TST_RET,                  \
>  		         #SCALL, ##__VA_ARGS__);                               \
>                                                                                 \
>  		TST_PASS = 1;                                                  \
> diff --git a/lib/newlib_tests/test_macros01.c b/lib/newlib_tests/test_macros01.c
> index 9a920f8e4..9aa3885c7 100644
> --- a/lib/newlib_tests/test_macros01.c
> +++ b/lib/newlib_tests/test_macros01.c
> @@ -30,7 +30,8 @@ static void do_test(void)
>  	TST_EXP_FD(fail_fd(), "TEST DESCRIPTION");
>  	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
>  	TST_EXP_FD(pass_fd(), "%s", "TEST DESCRIPTION PARAM");
> -	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
> +	if (TST_PASS)
> +		tst_res(TPASS, "TST_PASS = %i", TST_PASS);
>  	TST_EXP_FD(inval_val());
>  	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
>  }
> diff --git a/testcases/kernel/syscalls/open/open11.c b/testcases/kernel/syscalls/open/open11.c
> index ded384fa8..f7ac96d90 100644
> --- a/testcases/kernel/syscalls/open/open11.c
> +++ b/testcases/kernel/syscalls/open/open11.c
> @@ -283,6 +283,8 @@ static void verify_open(unsigned int n)
>  	} else if (tc[n].err == 0) {
>  		TST_EXP_FD(open(tc[n].path, tc[n].flags, tc[n].mode),
>  		           "%s", tc[n].desc);
> +		if (TST_PASS)
> +			tst_res(TPASS, "%s", tc[n].desc);
>  	} else {
>  		TEST(open(tc[n].path, tc[n].flags, tc[n].mode));
>  		tst_res(TPASS, "%s", tc[n].desc);



