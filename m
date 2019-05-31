From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 31 May 2019 15:47:02 +0200
Subject: [LTP] [PATCH v3 ltp] Add 4 more cases for Intel PT.
In-Reply-To: <6A26F11783B7464A9CE09DB41C14533C5EDE1B8B@SHSMSX101.ccr.corp.intel.com>
References: <20190524020123.7623-1-ammy.yi@intel.com>
 <20190529143831.GA4610@rei.lan>
 <6A26F11783B7464A9CE09DB41C14533C5EDE1B8B@SHSMSX101.ccr.corp.intel.com>
Message-ID: <20190531134702.GC12608@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +	if (flag == 1) {
> > +		tst_res(TINFO, "memory will be r/w for full trace mode!");
> > +		pro_flag = PROT_READ | PROT_WRITE;
> > +	} else {
> > +		tst_res(TINFO, "memory will be r only for snapshot mode!");
> > +		pro_flag = PROT_READ;
> > +	}
> > +	buf_ev[0] = SAFE_MMAP(fde, INTEL_PT_MEMSIZE, PROT_READ | PROT_WRITE,
>                                ^
> 			       This should be NULL, right?
> [Ammy] Do you mean tis will get NULL? No, SAFE_MMAP should be successfully here.

Not at all. You are passing file descriptor as addr parameter to mmap()
which is wrong and the mmap() call only passes because the address
parameters is ignored unless we pass MAP_FIXED.

> > +	if (str_branch_flag) {
> > +		tst_res(TINFO, "Intel PT will disable branch trace.");
> > +		attr.config |= 1;
> > +	}
> > +
> > +	attr.exclude_kernel	= 0;
> > +	attr.exclude_user	= 0;
> > +
> > +	if (str_exclude_info && strcmp(str_exclude_info, "user")) {
>                                 ^
> 				Should be !strcmp() as the function
> 				returns 0 on match
> [Ammy] This is a little tricky here, if = user, means exclude user, then attr.exclude_user = 1. Here is right. If not match with user, it means not exclude user, it need exclude kernel trace, then attr.exclude_kernel = 1;
> From following execution log, we can see case name is " pt_ex_user " for exclude user test, then " Intel PT will exclude user trace " in log, they are matched.

Well as it is this will also work if we pass garbage to the -e
parameter it will set both exclude_kernel and exclude_user paramters.

Why isn't this simply:

	if (str_exclude) {
		if (!strcmp(str_exclude, "user")) {
			tst_res(TINFO, "Excluding user trace");
			attr.exclude_user = 1;
		} else if (!strcmp(str_exclude, "kernel")) {
			tst_res(TINFO, "Excluding kernel trace");
			attr.exclude_kernel = 1;
		} else {
			tst_brk(TBROK, "Invalid -e '%s'", str_exclude);
		}
	}

> > +		tst_res(TINFO, "Intel PT will exclude kernel trace.");
> > +		attr.exclude_kernel = 1;
> > +	}
> > +	if (str_exclude_info && strcmp(str_exclude_info, "kernel")) {
>                                 ^
> 				Here as well.
> [Ammy] Same as above.
> > +		tst_res(TINFO, "Intel PT will exclude user trace.");
> > +		attr.exclude_user = 1;
> > +	}
> >  
> >  	/* only get trace for own pid */
> >  	fde = tst_syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0);
> >  	if (fde < 0) {
> > -		tst_res(TINFO, "Open Intel PT event failed!");
> > -		tst_res(TFAIL, "perf trace full mode is failed!");
> > +		tst_res(TINFO, "Open Intel PT event failed.");
> > +		tst_res(TFAIL, "perf trace full mode is failed.");
> >  		return;
> >  	}
> >  	bufm = NULL;
> > -	bufm = create_map(fde, buhsz);
> > +	if (str_mode)
> > +		mode = 0;
> >  
> > +	bufm = create_map(fde, buhsz, mode);
> >  }
> >  
> >  static void cleanup(void)
> > @@ -154,8 +183,17 @@ static void cleanup(void)
> >  	del_map(bufm, buhsz);
> >  }
> >  
> > +static struct tst_option options[] = {
> > +	{"m", &str_mode, "-m different mode, default is full mode"},
> > +	{"e:", &str_exclude_info, "-e exclude info, user or kernel"},
> > +	{"b", &str_branch_flag, "-b if disable branch trace"},
> > +	{NULL, NULL, NULL}
> > +};
> > +
> > +
> >  static struct tst_test test = {
> > -	.test_all = intel_pt_full_trace_check,
> > +	.test_all = intel_pt_trace_check,
> > +	.options = options,
> >  	.min_kver = "4.1",
> >  	.setup = setup,
> >  	.cleanup = cleanup,
> > -- 
> > 2.14.1
> > 
> > 
> > -- 
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz
