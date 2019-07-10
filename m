From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 10 Jul 2019 17:31:06 +0800
Subject: [LTP] [PATCH v3 3/3] syscalls/copy_file_range02: increase
 coverage and remove EXDEV test
In-Reply-To: <CAOQ4uxhGnVxYyNFmqiJUxfQesnWGhqwdLB88CyiCUFMJx8ybFA@mail.gmail.com>
References: <CAOQ4uxhjbaszcCL0=QAncBT3PzqJR_7oyR+_0-zNa-pt6JNQSA@mail.gmail.com>
 <1562743104-2705-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1562743104-2705-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAOQ4uxhGnVxYyNFmqiJUxfQesnWGhqwdLB88CyiCUFMJx8ybFA@mail.gmail.com>
Message-ID: <5D25B05A.8000600@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

on 2019/07/10 15:57, Amir Goldstein wrote:
> On Wed, Jul 10, 2019 at 10:18 AM Yang Xu<xuyang2018.jy@cn.fujitsu.com>  wrote:
>> Since Amir patch[1] for copy_file_range has been merged into linux-xfs for
>> next branch, I want to add test for swapfile, immutable file, bounds in ltp.
>> Also, add test for block,char,pipe dev and remove EXDEV test(5.3 will relax
>> the cross-device constraint[2]).  I follow xfstests code[3][4][5].
>>
>> [1]https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/commit/?h=for-next&id=96e6e8f
>> [2]https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/commit/?h=for-next&id=5dae222
>> [3]https://patchwork.kernel.org/patch/10971759/
>> [4]https://patchwork.kernel.org/patch/10971747/
>> [5]https://patchwork.kernel.org/patch/10961421/
>>
>> Signed-off-by: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
> A few documentation nits below, otherwise you may add:
>
> Reviewed-by: Amir Goldstein<amir73il@gmail.com>
>
>> ---
>>   .../copy_file_range/copy_file_range.h         |  20 ++-
>>   .../copy_file_range/copy_file_range02.c       | 142 +++++++++++++++---
>>   2 files changed, 141 insertions(+), 21 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range.h b/testcases/kernel/syscalls/copy_file_range/copy_file_range.h
>> index b6d132978..2a9eec75d 100644
>> --- a/testcases/kernel/syscalls/copy_file_range/copy_file_range.h
>> +++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range.h
>> @@ -9,6 +9,8 @@
>>
>>   #include<stdbool.h>
>>   #include<unistd.h>
>> +#include<sys/sysmacros.h>
>> +#include<limits.h>
>>   #include "lapi/syscalls.h"
>>
>>   #define TEST_VARIANTS  2
>> @@ -18,11 +20,27 @@
>>   #define FILE_DEST_PATH  "file_dest"
>>   #define FILE_RDONL_PATH "file_rdonl"
>>   #define FILE_DIR_PATH  "file_dir"
>> -#define FILE_MNTED_PATH        MNTPOINT"/file_mnted"
>> +#define FILE_MNTED_PATH  MNTPOINT"/file_mnted"
>> +#define FILE_IMMUTABLE_PATH "file_immutable"
>> +#define FILE_SWAP_PATH "file_swap"
>> +#define FILE_BLKDEV    "file_blk"
>> +#define FILE_CHRDEV    "/dev/null"
>> +#define FILE_FIFO      "file_fifo"
>> +#define FILE_COPY_PATH  "file_copy"
>>
>>   #define CONTENT                "ABCDEFGHIJKLMNOPQRSTUVWXYZ12345\n"
>>   #define CONTSIZE       (sizeof(CONTENT) - 1)
>>
> Worth a comment where of file this was copied from
> and might be better to put it in some common header file
>
OK.  I will add a comment for this and move it  include/lapi/fs.h, as below:

diff --git a/include/lapi/fs.h b/include/lapi/fs.h
index 42cb4f9b2..d5a78e46b 100644
--- a/include/lapi/fs.h
+++ b/include/lapi/fs.h
@@ -35,4 +35,11 @@
  #define FS_NODUMP_FL      0x00000040 /* do not dump file */
  #endif

+/* Referred form linux kernel include/linux/fs.h */
+#if __WORDSIZE == 64
+        #define MAX_LFS_FILESIZE        ((loff_t)LLONG_MAX)
+#else
+        #define MAX_LFS_FILESIZE        ((loff_t)ULONG_MAX<<  PAGE_SHIFT)
+#endif
+
  #endif


>> +#if __WORDSIZE == 64
>> +       #define MAX_LFS_FILESIZE        ((loff_t)LLONG_MAX)
>> +#else
>> +       #define MAX_LFS_FILESIZE        ((loff_t)ULONG_MAX<<  PAGE_SHIFT)
>> +#endif
>> +
>> +#define MAX_LEN   MAX_LFS_FILESIZE
>> +#define MIN_OFF   65537
>> +#define MAX_OFF   (MAX_LEN - MIN_OFF)
>> +
>>   static void syscall_info(void)
>>   {
>>          switch (tst_variant) {
>> diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
>> index 07c0207c2..abe6d5751 100644
>> --- a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
>> +++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
>> @@ -10,15 +10,25 @@
>>    *
>>    * 1) Try to copy contents to file open as readonly
>>    *    ->  EBADF
>> - * 2) Try to copy contents to file on different mounted
>> - *    filesystem ->  EXDEV
>> - * 3) Try to copy contents to directory ->  EISDIR
>> - * 4) Try to copy contents to a file opened with the
>> + * 2) Try to copy contents to directory ->  EISDIR
>> + * 3) Try to copy contents to a file opened with the
>>    *    O_APPEND flag ->  EBADF
>> - * 5) Try to copy contents to closed filedescriptor
>> + * 4) Try to copy contents to closed filedescriptor
>>    *    ->  EBADF
>> - * 6) Try to copy contents with invalid 'flags' value
>> + * 5) Try to copy contents with invalid 'flags' value
>>    *    ->  EINVAL
>> + * 6) Try to copy contents to a file chattred with +i
>> + *    flag ->  EPERM
>> + * 7) Try to copy contents to a swapfile ->ETXTBSY
>> + * 8) Try to copy contents to the samefile with overlapping
>> + *    ->EINVAL
>> + * 9) Try to copy contents to a blkdev ->EINVAL
>> + * 10) Try to copy contents to a chardev ->EINVAL
>> + * 11) Try to copy contents to a FIFO ->EINVAL
>> + * 12) Try to copy contents to a file with length beyond
>> + *     16EiB wraps around 0 ->  EOVERFLOW
> Rephrase for description to be correct also on 32bit
> BTW, I don't think current definition of 2*MAX_LEN
> actually overflows on 32bit?
  in mm/filemap.c

     /* Ensure offsets don't wrap. */
+       if (pos_in + count<  pos_in || pos_out + count<  pos_out)
+               return -EOVERFLOW;

these variables are long long or uint64_t,  so we should set tc->len as ULLONG_MAX if we want to
trigger the EOVERFLOW on 32bit or 64bit.   as below

	static struct tcase {
		.....
	} tcases[] = {
		....
  	{&fd_copy,      0,   EOVERFLOW,  MAX_OFF, ULLONG_MAX},
	.....

How about it?


>> + * 13) Try to copy contents to a file with target file range
>> + *     beyond 8EiB ->EFBIG
> Rephrase: beyond maximum supported file size
OK.
>>    */
>>
>>   #define _GNU_SOURCE
>> @@ -29,30 +39,78 @@
>>   static int fd_src;
>>   static int fd_dest;
>>   static int fd_rdonly;
>> -static int fd_mnted;
>>   static int fd_dir;
>>   static int fd_closed;
>>   static int fd_append;
>> +static int fd_immutable;
>> +static int fd_swapfile;
>> +static int fd_dup;
>> +static int fd_blkdev;
>> +static int fd_chrdev;
>> +static int fd_fifo;
>> +static int fd_copy;
>> +
>> +static int chattr_i_nsup;
>> +static int swap_nsup;
>> +static int loop_devn;
>>
>>   static struct tcase {
>>          int     *copy_to_fd;
>>          int     flags;
>>          int     exp_err;
>> +       loff_t  dst;
>> +       loff_t     len;
>>   } tcases[] = {
>> -       {&fd_rdonly,    0,      EBADF},
>> -       {&fd_mnted,     0,      EXDEV},
>> -       {&fd_dir,       0,      EISDIR},
>> -       {&fd_append,    0,      EBADF},
>> -       {&fd_closed,    0,      EBADF},
>> -       {&fd_dest,      -1,     EINVAL},
>> +       {&fd_rdonly,    0,   EBADF,      0,     CONTSIZE},
>> +       {&fd_dir,       0,   EISDIR,     0,     CONTSIZE},
>> +       {&fd_append,    0,   EBADF,      0,     CONTSIZE},
>> +       {&fd_closed,    0,   EBADF,      0,     CONTSIZE},
>> +       {&fd_dest,      -1,  EINVAL,     0,     CONTSIZE},
>> +       {&fd_immutable, 0,   EPERM,      0,     CONTSIZE},
>> +       {&fd_swapfile,  0,   ETXTBSY,    0,     CONTSIZE},
>> +       {&fd_dup,       0,   EINVAL,     0,     CONTSIZE/2},
>> +       {&fd_blkdev,    0,   EINVAL,     0,     CONTSIZE},
>> +       {&fd_chrdev,    0,   EINVAL,     0,     CONTSIZE},
>> +       {&fd_fifo,      0,   EINVAL,     0,     CONTSIZE},
>> +       {&fd_copy,      0,   EOVERFLOW,  MAX_OFF, 2*MAX_LEN},
>> +       {&fd_copy,      0,   EFBIG,      MAX_OFF, MIN_OFF},
>>   };
>>
>> +static int run_command(char *command, char *option, char *file)
>> +{
>> +       const char *const cmd[] = {command, option, file, NULL};
>> +       int ret;
>> +
>> +       ret = tst_run_cmd(cmd, NULL, NULL, 1);
>> +       switch (ret) {
>> +       case 0:
>> +       return 0;
>> +       case 255:
>> +               tst_res(TCONF, "%s binary not installed", command);
>> +       return 1;
>> +       default:
>> +               tst_res(TCONF, "%s exited with %i", command, ret);
>> +       return 2;
>> +       }
>> +}
>> +
>>   static void verify_copy_file_range(unsigned int n)
>>   {
>>          struct tcase *tc =&tcases[n];
>> -
>> +       if (tc->copy_to_fd ==&fd_immutable&&  chattr_i_nsup) {
>> +               tst_res(TCONF, "filesystem doesn't support chattr +i, skip it");
>> +               return;
>> +       }
>> +       if (tc->copy_to_fd ==&fd_swapfile&&  swap_nsup) {
>> +               tst_res(TCONF, "filesystem doesn't support swapfile, skip it");
>> +               return;
>> +       }
>> +       if (tc->copy_to_fd ==&fd_blkdev&&  loop_devn == -1) {
>> +               tst_res(TCONF, "filesystem doesn't have free loopdev, skip it");
>> +               return;
>> +       }
>>          TEST(sys_copy_file_range(fd_src, 0, *tc->copy_to_fd,
>> -                               0, CONTSIZE, tc->flags));
>> +&tc->dst, tc->len, tc->flags));
>>
>>          if (TST_RET == -1) {
>>                  if (tc->exp_err == TST_ERR) {
>> @@ -76,14 +134,27 @@ static void cleanup(void)
>>                  SAFE_CLOSE(fd_append);
>>          if (fd_dir>  0)
>>                  SAFE_CLOSE(fd_dir);
>> -       if (fd_mnted>  0)
>> -               SAFE_CLOSE(fd_mnted);
>>          if (fd_rdonly>  0)
>>                  SAFE_CLOSE(fd_rdonly);
>>          if (fd_dest>  0)
>>                  SAFE_CLOSE(fd_dest);
>>          if (fd_src>  0)
>>                  SAFE_CLOSE(fd_src);
>> +       if (fd_immutable>  0) {
>> +               run_command("chattr", "-i", FILE_IMMUTABLE_PATH);
>> +               SAFE_CLOSE(fd_immutable);
>> +       }
>> +       if (fd_swapfile>  0) {
>> +               run_command("swapoff", FILE_SWAP_PATH, NULL);
>> +               SAFE_CLOSE(fd_swapfile);
>> +       }
>> +       if (fd_dup>  0)
>> +               SAFE_CLOSE(fd_dup);
>> +       if (loop_devn>= 0)
>> +               SAFE_UNLINK(FILE_BLKDEV);
>> +       if (fd_copy>  0)
>> +               SAFE_CLOSE(fd_copy);
>> +       SAFE_UNLINK(FILE_FIFO);
>>   }
>>
>>   static void setup(void)
>> @@ -93,16 +164,47 @@ static void setup(void)
>>          if (access(FILE_DIR_PATH, F_OK) == -1)
>>                  SAFE_MKDIR(FILE_DIR_PATH, 0777);
>>
>> +       loop_devn = find_free_loopdev();
>> +       if (loop_devn>= 0)
>> +               SAFE_MKNOD(FILE_BLKDEV, S_IFBLK | 0777, makedev(7, loop_devn));
>> +
> This can raise eyebrows - worth a comment that we want to create a
> non-instantiated loop device
OK. I wiil add a comment for this.

>> +       SAFE_MKNOD(FILE_FIFO, S_IFIFO | 0777, 0);
>> +
>>          fd_src    = SAFE_OPEN(FILE_SRC_PATH, O_RDWR | O_CREAT, 0664);
>>          fd_dest   = SAFE_OPEN(FILE_DEST_PATH, O_RDWR | O_CREAT, 0664);
>>          fd_rdonly = SAFE_OPEN(FILE_RDONL_PATH, O_RDONLY | O_CREAT, 0664);
>> -       fd_mnted  = SAFE_OPEN(FILE_MNTED_PATH, O_RDWR | O_CREAT, 0664);
>>          fd_dir    = SAFE_OPEN(FILE_DIR_PATH, O_DIRECTORY);
>>          fd_closed = -1;
>>          fd_append = SAFE_OPEN(FILE_DEST_PATH,
>>                          O_RDWR | O_CREAT | O_APPEND, 0664);
>> +       fd_immutable = SAFE_OPEN(FILE_IMMUTABLE_PATH, O_RDWR | O_CREAT, 0664);
>> +       fd_swapfile = SAFE_OPEN(FILE_SWAP_PATH, O_RDWR | O_CREAT, 0600);
>> +       fd_blkdev = SAFE_OPEN(FILE_BLKDEV, O_RDWR, 0600);
>> +       fd_chrdev = SAFE_OPEN(FILE_CHRDEV, O_RDWR, 0600);
>> +       fd_fifo = SAFE_OPEN(FILE_FIFO, O_RDWR, 0600);
>> +
>> +       SAFE_WRITE(1, fd_src, CONTENT, CONTSIZE);
>> +       close(fd_src);
>> +       fd_src = SAFE_OPEN(FILE_SRC_PATH, O_RDONLY, 0664);
>> +       fd_dup = SAFE_OPEN(FILE_SRC_PATH, O_WRONLY|O_CREAT, 0666);
>> +
>> +       fd_copy = SAFE_OPEN(FILE_COPY_PATH, O_RDWR | O_CREAT | O_TRUNC, 0664);
>> +       chattr_i_nsup = run_command("chattr", "+i", FILE_IMMUTABLE_PATH);
>> +
>> +       if (!tst_fs_has_free(".", sysconf(_SC_PAGESIZE) * 10, TST_BYTES)) {
>> +               tst_res(TCONF, "Insufficient disk space to create swap file");
>> +               swap_nsup = 3;
>> +               return;
>> +       }
>> +
>> +       if (tst_fill_file(FILE_SWAP_PATH, 0, sysconf(_SC_PAGESIZE), 10) != 0) {
>> +               tst_res(TCONF, "Failed to create swapfile");
>> +               swap_nsup = 4;
>> +               return;
>> +       }
>>
>> -       SAFE_WRITE(1, fd_src,  CONTENT,  CONTSIZE);
>> +       swap_nsup = run_command("mkswap", FILE_SWAP_PATH, NULL);
>> +       swap_nsup = run_command("swapon", FILE_SWAP_PATH, NULL);
>>   }
>>
>>   static struct tst_test test = {
>> @@ -113,6 +215,6 @@ static struct tst_test test = {
>>          .needs_root = 1,
>>          .mount_device = 1,
>>          .mntpoint = MNTPOINT,
>> -       .dev_fs_type = "ext4",
>> +       .all_filesystems = 1,
>>          .test_variants = TEST_VARIANTS,
>>   };
>> --
>> 2.18.1
>>
>>
>>
>
> .
>



