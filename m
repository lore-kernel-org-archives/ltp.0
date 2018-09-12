From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 12 Sep 2018 13:40:18 +0200
Subject: [LTP] [PATCH v2 ltp] Add Intel PT full trace mode basic test
	case
In-Reply-To: <20180912064458.27749-1-ammy.yi@intel.com>
References: <20180912064458.27749-1-ammy.yi@intel.com>
Message-ID: <20180912114017.GB29460@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/tracing/pt_test/Makefile b/testcases/kernel/tracing/pt_test/Makefile
> new file mode 100644
> index 000000000..43964273d
> --- /dev/null
> +++ b/testcases/kernel/tracing/pt_test/Makefile
> @@ -0,0 +1,4 @@

You should probably put a SPDX-License-Identifier tag here as well.

> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/tracing/pt_test/pt_test.c b/testcases/kernel/tracing/pt_test/pt_test.c
> new file mode 100644
> index 000000000..e7a402cdb
> --- /dev/null
> +++ b/testcases/kernel/tracing/pt_test/pt_test.c
> @@ -0,0 +1,194 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
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

Once you add the SPDX License indentifier here the full license text
should be removed.

> + * author: Ammy Yi (ammy.yi@intel.com)
> + * date:   8/20/2018
> + */
> +
> +/*
> + * This test will check if Intel PT(Intel Processer Trace) full trace mode is
> + * working. It is only applied on X86 platforms.
> + */
> +
> +#include "tst_test.h"
> +#include "lapi/syscalls.h"
> +#include <linux/perf_event.h>
> +#include <sched.h>
> +#include <stdlib.h>
> +#include <stdio.h>

The include order here should be reversed i.e. the system headers should
be first.

> +#define PAGESIZE 4096
> +#define INTEL_PT_MEMSIZE (17*PAGESIZE)
> +
> +#define BIT(nr)                 (1UL << (nr))
> +
> +#define INTEL_PT_PMU_TYPE ("/sys/devices/intel_pt/type")
> +#define INTEL_PT_FORMAT_TSC ("/sys/devices/intel_pt/format/tsc")
> +#define INTEL_PT_FORMAT_NRT ("/sys/devices/intel_pt/format/noretcomp")

Huh, why the braces around the strings? It's not like there could even
be an expression between them, it's just a constant string.

> +//Intel PT event handle
> +int FDE = -1;
> +//map head and size
> +uint64_t **BUFM;
> +long BUFSZ;
> +
> +uint64_t **creaMap(int fde, long bufsize)
> +{

See:
https://www.kernel.org/doc/html/v4.10/process/coding-style.html#naming

"Mixex case is frowned upon."

Generally functions and variables should use lower case and separate
words by underscores.

> +	int PROTo;
> +	long pbufSz;
> +	uint64_t **bufEv;
> +	struct perf_event_mmap_page *pc;
> +
> +	bufEv = SAFE_MALLOC(2*sizeof(uint64_t *));
> +	if (!bufEv)
> +		return NULL;


The SAFE operations cannot fail, they abort the test if something goes
wrong.

See:
https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines
https://github.com/linux-test-project/ltp/wiki/C-Test-Case-Tutorial

> +	PROTo = PROT_READ | PROT_WRITE;
> +
> +	pbufSz = INTEL_PT_MEMSIZE;
> +//try to mmap for trace
> +	bufEv[0] = SAFE_MMAP(NULL, pbufSz, PROT_READ | PROT_WRITE,
> +							MAP_SHARED, fde, 0);
> +
> +	if (bufEv[0] != MAP_FAILED) {
> +		pc = (struct perf_event_mmap_page *)bufEv[0];
> +		pc->aux_offset = pbufSz;
> +		pc->aux_size = bufsize;
> +		bufEv[1] = SAFE_MMAP(NULL, bufsize, PROTo, MAP_SHARED,
> +								fde, pbufSz);
> +	}
> +	return bufEv;
> +}
> +
> +
> +int Intel_PT_pmu_value(char *dir)
> +{
> +	char *value;
> +	int temp = 0, val = 0;
> +	char delims[] = ":";
> +	FILE *f = fopen(dir, "r");
> +// try to get sysfs value
> +	if (f) {
> +		temp = fscanf(f, "%m[^\n]", &value);
> +		if (temp != 1) {
> +			tst_res(TINFO, "Read value fail!");
> +		} else {
> +			if (strstr(value, delims) == NULL) {
> +				val = atoi(value);
> +			} else {
> +				strsep(&value, delims);
> +				val = atoi(value);
> +			}
> +		}
> +		fclose(f);
> +	}
> +
> +	return val;
> +}
> +
> +void delMap(uint64_t **bufEv, long bufsize)
> +{
> +	long pbufSz;
> +
> +	pbufSz = INTEL_PT_MEMSIZE;
> +
> +	munmap(bufEv[0], pbufSz);
> +	munmap(bufEv[1], bufsize);
> +
> +	free(bufEv);
> +}
> +
> +static void INTEL_PT_FULL_TRACE_CHECK(void)
> +{
> +	struct perf_event_attr attr = {};
> +	struct perf_event_mmap_page *pmp;
> +	uint64_t aux_head = 0;
> +
> +	BUFSZ = 2 * PAGESIZE;
> +
> +	//set attr for Intel PT trace
> +	attr.type	= Intel_PT_pmu_value(INTEL_PT_PMU_TYPE);
> +	attr.read_format = PERF_FORMAT_ID | PERF_FORMAT_TOTAL_TIME_RUNNING |
> +				PERF_FORMAT_TOTAL_TIME_ENABLED;
> +	attr.disabled	= 1;
> +	attr.config	= BIT(Intel_PT_pmu_value(INTEL_PT_FORMAT_TSC)) |
> +				BIT(Intel_PT_pmu_value(INTEL_PT_FORMAT_NRT));
> +	attr.size	= sizeof(struct perf_event_attr);
> +	attr.exclude_kernel		= 0;
> +	attr.exclude_user		= 0;
> +	attr.mmap			= 1;
> +
> +	//only get trace for own pid
> +	FDE = tst_syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0);
> +	if (FDE < 0) {
> +		tst_res(TINFO, "Open Intel PT event failed!");
> +		tst_res(TFAIL, "perf trace full mode is failed!");
> +		return;
> +	}
> +	BUFM = NULL;
> +	/* allocate memory for trace */
> +	BUFM =  creaMap(FDE, BUFSZ);
> +
> +	if (!BUFM || (BUFM)[0] == MAP_FAILED || (BUFM)[1] == MAP_FAILED) {
> +		tst_res(TINFO, "creaMap failed!");
> +		tst_res(TFAIL, "perf trace full mode is failed!");
> +		return;
> +	}

The code up to this point should be in setup() so that the test will
work when we specify the -i (iterations) parameter on the command line.

> +	/* enable tracing */
> +	if (ioctl(FDE, PERF_EVENT_IOC_RESET) != 0) {
> +		tst_res(TFAIL, "ioctl with PERF_EVENT_IOC_RESET is failed!");
> +		return;
> +	}
> +	if (ioctl(FDE, PERF_EVENT_IOC_ENABLE) != 0) {
> +		tst_res(TFAIL, "ioctl with PERF_EVENT_IOC_ENABLE is failed!");
> +		return;
> +	}
> +
> +	/* stop tracing */
> +	if (ioctl(FDE, PERF_EVENT_IOC_DISABLE) != 0) {
> +		tst_res(TFAIL, "ioctl with PERF_EVENT_IOC_DISABLE is failed!");
> +		return;
> +	}
> +
> +	// check if there is some trace generated
> +	pmp = (struct perf_event_mmap_page *)BUFM[0];
> +	aux_head = *(volatile uint64_t *)&pmp->aux_head;
> +	if (aux_head == 0) {
> +		tst_res(TFAIL, "There is no trace, so failed!");
> +		return;
> +	}
> +
> +	tst_res(TPASS, "perf trace full mode is passed!");
> +
> +}
> +
> +void Cleanup(void)
> +{
> +	if (FDE != -1)
> +		close(FDE);
> +
> +	if (!BUFM || (BUFM)[0] == MAP_FAILED || (BUFM)[1] == MAP_FAILED)
> +		delMap(BUFM, BUFSZ);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = INTEL_PT_FULL_TRACE_CHECK,
> +	.min_kver = "4.1",
> +	.cleanup = Cleanup,
> +	.needs_root = 1,
> +};
> -- 
> 2.14.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
