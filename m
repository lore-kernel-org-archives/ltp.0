From: Murphy Zhou <jencce.kernel@gmail.com>
Date: Fri, 23 Aug 2019 15:15:06 +0800
Subject: [LTP] [PATCH] syscalls/copy_file_range02: use .needs_tmpdir and
 MAX_LEN
In-Reply-To: <1566541374-2225-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1566541374-2225-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20190823071506.3d32pwkss7aaewi3@XZHOUW.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Aug 23, 2019 at 02:22:54PM +0800, Yang Xu wrote:
> Since commit bc514b22, we have removed EXDEV test. all_filesystem
> ,mount_device and mntpoint make no sense. Remove it and use tmpdir.
> 
> As man-page said, when we plan to write at a position past the maximum
> allowed offset, it will return EFBIG. So we should USE MAX_LEN as pos
> instead of MAX_OFF.

Test PASS. Thanks!

> 
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> ---
>  .../kernel/syscalls/copy_file_range/copy_file_range02.c     | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
> index 9004c4a40..f502c75c0 100644
> --- a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
> +++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
> @@ -74,7 +74,7 @@ static struct tcase {
>  	{&fd_chrdev,    0,   EINVAL,     0,     CONTSIZE, "char device"},
>  	{&fd_fifo,      0,   EINVAL,     0,     CONTSIZE, "fifo"},
>  	{&fd_copy,      0,   EOVERFLOW,  MAX_OFF, ULLONG_MAX, "max length lenght"},
> -	{&fd_copy,      0,   EFBIG,      MAX_OFF, MIN_OFF, "max file size"},
> +	{&fd_copy,      0,   EFBIG,      MAX_LEN, MIN_OFF, "max file size"},
>  };
>  
>  static int run_command(char *command, char *option, char *file)
> @@ -219,8 +219,6 @@ static struct tst_test test = {
>  	.setup = setup,
>  	.cleanup = cleanup,
>  	.needs_root = 1,
> -	.mount_device = 1,
> -	.mntpoint = MNTPOINT,
> -	.all_filesystems = 1,
> +	.needs_tmpdir = 1,
>  	.test_variants = TEST_VARIANTS,
>  };
> -- 
> 2.18.1
> 
> 
> 
