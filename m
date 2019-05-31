From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 31 May 2019 15:03:21 +0200
Subject: [LTP] [PATCH] syscalls: testing on all fs for copy_file_range02
 and getxattr04
In-Reply-To: <20190531095659.22796-1-xzhou@redhat.com>
References: <20190531095659.22796-1-xzhou@redhat.com>
Message-ID: <20190531130321.GB12608@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> To increase test coverage. If the testing fs is not supporting
> this syscall, tcase handles it well.
> 
> Signed-off-by: Murphy Zhou <xzhou@redhat.com>
> ---
>  testcases/kernel/syscalls/copy_file_range/copy_file_range02.c | 2 +-
>  testcases/kernel/syscalls/getxattr/getxattr04.c               | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
> index 07c0207c2..d3fb737be 100644
> --- a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
> +++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
> @@ -113,6 +113,6 @@ static struct tst_test test = {
>  	.needs_root = 1,
>  	.mount_device = 1,
>  	.mntpoint = MNTPOINT,
> -	.dev_fs_type = "ext4",
> +	.all_filesystems = 1,
>  	.test_variants = TEST_VARIANTS,
>  };

Actually looking at the kernel code all these error checks are done in
the vfs_copy_file_range() function so as far as I can tell there is no
point in running copy_file_range02 test for all filesystems. Maybe we
can just delete all the device code and change the test to use the
default TMPDIR instead?

It would may much more sense to run the copy_file_range01 and
copy_file_range03 for all filesystems, because these tests advance
beyond the common checks and actually copy the file which invokes
either the f_op->copy_file_range() or the do_splice_direct() fallback.

> diff --git a/testcases/kernel/syscalls/getxattr/getxattr04.c b/testcases/kernel/syscalls/getxattr/getxattr04.c
> index 1dcb14da3..905abd587 100644
> --- a/testcases/kernel/syscalls/getxattr/getxattr04.c
> +++ b/testcases/kernel/syscalls/getxattr/getxattr04.c
> @@ -121,7 +121,7 @@ static struct tst_test test = {
>  	.needs_tmpdir = 1,
>  	.needs_root = 1,
>  	.mount_device = 1,
> -	.dev_fs_type = "xfs",
> +	.all_filesystems = 1,
>  	.mntpoint = MNTPOINT,
>  	.forks_child = 1,
>  	.test_all = verify_getxattr,

Can you please split the patch?

It's a bit cleaner (and easier when we have to revert) to enable the
all_filesystem flags for each syscall in a separate patch.

-- 
Cyril Hrubis
chrubis@suse.cz
