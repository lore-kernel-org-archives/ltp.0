From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 13 Apr 2016 16:02:05 +0800
Subject: [LTP] [PATCH v2 1/2] request_key/request_key01.c: add new
	testcase
In-Reply-To: <1458113314-29731-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20160309145331.GG28171@rei.lan>
 <1458113314-29731-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <570DFCFD.7060109@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

ping :-)

Thanks
Xiao Yang
> The testcase checks basic functionality of the request_key(2).
> request_key(2) asks the kernel to find a key which matches the
> specified description. If successful, it attaches it to the
> nominated keyring and returns its serial number.
>
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  configure.ac                                       |   1 +
>  runtest/ltplite                                    |   2 +
>  runtest/syscalls                                   |   2 +
>  testcases/kernel/syscalls/.gitignore               |   1 +
>  testcases/kernel/syscalls/request_key/Makefile     |  27 ++++++
>  .../kernel/syscalls/request_key/request_key01.c    | 103 +++++++++++++++++++++
>  6 files changed, 136 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/request_key/Makefile
>  create mode 100644 testcases/kernel/syscalls/request_key/request_key01.c
>
> diff --git a/configure.ac b/configure.ac
> index b065fe6..96f9a0b 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -45,6 +45,7 @@ AC_CHECK_HEADERS([ \
>      sys/fanotify.h \
>      sys/jfsdmapi.h \
>      sys/prctl.h \
> +    keyutils.h \
>  ])
>  
>  # Tools knobs
> diff --git a/runtest/ltplite b/runtest/ltplite
> index fa52588..e3dd403 100644
> --- a/runtest/ltplite
> +++ b/runtest/ltplite
> @@ -668,6 +668,8 @@ rename12 rename12
>  rename13 rename13
>  rename14 rename14
>  
> +request_key01 request_key01
> +
>  rmdir01 rmdir01
>  rmdir02 rmdir02
>  rmdir03 rmdir03
> diff --git a/runtest/syscalls b/runtest/syscalls
> index b41c927..e442297 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -896,6 +896,8 @@ renameat01 renameat01
>  renameat201 renameat201
>  renameat202 renameat202 -i 10
>  
> +request_key01 request_key01
> +
>  rmdir01 rmdir01
>  rmdir02 rmdir02
>  rmdir03 rmdir03
> diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
> index 0540928..92dbda4 100644
> --- a/testcases/kernel/syscalls/.gitignore
> +++ b/testcases/kernel/syscalls/.gitignore
> @@ -740,6 +740,7 @@
>  /renameat/renameat01
>  /renameat2/renameat201
>  /renameat2/renameat202
> +/request_key/request_key01
>  /rmdir/rmdir01
>  /rmdir/rmdir02
>  /rmdir/rmdir03
> diff --git a/testcases/kernel/syscalls/request_key/Makefile b/testcases/kernel/syscalls/request_key/Makefile
> new file mode 100644
> index 0000000..2ee14a9
> --- /dev/null
> +++ b/testcases/kernel/syscalls/request_key/Makefile
> @@ -0,0 +1,27 @@
> +#  Copyright (c) 2016 Fujitsu Ltd.
> +#  Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
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
> +#  along with this program.
> +#
> +
> +top_srcdir		?= ../../../..
> +have_keyutil		?= /usr/include/keyutils.h
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +ifeq ($(have_keyutil), $(wildcard $(have_keyutil)))
> +LDLIBS		+= -lkeyutils
> +endif
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/request_key/request_key01.c b/testcases/kernel/syscalls/request_key/request_key01.c
> new file mode 100644
> index 0000000..9d99e85
> --- /dev/null
> +++ b/testcases/kernel/syscalls/request_key/request_key01.c
> @@ -0,0 +1,103 @@
> +/*
> +* Copyright (c) 2016 Fujitsu Ltd.
> +* Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> +*
> +* This program is free software; you can redistribute it and/or modify it
> +* under the terms of version 2 of the GNU General Public License as
> +* published by the Free Software Foundation.
> +*
> +* This program is distributed in the hope that it would be useful, but
> +* WITHOUT ANY WARRANTY; without even the implied warranty of
> +* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> +*
> +* You should have received a copy of the GNU General Public License
> +* alone with this program.
> +*/
> +
> +/*
> +* Test Name: request_key01
> +*
> +* Description:
> +* The testcase checks basic functionality of the request_key(2).
> +* request_key(2) asks the kernel to find a key which matches the
> +* specified description. If successful, it attaches it to the
> +* nominated keyring and returns its serial number.
> +*
> +*/
> +
> +#include "config.h"
> +#include <errno.h>
> +#include <sys/types.h>
> +#ifdef HAVE_KEYUTILS_H
> +#include <keyutils.h>
> +#endif
> +
> +#include "test.h"
> +
> +char *TCID = "request_key01";
> +
> +static int res;
> +
> +static void verify_request_key(void);
> +static void setup(void);
> +static void cleanup(void);
> +
> +int TST_TOTAL = 1;
> +
> +#ifdef HAVE_KEYUTILS_H
> +int main(int ac, char **av)
> +{
> +	int lc;
> +
> +	tst_parse_opts(ac, av, NULL, NULL);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		tst_count = 0;
> +
> +		verify_request_key();
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void verify_request_key(void)
> +{
> +	TEST(request_key("keyring", "ltp", NULL, KEY_REQKEY_DEFL_DEFAULT));
> +	if (TEST_RETURN == -1) {
> +		tst_resm(TFAIL | TERRNO, "request_key() failed");
> +		return;
> +	}
> +
> +	if (TEST_RETURN != res)
> +		tst_resm(TFAIL, "serial number mismatched");
> +	else
> +		tst_resm(TPASS, "request_key() succeed");
> +}
> +
> +static void setup(void)
> +{
> +	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +
> +	TEST_PAUSE;
> +
> +	tst_tmpdir();
> +
> +	res = add_key("keyring", "ltp", NULL, 0, KEY_SPEC_THREAD_KEYRING);
> +	if (res == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "add_key() failed");
> +}
> +
> +static void cleanup(void)
> +{
> +	tst_rmdir();
> +}
> +
> +#else
> +int main(void)
> +{
> +	tst_brkm(TCONF, NULL, "compilation failed without keyutils.h");
> +}
> +#endif /* HAVE_LINUX_KEYCTL_H */



