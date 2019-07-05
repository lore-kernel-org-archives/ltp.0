From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 5 Jul 2019 18:22:21 +0300
Subject: [LTP] [PATCH] syscalls/copy_file_range02: increase coverage and
 remove EXDEV test
In-Reply-To: <1562125302-4279-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1562125302-4279-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <CAOQ4uxgUfhDL3kE_2xFKTnfs+Pgn5UJ38n2aFxz4XndfUeFX8A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Jul 5, 2019 at 12:37 PM Yang Xu <xuyang2018.jy@cn.fujitsu.com> wrote:
>
> Since Amir path for copy_file_range has been merged into linux-xfs,
> I add test for swapfile, immutable file, bounds in ltp.  Also, add test
> for block char pipe dev and remove EXDEV test(5.3 will relax the cross-device
> constraint[2]).  I follow xfstests code[3][4][5] and increase it .
>
> [1]https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?h=for-next-5.3&id=5dae222a5ff0c269730393018a5539cc970a4726
> [2]https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?h=for-next-5.3&id=96e6e8f4a68df2d94800311163faa67124df24e5
> [3]https://patchwork.kernel.org/patch/10971759/
> [4]https://patchwork.kernel.org/patch/10971747/
> [5]https://patchwork.kernel.org/patch/10961421/
>
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>  .../copy_file_range/copy_file_range.h         |  11 +-
>  .../copy_file_range/copy_file_range02.c       | 127 +++++++++++++++---
>  2 files changed, 118 insertions(+), 20 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range.h b/testcases/kernel/syscalls/copy_file_range/copy_file_range.h
> index b6d132978..22bbb46a5 100644
> --- a/testcases/kernel/syscalls/copy_file_range/copy_file_range.h
> +++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range.h
> @@ -9,6 +9,7 @@
>
>  #include <stdbool.h>
>  #include <unistd.h>
> +#include <sys/sysmacros.h>
>  #include "lapi/syscalls.h"
>
>  #define TEST_VARIANTS  2
> @@ -18,10 +19,18 @@
>  #define FILE_DEST_PATH  "file_dest"
>  #define FILE_RDONL_PATH "file_rdonl"
>  #define FILE_DIR_PATH  "file_dir"
> -#define FILE_MNTED_PATH        MNTPOINT"/file_mnted"
> +#define FILE_IMMUTABLE_PATH "file_immutable"
> +#define FILE_SWAP_PATH "file_swap"
> +#define FILE_BLKDEV    "file_blk"
> +#define FILE_CHRDEV    "file_chr"
> +#define FILE_FIFO      "file_fifo"
> +#define FILE_COPY_PATH  "file_copy"
>
>  #define CONTENT                "ABCDEFGHIJKLMNOPQRSTUVWXYZ12345\n"
>  #define CONTSIZE       (sizeof(CONTENT) - 1)
> +#define MAX_OFF   9223372036854712050

Please use the expression instead of the unexplained value

> +#define MIN_OFF   65537
> +#define MAX_LEN   9223372036854775807

Same here

>
>  static void syscall_info(void)
>  {
> diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
> index 07c0207c2..b408d738d 100644
> --- a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
> +++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
> @@ -10,15 +10,25 @@
>   *
>   * 1) Try to copy contents to file open as readonly
>   *    -> EBADF
> - * 2) Try to copy contents to file on different mounted
> - *    filesystem -> EXDEV
> - * 3) Try to copy contents to directory -> EISDIR
> - * 4) Try to copy contents to a file opened with the
> + * 2) Try to copy contents to directory -> EISDIR
> + * 3) Try to copy contents to a file opened with the
>   *    O_APPEND flag -> EBADF
> - * 5) Try to copy contents to closed filedescriptor
> + * 4) Try to copy contents to closed filedescriptor
>   *    -> EBADF
> - * 6) Try to copy contents with invalid 'flags' value
> + * 5) Try to copy contents with invalid 'flags' value
>   *    -> EINVAL
> + * 6) Try to copy contents to a file chattred with +i
> + *    flag -> EPERM
> + * 7) Try to copy contents to a swapfile ->ETXTBSY
> + * 8) Try to copy contents to the samefile with overlapping
> + *    ->EINVAL
> + * 9) Try to copy contents to a blkdev ->EINVAL
> + * 10) Try to copy contents to a chardev ->EINVAL
> + * 11) Try to copy contents to a FIFO ->EINVAL
> + * 12) Try to copy contents to a file with length beyond
> + *     8EiB wraps around 0 -> EOVERFLOW
> + * 13) Try to copy contents to a file with target file range
> + *     beyond 8TiB ->EFBIG
>   */
>
>  #define _GNU_SOURCE
> @@ -29,30 +39,61 @@
>  static int fd_src;
>  static int fd_dest;
>  static int fd_rdonly;
> -static int fd_mnted;
>  static int fd_dir;
>  static int fd_closed;
>  static int fd_append;
> +static int fd_immutable;
> +static int fd_swapfile;
> +static int fd_dup;
> +static int fd_blkdev;
> +static int fd_chrdev;
> +static int fd_fifo;
> +static int fd_copy;
>
>  static struct tcase {
>         int     *copy_to_fd;
>         int     flags;
>         int     exp_err;
> +       loff_t  dst;
> +       loff_t     len;
>  } tcases[] = {
> -       {&fd_rdonly,    0,      EBADF},
> -       {&fd_mnted,     0,      EXDEV},
> -       {&fd_dir,       0,      EISDIR},
> -       {&fd_append,    0,      EBADF},
> -       {&fd_closed,    0,      EBADF},
> -       {&fd_dest,      -1,     EINVAL},
> +       {&fd_rdonly,    0,   EBADF,      0,     CONTSIZE},
> +       {&fd_dir,       0,   EISDIR,     0,     CONTSIZE},
> +       {&fd_append,    0,   EBADF,      0,     CONTSIZE},
> +       {&fd_closed,    0,   EBADF,      0,     CONTSIZE},
> +       {&fd_dest,      -1,  EINVAL,     0,     CONTSIZE},
> +       {&fd_immutable, 0,   EPERM,      0,     CONTSIZE},
> +       {&fd_swapfile,  0,   ETXTBSY,    0,     CONTSIZE},
> +       {&fd_dup,       0,   EINVAL,     0,     CONTSIZE/2},
> +       {&fd_blkdev,    0,   EINVAL,     0,     CONTSIZE},
> +       {&fd_chrdev,    0,   EINVAL,     0,     CONTSIZE},
> +       {&fd_fifo,      0,   EINVAL,     0,     CONTSIZE},
> +       {&fd_copy,      0,   EOVERFLOW,  MAX_OFF, 2*MAX_LEN},
> +       {&fd_copy,      0,   EFBIG,      MAX_OFF, MIN_OFF},
>  };
>
> +static void run_command(char *command, char *option, char *file)
> +{
> +       const char *const cmd[] = {command, option, file, NULL};
> +       int ret;
> +
> +       ret = tst_run_cmd(cmd, NULL, NULL, 1);
> +       switch (ret) {
> +       case 0:
> +       break;
> +       case 255:
> +               tst_res(TCONF, "%s binary not installed", command);
> +       break;
> +       default:
> +               tst_res(TCONF, "%s exited with %i", command, ret);
> +       }
> +}
> +
>  static void verify_copy_file_range(unsigned int n)
>  {
>         struct tcase *tc = &tcases[n];
> -
>         TEST(sys_copy_file_range(fd_src, 0, *tc->copy_to_fd,
> -                               0, CONTSIZE, tc->flags));
> +                               &tc->dst, tc->len, tc->flags));
>
>         if (TST_RET == -1) {
>                 if (tc->exp_err == TST_ERR) {
> @@ -76,33 +117,81 @@ static void cleanup(void)
>                 SAFE_CLOSE(fd_append);
>         if (fd_dir > 0)
>                 SAFE_CLOSE(fd_dir);
> -       if (fd_mnted > 0)
> -               SAFE_CLOSE(fd_mnted);
>         if (fd_rdonly > 0)
>                 SAFE_CLOSE(fd_rdonly);
>         if (fd_dest > 0)
>                 SAFE_CLOSE(fd_dest);
>         if (fd_src > 0)
>                 SAFE_CLOSE(fd_src);
> +       if (fd_immutable > 0) {
> +               run_command("chattr", "-i", FILE_IMMUTABLE_PATH);
> +               SAFE_CLOSE(fd_immutable);
> +       }
> +       if (fd_swapfile > 0) {
> +               run_command("swapoff", FILE_SWAP_PATH, NULL);
> +               SAFE_CLOSE(fd_swapfile);
> +       }
> +       if (fd_dup > 0)
> +               SAFE_CLOSE(fd_dup);
> +       if (fd_copy > 0)
> +               SAFE_CLOSE(fd_copy);
> +
> +       SAFE_UNLINK(FILE_BLKDEV);
> +       SAFE_UNLINK(FILE_CHRDEV);
> +       SAFE_UNLINK(FILE_FIFO);
>  }
>
>  static void setup(void)
>  {
>         syscall_info();
> +       int swap_flag = 1;
> +       dev_t dev[3];
> +
> +       dev[1] = makedev(7, 3);

You've picked /dev/loop3, which is high likely to be a real device
on a system where this test is run and with release kernel this test
may write over that real device - not a good thing.
My xfstest uses device (7, 123), which has better odds to be unused,
but I think I may switch to a test owned device before proposing the
test for merge.

> +       dev[2] = makedev(7, 4);

Would be safer to use a known device like /dev/null IMO

> +       dev[3] = makedev(7, 5);

dev[3] not needed for S_FIFO

>
>         if (access(FILE_DIR_PATH, F_OK) == -1)
>                 SAFE_MKDIR(FILE_DIR_PATH, 0777);
>
> +       SAFE_MKNOD(FILE_BLKDEV, S_IFBLK | 0777, dev[1]);
> +       SAFE_MKNOD(FILE_CHRDEV, S_IFCHR | 0777, dev[2]);

Would be safer to use a known device like /dev/null IMO

> +       SAFE_MKNOD(FILE_FIFO, S_IFIFO | 0777, dev[3]);
> +
>         fd_src    = SAFE_OPEN(FILE_SRC_PATH, O_RDWR | O_CREAT, 0664);
>         fd_dest   = SAFE_OPEN(FILE_DEST_PATH, O_RDWR | O_CREAT, 0664);
>         fd_rdonly = SAFE_OPEN(FILE_RDONL_PATH, O_RDONLY | O_CREAT, 0664);
> -       fd_mnted  = SAFE_OPEN(FILE_MNTED_PATH, O_RDWR | O_CREAT, 0664);
>         fd_dir    = SAFE_OPEN(FILE_DIR_PATH, O_DIRECTORY);
>         fd_closed = -1;
>         fd_append = SAFE_OPEN(FILE_DEST_PATH,
>                         O_RDWR | O_CREAT | O_APPEND, 0664);
> +       fd_immutable = SAFE_OPEN(FILE_IMMUTABLE_PATH, O_RDWR | O_CREAT, 0664);
> +       fd_swapfile = SAFE_OPEN(FILE_SWAP_PATH, O_RDWR | O_CREAT, 0600);
> +       fd_blkdev = SAFE_OPEN(FILE_BLKDEV, O_RDWR, 0664);
> +       fd_chrdev = SAFE_OPEN(FILE_CHRDEV, O_RDWR, 0664);
> +       fd_fifo = SAFE_OPEN(FILE_FIFO, O_RDWR, 0664);
> +
> +       SAFE_WRITE(1, fd_src, CONTENT, CONTSIZE);
> +       close(fd_src);
> +       fd_src = SAFE_OPEN(FILE_SRC_PATH, O_RDONLY, 0664);
> +       fd_dup = SAFE_OPEN(FILE_SRC_PATH, O_WRONLY|O_CREAT, 0666);
> +
> +       fd_copy = SAFE_OPEN(FILE_COPY_PATH, O_RDWR | O_CREAT | O_TRUNC, 0664);
> +       run_command("chattr", "+i", FILE_IMMUTABLE_PATH);

fs may not support chattr +i. immutable file test case should be
skipped in that case.

>
> -       SAFE_WRITE(1, fd_src,  CONTENT,  CONTSIZE);
> +       if (!tst_fs_has_free(".", sysconf(_SC_PAGESIZE) * 10, TST_BYTES)) {
> +               tst_res(TCONF, "Insufficient disk space to create swap file");
> +               swap_flag = 0;
> +       }
> +
> +       if (tst_fill_file(FILE_SWAP_PATH, 0, sysconf(_SC_PAGESIZE), 10) != 0) {
> +               tst_res(TCONF, "Failed to create swapfile");
> +               swap_flag = 0;
> +       }
> +       if (swap_flag) {
> +               run_command("mkswap", FILE_SWAP_PATH, NULL);
> +               run_command("swapon", FILE_SWAP_PATH, NULL);

fs may not support swap. swapfile test case should be skipped in that case.

Please make sure run your test on release kernel and not only on xfs-next
when you test it.
You may want to run on older kernel with btrfs to see how no support
for swapfiles behaves.

Thanks,
Amir.
