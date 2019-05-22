From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 22 May 2019 15:09:00 +0200
Subject: [LTP] [PATCH v2 ltp] Add 4 more cases for Intel PT.
In-Reply-To: <20190428054815.3266-1-ammy.yi@intel.com>
References: <20190428054815.3266-1-ammy.yi@intel.com>
Message-ID: <20190522130900.GC7912@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -static uint64_t **create_map(int fde, long bufsize)
> +static uint64_t **create_map(int rw_flag, long bufsize, int flag)

Huh, I far as I can tell I asked for the flag to be renamed rw_flag to
make it more clear what the flag is actually doing.

Renaming the fde to rw_flag makes this code cryptic instead.

>  {
>  	uint64_t **buf_ev;
> +	int pro_flag;
>  	struct perf_event_mmap_page *pc;
>  
>  	buf_ev = SAFE_MALLOC(2*sizeof(uint64_t *));
>  	buf_ev[0] = NULL;
>  	buf_ev[1] = NULL;
> -	buf_ev[0] = SAFE_MMAP(NULL, INTEL_PT_MEMSIZE, PROT_READ | PROT_WRITE,
> -							MAP_SHARED, fde, 0);
> +	if (flag == 1) {
> +		tst_res(TINFO, "memory will be r/w for full trace mode!");
> +		pro_flag = PROT_READ | PROT_WRITE;
> +	} else {
> +		tst_res(TINFO, "memory will be r only for snapshot mode!");
> +		pro_flag = PROT_READ;
> +	}

Again, why do we need exclamation marks (!) in the info messages?

> +	buf_ev[0] = SAFE_MMAP(rw_flag, INTEL_PT_MEMSIZE, PROT_READ | PROT_WRITE,
> +							MAP_SHARED, rw_flag, 0);
>  
>  	pc = (struct perf_event_mmap_page *)buf_ev[0];
>  	pc->aux_offset = INTEL_PT_MEMSIZE;
>  	pc->aux_size = bufsize;
> -	buf_ev[1] = SAFE_MMAP(NULL, bufsize, PROT_READ | PROT_WRITE,
> -					MAP_SHARED, fde, INTEL_PT_MEMSIZE);
> +	buf_ev[1] = SAFE_MMAP(NULL, bufsize, pro_flag,
> +					MAP_SHARED, rw_flag, INTEL_PT_MEMSIZE);
>  	return buf_ev;
>  }
>  
> @@ -89,7 +101,7 @@ static void del_map(uint64_t **buf_ev, long bufsize)
>  	free(buf_ev);
>  }
>  
> -static void intel_pt_full_trace_check(void)
> +static void intel_pt_trace_check(void)
>  {
>  	uint64_t aux_head = 0;
>  	struct perf_event_mmap_page *pmp;
> @@ -108,7 +120,7 @@ static void intel_pt_full_trace_check(void)
>  		return;
>  	}
>  
> -	tst_res(TPASS, "perf trace full mode is passed!");
> +	tst_res(TPASS, "perf trace test is passed!");
>  }
>  
>  static void setup(void)
> @@ -116,6 +128,7 @@ static void setup(void)
>  	struct perf_event_attr attr = {};
>  
>  	buhsz = 2 * PAGESIZE;
> +
>  	if (access(INTEL_PT_PATH, F_OK)) {
>  		tst_brk(TCONF,
>  			"Requires Intel Core 5th+ generation (Broadwell and newer)"
> @@ -130,9 +143,23 @@ static void setup(void)
>  	attr.config	= BIT(intel_pt_pmu_value(INTEL_PT_FORMAT_TSC)) |
>  				BIT(intel_pt_pmu_value(INTEL_PT_FORMAT_NRT));
>  	attr.size	= sizeof(struct perf_event_attr);
> -	attr.exclude_kernel		= 0;
> -	attr.exclude_user		= 0;
>  	attr.mmap			= 1;
> +	if (str_branch_flag != NULL && !str_branch_flag) {

This should be just if (str_branch_flag). And actually the condition
(a != NULL && !a) is never true.

> +		tst_res(TINFO, "Intel PT will disable branch trace!");
> +		attr.config |= 1;
> +	}
> +
> +	attr.exclude_kernel	= 0;
> +	attr.exclude_user	= 0;
> +
> +	if (str_exclude_info != NULL && strcmp(str_exclude_info, "user")) {


This could be just:

	if (str_exclude_info && strcmp(str_exclude_info, "user"))

> +		tst_res(TINFO, "Intel PT will exclude kernel trace!");
> +		attr.exclude_kernel = 1;
> +	}
> +	if (str_exclude_info != NULL && strcmp(str_exclude_info, "kernel")) {
> +		tst_res(TINFO, "Intel PT will exclude user trace!");
> +		attr.exclude_user = 1;
> +	}

Here as well.

>  	/* only get trace for own pid */
>  	fde = tst_syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0);
> @@ -142,8 +169,10 @@ static void setup(void)
>  		return;
>  	}
>  	bufm = NULL;
> -	bufm = create_map(fde, buhsz);
> +	if (str_mode != NULL && !str_mode)

Here as well just if (str_mode)

> +		mode = 0;
>  
> +	bufm = create_map(fde, buhsz, mode);
>  }
>  
>  static void cleanup(void)
> @@ -154,8 +183,17 @@ static void cleanup(void)
>  	del_map(bufm, buhsz);
>  }
>  
> +static struct tst_option options[] = {
> +	{"m", &str_mode, "-m different mode, default is full mode"},
> +	{"e:", &str_exclude_info, "-e exclude info, user or kernel"},
> +	{"b", &str_branch_flag, "-b if disable branch trace"},
> +	{NULL, NULL, NULL}
> +};
> +
> +
>  static struct tst_test test = {
> -	.test_all = intel_pt_full_trace_check,
> +	.test_all = intel_pt_trace_check,
> +	.options = options,
>  	.min_kver = "4.1",
>  	.setup = setup,
>  	.cleanup = cleanup,
> -- 
> 2.14.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
