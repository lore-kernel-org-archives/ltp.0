From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 30 Aug 2018 08:41:22 -0400 (EDT)
Subject: [LTP] [PATCH v2 3/4] syscalls/mlock201: Add new testcase
In-Reply-To: <1535699602-28185-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <864746561.43466655.1535545169373.JavaMail.zimbra@redhat.com>
 <1535699602-28185-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <176741503.43672692.1535632882334.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> 1) Add SAFE_MINCORE() macro
> 2) Check the basic functionality of mlock2(2).
> 
> Note:
> 1) We use tst_syscall() to check if mlock2() is supported.
> 2) since kernel v2.6.9, the limits and permissions of mlock2()
>    changed, so we just check mlock2() since the version.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Looks good to me, some nits below (no need to re-post)

> +#include <errno.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <stdlib.h>
> +#include <sys/mman.h>
> +#include <linux/mman.h>
> +
> +#include "tst_test.h"
> +#include "lapi/syscalls.h"
> +#include "lapi/mlock2.h"
> +
> +#define PAGES	8
> +#define HPAGES	(PAGES / 2)
> +
> +static size_t pgsz;
> +static unsigned char *vec;
> +
> +static struct tcase {
> +	size_t pop_pgs;
> +	size_t lock_pgs;
> +	size_t offset;
> +	size_t exp_vmlcks;
> +	size_t exp_pgs;

Some of these could be more descriptive or have comments.

<snip>

> +static void setup(void)
> +{
> +	pgsz = getpagesize();
> +	vec = SAFE_MALLOC((PAGES * pgsz + pgsz - 1) / pgsz);

This value is known at compile time, so malloc isn't needed.

> +}
> +
> +static void cleanup(void)
> +{
> +	if (vec)
> +		free(vec);
> +}
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = verify_mlock2,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.min_kver = "2.6.9",

Ok, "syscall can be backported to older kernels" is valid argument.

Thanks,
Jan
