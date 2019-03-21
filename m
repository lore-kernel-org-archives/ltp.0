From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 21 Mar 2019 17:49:57 +0100
Subject: [LTP] [PATCH 1/1] lapi: Add wordsize.h and use it
In-Reply-To: <20190320220804.31736-1-petr.vorel@gmail.com>
References: <20190320220804.31736-1-petr.vorel@gmail.com>
Message-ID: <20190321164956.GA23647@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> not sure if it's a good approach, Cyril suggested to implement it in
> include/lapi/abisize.h, so maybe my changes should be in abisize.h.

Maybe we should use __LP64__ instead.

But I guess that the safest option would be defining new constants
somewhere in lapi/abisize.h that could be then used in tests.

Something as:

#ifdef __LP64__
# define TST_ABI64
#else
# define TST_ABI32
#endif

> 
> PS: I found and fix this error independently and use different approach,
> but first it was reported by Dengke Du in PR #177 [2] and
> used in openembedded-core [3].
> [1] https://github.com/linux-test-project/ltp/pull/177#discussion_r125466352
> [2] https://github.com/linux-test-project/ltp/pull/177/commits/fd65412438526a28813fae403b6d3fb6ec605bde
> [3] http://cgit.openembedded.org/openembedded-core/tree/meta/recipes-extended/ltp/ltp/0009-fix-redefinition-of-struct-msgbuf-error-building-wit.patch?h=sumo
> ---
>  configure.ac                                    |  1 +
>  include/lapi/abisize.h                          |  2 ++
>  include/lapi/sync_file_range.h                  |  1 +
>  include/lapi/wordsize.h                         | 17 +++++++++++++++++
>  testcases/kernel/io/disktest/main.h             |  1 +
>  .../kernel/mem/hugetlb/hugemmap/hugemmap02.c    |  1 +
>  .../kernel/mem/hugetlb/hugemmap/hugemmap04.c    |  1 +
>  .../kernel/mem/hugetlb/hugeshmat/hugeshmat02.c  |  1 +
>  testcases/kernel/mem/mem/mem01.c                |  1 +
>  testcases/kernel/mem/mtest01/mtest01.c          |  1 +
>  testcases/kernel/mem/oom/oom01.c                |  1 +
>  testcases/kernel/mem/oom/oom02.c                |  1 +
>  testcases/kernel/mem/oom/oom03.c                |  1 +
>  testcases/kernel/mem/oom/oom04.c                |  1 +
>  testcases/kernel/mem/oom/oom05.c                |  1 +
>  testcases/kernel/mem/swapping/swapping01.c      |  1 +
>  testcases/kernel/mem/tunable/min_free_kbytes.c  |  1 +
>  .../kernel/mem/tunable/overcommit_memory.c      |  1 +
>  testcases/kernel/mem/vma/vma03.c                |  1 +
>  .../kernel/syscalls/fadvise/posix_fadvise03.c   |  1 +
>  .../kernel/syscalls/fallocate/fallocate02.c     |  1 +
>  testcases/kernel/syscalls/fcntl/fcntl_common.h  |  1 +
>  testcases/kernel/syscalls/fork/fork14.c         |  1 +
>  testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c |  1 +
>  testcases/kernel/syscalls/mmap/mmap15.c         |  1 +
>  testcases/kernel/syscalls/profil/profil01.c     |  1 +
>  testcases/kernel/syscalls/sbrk/sbrk03.c         |  1 +
>  testcases/kernel/syscalls/sendfile/sendfile09.c |  1 +
>  28 files changed, 45 insertions(+)
>  create mode 100644 include/lapi/wordsize.h
> 
> diff --git a/configure.ac b/configure.ac
> index e73f7d92e..08128e13d 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -33,6 +33,7 @@ AC_PROG_YACC
>  AC_PREFIX_DEFAULT(/opt/ltp)
>  
>  AC_CHECK_HEADERS([ \
> +    bits/wordsize.h \
>      ifaddrs.h \
>      keyutils.h \
>      linux/can.h \
> diff --git a/include/lapi/abisize.h b/include/lapi/abisize.h
> index 897bdfdb6..ae28021d1 100644
> --- a/include/lapi/abisize.h
> +++ b/include/lapi/abisize.h
> @@ -20,6 +20,8 @@
>  #ifndef ABISIZE_H__
>  #define ABISIZE_H__
>  
> +#include "lapi/wordsize.h"
> +
>  /*
>   * Determines if we have to split up 64 bit arguments or not
>   *
> diff --git a/include/lapi/sync_file_range.h b/include/lapi/sync_file_range.h
> index e2d35fcfd..affbb3974 100644
> --- a/include/lapi/sync_file_range.h
> +++ b/include/lapi/sync_file_range.h
> @@ -9,6 +9,7 @@
>  #include <sys/types.h>
>  #include "config.h"
>  #include "lapi/syscalls.h"
> +#include "lapi/wordsize.h"
>  
>  #if !defined(HAVE_SYNC_FILE_RANGE)
>  
> diff --git a/include/lapi/wordsize.h b/include/lapi/wordsize.h
> new file mode 100644
> index 000000000..a3e1ba36d
> --- /dev/null
> +++ b/include/lapi/wordsize.h
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 Petr Vorel <petr.vorel@gmail.com>
> + */
> +
> +#ifndef WORDSIZE_H__
> +#define WORDSIZE_H__
> +
> +#ifdef HAVE_BITS_WORDSIZE_H
> +# include <bits/wordsize.h>
> +#endif
> +
> +#ifndef __WORDSIZE
> +# include <sys/reg.h>
> +#endif
> +
> +#endif /* WORDSIZE_H__ */
> diff --git a/testcases/kernel/io/disktest/main.h b/testcases/kernel/io/disktest/main.h
> index 41fcd7315..9b619aeb7 100644
> --- a/testcases/kernel/io/disktest/main.h
> +++ b/testcases/kernel/io/disktest/main.h
> @@ -49,6 +49,7 @@
>  #include <time.h>
>  #include <errno.h>
>  #include "defs.h"
> +#include "lapi/wordsize.h"
>  
>  #define VER_STR "v1.4.2"
>  #define BLKGETSIZE _IO(0x12,96)		/* IOCTL for getting the device size */
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
> index 0be753e0d..6c3defc6a 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
> @@ -39,6 +39,7 @@
>  #include <sys/mount.h>
>  #include <limits.h>
>  #include <sys/param.h>
> +#include "lapi/wordsize.h"
>  #include "hugetlb.h"
>  
>  #define LOW_ADDR       0x80000000
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
> index 674d367a4..074efc243 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
> @@ -38,6 +38,7 @@
>  #include <stdio.h>
>  #include <limits.h>
>  #include <sys/param.h>
> +#include "lapi/wordsize.h"
>  #include "hugetlb.h"
>  
>  static struct tst_option options[] = {
> diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
> index 1c2c978c8..d75e2ea59 100644
> --- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
> +++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
> @@ -36,6 +36,7 @@
>  
>  #include <pwd.h>
>  #include <limits.h>
> +#include "lapi/wordsize.h"
>  #include "hugetlb.h"
>  
>  #if __WORDSIZE == 64
> diff --git a/testcases/kernel/mem/mem/mem01.c b/testcases/kernel/mem/mem/mem01.c
> index f7642ab24..46d2feed0 100644
> --- a/testcases/kernel/mem/mem/mem01.c
> +++ b/testcases/kernel/mem/mem/mem01.c
> @@ -39,6 +39,7 @@
>  #include <time.h>
>  #include <limits.h>
>  
> +#include "lapi/wordsize.h"
>  #include "test.h"
>  
>  /* in KB */
> diff --git a/testcases/kernel/mem/mtest01/mtest01.c b/testcases/kernel/mem/mtest01/mtest01.c
> index df038f50d..d08b9b536 100644
> --- a/testcases/kernel/mem/mtest01/mtest01.c
> +++ b/testcases/kernel/mem/mtest01/mtest01.c
> @@ -28,6 +28,7 @@
>  #include <stdlib.h>
>  #include <unistd.h>
>  
> +#include "lapi/wordsize.h"
>  #include "tst_test.h"
>  
>  #define FIVE_HUNDRED_MB         (500ULL*1024*1024)
> diff --git a/testcases/kernel/mem/oom/oom01.c b/testcases/kernel/mem/oom/oom01.c
> index beb232d45..3ca537144 100644
> --- a/testcases/kernel/mem/oom/oom01.c
> +++ b/testcases/kernel/mem/oom/oom01.c
> @@ -27,6 +27,7 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <unistd.h>
> +#include "lapi/wordsize.h"
>  #include "mem.h"
>  
>  static void verify_oom(void)
> diff --git a/testcases/kernel/mem/oom/oom02.c b/testcases/kernel/mem/oom/oom02.c
> index 866540def..c893b98d0 100644
> --- a/testcases/kernel/mem/oom/oom02.c
> +++ b/testcases/kernel/mem/oom/oom02.c
> @@ -30,6 +30,7 @@
>  #include <numa.h>
>  #endif
>  
> +#include "lapi/wordsize.h"
>  #include "numa_helper.h"
>  #include "mem.h"
>  
> diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
> index b283b5275..978a414af 100644
> --- a/testcases/kernel/mem/oom/oom03.c
> +++ b/testcases/kernel/mem/oom/oom03.c
> @@ -30,6 +30,7 @@
>  #include <numa.h>
>  #endif
>  
> +#include "lapi/wordsize.h"
>  #include "numa_helper.h"
>  #include "mem.h"
>  
> diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
> index 98b31c74a..c17f4e3da 100644
> --- a/testcases/kernel/mem/oom/oom04.c
> +++ b/testcases/kernel/mem/oom/oom04.c
> @@ -30,6 +30,7 @@
>  #include <numa.h>
>  #endif
>  
> +#include "lapi/wordsize.h"
>  #include "numa_helper.h"
>  #include "mem.h"
>  
> diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
> index c5395b0bb..7a77b590b 100644
> --- a/testcases/kernel/mem/oom/oom05.c
> +++ b/testcases/kernel/mem/oom/oom05.c
> @@ -30,6 +30,7 @@
>  #include <numa.h>
>  #endif
>  
> +#include "lapi/wordsize.h"
>  #include "numa_helper.h"
>  #include "mem.h"
>  
> diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
> index 6ac802b25..07109c80a 100644
> --- a/testcases/kernel/mem/swapping/swapping01.c
> +++ b/testcases/kernel/mem/swapping/swapping01.c
> @@ -44,6 +44,7 @@
>  #include <stdlib.h>
>  #include <string.h>
>  #include <unistd.h>
> +#include "lapi/wordsize.h"
>  #include "mem.h"
>  
>  /* allow swapping 1 * phy_mem in maximum */
> diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
> index f114dc493..aae3f00cc 100644
> --- a/testcases/kernel/mem/tunable/min_free_kbytes.c
> +++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
> @@ -34,6 +34,7 @@
>  #include <signal.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> +#include "lapi/wordsize.h"
>  #include "mem.h"
>  
>  #define MAP_SIZE (1UL<<20)
> diff --git a/testcases/kernel/mem/tunable/overcommit_memory.c b/testcases/kernel/mem/tunable/overcommit_memory.c
> index 07f824328..0712ff760 100644
> --- a/testcases/kernel/mem/tunable/overcommit_memory.c
> +++ b/testcases/kernel/mem/tunable/overcommit_memory.c
> @@ -69,6 +69,7 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <limits.h>
> +#include "lapi/wordsize.h"
>  #include "mem.h"
>  
>  #define DEFAULT_OVER_RATIO	50L
> diff --git a/testcases/kernel/mem/vma/vma03.c b/testcases/kernel/mem/vma/vma03.c
> index 4b34ab0a0..42e233412 100644
> --- a/testcases/kernel/mem/vma/vma03.c
> +++ b/testcases/kernel/mem/vma/vma03.c
> @@ -51,6 +51,7 @@
>  #include "test.h"
>  #include "safe_macros.h"
>  #include "tst_kernel.h"
> +#include "lapi/wordsize.h"
>  
>  char *TCID = "vma03";
>  int TST_TOTAL = 1;
> diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise03.c b/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
> index 0127a1b04..ad65870d1 100644
> --- a/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
> +++ b/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
> @@ -30,6 +30,7 @@
>  
>  #include "tst_test.h"
>  #include "lapi/syscalls.h"
> +#include "lapi/wordsize.h"
>  
>  char fname[] = "/bin/cat";	/* test executable to open */
>  int fd = -1;			/* initialized in open */
> diff --git a/testcases/kernel/syscalls/fallocate/fallocate02.c b/testcases/kernel/syscalls/fallocate/fallocate02.c
> index 4840eaf28..df5ae217e 100644
> --- a/testcases/kernel/syscalls/fallocate/fallocate02.c
> +++ b/testcases/kernel/syscalls/fallocate/fallocate02.c
> @@ -41,6 +41,7 @@
>  #include "test.h"
>  #include "safe_macros.h"
>  #include "lapi/fallocate.h"
> +#include "lapi/wordsize.h"
>  
>  #define BLOCKS_WRITTEN		12
>  #ifdef TEST_DEFAULT
> diff --git a/testcases/kernel/syscalls/fcntl/fcntl_common.h b/testcases/kernel/syscalls/fcntl/fcntl_common.h
> index 07229a0f8..7738a5258 100644
> --- a/testcases/kernel/syscalls/fcntl/fcntl_common.h
> +++ b/testcases/kernel/syscalls/fcntl/fcntl_common.h
> @@ -1,4 +1,5 @@
>  #include "lapi/syscalls.h"
> +#include "lapi/wordsize.h"
>  
>  /*
>   * glibc commit:
> diff --git a/testcases/kernel/syscalls/fork/fork14.c b/testcases/kernel/syscalls/fork/fork14.c
> index 6ea92e0c2..c660f6a4e 100644
> --- a/testcases/kernel/syscalls/fork/fork14.c
> +++ b/testcases/kernel/syscalls/fork/fork14.c
> @@ -35,6 +35,7 @@
>  #include <unistd.h>
>  #include "test.h"
>  #include "safe_macros.h"
> +#include "lapi/wordsize.h"
>  
>  char *TCID = "fork14";
>  int TST_TOTAL = 1;
> diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c
> index a757c0d18..2e500ce23 100644
> --- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c
> +++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c
> @@ -42,6 +42,7 @@
>  #include <sys/ipc.h>
>  #include <sys/msg.h>
>  #include "test.h"
> +#include "lapi/wordsize.h"
>  
>  const char *TCID = "msgrcv08";
>  const int TST_TOTAL = 1;
> diff --git a/testcases/kernel/syscalls/mmap/mmap15.c b/testcases/kernel/syscalls/mmap/mmap15.c
> index c8a77873a..db5e30bd1 100644
> --- a/testcases/kernel/syscalls/mmap/mmap15.c
> +++ b/testcases/kernel/syscalls/mmap/mmap15.c
> @@ -36,6 +36,7 @@
>  #include <unistd.h>
>  #include "test.h"
>  #include "safe_macros.h"
> +#include "lapi/wordsize.h"
>  
>  char *TCID = "mmap15";
>  int TST_TOTAL = 1;
> diff --git a/testcases/kernel/syscalls/profil/profil01.c b/testcases/kernel/syscalls/profil/profil01.c
> index f1164021b..1958e1fa4 100644
> --- a/testcases/kernel/syscalls/profil/profil01.c
> +++ b/testcases/kernel/syscalls/profil/profil01.c
> @@ -27,6 +27,7 @@
>  #include <sys/types.h>
>  #include "test.h"
>  #include "safe_macros.h"
> +#include "lapi/wordsize.h"
>  #include "config.h"
>  
>  char *TCID = "profil01";
> diff --git a/testcases/kernel/syscalls/sbrk/sbrk03.c b/testcases/kernel/syscalls/sbrk/sbrk03.c
> index 46fb2d111..5196c3a57 100644
> --- a/testcases/kernel/syscalls/sbrk/sbrk03.c
> +++ b/testcases/kernel/syscalls/sbrk/sbrk03.c
> @@ -46,6 +46,7 @@
>  
>  #include <stdio.h>
>  #include <unistd.h>
> +#include "lapi/wordsize.h"
>  #include "tst_test.h"
>  
>  static void sbrk_test(void)
> diff --git a/testcases/kernel/syscalls/sendfile/sendfile09.c b/testcases/kernel/syscalls/sendfile/sendfile09.c
> index 0a9d2553e..4be3065d0 100644
> --- a/testcases/kernel/syscalls/sendfile/sendfile09.c
> +++ b/testcases/kernel/syscalls/sendfile/sendfile09.c
> @@ -51,6 +51,7 @@
>  #include <inttypes.h>
>  #include "test.h"
>  #include "safe_macros.h"
> +#include "lapi/wordsize.h"
>  
>  #ifndef OFF_T
>  #define OFF_T off_t
> -- 
> 2.21.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz
