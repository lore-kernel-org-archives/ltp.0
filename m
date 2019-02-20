From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 20 Feb 2019 13:57:24 +0530
Subject: [LTP] [PATCH v3 6/7] syscalls/sync_file_range: Use C library
	wrapper if present
In-Reply-To: <20190219141930.GE32031@rei.lan>
References: <1550568500-10871-1-git-send-email-sumit.garg@linaro.org>
 <1550568500-10871-7-git-send-email-sumit.garg@linaro.org>
 <20190219141930.GE32031@rei.lan>
Message-ID: <CAFA6WYP5sYKiEm8wX5FaLzHSJMTQzfUTre_2LrRkNoxDgOurSQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, 19 Feb 2019 at 19:49, Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > diff --git a/configure.ac b/configure.ac
> > index 9122b6d..d15bff3 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -232,6 +232,7 @@ LTP_CHECK_RLIMIT64
> >  LTP_DETECT_HOST_CPU
> >  LTP_CHECK_PERF_EVENT
> >  LTP_CHECK_SYNCFS
> > +LTP_CHECK_SYNC_FILE_RANGE
> >
> >  if test "x$with_numa" = xyes; then
> >       LTP_CHECK_SYSCALL_NUMA
> > diff --git a/include/lapi/sync_file_range.h b/include/lapi/sync_file_range.h
> > new file mode 100644
> > index 0000000..7b0ef69
> > --- /dev/null
> > +++ b/include/lapi/sync_file_range.h
> > @@ -0,0 +1,64 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) International Business Machines  Corp., 2008
> > + */
> > +
> > +#ifndef SYNC_FILE_RANGE_H
> > +#define SYNC_FILE_RANGE_H
> > +
> > +#include <sys/types.h>
> > +#include "config.h"
> > +#include "lapi/syscalls.h"
> > +
> > +#if !defined(HAVE_SYNC_FILE_RANGE)
> > +
> > +#ifdef TST_TEST_H__
> > +# define TST_SYSCALL tst_syscall
> > +#else
> > +# define TST_SYSCALL ltp_syscall
> > +#endif
> > +
> > +/*****************************************************************************
> > + * Wraper function to call sync_file_range system call
> > + ******************************************************************************/
> > +static inline long sync_file_range(int fd, off64_t offset, off64_t nbytes,
> > +                                unsigned int flags)
> > +{
> > +/* arm and powerpc */
> > +#if (defined(__arm__) || defined(__powerpc__) || defined(__powerpc64__))
> > +#if (__WORDSIZE == 32)
> > +#if __BYTE_ORDER == __BIG_ENDIAN
> > +     return TST_SYSCALL(__NR_sync_file_range2, fd, flags,
> > +             (int)(offset >> 32), (int)offset, (int)(nbytes >> 32),
> > +             (int)nbytes);
> > +#elif __BYTE_ORDER == __LITTLE_ENDIAN
> > +     return TST_SYSCALL(__NR_sync_file_range2, fd, flags, (int)offset,
> > +                    (int)(offset >> 32), nbytes, (int)(nbytes >> 32));
> > +#endif
> > +#else
> > +     return TST_SYSCALL(__NR_sync_file_range2, fd, flags, offset, nbytes);
> > +#endif
> > +
> > +/* s390 */
>
> Instead of comment like this the usuall way how to make this maze easier
> to read is to stick spaces after the hash to inner conditions, so this
> would become:
>
> #if (defined(__arm__) || defined (__powerpc__) || defined(__powerpc64__))
> # if (__WORDSIZE == 32)
> #  if __BYTE_ORDER == __BIG_ENDIAN
>         return ...;
> #  elif __BYTE_ORDER == __LITTLE_ENDIAN
>         return ...;
> #  endif
> # else
>         return ...;
> #endif
>

Sure, will remove comments and insert spaces.

>
> > +#elif (defined(__s390__) || defined(__s390x__)) && __WORDSIZE == 32
> > +     return TST_SYSCALL(__NR_sync_file_range, fd, (int)(offset >> 32),
> > +             (int)offset, (int)(nbytes >> 32), (int)nbytes, flags);
> > +
> > +/* mips */
> > +#elif defined(__mips__) && __WORDSIZE == 32
> > +#if __BYTE_ORDER == __BIG_ENDIAN
> > +     return TST_SYSCALL(__NR_sync_file_range, fd, 0, (int)(offset >> 32),
> > +             (int)offset, (int)(nbytes >> 32), (int)nbytes, flags);
> > +#elif __BYTE_ORDER == __LITTLE_ENDIAN
> > +     return TST_SYSCALL(__NR_sync_file_range, fd, 0, (int)offset,
> > +             (int)(offset >> 32), (int)nbytes, (int)(nbytes >> 32), flags);
> > +#endif
> > +
> > +/* other */
> > +#else
> > +     return TST_SYSCALL(__NR_sync_file_range, fd, offset, nbytes, flags);
> > +#endif
> > +}
> > +#endif
>
>
>
> > +#endif /* SYNC_FILE_RANGE_H */
> > diff --git a/m4/ltp-sync_file_range.m4 b/m4/ltp-sync_file_range.m4
> > new file mode 100644
> > index 0000000..b47a091
> > --- /dev/null
> > +++ b/m4/ltp-sync_file_range.m4
> > @@ -0,0 +1,10 @@
> > +dnl SPDX-License-Identifier: GPL-2.0-or-later
> > +dnl Copyright (c) 2019 Linaro Limited. All rights reserved.
> > +
> > +dnl
> > +dnl LTP_CHECK_SYNC_FILE_RANGE
> > +dnl ----------------------------
> > +dnl
> > +AC_DEFUN([LTP_CHECK_SYNC_FILE_RANGE],[
> > +AC_CHECK_FUNCS(sync_file_range,,)
> > +])
> > diff --git a/testcases/kernel/syscalls/sync_file_range/check_sync_file_range.h b/testcases/kernel/syscalls/sync_file_range/check_sync_file_range.h
> > new file mode 100644
> > index 0000000..3d932f6
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/sync_file_range/check_sync_file_range.h
> > @@ -0,0 +1,23 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2019 Linaro Limited. All rights reserved.
> > + * Author: Sumit Garg <sumit.garg@linaro.org>
> > + */
> > +
> > +#ifndef CHECK_SYNC_FILE_RANGE_H
> > +#define CHECK_SYNC_FILE_RANGE_H
> > +
> > +#include <stdbool.h>
> > +
> > +bool check_sync_file_range(void)
> > +{
> > +     int ret;
> > +
> > +     ret = sync_file_range(-1, 0, 0, 0);
> > +     if (ret == -1 && errno == EINVAL)
> > +             return false;
> > +
> > +     return true;
> > +}
>
> I would rather stick to return 0 and return 1 instead of including the
> stdbool, but that is very minor.
>

Ok will use 0 and 1 then.

> > +#endif /* CHECK_SYNC_FILE_RANGE_H */
> > diff --git a/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c b/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c
> > index cebb919..3a97183 100644
> > --- a/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c
> > +++ b/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c
> > @@ -92,7 +92,8 @@
> >  #include <unistd.h>
> >
> >  #include "test.h"
> > -#include "lapi/syscalls.h"
> > +#include "lapi/sync_file_range.h"
> > +#include "check_sync_file_range.h"
> >
> >  #ifndef SYNC_FILE_RANGE_WAIT_BEFORE
> >  #define SYNC_FILE_RANGE_WAIT_BEFORE 1
> > @@ -190,48 +191,6 @@ void setup(void)
> >       sfd = open(spl_file, O_RDWR | O_CREAT, 0700);
> >  }
> >
> > -/*****************************************************************************
> > - * Wraper function to call sync_file_range system call
> > - ******************************************************************************/
> > -static inline long syncfilerange(int fd, off64_t offset, off64_t nbytes,
> > -                              unsigned int flags)
> > -{
> > -/* arm and powerpc */
> > -#if (defined(__arm__) || defined(__powerpc__) || defined(__powerpc64__))
> > -#if (__WORDSIZE == 32)
> > -#if __BYTE_ORDER == __BIG_ENDIAN
> > -     return ltp_syscall(__NR_sync_file_range2, fd, flags,
> > -             (int)(offset >> 32), (int)offset, (int)(nbytes >> 32),
> > -             (int)nbytes);
> > -#elif __BYTE_ORDER == __LITTLE_ENDIAN
> > -     return ltp_syscall(__NR_sync_file_range2, fd, flags, (int)offset,
> > -                    (int)(offset >> 32), nbytes, (int)(nbytes >> 32));
> > -#endif
> > -#else
> > -     return ltp_syscall(__NR_sync_file_range2, fd, flags, offset, nbytes);
> > -#endif
> > -
> > -/* s390 */
> > -#elif (defined(__s390__) || defined(__s390x__)) && __WORDSIZE == 32
> > -     return ltp_syscall(__NR_sync_file_range, fd, (int)(offset >> 32),
> > -             (int)offset, (int)(nbytes >> 32), (int)nbytes, flags);
> > -
> > -/* mips */
> > -#elif defined(__mips__) && __WORDSIZE == 32
> > -#if __BYTE_ORDER == __BIG_ENDIAN
> > -     return ltp_syscall(__NR_sync_file_range, fd, 0, (int)(offset >> 32),
> > -             (int)offset, (int)(nbytes >> 32), (int)nbytes, flags);
> > -#elif __BYTE_ORDER == __LITTLE_ENDIAN
> > -     return ltp_syscall(__NR_sync_file_range, fd, 0, (int)offset,
> > -             (int)(offset >> 32), (int)nbytes, (int)(nbytes >> 32), flags);
> > -#endif
> > -
> > -/* other */
> > -#else
> > -     return ltp_syscall(__NR_sync_file_range, fd, offset, nbytes, flags);
> > -#endif
> > -}
> > -
> >  /******************************************************************************/
> >  /*                                                                       */
> >  /* Function:    main                                                   */
> > @@ -258,24 +217,13 @@ int main(int ac, char **av)
> >
> >       tst_parse_opts(ac, av, NULL, NULL);
> >
> > -#if defined(__powerpc__) || defined(__powerpc64__)   /* for PPC, kernel version > 2.6.21 needed */
> > -     if (tst_kvercmp(2, 16, 22) < 0) {
> > -             tst_brkm(TCONF, NULL,
> > -                      "System doesn't support execution of the test");
> > -     }
> > -#else
> > -     /* For other archs, need kernel version > 2.6.16 */
> > -
> > -     if (tst_kvercmp(2, 6, 17) < 0) {
> > -             tst_brkm(TCONF, NULL,
> > -                      "System doesn't support execution of the test");
> > -     }
> > -#endif
> > +     if (!check_sync_file_range())
> > +             tst_brkm(TCONF, NULL, "sync_file_range() not supported");
> >
> >       setup();
> >
> >       for (test_index = 0; test_index < TST_TOTAL; test_index++) {
> > -             TEST(syncfilerange
> > +             TEST(sync_file_range
> >                    (*(test_data[test_index].fd),
> >                     test_data[test_index].offset,
> >                     test_data[test_index].nbytes,
>
> Other than the minor things, this is great work.
>

Thanks,
-Sumit

> --
> Cyril Hrubis
> chrubis@suse.cz
