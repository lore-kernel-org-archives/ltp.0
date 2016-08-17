From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 17 Aug 2016 11:22:11 +0200
Subject: [LTP] [PATCH] tst_test.h: fix tst_test->tid for unsupported
	cases
In-Reply-To: <1471425396-26898-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1471425396-26898-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20160817092211.GC5817@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> If some cases aren't supported by system, they fail with
> the following message:
>   "tst_test.c:569: BROK: No tid set in test structure"
> We should return TCONF instead of TBROK.

My bad, I've broke it with the assert for non-null tid.

> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  include/tst_test.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 7e4997f..03722ec 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -160,8 +160,8 @@ int main(int argc, char *argv[])
>  
>  #define TST_TEST_TCONF(message)                                           \
>  	static void tst_do_test(void) { tst_brk(TCONF, "%s", message); }; \
> -        static struct tst_test test = { .test_all = tst_do_test }         \
> -
> +	static struct tst_test test = { .test_all = tst_do_test,          \
> +					.tid = "tst_test_conf" }          \

I guess that a little better solution would be to pass the test id to
the TST_TEST_TCONF() macro as well. I will fix that.

-- 
Cyril Hrubis
chrubis@suse.cz
