From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 25 Jul 2019 08:24:48 +0300
Subject: [LTP] [PATCH v6 3/3] syscalls/copy_file_range02: increase
 coverage and remove EXDEV test
In-Reply-To: <1564030915-3211-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <5D30200B.4050306@cn.fujitsu.com>
 <1564030915-3211-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1564030915-3211-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <CAOQ4uxg-5UUTB6Z=4Ma9+6LkLVnCz6NBFS4=7Zq_pJfNhZFRqA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jul 25, 2019 at 8:02 AM Yang Xu <xuyang2018.jy@cn.fujitsu.com> wrote:
>
> Since Amir patch[1] for copy_file_range has been merged into upstream
> kernel, we should add swapfile, immutable file, bounds tests in ltp.
> Also, add block,char,pipe dev tests and remove EXDEV test(the cross-device
> constraint has been relaxed since[2]). I follow xfstests code[3].
>
> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=96e6e8f4a
> [2]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5dae222a5
> [3]https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/tests/generic/553{554,564,565}
>
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>
> ----
> v5->v6:
>    1)directly use the tst_find_free_loopdev filling dev_path
>    2)use TST_ABI64 instead of __WORDSIZE == 64
> ---
>  include/lapi/fs.h                             |   8 +
>  .../copy_file_range/copy_file_range.h         |  13 +-
>  .../copy_file_range/copy_file_range02.c       | 145 +++++++++++++++---
>  3 files changed, 145 insertions(+), 21 deletions(-)
>
> diff --git a/include/lapi/fs.h b/include/lapi/fs.h
> index 42cb4f9b2..708cb8902 100644
> --- a/include/lapi/fs.h
> +++ b/include/lapi/fs.h
> @@ -7,6 +7,7 @@
>  #ifdef HAVE_LINUX_FS_H
>  # include <linux/fs.h>
>  #endif
> +# include "lapi/abisize.h"
>
>  #ifndef LAPI_FS_H
>  #define LAPI_FS_H
> @@ -35,4 +36,11 @@
>  #define FS_NODUMP_FL      0x00000040 /* do not dump file */
>  #endif
>
> +/* Referred form linux kernel include/linux/fs.h */
> +#ifdef TST_ABI64
> + #define MAX_LFS_FILESIZE   ((loff_t)LLONG_MAX)
> +#else
> + #define MAX_LFS_FILESIZE   ((loff_t)ULONG_MAX << PAGE_SHIFT)
> +#endif
> +
>  #endif
> diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range.h b/testcases/kernel/syscalls/copy_file_range/copy_file_range.h
> index b6d132978..c7f423e45 100644
> --- a/testcases/kernel/syscalls/copy_file_range/copy_file_range.h
> +++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range.h
> @@ -9,7 +9,10 @@
>
>  #include <stdbool.h>
>  #include <unistd.h>
> +#include <sys/sysmacros.h>
> +#include <limits.h>
>  #include "lapi/syscalls.h"
> +#include "lapi/fs.h"
>
>  #define TEST_VARIANTS  2
>
> @@ -18,10 +21,18 @@
>  #define FILE_DEST_PATH  "file_dest"
>  #define FILE_RDONL_PATH "file_rdonl"
>  #define FILE_DIR_PATH  "file_dir"
> -#define FILE_MNTED_PATH        MNTPOINT"/file_mnted"
> +#define FILE_MNTED_PATH  MNTPOINT"/file_mnted"
> +#define FILE_IMMUTABLE_PATH "file_immutable"
> +#define FILE_SWAP_PATH "file_swap"
> +#define FILE_CHRDEV    "/dev/null"
> +#define FILE_FIFO      "file_fifo"
> +#define FILE_COPY_PATH  "file_copy"
>
>  #define CONTENT                "ABCDEFGHIJKLMNOPQRSTUVWXYZ12345\n"
>  #define CONTSIZE       (sizeof(CONTENT) - 1)
> +#define MAX_LEN   MAX_LFS_FILESIZE
> +#define MIN_OFF   65537
> +#define MAX_OFF   (MAX_LEN - MIN_OFF)
>
>  static void syscall_info(void)
>  {
> diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
> index 07c0207c2..36976156e 100644
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
> + *     16EiB wraps around 0 -> EOVERFLOW
> + * 13) Try to copy contents to a file with target file range
> + *     beyond maximum supported file size ->EFBIG
>   */
>
>  #define _GNU_SOURCE
> @@ -29,30 +39,78 @@
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
> +
> +static int chattr_i_nsup;
> +static int swap_nsup;
> +static int loop_devn;
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
> +       {&fd_copy,      0,   EOVERFLOW,  MAX_OFF, ULLONG_MAX},
> +       {&fd_copy,      0,   EFBIG,      MAX_OFF, MIN_OFF},
>  };
>
> +static int run_command(char *command, char *option, char *file)
> +{
> +       const char *const cmd[] = {command, option, file, NULL};
> +       int ret;
> +
> +       ret = tst_run_cmd(cmd, NULL, NULL, 1);
> +       switch (ret) {
> +       case 0:
> +       return 0;
> +       case 255:
> +               tst_res(TCONF, "%s binary not installed", command);
> +       return 1;
> +       default:
> +               tst_res(TCONF, "%s exited with %i", command, ret);
> +       return 2;
> +       }
> +}
> +
>  static void verify_copy_file_range(unsigned int n)
>  {
>         struct tcase *tc = &tcases[n];
> -
> +       if (tc->copy_to_fd == &fd_immutable && chattr_i_nsup) {
> +               tst_res(TCONF, "filesystem doesn't support chattr +i, skip it");
> +               return;
> +       }
> +       if (tc->copy_to_fd == &fd_swapfile && swap_nsup) {
> +               tst_res(TCONF, "filesystem doesn't support swapfile, skip it");
> +               return;
> +       }
> +       if (tc->copy_to_fd == &fd_blkdev && loop_devn == -1) {
> +               tst_res(TCONF, "filesystem doesn't have free loopdev, skip it");
> +               return;
> +       }
>         TEST(sys_copy_file_range(fd_src, 0, *tc->copy_to_fd,
> -                               0, CONTSIZE, tc->flags));
> +                               &tc->dst, tc->len, tc->flags));
>
>         if (TST_RET == -1) {
>                 if (tc->exp_err == TST_ERR) {
> @@ -76,33 +134,80 @@ static void cleanup(void)
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
> +       SAFE_UNLINK(FILE_FIFO);
>  }
>
>  static void setup(void)
>  {
>         syscall_info();
> +       char dev_path[1024];

Why? What is the point of filling this string if you're not going to
use it. That's exactly what tst_find_free_loopdev(NULL, 0) is for.
I don't think you understood Cyril's comment about the API
correctly.
He meant he rather keep the *option* in the API to fill out the
suggested loopdev file name. Not that you *have* to fill it.

Thanks,
Amir.



>
>         if (access(FILE_DIR_PATH, F_OK) == -1)
>                 SAFE_MKDIR(FILE_DIR_PATH, 0777);
> +       /*
> +        * call tst_find_free_loopdev(), avoid overwriting its
> +        * content on used loopdev.
> +        */
> +       loop_devn = tst_find_free_loopdev(dev_path, sizeof(dev_path));
> +
> +       SAFE_MKNOD(FILE_FIFO, S_IFIFO | 0777, 0);
>
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
> +
> +       if (loop_devn == -1)
> +               fd_blkdev = SAFE_OPEN(dev_path, O_RDWR, 0600);
> +
> +       fd_chrdev = SAFE_OPEN(FILE_CHRDEV, O_RDWR, 0600);
> +       fd_fifo = SAFE_OPEN(FILE_FIFO, O_RDWR, 0600);
> +
> +       SAFE_WRITE(1, fd_src, CONTENT, CONTSIZE);
> +       close(fd_src);
> +       fd_src = SAFE_OPEN(FILE_SRC_PATH, O_RDONLY, 0664);
> +       fd_dup = SAFE_OPEN(FILE_SRC_PATH, O_WRONLY|O_CREAT, 0666);
> +
> +       fd_copy = SAFE_OPEN(FILE_COPY_PATH, O_RDWR | O_CREAT | O_TRUNC, 0664);
> +       chattr_i_nsup = run_command("chattr", "+i", FILE_IMMUTABLE_PATH);
> +
> +       if (!tst_fs_has_free(".", sysconf(_SC_PAGESIZE) * 10, TST_BYTES)) {
> +               tst_res(TCONF, "Insufficient disk space to create swap file");
> +               swap_nsup = 3;
> +               return;
> +       }
> +
> +       if (tst_fill_file(FILE_SWAP_PATH, 0, sysconf(_SC_PAGESIZE), 10) != 0) {
> +               tst_res(TCONF, "Failed to create swapfile");
> +               swap_nsup = 4;
> +               return;
> +       }
>
> -       SAFE_WRITE(1, fd_src,  CONTENT,  CONTSIZE);
> +       swap_nsup = run_command("mkswap", FILE_SWAP_PATH, NULL);
> +       swap_nsup = run_command("swapon", FILE_SWAP_PATH, NULL);
>  }
>
>  static struct tst_test test = {
> @@ -113,6 +218,6 @@ static struct tst_test test = {
>         .needs_root = 1,
>         .mount_device = 1,
>         .mntpoint = MNTPOINT,
> -       .dev_fs_type = "ext4",
> +       .all_filesystems = 1,
>         .test_variants = TEST_VARIANTS,
>  };
> --
> 2.18.1
>
>
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
