From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 31 Aug 2021 10:39:22 +0100
Subject: [LTP] [PATCH] kernel/irq: Add irqbalance01
In-Reply-To: <YS0w6y6wxn6CjLur@pevik>
References: <20210824101042.11772-1-rpalethorpe@suse.com>
 <YS0w6y6wxn6CjLur@pevik>
Message-ID: <878s0ikl6d.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Petr,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Richie,
>
> LGTM, only few nits found bellow (easily fixed before merge)

Thanks, but I also changed the printf to tst_printf which should be
added in the bpf_prog05 patch set. So I can post V2 after that is
merged.

>
> ...
>> +++ b/testcases/kernel/irq/.gitignore
>> @@ -0,0 +1 @@
>> +irqbalance01
> /irqbalance01
>
>> diff --git a/testcases/kernel/irq/Makefile b/testcases/kernel/irq/Makefile
>> new file mode 100644
>> index 000000000..085e06fac
>> --- /dev/null
>> +++ b/testcases/kernel/irq/Makefile
>> @@ -0,0 +1,9 @@
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +top_srcdir		?= ../../..
>> +
>> +include $(top_srcdir)/include/mk/testcases.mk
>> +
>> +INSTALL_TARGETS		:= *.sh
> This should be removed (probably copy paste error
>> +
>> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
>> diff --git a/testcases/kernel/irq/irqbalance01.c b/testcases/kernel/irq/irqbalance01.c
>> new file mode 100644
>> index 000000000..0a476839c
>> --- /dev/null
>> +++ b/testcases/kernel/irq/irqbalance01.c
>> @@ -0,0 +1,288 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/* Copyright (c) 2021 SUSE LLC <rpalethorpe@suse.com> */
>> +/*\
>> + * [Description]
>> + *
>> + * Check that something (e.g. irqbalance daemon) is performing IRQ
>> + * load balancing.
>> + *
>> + * On most systems userland needs to set /proc/irq/$IRQ/smp_affinity
>> + * to prevent many IRQs being delivered to the same CPU.
>> + *
>> + * Note some drivers and IRQ controllers will distribute IRQs
>> + * evenly. Some systems will have housekeeping CPUs configured. Some
>> + * IRQs can not be masked etc. So this test is not appropriate for all
>> + * scenarios.
>> + *
>> + * Furthermore, exactly how IRQs should be distributed is a
>> + * performance and/or security issue. This is only a generic smoke
>> + * test. It will hopefully detect misconfigured systems and total
>> + * balancing failures which are often silent errors.
>> + *
>> + * Heuristic: Evidence of Change
> Add blank new line here to get better docparse formatting:
>
>> + * 1. Find IRQs with a non-zero count
>> + * 2. Check if they are now disallowed
> LGTM. It'd be interesting to hear opinion of IRQ subsystem maintainer
> Thomas Gleixner.

I guess I can copy them in on V2.

-- 
Thank you,
Richard.
