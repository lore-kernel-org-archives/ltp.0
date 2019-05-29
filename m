From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 29 May 2019 16:38:31 +0200
Subject: [LTP] [PATCH v3 ltp] Add 4 more cases for Intel PT.
In-Reply-To: <20190524020123.7623-1-ammy.yi@intel.com>
References: <20190524020123.7623-1-ammy.yi@intel.com>
Message-ID: <20190529143831.GA4610@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	if (flag == 1) {
> +		tst_res(TINFO, "memory will be r/w for full trace mode!");
> +		pro_flag = PROT_READ | PROT_WRITE;
> +	} else {
> +		tst_res(TINFO, "memory will be r only for snapshot mode!");
> +		pro_flag = PROT_READ;
> +	}
> +	buf_ev[0] = SAFE_MMAP(fde, INTEL_PT_MEMSIZE, PROT_READ | PROT_WRITE,
                               ^
			       This should be NULL, right?
>  							MAP_SHARED, fde, 0);
>  
>  	pc = (struct perf_event_mmap_page *)buf_ev[0];
>  	pc->aux_offset = INTEL_PT_MEMSIZE;
>  	pc->aux_size = bufsize;
> -	buf_ev[1] = SAFE_MMAP(NULL, bufsize, PROT_READ | PROT_WRITE,
> +	buf_ev[1] = SAFE_MMAP(NULL, bufsize, pro_flag,
>  					MAP_SHARED, fde, INTEL_PT_MEMSIZE);
>  	return buf_ev;
>  }
> @@ -89,7 +101,7 @@ static void del_map(uint64_t **buf_ev, long bufsize)
>  	free(buf_ev);
>  }
>  
> -static void intel_pt_full_trace_check(void)
> +static void intel_pt_trace_check(void)
>  {
>  	uint64_t aux_head = 0;
>  	struct perf_event_mmap_page *pmp;
> @@ -104,11 +116,11 @@ static void intel_pt_full_trace_check(void)
>  	pmp = (struct perf_event_mmap_page *)bufm[0];
>  	aux_head = *(volatile uint64_t *)&pmp->aux_head;
>  	if (aux_head == 0) {
> -		tst_res(TFAIL, "There is no trace!");
> +		tst_res(TFAIL, "There is no trace.");
>  		return;
>  	}
>  
> -	tst_res(TPASS, "perf trace full mode is passed!");
> +	tst_res(TPASS, "perf trace test is passed.");
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
> @@ -130,20 +143,36 @@ static void setup(void)
>  	attr.config	= BIT(intel_pt_pmu_value(INTEL_PT_FORMAT_TSC)) |
>  				BIT(intel_pt_pmu_value(INTEL_PT_FORMAT_NRT));
>  	attr.size	= sizeof(struct perf_event_attr);
> -	attr.exclude_kernel		= 0;
> -	attr.exclude_user		= 0;
>  	attr.mmap			= 1;
> +	if (str_branch_flag) {
> +		tst_res(TINFO, "Intel PT will disable branch trace.");
> +		attr.config |= 1;
> +	}
> +
> +	attr.exclude_kernel	= 0;
> +	attr.exclude_user	= 0;
> +
> +	if (str_exclude_info && strcmp(str_exclude_info, "user")) {
                                ^
				Should be !strcmp() as the function
				returns 0 on match
> +		tst_res(TINFO, "Intel PT will exclude kernel trace.");
> +		attr.exclude_kernel = 1;
> +	}
> +	if (str_exclude_info && strcmp(str_exclude_info, "kernel")) {
                                ^
				Here as well.
> +		tst_res(TINFO, "Intel PT will exclude user trace.");
> +		attr.exclude_user = 1;
> +	}
>  
>  	/* only get trace for own pid */
>  	fde = tst_syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0);
>  	if (fde < 0) {
> -		tst_res(TINFO, "Open Intel PT event failed!");
> -		tst_res(TFAIL, "perf trace full mode is failed!");
> +		tst_res(TINFO, "Open Intel PT event failed.");
> +		tst_res(TFAIL, "perf trace full mode is failed.");
>  		return;
>  	}
>  	bufm = NULL;
> -	bufm = create_map(fde, buhsz);
> +	if (str_mode)
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
