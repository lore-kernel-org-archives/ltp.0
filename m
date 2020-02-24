From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 24 Feb 2020 16:31:12 +0100
Subject: [LTP] [PATCH] syscalls/add_key05: add maxbytes/maxkeys test
 under unprivileged user
In-Reply-To: <1581081297-20034-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1581081297-20034-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200224153112.GB2210@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 577a4a527..df7bbcbf1 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -18,6 +18,7 @@ add_key01 add_key01
>  add_key02 add_key02
>  add_key03 add_key03
>  add_key04 add_key04
> +add_key05 add_key05
>  
>  adjtimex01 adjtimex01
>  adjtimex02 adjtimex02
> diff --git a/testcases/kernel/syscalls/add_key/.gitignore b/testcases/kernel/syscalls/add_key/.gitignore
> index b9a04214d..f57dc2228 100644
> --- a/testcases/kernel/syscalls/add_key/.gitignore
> +++ b/testcases/kernel/syscalls/add_key/.gitignore
> @@ -2,3 +2,4 @@
>  /add_key02
>  /add_key03
>  /add_key04
> +/add_key05
> diff --git a/testcases/kernel/syscalls/add_key/add_key05.c b/testcases/kernel/syscalls/add_key/add_key05.c
> new file mode 100644
> index 000000000..0d5e9db28
> --- /dev/null
> +++ b/testcases/kernel/syscalls/add_key/add_key05.c
> @@ -0,0 +1,180 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
> + * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> + *
> + *Description:
> + * Test unprivileged user can support the number of keys and the
> + * number of bytes consumed in payloads of the keys.The defalut value
> + * is 200 and 20000.
> + * This is also a regresstion test for
> + * commit a08bf91ce28e ("KEYS: allow reaching the keys quotas exact")
> + *
> + */
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <pwd.h>
> +#include "tst_test.h"
> +#include "lapi/keyctl.h"
> +
> +static char *user_buf, *user_buf1, *keyring_buf;
> +static const char *username = "ltp_add_key05";
> +static int user_added;
> +struct passwd *ltpuser;
> +static unsigned int used_bytes, max_bytes, used_key, max_key, data_len;
> +char fmt[1024];
> +int flag[2] = {1, 0};
> +
> +void add_user(void)
> +{
> +	if (user_added)
> +		return;
> +
> +	const char *const cmd_useradd[] = {"useradd", username, NULL};
> +	int rc;
> +
> +	switch ((rc = tst_run_cmd(cmd_useradd, NULL, NULL, 1))) {
> +	case 0:
> +		user_added = 1;
> +		ltpuser = SAFE_GETPWNAM(username);
> +		break;
> +	case 1:
> +	case 255:
> +		break;
> +	default:
> +		tst_brk(TBROK, "Useradd failed (%d)", rc);
> +	}
> +	sprintf(fmt, "%5u: %%*5d %%*d/%%*d %%d/%%d %%d/%%d", ltpuser->pw_uid);
> +}
> +
> +void clean_user(void)
> +{
> +	if (!user_added)
> +		return;
> +
> +	const char *const cmd_userdel[] = {"userdel", "-r", username, NULL};
> +
> +	if (tst_run_cmd(cmd_userdel, NULL, NULL, 1))
> +		tst_res(TWARN | TERRNO, "'userdel -r %s' failed", username);
> +	else
> +		user_added = 0;
> +}
> +
> +void verify_max_btyes(void)
> +{
> +	char *buf, *invalid_buf;
> +	int plen, invalid_plen;
> +
> +	tst_res(TINFO, "test max bytes under unprivileged user");
> +	invalid_plen = max_bytes - used_bytes - data_len - 8;

What is the -8 for, strlen("test_inv")?

I guess that it will be more readable if we used the strlen() here as
well.

> +	plen = invalid_plen - 1;
> +	buf = tst_alloc(plen);
> +	invalid_buf = tst_alloc(invalid_plen);
> +
> +	TEST(add_key("user", "test_inv", invalid_buf, invalid_plen, KEY_SPEC_THREAD_KEYRING));
> +	if (TST_RET != -1)
> +		tst_res(TFAIL, "add_key(test_inv) succeeded unexpectedltly");
> +	else {
> +		if (TST_ERR == EDQUOT)
> +			tst_res(TPASS | TTERRNO, "add_key(test_inv) failed as expected");
> +		else
> +			tst_res(TFAIL | TTERRNO, "add_key(test_inv) failed expected EDQUOT got");
> +	}
> +
> +	TEST(add_key("user", "test_max", buf, plen, KEY_SPEC_THREAD_KEYRING));
> +	if (TST_RET != -1) {
> +		tst_res(TPASS, "add_key(test_max) succeeded as expected");
> +		SAFE_FILE_LINES_SCANF("/proc/key-users", fmt, &used_key, &max_key, &used_bytes, &max_bytes);
> +		if (used_bytes == max_bytes)
> +			tst_res(TPASS, "allow reaching the max bytes exactly");
> +		else
> +			tst_res(TFAIL, "max used bytes %u, key allow max bytes %u", used_bytes, max_bytes);
> +	} else
> +		tst_res(TFAIL | TTERRNO, "add_key(test_max) failed unexpectedly");
> +}
> +
> +void verify_max_keys(void)
> +{
> +	unsigned int i;
> +	char desc[10];
> +
> +	tst_res(TINFO, "test max keys under unprivileged user");
> +	for (i = used_key + 1; i < max_key; i++) {
> +		sprintf(desc, "abc%d", i);
> +		TEST(add_key("keyring", desc, keyring_buf, 0, KEY_SPEC_THREAD_KEYRING));
> +		if (TST_RET == -1)
> +			tst_res(TFAIL | TTERRNO, "add keyring key(%s) failed", desc);

Why we are using the "keyring" ring here instead? I doubt that it
matters for the quota, but it just seems strange.

Also we should stop the loop on a first failure, I guess that goto
count: would suffice.

> +	}
> +
> +	TEST(add_key("keyring", "abc200", keyring_buf, 0, KEY_SPEC_THREAD_KEYRING));
> +
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TTERRNO, "add keyring key(abc200) failed");
> +		goto count;
> +	} else
> +		tst_res(TPASS, "add keyring key(abc200) succedd");

Why don't we just start the loop above at used_key? There is no point in
adding the last key here outside of the loop.

> +	TEST(add_key("keyring", "abc201", keyring_buf, 0, KEY_SPEC_THREAD_KEYRING));
> +	if (TST_RET != -1) {
> +		tst_res(TFAIL, "add keyring key(abc201) succeeded unexpectedly");
> +		goto count;

We should add a key with a different name than the previous "abc%d"
pattern here, if the upper limit was over 200 we would just replace a
key here instread which will not fail at all.

> +	} else {
> +		if (TST_ERR == EDQUOT)
> +			tst_res(TPASS | TTERRNO, "add keyring key(abc201) failed as expected over max key");
> +		else
> +			tst_res(TFAIL | TTERRNO, "add_keyring failed expected EDQUOT got");
> +	}
> +count:
> +	SAFE_FILE_LINES_SCANF("/proc/key-users", fmt, &used_key, &max_key, &used_bytes, &max_bytes);
> +	if (used_key == max_key)
> +		tst_res(TPASS, "allow reaching the max key exactly");
> +	else
> +		tst_res(TFAIL, "max used key %u, key allow max key %u", used_key, max_key);
> +}
> +
> +static void do_test(unsigned int n)
> +{
> +	add_user();
> +	int f_used_bytes = 0;
> +
> +	if (!SAFE_FORK()) {
> +		SAFE_SETUID(ltpuser->pw_uid);
> +
> +		TEST(add_key("user", "test1", user_buf, 64, KEY_SPEC_THREAD_KEYRING));
> +		if (TST_RET == -1)
> +			tst_brk(TFAIL | TTERRNO, "add key test1 failed");
> +		SAFE_FILE_LINES_SCANF("/proc/key-users", fmt, &used_key, &max_key, &used_bytes, &max_bytes);
> +		f_used_bytes = used_bytes;
> +
> +		TEST(add_key("user", "test2", user_buf1, 64, KEY_SPEC_THREAD_KEYRING));
> +		if (TST_RET == -1)
> +			tst_brk(TFAIL | TTERRNO, "add key test2 failed");

Do we really need to pass a different users_buf to each call?

> +		SAFE_FILE_LINES_SCANF("/proc/key-users", fmt, &used_key, &max_key, &used_bytes, &max_bytes);
> +
> +		data_len = used_bytes - f_used_bytes - strlen("test1") - 1 - 64;

So this code here is used to determine how much data will consume the
key structure in kernel itself? I guess that this is useless to run in
the case of testing for maximal number of keys, right? Can we put this
code into a function something as get_kernel_key_data_size() and call it
from the verify_max_bytes() only?

I guess that the SAFE_FILE_LINES_SCANF() intializes the max_key for the
max_keys test. Having a global variables that are initalized in random
places makes the code really confusing, can we avoid that if poissible
please?

I guess that we can at least create:

parse_proc_key_users(int *used_keys, int *max_key, int *used_bytes, *int max_bytes)

function that would read the values into a local variables and copy the
results only if non-NULL pointers were passed.

That way the verify_max_keys() would call:
parse_proc_key_users(NULL, &max_keys, NULL, NULL);
and use the result for the loop that adds the keys.

> +		if (flag[n])

Huh, why not just if (n)?

> +			verify_max_btyes();
> +		else
> +			verify_max_keys();
> +		exit(0);
> +	}
> +	tst_reap_children();
> +	clean_user();

What is the reason to add and remove a user for each iteration?

Aare you cleaning the keys that way?

> +}
> +
> +static struct tst_test test = {
> +	.test = do_test,
> +	.tcnt = 2,
> +	.needs_root = 1,
> +	.forks_child = 1,
> +	.cleanup = clean_user,
> +	.bufs = (struct tst_buffers []) {
> +		{&keyring_buf, .size = 1},
> +		{&user_buf, .size = 64},
> +		{&user_buf1, .size = 64},
> +		{}
> +	},
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "a08bf91ce28"},
> +		{}
> +	}
> +};
> -- 
> 2.18.0
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
