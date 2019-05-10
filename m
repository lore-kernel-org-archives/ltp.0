From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 10 May 2019 08:27:35 +0300
Subject: [LTP] [PATCH v4] syscalls/swap{on,
 off}: fail softly if FIBMAP ioctl trial fails
In-Reply-To: <20190510044217.5215-1-xzhou@redhat.com>
References: <CAOQ4uxjDyx7JFBSmkDe-rHNe=NriT710Ldsva=s+HasaDL0CTw@mail.gmail.com>
 <20190510044217.5215-1-xzhou@redhat.com>
Message-ID: <CAOQ4uxi1=Xj59GvyrJf9HiMgGvRYTC8HGG8UOZKz3B8zgGh52g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, May 10, 2019 at 7:42 AM Murphy Zhou <xzhou@redhat.com> wrote:
>
> Add a test helper to do a FIBMAP ioctl test. Remove old fs type whitelist code.

If you wouldn't have just done that it would have been good.
But your patch also changes a lot of the logic and output messages,
which is less good.
For BTRFS, with a kernel that does not support swapon/off, test logic
should have stayed the same and produce more or less the same output.
This would have made review much easier and less chance of breaking things.

> Leave swapoff02 alone because it's permission checking only in it.
>
> Signed-off-by: Murphy Zhou <xzhou@redhat.com>
> ---
> v2:
>   Test FIBMAP instead of fstype whitelist.
> v3:
>   Fix fs_type undeclared in swapoff01.c.
> v4:
>   Fail softly if FIBMAP nit supported, instead of skip entire testcase.
>
>  include/tst_fs.h                              |  5 ++
>  lib/tst_ioctl.c                               | 39 ++++++++++++++
>  testcases/kernel/syscalls/swapoff/swapoff01.c | 46 +++++++++-------
>  testcases/kernel/syscalls/swapoff/swapoff02.c | 10 ----
>  testcases/kernel/syscalls/swapon/swapon01.c   | 23 ++++----
>  testcases/kernel/syscalls/swapon/swapon02.c   | 31 ++++++-----
>  testcases/kernel/syscalls/swapon/swapon03.c   | 52 +++++++++----------
>  7 files changed, 121 insertions(+), 85 deletions(-)
>  create mode 100644 lib/tst_ioctl.c
>
> diff --git a/include/tst_fs.h b/include/tst_fs.h
> index b2b19ada6..423ca82ec 100644
> --- a/include/tst_fs.h
> +++ b/include/tst_fs.h
> @@ -172,6 +172,11 @@ const char **tst_get_supported_fs_types(void);
>   */
>  void tst_fill_fs(const char *path, int verbose);
>
> +/*
> + * test if FIBMAP ioctl is supported
> + */
> +int tst_fibmap(const char *filename, const char *fstype);
> +
>  #ifdef TST_TEST_H__
>  static inline long tst_fs_type(const char *path)
>  {
> diff --git a/lib/tst_ioctl.c b/lib/tst_ioctl.c
> new file mode 100644
> index 000000000..f63eb5565
> --- /dev/null
> +++ b/lib/tst_ioctl.c
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <errno.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/ioctl.h>
> +#include <linux/fs.h>
> +
> +#define TST_NO_DEFAULT_MAIN
> +
> +#include "tst_test.h"
> +
> +int tst_fibmap(const char *filename, const char *fstype)
> +{
> +       /* test if FIBMAP ioctl is supported */
> +       int fd, block = 0;
> +
> +       tst_res(TINFO, "Testing if FIBMAP ioctl is supported on %s", fstype);

passing the fstype into this helper seems quite irrelevant to me.
the TINFO print doesn't justify it IMO
Its not even an important info IMO, so as long as you have the print
when FIBMAP not supported

> +
> +       fd = open(filename, O_RDWR | O_CREAT, 0666);
> +       if (fd < 0) {
> +               tst_res(TWARN | TERRNO,
> +                        "open(%s, O_RDWR | O_CREAT, 0666) failed", filename);
> +               return 1;
> +       }
> +
> +       if (ioctl(fd, FIBMAP, &block)) {
> +               tst_res(TINFO, "FIBMAP ioctl is NOT supported");
> +               close(fd);
> +               return 1;
> +       }
> +       tst_res(TINFO, "FIBMAP ioctl is supported");
> +
> +       if (close(fd)) {
> +               tst_res(TWARN | TERRNO, "close(fd) failed");
> +               return 1;
> +       }
> +       return 0;
> +}
> diff --git a/testcases/kernel/syscalls/swapoff/swapoff01.c b/testcases/kernel/syscalls/swapoff/swapoff01.c
> index a63e661a5..fbce66fc8 100644
> --- a/testcases/kernel/syscalls/swapoff/swapoff01.c
> +++ b/testcases/kernel/syscalls/swapoff/swapoff01.c
> @@ -32,6 +32,7 @@ static void verify_swapoff(void);
>
>  char *TCID = "swapoff01";
>  int TST_TOTAL = 1;
> +int fibmap = 1;
>
>  static long fs_type;
>
> @@ -55,22 +56,26 @@ int main(int ac, char **av)
>  static void verify_swapoff(void)
>  {
>         if (ltp_syscall(__NR_swapon, "./swapfile01", 0) != 0) {
> -               if (fs_type == TST_BTRFS_MAGIC && errno == EINVAL) {
> -                       tst_brkm(TCONF, cleanup,
> -                                "Swapfiles on BTRFS are not implemented");
> +               if (fibmap == 1) {

This changes both logic and output message.
I don't see a good reason for you to do that.
Please keep the errno == EINVAL check and the message format for TCONF case
Same comment for all the other places it applies

> +                       tst_resm(TBROK, "Failed to turn on the swap file"
> +                                ", skipping test iteration");
> +                       return;
> +               } else {
> +                       tst_resm(TCONF, "Failed to turn on the swap file"
> +                                ", keep going for sanity check");
>                 }
> -
> -               tst_resm(TBROK, "Failed to turn on the swap file"
> -                        ", skipping test iteration");
> -               return;
>         }
>
>         TEST(ltp_syscall(__NR_swapoff, "./swapfile01"));
>
>         if (TEST_RETURN == -1) {
> -               tst_resm(TFAIL | TTERRNO, "Failed to turn off swapfile,"
> -                        " system reboot after execution of LTP "
> -                        "test suite is recommended.");
> +               if (fibmap == 1) {

No reason to do that.
If filesystem was already proven to support swpaon(), swapoff() must succeed.
If fs doesn't support swapon(), test should bail out and not try swapoff()

> +                       tst_resm(TFAIL | TTERRNO, "Failed to turn off swapfile,"
> +                                " system reboot after execution of LTP "
> +                                "test suite is recommended.");
> +               } else {
> +                       tst_resm(TCONF, "Failed to turn off swapfile");
> +               }
>         } else {
>                 tst_resm(TPASS, "Succeeded to turn off swapfile");
>         }
> @@ -86,13 +91,11 @@ static void setup(void)
>
>         tst_tmpdir();
>
> -       switch ((fs_type = tst_fs_type(cleanup, "."))) {
> -       case TST_NFS_MAGIC:
> -       case TST_TMPFS_MAGIC:
> -               tst_brkm(TCONF, cleanup,
> -                        "Cannot do swapoff on a file on %s filesystem",
> -                        tst_fs_type_name(fs_type));
> -       break;
> +       fs_type = tst_fs_type(cleanup, ".");
> +       if (tst_fibmap("./tst_fibmap", tst_fs_type_name(fs_type))) {
> +               tst_resm(TCONF,
> +                        "Will not report FAIL as FIBMAP ioctl not supported");

Here printing fs name would be useful IMO

> +               fibmap = 0;
>         }
>
>         if (!tst_fs_has_free(NULL, ".", 64, TST_MB)) {
> @@ -103,8 +106,13 @@ static void setup(void)
>         if (tst_fill_file("swapfile01", 0x00, 1024, 65536))
>                 tst_brkm(TBROK, cleanup, "Failed to create file for swap");
>
> -       if (system("mkswap swapfile01 > tmpfile 2>&1") != 0)
> -               tst_brkm(TBROK, cleanup, "Failed to make swapfile");
> +       if (system("mkswap swapfile01 > tmpfile 2>&1") != 0) {
> +               if (fibmap == 1) {
> +                       tst_brkm(TBROK, cleanup, "Failed to make swapfile");
> +               } else {
> +                       tst_resm(TCONF, "Failed to make swapfile");

You see, this message does not align with the outcome (skip).
Is this really needed? does mkswap fail on tmpfs?
If it does, then surely the entire test can be skipped

> +               }
> +       }
>  }
>
>  static void cleanup(void)
> diff --git a/testcases/kernel/syscalls/swapoff/swapoff02.c b/testcases/kernel/syscalls/swapoff/swapoff02.c
> index b5c6312a1..2267449eb 100644
> --- a/testcases/kernel/syscalls/swapoff/swapoff02.c
> +++ b/testcases/kernel/syscalls/swapoff/swapoff02.c
> @@ -124,7 +124,6 @@ static void cleanup01(void)
>
>  static void setup(void)
>  {
> -       long type;
>         struct passwd *nobody;
>
>         tst_sig(FORK, DEF_HANDLER, cleanup);
> @@ -138,15 +137,6 @@ static void setup(void)
>
>         tst_tmpdir();
>
> -       switch ((type = tst_fs_type(cleanup, "."))) {
> -       case TST_NFS_MAGIC:
> -       case TST_TMPFS_MAGIC:
> -               tst_brkm(TCONF, cleanup,
> -                        "Cannot do swapoff on a file on %s filesystem",
> -                        tst_fs_type_name(type));
> -       break;
> -       }
> -
>         if (!tst_fs_has_free(NULL, ".", 1, TST_KB)) {
>                 tst_brkm(TBROK, cleanup,
>                          "Insufficient disk space to create swap file");
> diff --git a/testcases/kernel/syscalls/swapon/swapon01.c b/testcases/kernel/syscalls/swapon/swapon01.c
> index 32538f82b..0419cae28 100644
> --- a/testcases/kernel/syscalls/swapon/swapon01.c
> +++ b/testcases/kernel/syscalls/swapon/swapon01.c
> @@ -31,6 +31,7 @@ static void cleanup(void);
>
>  char *TCID = "swapon01";
>  int TST_TOTAL = 1;
> +int fibmap = 1;
>
>  static long fs_type;
>
> @@ -39,12 +40,11 @@ static void verify_swapon(void)
>         TEST(ltp_syscall(__NR_swapon, "./swapfile01", 0));
>
>         if (TEST_RETURN == -1) {
> -               if (fs_type == TST_BTRFS_MAGIC && errno == EINVAL) {
> -                       tst_brkm(TCONF, cleanup,
> -                                "Swapfile on BTRFS not implemeted");
> -                       return;
> +               if (fibmap == 0) {
> +                       tst_resm(TCONF, "Failed to turn on swapfile");

Please take care to not change logic.
You replcaed tst_brkm with tst_resm. Intentional?
You also change the meaning of the warning message to the worse IMO

> +               } else {
> +                       tst_resm(TFAIL | TTERRNO, "Failed to turn on swapfile");
>                 }
> -               tst_resm(TFAIL | TTERRNO, "Failed to turn on swapfile");
>         } else {
>                 tst_resm(TPASS, "Succeeded to turn on swapfile");
>                 /*we need to turn this swap file off for -i option */
> @@ -58,7 +58,6 @@ static void verify_swapon(void)
>
>  int main(int ac, char **av)
>  {
> -
>         int lc;
>
>         tst_parse_opts(ac, av, NULL, NULL);
> @@ -84,13 +83,11 @@ static void setup(void)
>
>         tst_tmpdir();
>
> -       switch ((fs_type = tst_fs_type(cleanup, "."))) {
> -       case TST_NFS_MAGIC:
> -       case TST_TMPFS_MAGIC:
> -               tst_brkm(TCONF, cleanup,
> -                        "Cannot do swapon on a file on %s filesystem",
> -                        tst_fs_type_name(fs_type));
> -       break;
> +       fs_type = tst_fs_type(cleanup, ".");
> +       if (tst_fibmap("./tst_fibmap", tst_fs_type_name(fs_type))) {
> +               tst_resm(TCONF,
> +                        "Will not report FAIL as FIBMAP ioctl not supported");
> +               fibmap = 0;
>         }
>
>         make_swapfile(cleanup, "swapfile01");
> diff --git a/testcases/kernel/syscalls/swapon/swapon02.c b/testcases/kernel/syscalls/swapon/swapon02.c
> index 4af5105c6..8120be987 100644
> --- a/testcases/kernel/syscalls/swapon/swapon02.c
> +++ b/testcases/kernel/syscalls/swapon/swapon02.c
> @@ -44,6 +44,7 @@ static void cleanup01(void);
>
>  char *TCID = "swapon02";
>  int TST_TOTAL = 4;
> +int fibmap = 1;
>
>  static uid_t nobody_uid;
>  static int do_swapoff;
> @@ -81,14 +82,15 @@ static void verify_swapon(struct test_case_t *test)
>                 return;
>         }
>
> -       if (fs_type == TST_BTRFS_MAGIC && errno == EINVAL) {
> -               tst_resm(TCONF, "Swapfile on BTRFS not implemeted");
> -                       return;
> +       if (fibmap == 1) {
> +               tst_resm(TFAIL, "swapon(2) failed to produce expected error:"
> +                        " %d, errno: %s and got %d.", test->exp_errno,
> +                        test->exp_errval, TEST_ERRNO);

Changes message

> +       } else {
> +               tst_resm(TCONF, "swapon(2) failed to produce expected error:"
> +                        " %d, errno: %s and got %d.", test->exp_errno,
> +                        test->exp_errval, TEST_ERRNO);
>         }
> -
> -       tst_resm(TFAIL, "swapon(2) failed to produce expected error:"
> -                " %d, errno: %s and got %d.", test->exp_errno,
> -                test->exp_errval, TEST_ERRNO);
>  }
>
>  int main(int ac, char **av)
> @@ -132,13 +134,11 @@ static void setup(void)
>
>         tst_tmpdir();
>
> -       switch ((fs_type = tst_fs_type(cleanup, "."))) {
> -       case TST_NFS_MAGIC:
> -       case TST_TMPFS_MAGIC:
> -               tst_brkm(TCONF, cleanup,
> -                        "Cannot do swapon on a file on %s filesystem",
> -                        tst_fs_type_name(fs_type));
> -       break;
> +       fs_type = tst_fs_type(cleanup, ".");
> +       if (tst_fibmap("./tst_fibmap", tst_fs_type_name(fs_type))) {
> +               tst_resm(TCONF,
> +                        "Will not report FAIL as FIBMAP ioctl not supported");
> +               fibmap = 0;
>         }
>
>         SAFE_TOUCH(cleanup, "notswap", 0777, NULL);
> @@ -146,8 +146,7 @@ static void setup(void)
>         make_swapfile(cleanup, "alreadyused");
>
>         if (ltp_syscall(__NR_swapon, "alreadyused", 0)) {
> -               if (fs_type != TST_BTRFS_MAGIC || errno != EINVAL)
> -                       tst_resm(TWARN | TERRNO, "swapon(alreadyused) failed");
> +               tst_resm(TWARN | TERRNO, "swapon(alreadyused) failed");

Change of logic for fibmap == 0 case

>         } else {
>                 do_swapoff = 1;
>         }
> diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
> index 955ac247b..696d0a3dd 100644
> --- a/testcases/kernel/syscalls/swapon/swapon03.c
> +++ b/testcases/kernel/syscalls/swapon/swapon03.c
> @@ -49,6 +49,7 @@ static int check_and_swapoff(const char *filename);
>
>  char *TCID = "swapon03";
>  int TST_TOTAL = 1;
> +int fibmap = 1;
>
>  static int swapfiles;
>
> @@ -65,6 +66,14 @@ static struct swap_testfile_t {
>
>  int expected_errno = EPERM;
>
> +void record_failure_soft(int flag, char *s, int exp, char *err)
> +{
> +       if (fibmap != 1)
> +               flag = TCONF;
> +
> +       tst_resm(flag, s, exp, err);
> +}
> +
>  int main(int ac, char **av)
>  {
>         int lc;
> @@ -88,10 +97,10 @@ int main(int ac, char **av)
>                         tst_resm(TPASS, "swapon(2) got expected failure (%d),",
>                                  expected_errno);
>                 } else if (TEST_RETURN < 0) {
> -                       tst_resm(TFAIL | TTERRNO,
> +                       record_failure_soft(TFAIL | TTERRNO,
>                                  "swapon(2) failed to produce expected error "
> -                                "(%d). System reboot recommended.",
> -                                expected_errno);
> +                                "(%d), got (%s). System reboot recommended.",
> +                                expected_errno, strerror(TEST_ERRNO));
>                 } else {
>                         /* Probably the system supports MAX_SWAPFILES > 30,
>                          * let's try with MAX_SWAPFILES == 32 */
> @@ -103,8 +112,10 @@ int main(int ac, char **av)
>
>                         /* Check return code (now we're expecting success) */
>                         if (TEST_RETURN < 0) {
> -                               tst_resm(TFAIL | TTERRNO,
> -                                        "swapon(2) got an unexpected failure");
> +                               record_failure_soft(TFAIL | TTERRNO,
> +                                        "swapon(2) got an unexpected failure"
> +                                        "(%d: %s).",
> +                                        TEST_RETURN, strerror(TEST_ERRNO));
>                         } else {
>                                 /* Call swapon sys call once again for 33
>                                  * now we have to receive an error */
> @@ -121,7 +132,7 @@ int main(int ac, char **av)
>                                                  " MAX_SWAPFILES is 32",
>                                                  expected_errno);
>                                 } else {
> -                                       tst_resm(TFAIL,
> +                                       record_failure_soft(TFAIL,
>                                                  "swapon(2) failed to produce"
>                                                  " expected error: %d, got %s."
>                                                  " System reboot after execution of LTP"
> @@ -141,7 +152,6 @@ int main(int ac, char **av)
>
>         cleanup();
>         tst_exit();
> -
>  }
>
>  /*
> @@ -215,9 +225,6 @@ static int setup_swap(void)
>                         /* turn on the swap file */
>                         res = ltp_syscall(__NR_swapon, filename, 0);
>                         if (res != 0) {
> -                               if (fs_type == TST_BTRFS_MAGIC && errno == EINVAL)
> -                                       exit(2);
> -
>                                 if (errno == EPERM) {
>                                         printf("Successfully created %d "
>                                                "swapfiles\n", j);
> @@ -225,7 +232,8 @@ static int setup_swap(void)
>                                 } else {
>                                         printf("Failed to create "
>                                                "swapfile: %s\n", filename);
> -                                       exit(1);
> +                                       if (fibmap == 1)
> +                                               exit(1);
>                                 }
>                         }
>                 }
> @@ -233,15 +241,8 @@ static int setup_swap(void)
>         } else
>                 waitpid(pid, &status, 0);
>
> -       switch (WEXITSTATUS(status)) {
> -       case 0:
> -       break;
> -       case 2:
> -               tst_brkm(TCONF, cleanup, "Swapfile on BTRFS not implemeted");
> -       break;
> -       default:
> +       if (WEXITSTATUS(status)) {
>                 tst_brkm(TFAIL, cleanup, "Failed to setup swaps");
> -       break;
>         }
>
>         /* Create all needed extra swapfiles for testing */
> @@ -249,7 +250,6 @@ static int setup_swap(void)
>                 make_swapfile(cleanup, swap_testfiles[j].filename);
>
>         return 0;
> -
>  }
>
>  /*
> @@ -333,13 +333,11 @@ static void setup(void)
>
>         tst_tmpdir();
>
> -       switch ((fs_type = tst_fs_type(cleanup, "."))) {
> -       case TST_NFS_MAGIC:
> -       case TST_TMPFS_MAGIC:
> -               tst_brkm(TCONF, cleanup,
> -                        "Cannot do swapon on a file on %s filesystem",
> -                        tst_fs_type_name(fs_type));
> -       break;
> +       fs_type = tst_fs_type(cleanup, ".");
> +       if (tst_fibmap("./tst_fibmap", tst_fs_type_name(fs_type))) {
> +               tst_resm(TCONF,
> +                        "Will not report FAIL as FIBMAP ioctl not supported");
> +               fibmap = 0;
>         }
>
>         TEST_PAUSE;
> --
> 2.21.0
>
