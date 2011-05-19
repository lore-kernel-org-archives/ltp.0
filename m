Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QN4ZT-0001NE-9f
	for ltp-list@lists.sourceforge.net; Thu, 19 May 2011 14:51:27 +0000
Date: Thu, 19 May 2011 16:47:12 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110519144712.GA11838@saboteur.suse.cz>
References: <4D8B1B3F.6010303@cn.fujitsu.com>
	<BANLkTi=n_UeC_YOT3o-czzAhwu9GRUbWhw@mail.gmail.com>
	<4D9EB736.2030907@cn.fujitsu.com> <4DAF85AA.5080609@cn.fujitsu.com>
	<4DB0FF1C.5060000@redhat.com> <4DC91E94.6050907@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4DC91E94.6050907@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] hugemmap01.c : Automatically mount hugetlbfs on
 /huge.
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
To: tangchen <tangchen@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi,
> hugemmap test could fail because I didn't mount hugetlbfs by myself.
> And I need to umount it after test.  In my opinion, firstly, mounting
> hugetlbfs on /tmp is not a good idea, because lots of programs could
> use /tmp for other purpose. This could cause other tests fail;
> secondly, mounting hugetlbfs could be done automatically.  This patch
> creates a directory /huge, automatically mounts hugetlbfs on /huge
> before test starts, and umounts it when the test is over.

Messing around in / is IMHO not good idea either, what about calling
tst_tmpdir() and mounting it into local directory. Has anybody better
idea?

> Signed-off-by: tangchen <tangchen@cn.fujitsu.com>
> ---
>  runtest/hugetlb                                    |    8 +-
>  testcases/kernel/mem/hugetlb/hugemmap/Makefile     |   27 +++++++-
>  testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c |   12 +++-
>  testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c |   11 +++
>  testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c |   12 +++-
>  testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c |   12 +++-
>  testcases/kernel/mem/hugetlb/hugemmap/lib/Makefile |   25 +++++++
>  testcases/kernel/mem/hugetlb/hugemmap/lib/libmnt.c |   69 ++++++++++++++++++++
>  testcases/kernel/mem/hugetlb/hugemmap/lib/libmnt.h |   35 ++++++++++
>  9 files changed, 202 insertions(+), 9 deletions(-)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/lib/Makefile
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/lib/libmnt.c
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/lib/libmnt.h
> 
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index af45868..ef15e9e 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -1,7 +1,7 @@
> -hugemmap01 hugemmap01 -H/tmp
> -hugemmap02 hugemmap02 -H/tmp -c10
> -hugemmap03 hugemmap03 -H/tmp -I2 -c10
> -hugemmap04 hugemmap04 -H/tmp
> +hugemmap01 hugemmap01 -H/huge
> +hugemmap02 hugemmap02 -H/huge -c10
> +hugemmap03 hugemmap03 -H/huge -I2 -c10
> +hugemmap04 hugemmap04 -H/huge
>  hugemmap05 hugemmap05
>  hugemmap05_1 hugemmap05 -m
>  hugemmap05_2 hugemmap05 -s
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/Makefile b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
> index a1ba46e..b89a040 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/Makefile
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
> @@ -20,8 +20,31 @@
>  # Garrett Cooper, July 2009
>  #
>  
> -top_srcdir              ?= ../../../../..
> +top_srcdir		?= ../../../../..
>  
>  include $(top_srcdir)/include/mk/testcases.mk
> -include $(abs_srcdir)/../Makefile.inc
> +
> +LIBDIR			:= lib
> +LIB			:= $(LIBDIR)/libmnt_hugetlb.a
> +FILTER_OUT_DIRS		:= $(LIBDIR)
> +
> +$(LIBDIR):
> +	mkdir -p "$@"
> +
> +$(LIB): $(LIBDIR)
> +	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
> +
> +CPPFLAGS                += -I$(abs_srcdir)/$(LIBDIR)
> +
> +LDFLAGS                 += -L$(abs_builddir)/$(LIBDIR)
> +
> +LDLIBS                  += -lmnt_hugetlb
> +
> +MAKE_DEPS		:= $(LIB)
> +
> +trunk-clean:: | lib-clean
> +
> +lib-clean:: $(LIBDIR)
> +	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
> +
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
> index 874f736..2b9b3b1 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
> @@ -73,6 +73,7 @@
>  #include "test.h"
>  #include "usctest.h"
>  #include "system_specific_hugepages_info.h"
> +#include "lib/libmnt.h"
>  
>  #define BUFFER_SIZE  256
>  
> @@ -86,6 +87,7 @@ char *Hopt;                     /* location of hugetlbfs */
>
>  int beforetest=0;		/* Amount of free huge pages before testing */
>  int aftertest=0;		/* Amount of free huge pages after testing */
>  int hugepagesmapped=0;		/* Amount of huge pages mapped after testing */
> +char *mount_point = NULL;	/* The path on which hugetlbfs will be mounted */

I would change the names a little and drop the comments, something like:

int free_huge_before;
int free_huge_after;

Also, to cite LKML coding style "mixed case is frowned upon", so change
Hopt at least to hopt.

>  void setup();			/* Main setup function of test */
>  void cleanup();			/* cleanup function for the test */

Once again these comments are useless, please avoid/remove comments like:

setup(void); /* this is setup */

And please use always void for fuctions without any parameters
(otherwise compliter thinks that they could take any nuber of int
parameters).

>  {
> +	mount_point = (char *)malloc(sizeof(char) * strlen(Hopt));

Remove that cast, we are in C where void* is compatible with any
pointer. And also sizeof(char) is 1 by definition ;).

> +	mount_point = strcpy(mount_point, Hopt);

Hmm do we really need to copy Hopt? It's not modified by mount_hugetlbfs
isn't it? And even if we do, there is strdup() exactly for that purpose.
(Also you should check the return value from malloc, strdup and
friends.)

> +	tst_require_root(tst_exit);

tst_require_root() doesn't need valid cleanup pointer to exit, so please
use tst_require_root(NULL); instead. And move it to the beginning of
setup(), ideally this would be first fucntion before doing anything
else.

> +	mount_hugetlbfs(mount_point);
> +	hugepage_alloc(1024);
> +
>  	char mypid[40];
>  
>  	sprintf(mypid,"/%d",getpid());

Missing spaces after ,

> @@ -217,5 +227,5 @@ cleanup()
>  	TEST_CLEANUP;
>  
>  	unlink(TEMPFILE);
> -
> +	umount_hugetlbfs(mount_point);
>  }

Aaah, and the original code modifies Hopt by strcat() which is plain
wrong.

> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
> index 45cddf7..b41ec41 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
> @@ -63,6 +63,7 @@
>  #include "test.h"
>  #include "usctest.h"
>  #include "system_specific_hugepages_info.h"
> +#include "lib/libmnt.h"
>  
>  #define LOW_ADDR       (void *)(0x80000000)
>  #define LOW_ADDR2      (void *)(0x90000000)
> @@ -78,6 +79,7 @@ int i;
>  int fildes;			/* file descriptor for tempfile */
>  int nfildes;			/* file descriptor for /dev/zero */
>  char *Hopt;                     /* location of hugetlbfs */
> +char *mount_point = NULL;	/* The path on which hugetlbfs will be mounted */
>  
>  void setup();			/* Main setup function of test */
>  void cleanup();			/* cleanup function for the test */
> @@ -208,6 +210,14 @@ main(int ac, char **av)
>  void
>  setup()
>  {
> +	mount_point = (char *)malloc(sizeof(char) * strlen(Hopt));
> +	mount_point = strcpy(mount_point, Hopt);
> +
> +	tst_require_root(tst_exit);
> +
> +	mount_hugetlbfs(mount_point);
> +	hugepage_alloc(1024);
> +
>  	tst_tmpdir();
>  
>  	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", Hopt, getpid());
> @@ -231,6 +241,7 @@ cleanup()
>  	TEST_CLEANUP;
>  
>  	unlink(TEMPFILE);
> +	umount_hugetlbfs(mount_point);
>  
>  	tst_rmdir();
>  }

Same applies here.

> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c
> index cac94b0..a06ef44 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c
> @@ -54,6 +54,7 @@
>  #include "test.h"
>  #include "usctest.h"
>  #include "system_specific_hugepages_info.h"
> +#include "lib/libmnt.h"
>  
>  #define HIGH_ADDR      (void *)(0x1000000000000)
>  
> @@ -64,6 +65,7 @@ int TST_TOTAL=1;		/* Total number of test cases. */
>  unsigned long *addr;		/* addr of memory mapped region */
>  int fildes;			/* file descriptor for tempfile */
>  char *Hopt;                     /* location of hugetlbfs */
> +char *mount_point = NULL;	/* The path on which hugetlbfs will be mounted */
>  
>  void setup();			/* Main setup function of test */
>  void cleanup();			/* cleanup function for the test */
> @@ -151,6 +153,14 @@ main(int ac, char **av)
>  void
>  setup()
>  {
> +	mount_point = (char *)malloc(sizeof(char) * strlen(Hopt));
> +	mount_point = strcpy(mount_point, Hopt);
> +
> +	tst_require_root(tst_exit);
> +
> +	mount_hugetlbfs(mount_point);
> +	hugepage_alloc(1024);
> +
>  	char mypid[40];
>  
>  	sprintf(mypid,"/%d",getpid());
> @@ -177,5 +187,5 @@ cleanup()
>  	TEST_CLEANUP;
>  
>  	unlink(TEMPFILE);
> -
> +	umount_hugetlbfs(mount_point);
>  }

And here.

> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
> index 4cc6ed4..86a5fe2 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
> @@ -73,6 +73,7 @@
>  #include "test.h"
>  #include "usctest.h"
>  #include "system_specific_hugepages_info.h"
> +#include "lib/libmnt.h"
>  
>  #define BUFFER_SIZE  256
>  
> @@ -88,6 +89,7 @@ int beforetest=0;		/* Amount of free huge pages before testing */
>  int aftertest=0;		/* Amount of free huge pages after testing */
>  int hugepagesmapped=0;		/* Amount of huge pages mapped after testing */
>  char *Hopt;                     /* location of hugetlbfs */
> +char *mount_point = NULL;	/* The path on which hugetlbfs will be mounted */
>  
>  void setup();			/* Main setup function of test */
>  void cleanup();			/* cleanup function for the test */
> @@ -206,6 +208,14 @@ main(int ac, char **av)
>  void
>  setup()
>  {
> +	mount_point = (char *)malloc(sizeof(char) * strlen(Hopt));
> +	mount_point = strcpy(mount_point, Hopt);
> +
> +	tst_require_root(tst_exit);
> +
> +	mount_hugetlbfs(mount_point);
> +	hugepage_alloc(1024);
> +
>  	char mypid[40];
>  
>  	sprintf(mypid,"/%d",getpid());
> @@ -232,5 +242,5 @@ cleanup()
>  	TEST_CLEANUP;
>  
>  	unlink(TEMPFILE);
> -
> +	umount_hugetlbfs(mount_point);
>  }

And here.

> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/lib/Makefile b/testcases/kernel/mem/hugetlb/hugemmap/lib/Makefile
> new file mode 100644
> index 0000000..f37b87a
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/lib/Makefile
> @@ -0,0 +1,25 @@
> +#
> +#  Copyright (c) International Business Machines  Corp., 2001
> +#
> +#  This program is free software;  you can redistribute it and/or modify
> +#  it under the terms of the GNU General Public License as published by
> +#  the Free Software Foundation; either version 2 of the License, or
> +#  (at your option) any later version.
> +#
> +#  This program is distributed in the hope that it will be useful,
> +#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
> +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> +#  the GNU General Public License for more details.
> +#
> +#  You should have received a copy of the GNU General Public License
> +#  along with this program;  if not, write to the Free Software
> +#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> +#
> +
> +top_srcdir		?= ../../../../../..
> +
> +include $(top_srcdir)/include/mk/env_pre.mk
> +
> +LIB			:= libmnt_hugetlb.a
> +
> +include $(top_srcdir)/include/mk/lib.mk
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/lib/libmnt.c b/testcases/kernel/mem/hugetlb/hugemmap/lib/libmnt.c
> new file mode 100644
> index 0000000..618d08b
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/lib/libmnt.c
> @@ -0,0 +1,69 @@
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
> + *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> + */
> +
> +/*
> + * NAME
> + *	libmnt.c
> + *
> + * DESCRIPTION
> + *	Helper functions for mounting hugetlbfs automatically.
> + *
> + *	The library contains the following routines:
> + *
> + *	hugepage_alloc()
> + *	mount_hugetlbfs()
> + *	umount_hugetlbfs()
> + */

This comment isn't IMHO usefull either, I could see the header file for
knowing which fucntions are implemented there...

> +#include "libmnt.h"
> +
> +void
> +hugepage_alloc(int num)
> +{
> +	FILE *nr_hugepages_file = NULL;
> +	nr_hugepages_file = fopen("/proc/sys/vm/nr_hugepages", "w+");
> +	if (nr_hugepages_file == NULL) {
> +		tst_brkm(TBROK|TERRNO, NULL, "fopen failed on /proc/sys/vm/nr_hugepages");
> +	}
> +
> +	if (fprintf(nr_hugepages_file, "%d", num) < 0) {
> +		tst_brkm(TBROK|TERRNO, NULL, "fprintf failed on /proc/sys/vm/nr_hugepages");
> +	}
> +
> +	fclose(nr_hugepages_file);
> +}

I would use here just 'file' or something like that instead of
'nr_hugepages_file' and there is no reasont to initalize it to NULL.

> +void
> +mount_hugetlbfs(char *mount_point)
> +{
> +	if (mkdir(mount_point, 0755) < 0) {
> +		tst_brkm(TBROK|TERRNO, NULL, "mkdir failed on %s", mount_point);
> +	}
> +
> +	if (mount("none", mount_point, "hugetlbfs", 0, NULL) < 0) {
> +		tst_brkm(TBROK|TERRNO, NULL, "mount failed on %s", mount_point);
> +	}
> +}
> +
> +void
> +umount_hugetlbfs(char *mount_point)
> +{
> +	umount(mount_point);
> +	remove(mount_point);
> +}
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/lib/libmnt.h b/testcases/kernel/mem/hugetlb/hugemmap/lib/libmnt.h
> new file mode 100644
> index 0000000..792c831
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/lib/libmnt.h
> @@ -0,0 +1,35 @@
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
> + *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> + */
> +
> +/*
> + * libmnt.h - functions to mount hugetlbfs automatically.
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/mount.h>
> +#include <errno.h>
> +#include <sys/stat.h>
> +
> +#include "test.h"
> +
> +void hugepage_alloc(int num);
> +void mount_hugetlbfs(char *mount_point);
> +void umount_hugetlbfs(char *mount_point);
> +

Header is missing guards. (these #ifdef __HEADER_NAME_H__ ...)

Also there is no need to include all these headers here, include them in
the C source if needed.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
What Every C/C++ and Fortran developer Should Know!
Read this article and learn how Intel has extended the reach of its 
next-generation tools to help Windows* and Linux* C/C++ and Fortran 
developers boost performance applications - including clusters. 
http://p.sf.net/sfu/intel-dev2devmay
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
