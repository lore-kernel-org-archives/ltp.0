From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 26 Jul 2019 14:12:55 +0200
Subject: [LTP] [PATCH v2] move_pages12: handle errno EBUSY for
 madvise(..., MADV_SOFT_OFFLINE)
In-Reply-To: <20190725033713.8551-1-liwang@redhat.com>
References: <20190725033713.8551-1-liwang@redhat.com>
Message-ID: <20190726121255.GA28028@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  static void do_test(unsigned int n)
>  {
> -	int i;
> +	int i, ret, retrys;
> +	void *ptr;
>  	pid_t cpid = -1;
>  	int status;
>  	unsigned int twenty_percent = (tst_timeout_remaining() / 5);
> @@ -135,19 +136,37 @@ static void do_test(unsigned int n)
>  	if (cpid == 0)
>  		do_child(tcases[n].tpages);
>  
> -	for (i = 0; i < LOOPS; i++) {
> -		void *ptr;
> +	for (i = 0; i < LOOPS; retrys = 0, i++) {
> +retry:
> +		ptr = mmap(NULL, tcases[n].tpages * hpsz,
> +				PROT_READ | PROT_WRITE,
> +				MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
> +		if (ptr == MAP_FAILED) {
> +			if (errno == ENOMEM) {
> +				if (retrys < LOOPS) {
> +					retrys++;
> +					usleep(1000);
> +					goto retry;
> +				}
> +
> +				if (i > 0) {
> +					tst_res(TINFO, "Test run %d times", i);
> +					goto out;
> +				}
> +			}
> +
> +			tst_brk(TBROK | TERRNO, "Cannot allocate hugepage");
> +		}

Why so complicated?

What about just doing usleep() and continue in case of the failure?


	for (i = 0; i < LOOPS; i++) {
		ptr = mmap(...);
		if (ptr == MAP_FAILED) {
			if (errno == ENOMEM) {
				usleep(1000);
				continue;
			}

			tst_brk(...);
		}

		...
	}


> -		ptr = SAFE_MMAP(NULL, tcases[n].tpages * hpsz,
> -			PROT_READ | PROT_WRITE,
> -			MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
>  		if (ptr != addr)
>  			tst_brk(TBROK, "Failed to mmap at desired addr");
>  
>  		memset(addr, 0, tcases[n].tpages * hpsz);
>  
>  		if (tcases[n].offline) {
> -			if (do_soft_offline(tcases[n].tpages) == EINVAL) {
> +			ret = do_soft_offline(tcases[n].tpages);
> +
> +			if (ret == EINVAL) {
>  				SAFE_KILL(cpid, SIGKILL);
>  				SAFE_WAITPID(cpid, &status, 0);
>  				SAFE_MUNMAP(addr, tcases[n].tpages * hpsz);
> @@ -163,6 +182,7 @@ static void do_test(unsigned int n)
>  			break;
>  	}
>  
> +out:
>  	SAFE_KILL(cpid, SIGKILL);
>  	SAFE_WAITPID(cpid, &status, 0);
>  	if (!WIFEXITED(status))
> -- 
> 2.20.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz
