Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Rfm59-0006sV-WE
	for ltp-list@lists.sourceforge.net; Wed, 28 Dec 2011 05:29:44 +0000
Received: from mail-yx0-f175.google.com ([209.85.213.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Rfm59-0006M9-3w
	for ltp-list@lists.sourceforge.net; Wed, 28 Dec 2011 05:29:43 +0000
Received: by yenm12 with SMTP id m12so7686880yen.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 27 Dec 2011 21:29:37 -0800 (PST)
Message-ID: <4EFAA763.4030607@casparzhang.com>
Date: Wed, 28 Dec 2011 13:21:39 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1322044169-30851-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<1322044169-30851-2-git-send-email-gaowanlong@cn.fujitsu.com>
In-Reply-To: <1322044169-30851-2-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 1/5] A library used to mount hugetlbfs
	automatically.
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On 11/23/2011 06:29 PM, Wanlong Gao wrote:
> This library includes a set of functions used to mount hugetlbfs automatically when doing the hugemmap tests.
> 
> Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> ---
>  testcases/kernel/mem/hugetlb/hugemmap/Makefile |    6 ++-
>  testcases/kernel/mem/hugetlb/hugemmap/libmnt.c |   58 ++++++++++++++++++++++++
>  testcases/kernel/mem/hugetlb/hugemmap/libmnt.h |   25 ++++++++++
>  3 files changed, 88 insertions(+), 1 deletions(-)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/libmnt.c
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/libmnt.h
> 
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/Makefile b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
> index a1ba46e..e6ba4fe 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/Makefile
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
> @@ -23,5 +23,9 @@
>  top_srcdir              ?= ../../../../..
>  
>  include $(top_srcdir)/include/mk/testcases.mk
> -include $(abs_srcdir)/../Makefile.inc
> +
> +MAKE_TARGETS	:= $(filter-out libmnt,$(patsubst $(abs_srcdir)/%.c,%,$(wildcard $(abs_srcdir)/*.c)))
> +
> +$(MAKE_TARGETS): %: %.o libmnt.o
> +
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/libmnt.c b/testcases/kernel/mem/hugetlb/hugemmap/libmnt.c
> new file mode 100644
> index 0000000..bf6f857
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/libmnt.c
> @@ -0,0 +1,58 @@
> +/*
> + *
> + *   Copyright (c) Fujitsu Corp., 2011
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
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/mount.h>
> +#include <errno.h>
> +
> +#include "test.h"
> +#include "libmnt.h"
> +
> +void
> +hugepage_alloc(int num)

It's not necessary to put it into 2 lines.

> +{
> +	FILE *file = fopen("/proc/sys/vm/nr_hugepages", "w+");
> +	if (file == NULL) {
> +		tst_brkm(TBROK|TERRNO, NULL,
> +			"fopen failed on /proc/sys/vm/nr_hugepages");
> +	}
> +
> +	if (fprintf(file, "%d", num) < 0) {
> +		tst_brkm(TBROK|TERRNO, NULL,
> +			"fprintf failed on /proc/sys/vm/nr_hugepages");
> +	}
> +
> +	fclose(file);
> +}
> +
> +void
> +mount_hugetlbfs(char *mount_point)
> +{
> +	if (mount("none", mount_point, "hugetlbfs", 0, NULL) < 0) {
> +		tst_brkm(TBROK|TERRNO, NULL,
> +			"mount failed on %s", mount_point);
> +	}
> +}
> +
> +void
> +umount_hugetlbfs(char *mount_point)
> +{
> +	umount(mount_point);

You should check the return code and errno for it.

> +}
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/libmnt.h b/testcases/kernel/mem/hugetlb/hugemmap/libmnt.h
> new file mode 100644
> index 0000000..dc1ceed
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/libmnt.h
> @@ -0,0 +1,25 @@
> +/*
> + *   Copyright (c) Fujitsu  Corp., 2011
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
> + *   libmnt.h - functions to mount hugetlbfs automatically.
> + */
> +
> +void hugepage_alloc(int num);
> +void mount_hugetlbfs(char *mount_point);
> +void umount_hugetlbfs(char *mount_point);


------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
