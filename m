From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 1 Oct 2018 17:15:40 +0200
Subject: [LTP] [PATCH v3 ltp] Add Intel PT full trace mode basic test
	case
In-Reply-To: <20180913015431.6411-1-ammy.yi@intel.com>
References: <20180913015431.6411-1-ammy.yi@intel.com>
Message-ID: <20181001151540.GF27555@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
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
> +int FDE = -1;
> +//map head and size
> +uint64_t **BUFM;
> +long BUFSZ;
> +
> +uint64_t **create_map(int fde, long bufsize)
> +{
> +	int PROTo;
> +	long pbufSz;
> +	uint64_t **bufEv;
> +	struct perf_event_mmap_page *pc;
> +
> +	bufEv = SAFE_MALLOC(2*sizeof(uint64_t *));
> +
> +	PROTo = PROT_READ | PROT_WRITE;
> +
> +	pbufSz = INTEL_PT_MEMSIZE;
> +//try to mmap for trace
> +	bufEv[0] = SAFE_MMAP(NULL, pbufSz, PROT_READ | PROT_WRITE,
> +							MAP_SHARED, fde, 0);
> +
> +	if (bufEv[0] != MAP_FAILED) {

I think I told you already that SAFE_MMAP() cannot fail. If mmap()
called in SAFE_MMAP() fails the test execution stops, that is the whole
point of having the SAFE_ variants.

So in this case there is no need to check againts MAP_FAILED, because
the bufEv[0] will never have value of MAP_FAILED.

Also bufEv is mixed case, which is frowned upon, so this should rather
be buf_ev.

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
> +void del_map(uint64_t **bufEv, long bufsize)
> +{
> +	long pbufSz;
> +
> +	pbufSz = INTEL_PT_MEMSIZE;
> +
> +	munmap(bufEv[0], pbufSz);
                          ^
			  Why not just INTEL_PT_MEMSIZE?

There is no point in storing the constant in the variable first...

> +	munmap(bufEv[1], bufsize);
> +
> +	free(bufEv);
> +}
> +
> +static void intel_pt_full_trace_check(void)
> +{
> +	uint64_t aux_head = 0;
> +	struct perf_event_mmap_page *pmp;
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

We do have SAFE_IOCTL() so this should be just:

	SAFE_IOCTL(FDE, PERF_EVENT_IOC_RESET);
	SAFE_IOCTL(FDE, PERF_EVENT_IOC_ENABLE);
	SAFE_IOCTL(FDE, PERF_EVENT_IOC_DISABLE);


> +	// check if there is some trace generated
> +	pmp = (struct perf_event_mmap_page *)BUFM[0];
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
> +	BUFSZ = 2 * PAGESIZE;
> +
> +	//set attr for Intel PT trace
> +	attr.type	= intel_pt_pmu_value(INTEL_PT_PMU_TYPE);
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
> +	FDE = tst_syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0);
         ^
	 Can we just call this fde? The uppercase names are kind of
	 reserved for macros in C.

> +	if (FDE < 0) {
> +		tst_res(TINFO, "Open Intel PT event failed!");
> +		tst_res(TFAIL, "perf trace full mode is failed!");

		Why do we print two messages here? Shouldn't
		tst_res(TFAIL, "Open Intel PT event failed!") suffice?

		Also we should probably print errno in this case as
		well, so it should be tst_res(TFAIL | TERRNO, ...);

> +		return;
> +	}
> +	BUFM = NULL;
> +	/* allocate memory for trace */
> +	BUFM =  create_map(FDE, BUFSZ);
        ^
	Here as well, it would be better to be called bufm.

> +	if (!BUFM || (BUFM)[0] == MAP_FAILED || (BUFM)[1] == MAP_FAILED) {
> +		tst_res(TINFO, "create_map failed!");
> +		tst_res(TFAIL, "perf trace full mode is failed!");
> +		return;

And as above, since we use SAFE_MMAP() this will never happen.

> +	}

> +}
> +
> +void cleanup(void)
> +{
> +	if (FDE != -1)
> +		close(FDE);
> +
> +	if (!BUFM || (BUFM)[0] == MAP_FAILED || (BUFM)[1] == MAP_FAILED)

Here as well the MAP_FAILED check will never be true.

Also the cleanup has to be able to cope with partial initialization as
well, for example the second SAFE_MMAP() can exit the test in a state where we allocated bufm and mmapped bufm[0].

So we should probably do in setup:


	bufm = SAFE_MALLOC(...);
	bufm[0] = NULL;
	bufm[1] = NULL:

	bufm[0] = SAFE_MMAP(...);
	bufm[1] = SAFE_MMAP(...);


And in the cleanup (or in the del_map called from cleanup):

	if (bufm) {
		if (bufm[0])
			munmap(bufm[0], ...);

		if (bufm[1])
			munmap(bufm[1], ...);
	}

	free(bufm);

> +		del_map(BUFM, BUFSZ);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = intel_pt_full_trace_check,
> +	.min_kver = "4.1",
> +	.setup = setup,
> +	.cleanup = cleanup,
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
