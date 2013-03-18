Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <markos.chandras@gmail.com>) id 1UHXiO-0006Df-Nu
	for ltp-list@lists.sourceforge.net; Mon, 18 Mar 2013 10:54:52 +0000
Received: from mail-we0-f181.google.com ([74.125.82.181])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UHXiI-0000L7-D8
	for ltp-list@lists.sourceforge.net; Mon, 18 Mar 2013 10:54:52 +0000
Received: by mail-we0-f181.google.com with SMTP id t44so4734631wey.40
	for <ltp-list@lists.sourceforge.net>;
	Mon, 18 Mar 2013 03:54:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1363603916-4738-1-git-send-email-markos.chandras@gmail.com>
References: <1363603916-4738-1-git-send-email-markos.chandras@gmail.com>
From: Markos Chandras <markos.chandras@gmail.com>
Date: Mon, 18 Mar 2013 10:54:20 +0000
Message-ID: <CAG2jQ8g9WOG+vzCWoaJJoK_8+kjQGcaFQccza3JqmkyejkH03g@mail.gmail.com>
Subject: Re: [LTP] [PATCH v3] syscalls/getdents: Add parameter to test
 getdents64 syscall
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

On 18 March 2013 10:51, Markos Chandras <markos.chandras@gmail.com> wrote:
> From: Markos Chandras <markos.chandras@imgtec.com>
>
> Add new "-l" parameter to test the getdents64 syscall along with
> the getdents one. Use ltp_syscall() to call the system call to get
> proper return values when an architecture does not support any of the
> getdents{,64} syscalls. Modify runtest/syscalls to call getdentsXX tests
> with and without the "-l" parameter
>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>  runtest/syscalls                                |    9 ++++
>  testcases/kernel/syscalls/getdents/Makefile     |    2 +
>  testcases/kernel/syscalls/getdents/getdents.h   |   48 +++++++++++++++++++-
>  testcases/kernel/syscalls/getdents/getdents01.c |   56 +++++++++++++++++------
>  testcases/kernel/syscalls/getdents/getdents02.c |   45 +++++++++++++++----
>  testcases/kernel/syscalls/getdents/getdents03.c |   42 ++++++++++++++---
>  testcases/kernel/syscalls/getdents/getdents04.c |   46 +++++++++++++++----
>  7 files changed, 205 insertions(+), 43 deletions(-)
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index c70bcbd..191ad10 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -331,6 +331,15 @@ getdents03_64 getdents03_64
>  getdents04 getdents04
>  getdents04_64 getdents04_64
>
> +getdents01_long getdents01 -l
> +getdents01_64_long getdents01_64 -l
> +getdents02_long getdents02 -l
> +getdents02_64_long getdents02_64 -l
> +getdents03_long getdents03 -l
> +getdents03_64_long getdents03_64 -l
> +getdents04_long getdents04 -l
> +getdents04_64_long getdents04_64 -l
> +
>  getdomainname01 getdomainname01
>
>  getdtablesize01 getdtablesize01
> diff --git a/testcases/kernel/syscalls/getdents/Makefile b/testcases/kernel/syscalls/getdents/Makefile
> index df7b63f..8334aa7 100644
> --- a/testcases/kernel/syscalls/getdents/Makefile
> +++ b/testcases/kernel/syscalls/getdents/Makefile
> @@ -21,6 +21,8 @@ top_srcdir            ?= ../../../..
>  include $(top_srcdir)/include/mk/testcases.mk
>  include $(abs_srcdir)/../utils/newer_64.mk
>
> +CFLAGS += -D_LARGEFILE64_SOURCE
> +
>  %_64: CPPFLAGS += -D_FILE_OFFSET_BITS=64 -DOFF_T=__off64_t
>
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/getdents/getdents.h b/testcases/kernel/syscalls/getdents/getdents.h
> index 1d5e584..ee19ad0 100644
> --- a/testcases/kernel/syscalls/getdents/getdents.h
> +++ b/testcases/kernel/syscalls/getdents/getdents.h
> @@ -25,10 +25,13 @@
>  #define __GETDENTS_H   1
>
>  #include <dirent.h>
> +#include <features.h>
>  #include <stdio.h>
>  #include <string.h>
>  #include <unistd.h>
>  #include <sys/syscall.h>
> +#include "test.h"
> +#include "linux_syscall_numbers.h"
>
>  /*
>   * The dirent struct that the C library exports is not the same
> @@ -45,6 +48,13 @@ struct linux_dirent {
>         char            d_name[];
>  };
>
> +struct linux_dirent64 {
> +       unsigned long long      d_ino;
> +       long long               d_off;
> +       unsigned short          d_reclen;
> +       char                    d_name[];
> +};
> +
>  static inline int
>  getdents(unsigned int fd, struct dirent *dirp, unsigned int count)
>  {
> @@ -57,7 +67,43 @@ getdents(unsigned int fd, struct dirent *dirp, unsigned int count)
>         unsigned int i;
>
>         ptrs.buf = buf;
> -       ret = syscall(SYS_getdents, fd, buf, count);
> +       ret = ltp_syscall(__NR_getdents, fd, buf, count);
> +       if (ret < 0)
> +               return ret;
> +
> +#define kdircpy(field) memcpy(&dirp[i].field, &ptrs.dirp->field, sizeof(dirp[i].field))
> +
> +       i = 0;
> +       while (i < count && i < ret) {
> +               unsigned long reclen;
> +
> +               kdircpy(d_ino);
> +               kdircpy(d_reclen);
> +               reclen = dirp[i].d_reclen;
> +               kdircpy(d_off);
> +               strcpy(dirp[i].d_name, ptrs.dirp->d_name);
> +
> +               ptrs.buf += reclen;
> +
> +               i += reclen;
> +       }
> +
> +       return ret;
> +}
> +
> +static inline int
> +getdents64(unsigned int fd, struct dirent64 *dirp, unsigned int count)
> +{
> +       union {
> +               struct linux_dirent64 *dirp;
> +               char *buf;
> +       } ptrs;
> +       char buf[count];
> +       long ret;
> +       unsigned int i;
> +
> +       ptrs.buf = buf;
> +       ret = ltp_syscall(__NR_getdents64, fd, buf, count);
>         if (ret < 0)
>                 return ret;
>
> diff --git a/testcases/kernel/syscalls/getdents/getdents01.c b/testcases/kernel/syscalls/getdents/getdents01.c
> index af0ac1a..b9cd28c 100644
> --- a/testcases/kernel/syscalls/getdents/getdents01.c
> +++ b/testcases/kernel/syscalls/getdents/getdents01.c
> @@ -44,10 +44,12 @@
>   *             -f   : Turn off functionality Testing.
>   *            -i n : Execute test n times.
>   *            -I x : Execute test for x seconds.
> + *            -l   : Test the getdents64 system call.
>   *            -P x : Pause for x seconds between iterations.
>   *            -t   : Turn on syscall timing.
>   *
>   * HISTORY
> + *     03/2013 - Added -l option by Markos Chandras
>   *     03/2001 - Written by Wayne Boyer
>   *
>   * RESTRICTIONS
> @@ -71,6 +73,18 @@ void setup(void);
>  char *TCID = "getdents01";
>  int TST_TOTAL = 1;
>
> +static int longsyscall;
> +
> +option_t Options[] = {
> +               {"l", &longsyscall, NULL}, /* -l long option. Tests getdents64 */
> +               {NULL, NULL, NULL}
> +};
> +
> +void help(void)
> +{
> +       printf("  -l      Test the getdents64 system call\n");
> +}
> +
>  int main(int ac, char **av)
>  {
>         int lc;
> @@ -79,13 +93,28 @@ int main(int ac, char **av)
>         int count;
>         size_t size = 0;
>         char *dir_name = NULL;
> -       struct dirent *dirp;
> +       struct dirent64 *dirp64 = NULL;
> +       struct dirent *dirp = NULL;
>
> -       if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
> +       if ((msg = parse_opts(ac, av, Options, &help)) != NULL)
>                 tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
>
>         setup();
>
> +       /*
> +        * Set up count to be equal to the sizeof struct dirent,
> +        * just to pick a decent size.
> +        */
> +       if (longsyscall) {
> +               if ((dirp64 = malloc(sizeof(struct dirent64))) == NULL)
> +                       tst_brkm(TBROK, cleanup, "malloc failed");
> +               count = (int)sizeof(struct dirent64);
> +       } else {
> +               if ((dirp = malloc(sizeof(struct dirent))) == NULL)
> +                       tst_brkm(TBROK, cleanup, "malloc failed");
> +               count = (int)sizeof(struct dirent);
> +       }
> +
>         for (lc = 0; TEST_LOOPING(lc); lc++) {
>                 tst_count = 0;
>
> @@ -93,20 +122,14 @@ int main(int ac, char **av)
>                         tst_brkm(TBROK, cleanup, "Can not get current "
>                                  "directory name");
>
> -               if ((dirp = malloc(sizeof(struct dirent))) == NULL)
> -                       tst_brkm(TBROK, cleanup, "malloc failed");
> -
> -               /*
> -                * Set up count to be equal to the sizeof struct dirent,
> -                * just to pick a decent size.
> -                */
> -
> -               count = (int)sizeof(struct dirent);
> -
>                 if ((fd = open(dir_name, O_RDONLY)) == -1)
>                         tst_brkm(TBROK, cleanup, "open of directory failed");
>
> -               rval = getdents(fd, dirp, count);
> +               if (longsyscall)
> +                       rval = getdents64(fd, dirp64, count);
> +               else
> +                       rval = getdents(fd, dirp, count);
> +
>                 if (rval < 0) {
>
>                         TEST_ERROR_LOG(errno);
> @@ -127,12 +150,15 @@ int main(int ac, char **av)
>                 free(dir_name);
>                 dir_name = NULL;
>
> -               free(dirp);
> -
>                 if ((rval = close(fd)) == -1)
>                         tst_brkm(TBROK, cleanup, "file close failed");
>         }
>
> +       if (longsyscall)
> +               free(dirp64);
> +       else
> +               free(dirp);
> +
>         cleanup();
>
>         tst_exit();
> diff --git a/testcases/kernel/syscalls/getdents/getdents02.c b/testcases/kernel/syscalls/getdents/getdents02.c
> index ee34de2..971b755 100644
> --- a/testcases/kernel/syscalls/getdents/getdents02.c
> +++ b/testcases/kernel/syscalls/getdents/getdents02.c
> @@ -40,10 +40,12 @@
>   *             -e   : Turn on errno logging.
>   *            -i n : Execute test n times.
>   *            -I x : Execute test for x seconds.
> + *            -l   : Test the getdents64 system call.
>   *            -P x : Pause for x seconds between iterations.
>   *            -t   : Turn on syscall timing.
>   *
>   * HISTORY
> + *     03/2013 - Added -l option by Markos Chandras
>   *     03/2001 - Written by Wayne Boyer
>   *
>   * RESTRICTIONS
> @@ -69,6 +71,18 @@ int TST_TOTAL = 1;
>
>  int exp_enos[] = { EBADF, 0 }; /* 0 terminated list of expected errnos */
>
> +static int longsyscall;
> +
> +option_t Options[] = {
> +               {"l", &longsyscall, NULL}, /* -l long option. Tests getdents64 */
> +               {NULL, NULL, NULL}
> +};
> +
> +void help(void)
> +{
> +       printf("  -l      Test the getdents64 system call\n");
> +}
> +
>  int main(int ac, char **av)
>  {
>         int lc;
> @@ -77,13 +91,24 @@ int main(int ac, char **av)
>         int count;
>         size_t size = 0;
>         char *dir_name = NULL;
> -       struct dirent *dirp;
> +       struct dirent64 *dirp64 = NULL;
> +       struct dirent *dirp = NULL;
>
> -       if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
> +       if ((msg = parse_opts(ac, av, Options, &help)) != NULL)
>                 tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
>
>         setup();
>
> +       if (longsyscall) {
> +               if ((dirp64 = malloc(sizeof(struct dirent))) == NULL)
> +                       tst_brkm(TBROK, cleanup, "malloc failed");
> +               count = (int)sizeof(struct dirent64);
> +       } else {
> +               if ((dirp = malloc(sizeof(struct dirent))) == NULL)
> +                       tst_brkm(TBROK, cleanup, "malloc failed");
> +               count = (int)sizeof(struct dirent);
> +       }
> +
>         for (lc = 0; TEST_LOOPING(lc); lc++) {
>                 tst_count = 0;
>
> @@ -91,16 +116,14 @@ int main(int ac, char **av)
>                         tst_brkm(TBROK, cleanup, "Can not get current "
>                                  "directory name");
>
> -               if ((dirp = malloc(sizeof(struct dirent))) == NULL)
> -                       tst_brkm(TBROK, cleanup, "malloc failed");
> -
> -               count = (int)sizeof(struct dirent);
> -
>                 /* set up a bad file descriptor */
>
>                 fd = -5;
>
> -               rval = getdents(fd, dirp, count);
> +               if (longsyscall)
> +                       rval = getdents64(fd, dirp64, count);
> +               else
> +                       rval = getdents(fd, dirp, count);
>
>                 /*
>                  * Hopefully we get an error due to the bad file descriptor.
> @@ -124,9 +147,13 @@ int main(int ac, char **av)
>                 free(dir_name);
>                 dir_name = NULL;
>
> -               free(dirp);
>         }
>
> +       if (longsyscall)
> +               free(dirp64);
> +       else
> +               free(dirp);
> +
>         cleanup();
>
>         tst_exit();
> diff --git a/testcases/kernel/syscalls/getdents/getdents03.c b/testcases/kernel/syscalls/getdents/getdents03.c
> index 700e54b..6b4f88b 100644
> --- a/testcases/kernel/syscalls/getdents/getdents03.c
> +++ b/testcases/kernel/syscalls/getdents/getdents03.c
> @@ -43,10 +43,12 @@
>   *             -e   : Turn on errno logging.
>   *            -i n : Execute test n times.
>   *            -I x : Execute test for x seconds.
> + *            -l   : Test the getdents64 system call.
>   *            -P x : Pause for x seconds between iterations.
>   *            -t   : Turn on syscall timing.
>   *
>   * HISTORY
> + *     03/2013 - Added -l option by Markos Chandras
>   *     03/2001 - Written by Wayne Boyer
>   *
>   * RESTRICTIONS
> @@ -72,6 +74,18 @@ int TST_TOTAL = 1;
>
>  int exp_enos[] = { EINVAL, 0 };        /* 0 terminated list of expected errnos */
>
> +static int longsyscall;
> +
> +option_t Options[] = {
> +               {"l", &longsyscall, NULL}, /* -l long option. Tests getdents64 */
> +               {NULL, NULL, NULL}
> +};
> +
> +void help(void)
> +{
> +       printf("  -l      Test the getdents64 system call\n");
> +}
> +
>  int main(int ac, char **av)
>  {
>         int lc;
> @@ -80,13 +94,22 @@ int main(int ac, char **av)
>         int count;
>         size_t size = 0;
>         char *dir_name = NULL;
> -       struct dirent *dirp;
> +       struct dirent64 *dirp64 = NULL;
> +       struct dirent *dirp = NULL;
>
> -       if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
> +       if ((msg = parse_opts(ac, av, Options, &help)) != NULL)
>                 tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
>
>         setup();
>
> +       if (longsyscall) {
> +               if ((dirp64 = malloc(sizeof(struct dirent64))) == NULL)
> +                       tst_brkm(TBROK, cleanup, "malloc failed");
> +       } else {
> +               if ((dirp = malloc(sizeof(struct dirent))) == NULL)
> +                       tst_brkm(TBROK, cleanup, "malloc failed");
> +       }
> +
>         for (lc = 0; TEST_LOOPING(lc); lc++) {
>                 tst_count = 0;
>
> @@ -94,9 +117,6 @@ int main(int ac, char **av)
>                         tst_brkm(TBROK, cleanup, "Can not get current "
>                                  "directory name");
>
> -               if ((dirp = malloc(sizeof(struct dirent))) == NULL)
> -                       tst_brkm(TBROK, cleanup, "malloc failed");
> -
>                 /* Set count to be very small.  The result should be EINVAL */
>
>                 count = 1;
> @@ -104,7 +124,10 @@ int main(int ac, char **av)
>                 if ((fd = open(dir_name, O_RDONLY)) == -1)
>                         tst_brkm(TBROK, cleanup, "open of directory failed");
>
> -               rval = getdents(fd, dirp, count);
> +               if (longsyscall)
> +                       rval = getdents64(fd, dirp64, count);
> +               else
> +                       rval = getdents(fd, dirp, count);
>
>                 /*
>                  * Hopefully we get an error due to the small buffer.
> @@ -129,12 +152,15 @@ int main(int ac, char **av)
>                 free(dir_name);
>                 dir_name = NULL;
>
> -               free(dirp);
> -
>                 if ((rval = close(fd)) == -1)
>                         tst_brkm(TBROK, cleanup, "fd close failed");
>         }
>
> +       if (longsyscall)
> +               free(dirp64);
> +       else
> +               free(dirp);
> +
>         cleanup();
>
>         tst_exit();
> diff --git a/testcases/kernel/syscalls/getdents/getdents04.c b/testcases/kernel/syscalls/getdents/getdents04.c
> index 89479a4..3dc1030 100644
> --- a/testcases/kernel/syscalls/getdents/getdents04.c
> +++ b/testcases/kernel/syscalls/getdents/getdents04.c
> @@ -43,10 +43,12 @@
>   *             -e   : Turn on errno logging.
>   *            -i n : Execute test n times.
>   *            -I x : Execute test for x seconds.
> + *            -l   : Test the getdents64 system call.
>   *            -P x : Pause for x seconds between iterations.
>   *            -t   : Turn on syscall timing.
>   *
>   * HISTORY
> + *     03/2013 - Added -l option by Markos Chandras
>   *     03/2001 - Written by Wayne Boyer
>   *
>   * RESTRICTIONS
> @@ -73,6 +75,18 @@ int TST_TOTAL = 1;
>
>  int exp_enos[] = { ENOTDIR, 0 };       /* 0 terminated list of expected errnos */
>
> +static int longsyscall;
> +
> +option_t Options[] = {
> +               {"l", &longsyscall, NULL}, /* -l long option. Tests getdents64 */
> +               {NULL, NULL, NULL}
> +};
> +
> +void help(void)
> +{
> +       printf("  -l      Test the getdents64 system call\n");
> +}
> +
>  int main(int ac, char **av)
>  {
>         int lc;
> @@ -80,15 +94,26 @@ int main(int ac, char **av)
>         int count, rval, fd;
>         size_t size = 0;
>         char *dir_name = NULL;
> -       struct dirent *dirp;
>         struct stat *sbuf;
>         char *newfile;
> +       struct dirent64 *dirp64 = NULL;
> +       struct dirent *dirp = NULL;
>
> -       if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
> +       if ((msg = parse_opts(ac, av, Options, &help)) != NULL)
>                 tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
>
>         setup();
>
> +       if (longsyscall) {
> +               if ((dirp64 = malloc(sizeof(struct dirent64))) == NULL)
> +                       tst_brkm(TBROK, cleanup, "malloc failed");
> +               count = (int)sizeof(struct dirent64);
> +       } else {
> +               if ((dirp = malloc(sizeof(struct dirent))) == NULL)
> +                       tst_brkm(TBROK, cleanup, "malloc failed");
> +               count = (int)sizeof(struct dirent);
> +       }
> +
>         for (lc = 0; TEST_LOOPING(lc); lc++) {
>                 tst_count = 0;
>
> @@ -96,11 +121,6 @@ int main(int ac, char **av)
>                         tst_brkm(TBROK, cleanup, "Can not get current "
>                                  "directory name");
>
> -               if ((dirp = malloc(sizeof(struct dirent))) == NULL)
> -                       tst_brkm(TBROK, cleanup, "malloc failed");
> -
> -               count = (int)sizeof(struct dirent);
> -
>                 /* set up some space for a file name */
>                 if ((newfile = malloc(sizeof(char) * 20)) == NULL)
>                         tst_brkm(TBROK, cleanup, "newfile malloc failed");
> @@ -123,7 +143,10 @@ int main(int ac, char **av)
>                 if (S_ISDIR(sbuf->st_mode))
>                         tst_brkm(TBROK, cleanup, "fd is a directory");
>
> -               rval = getdents(fd, dirp, count);
> +               if (longsyscall)
> +                       rval = getdents64(fd, dirp64, count);
> +               else
> +                       rval = getdents(fd, dirp, count);
>
>                 /*
>                  * Calling with a non directory file descriptor should give
> @@ -149,14 +172,17 @@ int main(int ac, char **av)
>                 free(dir_name);
>                 dir_name = NULL;
>
> -               free(dirp);
> -
>                 if ((rval = close(fd)) == -1)
>                         tst_brkm(TBROK, cleanup, "fd close failed");
>                 if ((rval = unlink(newfile)) == -1)
>                         tst_brkm(TBROK, cleanup, "file unlink failed");
>         }
>
> +       if (longsyscall)
> +               free(dirp64);
> +       else
> +               free(dirp);
> +
>         cleanup();
>
>         tst_exit();
> --
> 1.7.1
>
>
>
> ------------------------------------------------------------------------------
> Everyone hates slow websites. So do we.
> Make your web apps faster with AppDynamics
> Download AppDynamics Lite for free today:
> http://p.sf.net/sfu/appdyn_d2d_mar
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

Please ignore this patch. I forgot to fix the Makefile like Mike
suggested. It's fixed in v4.

-- 
Regards,
Markos Chandras

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
