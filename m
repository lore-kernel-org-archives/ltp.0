From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 21 Jun 2021 10:42:31 +0200
Subject: [LTP] [PATCH 1/7] io_cancel02: Add io_cancel02 test for libaio
In-Reply-To: <20210618094210.183027-2-xieziyao@huawei.com>
References: <20210618094210.183027-1-xieziyao@huawei.com>
 <20210618094210.183027-2-xieziyao@huawei.com>
Message-ID: <YNBQ95gIlM9TTjpA@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#include "config.h"
> +#include "tst_test.h"
> +
> +#ifdef HAVE_LIBAIO
> +#define EXP_RET (-EFAULT)
> +
> +#include <libaio.h>
> +
> +static void run(void)
> +{
> +	io_context_t ctx;
> +
> +	memset(&ctx, 0, sizeof(ctx));
> +	TEST(io_cancel(ctx, NULL, NULL));
> +
> +	if (TST_RET == 0)
> +		tst_res(TFAIL, "call succeeded unexpectedly");
> +	else if (TST_RET == EXP_RET)
> +		tst_res(TPASS, "io_cancel(ctx, NULL, NULL) returns %ld : %s",
> +			TST_RET, strerror(-TST_RET));
> +	else
> +		tst_res(TFAIL, "io_cancel(ctx, NULL, NULL) returns %ld : %s, expected %d : %s",
> +			TST_RET, strerror(-TST_RET), EXP_RET, strerror(-EXP_RET));

Please use TST_EXP_FAIL() instead.

> +}
> +
> +static struct tst_test test = {
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_AIO=y",
> +		NULL
> +	},
> +	.test_all = run,
> +};
> +
> +#else
> +TST_TEST_TCONF("test requires libaio and it's development packages");
> +#endif
> --
> 2.17.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
