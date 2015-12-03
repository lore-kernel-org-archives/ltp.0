From: Li Wang <liwang@redhat.com>
Date: Thu, 3 Dec 2015 10:57:51 +0800
Subject: [LTP] [PATCH 1/2] hugetlb: rename lib/ipcshm.* to lib/hugetlb.*
In-Reply-To: <1448612328-2094-1-git-send-email-liwang@redhat.com>
References: <1448612328-2094-1-git-send-email-liwang@redhat.com>
Message-ID: <CAEemH2ehK0+ORgo1Rsp1V5zZQnQd4EhGSvpK+iFa6kc=oDy95g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

sorry, ping~

http://lists.linux.it/pipermail/ltp/2015-November/000563.html
http://lists.linux.it/pipermail/ltp/2015-November/000564.html
http://lists.linux.it/pipermail/ltp/2015-November/000565.html
http://lists.linux.it/pipermail/ltp/2015-November/000566.html

any comments on above patches?


On Fri, Nov 27, 2015 at 4:18 PM, Li Wang <liwang@redhat.com> wrote:

> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  testcases/kernel/mem/hugetlb/Makefile              |   2 +-
>  testcases/kernel/mem/hugetlb/Makefile.inc          |   4 +-
>  .../kernel/mem/hugetlb/hugeshmat/hugeshmat01.c     |   2 +-
>  .../kernel/mem/hugetlb/hugeshmat/hugeshmat02.c     |   2 +-
>  .../kernel/mem/hugetlb/hugeshmat/hugeshmat03.c     |   2 +-
>  .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c   |   2 +-
>  .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c   |   2 +-
>  .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c   |   2 +-
>  .../kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c     |   2 +-
>  .../kernel/mem/hugetlb/hugeshmget/hugeshmget01.c   |   2 +-
>  .../kernel/mem/hugetlb/hugeshmget/hugeshmget02.c   |   2 +-
>  .../kernel/mem/hugetlb/hugeshmget/hugeshmget03.c   |   2 +-
>  .../kernel/mem/hugetlb/hugeshmget/hugeshmget05.c   |   2 +-
>  testcases/kernel/mem/hugetlb/lib/Makefile          |   2 +-
>  testcases/kernel/mem/hugetlb/lib/hugetlb.c         | 116
> +++++++++++++++++++++
>  testcases/kernel/mem/hugetlb/lib/hugetlb.h         |  61 +++++++++++
>  testcases/kernel/mem/hugetlb/lib/ipcshm.h          |  61 -----------
>  testcases/kernel/mem/hugetlb/lib/libipc.c          | 116
> ---------------------
>  18 files changed, 192 insertions(+), 192 deletions(-)
>  create mode 100644 testcases/kernel/mem/hugetlb/lib/hugetlb.c
>  create mode 100644 testcases/kernel/mem/hugetlb/lib/hugetlb.h
>  delete mode 100644 testcases/kernel/mem/hugetlb/lib/ipcshm.h
>  delete mode 100644 testcases/kernel/mem/hugetlb/lib/libipc.c
>
> diff --git a/testcases/kernel/mem/hugetlb/Makefile
> b/testcases/kernel/mem/hugetlb/Makefile
> index 1e8f8f8..ea7867f 100644
> --- a/testcases/kernel/mem/hugetlb/Makefile
> +++ b/testcases/kernel/mem/hugetlb/Makefile
> @@ -21,7 +21,7 @@ top_srcdir            ?= ../../../..
>  include        $(top_srcdir)/include/mk/env_pre.mk
>
>  LIBDIR                 := lib
> -LIB                    := $(LIBDIR)/libipc_hugetlb.a
> +LIB                    := $(LIBDIR)/libhugetlb.a
>  FILTER_OUT_DIRS                := $(LIBDIR)
>
>  $(LIBDIR):
> diff --git a/testcases/kernel/mem/hugetlb/Makefile.inc
> b/testcases/kernel/mem/hugetlb/Makefile.inc
> index cc0ada6..c07d600 100644
> --- a/testcases/kernel/mem/hugetlb/Makefile.inc
> +++ b/testcases/kernel/mem/hugetlb/Makefile.inc
> @@ -22,7 +22,7 @@
>
>  # DO NOT USE THIS FILE FOR hugetlb / lib!!!
>  LIBIPCDIR              := ../lib
> -LIBIPC                 := $(LIBIPCDIR)/libipc_hugetlb.a
> +LIBIPC                 := $(LIBIPCDIR)/libhugetlb.a
>
>  $(LIBIPCDIR):
>         mkdir -p "$@"
> @@ -31,7 +31,7 @@ $(LIBIPC): $(LIBIPCDIR)
>
>  CPPFLAGS               += -I$(abs_srcdir)/$(LIBIPCDIR)
>  LDFLAGS                        += -L$(abs_builddir)/$(LIBIPCDIR)
> -LDLIBS                 += -lipc_hugetlb
> +LDLIBS                 += -lhugetlb
>  MAKE_DEPS              += $(LIBIPC)
>
>  include $(top_srcdir)/testcases/kernel/mem/include/libmem.mk
> diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
> b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
> index 851d4cf..35e7216 100644
> --- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
> +++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
> @@ -56,7 +56,7 @@
>   *     none
>   */
>
> -#include "ipcshm.h"
> +#include "hugetlb.h"
>  #include "safe_macros.h"
>  #include "mem.h"
>
> diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
> b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
> index 52348f1..2bac9c2 100644
> --- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
> +++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
> @@ -51,7 +51,7 @@
>   */
>
>  #include <pwd.h>
> -#include "ipcshm.h"
> +#include "hugetlb.h"
>  #include "safe_macros.h"
>  #include "mem.h"
>
> diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
> b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
> index 723c8b5..fe74810 100644
> --- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
> +++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
> @@ -57,7 +57,7 @@
>   *     test must be run at root
>   */
>
> -#include "ipcshm.h"
> +#include "hugetlb.h"
>  #include "safe_macros.h"
>  #include "mem.h"
>
> diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
> b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
> index 66ad1b5..d7990c7 100644
> --- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
> +++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
> @@ -61,7 +61,7 @@
>   *     none
>   */
>
> -#include "ipcshm.h"
> +#include "hugetlb.h"
>  #include "safe_macros.h"
>  #include "mem.h"
>
> diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
> b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
> index 4aeb638..f79ee83 100644
> --- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
> +++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
> @@ -53,7 +53,7 @@
>   */
>
>  #include <pwd.h>
> -#include "ipcshm.h"
> +#include "hugetlb.h"
>  #include "safe_macros.h"
>  #include "mem.h"
>
> diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
> b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
> index 9f5c2c9..e553a2a 100644
> --- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
> +++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
> @@ -60,7 +60,7 @@
>
>  #include <sys/types.h>
>  #include <sys/wait.h>
> -#include "ipcshm.h"
> +#include "hugetlb.h"
>  #include "safe_macros.h"
>  #include "mem.h"
>
> diff --git a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
> b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
> index 9770e87..c8592b3 100644
> --- a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
> +++ b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
> @@ -58,7 +58,7 @@
>   */
>
>  #include <setjmp.h>
> -#include "ipcshm.h"
> +#include "hugetlb.h"
>  #include "safe_macros.h"
>  #include "mem.h"
>
> diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
> b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
> index ee82de3..5d45aaa 100644
> --- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
> +++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
> @@ -58,7 +58,7 @@
>   *     none
>   */
>
> -#include "ipcshm.h"
> +#include "hugetlb.h"
>  #include "safe_macros.h"
>  #include "mem.h"
>
> diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
> b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
> index b995ef8..0ac4a29 100644
> --- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
> +++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
> @@ -51,7 +51,7 @@
>   *     none
>   */
>
> -#include "ipcshm.h"
> +#include "hugetlb.h"
>  #include "safe_macros.h"
>  #include "mem.h"
>
> diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
> b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
> index 9284669..9a2a0b2 100644
> --- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
> +++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
> @@ -52,7 +52,7 @@
>   *     none
>   */
>
> -#include "ipcshm.h"
> +#include "hugetlb.h"
>  #include "safe_macros.h"
>  #include "mem.h"
>
> diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
> b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
> index 7b8f6b4..567b02d 100644
> --- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
> +++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
> @@ -60,7 +60,7 @@
>
>  #include <sys/types.h>
>  #include <sys/wait.h>
> -#include "ipcshm.h"
> +#include "hugetlb.h"
>  #include "safe_macros.h"
>  #include "mem.h"
>
> diff --git a/testcases/kernel/mem/hugetlb/lib/Makefile
> b/testcases/kernel/mem/hugetlb/lib/Makefile
> index 4cdd142..96e8e37 100644
> --- a/testcases/kernel/mem/hugetlb/lib/Makefile
> +++ b/testcases/kernel/mem/hugetlb/lib/Makefile
> @@ -20,6 +20,6 @@ top_srcdir            ?= ../../../../..
>
>  include $(top_srcdir)/include/mk/env_pre.mk
>
> -LIB                    := libipc_hugetlb.a
> +LIB                    := libhugetlb.a
>
>  include $(top_srcdir)/include/mk/lib.mk
> diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.c
> b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
> new file mode 100644
> index 0000000..4b2a3d2
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
> @@ -0,0 +1,116 @@
> +/*
> + *
> + *   Copyright (c) International Business Machines  Corp., 2001
> + *
> + *   This program is free software;  you can redistribute it and/or modify
> + *   it under the terms of the GNU General Public License as published by
> + *   the Free Software Foundation; either version 2 of the License, or
> + *   (at your option) any later version.
> + *
> + *   This program is distributed in the hope that it will be useful,
> + *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> + *   the GNU General Public License for more details.
> + *
> + *   You should have received a copy of the GNU General Public License
> + *   along with this program;  if not, write to the Free Software
> + *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> 02110-1301 USA
> + */
> +
> +/*
> + * NAME
> + *     hugetlb.c
> + *
> + * DESCRIPTION
> + *     common routines for the hugepage tests.
> + *
> + *     The library contains the following routines:
> + *
> + *     getipckey()
> + *     getuserid()
> + *     rm_shm()
> + *     help()
> + */
> +
> +#include <sys/types.h>
> +#include <sys/ipc.h>
> +#include <sys/shm.h>
> +#include <sys/timeb.h>
> +#include <pwd.h>
> +#include "hugetlb.h"
> +
> +/*
> + * getipckey() - generates and returns a message key used by the "get"
> + *              calls to create an IPC resource.
> + */
> +int getipckey(void)
> +{
> +       const char a = 'a';
> +       int ascii_a = (int)a;
> +       char *curdir = NULL;
> +       size_t size = 0;
> +       key_t ipc_key;
> +       struct timeb time_info;
> +
> +       curdir = getcwd(curdir, size);
> +       if (curdir == NULL)
> +               tst_brkm(TBROK | TERRNO, cleanup, "getcwd(curdir)");
> +
> +       /*
> +        * Get a Sys V IPC key
> +        *
> +        * ftok() requires a character as a second argument.  This is
> +        * refered to as a "project identifier" in the man page.  In
> +        * order to maximize the chance of getting a unique key, the
> +        * project identifier is a "random character" produced by
> +        * generating a random number between 0 and 25 and then adding
> +        * that to the ascii value of 'a'.  The "seed" for the random
> +        * number is the millisecond value that is set in the timeb
> +        * structure after calling ftime().
> +        */
> +       ftime(&time_info);
> +       srandom((unsigned int)time_info.millitm);
> +
> +       ipc_key = ftok(curdir, ascii_a + random() % 26);
> +       if (ipc_key == -1)
> +               tst_brkm(TBROK | TERRNO, cleanup, "ftok");
> +
> +       return ipc_key;
> +}
> +
> +/*
> + * getuserid() - return the integer value for the "user" id
> + */
> +int getuserid(char *user)
> +{
> +       struct passwd *ent;
> +
> +       ent = getpwnam(user);
> +       if (ent == NULL)
> +               tst_brkm(TBROK | TERRNO, cleanup, "getpwnam");
> +
> +       return ent->pw_uid;
> +}
> +
> +/*
> + * rm_shm() - removes a shared memory segment.
> + */
> +void rm_shm(int shm_id)
> +{
> +       if (shm_id == -1)
> +               return;
> +
> +       /*
> +        * check for # of attaches ?
> +        */
> +       if (shmctl(shm_id, IPC_RMID, NULL) == -1) {
> +               tst_resm(TINFO, "WARNING: shared memory deletion failed.");
> +               tst_resm(TINFO, "This could lead to IPC resource
> problems.");
> +               tst_resm(TINFO, "id = %d", shm_id);
> +       }
> +}
> +
> +void help(void)
> +{
> +       printf("    -s NUM  Set the number of hugepages to be
> allocated\n");
> +}
> diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.h
> b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
> new file mode 100644
> index 0000000..6d73e9c
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
> @@ -0,0 +1,61 @@
> +/*
> + *
> + *   Copyright (c) International Business Machines  Corp., 2001
> + *
> + *   This program is free software;  you can redistribute it and/or modify
> + *   it under the terms of the GNU General Public License as published by
> + *   the Free Software Foundation; either version 2 of the License, or
> + *   (at your option) any later version.
> + *
> + *   This program is distributed in the hope that it will be useful,
> + *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> + *   the GNU General Public License for more details.
> + *
> + *   You should have received a copy of the GNU General Public License
> + *   along with this program;  if not, write to the Free Software
> + *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> 02110-1301 USA
> + */
> +
> +/*
> + * hugetlb.h - common definitions for the hugepage tests
> + */
> +
> +#ifndef __HUGETLB_H
> +#define __HUGETLB_H
> +
> +#include <sys/ipc.h>
> +#include <sys/shm.h>
> +#include <errno.h>
> +#include <wait.h>
> +#include "test.h"
> +
> +#define SHM_RD 0400
> +#define SHM_WR 0200
> +#define SHM_RW (SHM_RD|SHM_WR)
> +
> +#ifndef SHM_HUGETLB
> +#define SHM_HUGETLB    04000   /* segment is mapped via hugetlb */
> +#endif
> +
> +/*
> + * to get the lower nine permission bits
> + * from shmid_ds.ipc_perm.mode
> + */
> +#define MODE_MASK      0x01FF
> +
> +key_t shmkey;                  /* an IPC key generated by ftok() */
> +
> +int getipckey(void);
> +int getuserid(char *user);
> +void rm_shm(int shm_id);
> +
> +void cleanup(void);
> +void setup(void);
> +
> +char *nr_opt;
> +int sflag;
> +long orig_hugepages;
> +void help(void);
> +
> +#endif /* hugetlb.h */
> diff --git a/testcases/kernel/mem/hugetlb/lib/ipcshm.h
> b/testcases/kernel/mem/hugetlb/lib/ipcshm.h
> deleted file mode 100644
> index 194d14b..0000000
> --- a/testcases/kernel/mem/hugetlb/lib/ipcshm.h
> +++ /dev/null
> @@ -1,61 +0,0 @@
> -/*
> - *
> - *   Copyright (c) International Business Machines  Corp., 2001
> - *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> - *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> - *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> 02110-1301 USA
> - */
> -
> -/*
> - * ipcshm.h - common definitions for the IPC shared memory tests
> - */
> -
> -#ifndef __IPCSHM_H
> -#define __IPCSHM_H
> -
> -#include <sys/ipc.h>
> -#include <sys/shm.h>
> -#include <errno.h>
> -#include <wait.h>
> -#include "test.h"
> -
> -#define SHM_RD 0400
> -#define SHM_WR 0200
> -#define SHM_RW (SHM_RD|SHM_WR)
> -
> -#ifndef SHM_HUGETLB
> -#define SHM_HUGETLB    04000   /* segment is mapped via hugetlb */
> -#endif
> -
> -/*
> - * to get the lower nine permission bits
> - * from shmid_ds.ipc_perm.mode
> - */
> -#define MODE_MASK      0x01FF
> -
> -key_t shmkey;                  /* an IPC key generated by ftok() */
> -
> -int getipckey(void);
> -int getuserid(char *user);
> -void rm_shm(int shm_id);
> -
> -void cleanup(void);
> -void setup(void);
> -
> -char *nr_opt;
> -int sflag;
> -long orig_hugepages;
> -void help(void);
> -
> -#endif /* ipcshm.h */
> diff --git a/testcases/kernel/mem/hugetlb/lib/libipc.c
> b/testcases/kernel/mem/hugetlb/lib/libipc.c
> deleted file mode 100644
> index 1f16f22..0000000
> --- a/testcases/kernel/mem/hugetlb/lib/libipc.c
> +++ /dev/null
> @@ -1,116 +0,0 @@
> -/*
> - *
> - *   Copyright (c) International Business Machines  Corp., 2001
> - *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> - *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> - *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> 02110-1301 USA
> - */
> -
> -/*
> - * NAME
> - *     libipc.c
> - *
> - * DESCRIPTION
> - *     common routines for the IPC system call tests.
> - *
> - *     The library contains the following routines:
> - *
> - *     getipckey()
> - *     getuserid()
> - *     rm_shm()
> - *     help()
> - */
> -
> -#include <sys/types.h>
> -#include <sys/ipc.h>
> -#include <sys/shm.h>
> -#include <sys/timeb.h>
> -#include <pwd.h>
> -#include "ipcshm.h"
> -
> -/*
> - * getipckey() - generates and returns a message key used by the "get"
> - *              calls to create an IPC resource.
> - */
> -int getipckey(void)
> -{
> -       const char a = 'a';
> -       int ascii_a = (int)a;
> -       char *curdir = NULL;
> -       size_t size = 0;
> -       key_t ipc_key;
> -       struct timeb time_info;
> -
> -       curdir = getcwd(curdir, size);
> -       if (curdir == NULL)
> -               tst_brkm(TBROK | TERRNO, cleanup, "getcwd(curdir)");
> -
> -       /*
> -        * Get a Sys V IPC key
> -        *
> -        * ftok() requires a character as a second argument.  This is
> -        * refered to as a "project identifier" in the man page.  In
> -        * order to maximize the chance of getting a unique key, the
> -        * project identifier is a "random character" produced by
> -        * generating a random number between 0 and 25 and then adding
> -        * that to the ascii value of 'a'.  The "seed" for the random
> -        * number is the millisecond value that is set in the timeb
> -        * structure after calling ftime().
> -        */
> -       ftime(&time_info);
> -       srandom((unsigned int)time_info.millitm);
> -
> -       ipc_key = ftok(curdir, ascii_a + random() % 26);
> -       if (ipc_key == -1)
> -               tst_brkm(TBROK | TERRNO, cleanup, "ftok");
> -
> -       return ipc_key;
> -}
> -
> -/*
> - * getuserid() - return the integer value for the "user" id
> - */
> -int getuserid(char *user)
> -{
> -       struct passwd *ent;
> -
> -       ent = getpwnam(user);
> -       if (ent == NULL)
> -               tst_brkm(TBROK | TERRNO, cleanup, "getpwnam");
> -
> -       return ent->pw_uid;
> -}
> -
> -/*
> - * rm_shm() - removes a shared memory segment.
> - */
> -void rm_shm(int shm_id)
> -{
> -       if (shm_id == -1)
> -               return;
> -
> -       /*
> -        * check for # of attaches ?
> -        */
> -       if (shmctl(shm_id, IPC_RMID, NULL) == -1) {
> -               tst_resm(TINFO, "WARNING: shared memory deletion failed.");
> -               tst_resm(TINFO, "This could lead to IPC resource
> problems.");
> -               tst_resm(TINFO, "id = %d", shm_id);
> -       }
> -}
> -
> -void help(void)
> -{
> -       printf("    -s NUM  Set the number of hugepages to be
> allocated\n");
> -}
> --
> 1.8.3.1
>
>
> --
> Mailing list info: http://lists.linux.it/listinfo/ltp
>



-- 
Regards,
Li Wang
Email: liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20151203/74c0747a/attachment-0001.html>
