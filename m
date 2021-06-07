From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 7 Jun 2021 15:15:36 +0200
Subject: [LTP] [PATCH 1/3] syscalls/io_destroy: Add io_destroy02 test
 for native AIO
In-Reply-To: <20210507083321.167998-2-xieziyao@huawei.com>
References: <20210507083321.167998-1-xieziyao@huawei.com>
 <20210507083321.167998-2-xieziyao@huawei.com>
Message-ID: <YL4b+J7Cc+i4Bs7w@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Test looks good but there is one minor problem that has to be solwed,
see below.

> +/*
> + * Copyright (c) Crackerjack Project., 2007
> + * Ported from Crackerjack to LTP by Masatake YAMATO <yamato@redhat.com>
> + * Copyright (c) 2011 Cyril Hrubis <chrubis@suse.cz>
> + * Copyright (c) 2017 Xiao Yang <yangx.jy@cn.fujitsu.com>
> + * Copyright (c) 2021 Xie Ziyao <xieziyao@huawei.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Test io_destroy invoked via syscall(2) with an invalid ctx and expects
> + * it to return EINVAL.
> + */
> +
> +#include <linux/aio_abi.h>
> +
> +#include "config.h"
> +#include "tst_test.h"
> +#include "lapi/syscalls.h"
> +
> +static void verify_io_destroy(void)
> +{
> +	aio_context_t ctx;
> +	memset(&ctx, 0xff, sizeof(ctx));
> +	TST_EXP_FAIL(tst_syscall(__NR_io_destroy, ctx), EINVAL);

This may fail the test if CONFIG_AIO has been disabled in kernel, which
I think is common for embedded tests.

Thinking of solution the easiest fix would probably be to add
.needs_kconfigs with "CONFIG_AIO" to the tst_test structure.

> +}
> +
> +static struct tst_test test = {
> +	.test_all = verify_io_destroy,
> +};
> --
> 2.17.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz
