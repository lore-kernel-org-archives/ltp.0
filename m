Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1XF4FD-0006QG-I6
	for ltp-list@lists.sourceforge.net; Wed, 06 Aug 2014 16:39:19 +0000
Received: from mail-pd0-f182.google.com ([209.85.192.182])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1XF4F7-00085Q-HD
	for ltp-list@lists.sourceforge.net; Wed, 06 Aug 2014 16:39:19 +0000
Received: by mail-pd0-f182.google.com with SMTP id fp1so3593441pdb.13
	for <ltp-list@lists.sourceforge.net>;
	Wed, 06 Aug 2014 09:39:04 -0700 (PDT)
Message-ID: <53E25A90.40303@casparzhang.com>
Date: Thu, 07 Aug 2014 00:40:48 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <e6cf00e941296bfd4d10edc44f1b9980a8b19489.1407313325.git.jstancek@redhat.com>
In-Reply-To: <e6cf00e941296bfd4d10edc44f1b9980a8b19489.1407313325.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH v2] madvise05: new testcase for Oops in
	madvise_willneed
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
To: Jan Stancek <jstancek@redhat.com>, ltp-list@lists.sourceforge.net

On 08/06/2014 04:31 PM, Jan Stancek wrote:
> This is a regression test for madvise(2) system call. It tests
> kernel for NULL ptr deref Oops fixed by:
>    commit ee53664bda169f519ce3c6a22d378f0b946c8178
>    Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>    Date:   Fri Dec 20 15:10:03 2013 +0200
>      mm: Fix NULL pointer dereference in madvise(MADV_WILLNEED) support
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
Acked-by: Caspar Zhang <caspar@casparzhang.com>

> ---
> Changes in v2:
> 1. exclude this test from kernels < 3.9.
>     Older kernels do not support swap file prefetch,
>     which caused madvise to return EBADF. And if backing file is
>     added to mmap, reproducer no longer works.
>
>   runtest/syscalls                              |    1 +
>   testcases/kernel/syscalls/.gitignore          |    1 +
>   testcases/kernel/syscalls/madvise/madvise05.c |   90 +++++++++++++++++++++++++
>   3 files changed, 92 insertions(+), 0 deletions(-)
>   create mode 100644 testcases/kernel/syscalls/madvise/madvise05.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 5e6e0f4..142c350 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -715,6 +715,7 @@ madvise01 madvise01
>   madvise02 madvise02
>   madvise03 madvise03
>   madvise04 madvise04
> +madvise05 madvise05
>
>   newuname01 newuname01
>
> diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
> index fb2425e..fd52217 100644
> --- a/testcases/kernel/syscalls/.gitignore
> +++ b/testcases/kernel/syscalls/.gitignore
> @@ -479,6 +479,7 @@
>   /madvise/madvise02
>   /madvise/madvise03
>   /madvise/madvise04
> +/madvise/madvise05
>   /mallopt/mallopt01
>   /mbind/mbind01
>   /memcmp/memcmp01
> diff --git a/testcases/kernel/syscalls/madvise/madvise05.c b/testcases/kernel/syscalls/madvise/madvise05.c
> new file mode 100644
> index 0000000..384dea7
> --- /dev/null
> +++ b/testcases/kernel/syscalls/madvise/madvise05.c
> @@ -0,0 +1,90 @@
> +/*
> + *  Copyright (c) Linux Test Project, 2014
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU Library General Public License for more details.
> + */
> +/*
> + * This is a regression test for madvise(2) system call. It tests kernel
> + * for NULL ptr deref Oops fixed by:
> + *   commit ee53664bda169f519ce3c6a22d378f0b946c8178
> + *   Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> + *   Date:   Fri Dec 20 15:10:03 2013 +0200
> + *     mm: Fix NULL pointer dereference in madvise(MADV_WILLNEED) support
> + *
> + * On buggy kernel with CONFIG_TRANSPARENT_HUGEPAGE=y CONFIG_DEBUG_LOCK_ALLOC=y
> + * this testcase should produce Oops and/or be killed. On fixed/good kernel
> + * this testcase runs to completion (retcode is 0)
> + */
> +
> +#include <sys/mman.h>
> +#include <errno.h>
> +
> +#include "test.h"
> +#include "usctest.h"
> +#include "safe_macros.h"
> +
> +#define ALLOC_SIZE (32 * 1024 * 1024)
> +
> +static void setup(void);
> +static void cleanup(void);
> +
> +char *TCID = "madvise05";
> +int TST_TOTAL = 1;
> +
> +int main(int argc, char *argv[])
> +{
> +	int lc;
> +	const char *msg = NULL;
> +	void *p;
> +
> +	msg = parse_opts(argc, argv, NULL, NULL);
> +	if (msg)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		p = SAFE_MMAP(cleanup, NULL, ALLOC_SIZE, PROT_READ,
> +			MAP_PRIVATE | MAP_ANONYMOUS | MAP_POPULATE, -1, 0);
> +		TEST(mprotect(p, ALLOC_SIZE, PROT_NONE));
> +		if (TEST_RETURN == -1)
> +			tst_brkm(TBROK | TTERRNO, cleanup, "mprotect failed");
> +		TEST(madvise(p, ALLOC_SIZE, MADV_WILLNEED));
> +		SAFE_MUNMAP(cleanup, p, ALLOC_SIZE);
> +
> +		if (TEST_RETURN == 0)
> +			continue;
> +
> +		if (TEST_ERRNO == EBADF)
> +			tst_brkm(TCONF, cleanup, "CONFIG_SWAP=n");
> +		else
> +			tst_brkm(TBROK | TTERRNO, cleanup, "madvise failed");
> +	}
> +
> +	tst_resm(TPASS, "issue has not been reproduced");
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void setup(void)
> +{
> +	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +	if (tst_kvercmp(3, 9, 0) < 0)
> +		tst_brkm(TCONF, NULL, "madvise(MADV_WILLNEED) swap file "
> +			"prefetch available only since 3.9");
> +	TEST_PAUSE;
> +}
> +
> +static void cleanup(void)
> +{
> +	TEST_CLEANUP;
> +}
>


------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
