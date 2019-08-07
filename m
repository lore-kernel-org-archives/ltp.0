From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 7 Aug 2019 07:45:03 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/copy_file_range02: Fix #12 when TMPDIR
 is on tmpfs or ext[234]
In-Reply-To: <20190807094119.10834-1-pvorel@suse.cz>
References: <20190807094119.10834-1-pvorel@suse.cz>
Message-ID: <963130698.5086817.1565178303526.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Recent fix 96e6e8f4a68d ("vfs: add missing checks to copy_file_range")
> in kernel v5.3-rc1 changed errno for ext[234] and tmpfs to EINVAL.
> 
> + fix typo from 0242a9a29
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi all,
> 
> Amir, Darrick, am I right that it's not a problem that errno changed
> recently, is it? There have been more errno changes due several fixes in
> copy_file_range() in the past. I've seen this approach several times in
> other subsystems (e.g. network). Hope userspace not often check for
> particular error.
> 
> Cyril, Jan, Li, still not sure what the policy about errno is (see
> Cyril's statements in recent discussion about it in Jinhui's patch [1]
> [2]). With these frequent changes we should IMHO check for all possible
> variants (EXDEV, EFBIG, EINVAL).

Petr,

Looking at test code, it does seem like testcase you listed violates
multiple checks at same time.

Are you getting EINVAL on tmpfs/ext234 even when source file length > MIN_OFF ?

EINVAL: Requested range extends beyond the end of the source file; or the flags argument is not 0.

Regards,
Jan

> 
> Or should we investigate all fixes and keep errors which highlight
> important fix was not backported (to both stable and LTS/enterprise
> distros kernels?). That'd be weird but approach practical :).
> 
> Anyway, we should define and write down LTP policy / rules about it.
> 
> Kind regards,
> Petr
> 
> [1] https://patchwork.ozlabs.org/patch/1108229/#2182801
> [2] https://patchwork.ozlabs.org/patch/1108229/#2182837
> 
>  .../copy_file_range/copy_file_range02.c       | 20 +++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
> b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
> index 9004c4a40..b113e44b5 100644
> --- a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
> +++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
> @@ -49,6 +49,7 @@ static int fd_blkdev;
>  static int fd_chrdev;
>  static int fd_fifo;
>  static int fd_copy;
> +static int fd_copy2;
>  
>  static int chattr_i_nsup;
>  static int swap_nsup;
> @@ -73,8 +74,8 @@ static struct tcase {
>  	{&fd_blkdev,    0,   EINVAL,     0,     CONTSIZE, "block device"},
>  	{&fd_chrdev,    0,   EINVAL,     0,     CONTSIZE, "char device"},
>  	{&fd_fifo,      0,   EINVAL,     0,     CONTSIZE, "fifo"},
> -	{&fd_copy,      0,   EOVERFLOW,  MAX_OFF, ULLONG_MAX, "max length lenght"},
> -	{&fd_copy,      0,   EFBIG,      MAX_OFF, MIN_OFF, "max file size"},
> +	{&fd_copy,      0,   EOVERFLOW,  MAX_OFF, ULLONG_MAX, "max length"},
> +	{&fd_copy2,     0,   EFBIG,      MAX_OFF, MIN_OFF, "max file size"},
>  };
>  
>  static int run_command(char *command, char *option, char *file)
> @@ -100,6 +101,7 @@ static void verify_copy_file_range(unsigned int n)
>  	struct tcase *tc = &tcases[n];
>  	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
>  
> +
>  	if (tc->copy_to_fd == &fd_immutable && chattr_i_nsup) {
>  		tst_res(TCONF, "filesystem doesn't support chattr +i, skip it");
>  		return;
> @@ -112,6 +114,20 @@ static void verify_copy_file_range(unsigned int n)
>  		tst_res(TCONF, "filesystem doesn't have free loopdev, skip it");
>  		return;
>  	}
> +
> +	if (tc->copy_to_fd == &fd_copy2) {
> +		long fs_type = tst_fs_type(".");
> +		switch (fs_type) {
> +		case TST_TMPFS_MAGIC:
> +		case TST_EXT234_MAGIC:
> +		default:
> +			tc->exp_err = EINVAL;
> +			tst_res(TINFO, "%s filesystem, changing expecting errno to %d",
> +					tst_fs_type_name(fs_type), tc->exp_err);
> +			break;
> +		}
> +	}
> +
>  	TEST(sys_copy_file_range(fd_src, 0, *tc->copy_to_fd,
>  				&tc->dst, tc->len, tc->flags));
>  
> --
> 2.22.0
> 
> 
