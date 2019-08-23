From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 23 Aug 2019 12:33:37 +0800
Subject: [LTP] [PATCH v2 2/2] capability: library tests
In-Reply-To: <20190822141713.26825-2-rpalethorpe@suse.com>
References: <20190808153825.18363-2-rpalethorpe@suse.com>
 <20190822141713.26825-1-rpalethorpe@suse.com>
 <20190822141713.26825-2-rpalethorpe@suse.com>
Message-ID: <5D5F6CA1.8010305@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

on 2019/08/22 22:17, Richard Palethorpe wrote:

> diff --git a/lib/newlib_tests/tst_capability01.c b/lib/newlib_tests/tst_capability01.c
> new file mode 100644
> index 000000000..1a9cb0568
> --- /dev/null
> +++ b/lib/newlib_tests/tst_capability01.c
> @@ -0,0 +1,50 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (c) 2019 Richard Palethorpe<rpalethorpe@suse.com>
> + *
> + * The user or file requires CAP_NET_RAW for this test to work.
> + * e.g use "$ setcap cap_net_raw=pei tst_capability"
> + */
> +
> +#include<unistd.h>
> +#include<sys/types.h>
> +
> +#include "tst_test.h"
> +#include "tst_capability.h"
> +#include "tst_safe_net.h"
> +
> +#include "lapi/socket.h"
> +
> +static void run(void)
> +{
> +	TEST(socket(AF_INET, SOCK_RAW, 1));
> +	if (TST_RET>  -1) {
> +		tst_res(TFAIL, "Created raw socket");
                         SAFE_CLOSE(TST_RET);

> +	} else if (TST_ERR != EPERM) {
> +		tst_res(TBROK | TTERRNO,
> +			"Failed to create socket for wrong reason");
> +	} else {
> +		tst_res(TPASS | TTERRNO, "Didn't create raw socket");
> +	}
> +}
> +



