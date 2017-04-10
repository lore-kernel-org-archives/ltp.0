From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 10 Apr 2017 16:42:34 +0200
Subject: [LTP] [PATCH v1 1/1] syscalls/splice05: add test for splice()
 between pipe and socket
In-Reply-To: <1491551087-31017-1-git-send-email-bxue@redhat.com>
References: <1491551087-31017-1-git-send-email-bxue@redhat.com>
Message-ID: <20170410144234.GC21811@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#define MAX_DATA_LEN (64*1024)
> +
> +static void setup(void);
> +static void cleanup(void);
> +static void pipe_socket(void);

These function prototypes are useless.

> +static char *arr_in, *arr_out;
> +static char *str_len_data;
> +static int num_len_data = MAX_DATA_LEN;
> +static int pp0[2], pp1[2], sv[2];
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
> +	tst_res(TINFO, "splice size = %d\n", num_len_data);
                                         ^
					 Second newline here as well.

> +	arr_in = SAFE_MALLOC(num_len_data);
> +	for (i = 0; i < num_len_data; i++)
> +		arr_in[i] = i & 0xff;
> +}
> +
> +static void cleanup(void)
> +{
> +	int i;
> +
> +	free(arr_in);
> +	free(arr_out);
> +
> +	for (i = 0; i < 2; i++) {
> +		SAFE_CLOSE(pp0[i]);
> +		SAFE_CLOSE(pp1[i]);
> +		SAFE_CLOSE(sv[i]);
> +	}

If you open the pipes/sockets in the test function you have to close it
there in case that the test function is executed in a loop. Otherwise
the test may fail when file descriptors are used up.

> +}
> +
> +static void pipe_socket(void)
> +{
> +	int i;
> +
> +	SAFE_PIPE(pp0);
> +	SAFE_PIPE(pp1);
> +	if (socketpair(AF_UNIX, SOCK_STREAM, 0, sv))
> +		tst_brk(TBROK, "fail to create socket pair.");
                         ^
			 We should print errno with TERRNO here.

> +	SAFE_WRITE(1, pp0[1], arr_in, num_len_data);
> +	if (splice(pp0[0], NULL, sv[0], 0, num_len_data, SPLICE_F_MOVE) != num_len_data)
> +		tst_res(TFAIL, "incomplete splice operation.");
> +	if (splice(sv[1], 0, pp1[1], NULL, num_len_data, SPLICE_F_MOVE) != num_len_data)
> +		tst_res(TFAIL, "incomplete splice operation.");

Here as well we should print the splice return value and errno.

> +	arr_out = SAFE_MALLOC(num_len_data);

Why do we allocate the arr_out here insetad of setup?

> +	SAFE_READ(1, pp1[0], arr_out, num_len_data);
> +
> +	for (i = 0; i < num_len_data; i++) {
> +		if (arr_in[i] != arr_out[i]) {
> +			tst_res(TFAIL, "splice(2): pipe <-> socket fails.");

Here as well you may print more info about the buffer.

> +			return;
> +		}
> +	}
> +	tst_res(TPASS, "splice(2): pipe <-> socket run pass.");
> +	return;

Useless return here as well.

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
