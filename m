From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 21 Jan 2020 16:13:43 +0100
Subject: [LTP] [PATCH 1/2] syscalls/add_key05: add new test for the
 length of payload
In-Reply-To: <1579420198-29651-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1579420198-29651-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200121151342.GD6337@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Seeing add_key manpages, the lenth of payload for "user"/"logon"
> is 32767, this value is up tp 1M for "big_key". For "keyring" type
> , this value is zero.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>  runtest/syscalls                              |  1 +
>  testcases/kernel/syscalls/add_key/.gitignore  |  1 +
>  testcases/kernel/syscalls/add_key/add_key05.c | 99 +++++++++++++++++++
>  3 files changed, 101 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/add_key/add_key05.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index f58fefe17..830dfc8b7 100644
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
> index 000000000..a6d4c1a02
> --- /dev/null
> +++ b/testcases/kernel/syscalls/add_key/add_key05.c
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
> + * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> + *
> + * This case test various key type can support how many long
> + * bytes payload.
> + * keyring: 0 bytes
> + * user/logon: 32767 bytes
> + * big_key: 1M -1byte
> + */
> +
> +#include <errno.h>
> +#include "tst_test.h"
> +#include "lapi/keyctl.h"
> +
> +struct tcase {
> +	const char *type;
> +	const char *desc;
> +	size_t plen;
> +	int pass_flag;
> +	char *message;
> +} tcases[] = {
> +	{"keyring", "abc", 0, 1,
> +	"The key type is keyrings and plen is 0"},
> +
> +	{"keyring", "bcd", 1, 0,
> +	"the key type is keyrings and plen is 1"},
> +
> +	{"user", "cde", 32767, 1,
> +	"The key type is user and plen is 32767"},
> +
> +	{"user", "def", 32768, 0,
> +	"The key type is user and plen is 32768"},
> +
> +	{"logon", "ef:g", 32767, 1,
> +	"The key type is logon and plen is 32767"},
> +
> +	{"logon", "fg:h", 32768, 0,
> +	"The key type is logon and plen is 32768"},
> +
> +	{"big_key", "ghi", (1 << 20) - 1, 1,
> +	"The key type is big_key and plen is 1048575"},
> +
> +	{"big_key", "hij", 1 << 20, 0,
> +	"The key type is big_key and plen is 1048576"},
> +};
> +
> +static char *buf;
> +static unsigned int logon_nsup, big_key_nsup;
> +
> +static void verify_add_key(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +
> +	tst_res(TINFO, "%s", tc->message);
> +
> +	if (!strcmp(tc->type, "logon") && logon_nsup) {
> +		tst_res(TINFO,
> +			"current system doesn't support logon key type, skip it");
                     This should be TCONF and the message could be much
		     shorther and to the point, something as:

		     tst_res(TCONF, "skipping unsupported logon key");
> +		return;
> +	}
> +
> +	if (!strcmp(tc->type, "big_key") && big_key_nsup) {
> +		tst_res(TINFO,
> +			"current system doesn't support big_key key type, skip it");

Here as well.

> +		return;
> +	}
> +
> +	TEST(add_key(tc->type, tc->desc, buf, tc->plen, KEY_SPEC_THREAD_KEYRING));
> +	if (TST_RET == -1) {
> +		if (TST_ERR == EINVAL)
> +			tst_res(tc->pass_flag ? TFAIL : TPASS, "add_key call failed as expected");
> +		else
> +			tst_res(TFAIL | TTERRNO, "add_key call failed expected EINVAL but got");

This is a bit confusing, we may get the messages even in a case that the
key is supposed to be successfully created, right?

I guess that message "TFAIL: add_key call failed as expected" is not
right.

Can we separate the negative a positive messages so that they are less
confusing?

> +		return;
> +	}
> +	tst_res(tc->pass_flag ? TPASS : TFAIL, "add_key call succeeded");
> +}
> +
> +static void setup(void)
> +{
> +	TEST(add_key("logon", "test:sup_logon", buf, 64, KEY_SPEC_THREAD_KEYRING));
> +	if (TST_RET == -1)
> +		logon_nsup = 1;
> +
> +	TEST(add_key("big_key", "sup_big_key", buf, 64, KEY_SPEC_THREAD_KEYRING));
> +	if (TST_RET == -1)
> +		big_key_nsup = 1;
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = verify_add_key,
> +	.bufs = (struct tst_buffers []) {
> +		{&buf, .size = 1 << 20},

We actually need different buffer for each different plen size, because
the sole purpose of the buffer is to map a unaccessible page right after
the end of the buffer to catch off-by-one accesses.

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
