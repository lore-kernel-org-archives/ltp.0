From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 7 Jun 2016 16:24:14 +0200
Subject: [LTP] [PATCH V4] syscalls/madvise02: reconstruct and convert to
	new API
In-Reply-To: <1465287565-32639-1-git-send-email-liwang@redhat.com>
References: <1465287565-32639-1-git-send-email-liwang@redhat.com>
Message-ID: <20160607142414.GA4397@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(tcases); i++) {
> +		struct tcase *tc = &tcases[i];
> +
> +		switch (tc->advice) {
> +		case MADV_NORMAL:
> +			if (tc->exp_errno == EINVAL)
> +				nonalign = file1 + 100;
> +			else
> +				/* Test for MADV_NORMAL ENOMEM */
> +				SAFE_MUNMAP(file2 + st.st_size - pagesize,
> +						pagesize);
> +			break;
> +
> +		case MADV_DONTNEED:
> +			#if !defined(UCLINUX)
> +			if (mlock(file1, st.st_size) < 0)
> +				tst_brk(TBROK | TERRNO, "mlock failed");
> +			tc->skip = 0;
> +			#endif /* if !defined(UCLINUX) */
> +			break;
> +
> +		case MADV_MERGEABLE:
> +		case MADV_UNMERGEABLE:
> +			if ((tst_kvercmp(2, 6, 32)) < 0)
> +				tc->skip = 1;
> +
> +			if (access(KSM_SYS_DIR, F_OK) == 0)
> +				/* kernel configured with CONFIG_KSM,
> +				 * skip EINVAL test for MADV_MERGEABLE. */
> +				tc->skip = 1;
> +			break;
> +
> +		case MADV_WILLNEED:
> +			/* Test for MADV_WILLNEED EBADF */
> +			ptr_addr = SAFE_MALLOC(st.st_size);
> +			/* Take temporary pointer for later use, freeing up the
> +			 * original one. */
> +			tmp_addr = ptr_addr;
> +			tmp_addr =
> +				(char *)(((unsigned long)tmp_addr + pagesize - 1)
> +						& ~(pagesize - 1));
> +
> +			/* In kernel commit 1998cc0, madvise(MADV_WILLNEED) to
> +			 * anon mem doesn't return -EBADF now, as now we support
> +			 * swap prefretch. */
> +			if ((tst_kvercmp(3, 9, 0)) > 0 &&
> +					tc->exp_errno == EBADF)
> +				tc->skip = 1;
> +			break;
> +		}

I've moved the setup-like parts from the filter function to setup, so
that the filter function only filters the testcases.

And also used the LTP_ALIGN() macro to align the tmp_addr and pushed,
thanks.


-- 
Cyril Hrubis
chrubis@suse.cz
