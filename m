From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 19 May 2017 16:27:09 +0200
Subject: [LTP] [PATCH v4 2/2] syscalls/splice05: add test for splice()
 between pipe and socket
In-Reply-To: <1494580475-3522-2-git-send-email-bxue@redhat.com>
References: <1494580475-3522-1-git-send-email-bxue@redhat.com>
 <1494580475-3522-2-git-send-email-bxue@redhat.com>
Message-ID: <20170519142708.GE17258@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void setup(void)
> +{
> +	int i, pipe_max_unpriv, pipe_limit;
> +
> +	SAFE_FILE_SCANF("/proc/sys/fs/pipe-max-size", "%d", &pipe_max_unpriv);
> +	pipe_limit = pipe_max_unpriv < num_len_data ? pipe_max_unpriv :
> +		num_len_data;
> +	num_len_data = pipe_limit;
> +
> +	if (tst_parse_int(str_len_data, &num_len_data, 1, pipe_limit))
> +		tst_brk(TBROK, "Invalid length of data: '%s', "
> +			"valid value: [1, %d]", str_len_data, pipe_limit);

Here as well.

> +	tst_res(TINFO, "splice size = %d", num_len_data);
> +	arr_in = SAFE_MALLOC(num_len_data);
> +	arr_out = SAFE_MALLOC(num_len_data);
> +	for (i = 0; i < num_len_data; i++)
> +		arr_in[i] = i & 0xff;
> +
> +}
> +
> +static void cleanup(void)
> +{
> +	free(arr_in);
> +	free(arr_out);
> +}
> +
> +static void pipe_socket(void)
> +{
> +	int pp1[2], pp2[2], sv[2], i, ret;
> +
> +	SAFE_PIPE(pp1);
> +	SAFE_PIPE(pp2);
> +	if (socketpair(AF_UNIX, SOCK_STREAM, 0, sv))
> +		tst_brk(TBROK | TERRNO, "fail to create socket pair.");
> +
> +	SAFE_WRITE(1, pp1[1], arr_in, num_len_data);
> +	for (i = 0; i < num_len_data; i++) {
> +		ret = splice(pp1[0], NULL, sv[0], 0, 1, SPLICE_F_MOVE);
> +		if (ret == -1) {
> +			tst_res(TFAIL | TERRNO, "splice error");
> +			goto exit;
> +		}
> +	}
> +	for (i = 0; i < num_len_data; i++) {
> +		ret = splice(sv[1], 0, pp2[1], NULL, 1, SPLICE_F_MOVE);
> +		if (ret == -1) {
> +			tst_res(TFAIL | TERRNO, "splice error");
> +			goto exit;
> +		}
> +		SAFE_READ(1, pp2[0], arr_out + i, 1);
> +	}

And here as well.

> +	for (i = 0; i < num_len_data; i++) {
> +		if (arr_in[i] != arr_out[i]) {
> +			tst_res(TFAIL, "wrong data at %d: expected: %d, "
> +				"actual %d", i, arr_in[i], arr_out[i]);
> +			goto exit;
> +		}
> +	}
> +	tst_res(TPASS, "splice(2): pipe <-> socket run pass.");
> +exit:
> +	for (i = 0; i < 2; i++) {
> +		SAFE_CLOSE(pp1[i]);
> +		SAFE_CLOSE(pp2[i]);
> +		SAFE_CLOSE(sv[i]);
> +	}
> +}
> +
> +static struct tst_test test = {
> +	.tid = "splice05",
> +	.test_all = pipe_socket,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.options = options,
> +	.min_kver = "2.6.17"
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
