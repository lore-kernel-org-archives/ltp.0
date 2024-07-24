Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E5FC3DA63
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 09:37:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C2D73D1C17
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 11:37:44 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A9813D0E76
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 11:37:27 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E6586101F0AD
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 11:37:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B11C81F797;
 Wed, 24 Jul 2024 09:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721813844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xr3k2giwSCQdshfMzUCyNBfNYoAzwAlAMe+Kx6+oAgs=;
 b=Q8UDt3g+4iLSLMfpD3iO+VicS8qUHsz+ti43xz1BBwTvolCJQSzNejQlzNpCCgMidRyhAZ
 0WxqtERHNTQFmdN94fim5Z3obNx5xlQRYRlfLpmF30i1EU/niDTuquRLEcWmC8bbgkbVzF
 jPUrgbXeZE8JvajOBd/dPZH8fwWKatI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721813844;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xr3k2giwSCQdshfMzUCyNBfNYoAzwAlAMe+Kx6+oAgs=;
 b=BxCwRpx/Oh5bT6JQKXQtnrG/Llt1ZjD6ft1Cd+WAodQfjoSxpDukkTYMb0C1VRGeA7DyE0
 ueLa5zXNUDMsQ9AA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Q8UDt3g+;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="BxCwRpx/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721813844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xr3k2giwSCQdshfMzUCyNBfNYoAzwAlAMe+Kx6+oAgs=;
 b=Q8UDt3g+4iLSLMfpD3iO+VicS8qUHsz+ti43xz1BBwTvolCJQSzNejQlzNpCCgMidRyhAZ
 0WxqtERHNTQFmdN94fim5Z3obNx5xlQRYRlfLpmF30i1EU/niDTuquRLEcWmC8bbgkbVzF
 jPUrgbXeZE8JvajOBd/dPZH8fwWKatI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721813844;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xr3k2giwSCQdshfMzUCyNBfNYoAzwAlAMe+Kx6+oAgs=;
 b=BxCwRpx/Oh5bT6JQKXQtnrG/Llt1ZjD6ft1Cd+WAodQfjoSxpDukkTYMb0C1VRGeA7DyE0
 ueLa5zXNUDMsQ9AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C46F13411;
 Wed, 24 Jul 2024 09:37:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /7fPJVTLoGYjWQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Wed, 24 Jul 2024 09:37:24 +0000
Message-ID: <7787ae84-8c5a-4f31-815b-afb12fce2575@suse.cz>
Date: Wed, 24 Jul 2024 11:37:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Martin Doucha <mdoucha@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <20240716153604.22984-1-chrubis@suse.cz>
 <20240716153604.22984-2-chrubis@suse.cz>
Content-Language: en-US
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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
In-Reply-To: <20240716153604.22984-2-chrubis@suse.cz>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B11C81F797
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 XM_UA_NO_VERSION(0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/2] Add support for mixing C and shell code
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
I'll skip bugs reported by others but I have some comments below.

On 16. 07. 24 17:36, Cyril Hrubis wrote:
> This is a proof of a concept of a seamless C and shell integration. The
> idea is that with this you can mix shell and C code as much as as you
> wish to get the best of the two worlds.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>   include/tst_test.h                           | 38 +++++++++++++
>   lib/tst_test.c                               | 51 +++++++++++++++++
>   testcases/lib/.gitignore                     |  1 +
>   testcases/lib/Makefile                       |  4 +-
>   testcases/lib/run_tests.sh                   | 10 ++++
>   testcases/lib/tests/.gitignore               |  6 ++
>   testcases/lib/tests/Makefile                 | 11 ++++
>   testcases/lib/tests/shell_loader.sh          |  5 ++
>   testcases/lib/tests/shell_test01.c           | 17 ++++++
>   testcases/lib/tests/shell_test02.c           | 18 ++++++
>   testcases/lib/tests/shell_test03.c           | 25 +++++++++
>   testcases/lib/tests/shell_test04.c           | 18 ++++++
>   testcases/lib/tests/shell_test05.c           | 27 +++++++++
>   testcases/lib/tests/shell_test06.c           | 16 ++++++
>   testcases/lib/tests/shell_test_brk.sh        |  6 ++
>   testcases/lib/tests/shell_test_check_argv.sh | 25 +++++++++
>   testcases/lib/tests/shell_test_checkpoint.sh |  7 +++
>   testcases/lib/tests/shell_test_pass.sh       |  6 ++
>   testcases/lib/tst_env.sh                     | 16 ++++++
>   testcases/lib/tst_res_.c                     | 58 ++++++++++++++++++++
>   20 files changed, 363 insertions(+), 2 deletions(-)
>   create mode 100755 testcases/lib/run_tests.sh
>   create mode 100644 testcases/lib/tests/.gitignore
>   create mode 100644 testcases/lib/tests/Makefile
>   create mode 100644 testcases/lib/tests/shell_loader.sh
>   create mode 100644 testcases/lib/tests/shell_test01.c
>   create mode 100644 testcases/lib/tests/shell_test02.c
>   create mode 100644 testcases/lib/tests/shell_test03.c
>   create mode 100644 testcases/lib/tests/shell_test04.c
>   create mode 100644 testcases/lib/tests/shell_test05.c
>   create mode 100644 testcases/lib/tests/shell_test06.c
>   create mode 100755 testcases/lib/tests/shell_test_brk.sh
>   create mode 100755 testcases/lib/tests/shell_test_check_argv.sh
>   create mode 100755 testcases/lib/tests/shell_test_checkpoint.sh
>   create mode 100755 testcases/lib/tests/shell_test_pass.sh
>   create mode 100644 testcases/lib/tst_env.sh
>   create mode 100644 testcases/lib/tst_res_.c
> 
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 517c8d032..fde8a1414 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -331,6 +331,8 @@ struct tst_fs {
>    * @child_needs_reinit: Has to be set if the test needs to call tst_reinit()
>    *                      from a process started by exec().
>    *
> + * @runs_shell: Implies child_needs_reinit and forks_child at the moment.
> + *

This could also work as is for Python or Perl scripts (which we don't 
support at the moment) but consider renaming the attribute to 
.runs_script anyway.

>    * @needs_devfs: If set the devfs is mounted at tst_test.mntpoint. This is
>    *               needed for tests that need to create device files since tmpfs
>    *               at /tmp is usually mounted with 'nodev' option.
> @@ -514,6 +516,7 @@ struct tst_fs {
>   	unsigned int mount_device:1;
>   	unsigned int needs_rofs:1;
>   	unsigned int child_needs_reinit:1;
> +	unsigned int runs_shell:1;
>   	unsigned int needs_devfs:1;
>   	unsigned int restore_wallclock:1;
>   
> @@ -522,6 +525,8 @@ struct tst_fs {
>   	unsigned int skip_in_lockdown:1;
>   	unsigned int skip_in_secureboot:1;
>   	unsigned int skip_in_compat:1;
> +
> +
>   	int needs_abi_bits;
>   
>   	unsigned int needs_hugetlbfs:1;
> @@ -607,6 +612,39 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
>    */
>   void tst_reinit(void);
>   
> +/**
> + * tst_run_shell() - Prepare the environment and execute a shell script.
> + *
> + * @script_name: A filename of the script.
> + * @params: A NULL terminated array of shell script parameters, pass NULL if
> + *          none are needed. This what is passed starting from argv[1].
> + *
> + * The shell script is executed with LTP_IPC_PATH in environment so that the
> + * binary helpers such as tst_res_ or tst_checkpoint work properly when executed
> + * from the script. This also means that the tst_test.runs_shell flag needs to
> + * be set.
> + *
> + * The shell script itself has to source the tst_env.sh shell script at the
> + * start and after that it's free to use tst_res in the same way C code would
> + * use.
> + *
> + * Example shell script that reports success::
> + *
> + *   #!/bin/sh
> + *   . tst_env.sh
> + *
> + *   tst_res TPASS "Example test works"
> + *
> + * The call returns a pid in a case that you want to examine the return value
> + * of the script yourself. If you do not need to check the return value
> + * yourself you can use tst_reap_children() to wait for the completion. Or let
> + * the test library collect the child automatically, just be wary that the
> + * script and the test both runs concurently at the same time in this case.
> + *
> + * Return: A pid of the shell process.
> + */
> +int tst_run_shell(char *script_name, char *const params[]);
> +
>   unsigned int tst_multiply_timeout(unsigned int timeout);
>   
>   /*
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index e5bc5bf4d..fa0907353 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -173,6 +173,52 @@ void tst_reinit(void)
>   	SAFE_CLOSE(fd);
>   }
>   
> +extern char **environ;
> +
> +static unsigned int params_array_len(char *const array[])
> +{
> +	unsigned int ret = 0;
> +
> +	if (!array)
> +		return 0;
> +
> +	while (*(array++))
> +		ret++;
> +
> +	return ret;
> +}
> +
> +int tst_run_shell(char *script_name, char *const params[])
> +{
> +	int pid;
> +	unsigned int i, params_len = params_array_len(params);
> +	char *argv[params_len + 2] = {};
> +
> +	if (!tst_test->runs_shell)
> +		tst_brk(TBROK, "runs_shell flag must be set!");
> +
> +	argv[0] = script_name;
> +
> +	if (params) {
> +		for (i = 0; i < params_len; i++)
> +			argv[i+1] = params[i];
> +	}
> +
> +	pid = SAFE_FORK();
> +	if (pid)
> +		return pid;
> +
> +	char *script_name_env = NULL;
> +	SAFE_ASPRINTF(&script_name_env, "LTP_SCRIPT_NAME=%s", script_name);
> +	putenv(script_name_env);
> +
> +	execvpe(script_name, argv, environ);
> +
> +	tst_brk(TBROK | TERRNO, "execv(%s, ...) failed!", script_name);
> +
> +	return -1;
> +}
> +
>   static void update_results(int ttype)
>   {
>   	if (!results)
> @@ -1224,6 +1270,11 @@ static void do_setup(int argc, char *argv[])
>   		tdebug = 1;
>   	}
>   
> +	if (tst_test->runs_shell) {
> +		tst_test->child_needs_reinit = 1;
> +		tst_test->forks_child = 1;
> +	}
> +
>   	if (tst_test->needs_kconfigs && tst_kconfig_check(tst_test->needs_kconfigs))
>   		tst_brk(TCONF, "Aborting due to unsuitable kernel config, see above!");
>   
> diff --git a/testcases/lib/.gitignore b/testcases/lib/.gitignore
> index e8afd06f3..d0dacf62a 100644
> --- a/testcases/lib/.gitignore
> +++ b/testcases/lib/.gitignore
> @@ -23,3 +23,4 @@
>   /tst_sleep
>   /tst_supported_fs
>   /tst_timeout_kill
> +/tst_res_
> diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
> index 990b46089..928d76d62 100644
> --- a/testcases/lib/Makefile
> +++ b/testcases/lib/Makefile
> @@ -13,6 +13,6 @@ MAKE_TARGETS		:= tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp\
>   			   tst_getconf tst_supported_fs tst_check_drivers tst_get_unused_port\
>   			   tst_get_median tst_hexdump tst_get_free_pids tst_timeout_kill\
>   			   tst_check_kconfigs tst_cgctl tst_fsfreeze tst_ns_create tst_ns_exec\
> -			   tst_ns_ifmove tst_lockdown_enabled tst_secureboot_enabled
> +			   tst_ns_ifmove tst_lockdown_enabled tst_secureboot_enabled tst_res_
>   
> -include $(top_srcdir)/include/mk/generic_leaf_target.mk
> +include $(top_srcdir)/include/mk/generic_trunk_target.mk
> diff --git a/testcases/lib/run_tests.sh b/testcases/lib/run_tests.sh
> new file mode 100755
> index 000000000..88607b146
> --- /dev/null
> +++ b/testcases/lib/run_tests.sh
> @@ -0,0 +1,10 @@
> +#!/bin/sh
> +
> +export PATH=$PATH:$PWD:$PWD/tests/

$PWD is not the correct path. It should be set as follows:

testdir=$(dirname $0)
export PATH=$PATH:$testdir:$testdir/tests/

> +
> +./tests/shell_test01
> +./tests/shell_test02
> +./tests/shell_test03
> +./tests/shell_test04
> +./tests/shell_test05
> +./tests/shell_test06
> diff --git a/testcases/lib/tests/.gitignore b/testcases/lib/tests/.gitignore
> new file mode 100644
> index 000000000..da967c4d6
> --- /dev/null
> +++ b/testcases/lib/tests/.gitignore
> @@ -0,0 +1,6 @@
> +shell_test01
> +shell_test02
> +shell_test03
> +shell_test04
> +shell_test05
> +shell_test06
> diff --git a/testcases/lib/tests/Makefile b/testcases/lib/tests/Makefile
> new file mode 100644
> index 000000000..5a5cf5310
> --- /dev/null
> +++ b/testcases/lib/tests/Makefile
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (C) 2009, Cisco Systems Inc.
> +# Ngie Cooper, August 2009
> +
> +top_srcdir		?= ../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +INSTALL_TARGETS=
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/lib/tests/shell_loader.sh b/testcases/lib/tests/shell_loader.sh
> new file mode 100644
> index 000000000..c3b3cf5fd
> --- /dev/null
> +++ b/testcases/lib/tests/shell_loader.sh
> @@ -0,0 +1,5 @@
> +#!/usr/bin/env tst_run_shell
> +
> +. tst_env.sh
> +
> +tst_res TPASS "Shell loader works fine!"
> diff --git a/testcases/lib/tests/shell_test01.c b/testcases/lib/tests/shell_test01.c
> new file mode 100644
> index 000000000..18f834138
> --- /dev/null
> +++ b/testcases/lib/tests/shell_test01.c
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Shell test example.
> + */
> +
> +#include "tst_test.h"
> +
> +static void run_test(void)
> +{
> +	tst_run_shell("shell_test_pass.sh", NULL);
> +	tst_res(TINFO, "C test exits now");
> +}
> +
> +static struct tst_test test = {
> +	.runs_shell = 1,
> +	.test_all = run_test,
> +};
> diff --git a/testcases/lib/tests/shell_test02.c b/testcases/lib/tests/shell_test02.c
> new file mode 100644
> index 000000000..3b0534370
> --- /dev/null
> +++ b/testcases/lib/tests/shell_test02.c
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Shell test example.
> + */
> +
> +#include "tst_test.h"
> +
> +static void run_test(void)
> +{
> +	tst_run_shell("shell_test_pass.sh", NULL);
> +	tst_reap_children();
> +	tst_res(TINFO, "Shell test has finished at this point!");
> +}
> +
> +static struct tst_test test = {
> +	.runs_shell = 1,
> +	.test_all = run_test,
> +};
> diff --git a/testcases/lib/tests/shell_test03.c b/testcases/lib/tests/shell_test03.c
> new file mode 100644
> index 000000000..c11a09e4e
> --- /dev/null
> +++ b/testcases/lib/tests/shell_test03.c
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Shell test example.
> + */
> +
> +#include <sys/wait.h>
> +#include "tst_test.h"
> +
> +static void run_test(void)
> +{
> +	int pid, status;
> +
> +	pid = tst_run_shell("shell_test_pass.sh", NULL);
> +
> +	tst_res(TINFO, "Waiting for the pid %i", pid);
> +
> +	waitpid(pid, &status, 0);
> +
> +	tst_res(TINFO, "Shell test has %s", tst_strstatus(status));
> +}
> +
> +static struct tst_test test = {
> +	.runs_shell = 1,
> +	.test_all = run_test,
> +};
> diff --git a/testcases/lib/tests/shell_test04.c b/testcases/lib/tests/shell_test04.c
> new file mode 100644
> index 000000000..fd1fd122c
> --- /dev/null
> +++ b/testcases/lib/tests/shell_test04.c
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Shell test example.
> + */
> +
> +#include "tst_test.h"
> +
> +static void run_test(void)
> +{
> +	char *const params[] = {"param1", "param2", NULL};
> +
> +	tst_run_shell("shell_test_check_argv.sh", params);
> +}
> +
> +static struct tst_test test = {
> +	.runs_shell = 1,
> +	.test_all = run_test,
> +};
> diff --git a/testcases/lib/tests/shell_test05.c b/testcases/lib/tests/shell_test05.c
> new file mode 100644
> index 000000000..2141d4790
> --- /dev/null
> +++ b/testcases/lib/tests/shell_test05.c
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Shell test example.
> + */
> +
> +#include "tst_test.h"
> +
> +static void run_test(void)
> +{
> +	int pid;
> +
> +	pid = tst_run_shell("shell_test_checkpoint.sh", NULL);
> +
> +	tst_res(TINFO, "Waiting for shell to sleep on checkpoint!");
> +
> +	TST_PROCESS_STATE_WAIT(pid, 'S', 10000);
> +
> +	tst_res(TINFO, "Waking shell child!");
> +
> +	TST_CHECKPOINT_WAKE(0);
> +}
> +
> +static struct tst_test test = {
> +	.runs_shell = 1,
> +	.needs_checkpoints = 1,
> +	.test_all = run_test,
> +};
> diff --git a/testcases/lib/tests/shell_test06.c b/testcases/lib/tests/shell_test06.c
> new file mode 100644
> index 000000000..25abc1e7b
> --- /dev/null
> +++ b/testcases/lib/tests/shell_test06.c
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Shell test example.
> + */
> +
> +#include "tst_test.h"
> +
> +static void run_test(void)
> +{
> +	tst_run_shell("shell_test_brk.sh", NULL);
> +}
> +
> +static struct tst_test test = {
> +	.runs_shell = 1,
> +	.test_all = run_test,
> +};
> diff --git a/testcases/lib/tests/shell_test_brk.sh b/testcases/lib/tests/shell_test_brk.sh
> new file mode 100755
> index 000000000..f266dc3fe
> --- /dev/null
> +++ b/testcases/lib/tests/shell_test_brk.sh
> @@ -0,0 +1,6 @@
> +#!/bin/sh
> +
> +. tst_env.sh
> +
> +tst_brk TCONF "This exits test and the next message should not be reached"
> +tst_res TFAIL "If you see this the test failed"
> diff --git a/testcases/lib/tests/shell_test_check_argv.sh b/testcases/lib/tests/shell_test_check_argv.sh
> new file mode 100755
> index 000000000..756189ee7
> --- /dev/null
> +++ b/testcases/lib/tests/shell_test_check_argv.sh
> @@ -0,0 +1,25 @@
> +#!/bin/sh
> +
> +. tst_env.sh
> +
> +echo "$@"
> +
> +tst_res TINFO "argv = $@"
> +
> +if [ $# -ne 2 ]; then
> +	tst_res TFAIL "Wrong number of parameters got $# expected 2"
> +else
> +	tst_res TPASS "Got 2 parameters"
> +fi
> +
> +if [ "$1" != "param1" ]; then
> +	tst_res TFAIL "First parameter is $1 expected param1"
> +else
> +	tst_res TPASS "First parameter is $1"
> +fi
> +
> +if [ "$2" != "param2" ]; then
> +	tst_res TFAIL "Second parameter is $2 expected param2"
> +else
> +	tst_res TPASS "Second parameter is $2"
> +fi
> diff --git a/testcases/lib/tests/shell_test_checkpoint.sh b/testcases/lib/tests/shell_test_checkpoint.sh
> new file mode 100755
> index 000000000..0ceb7cf66
> --- /dev/null
> +++ b/testcases/lib/tests/shell_test_checkpoint.sh
> @@ -0,0 +1,7 @@
> +#!/bin/sh
> +
> +. tst_env.sh
> +
> +tst_res TINFO "Waiting for a checkpoint 0"
> +tst_checkpoint wait 10000 0
> +tst_res TPASS "Continuing after checkpoint"
> diff --git a/testcases/lib/tests/shell_test_pass.sh b/testcases/lib/tests/shell_test_pass.sh
> new file mode 100755
> index 000000000..fd0684eb2
> --- /dev/null
> +++ b/testcases/lib/tests/shell_test_pass.sh
> @@ -0,0 +1,6 @@
> +#!/bin/sh
> +
> +. tst_env.sh
> +
> +tst_res TPASS "This is called from the shell script!"
> +tst_sleep 100ms
> diff --git a/testcases/lib/tst_env.sh b/testcases/lib/tst_env.sh
> new file mode 100644
> index 000000000..c8f3c2160
> --- /dev/null
> +++ b/testcases/lib/tst_env.sh
> @@ -0,0 +1,16 @@
> +#!/bin/sh
> +
> +tst_script_name=$(basename $0)
> +
> +tst_brk_()
> +{
> +	tst_res_ $@
> +
> +	case "$3" in
> +		"TBROK") exit 2;;
> +		*) exit 0;;

The exit command above will ignore any other result flags already set 
during the test. You could modify tst_res_ to return the correct exit 
code and then call it like this:

tst_brk() {
	tst_res_ "$@"
	exit $?
}

Also note the quotation marks around $@. Without them, tst_brk will 
compress whitespace which the caller wants to preserve.

> +	esac
> +}
> +
> +alias tst_res="tst_res_ $tst_script_name \$LINENO"
> +alias tst_brk="tst_brk_ $tst_script_name \$LINENO"
> diff --git a/testcases/lib/tst_res_.c b/testcases/lib/tst_res_.c
> new file mode 100644
> index 000000000..cc3fa53d3
> --- /dev/null
> +++ b/testcases/lib/tst_res_.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2024 Cyril Hrubis <chrubis@suse.cz>
> + */
> +
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"
> +
> +static void print_help(void)
> +{
> +	printf("Usage: tst_res_ filename lineno [TPASS|TFAIL|TCONF|TINFO|TDEBUG] 'A short description'\n");
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int type, i;
> +
> +	if (argc < 5)
> +		goto help;
> +
> +	if (!strcmp(argv[3], "TPASS"))
> +		type = TPASS;
> +	else if (!strcmp(argv[3], "TFAIL"))
> +		type = TFAIL;
> +	else if (!strcmp(argv[3], "TCONF"))
> +		type = TCONF;
> +	else if (!strcmp(argv[3], "TINFO"))
> +		type = TINFO;
> +	else if (!strcmp(argv[3], "TDEBUG"))
> +		type = TDEBUG;
> +	else
> +		goto help;
> +
> +	size_t len = 0;
> +
> +	for (i = 4; i < argc; i++)
> +		len += strlen(argv[i]) + 1;
> +
> +	char *msg = SAFE_MALLOC(len);
> +	char *msgp = msg;
> +
> +	for (i = 4; i < argc; i++) {
> +		msgp = strcpy(msgp, argv[i]);
> +		msgp += strlen(argv[i]);
> +		*(msgp++) = ' ';
> +	}
> +
> +	*(msgp - 1) = 0;
> +
> +	tst_reinit();
> +
> +	tst_res_(argv[1], atoi(argv[2]), type, msg);
> +
> +	return 0;
> +help:
> +	print_help();
> +	return 1;
> +}

-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
