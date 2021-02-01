From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 1 Feb 2021 14:46:49 +0100
Subject: [LTP] [RFC PATCH] lib: enhancement of tst_pollute_memory
In-Reply-To: <20210201133106.26970-1-liwang@redhat.com>
References: <20210201133106.26970-1-liwang@redhat.com>
Message-ID: <YBgGSRNMXU58+cTw@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  lib/tst_memutils.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
> index dd09db490..af2178a9c 100644
> --- a/lib/tst_memutils.c
> +++ b/lib/tst_memutils.c
> @@ -15,6 +15,7 @@
>  
>  void tst_pollute_memory(size_t maxsize, int fillchar)
>  {
> +	unsigned int ori_overcommit_mem, ori_overcommit_rat, new_overcommit_rat;
>  	size_t i, map_count = 0, safety = 0, blocksize = BLOCKSIZE;
>  	void **map_blocks;
>  	struct sysinfo info;
> @@ -40,6 +41,25 @@ void tst_pollute_memory(size_t maxsize, int fillchar)
>  	map_count = maxsize / blocksize;
>  	map_blocks = SAFE_MALLOC(map_count * sizeof(void *));
>  
> +	/* Only allow to run on systems with less than or equal to 128GB of memory */
> +	if (info.totalram  >= (137438953472 / info.mem_unit)) {
> +		tst_brk(TCONF, "Skip test - totalram (%lukB) is larger than 128GB",
> +				info.totalram * info.mem_unit / 1024);
> +	}

This is completely wrong, attempt to dirty memory only increases chances
of reproducing the kernel bug but it's not strictly required.

It's okay to limit the memory or completely skip the rest of this
function but we must not exit the test. The test is valid even if we do
not dirty any memory, it's just less likely to fail on buggy kernel.

> +	SAFE_FILE_SCANF("/proc/sys/vm/overcommit_memory", "%u", &ori_overcommit_mem);
> +	SAFE_FILE_SCANF("/proc/sys/vm/overcommit_ratio",  "%u", &ori_overcommit_rat);
> +
> +	/* Disable the memory overcommit to prevent test invoking OOM killer */
> +	if (SAFE_READ_MEMINFO("CommitLimit:") >= SAFE_READ_MEMINFO("MemAvailable:")) {
> +		SAFE_FILE_PRINTF("/proc/sys/vm/overcommit_memory", "2");
> +	} else {
> +		new_overcommit_rat = (maxsize / info.mem_unit * 100) / info.totalram;
> +		SAFE_FILE_PRINTF("/proc/sys/vm/overcommit_ratio", "%u", new_overcommit_rat);
> +
> +		SAFE_FILE_PRINTF("/proc/sys/vm/overcommit_memory", "2");
> +	}

And I do not like this that much either, I would be happier with
attempt to dirty only half of the available memory instead of depending
on specific kernel behavior like this.

>  	/*
>  	 * Keep allocating until the first failure. The address space may be
>  	 * too fragmented or just smaller than maxsize.
> @@ -60,4 +80,7 @@ void tst_pollute_memory(size_t maxsize, int fillchar)
>  		SAFE_MUNMAP(map_blocks[i], blocksize);
>  
>  	free(map_blocks);
> +
> +	SAFE_FILE_PRINTF("/proc/sys/vm/overcommit_memory", "%u", ori_overcommit_mem);
> +	SAFE_FILE_PRINTF("/proc/sys/vm/overcommit_ratio", "%u",  ori_overcommit_rat);
>  }
> -- 
> 2.21.3
> 

-- 
Cyril Hrubis
chrubis@suse.cz
