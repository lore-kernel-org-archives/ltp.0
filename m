From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 10 Apr 2017 16:31:18 +0200
Subject: [LTP] [PATCH v3 1/1] syscalls/splice04: add test for splice()
 from pipe to pipe
In-Reply-To: <1491375303-1418-1-git-send-email-bxue@redhat.com>
References: <1491375303-1418-1-git-send-email-bxue@redhat.com>
Message-ID: <20170410143118.GA21811@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void setup(void)
> +{
> +	int i;
> +
> +	if (tst_parse_int(str_len_data, &num_len_data, 1, MAX_DATA_LEN))
> +		tst_brk(TBROK, "Invalid length of data: '%s'", str_len_data);
> +	tst_res(TINFO, "splice size = %d\n", num_len_data);
                                        ^
					The \n should be removed as it
					adds a second newline after the
					message.
> +	arr_in = SAFE_MALLOC(num_len_data);
> +	arr_out = SAFE_MALLOC(num_len_data);
> +	for (i = 0; i < num_len_data; i++)
> +		arr_in[i] = i & 0xff;
> +}
> +
> +static void cleanup(void)
> +{
> +	free(arr_in);
> +	free(arr_out);
> +}
> +
> +static void pipe_pipe(void)
> +{
> +	int pp1[2], pp2[2], i;
> +
> +	SAFE_PIPE(pp1);
> +	SAFE_PIPE(pp2);
> +	SAFE_WRITE(1, pp1[1], arr_in, num_len_data);
> +	if (splice(pp1[0], NULL, pp2[1], NULL, num_len_data, SPLICE_F_MOVE) != num_len_data)
> +		tst_res(TFAIL, "incomplete splice operation.");

We should print the return value from the splice and errno as well and
also close the fds and return.

	ret = splice(...)
	if (ret != num_len_data) {
		tst_res(TFAIL | TERRNO, "Splice returned %i", ret);
		goto exit;
	}

> +	SAFE_READ(1, pp2[0], arr_out, num_len_data);
> +
> +	SAFE_CLOSE(pp1[1]);
> +	SAFE_CLOSE(pp1[0]);
> +	SAFE_CLOSE(pp2[1]);
> +	SAFE_CLOSE(pp2[0]);
> +
> +	for (i = 0; i < num_len_data; i++) {
> +		if (arr_in[i] != arr_out[i]) {
> +			tst_res(TFAIL, "splice(2) from pipe to pipe fails.");

We may print the actual and expected value, something as:

tst_res(TFAIL, "wrong data at %i have %i expected %i",
	i, arr_out[i], arr_in[i]);

> +			return;

And do the goto exit; to close the fds.

> +		}
> +	}
> +	tst_res(TPASS, "splice(2) from pipe to pipe run pass.");
> +	return;
          ^
	 The return here is useless

Here we should add the exit label

exit:
	SAFE_CLOSE(pp1[1]);
	SAFE_CLOSE(pp1[0]);
	SAFE_CLOSE(pp2[1]);
	SAFE_CLOSE(pp2[0]);
> +}
> +
> +static struct tst_test test = {
> +	.tid = "splice04",
> +	.test_all = pipe_pipe,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.options = options,
> +	.min_kver = "2.6.31"
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
