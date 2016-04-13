From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 13 Apr 2016 17:56:57 +0200
Subject: [LTP] [PATCH v2 1/2] request_key/request_key01.c: add new
	testcase
In-Reply-To: <1458113314-29731-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20160309145331.GG28171@rei.lan>
 <1458113314-29731-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20160413155657.GF11529@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
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

This is ugly hack. The header does not need to be in the standard path
at all. What you should do instead is to call
AC_SUBST([KEYUTIL_LIBS, ...) in the configure part and do
LDLIBS+=$(KEYUTILS_LIBS) here. Have a look at the m4/ltp-acl.m4 or
m4/ltp-cap.m4 for instance.

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

What do we create the temporary directory for? The test does not seem to
work with files at all.

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
                                            ^

				Technically it didn't fail, but only
				stub was compiled due to missing
				library.

It should say something as:

	"keyutils.h was missing at compilation"

> +}
> +#endif /* HAVE_LINUX_KEYCTL_H */
> -- 
> 1.8.3.1
> 
> 
> 

-- 
Cyril Hrubis
chrubis@suse.cz
