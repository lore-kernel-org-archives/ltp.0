From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 25 Jul 2017 10:07:54 +0200
Subject: [LTP] [PATCH] Test for CVE-2016-7042 in /proc/keys show function
In-Reply-To: <20170725060341.14752-1-fenggw-fnst@cn.fujitsu.com>
References: <20170725060341.14752-1-fenggw-fnst@cn.fujitsu.com>
Message-ID: <87lgnd9bxh.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Guangwen Feng writes:

> Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
> ---
>  runtest/cve                   |  1 +
>  testcases/cve/.gitignore      |  1 +
>  testcases/cve/cve-2016-7042.c | 98 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 100 insertions(+)
>  create mode 100644 testcases/cve/cve-2016-7042.c
>
> diff --git a/runtest/cve b/runtest/cve
> index ee0614a..149d4a2 100644
> --- a/runtest/cve
> +++ b/runtest/cve
> @@ -3,6 +3,7 @@ cve-2012-0957 cve-2012-0957
>  cve-2014-0196 cve-2014-0196
>  cve-2016-4997 cve-2016-4997
>  cve-2016-5195 dirtyc0w
> +cve-2016-7042 cve-2016-7042
>  cve-2016-7117 cve-2016-7117
>  cve-2017-5669 cve-2017-5669
>  cve-2017-6951 cve-2017-6951
> diff --git a/testcases/cve/.gitignore b/testcases/cve/.gitignore
> index bdb73f3..4922bef 100644
> --- a/testcases/cve/.gitignore
> +++ b/testcases/cve/.gitignore
> @@ -1,6 +1,7 @@
>  cve-2012-0957
>  cve-2014-0196
>  cve-2016-4997
> +cve-2016-7042
>  cve-2016-7117
>  cve-2017-6951
>  cve-2017-5669
> diff --git a/testcases/cve/cve-2016-7042.c b/testcases/cve/cve-2016-7042.c
> new file mode 100644
> index 0000000..89c59c9
> --- /dev/null
> +++ b/testcases/cve/cve-2016-7042.c
> @@ -0,0 +1,98 @@
> +/*
> + * Copyright (c) 2017 Fujitsu Ltd.
> + * Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program, if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +/*
> + * Test for CVE-2016-7042, this regression test can crash the buggy kernel
> + * when the stack-protector is enabled, and the bug was fixed in:
> + *
> + *  commit 03dab869b7b239c4e013ec82aea22e181e441cfc
> + *  Author: David Howells <dhowells@redhat.com>
> + *  Date:   Wed Oct 26 15:01:54 2016 +0100
> + *
> + *  KEYS: Fix short sprintf buffer in /proc/keys show function
> + */
> +
> +#include "config.h"
> +#include <errno.h>
> +#include <stdio.h>
> +#include <sys/types.h>
> +#ifdef HAVE_KEYUTILS_H
> +# include <keyutils.h>
> +#endif

This file is only being included for a typedef of int and some
constants, so you could provide fallback definitions if it is not
present. e.g. typedef int32_t key_serial_t. Otherwise it won't compile
on a lot of systems by defualt where the CVE is easily exploitable.

We should probably have something in include/lapi for keyutils, but you
could just include the definitions here as well.

> +#include "tst_test.h"
> +#include "linux_syscall_numbers.h"
> +
> +#ifdef HAVE_KEYUTILS_H
> +
> +#define PATH_KEYS	"/proc/keys"
> +
> +static key_serial_t key;
> +static int fd;
> +
> +static void do_test(void)
> +{
> +	char buf[BUFSIZ];
> +
> +	key = tst_syscall(__NR_add_key,
> +		"user", "ltptestkey", "a", 1, KEY_SPEC_SESSION_KEYRING);
> +	if (key == -1)
> +		tst_brk(TBROK, "Failed to add key");
> +
> +	if (tst_syscall(__NR_keyctl, KEYCTL_UPDATE, key, "b", 1))
> +		tst_brk(TBROK, "Failed to update key");
> +
> +	fd = SAFE_OPEN(PATH_KEYS, O_RDONLY);
> +
> +	// Will cause a panic due to stack corruption if bug occurs
> +	SAFE_READ(0, fd, buf, BUFSIZ);

Please replace the comment with something like tst_res(TINFO,
"Attempting to crash system...").

> +
> +	tst_res(TPASS, "Bug not reproduced");
> +
> +	SAFE_CLOSE(fd);
> +
> +	if (tst_syscall(__NR_keyctl, KEYCTL_UNLINK, key,
> +		KEY_SPEC_SESSION_KEYRING))
> +		tst_brk(TBROK, "Failed to unlink key");
> +	key = 0;
> +}
> +
> +static void setup(void)
> +{
> +	if (access(PATH_KEYS, F_OK))
> +		tst_brk(TCONF, "%s does not exist", PATH_KEYS);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (key > 0 && tst_syscall(__NR_keyctl, KEYCTL_UNLINK, key,
> +		KEY_SPEC_SESSION_KEYRING))
> +		tst_res(TWARN, "Failed to unlink key");
> +
> +	if (fd > 0)
> +		SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = do_test,
> +};
> +
> +#else
> +	TST_TEST_TCONF("keyutils.h does not exist");
> +#endif /* HAVE_KEYUTILS_H */
> -- 
> 2.9.4

Great!

-- 
Thank you,
Richard.
