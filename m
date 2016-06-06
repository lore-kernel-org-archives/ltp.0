From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 6 Jun 2016 15:03:07 +0200
Subject: [LTP] [PATCH V3 3/3] syscalls/madvise02: reconstruct and
 convert to new API
In-Reply-To: <1464157779-6883-3-git-send-email-liwang@redhat.com>
References: <1464157779-6883-1-git-send-email-liwang@redhat.com>
 <1464157779-6883-2-git-send-email-liwang@redhat.com>
 <1464157779-6883-3-git-send-email-liwang@redhat.com>
Message-ID: <20160606130307.GB20756@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -#if defined(MADV_MERGEABLE)
> -static void test_mergeable_einval(void)
> -{
> -	char *file;
> -
> -	if (access(KSM_SYS_DIR, F_OK) >= 0) {
> -		tst_resm(TCONF, "kernel configured with CONFIG_KSM, "
> -				 "skip EINVAL test for MADV_MERGEABLE.");
> -		return;
> +	enable = 1;
> +	file = tmp_file;
> +
> +	switch (i) {
> +	case 0:
> +		/* Test for addr EINVAL */
> +		file = tmp_file + 100;
> +		break;
> +
> +	case 1:
> +		/* Test for advice EINVAL */
> +		break;
> +
> +	case 2:
> +		enable = 0;
> +		/* Test for lock EINVAL */
> +		#if !defined(UCLINUX)
> +		if (mlock(file, st.st_size) < 0)
> +			tst_brk(TBROK | TERRNO, "mlock failed");
> +		enable = 1;
> +		#endif /* if !defined(UCLINUX) */
> +		break;
> +
> +	case 3:
> +	case 4:
> +		/* Test for MADV_MERGEABLE EINVAL */
> +		if ((tst_kvercmp(2, 6, 32)) < 0)
> +			enable = 0;
> +
> +		if (access(KSM_SYS_DIR, F_OK) == 0)
> +			/* kernel configured with CONFIG_KSM,
> +			 * skip EINVAL test for MADV_MERGEABLE. */
> +			enable = 0;
> +		break;
> +
> +	case 5:
> +		/* Test for MADV_WILLNEED EBADF */
> +		ptr_addr = SAFE_MALLOC(st.st_size);
> +		/* Take temporary pointer for later use, freeing up the
> +		 * original one. */
> +		tmp_addr = ptr_addr;
> +		tmp_addr =
> +			(char *)(((unsigned long)tmp_addr + pagesize - 1) & ~(pagesize - 1));
> +		file = tmp_addr;
> +
> +		/* In kernel commit 1998cc0, madvise(MADV_WILLNEED) to
> +		 * anon mem doesn't return -EBADF now, as now we support
> +		 * swap prefretch. */
> +		if ((tst_kvercmp(3, 9, 0)) > 0)
> +			enable = 0;
> +		break;
> +
> +	case 6:
> +		/* Test for MADV_NORMAL ENOMEM */
> +		SAFE_MUNMAP(file + st.st_size - pagesize, pagesize);
> +		break;

If you need to do the testcase filter, you should:

1) Do the switch() over tc->advice
2) Call it once in the setup() and set tc->skipp flag rather
   than doing this on each iteration.

-- 
Cyril Hrubis
chrubis@suse.cz
