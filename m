From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 Mar 2016 15:52:17 +0100
Subject: [LTP] [PATCH v2] syscalls/readahead02: use bdi max readahead
 limit
In-Reply-To: <a9bd5a6d7f70f692acbb3232175a00f8de471af6.1458052562.git.jstancek@redhat.com>
References: <a9bd5a6d7f70f692acbb3232175a00f8de471af6.1458052562.git.jstancek@redhat.com>
Message-ID: <20160315145217.GB27377@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static long get_device_readahead(const char *fname)
> +{
> +	FILE *f;
> +	struct stat st;
> +	unsigned long ra_kb = 0;
> +	char buf[256];
> +
> +	if (stat(fname, &st) == -1)
> +		return -1;
> +	snprintf(buf, sizeof(buf), "/sys/dev/block/%d:%d/queue/read_ahead_kb",
> +		 major(st.st_dev), minor(st.st_dev));
> +	f = fopen(buf, "r");
> +	if (!f)
> +		return -1;
> +
> +	if (fscanf(f, "%lu", &ra_kb) != 1) {
> +		fclose(f);
> +		return -1;
> +	}
> +
> +	fclose(f);

Any reason why we don't do SAFE_FILE_SCANF() instead of fopen(),
fscanf(), fclose() here? We call tst_brkm(TBROK, ...) when this call
returs -1 in the read_testfile() anyway...

> +	return ra_kb * 1024;
> +}
> +
>  /* read_testfile - mmap testfile and read every page.
>   * This functions measures how many I/O and time it takes to fully
>   * read contents of test file.
> @@ -206,16 +230,26 @@ static void read_testfile(int do_readahead, const char *fname, size_t fsize,
>  	unsigned long time_start_usec, time_end_usec;
>  	off_t offset;
>  	struct timeval now;
> +	long readahead_size;
> +
> +	if ((tst_kvercmp(4, 4, 0)) >= 0) {
> +		readahead_size = get_device_readahead(fname);
> +		if (readahead_size == -1)
> +			tst_brkm(TBROK, cleanup, "get_device_readahead");
> +	} else {
> +		/* default to 2M, which should work on kernels prior to 4.4 */
> +		readahead_size = 2 * 1024 * 1024;
> +	}
> +	tst_resm(TINFO, "max readahead size is: %ld", readahead_size);
>  
>  	fd = open(fname, O_RDONLY);
>  	if (fd < 0)
>  		tst_brkm(TBROK | TERRNO, cleanup, "Failed to open %s", fname);
>  
>  	if (do_readahead) {
> -		/* read ahead in chunks, 2MB is maximum since 3.15-rc1 */
> -		for (i = 0; i < fsize; i += 2*1024*1024) {
> +		for (i = 0; i < fsize; i += readahead_size) {
>  			TEST(ltp_syscall(__NR_readahead, fd,
> -				(off64_t) i, 2*1024*1024));
> +				(off64_t) i, readahead_size));
>  			if (TEST_RETURN != 0)
>  				break;
>  		}
> -- 
> 1.8.3.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
