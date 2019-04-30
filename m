From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 30 Apr 2019 15:04:03 +0200
Subject: [LTP] [PATCH v4] hugetlb: limit hugepages according to
	MemAvailable
In-Reply-To: <20190430031859.28473-1-liwang@redhat.com>
References: <20190430031859.28473-1-liwang@redhat.com>
Message-ID: <20190430130403.GC30997@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +void limit_hugepages(long *hpages)
> +{
> +	long mem_avail, max_hpages;
> +
> +	if (FILE_LINES_SCANF("/proc/meminfo",
> +			"MemAvailable: %ld", &mem_avail)) {
> +		/*
> +		 * Dropping caches and using "MemFree:" on kernel
> +		 * that doesn't have "MemAvailable:" in Meminfo
> +		 */

I've added one TINFO message here.

> +		SAFE_FILE_PRINTF("/proc/sys/vm/drop_caches", "3");
> +		mem_avail = SAFE_READ_MEMINFO("MemFree:");
> +	}
> +
> +	max_hpages = mem_avail / SAFE_READ_MEMINFO("Hugepagesize:");
> +
> +	if (*hpages > max_hpages) {
> +		tst_res(TINFO, "The hugepages beyond system available, here "
> +				"reset to 80%% of the max page count %ld",
> +				max_hpages);

Reworded this message a bit, to make it clearer.


And pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
