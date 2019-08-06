From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 6 Aug 2019 18:27:00 +0800
Subject: [LTP] [PATCH 2/2] syscalls/copy_file_range02: Add test
 description
In-Reply-To: <20190806091040.26448-2-pvorel@suse.cz>
References: <20190806091040.26448-1-pvorel@suse.cz>
 <20190806091040.26448-2-pvorel@suse.cz>
Message-ID: <5D4955F4.40204@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi
> to increase readability as all_filesystems flag prolonged output a lot.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  .../copy_file_range/copy_file_range02.c       | 33 ++++++++++---------
>  1 file changed, 18 insertions(+), 15 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
> index 472dffdc6..56797f639 100644
> --- a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
> +++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
> @@ -13,14 +13,14 @@
>   * 2) Try to copy contents to directory -> EISDIR
>   * 3) Try to copy contents to a file opened with the
>   *    O_APPEND flag -> EBADF
> - * 4) Try to copy contents to closed filedescriptor
> + * 4) Try to copy contents to closed file descriptor
>   *    -> EBADF
>   * 5) Try to copy contents with invalid 'flags' value
>   *    -> EINVAL
>   * 6) Try to copy contents to a file chattred with +i
>   *    flag -> EPERM
>   * 7) Try to copy contents to a swapfile ->ETXTBSY
> - * 8) Try to copy contents to the samefile with overlapping
> + * 8) Try to copy contents to the same file with overlapping
>   *    ->EINVAL
>   * 9) Try to copy contents to a blkdev ->EINVAL
>   * 10) Try to copy contents to a chardev ->EINVAL
> @@ -60,20 +60,21 @@ static struct tcase {
>  	int	exp_err;
>  	loff_t  dst;
>  	loff_t     len;
> +	const char *tname;
>  } tcases[] = {
> -	{&fd_rdonly,	0,   EBADF,      0,     CONTSIZE},
> -	{&fd_dir,	0,   EISDIR,     0,     CONTSIZE},
> -	{&fd_append,	0,   EBADF,      0,     CONTSIZE},
> -	{&fd_closed,	0,   EBADF,      0,     CONTSIZE},
> -	{&fd_dest,	-1,  EINVAL,     0,     CONTSIZE},
> -	{&fd_immutable, 0,   EPERM,      0,     CONTSIZE},
> -	{&fd_swapfile,  0,   ETXTBSY,    0,     CONTSIZE},
> -	{&fd_dup,       0,   EINVAL,     0,     CONTSIZE/2},
> -	{&fd_blkdev,    0,   EINVAL,     0,     CONTSIZE},
> -	{&fd_chrdev,    0,   EINVAL,     0,     CONTSIZE},
> -	{&fd_fifo,      0,   EINVAL,     0,     CONTSIZE},
> -	{&fd_copy,      0,   EOVERFLOW,  MAX_OFF, ULLONG_MAX},
> -	{&fd_copy,      0,   EFBIG,      MAX_OFF, MIN_OFF},
> +	{&fd_rdonly,	0,   EBADF,      0,     CONTSIZE, "readonly file"},
> +	{&fd_dir,	0,   EISDIR,     0,     CONTSIZE, "directory"},
> +	{&fd_append,	0,   EBADF,      0,     CONTSIZE, "append to file"},
> +	{&fd_closed,	0,   EBADF,      0,     CONTSIZE, "closed file descriptor"},
> +	{&fd_dest,	-1,  EINVAL,     0,     CONTSIZE, "invalid flags"},
> +	{&fd_immutable, 0,   EPERM,      0,     CONTSIZE, "immutable file"},
> +	{&fd_swapfile,  0,   ETXTBSY,    0,     CONTSIZE, "swap file"},
> +	{&fd_dup,       0,   EINVAL,     0,     CONTSIZE/2, "overlaping"},
overlaping range
> +	{&fd_blkdev,    0,   EINVAL,     0,     CONTSIZE, "block device"},
> +	{&fd_chrdev,    0,   EINVAL,     0,     CONTSIZE, "charr device"},
char device
> +	{&fd_fifo,      0,   EINVAL,     0,     CONTSIZE, "fifo"},
> +	{&fd_copy,      0,   EOVERFLOW,  MAX_OFF, ULLONG_MAX, "max length lenght"},
> +	{&fd_copy,      0,   EFBIG,      MAX_OFF, MIN_OFF, "max file size"},
>  };
>  
>  static int run_command(char *command, char *option, char *file)
> @@ -97,6 +98,8 @@ static int run_command(char *command, char *option, char *file)
>  static void verify_copy_file_range(unsigned int n)
>  {
>  	struct tcase *tc = &tcases[n];
> +	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
> +
>  	if (tc->copy_to_fd == &fd_immutable && chattr_i_nsup) {
>  		tst_res(TCONF, "filesystem doesn't support chattr +i, skip it");
>  		return;
Other than typos, this patchset looks good to me.


