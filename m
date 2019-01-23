From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 23 Jan 2019 09:02:59 +0200
Subject: [LTP] [PATCH 5/5] syscalls/fanotify10: added support for
 FAN_OPEN_EXEC mask
In-Reply-To: <20190122223636.GA1699@lithium.mbobrowski.org>
References: <20190122223636.GA1699@lithium.mbobrowski.org>
Message-ID: <CAOQ4uxia1EUsJrdD=NVhj6RugOazLCoFYdXuUj5nQOxnDfBVFw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jan 23, 2019 at 12:36 AM Matthew Bobrowski
<mbobrowski@mbobrowski.org> wrote:
>
> Additional test cases have been added in order to increase the overall
> test coverage for the newly implemented FAN_OPEN_EXEC event mask.
>

A word for Jan for context (not a must to include this info in commit message)
This extension for mask/ignore_mask combination test exercises the
change that became relevant only after the addition of FAN_OPEN_EXEC:

2d10b23082a7 fanotify: return only user requested event types in event mask

> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  testcases/kernel/syscalls/fanotify/fanotify10.c | 157 ++++++++++++++++++++----
>  1 file changed, 133 insertions(+), 24 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
> index 820c50a8a..2431a9b29 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify10.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
> @@ -22,9 +22,11 @@
>  #include <stdio.h>
>  #include <sys/stat.h>
>  #include <sys/types.h>
> +#include <sys/wait.h>
>  #include <fcntl.h>
>  #include <errno.h>
>  #include <string.h>
> +#include <stdlib.h>
>  #include <sys/mount.h>
>  #include <sys/syscall.h>
>  #include "tst_test.h"
> @@ -56,11 +58,18 @@ static char event_buf[EVENT_BUF_LEN];
>  #define MNT2_PATH "mntpoint"
>  #define FILE_NAME "testfile"
>  #define FILE2_NAME "testfile2"
> +#define TEST_APP "fanotify_child"
> +#define TEST_APP2 "fanotify_child2"
>  #define FILE_PATH MOUNT_PATH"/"FILE_NAME
>  #define FILE2_PATH MOUNT_PATH"/"FILE2_NAME
> +#define FILE_EXEC_PATH MOUNT_PATH"/"TEST_APP
> +#define FILE2_EXEC_PATH MOUNT_PATH"/"TEST_APP2
>  #define FILE_MNT2 MNT2_PATH"/"FILE_NAME
>  #define FILE2_MNT2 MNT2_PATH"/"FILE2_NAME
> +#define FILE_EXEC_PATH2 MNT2_PATH"/"TEST_APP
> +#define FILE2_EXEC_PATH2 MNT2_PATH"/"TEST_APP2
>
> +static pid_t child_pid;
>  static int bind_mount_created;
>
>  enum {
> @@ -82,56 +91,109 @@ static struct tcase {
>         const char *ignore_path;
>         int ignore_mark_type;
>         const char *event_path;
> -       int expect_event;
> +       unsigned long long expected_mask_with_ignore;
> +       unsigned long long expected_mask_without_ignore;
>  } tcases[] = {
>         {
>                 "ignore mount events created on a specific file",
>                 MOUNT_PATH, FANOTIFY_MOUNT,
>                 FILE_MNT2, FANOTIFY_INODE,
> -               FILE_PATH, 0
> +               FILE_PATH, 0, FAN_OPEN
> +       },
> +       {
> +               "ignore exec mount events created on a specific file",
> +               MOUNT_PATH, FANOTIFY_MOUNT,
> +               FILE_EXEC_PATH2, FANOTIFY_INODE,
> +               FILE_EXEC_PATH, FAN_OPEN_EXEC, FAN_OPEN | FAN_OPEN_EXEC
>         },
>         {
>                 "don't ignore mount events created on another file",
>                 MOUNT_PATH, FANOTIFY_MOUNT,
>                 FILE_PATH, FANOTIFY_INODE,
> -               FILE2_PATH, 1
> +               FILE2_PATH, FAN_OPEN, FAN_OPEN
> +       },
> +       {
> +               "don't ignore exec mount events created on another file",
> +               MOUNT_PATH, FANOTIFY_MOUNT,
> +               FILE_EXEC_PATH, FANOTIFY_INODE,
> +               FILE2_EXEC_PATH, FAN_OPEN | FAN_OPEN_EXEC,
> +               FAN_OPEN | FAN_OPEN_EXEC
>         },
>         {
>                 "ignore inode events created on a specific mount point",
>                 FILE_PATH, FANOTIFY_INODE,
>                 MNT2_PATH, FANOTIFY_MOUNT,
> -               FILE_MNT2, 0
> +               FILE_MNT2, 0, FAN_OPEN
> +       },
> +       {
> +               "ignore exec inode events created on a specific mount point",
> +               FILE_EXEC_PATH, FANOTIFY_INODE,
> +               MNT2_PATH, FANOTIFY_MOUNT,
> +               FILE_EXEC_PATH2, FAN_OPEN_EXEC, FAN_OPEN | FAN_OPEN_EXEC
>         },
>         {
>                 "don't ignore inode events created on another mount point",
>                 FILE_MNT2, FANOTIFY_INODE,
>                 MNT2_PATH, FANOTIFY_MOUNT,
> -               FILE_PATH, 1
> +               FILE_PATH, FAN_OPEN, FAN_OPEN
> +       },
> +       {
> +               "don't ignore exec inode events created on another mount point",
> +               FILE_EXEC_PATH2, FANOTIFY_INODE,
> +               MNT2_PATH, FANOTIFY_MOUNT,
> +               FILE_EXEC_PATH, FAN_OPEN | FAN_OPEN_EXEC,
> +               FAN_OPEN | FAN_OPEN_EXEC
>         },
>         {
>                 "ignore fs events created on a specific file",
>                 MOUNT_PATH, FANOTIFY_FILESYSTEM,
>                 FILE_PATH, FANOTIFY_INODE,
> -               FILE_PATH, 0
> +               FILE_PATH, 0, FAN_OPEN
> +       },
> +       {
> +               "ignore exec fs events created on a specific file",
> +               MOUNT_PATH, FANOTIFY_FILESYSTEM,
> +               FILE_EXEC_PATH, FANOTIFY_INODE,
> +               FILE_EXEC_PATH, FAN_OPEN_EXEC, FAN_OPEN | FAN_OPEN_EXEC
>         },
>         {
>                 "don't ignore mount events created on another file",
>                 MOUNT_PATH, FANOTIFY_FILESYSTEM,
>                 FILE_PATH, FANOTIFY_INODE,
> -               FILE2_PATH, 1
> +               FILE2_PATH, FAN_OPEN, FAN_OPEN
> +       },
> +       {
> +               "don't ignore exec mount events created on another file",
> +               MOUNT_PATH, FANOTIFY_FILESYSTEM,
> +               FILE_EXEC_PATH, FANOTIFY_INODE,
> +               FILE2_EXEC_PATH, FAN_OPEN | FAN_OPEN_EXEC,
> +               FAN_OPEN | FAN_OPEN_EXEC
>         },
>         {
>                 "ignore fs events created on a specific mount point",
>                 MOUNT_PATH, FANOTIFY_FILESYSTEM,
>                 MNT2_PATH, FANOTIFY_MOUNT,
> -               FILE_MNT2, 0
> +               FILE_MNT2, 0, FAN_OPEN
> +       },
> +       {
> +               "ignore exec fs events created on a specific mount point",
> +               MOUNT_PATH, FANOTIFY_FILESYSTEM,
> +               MNT2_PATH, FANOTIFY_MOUNT,
> +               FILE_EXEC_PATH2, FAN_OPEN_EXEC, FAN_OPEN | FAN_OPEN_EXEC
>         },
>         {
>                 "don't ignore fs events created on another mount point",
>                 MOUNT_PATH, FANOTIFY_FILESYSTEM,
>                 MNT2_PATH, FANOTIFY_MOUNT,
> -               FILE_PATH, 1
> +               FILE_PATH, FAN_OPEN, FAN_OPEN
>         },
> +       {
> +               "don't ignore exec fs events created on another mount point",
> +               MOUNT_PATH, FANOTIFY_FILESYSTEM,
> +               MNT2_PATH, FANOTIFY_MOUNT,
> +               FILE_EXEC_PATH, FAN_OPEN | FAN_OPEN_EXEC,
> +               FAN_OPEN | FAN_OPEN_EXEC
> +       }
>  };
>
>  static int create_fanotify_groups(unsigned int n)
> @@ -153,7 +215,8 @@ static int create_fanotify_groups(unsigned int n)
>                         /* Add mark for each group */
>                         ret = fanotify_mark(fd_notify[p][i],
>                                             FAN_MARK_ADD | mark->flag,
> -                                           FAN_OPEN, AT_FDCWD, tc->mark_path);
> +                                           tc->expected_mask_without_ignore,
> +                                           AT_FDCWD, tc->mark_path);
>                         if (ret < 0) {
>                                 if (errno == EINVAL &&
>                                     tc->mark_type == FANOTIFY_FILESYSTEM) {
> @@ -161,6 +224,13 @@ static int create_fanotify_groups(unsigned int n)
>                                                 "FAN_MARK_FILESYSTEM not "
>                                                 "supported in kernel?");
>                                         return -1;
> +                               } else if (errno == EINVAL &&
> +                                          tc->expected_mask_without_ignore &
> +                                          FAN_OPEN_EXEC) {
> +                                       tst_res(TCONF,
> +                                               "FAN_OPEN_EXEC not supported "
> +                                               "by kernel?");
> +                                       return -1;
>                                 }
>                                 tst_brk(TBROK | TERRNO,
>                                         "fanotify_mark(%d, FAN_MARK_ADD | %s,"
> @@ -203,14 +273,15 @@ static void cleanup_fanotify_groups(void)
>         }
>  }
>
> -static void verify_event(int group, struct fanotify_event_metadata *event)
> +static void verify_event(int group, struct fanotify_event_metadata *event,
> +                        unsigned long long expected_mask)
>  {
> -       if (event->mask != FAN_OPEN) {
> +       if (event->mask != expected_mask) {
>                 tst_res(TFAIL, "group %d got event: mask %llx (expected %llx) "
>                         "pid=%u fd=%u", group, (unsigned long long)event->mask,
> -                       (unsigned long long)FAN_OPEN,
> +                       (unsigned long long) expected_mask,
>                         (unsigned)event->pid, event->fd);
> -       } else if (event->pid != getpid()) {
> +       } else if (event->pid != child_pid) {
>                 tst_res(TFAIL, "group %d got event: mask %llx pid=%u "
>                         "(expected %u) fd=%u", group,
>                         (unsigned long long)event->mask, (unsigned)event->pid,
> @@ -222,11 +293,38 @@ static void verify_event(int group, struct fanotify_event_metadata *event)
>         }
>  }
>
> +static int generate_event(const char *event_path,
> +                         unsigned long long expected_mask)
> +{
> +       int fd, status;
> +
> +       child_pid = SAFE_FORK();
> +
> +       if (child_pid == 0) {
> +               if (expected_mask & FAN_OPEN_EXEC) {
> +                       SAFE_EXECL(event_path, event_path, NULL);
> +               } else {
> +                       fd = SAFE_OPEN(event_path, O_RDONLY);
> +
> +                       if (fd > 0)
> +                               SAFE_CLOSE(fd);
> +               }
> +
> +               exit(0);
> +       }
> +
> +       SAFE_WAITPID(child_pid, &status, 0);
> +
> +       if (WIFEXITED(status) && WEXITSTATUS(status) == 0)
> +               return 1;
> +       return 0;
> +}
> +
>  static void test_fanotify(unsigned int n)
>  {
>         struct tcase *tc = &tcases[n];
>         struct fanotify_mark_type *mark, *ignore_mark;
> -       int ret, fd;
> +       int ret;
>         unsigned int p, i;
>         struct fanotify_event_metadata *event;
>
> @@ -238,15 +336,13 @@ static void test_fanotify(unsigned int n)
>         mark = &fanotify_mark_types[tc->mark_type];
>         ignore_mark = &fanotify_mark_types[tc->ignore_mark_type];
>
> -       /*
> -        * generate sequence of events
> -        */
> -       fd = SAFE_OPEN(tc->event_path, O_RDONLY);
> -       SAFE_CLOSE(fd);
> +       /* Generate event in child process */
> +       if (!generate_event(tc->event_path, tc->expected_mask_with_ignore))
> +               tst_brk(TBROK, "Child process terminated incorrectly");
>
>         /* First verify all groups without matching ignore mask got the event */
>         for (p = 0; p < FANOTIFY_PRIORITIES; p++) {
> -               if (p > 0 && !tc->expect_event)
> +               if (p > 0 && !tc->expected_mask_with_ignore)
>                         break;
>
>                 for (i = 0; i < GROUPS_PER_PRIO; i++) {
> @@ -273,14 +369,17 @@ static void test_fanotify(unsigned int n)
>                                         i, p, mark->name, ret,
>                                         event->event_len);
>                         } else {
> -                               verify_event(i, event);
> +                               verify_event(i, event, p == 0 ?
> +                                               tc->expected_mask_without_ignore :
> +                                               tc->expected_mask_with_ignore);
>                         }
>                         if (event->fd != FAN_NOFD)
>                                 SAFE_CLOSE(event->fd);
>                 }
>         }
>         /* Then verify all groups with matching ignore mask did got the event */
> -       for (p = 1; p < FANOTIFY_PRIORITIES && !tc->expect_event; p++) {
> +       for (p = 1; p < FANOTIFY_PRIORITIES &&
> +                       !tc->expected_mask_with_ignore; p++) {
>                 for (i = 0; i < GROUPS_PER_PRIO; i++) {
>                         ret = read(fd_notify[p][i], event_buf, EVENT_BUF_LEN);
>                         if (ret == 0) {
> @@ -316,6 +415,9 @@ static void setup(void)
>
>         SAFE_FILE_PRINTF(FILE_PATH, "1");
>         SAFE_FILE_PRINTF(FILE2_PATH, "1");
> +
> +       SAFE_CP(TEST_APP, FILE_EXEC_PATH);
> +       SAFE_CP(TEST_APP, FILE2_EXEC_PATH);
>  }
>
>  static void cleanup(void)
> @@ -326,6 +428,11 @@ static void cleanup(void)
>                 tst_brk(TBROK | TERRNO, "bind umount failed");
>  }
>
> +static const char *const resource_files[] = {
> +       TEST_APP,
> +       NULL
> +};
> +
>  static struct tst_test test = {
>         .test = test_fanotify,
>         .tcnt = ARRAY_SIZE(tcases),
> @@ -334,7 +441,9 @@ static struct tst_test test = {
>         .mount_device = 1,
>         .mntpoint = MOUNT_PATH,
>         .needs_tmpdir = 1,
> -       .needs_root = 1
> +       .needs_root = 1,
> +       .forks_child = 1,
> +       .resource_files = resource_files
>  };
>
>  #else
> --
> 2.16.4
>
>
> --
> Matthew Bobrowski
