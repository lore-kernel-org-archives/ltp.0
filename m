From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 17 May 2016 17:54:13 +0200
Subject: [LTP] [PATCH 2/6] syscalls/madvise02: Convert to new test API
In-Reply-To: <1463042993-398-2-git-send-email-liwang@redhat.com>
References: <1463042993-398-1-git-send-email-liwang@redhat.com>
 <1463042993-398-2-git-send-email-liwang@redhat.com>
Message-ID: <20160517155413.GB13705@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
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
> +		tst_res(TFAIL, "madvise succeeded unexpectedly");
>  	}
>  }
>  
> @@ -166,26 +125,26 @@ static void test_addr_einval(void)
>  {
>  	char *file;
>  
> -	file = SAFE_MMAP(cleanup, 0, st.st_size, PROT_READ,
> +	file = SAFE_MMAP(0, st.st_size, PROT_READ,
>  					 MAP_SHARED, fd, 0);
>  
>  	TEST(madvise(file + 100, st.st_size, MADV_NORMAL));
>  	check_and_print(EINVAL);
>  
> -	SAFE_MUNMAP(cleanup, file, st.st_size);
> +	SAFE_MUNMAP(file, st.st_size);
>  }

There is no readson to mmap the and unmap the file for each test, it
should be done once in the setup.

Also the testcases could be easily converted to a aray of structures
describing the test with one verify function taking a pointer to a
testcase describing structure.

>  static void test_advice_einval(void)
>  {
>  	char *file;
>  
> -	file = SAFE_MMAP(cleanup, 0, st.st_size, PROT_READ,
> +	file = SAFE_MMAP(0, st.st_size, PROT_READ,
>  					 MAP_SHARED, fd, 0);
>  
>  	TEST(madvise(file, st.st_size, 1212));
>  	check_and_print(EINVAL);
>  
> -	SAFE_MUNMAP(cleanup, file, st.st_size);
> +	SAFE_MUNMAP(file, st.st_size);
>  }
>  
>  #if !defined(UCLINUX)
> @@ -193,16 +152,16 @@ static void test_lock_einval(void)
>  {
>  	char *file;
>  
> -	file = SAFE_MMAP(cleanup, 0, st.st_size, PROT_READ,
> +	file = SAFE_MMAP(0, st.st_size, PROT_READ,
>  					 MAP_SHARED, fd, 0);
>  
>  	if (mlock(file, st.st_size) < 0)
> -		tst_brkm(TBROK | TERRNO, cleanup, "mlock failed");
> +		tst_brk(TBROK | TERRNO, "mlock failed");
>  
>  	TEST(madvise(file, st.st_size, MADV_DONTNEED));
>  	check_and_print(EINVAL);
>  
> -	SAFE_MUNMAP(cleanup, file, st.st_size);
> +	SAFE_MUNMAP(file, st.st_size);
>  }
>  #endif /* if !defined(UCLINUX) */
>  
> @@ -212,18 +171,18 @@ static void test_mergeable_einval(void)
>  	char *file;
>  
>  	if (access(KSM_SYS_DIR, F_OK) >= 0) {
> -		tst_resm(TCONF, "kernel configured with CONFIG_KSM, "
> +		tst_res(TCONF, "kernel configured with CONFIG_KSM, "
>  				 "skip EINVAL test for MADV_MERGEABLE.");
>  		return;
>  	}
>  
> -	file = SAFE_MMAP(cleanup, 0, st.st_size, PROT_READ,
> -					 MAP_SHARED, fd, 0);
> +	file = SAFE_MMAP(0, st.st_size, PROT_READ,
> +				 MAP_SHARED, fd, 0);
>  
>  	TEST(madvise(file, st.st_size, MADV_MERGEABLE));
>  	check_and_print(EINVAL);
>  
> -	SAFE_MUNMAP(cleanup, file, st.st_size);
> +	SAFE_MUNMAP(file, st.st_size);
>  }
>  #endif
>  
> @@ -233,18 +192,18 @@ static void test_unmergeable_einval(void)
>  	char *file;
>  
>  	if (access(KSM_SYS_DIR, F_OK) >= 0) {
> -		tst_resm(TCONF, "kernel configured with CONFIG_KSM, "
> +		tst_res(TCONF, "kernel configured with CONFIG_KSM, "
>  				 "skip EINVAL test for MADV_UNMERGEABLE.");
>  		return;
>  	}
>  
> -	file = SAFE_MMAP(cleanup, 0, st.st_size, PROT_READ,
> +	file = SAFE_MMAP(0, st.st_size, PROT_READ,
>  					 MAP_SHARED, fd, 0);
>  
>  	TEST(madvise(file, st.st_size, MADV_UNMERGEABLE));
>  	check_and_print(EINVAL);
>  
> -	SAFE_MUNMAP(cleanup, file, st.st_size);
> +	SAFE_MUNMAP(file, st.st_size);
>  }
>  #endif
>  
> @@ -254,10 +213,10 @@ static void test_enomem(void)
>  	char *high;
>  	unsigned long len;
>  
> -	low = SAFE_MMAP(cleanup, 0, st.st_size / 2, PROT_READ,
> +	low = SAFE_MMAP(0, st.st_size / 2, PROT_READ,
>  					MAP_SHARED, fd, 0);
>  
> -	high = SAFE_MMAP(cleanup, 0, st.st_size / 2, PROT_READ,
> +	high = SAFE_MMAP(0, st.st_size / 2, PROT_READ,
>  					 MAP_SHARED, fd, st.st_size / 2);
>  
>  	/* Swap if necessary to make low < high */
> @@ -270,12 +229,12 @@ static void test_enomem(void)
>  
>  	len = (high - low) + pagesize;
>  
> -	SAFE_MUNMAP(cleanup, high, st.st_size / 2);
> +	SAFE_MUNMAP(high, st.st_size / 2);

Well this whole part can be just done in two steps:

* mmap() the file as in the rest of the testcases
* unmap() last page of the mapping
* call madvise as in the rest of the testcases

>  	TEST(madvise(low, len, MADV_NORMAL));
>  	check_and_print(ENOMEM);
>  
> -	SAFE_MUNMAP(cleanup, low, st.st_size / 2);
> +	SAFE_MUNMAP(low, st.st_size / 2);

>  }
>  
>  static void test_ebadf(void)
> @@ -302,9 +261,29 @@ static void test_ebadf(void)
>  	 * prefretch.
>  	 */

The malloc() mess here could be changed to mmap() with MAP_ANOYMOUS.

>  	} else {
> -		tst_resm(TPASS, "madvise succeeded as expected, see "
> +		tst_res(TPASS, "madvise succeeded as expected, see "
>  				"kernel commit 1998cc0 for details.");
>  	}
>  
>  	free(ptr_memory_allocated);
>  }
> +
> +static void verify_madvise(unsigned int i)
> +{
> +	(*test_func[i])();
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd && close(fd) < 0)
> +		tst_res(TWARN | TERRNO, "close failed");
> +}
> +
> +static struct tst_test test = {
> +	.tid = "madvise02",
> +	.tcnt = ARRAY_SIZE(test_func),
> +	.test = verify_madvise,
> +	.needs_tmpdir = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +};
> -- 
> 1.8.3.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
