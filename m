From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 9 Mar 2021 13:46:16 +0100
Subject: [LTP] [PATCH] max_map_count: Add judgment of abnormal situation
In-Reply-To: <20210309120914.711-1-zhaogongyi@huawei.com>
References: <20210309120914.711-1-zhaogongyi@huawei.com>
Message-ID: <YEduGMNAv1V+sQVs@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> When CommitLimit - Committed_AS < 128, there is no post processing,
> and the test will report "TBROK: Test haven't reported results".

> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>  testcases/kernel/mem/tunable/max_map_count.c | 2 ++
>  1 file changed, 2 insertions(+)

> diff --git a/testcases/kernel/mem/tunable/max_map_count.c b/testcases/kernel/mem/tunable/max_map_count.c
> index aa70fde59..ffc53cbb5 100644
> --- a/testcases/kernel/mem/tunable/max_map_count.c
> +++ b/testcases/kernel/mem/tunable/max_map_count.c
> @@ -162,6 +162,8 @@ static void max_map_count_test(void)
>  	max_iters = memfree / sysconf(_SC_PAGESIZE) * 1024 - 64;
>  	if (max_iters > MAX_MAP_COUNT)
>  		max_iters = MAX_MAP_COUNT;
> +	if (max_iters < 0)
> +		tst_brk(TCONF, "Test nees max_iters > 0, test skipped");
typo: nees => needs (no need to repost, can be changed during merge).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

You seems to exploring limits. Out of curiosity, which system / hw do you test?

Kind regards,
Petr

>  	max_maps = MAP_COUNT_DEFAULT;
>  	while (max_maps <= max_iters) {
