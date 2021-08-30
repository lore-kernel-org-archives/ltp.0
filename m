From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 30 Aug 2021 21:26:35 +0200
Subject: [LTP] [PATCH] kernel/irq: Add irqbalance01
In-Reply-To: <20210824101042.11772-1-rpalethorpe@suse.com>
References: <20210824101042.11772-1-rpalethorpe@suse.com>
Message-ID: <YS0w6y6wxn6CjLur@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richie,

LGTM, only few nits found bellow (easily fixed before merge)

...
> +++ b/testcases/kernel/irq/.gitignore
> @@ -0,0 +1 @@
> +irqbalance01
/irqbalance01

> diff --git a/testcases/kernel/irq/Makefile b/testcases/kernel/irq/Makefile
> new file mode 100644
> index 000000000..085e06fac
> --- /dev/null
> +++ b/testcases/kernel/irq/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +top_srcdir		?= ../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +INSTALL_TARGETS		:= *.sh
This should be removed (probably copy paste error
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/irq/irqbalance01.c b/testcases/kernel/irq/irqbalance01.c
> new file mode 100644
> index 000000000..0a476839c
> --- /dev/null
> +++ b/testcases/kernel/irq/irqbalance01.c
> @@ -0,0 +1,288 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* Copyright (c) 2021 SUSE LLC <rpalethorpe@suse.com> */
> +/*\
> + * [Description]
> + *
> + * Check that something (e.g. irqbalance daemon) is performing IRQ
> + * load balancing.
> + *
> + * On most systems userland needs to set /proc/irq/$IRQ/smp_affinity
> + * to prevent many IRQs being delivered to the same CPU.
> + *
> + * Note some drivers and IRQ controllers will distribute IRQs
> + * evenly. Some systems will have housekeeping CPUs configured. Some
> + * IRQs can not be masked etc. So this test is not appropriate for all
> + * scenarios.
> + *
> + * Furthermore, exactly how IRQs should be distributed is a
> + * performance and/or security issue. This is only a generic smoke
> + * test. It will hopefully detect misconfigured systems and total
> + * balancing failures which are often silent errors.
> + *
> + * Heuristic: Evidence of Change
Add blank new line here to get better docparse formatting:

> + * 1. Find IRQs with a non-zero count
> + * 2. Check if they are now disallowed
LGTM. It'd be interesting to hear opinion of IRQ subsystem maintainer Thomas Gleixner.

> + *
> + * There are two sources of information we need to parse:
Also here.

> + * 1. /proc/interrupts
> + * 2. /proc/irq/$IRQ/smp_affinity
> + *
> + * We get the active IRQs and CPUs from /proc/interrupts. It also
> + * contains the per-CPU IRQ counts and info we do not care about.
> + *
> + * We get the IRQ masks from each active IRQ's smp_affinity file. This
> + * is a bitmask written out in hexidecimal format. It shows which CPUs
                                  ^ hexadecimal
> + * an IRQ may be recieved by.
                    ^ received
> + */
> +
> +#include <stdlib.h>
> +
> +#include "tst_test.h"
> +#include "tst_safe_stdio.h"
> +#include "tst_safe_file_at.h"
> +
> +enum affinity {
> +	ALLOW,
> +	DENY,
> +};
> +
> +static unsigned int *irq_stats;
> +static enum affinity *irq_affinity;
> +
> +static unsigned int nr_cpus;
> +static unsigned int nr_irqs;
> +static unsigned int *irq_ids;
> +
> +static void collect_irq_info(void)
> +{
> +	char *buf = NULL, *c, *first_row;
> +	char path[PATH_MAX];
> +	size_t size = 1024;
> +	size_t ret, row, col;
> +	long acc;
> +	unsigned int cpu_total, mask_pos;
> +	int fd = SAFE_OPEN("/proc/interrupts", O_RDONLY);
> +
> +	nr_cpus = 0;
> +	nr_irqs = 0;
> +
> +	do {
> +		size *= 2;
> +		buf = SAFE_REALLOC(buf, size);
> +		SAFE_LSEEK(fd, SEEK_SET, 0);
		SAFE_LSEEK(fd, 0, SEEK_SET);
(it works only because SEEK_SET is also 0)

> +		ret = SAFE_READ(0, fd, buf, size - 1);
> +	} while (ret >= size - 1);
...

The rest LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
