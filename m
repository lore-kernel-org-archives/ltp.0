From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 3 Aug 2021 13:34:24 +0200
Subject: [LTP] [PATCH] syscalls/madvise06: Add madvise WILLNEED
 performance problem tag
In-Reply-To: <1627979166-967-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1627979166-967-1-git-send-email-xuyang2018.jy@fujitsu.com>
Message-ID: <YQkpwAieJwTCzK+c@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/madvise/madvise06.c b/testcases/kernel/syscalls/madvise/madvise06.c
> index 63d8d5452..f2f65ff96 100644
> --- a/testcases/kernel/syscalls/madvise/madvise06.c
> +++ b/testcases/kernel/syscalls/madvise/madvise06.c
> @@ -35,6 +35,12 @@
>   * faults. Two faults are allowed incase some tasklet or something
>   * else unexpected, but irrelevant procedure, registers a fault to
>   * our process.
> + *
> + * It also can reproduce the MADV_WILLNEED preformance problem.
> + * It was introduced since 5.9 kernel with the following commit
> + *   e6e88712e43b ("mm: optimise madvise WILLNEED")
> + * and fixed since 5.10-rc5 kernel with the following commit
> + *   66383800df9c ("mm: fix madvise WILLNEED performance problem").
>   */
>  
>  #include <errno.h>
> @@ -242,6 +248,8 @@ static struct tst_test test = {
>  	.tags = (const struct tst_tag[]) {
>  		{"linux-git", "55231e5c898c"},
>  		{"linux-git", "8de15e920dc8"},
> +		{"linux-git", "e6e88712e43b"},
> +		{"linux-git", "66383800df9c"},

We only put patches that fixed the problem into the tags since we use
these to print failure hints about missing kernel patches.

Other than that it looks fine.

>  		{}
>  	}
>  };
> -- 
> 2.23.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
