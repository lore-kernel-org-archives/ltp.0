From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 12 Oct 2015 20:29:24 +0200
Subject: [LTP] [PATCH v2] mem/hugetlb: shift an empty region to use in
 hugemmap02.c
In-Reply-To: <1444647235-3041-1-git-send-email-liwang@redhat.com>
References: <1444647235-3041-1-git-send-email-liwang@redhat.com>
Message-ID: <20151012182924.GB24472@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Generall idea looks good, a few comments below.

> +/* MMAP */
> +int range_is_mapped(unsigned long low, unsigned long high)
>  #endif
> diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
> index 118b6c0..e0e1bdf 100644
> --- a/testcases/kernel/mem/lib/mem.c
> +++ b/testcases/kernel/mem/lib/mem.c
> @@ -1113,3 +1113,46 @@ void update_shm_size(size_t * shm_size)
>  		*shm_size = shmmax;
>  	}
>  }
> +
> +int range_is_mapped(unsigned long low, unsigned long high)
> +{
> +	FILE *f;
> +	int MAPS_BUF_SZ = 4096;
> +	char line[MAPS_BUF_SZ];
> +	char *tmp;
> +
> +	f = fopen("/proc/self/maps", "r");
> +	if (!f) {
> +		printf("Failed to open /proc/self/maps.\n");
                ^
		should rather be tst_resm(TWARN, );
> +		return -1;
> +	}
> +
> +	while (1) {
> +		unsigned long start, end;
> +		int ret;
> +
> +		tmp = fgets(line, MAPS_BUF_SZ, f);
> +		if (!tmp)
> +			break;
> +
> +		ret = sscanf(line, "%lx-%lx", &start, &end);
> +		if (ret != 2) {
> +			printf("Couldn't parse /proc/self/maps line: %s\n",
> +					line);
                        ^
			here as well
> +			fclose(f);
> +			return -1;
> +		}

Why don't you just use fscanf()? It doesn't make sense to read the line
into the buffer and then sscanf() the values.

> +		if ((start >= low) && (start < high)) {
> +			fclose(f);
> +			return 1;
> +		}
> +		if ((end >= low) && (end < high)) {
> +			fclose(f);
> +			return 1;
> +		}
> +	}
> +
> +	fclose(f);
> +	return 0;
> +}

-- 
Cyril Hrubis
chrubis@suse.cz
