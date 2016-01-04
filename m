From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 4 Jan 2016 04:41:01 -0500 (EST)
Subject: [LTP] [PATCH] syscalls/readahead02: fix error check
In-Reply-To: <1450704070-7870-1-git-send-email-klamm@yandex-team.ru>
References: <20151211135323.GA31048@red-moon>
 <1450704070-7870-1-git-send-email-klamm@yandex-team.ru>
Message-ID: <755898004.3200686.1451900461457.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Roman Gushchin" <klamm@yandex-team.ru>
> To: "lorenzo pieralisi" <lorenzo.pieralisi@arm.com>
> Cc: "Roman Gushchin" <klamm@yandex-team.ru>, ltp@lists.linux.it
> Sent: Monday, 21 December, 2015 2:21:10 PM
> Subject: [LTP] [PATCH] syscalls/readahead02: fix error check
> 
> After commit 600e19afc5f8a6 ("mm: use only per-device readahead limit")
> readahead size is not limited anymore by 2 megabytes. Instead,
> the per-bdi limit is used.
> 
> Signed-off-by: Roman Gushchin <klamm@yandex-team.ru>
> ---
>  testcases/kernel/syscalls/readahead/readahead02.c | 34
>  +++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/readahead/readahead02.c
> b/testcases/kernel/syscalls/readahead/readahead02.c
> index fe0b8a0..b5a7789 100644
> --- a/testcases/kernel/syscalls/readahead/readahead02.c
> +++ b/testcases/kernel/syscalls/readahead/readahead02.c
> @@ -184,6 +184,30 @@ static void create_testfile(void)
>  	free(tmp);
>  }
>  

Hi,

approach looks OK to me, but as it is now, it will break on older kernels.

> +static long get_device_readahead(const char *fname)
> +{
> +	FILE *f;
> +	struct stat st;
> +	unsigned long ra_kb = 0;
> +	char buf[256];
> +
> +	if (stat(fname, &st) == -1)
> +		return -1;

kernels < 4.5 will still impose 2M limit. So if your bdi limit is something
larger (say 4M) the test is going to fail. How about we keep the 2M default
for kernels prior to 600e19afc5f8a6?

if ((tst_kvercmp(4, 5, 0)) < 0)
    return 2 * 1024 * 1024;


> +	snprintf(buf, sizeof(buf), "/sys/dev/block/%d:%d/queue/read_ahead_kb",
> +		 major(st.st_dev), minor(st.st_dev));
> +	f = fopen(buf, "r");
> +	if (!f)
> +		return -1;

This sysfs file may not exist on older kernels, test now fails with TBROK.

Regards,
Jan

> +
> +	if (fscanf(f, "%lu", &ra_kb) != 1) {
> +		fclose(f);
> +		return -1;
> +	}
> +
> +	fclose(f);
> +	return ra_kb * 1024;
> +}
> +
>  /* read_testfile - mmap testfile and read every page.
>   * This functions measures how many I/O and time it takes to fully
>   * read contents of test file.
> @@ -206,16 +230,20 @@ static void read_testfile(int do_readahead, const char
> *fname, size_t fsize,
>  	unsigned long time_start_usec, time_end_usec;
>  	off_t offset;
>  	struct timeval now;
> +	long readahead_size;
> +
> +	readahead_size = get_device_readahead(fname);
> +	if (readahead_size == -1)
> +		tst_brkm(TBROK, cleanup, "Failed to get readahead size");
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
> 2.5.0
> 
> 
> --
> Mailing list info: http://lists.linux.it/listinfo/ltp
> 
