From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Oct 2018 14:38:26 +0200
Subject: [LTP] [PATCH v4 ltp] Add Intel PT full trace mode basic test
	case
In-Reply-To: <20181009051149.6055-1-ammy.yi@intel.com>
References: <20181009051149.6055-1-ammy.yi@intel.com>
Message-ID: <20181016123825.GA6980@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#
> +# Copyright (C) 2018 Intel Corporation
> +#
> +# This program is free software: you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation, either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program. If not, see <http://www.gnu.org/licenses/>.
> +#

We started to switch to SPDX license identifiers instead of the full
licence lately, so this license text can be replaced with just:

# SPDX-License-Identifier: GPL-2.0-or-later

> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> \ No newline at end of file

Can you please include newlines at the end of the files?

It produces very ugly patches if something is added at the end of such
files.

> diff --git a/testcases/kernel/tracing/pt_test/pt_test.c b/testcases/kernel/tracing/pt_test/pt_test.c
> new file mode 100644
> index 000000000..bbd641b06
> --- /dev/null
> +++ b/testcases/kernel/tracing/pt_test/pt_test.c
> @@ -0,0 +1,170 @@
> +/*
> + * Copyright (C) 2018 Intel Corporation
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + *
> + * author: Ammy Yi (ammy.yi@intel.com)
> + * date:   8/20/2018
> + */

Here as well, we can go just for SPDX license.

> +/*
> + * This test will check if Intel PT(Intel Processer Trace) full trace mode is
> + * working. It is only applied on X86 platforms.
> + */
> +
> +#include <linux/perf_event.h>
> +#include <sched.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include "tst_test.h"
> +#include "lapi/syscalls.h"
> +
> +#define PAGESIZE 4096
> +#define INTEL_PT_MEMSIZE (17*PAGESIZE)
> +
> +#define BIT(nr)                 (1UL << (nr))
> +
> +#define INTEL_PT_PMU_TYPE "/sys/devices/intel_pt/type"
> +#define INTEL_PT_FORMAT_TSC "/sys/devices/intel_pt/format/tsc"
> +#define INTEL_PT_FORMAT_NRT "/sys/devices/intel_pt/format/noretcomp"
> +
> +//Intel PT event handle
> +int fde = -1;
> +//map head and size
> +uint64_t **bufm;
> +long buhsz;
> +
> +uint64_t **create_map(int fde, long bufsize)
> +{
> +	int PROTo;
> +	uint64_t **buf_ev;
> +	struct perf_event_mmap_page *pc;
> +
> +	buf_ev = SAFE_MALLOC(2*sizeof(uint64_t *));
> +
> +	PROTo = PROT_READ | PROT_WRITE;

This is pretty much useless, why don't we pass the value directly to he
mmap()? We do that with the first mmap anyways.

> +	buf_ev[0] = NULL;
> +	buf_ev[1] = NULL;
> +//try to mmap for trace

Can we get rid of this useless comment please?

> +	buf_ev[0] = SAFE_MMAP(NULL, INTEL_PT_MEMSIZE, PROT_READ | PROT_WRITE,
> +							MAP_SHARED, fde, 0);
> +
> +	pc = (struct perf_event_mmap_page *)buf_ev[0];
> +	pc->aux_offset = INTEL_PT_MEMSIZE;
> +	pc->aux_size = bufsize;
> +	buf_ev[1] = SAFE_MMAP(NULL, bufsize, PROTo,
> +					MAP_SHARED, fde, INTEL_PT_MEMSIZE);
> +	return buf_ev;
> +}
> +
> +
> +int intel_pt_pmu_value(char *dir)
> +{
> +	char *value;
> +	int val = 0;
> +	char delims[] = ":";
> +
> +	SAFE_FILE_SCANF(dir, "%m[^\n]", &value);
> +	if (strstr(value, delims) == NULL) {
> +		val = atoi(value);
> +	} else {
> +		strsep(&value, delims);
> +		val = atoi(value);
> +	}
> +	return val;
> +}
> +
> +void del_map(uint64_t **buf_ev, long bufsize)
> +{
> +	long pbuhsz;
> +
> +	pbuhsz = INTEL_PT_MEMSIZE;

I think I asked you about this previously, but what is the point of
assigning the value to a local variable? I does not make any sense.

> +	if (buf_ev) {
> +		if (buf_ev[0])
> +			munmap(buf_ev[0], pbuhsz);
> +		if (buf_ev[1])
> +			munmap(buf_ev[1], bufsize);
> +	}
> +
> +	free(buf_ev);
> +}
> +
> +static void intel_pt_full_trace_check(void)
> +{
> +	uint64_t aux_head = 0;
> +	struct perf_event_mmap_page *pmp;
> +	/* enable tracing */
> +	SAFE_IOCTL(fde, PERF_EVENT_IOC_RESET);
> +	SAFE_IOCTL(fde, PERF_EVENT_IOC_ENABLE);
> +
> +	/* stop tracing */
> +	SAFE_IOCTL(fde, PERF_EVENT_IOC_DISABLE);
> +
> +	// check if there is some trace generated
> +	pmp = (struct perf_event_mmap_page *)bufm[0];
> +	aux_head = *(volatile uint64_t *)&pmp->aux_head;
> +	if (aux_head == 0) {
> +		tst_res(TFAIL, "There is no trace, so failed!");
> +		return;
> +	}
> +
> +	tst_res(TPASS, "perf trace full mode is passed!");
> +}
> +
> +void setup(void)
> +{
> +	struct perf_event_attr attr = {};
> +
> +	buhsz = 2 * PAGESIZE;
> +
> +	//set attr for Intel PT trace
> +	attr.type	= intel_pt_pmu_value(INTEL_PT_PMU_TYPE);

I've tried to run the test on my machine (Core i3 with 4.14 kernel) and
the test failed because the INTEL_PT_PMU_TYPE file is not present.

So we should check for the file presence first and exit the test with
TCONF if it's not there.

Also do I need a newer CPU or do need to enable certain kernel config
option in order to run this test? Ideally something like this should be
noted in the top level comment.

> +	attr.read_format = PERF_FORMAT_ID | PERF_FORMAT_TOTAL_TIME_RUNNING |
> +				PERF_FORMAT_TOTAL_TIME_ENABLED;
> +	attr.disabled	= 1;
> +	attr.config	= BIT(intel_pt_pmu_value(INTEL_PT_FORMAT_TSC)) |
> +				BIT(intel_pt_pmu_value(INTEL_PT_FORMAT_NRT));
> +	attr.size	= sizeof(struct perf_event_attr);
> +	attr.exclude_kernel		= 0;
> +	attr.exclude_user		= 0;
> +	attr.mmap			= 1;
> +
> +	//only get trace for own pid
> +	fde = tst_syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0);
> +	if (fde < 0) {
> +		tst_res(TINFO, "Open Intel PT event failed!");
> +		tst_res(TFAIL, "perf trace full mode is failed!");
> +		return;
> +	}
> +	bufm = NULL;
> +	/* allocate memory for trace */
            ^
	    Again useless comment.

> +	bufm =  create_map(fde, buhsz);
               ^
	       Two spaces instead of one.

Have you checked the patch with checkpatch.pl (that is shipped with
linux kernel sources)?

> +
> +}
> +
> +void cleanup(void)

That's very minor, but it's better to decleare the
setup/cleanup/del_map/create_map functions static.

> +{
> +	if (fde != -1)
> +		close(fde);
> +
> +	del_map(bufm, buhsz);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = intel_pt_full_trace_check,
> +	.min_kver = "4.1",
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +};

Other than the comments above, it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
