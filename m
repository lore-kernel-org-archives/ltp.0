From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 12 Feb 2020 17:42:19 +0800
Subject: [LTP] [PATCH v2] aio02: Drop O_DIRECT flag for tmpfs
In-Reply-To: <1581492715-15110-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <5E438D72.4020203@cn.fujitsu.com>
 <1581492715-15110-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <5E43C87B.60800@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2020/2/12 15:31, Yang Xu wrote:
> tmpfs doesn't support O_DIRECT flag, drop it. userer still can run aio02
> with different filesystem by mounting specified filesystem on $TMPDIR.
>
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/io/aio/aio02.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/io/aio/aio02.c b/testcases/kernel/io/aio/aio02.c
> index e283afba9..3bb89c45f 100644
> --- a/testcases/kernel/io/aio/aio02.c
> +++ b/testcases/kernel/io/aio/aio02.c
> @@ -18,7 +18,8 @@
>  #define AIO_MAXIO 32
>  #define AIO_BLKSIZE (64*1024)
>  
> -static int wait_count = 0;
> +static int wait_count;
Hi,

Why do you set wait_count to 0?
Isn't it default behavior?

> +static unsigned int use_tmpfs;
>  
>  #define DESC_FLAGS_OPR(x, y) .desc = (x == IO_CMD_PWRITE ? "WRITE: " #y: "READ : " #y), \
>  	.flags = y, .operation = x
> @@ -206,6 +207,11 @@ static void test_io(unsigned int n)
>  	int status;
>  	struct testcase *tc = testcases + n;
>  
> +	if (use_tmpfs && (tc->flags & O_DIRECT)) {
> +		tst_res(TINFO, "Drop O_DIRECT flag for tmpfs");
> +		tc->flags &= (~O_DIRECT);
> +	}
> +
>  	status = io_tio("file", tc->flags, tc->operation);
>  	if (status)
>  		tst_res(TFAIL, "%s, status = %d", tc->desc, status);
> @@ -213,7 +219,14 @@ static void test_io(unsigned int n)
>  		tst_res(TPASS, "%s", tc->desc);
>  }
>  
> +static void setup(void)
> +{
> +	if (tst_fs_type(".") == TST_TMPFS_MAGIC)
> +		use_tmpfs = 1;

Could you simple the fix by moving 'tst_fs_type(".") == TST_TMPFS_MAGIC
' into test_io().
(i.e. Drop unused setup() and use_tmpfs.)

Thanks,
Xiao Yang
> +}
> +
>  static struct tst_test test = {
> +	.setup = setup,
>  	.needs_tmpdir = 1,
>  	.test = test_io,
>  	.tcnt = ARRAY_SIZE(testcases),



