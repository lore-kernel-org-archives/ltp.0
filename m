Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4D5C433F5
	for <ltp@archiver.kernel.org>; Mon,  6 Dec 2021 12:34:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B6E763C245D
	for <ltp@archiver.kernel.org>; Mon,  6 Dec 2021 13:34:02 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 053E03C0551
 for <ltp@lists.linux.it>; Mon,  6 Dec 2021 13:33:52 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 98D99200918
 for <ltp@lists.linux.it>; Mon,  6 Dec 2021 13:33:51 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 78C17212B9;
 Mon,  6 Dec 2021 12:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638794030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a8oE2up4YDS/12Barbna2SqRG48VY+L1dTKK5ha0QdQ=;
 b=rYNddFONX/3mJVhkwV8DDNpl5c2Dor7pnbTRqvr0waqKEJrBNiDt3eDcsu6vjTZhSEN6yV
 ++/gPBK2Hh7SsCz9ChKCN+q7KZRN/SgCf4fm1IwK3/dAnekXZeFlNtqrDfvmVTB8VMQKOx
 qGkQfr35Kly8ZSO6ENZ9rMLw7MkgAjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638794030;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a8oE2up4YDS/12Barbna2SqRG48VY+L1dTKK5ha0QdQ=;
 b=bhcipwwUCpVXO9eJ4A0iypBrZ1uJsw8y0Uw71DJ0gO8Q1xlXJ3eSzjKyoOierULhYD9YMh
 BDFH9jLCYeOxchCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5174513C18;
 Mon,  6 Dec 2021 12:33:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0OR0Ei4DrmEFAwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 06 Dec 2021 12:33:50 +0000
Date: Mon, 6 Dec 2021 13:35:05 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <Ya4DeVrCa1X8IFjk@yuki>
References: <1638345208-2186-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1638345208-2186-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lib: add cmd parse handler in needs_cmd
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Testcase ie statx05 needs mkfs.ext4 >= 1.43.0 because of encrypt feature.
> 
> As Cyril suggested, add cmd parser handler in needs_cmd.
> 
> The difference logic about from before, we don't report not-found error and think it is
> cmd version string(need to use tst_version_parser) if tst_get_path fails in tst_test.c.
> 
> In tst_version_parser function, use strtok_r to split cmd_token,op_token,version_token.
> It only supports six operations '>=' '<=' '>' '<' '==' '!='.
> 
> Currently, this tst_version_parser only supports mkfs.ext4 command. If you want to support
> more commands, just add your own .parser and .table_get methond in version_parsers structure.
> 
> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  doc/c-test-api.txt                       |  14 +++
>  include/tst_test.h                       |   1 +
>  include/tst_version_parser.h             |  15 +++
>  lib/newlib_tests/.gitignore              |   5 +
>  lib/newlib_tests/test_version_parser01.c |  25 ++++
>  lib/newlib_tests/test_version_parser02.c |  24 ++++
>  lib/newlib_tests/test_version_parser03.c |  24 ++++
>  lib/newlib_tests/test_version_parser04.c |  24 ++++
>  lib/newlib_tests/test_version_parser05.c |  24 ++++
>  lib/tst_test.c                           |   2 +-
>  lib/tst_version_parser.c                 | 148 +++++++++++++++++++++++
>  11 files changed, 305 insertions(+), 1 deletion(-)
>  create mode 100644 include/tst_version_parser.h
>  create mode 100644 lib/newlib_tests/test_version_parser01.c
>  create mode 100644 lib/newlib_tests/test_version_parser02.c
>  create mode 100644 lib/newlib_tests/test_version_parser03.c
>  create mode 100644 lib/newlib_tests/test_version_parser04.c
>  create mode 100644 lib/newlib_tests/test_version_parser05.c
>  create mode 100644 lib/tst_version_parser.c
> 
> diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
> index 64d0630ce..fde6dce0c 100644
> --- a/doc/c-test-api.txt
> +++ b/doc/c-test-api.txt
> @@ -2013,6 +2013,20 @@ terminated array of strings such as:
>  },
>  -------------------------------------------------------------------------------
>  
> +Also can check required commands version whether is satisfied by using 'needs_cmds',
> +
> +[source,c]
> +-------------------------------------------------------------------------------
> +.needs_cmds = (const char *const []) {
> +	"mkfs.ext4 >= 1.43.0",
> +	NULL
> +},
> ++-------------------------------------------------------------------------------
> +
> +Currently, we only support mkfs.ext4 command. If you want to support more commands,
> +please fill your own .parser and .table_get method in the version_parsers structure
> +of lib/tst_version_parser.c.
> +
>  1.36 Assert sys or proc file value
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  Using TST_ASSERT_INT/STR(path, val) to assert that integer value or string stored in
> diff --git a/include/tst_test.h b/include/tst_test.h
> index c06a4729b..fd3d4cfee 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -44,6 +44,7 @@
>  #include "tst_taint.h"
>  #include "tst_memutils.h"
>  #include "tst_arch.h"
> +#include "tst_version_parser.h"

Since this is internal functionality that does not make sense to be
exposed to the tests there is no point in exposing this here, we should
include it in the tst_test.c instead.

>  /*
>   * Reports testcase result.
> diff --git a/include/tst_version_parser.h b/include/tst_version_parser.h
> new file mode 100644
> index 000000000..145043929
> --- /dev/null
> +++ b/include/tst_version_parser.h
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021 Yang Xu <xuyang2018.jy@fujitsu.com>
> + */
> +
> +#ifndef TST_VERSION_PARSER_H__
> +#define TST_VERSION_PARSER_H__
> +
> +/*
> + * Parse the cmd version requirement in needs_cmds member of tst_test
> + * structure whether is satisfied.
> + */
> +void tst_version_parser(const char *cmd);

This should probably be called tst_cmd_check() or something similar.

> +#endif /* TST_VERSION_PARSER_H__ */
> diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
> index cf467b5a0..ef8694d08 100644
> --- a/lib/newlib_tests/.gitignore
> +++ b/lib/newlib_tests/.gitignore
> @@ -46,4 +46,9 @@ test_macros06
>  tst_fuzzy_sync01
>  tst_fuzzy_sync02
>  tst_fuzzy_sync03
> +test_version_parser01
> +test_version_parser02
> +test_version_parser03
> +test_version_parser04
> +test_version_parser05
>  test_zero_hugepage
> diff --git a/lib/newlib_tests/test_version_parser01.c b/lib/newlib_tests/test_version_parser01.c
> new file mode 100644
> index 000000000..9e1bd3962
> --- /dev/null
> +++ b/lib/newlib_tests/test_version_parser01.c
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021 Yang Xu <xuyang2018.jy@fujitsu.com>
> + */
> +
> +#include <stdio.h>
> +#include "tst_test.h"
> +
> +static void do_test(void)
> +{
> +	tst_res(TPASS, "Tesing tst_version_parser() functionality OK.");
> +}
> +
> +static struct tst_test test = {
> +	.test_all = do_test,
> +	.needs_cmds = (const char *[]) {
> +		"mkfs.ext4",
> +		"mkfs.ext4 >= 1.43.0",
> +		"mkfs.ext4 <= 2.0.0",
> +		"mkfs.ext4 != 2.0.0",
> +		"mkfs.ext4 > 1.43.0",
> +		"mkfs.ext4 < 2.0.0",
> +		NULL
> +	}
> +};
> diff --git a/lib/newlib_tests/test_version_parser02.c b/lib/newlib_tests/test_version_parser02.c
> new file mode 100644
> index 000000000..5aedaa28f
> --- /dev/null
> +++ b/lib/newlib_tests/test_version_parser02.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021 Yang Xu <xuyang2018.jy@fujitsu.com>
> + */
> +
> +/*
> + * Test Illegal format by using Illegal cmd.
> + */
> +
> +#include <stdio.h>
> +#include "tst_test.h"
> +
> +static void do_test(void)
> +{
> +	tst_res(TFAIL, "Tesing tst_version_parser() functionality bad.");
                        ^
			"Nonexisting command is present!"


Or something along these line.

> +}
> +
> +static struct tst_test test = {
> +	.test_all = do_test,
> +	.needs_cmds = (const char *[]) {
> +		"mkfs.ext45 >= 1.43.0",
> +		NULL
> +	}
> +};
> diff --git a/lib/newlib_tests/test_version_parser03.c b/lib/newlib_tests/test_version_parser03.c
> new file mode 100644
> index 000000000..8f96e68d2
> --- /dev/null
> +++ b/lib/newlib_tests/test_version_parser03.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021 Yang Xu <xuyang2018.jy@fujitsu.com>
> + */
> +
> +/*
> + * Test Illegal format by using Illegal operation.
> + */
> +
> +#include <stdio.h>
> +#include "tst_test.h"
> +
> +static void do_test(void)
> +{
> +	tst_res(TFAIL, "Tesing tst_version_parser() functionality bad.");
                          ^
			  "Wrong operator was evaluated!"

> +}
> +
> +static struct tst_test test = {
> +	.test_all = do_test,
> +	.needs_cmds = (const char *[]) {
> +		"mkfs.ext4 ! 1.43.0",
> +		NULL
> +	}
> +};
> diff --git a/lib/newlib_tests/test_version_parser04.c b/lib/newlib_tests/test_version_parser04.c
> new file mode 100644
> index 000000000..461f673df
> --- /dev/null
> +++ b/lib/newlib_tests/test_version_parser04.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021 Yang Xu <xuyang2018.jy@fujitsu.com>
> + */
> +
> +/*
> + * Test Illegal format by using Illegal version.
> + */
> +
> +#include <stdio.h>
> +#include "tst_test.h"
> +
> +static void do_test(void)
> +{
> +	tst_res(TFAIL, "Tesing tst_version_parser() functionality bad.");
                          ^
			  "Incomplete version was parsed!"
> +}
> +
> +static struct tst_test test = {
> +	.test_all = do_test,
> +	.needs_cmds = (const char *[]) {
> +		"mkfs.ext4 > 1.43",
> +		NULL
> +	}
> +};
> diff --git a/lib/newlib_tests/test_version_parser05.c b/lib/newlib_tests/test_version_parser05.c
> new file mode 100644
> index 000000000..1bfe24f73
> --- /dev/null
> +++ b/lib/newlib_tests/test_version_parser05.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021 Yang Xu <xuyang2018.jy@fujitsu.com>
> + */
> +
> +/*
> + * Test non-existed cmd whether still can be detected.
> + */
> +
> +#include <stdio.h>
> +#include "tst_test.h"
> +
> +static void do_test(void)
> +{
> +	tst_res(TFAIL, "Tesing tst_version_parser() functionality bad.");
                        ^
			"Nonexisting command is present!"
> +}
> +
> +static struct tst_test test = {
> +	.test_all = do_test,
> +	.needs_cmds = (const char *[]) {
> +		"mkfs.ext45",
> +		NULL
> +	}
> +};
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index a79275722..a9e95a3d7 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -992,7 +992,7 @@ static void do_setup(int argc, char *argv[])
>  
>  		for (i = 0; (cmd = tst_test->needs_cmds[i]); ++i)
>  			if (tst_get_path(cmd, path, sizeof(path)))
> -				tst_brk(TCONF, "Couldn't find '%s' in $PATH", cmd);
> +				tst_version_parser(cmd);

Why do we keep the tst_get_path() here? We can as well get rid of that
and just call the function and handle the case without the version
there.

>  	}
>  
>  	if (tst_test->needs_drivers) {
> diff --git a/lib/tst_version_parser.c b/lib/tst_version_parser.c
> new file mode 100644
> index 000000000..296e25ea2
> --- /dev/null
> +++ b/lib/tst_version_parser.c
> @@ -0,0 +1,148 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021 Yang Xu <xuyang2018.jy@fujitsu.com>
> + */
> +
> +#include <stdio.h>
> +#include <string.h>
> +#include <stdlib.h>
> +
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_version_parser.h"
> +#include "tst_test.h"
> +
> +static int mkfs_ext4_version_parser(void)
> +{
> +	FILE *f;
> +	int rc, major, minor, patch;
> +
> +	f = popen("mkfs.ext4 -V 2>&1", "r");
> +	if (!f) {
> +		tst_res(TWARN, "Could not run mkfs.ext4 -V 2>&1 cmd");
> +		return -1;
> +	}
> +	rc = fscanf(f, "mke2fs %d.%d.%d", &major, &minor, &patch);
> +	pclose(f);
> +	if (rc != 3) {
> +		tst_res(TWARN, "Unable to parse mkfs.ext4 version");
> +		return -1;
> +	}
> +
> +	return major * 10000 +  minor * 100 + patch;
> +}
> +
> +static int mkfs_ext4_version_table_get(char *version)
> +{
> +	char *major, *minor, *patch, *next, *str;
> +	char table_version[100];
> +
> +	strcpy(table_version, version);
> +
> +	major = strtok_r(table_version, ".", &next);
> +	minor = strtok_r(NULL, ".", &next);
> +	patch = strtok_r(NULL, ".", &next);
> +	str = strtok_r(NULL, ".", &next);

I wonder if we should do a sscanf() here. Note that with the atoi() we
will pass on strings that have garbage after the numbers such as:

	"1ab.2c.3dd"

What about:

	unsigned int maj, min, patch;
	int len;

	if (sscanf(version, "%u.%u.%u %n", &maj, &min, &patch, len) != 3) {
		tst_res(TWARN, "Illegal version ...");
		return -1;
	}

	if (len != strlen(version)) {
		tst_res(TWARN, "Garbage after version");
		return -1;
	}

	return maj * 10000 + min * 100 + patch;

> +	if (!major || !minor || !patch || str) {
> +		tst_res(TWARN, "Illegal version(%s), should use format like 1.43.0", version);
> +		return -1;
> +	}
> +
> +	return atoi(major) * 10000 + atoi(minor) * 100 + atoi(patch);
> +}
> +
> +static struct version_parser {
> +	const char *cmd;
> +	int (*parser)(void);
> +	int (*table_get)(char *version);
> +} version_parsers[] = {
> +	{.cmd = "mkfs.ext4", .parser = mkfs_ext4_version_parser, .table_get = mkfs_ext4_version_table_get},
> +	{},
> +};
> +
> +void tst_version_parser(const char *cmd)
> +{
> +	struct version_parser *p;
> +	char *cmd_token, *op, *version, *next, *str;
> +	char path[PATH_MAX];
> +	char parser_cmd[100];
> +	int ver_parser, ver_get;
> +	int op_flag = 0;
> +
> +	strcpy(parser_cmd, cmd);
> +
> +	cmd_token = strtok_r(parser_cmd, " ", &next);
> +	op = strtok_r(NULL, " ", &next);

Shouldn't we just handle the case where op == NULL as a single command
here? That would make the code much cleaner.

I.e.:
	if (tst_get_path(cmd_token, path, sizeof(path)))
		tst_brk(TCONF, "Couldn't find '%s' in $PATH", cmd_token);

	if (!op)
		return;

> +	version = strtok_r(NULL, " ", &next);
> +	str = strtok_r(NULL, " ", &next);



> +	if (!cmd_token || !op || !version || str)
> +		tst_brk(TCONF,
> +			"Illegal fomart(%s), should use format like mkfs.ext4 >= 1.43.0", cmd);

Then we can just check the version and str here as:

	if (!version || str)
		tst_brk(TCONF, "Illegal format ...");

> +	if (tst_get_path(cmd_token, path, sizeof(path)))
> +		tst_brk(TCONF, "Couldn't find '%s' in $PATH", cmd_token);
> +
> +	if (!strcmp(op, ">="))
> +		op_flag = 1;
> +
> +	if (!strcmp(op, ">"))
> +		op_flag = 2;
> +
> +	if (!strcmp(op, "<="))
> +		op_flag = 3;
> +
> +	if (!strcmp(op, "<"))
> +		op_flag = 4;
> +
> +	if (!strcmp(op, "=="))
> +		op_flag = 5;
> +
> +	if (!strcmp(op, "!="))
> +		op_flag = 6;
> +
> +	if (!op_flag)
> +		tst_brk(TCONF, "Invalid op(%s)", op);

This is usually structured as else if (..) in C as:

	if (!strcmp(op, ">="))
		op_flag = ...
	else if (!strcmp(op, ">")
		op_flag = ...
	else ....

Also maybe an enum would make the code easier to read as:

enum op {
	OP_GE, /* >= */
	OP_GT, /* >  */
	OP_LE, /* <= */
	OP_LT, /* <  */
	OP_EQ, /* == */
	OP_NE, /* != */
};

Then we would do:

	if (!strcmp(op, ">="))
		op_flag = OP_GE;
	else ...

> +	for (p = &version_parsers[0]; p; p++) {
> +		if (!strcmp(p->cmd, cmd_token))
> +			tst_res(TINFO, "Parsing %s version", p->cmd);
> +			break;

This does not work without curly braces around the blok, right?

> +	}
> +
> +	if (!p->cmd)
> +		tst_brk(TBROK, "No version parser for %s implemented!", cmd_token);
> +
> +	ver_parser = p->parser();
> +	if (ver_parser < 0)
> +		tst_brk(TBROK, "Failed to parse %s version", p->cmd);
> +
> +	ver_get = p->table_get(version);
> +	if (ver_get < 0)
> +		tst_brk(TBROK, "Failed to get %s version", p->cmd);
> +
> +	switch (op_flag) {
> +	case 1:
> +		if (ver_parser < ver_get)
> +			tst_brk(TCONF, "cmd(%s) expected >= %d, but got %d", cmd, ver_get, ver_parser);
                                                 ^
					"%s required >= %d, but got %d", ...

The version is required in order run the test.

> +		break;
> +	case 2:
> +		if (ver_parser <= ver_get)
> +			tst_brk(TCONF, "cmd(%s) expected > %d, but got %d", cmd, ver_get, ver_parser);
> +		break;
> +	case 3:
> +		if (ver_parser > ver_get)
> +			tst_brk(TCONF, "cmd(%s) expected <= %d, but got %d", cmd, ver_get, ver_parser);
> +		break;
> +	case 4:
> +		if (ver_parser >= ver_get)
> +			tst_brk(TCONF, "cmd(%s) expected < %d, but got %d", cmd, ver_get, ver_parser);
> +		break;
> +	case 5:
> +		if (ver_parser != ver_get)
> +			tst_brk(TCONF, "cmd(%s) expected == %d, but got %d", cmd, ver_get, ver_parser);
> +		break;
> +	case 6:
> +		if (ver_parser == ver_get)
> +			tst_brk(TCONF, "cmd(%s) expected != %d, but got %d", cmd, ver_get, ver_parser);
> +		break;
> +	}


And the same for the rest of the messages.

> +}

Looks mostly good, minus the minor things I've pointed out.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
