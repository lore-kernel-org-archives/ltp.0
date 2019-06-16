From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 16 Jun 2019 18:11:10 +0300
Subject: [LTP] [PATCH v3 1/3] syscalls/fanotify13: new test to verify
 FAN_REPORT_FID functionality
In-Reply-To: <5a1302c56c25f53395757727ec509169bdd6bc03.1558242368.git.mbobrowski@mbobrowski.org>
References: <cover.1558242368.git.mbobrowski@mbobrowski.org>
 <5a1302c56c25f53395757727ec509169bdd6bc03.1558242368.git.mbobrowski@mbobrowski.org>
Message-ID: <CAOQ4uxi_ZWkihkDZSuVTtNPoKLZ4NEioc6u5hLQeFM=p-_9GFg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sun, May 19, 2019 at 8:25 AM Matthew Bobrowski
<mbobrowski@mbobrowski.org> wrote:
>
> A newly defined test file to validate the fanotify FAN_REPORT_FID
> functionality. A new line entry for this test file has been added within
> runtest/syscalls.
>
> Additionally, defined a helper function that can be used to obtain
> __kernel_fsid_t and file_handle objects. This helper will be used by
> test files related to verifying FAN_REPORT_FID. The name_to_handle_at()
> function is conditionally added to accommodate for builds on older
> distributions.
>
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> ---

Matthew,

Sorry for the delay, I've found some build warning/errors that need fixing.

>  configure.ac                                  |   1 +
>  runtest/syscalls                              |   1 +
>  testcases/kernel/syscalls/fanotify/.gitignore |   1 +
>  testcases/kernel/syscalls/fanotify/fanotify.h |  56 +++-
>  .../kernel/syscalls/fanotify/fanotify13.c     | 313 ++++++++++++++++++
>  5 files changed, 369 insertions(+), 3 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/fanotify/fanotify13.c
>
> diff --git a/configure.ac b/configure.ac
> index 53ad784d7..ac4d85b0e 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -68,6 +68,7 @@ AC_CHECK_FUNCS([ \
>      kcmp \
>      mkdirat \
>      mknodat \
> +    name_to_handle_at \
>      openat \
>      preadv \
>      preadv2 \
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 2b8ca719b..dfdc6cbf9 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -537,6 +537,7 @@ fanotify09 fanotify09
>  fanotify10 fanotify10
>  fanotify11 fanotify11
>  fanotify12 fanotify12
> +fanotify13 fanotify13
>
>  ioperm01 ioperm01
>  ioperm02 ioperm02
> diff --git a/testcases/kernel/syscalls/fanotify/.gitignore b/testcases/kernel/syscalls/fanotify/.gitignore
> index 4256b8cd3..16bdd99e5 100644
> --- a/testcases/kernel/syscalls/fanotify/.gitignore
> +++ b/testcases/kernel/syscalls/fanotify/.gitignore
> @@ -10,4 +10,5 @@
>  /fanotify10
>  /fanotify11
>  /fanotify12
> +/fanotify13
>  /fanotify_child
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> index 14654b7c7..d6e259002 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> @@ -29,6 +29,11 @@
>  #define        __FANOTIFY_H__
>
>  #include "config.h"
> +#include <sys/statfs.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <errno.h>
> +#include <fcntl.h>
>
>  #if defined(HAVE_SYS_FANOTIFY_H)
>
> @@ -57,9 +62,6 @@ static long fanotify_mark(int fd, unsigned int flags, uint64_t mask,
>  #ifndef FAN_REPORT_TID
>  #define FAN_REPORT_TID         0x00000100
>  #endif
> -#ifndef FAN_REPORT_FID
> -#define FAN_REPORT_FID         0x00000200
> -#endif
>
>  #ifndef FAN_MARK_INODE
>  #define FAN_MARK_INODE         0
> @@ -89,6 +91,54 @@ struct fanotify_mark_type {
>         const char * name;
>  };
>
> +#ifndef FAN_REPORT_FID
> +#define FAN_REPORT_FID         0x00000200
> +
> +struct fanotify_event_info_header {
> +       uint8_t info_type;
> +       uint8_t pad;
> +       uint16_t len;
> +};
> +
> +struct fanotify_event_info_fid {
> +       struct fanotify_event_info_header hdr;
> +       __kernel_fsid_t fsid;
> +       unsigned char handle[0];
> +};
> +
> +/*
> + * Helper function used to obtain __kernel_fsid_t and file_handle objects
> + * for a given path. Used by test files correlated to FAN_REPORT_FID
> + * functionality.
> + */
> +static inline void fanotify_get_fid(const char *path, __kernel_fsid_t *fsid,
> +                       struct file_handle *handle)
> +{
> +       int mount_id;
> +       struct statfs stats;
> +
> +       if (statfs(path, &stats) == -1)
> +               tst_brk(TBROK | TERRNO,
> +                       "statfs(%s, ...) failed", path);
> +       memcpy(fsid, &stats.f_fsid, sizeof(stats.f_fsid));
> +
> +#ifdef HAVE_NAME_TO_HANDLE_AT
> +       if (name_to_handle_at(AT_FDCWD, path, handle, &mount_id, 0) == -1) {

name_to_handle_at requires #define _GNU_SOURCE, which are
missing in fanotify05.c and fanotify14.c. Please add the missing
define to those tests
before any includes.

> +               if (errno == EOPNOTSUPP) {
> +                       tst_brk(TCONF,
> +                               "filesystem %s does not support file handles",
> +                               tst_device->fs_type);
> +               }
> +               tst_brk(TBROK | TERRNO,
> +                       "name_to_handle_at(AT_FDCWD, %s, ...) failed", path);
> +       }
> +#else
> +       tst_brk(TCONF, "name_to_handle_at() is not implmented");
> +#endif /* HAVE_NAME_TO_HANDLE_AT */
> +}
> +
> +#endif

The definition of fanotify_get_fid() should be outside
#ifndef FAN_REPORT_FID

Because if new kernel (5.1) headers are installed
fanotify_get_fid() still needs to be defined.

Please fix rebase and re-post the series or ask me to
do it if you are too busy.

Thanks,
Amir.
