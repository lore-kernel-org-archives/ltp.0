From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 6 Jun 2017 14:06:56 +0200
Subject: [LTP] [PATCH 2/2] syscalls/add_key03: add test for NULL payload
 with nonzero length
In-Reply-To: <20170605174811.95267-3-ebiggers3@gmail.com>
References: <20170605174811.95267-1-ebiggers3@gmail.com>
 <20170605174811.95267-3-ebiggers3@gmail.com>
Message-ID: <20170606120656.GB5208@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/add_key/add_key03.c b/testcases/kernel/syscalls/add_key/add_key03.c
> new file mode 100644
> index 000000000..21812710f
> --- /dev/null
> +++ b/testcases/kernel/syscalls/add_key/add_key03.c
> @@ -0,0 +1,104 @@
> +/*
> + * Copyright (c) 2017 Google, Inc.
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
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "config.h"
> +#ifdef HAVE_LINUX_KEYCTL_H
> +# include <linux/keyctl.h>
> +#endif
> +#include "tst_test.h"
> +#include "linux_syscall_numbers.h"
> +
> +/*
> + * Test that the add_key() syscall correctly handles a NULL payload with nonzero
> + * length.  Specifically, it should fail with EFAULT rather than oopsing the
> + * kernel with a NULL pointer dereference or failing with EINVAL, as it did
> + * before (depending on the key type).  This is a regression test for "KEYS: fix
> + * dereferencing NULL payload with nonzero length".

Can you pretty please add the kernel commit hash here as well?

> + * Note that none of the key types that exhibited the NULL pointer dereference
> + * are guaranteed to be built into the kernel, so we just test as many as we
> + * can, in the hope of catching one.  We also test with the "user" key type for
> + * good measure, although it was one of the types that failed with EINVAL rather
> + * than dereferencing NULL.
> + */
> +
> +#ifdef HAVE_LINUX_KEYCTL_H
> +struct tcase {
> +	const char *type;
> +	size_t plen;
> +} tcases[] = {
> +	/*
> +	 * The payload length we test for each key type needs to pass initial
> +	 * validation but is otherwise arbitrary.  Note: the "rxrpc_s" key type
> +	 * requires a payload of exactly 8 bytes.
> +	 */
> +	{ "asymmetric",		64 },
> +	{ "cifs.idmap",		64 },
> +	{ "cifs.spnego",	64 },
> +	{ "pkcs7_test",		64 },
> +	{ "rxrpc",		64 },
> +	{ "rxrpc_s",		 8 },
> +	{ "user",		64 },
> +};
> +#endif /* HAVE_LINUX_KEYCTL_H */
> +
> +static void verify_add_key(unsigned int i)
> +{
> +#ifdef HAVE_LINUX_KEYCTL_H
> +	TEST(tst_syscall(__NR_add_key, tcases[i].type, "abc:def",
> +			 NULL, tcases[i].plen, KEY_SPEC_PROCESS_KEYRING));
> +
> +	if (TEST_RETURN != -1) {
> +		tst_res(TFAIL,
> +			"add_key() with key type \"%s\" unexpectedly succeeded",
                                                  ^
						  And we tend to use
						  single quotes that
						  does not have to be
						  escaped. But that is
						  very minor.

Otherwise the test looks good to me.


-- 
Cyril Hrubis
chrubis@suse.cz
