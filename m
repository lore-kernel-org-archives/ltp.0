From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 13 Mar 2020 17:30:02 +0100
Subject: [LTP] [PATCH 2/2] Add new test cases to syscalls/readv01
In-Reply-To: <20200313153631.751-2-mdoucha@suse.cz>
References: <20200313153631.751-1-mdoucha@suse.cz>
 <20200313153631.751-2-mdoucha@suse.cz>
Message-ID: <20200313163002.GA19337@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Split the original test scenario into two test cases and add:
> - read into buffers bigger than input file
> - read into multiple buffers
> - read into non-NULL buffer with size = 0 (test for kernel commit 19f18459)
> 
> Also use guarded buffers in all IO vectors. Fixes #382
> 
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  testcases/kernel/syscalls/readv/readv01.c | 90 +++++++++++++++--------
>  1 file changed, 60 insertions(+), 30 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/readv/readv01.c b/testcases/kernel/syscalls/readv/readv01.c
> index ad0ab187b..fc17100eb 100644
> --- a/testcases/kernel/syscalls/readv/readv01.c
> +++ b/testcases/kernel/syscalls/readv/readv01.c
> @@ -20,57 +20,78 @@
>  
>  #include "tst_test.h"
>  
> +/* Note: multi_iovec test assumes CHUNK is divisible by 4 */
>  #define	CHUNK		64
>  
>  static char buf[CHUNK];
> +static struct iovec *rd_iovec, *big_iovec, *multi_iovec, *lockup_iovec;
> +static int fd;
>  
> -static struct iovec rd_iovec[] = {
> -	{buf, CHUNK},
> -	{NULL, 0},
> -	{NULL, 0},
> +static struct testcase {
> +	struct iovec **iov;
> +	int iov_count, exp_ret;
> +	const char *name;
> +} testcase_list[] = {
> +	{&rd_iovec, 0, 0, "readv() with 0 I/O vectors"},
> +	{&rd_iovec, 3, CHUNK, "readv() with NULL I/O vectors"},
> +	{&big_iovec, 2, CHUNK, "readv() with too big I/O vectors"},
> +	{&multi_iovec, 2, 3*CHUNK/4, "readv() with multiple I/O vectors"},
> +	{&lockup_iovec, 2, CHUNK, "readv() with zero-len buffer"},
>  };
>  
> -static int fd;
> -
> -static void run(void)
> +static void test_readv(unsigned int n)
>  {
> -	int i, fail;
> -	char *vec;
> +	int i, fpos, fail = 0;
> +	size_t j;
> +	char *ptr;
> +	const struct testcase *tc = testcase_list + n;
> +	struct iovec *vec;
>  
>  	SAFE_LSEEK(fd, 0, SEEK_SET);
> +	vec = *tc->iov;
>  
> -	if (readv(fd, rd_iovec, 0) == -1)
> -		tst_res(TFAIL | TERRNO, "readv failed unexpectedly");
> -	else
> -		tst_res(TPASS, "readv read 0 io vectors");
> +	for (i = 0; i < tc->iov_count; i++)
> +		if (vec[i].iov_base && vec[i].iov_len)
> +			memset(vec[i].iov_base, 0, vec[i].iov_len);

This is minor however LKML coding style mandates curly braces around
multiline blocks, so the for () loop should be followed by them.

> +	TEST(readv(fd, vec, tc->iov_count));
> +
> +	if (TST_RET == -1)
> +		tst_res(TFAIL | TTERRNO, "readv() failed unexpectedly");
> +	else if (TST_RET < 0)
> +		tst_res(TFAIL | TTERRNO, "readv() returned invalid value");
> +	else if (TST_RET != tc->exp_ret)
> +		tst_res(TFAIL, "readv() returned unexpected value %ld",
> +			TST_RET);
>  
> -	memset(rd_iovec[0].iov_base, 0x00, CHUNK);
> +	if (TST_RET != tc->exp_ret)
> +		return;
>  
> -	if (readv(fd, rd_iovec, 3) != CHUNK) {
> -		tst_res(TFAIL, "readv failed reading %d bytes, "
> -			 "followed by two NULL vectors", CHUNK);
> -	} else {
> -		fail = 0;
> -		vec = rd_iovec[0].iov_base;
> +	tst_res(TPASS, "%s", tc->name);
>  
> -		for (i = 0; i < CHUNK; i++) {
> -			if (vec[i] != 0x42)
> +	for (i = 0, fpos = 0; i < tc->iov_count; i++) {
> +		ptr = vec[i].iov_base;
> +
> +		for (j = 0; j < vec[i].iov_len; j++, fpos++) {
> +			if (ptr[j] != (fpos < tc->exp_ret ? 0x42 : 0))
>  				fail++;
>  		}
> -
> -		if (fail)
> -			tst_res(TFAIL, "Wrong buffer content");
> -		else
> -			tst_res(TPASS, "readv passed reading %d bytes "
> -			         "followed by two NULL vectors", CHUNK);
>  	}
> +
> +	if (fail)
> +		tst_res(TFAIL, "Wrong buffer content");
> +	else
> +		tst_res(TPASS, "readv() correctly read %d bytes ", tc->exp_ret);
>  }
>  
>  static void setup(void)
>  {
> +	/* replace the default NULL pointer with end of guarded buffer */
> +	lockup_iovec[0].iov_base = rd_iovec[0].iov_base + rd_iovec[0].iov_len;

We do have tst_get_bad_addr() for this.

Maybe we can even patch the buffer library to produce bad pointer when
we pass negative .size.

>  	memset(buf, 0x42, sizeof(buf));
>  
> -	fd = SAFE_OPEN("data_file", O_WRONLY | O_CREAT, 0666);
> +	fd = SAFE_OPEN("data_file", O_WRONLY | O_CREAT | O_TRUNC, 0666);
>  	SAFE_WRITE(1, fd, buf, sizeof(buf));
>  	SAFE_CLOSE(fd);
>  	fd = SAFE_OPEN("data_file", O_RDONLY);
> @@ -85,6 +106,15 @@ static void cleanup(void)
>  static struct tst_test test = {
>  	.setup = setup,
>  	.cleanup = cleanup,
> -	.test_all = run,
> +	.test = test_readv,
> +	.tcnt = ARRAY_SIZE(testcase_list),
>  	.needs_tmpdir = 1,
> +	.timeout = 15,

What's the problem with default timeout?

> +	.bufs = (struct tst_buffers[]) {
> +		{&rd_iovec, .iov_sizes = (int[]){CHUNK, 0, 0, -1}},
> +		{&big_iovec, .iov_sizes = (int[]){2*CHUNK, CHUNK, -1}},
> +		{&multi_iovec, .iov_sizes = (int[]){CHUNK/4, CHUNK/2, -1}},
> +		{&lockup_iovec, .iov_sizes = (int[]){0, CHUNK, -1}},
> +		{}
> +	}
>  };
> -- 
> 2.25.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
