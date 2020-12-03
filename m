From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 3 Dec 2020 16:30:30 +0100
Subject: [LTP] [PATCH v3] overcommit_memory: Fix unstable subtest
In-Reply-To: <20201127071419.20370-1-lkml@jv-coder.de>
References: <20201127071419.20370-1-lkml@jv-coder.de>
Message-ID: <20201203153030.GE5809@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static long get_total_batch_size_bytes(void)
> +{
> +	struct sysinfo info;
> +	long ncpus = tst_ncpus_conf();
> +	long pagesize = getpagesize();
> +	SAFE_SYSINFO(&info);
> +
> +	/* see linux source mm/mm_init.c mm_compute_batch() (This is in pages) */
> +	long batch_size = MAX(
> +			ncpus * 2,
> +			MAX(
> +				32,
> +				MIN(
> +					INT32_MAX,
> +					(long)(info.totalram / pagesize) / ncpus / 256
> +				)
> +			)
> +		);
> +
> +	/* there are ncpu separate counters, that can all grow up to
> +	 * batch_size. So the maximum error for __vm_enough_memory is
> +	 * batch_size * ncpus. */
> +	return batch_size * ncpus * pagesize;
> +}

This version looks better. However two (minor) comments for this
function still apply.

-- 
Cyril Hrubis
chrubis@suse.cz
