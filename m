From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 9 Mar 2016 15:44:44 +0100
Subject: [LTP] [PATCH 1/2] request_key/request_key01.c: add new testcase
In-Reply-To: <1456732418-10557-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1456732418-10557-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20160309144444.GF28171@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> --- /dev/null
> +++ b/testcases/kernel/syscalls/request_key/request_key01.c
> @@ -0,0 +1,107 @@
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
> +* The testcase checks the basic functionality of the request_key(2).
> +* request_key(2) asks the kernel to find a key which matches the
> +* specified description. If successful, it attaches it to the nominated
> +* keyring and returns its serial number.
> +*
> +*/
> +
> +#include "config.h"
> +#include <errno.h>
> +
> +#ifdef HAVE_LINUX_KEYCTL_H
> +#include <linux/keyctl.h>
> +#endif
> +
> +#include "test.h"
> +#include "linux_syscall_numbers.h"
> +
> +char *TCID = "request_key01";
> +
> +#ifdef HAVE_LINUX_KEYCTL_H
> +
> +static void verify_request_key(void);
> +static void setup(void);
> +static void cleanup(void);
> +
> +int TST_TOTAL = 1;
> +
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
> +	int res;
> +
> +	res = ltp_syscall(__NR_add_key, "keyring", "ltp", NULL, 0, KEY_SPEC_THREAD_KEYRING);

You should not call the add_key directly via syscall here.

Ideally you should add a common wrapper into a shared header and
possibly use keyutils library, if it's available.

And the same goes for KEY_SPEC_THREAD_KEYRING. There is no reason to
ifdef the whole testcases out if this value is not defined. You just
have to add a lapi/keyctl.h header with fallback definitons.

> +	if (res == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "add_key() failed");

This part should be done in setup, shoudldn't it?

> +	TEST(ltp_syscall(__NR_request_key, "keyring", "ltp", NULL, KEY_SPEC_PROCESS_KEYRING));
> +	if (TEST_RETURN == -1) {
> +		tst_resm(TFAIL | TERRNO, "request_key() failed");
> +		return;
> +	}

Same here.

> +	if (TEST_RETURN != res)
> +		tst_resm(TFAIL, "serial number mismatched");
> +	else
> +		tst_resm(TPASS, "request_key() succeed");
> +}
> +
> +static void setup(void)
> +{
> +	tst_require_root();
> +
> +	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +
> +	TEST_PAUSE;
> +
> +	tst_tmpdir();
> +}
> +
> +static void cleanup(void)
> +{
> +	tst_rmdir();
> +}
> +
> +#else
> +int main(int ac, char **av)
> +{
> +	tst_brkm(TCONF, NULL, "linux/keyctl.h was missing upon compilation.");
> +}
> +#endif

-- 
Cyril Hrubis
chrubis@suse.cz
