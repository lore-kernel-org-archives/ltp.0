From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 23 May 2016 16:14:18 +0200
Subject: [LTP] [PATCH v2 3/3] syscalls/madvise02: reconstruct and
 convert to new API
In-Reply-To: <1463979557-21421-1-git-send-email-liwang@redhat.com>
References: <1463979557-21421-1-git-send-email-liwang@redhat.com>
Message-ID: <20160523141418.GB25488@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#define SAFE_FREE(p) { if (p) { free(p); (p) = NULL; } }

Just call plain free() in the cleanup it can handle NULL pointers just
fine.

>  static int fd;
>  static struct stat st;
>  static int pagesize;
> +static char *file;
> +static char *ptr_memory_allocated;
> +static char *tmp_memory_allocated;
> +
> +static struct {
> +	int advice;
> +	char *name;
> +	char *addr;
> +	int expect;
> +	int   flag;
> +} advice_opt[] = {
> +	{MADV_NORMAL,      "MADV_NORMAL",      NULL, EINVAL, 1}, /* (1) */
> +	{MADV_NORMAL,      "MADV_NORMAL",      NULL, EINVAL, 1}, /* (2) */
> +	{MADV_DONTNEED,    "MADV_DONTNEED",    NULL, EINVAL, 0}, /* (3) */
> +	{MADV_MERGEABLE,   "MADV_MERGEABLE",   NULL, EINVAL, 1}, /* (4) since Linux 2.6.32 */
> +	{MADV_UNMERGEABLE, "MADV_UNMERGEABLE", NULL, EINVAL, 1}, /* (5) since Linux 2.6.32 */
> +	{MADV_WILLNEED,    "MADV_WILLNEED,",   NULL,  EBADF, 1}, /* (6) */
> +	{MADV_NORMAL,      "MADV_NORMAL",      NULL, ENOMEM, 1}  /* (7) */
> +};
>  
> -int main(int argc, char *argv[])
> +static void advice_prepare(void)
>  {
> -	int lc;
>  	int i;
>  
> -	tst_parse_opts(argc, argv, NULL, NULL);
> +	/* (1) Test for addr EINVAL */
> +	advice_opt[0].addr = file + 100;
>  
> -	setup();
> +	/* (2) Test for advice EINVAL */
> +	advice_opt[1].advice = 1212;
> +	advice_opt[1].addr = file;
>  
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> +	/* (3) Test for lock EINVAL */
> +#if !defined(UCLINUX)
> +	if (mlock(file, st.st_size) < 0)
> +		tst_brk(TBROK | TERRNO, "mlock failed");
> +	advice_opt[2].flag = 1;
> +	advice_opt[2].addr = file;
> +#endif /* if !defined(UCLINUX) */
>  
> -		for (i = 0; i < TST_TOTAL; i++)
> -			(*test_func[i])();
> +	/* (4,5) Test for MADV_MERGEABLE EINVAL */
> +	if ((tst_kvercmp(2, 6, 32)) < 0)
> +		for (i = 3; i < 5; i++) {
> +			advice_opt[i].flag = 0;
> +			advice_opt[i].addr = file;
> +		}
> +
> +	if (access(KSM_SYS_DIR, F_OK) == 0) {
> +		/* kernel configured with CONFIG_KSM,
> +		 * skip EINVAL test for MADV_MERGEABLE. */
> +		for (i = 3; i < 5; i++) {
> +			advice_opt[i].flag = 0;
> +			advice_opt[i].addr = file;
> +		}
>  	}

This whole part is a mess. You should not change the content of the
structure in this way. If there are values that has to be changed on the
runtime the structure members should be initialized with a pointers to a
variable and that variable should be set up in the setup().


I.e.

static char *mmaped_file;

static struct tcase {
	...
	char **addr;
	...
} tcases[] = {
	{..., .addr = &mmaped_file, ...}
};

static void setup(void)
{
	mmaped_file = SAFE_MMAP(...);
}

> -	cleanup();
> -	tst_exit();
> +	/* (6) Test for MADV_WILLNEED EBADF */
> +	ptr_memory_allocated = SAFE_MALLOC(st.st_size);
> +	/* Take temporary pointer for later use, freeing up the
> +	 * original one. */
> +	tmp_memory_allocated = ptr_memory_allocated;
> +	tmp_memory_allocated =
> +		(char *)(((unsigned long)tmp_memory_allocated
> +					+ pagesize - 1) & ~(pagesize - 1));
> +	advice_opt[5].addr = tmp_memory_allocated;
> +
> +	if ((tst_kvercmp(3, 9, 0)) > 0)
> +		/* In kernel commit 1998cc0, madvise(MADV_WILLNEED) to
> +		 * anon mem doesn't return -EBADF now, as now we support
> +		 * swap prefretch. */
> +		advice_opt[5].flag = 0;
> +
> +	/* (7) Test for MADV_NORMAL ENOMEM */
> +	SAFE_MUNMAP(file + st.st_size - pagesize, pagesize);
> +	advice_opt[6].addr = file;
>  }
>  
>  static void setup(void)
>  {
>  	int i;
>  
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	tst_tmpdir();
> -
> -	fd = SAFE_OPEN(cleanup, TEST_FILE, O_RDWR | O_CREAT, 0664);
> +	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT, 0664);
>  
>  	pagesize = getpagesize();
>  
>  	/* Writing 16 pages of random data into this file */
>  	for (i = 0; i < (pagesize / 2); i++)
> -		SAFE_WRITE(cleanup, 1, fd, STR, sizeof(STR) - 1);
> +		SAFE_WRITE(1, fd, STR, sizeof(STR) - 1);
>  
> -	SAFE_FSTAT(cleanup, fd, &st);
> -}
> +	SAFE_FSTAT(fd, &st);
>  
> -static void cleanup(void)
> -{
> -	if (fd && close(fd) < 0)
> -		tst_resm(TWARN | TERRNO, "close failed");
> +	file = SAFE_MMAP(0, st.st_size, PROT_READ, MAP_SHARED, fd, 0);
>  
> -	tst_rmdir();
> +	advice_prepare();
>  }
>  
>  static void check_and_print(int expected_errno)
>  {
>  	if (TEST_RETURN == -1) {
>  		if (TEST_ERRNO == expected_errno)
> -			tst_resm(TPASS | TTERRNO, "failed as expected");
> +			tst_res(TPASS | TTERRNO, "failed as expected");
>  		else
> -			tst_resm(TFAIL | TTERRNO,
> +			tst_res(TFAIL | TTERRNO,
>  				 "failed unexpectedly; expected - %d : %s",
>  				 expected_errno, strerror(expected_errno));
>  	} else {
> -		tst_resm(TFAIL, "madvise succeeded unexpectedly");
> -	}
> -}

Here as well, it does not make sense to have separate check_and_print()
function anymore.

> -static void test_addr_einval(void)
> -{
> -	char *file;
> -
> -	file = SAFE_MMAP(cleanup, 0, st.st_size, PROT_READ,
> -					 MAP_SHARED, fd, 0);
> -
> -	TEST(madvise(file + 100, st.st_size, MADV_NORMAL));
> -	check_and_print(EINVAL);
> -
> -	SAFE_MUNMAP(cleanup, file, st.st_size);
> -}
> -
> -static void test_advice_einval(void)
> -{
> -	char *file;
> -
> -	file = SAFE_MMAP(cleanup, 0, st.st_size, PROT_READ,
> -					 MAP_SHARED, fd, 0);
> -
> -	TEST(madvise(file, st.st_size, 1212));
> -	check_and_print(EINVAL);
> -
> -	SAFE_MUNMAP(cleanup, file, st.st_size);
> -}
> -
> -#if !defined(UCLINUX)
> -static void test_lock_einval(void)
> -{
> -	char *file;
> -
> -	file = SAFE_MMAP(cleanup, 0, st.st_size, PROT_READ,
> -					 MAP_SHARED, fd, 0);
> -
> -	if (mlock(file, st.st_size) < 0)
> -		tst_brkm(TBROK | TERRNO, cleanup, "mlock failed");
> -
> -	TEST(madvise(file, st.st_size, MADV_DONTNEED));
> -	check_and_print(EINVAL);
> -
> -	SAFE_MUNMAP(cleanup, file, st.st_size);
> -}
> -#endif /* if !defined(UCLINUX) */
> -
> -#if defined(MADV_MERGEABLE)
> -static void test_mergeable_einval(void)
> -{
> -	char *file;
> -
> -	if (access(KSM_SYS_DIR, F_OK) >= 0) {
> -		tst_resm(TCONF, "kernel configured with CONFIG_KSM, "
> -				 "skip EINVAL test for MADV_MERGEABLE.");
> -		return;
> +		tst_res(TFAIL, "madvise succeeded unexpectedly");
>  	}
> -
> -	file = SAFE_MMAP(cleanup, 0, st.st_size, PROT_READ,
> -					 MAP_SHARED, fd, 0);
> -
> -	TEST(madvise(file, st.st_size, MADV_MERGEABLE));
> -	check_and_print(EINVAL);
> -
> -	SAFE_MUNMAP(cleanup, file, st.st_size);
>  }
> -#endif
>  
> -#if defined(MADV_UNMERGEABLE)
> -static void test_unmergeable_einval(void)
> +static void advice_test(unsigned int nr)
>  {
> -	char *file;
> -
> -	if (access(KSM_SYS_DIR, F_OK) >= 0) {
> -		tst_resm(TCONF, "kernel configured with CONFIG_KSM, "
> -				 "skip EINVAL test for MADV_UNMERGEABLE.");
> -		return;
> -	}
> -
> -	file = SAFE_MMAP(cleanup, 0, st.st_size, PROT_READ,
> -					 MAP_SHARED, fd, 0);
> -
> -	TEST(madvise(file, st.st_size, MADV_UNMERGEABLE));
> -	check_and_print(EINVAL);
> -
> -	SAFE_MUNMAP(cleanup, file, st.st_size);
> +	if (advice_opt[nr].flag == 1) {
> +		TEST(madvise(advice_opt[nr].addr, st.st_size, advice_opt[nr].advice));
> +		check_and_print(advice_opt[nr].expect);
> +	} else
> +		tst_res(TCONF, "%s is skipped", advice_opt[nr].name);
>  }
> -#endif
>  
> -static void test_enomem(void)
> +static void cleanup(void)
>  {
> -	char *low;
> -	char *high;
> -	unsigned long len;
> -
> -	low = SAFE_MMAP(cleanup, 0, st.st_size / 2, PROT_READ,
> -					MAP_SHARED, fd, 0);
> -
> -	high = SAFE_MMAP(cleanup, 0, st.st_size / 2, PROT_READ,
> -					 MAP_SHARED, fd, st.st_size / 2);
> -
> -	/* Swap if necessary to make low < high */
> -	if (low > high) {
> -		char *tmp;
> -		tmp = high;
> -		high = low;
> -		low = tmp;
> -	}
> -
> -	len = (high - low) + pagesize;
> -
> -	SAFE_MUNMAP(cleanup, high, st.st_size / 2);
> -
> -	TEST(madvise(low, len, MADV_NORMAL));
> -	check_and_print(ENOMEM);
> +	if (fd && close(fd) < 0)
> +		tst_res(TWARN | TERRNO, "close failed");

It's better to check if fd > 0 since otherwise you may attempt to call
close with fd = -1 if open() has failed.

> -	SAFE_MUNMAP(cleanup, low, st.st_size / 2);
> +	SAFE_FREE(ptr_memory_allocated);
> +	SAFE_MUNMAP(file, st.st_size);
>  }

Here as well no SAFE_MACROS() in cleanup and make sure to unmap only
memory that has been mmaped.

> -static void test_ebadf(void)
> -{
> -	char *ptr_memory_allocated = NULL;
> -	char *tmp_memory_allocated = NULL;
> -
> -	/* Create one memory segment using malloc */
> -	ptr_memory_allocated = malloc(5 * pagesize);
> -	/*
> -	 * Take temporary pointer for later use, freeing up the
> -	 * original one.
> -	 */
> -	tmp_memory_allocated = ptr_memory_allocated;
> -	tmp_memory_allocated =
> -		(char *)(((unsigned long)tmp_memory_allocated +
> -			pagesize - 1) & ~(pagesize - 1));
> -
> -	TEST(madvise(tmp_memory_allocated, 5 * pagesize, MADV_WILLNEED));
> -	if (tst_kvercmp(3, 9, 0) < 0) {
> -		check_and_print(EBADF);
> -	/* in kernel commit 1998cc0, madvise(MADV_WILLNEED) to anon
> -	 * mem doesn't return -EBADF now, as now we support swap
> -	 * prefretch.
> -	 */
> -	} else {
> -		tst_resm(TPASS, "madvise succeeded as expected, see "
> -				"kernel commit 1998cc0 for details.");
> -	}
> -
> -	free(ptr_memory_allocated);
> -}
> +static struct tst_test test = {
> +	.tid = "madvise02",
> +	.tcnt = ARRAY_SIZE(advice_opt),
> +	.test = advice_test,
> +	.needs_tmpdir = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +};
> -- 
> 1.8.3.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz
