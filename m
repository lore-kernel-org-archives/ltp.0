From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Jul 2016 14:45:22 +0200
Subject: [LTP] [PATCH] syscalls/fallocate04: add
 'FALLOC_FL_INSERT_RANGE' test-case
In-Reply-To: <1466612145-13233-1-git-send-email-alexey.kodanev@oracle.com>
References: <1466612145-13233-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20160726124522.GD11679@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  	fill_tst_buf(tmp_buf);
>  
>  	memcpy(exp_buf, tmp_buf, block_size);
> -	memcpy(exp_buf + block_size, tmp_buf + size, block_size);
> +	memcpy(exp_buf + block_size, tmp_buf + 2 * block_size,
> +	       buf_size - block_size * 2);

Looks OK to me.

>  	exp_buf[block_size - 1] = exp_buf[block_size] = '\0';
>  	check_file_data(exp_buf, size);
> @@ -274,6 +275,50 @@ static void test04(void)
>  	tst_resm(TPASS, "test-case succeeded");
>  }
>  
> +static void test05(void)
> +{
> +	tst_resm(TINFO, "inserting space with FALLOC_FL_INSERT_RANGE");
> +
> +	size_t alloc_size0 = get_allocsize();
> +
> +	tst_resm(TINFO, "read current allocated file size '%zu'", alloc_size0);
> +
> +	if (fallocate(fd, FALLOC_FL_INSERT_RANGE, block_size,
> +	    block_size) == -1) {
> +		if (errno == EOPNOTSUPP) {
> +			tst_brkm(TCONF, cleanup,
> +			         "FALLOC_FL_INSERT_RANGE not supported");
> +		}
> +		tst_brkm(TFAIL | TERRNO, cleanup, "fallocate failed");
> +	}
> +
> +	/* allocate space and ensure that it filled with zeroes */
> +	if (fallocate(fd, FALLOC_FL_ZERO_RANGE, block_size, block_size) == -1)
> +		tst_brkm(TFAIL | TERRNO, cleanup, "fallocate failed");
> +
> +	size_t alloc_size1 = get_allocsize();
> +
> +	tst_resm(TINFO, "allocated file size before '%zu' and after '%zu'",
> +		 alloc_size0, alloc_size1);
> +	if ((alloc_size0 + block_size) != alloc_size1)
> +		tst_brkm(TFAIL, cleanup, "not expected allocated size");
> +
> +	size_t size = buf_size;
> +	char tmp_buf[buf_size];
> +	char exp_buf[size];
> +
> +	fill_tst_buf(tmp_buf);
> +
> +	memcpy(exp_buf, tmp_buf, block_size);
> +	memcpy(exp_buf +  2 * block_size, tmp_buf + 2 * block_size,
> +	       buf_size - block_size * 2);
> +	memset(exp_buf + block_size - 1, 0, block_size + 2);
> +
> +	check_file_data(exp_buf, size);

Why not just:

        fill_tst_buf(exp_buf);
	memset(exp_buf + block_size - 1, 0, block_size + 2);

Otherwise it looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz
