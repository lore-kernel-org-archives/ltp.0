From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 3 Apr 2017 17:14:49 +0200
Subject: [LTP] [PATCH v2 1/1] syscalls/splice04: add test for splice()
 from pipe to pipe
In-Reply-To: <1490951934-17763-1-git-send-email-bxue@redhat.com>
References: <1490951934-17763-1-git-send-email-bxue@redhat.com>
Message-ID: <20170403151449.GA25596@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +/*
> + * Functional test for splice(2): pipe to pipe
> + *
> + * This test case tests splice(2) from a pipe to another
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <fcntl.h>
> +#include <stdlib.h>
> +#include "tst_test.h"
> +
> +#define MAX_DATA_LEN (64*1024)
> +
> +static void setup(void);
> +static void cleanup(void);
> +static void maintest(void);
> +static int cmp_data(void);
> +static int pipe_pipe(void);

Nearly all of these are not needed, the only one is the pipe_pipe()
called from maintest() and this wouldn't be needed if there is no
maintest function anyway.

> +static char *str_len_data;
> +static int num_len_data;

You can initialize the num_len_data to MAX_DATA_LEN here and drop the
if (!num_len_data) condition from the setup()

> +static char *arr_in;
> +static char *arr_out;
> +
> +static struct tst_option options[] = {
> +	{"l:", &str_len_data, "-l <num> Length of test data (in bytes)"},
> +	{NULL, NULL, NULL},
> +};
> +
> +static void setup(void)
> +{
> +	int i;
> +
> +	if (tst_parse_int(str_len_data, &num_len_data, 1, MAX_DATA_LEN))
> +		tst_brk(TBROK, "Invalid length of data: '%s'", str_len_data);
> +	if (!num_len_data)
> +		num_len_data = MAX_DATA_LEN;
> +
> +	fprintf(stdout, "splice size = %d\n", num_len_data);

Use tst_res(TINFO, ) here.

> +	arr_in = SAFE_MALLOC(num_len_data);
> +	arr_out = SAFE_MALLOC(num_len_data);
> +	for (i = 0; i < num_len_data; i++)
> +		*(arr_in + i) = i & 0xff;
                 ^
		 This is just more complicated way how to write
		 arr_in[i] = ...
> +}
> +
> +static void cleanup(void)
> +{
> +	if (arr_in != NULL)
> +		free(arr_in);
> +	if (arr_out != NULL)
> +		free(arr_out);

Do just free(arr_in) and free(arr_out) here, free(NULL) is no-op.

> +}
> +
> +static void maintest(void)
> +{
> +	if (pipe_pipe())
> +		tst_res(TFAIL, "splice(2) from pipe to pipe fails.");
> +	else
> +		tst_res(TPASS, "splice(2) from pipe to pipe run pass.");

Why do we need a separate function just to print the PASS/FAIL ?

Why can't we just print PASS/FAIL in the cmp_data() function?

> +}
> +
> +static int cmp_data(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < num_len_data; i++) {
> +		if (*(arr_in + i) != *(arr_out + i)) {
                       ^
		       Again this is the same as arr_in[i] and arr_out[i]
> +			tst_res(TBROK, "Data mismatch after splice operation.");
                           ^
			   This message here does not make sense, it's
			   clear TFAIL.
> +			return -1;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int pipe_pipe(void)
> +{
> +	int pp1[2], pp2[2];
> +
> +	SAFE_PIPE(pp1);
> +	SAFE_PIPE(pp2);
> +	SAFE_WRITE(1, pp1[1], arr_in, num_len_data);
> +	splice(pp1[0], NULL, pp2[1], NULL, num_len_data, SPLICE_F_MOVE);

You should really check the return value from the syscall you are
supposed to test...

> +	SAFE_READ(1, pp2[0], arr_out, num_len_data);
> +
> +	SAFE_CLOSE(pp1[1]);
> +	SAFE_CLOSE(pp1[0]);
> +	SAFE_CLOSE(pp2[1]);
> +	SAFE_CLOSE(pp2[0]);
> +
> +	return cmp_data();
> +}
> +
> +static struct tst_test test = {
> +	.tid = "splice04",
> +	.test_all = maintest,
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
