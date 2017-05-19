From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 19 May 2017 16:25:42 +0200
Subject: [LTP] [PATCH v4 1/2] syscalls/splice04: add test for splice()
 from pipe to pipe
In-Reply-To: <1494580475-3522-1-git-send-email-bxue@redhat.com>
References: <1494580475-3522-1-git-send-email-bxue@redhat.com>
Message-ID: <20170519142542.GD17258@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#define _GNU_SOURCE
> +#include <fcntl.h>
> +#include <stdlib.h>
> +#include "tst_test.h"
> +
> +#define PIPE_MAX (64*1024)
> +
> +static char *str_len_data;
> +static int num_len_data = PIPE_MAX;
> +static char *arr_in, *arr_out;
> +
> +static struct tst_option options[] = {
> +	{"l:", &str_len_data, "-l <num> Length of test data (in bytes)"},
> +	{NULL, NULL, NULL},
> +};
> +
> +static void setup(void)
> +{
> +	int i, pipe_max_unpriv, pipe_limit;
> +
> +	SAFE_FILE_SCANF("/proc/sys/fs/pipe-max-size", "%d", &pipe_max_unpriv);
> +	pipe_limit = pipe_max_unpriv < num_len_data ? pipe_max_unpriv :
> +		num_len_data;

Hmm, this is case for a MIN() macro. I guess that I should add MIN() and
MAX*() to the tst_test.h header since we have several uses in the
testcases already.

> +	num_len_data = pipe_limit;
> +
> +	if (tst_parse_int(str_len_data, &num_len_data, 1, pipe_limit))
> +		tst_brk(TBROK, "Invalid length of data: '%s', "
> +			"valid value: [1, %d]", str_len_data, pipe_limit);

There should be curly braces around the multiline statement.

> +	tst_res(TINFO, "splice size = %d", num_len_data);
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
> +	int pp1[2], pp2[2], i, ret;
> +
> +	SAFE_PIPE(pp1);
> +	SAFE_PIPE(pp2);
> +	SAFE_WRITE(1, pp1[1], arr_in, num_len_data);
> +	for (i = 0; i < num_len_data; i++) {
> +		ret = splice(pp1[0], NULL, pp2[1], NULL, 1, SPLICE_F_MOVE);
> +		if (ret == -1) {
> +			tst_res(TFAIL | TERRNO, "splice error");
> +			goto exit;
> +		}
> +		SAFE_READ(1, pp2[0], arr_out + i, 1);
> +	}

I do not understand why we are moving the data byte by byte here?

And also the SPLICE_F_MOVE flag, even if that was correctly implemented,
would be useless here.

> +	for (i = 0; i < num_len_data; i++) {
> +		if (arr_in[i] != arr_out[i]) {
> +			tst_res(TFAIL, "wrong data at %d: expected: %d, "
> +				"actual: %d", i, arr_in[i], arr_out[i]);
> +			goto exit;
> +		}
> +	}
> +	tst_res(TPASS, "splice(2) from pipe to pipe run pass.");
> +
> +exit:
> +	SAFE_CLOSE(pp1[1]);
> +	SAFE_CLOSE(pp1[0]);
> +	SAFE_CLOSE(pp2[1]);
> +	SAFE_CLOSE(pp2[0]);
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
