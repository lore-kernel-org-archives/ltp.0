Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE76CA0EE4
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 12:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1725021663; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=TUGF1V2KCMy1h67RmeL9qhVpzvNN90+lAIbzBF/8C9I=;
 b=WCTbF09zr8Z90hjC5UgR6THE710k1ItXxVW74MlNqu3zCPDLI/iTSFitUBz0z6F8BgH6/
 Me4rUpMsgpHqyqHoOhZ07OdQEzvIfknJwi6Lrf3k0oqwGKOOPWEypMsWz/HzV0l7nBlN21h
 jR2UGzf6IW+lIdLqQvjJxOd91hkwYOY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B5483D284E
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 14:41:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6BEFB3C02D5
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 14:40:42 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 49E586019B4
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 14:40:41 +0200 (CEST)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a86910caf9cso502711666b.1
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 05:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1725021640; x=1725626440; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QShvfgbjW+m2CNGXZdt2rFIyIQ5lBKhCNI7mhapHPic=;
 b=A6T02YHqwe4Y9FcL0LlgZpk5JsfKEYMQ/8LSN876koGssibrZXyjgjTcxuc4Uhr2fV
 XHgeCd/l2w/SgbA/Ge3RWhoy1ovDKAy31H04yR8x9PGnzjWZ80VQx1YywhpDd4evcTck
 oWDGnihD6pH+Q31u+vwthxVa/9fsjiKl4Hg7gXsBO2E6fg/c6GmTzq1pA/r4wrKoY1fe
 2Kpe7K0ME+di1PASPXSSfZNn+VGOGTDYUyuAxjgYv4/lEHdxL6YTG/Dx2aBStzUfKNuu
 Swnshk7Z9Q12Z18AZ0USgSwUf+b0rG0CvWs8XFmjgPJQxBQAVyUvzPTt//uw0Jc1cnmQ
 deXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725021640; x=1725626440;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QShvfgbjW+m2CNGXZdt2rFIyIQ5lBKhCNI7mhapHPic=;
 b=fnvgMrBVkV2PjeD5BFM2XyHRlBYfAWNiEjIgd6jVds/KvOLaiC9Pye0kJaZ+eTwrI8
 ZbFi59IvEG8yVUhVDq+pu88tZ6Rpg07ivb2SmZYC9YFnx5WlH5riTTxxsKkd6/xfRCz+
 93SryWReNRyLOfl8y5RbCL/5J29NVPk74r7sRdbpWjqEULH62sBeNcJ/g6sOurQc/XHN
 RP7JBxVpCWO+gZ63GtRe4PAy1nBS/c5s10WKl3CU8D+Eh4JpdOL/lQ5EYcuupNpV28YU
 JShEeQn++/YLct+J+T2OYT0+lHAQlOtbtASwX1ya2jqlsU8uGsArlRoRMz9jne4ue4Ve
 1Pfg==
X-Gm-Message-State: AOJu0YwHC6mzoNY9EaBHqZlqvnPENYA3xq5AqgV9ADtyEQnn2PLY1z05
 jloEEpys8cTBEAiwXjM5NCTHFQvCr3zcAL7MCNWT09Gpe3VCp9mXXWd0DUfg9//UBlR7ZL+m6X4
 08GQ=
X-Google-Smtp-Source: AGHT+IFn0RsARR4AeqB/qzlFcMNxzovi6uDn/waaoIDmmZmWjNLNiqqLbs1WrJ9DoeKygoi994em2w==
X-Received: by 2002:a17:907:7e99:b0:a86:abbd:6834 with SMTP id
 a640c23a62f3a-a89828335famr502002066b.30.1725021639707; 
 Fri, 30 Aug 2024 05:40:39 -0700 (PDT)
Received: from [10.232.133.87] ([88.128.90.2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8989223199sm210978466b.219.2024.08.30.05.40.39
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Aug 2024 05:40:39 -0700 (PDT)
Message-ID: <642498c9-3db5-4947-bfb5-f1727b0e2a88@suse.com>
Date: Fri, 30 Aug 2024 14:40:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <20240827120237.25805-1-chrubis@suse.cz>
 <20240827120237.25805-3-chrubis@suse.cz>
Content-Language: en-US
In-Reply-To: <20240827120237.25805-3-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/4] Add support for mixing C and shell code
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

I like this minimal approach.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

On 8/27/24 14:02, Cyril Hrubis wrote:
> This is a proof of a concept of a seamless C and shell integration. The
> idea is that with this you can mix shell and C code as much as as you
> wish to get the best of the two worlds.
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> Reviewed-by: Richard Palethorpe <io@richiejp.com>
> ---
>   include/tst_test.h                           | 37 +++++++++++++
>   lib/tst_test.c                               | 51 +++++++++++++++++
>   testcases/lib/.gitignore                     |  1 +
>   testcases/lib/Makefile                       |  4 +-
>   testcases/lib/run_tests.sh                   | 11 ++++
>   testcases/lib/tests/.gitignore               |  6 ++
>   testcases/lib/tests/Makefile                 | 11 ++++
>   testcases/lib/tests/shell_test01.c           | 17 ++++++
>   testcases/lib/tests/shell_test02.c           | 18 ++++++
>   testcases/lib/tests/shell_test03.c           | 25 +++++++++
>   testcases/lib/tests/shell_test04.c           | 18 ++++++
>   testcases/lib/tests/shell_test05.c           | 27 +++++++++
>   testcases/lib/tests/shell_test06.c           | 16 ++++++
>   testcases/lib/tests/shell_test_brk.sh        |  6 ++
>   testcases/lib/tests/shell_test_check_argv.sh | 23 ++++++++
>   testcases/lib/tests/shell_test_checkpoint.sh |  7 +++
>   testcases/lib/tests/shell_test_pass.sh       |  6 ++
>   testcases/lib/tst_env.sh                     | 21 +++++++
>   testcases/lib/tst_res_.c                     | 58 ++++++++++++++++++++
>   19 files changed, 361 insertions(+), 2 deletions(-)
>   create mode 100755 testcases/lib/run_tests.sh
>   create mode 100644 testcases/lib/tests/.gitignore
>   create mode 100644 testcases/lib/tests/Makefile
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
> index afc6a5714..9871676a5 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -331,6 +331,8 @@ struct tst_fs {
>    * @child_needs_reinit: Has to be set if the test needs to call tst_reinit()
>    *                      from a process started by exec().
>    *
> + * @runs_script: Implies child_needs_reinit and forks_child at the moment.
> + *
>    * @needs_devfs: If set the devfs is mounted at tst_test.mntpoint. This is
>    *               needed for tests that need to create device files since tmpfs
>    *               at /tmp is usually mounted with 'nodev' option.
> @@ -521,6 +523,7 @@ struct tst_fs {
>   	unsigned int mount_device:1;
>   	unsigned int needs_rofs:1;
>   	unsigned int child_needs_reinit:1;
> +	unsigned int runs_script:1;
>   	unsigned int needs_devfs:1;
>   	unsigned int restore_wallclock:1;
>   
> @@ -529,6 +532,8 @@ struct tst_fs {
>   	unsigned int skip_in_lockdown:1;
>   	unsigned int skip_in_secureboot:1;
>   	unsigned int skip_in_compat:1;
> +
> +
>   	int needs_abi_bits;
>   
>   	unsigned int needs_hugetlbfs:1;
> @@ -616,6 +621,38 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
>    */
>   void tst_reinit(void);
>   
> +/**
> + * tst_run_script() - Prepare the environment and execute a (shell) script.
> + *
> + * @script_name: A filename of the script.
> + * @params: A NULL terminated array of (shell) script parameters, pass NULL if
> + *          none are needed. This what is passed starting from argv[1].
> + *
> + * The (shell) script is executed with LTP_IPC_PATH in environment so that the
> + * binary helpers such as tst_res_ or tst_checkpoint work properly when executed
> + * from the script. This also means that the tst_test.runs_script flag needs to
> + * be set.
> + *
> + * A shell script has to source the tst_env.sh shell script at the start and
> + * after that it's free to use tst_res in the same way C code would use.
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
> + * Return: A pid of the (shell) script process.
> + */
> +int tst_run_script(const char *script_name, char *const params[]);
> +
>   unsigned int tst_multiply_timeout(unsigned int timeout);
>   
>   /*
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 201b81e14..918bee2a1 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -4,6 +4,8 @@
>    * Copyright (c) Linux Test Project, 2016-2024
>    */
>   
> +#define _GNU_SOURCE
> +
>   #include <limits.h>
>   #include <stdio.h>
>   #include <stdarg.h>
> @@ -174,6 +176,50 @@ void tst_reinit(void)
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
> +int tst_run_script(const char *script_name, char *const params[])
> +{
> +	int pid;
> +	unsigned int i, params_len = params_array_len(params);
> +	char *argv[params_len + 2];
> +
> +	if (!tst_test->runs_script)
> +		tst_brk(TBROK, "runs_script flag must be set!");
> +
> +	argv[0] = (char*)script_name;
> +
> +	if (params) {
> +		for (i = 0; i < params_len; i++)
> +			argv[i+1] = params[i];
> +	}
> +
> +	argv[params_len+1] = NULL;
> +
> +	pid = SAFE_FORK();
> +	if (pid)
> +		return pid;
> +
> +	execvpe(script_name, argv, environ);
> +
> +	tst_brk(TBROK | TERRNO, "execvpe(%s, ...) failed!", script_name);
> +
> +	return -1;
> +}
> +
>   static void update_results(int ttype)
>   {
>   	if (!results)
> @@ -1226,6 +1272,11 @@ static void do_setup(int argc, char *argv[])
>   		tdebug = 1;
>   	}
>   
> +	if (tst_test->runs_script) {
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
> index 000000000..60e7d1bcf
> --- /dev/null
> +++ b/testcases/lib/run_tests.sh
> @@ -0,0 +1,11 @@
> +#!/bin/sh
> +
> +testdir=$(realpath $(dirname $0))
> +export PATH=$PATH:$testdir:$testdir/tests/
> +
> +for i in `seq -w 01 06`; do
> +	echo
> +	echo "*** Running shell_test$i ***"
> +	echo
> +	./tests/shell_test$i
> +done
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
> diff --git a/testcases/lib/tests/shell_test01.c b/testcases/lib/tests/shell_test01.c
> new file mode 100644
> index 000000000..b9f07308e
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
> +	tst_run_script("shell_test_pass.sh", NULL);
> +	tst_res(TINFO, "C test exits now");
> +}
> +
> +static struct tst_test test = {
> +	.runs_script = 1,
> +	.test_all = run_test,
> +};
> diff --git a/testcases/lib/tests/shell_test02.c b/testcases/lib/tests/shell_test02.c
> new file mode 100644
> index 000000000..087055794
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
> +	tst_run_script("shell_test_pass.sh", NULL);
> +	tst_reap_children();
> +	tst_res(TINFO, "Shell test has finished at this point!");
> +}
> +
> +static struct tst_test test = {
> +	.runs_script = 1,
> +	.test_all = run_test,
> +};
> diff --git a/testcases/lib/tests/shell_test03.c b/testcases/lib/tests/shell_test03.c
> new file mode 100644
> index 000000000..61436891e
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
> +	pid = tst_run_script("shell_test_pass.sh", NULL);
> +
> +	tst_res(TINFO, "Waiting for the pid %i", pid);
> +
> +	waitpid(pid, &status, 0);
> +
> +	tst_res(TINFO, "Shell test has %s", tst_strstatus(status));
> +}
> +
> +static struct tst_test test = {
> +	.runs_script = 1,
> +	.test_all = run_test,
> +};
> diff --git a/testcases/lib/tests/shell_test04.c b/testcases/lib/tests/shell_test04.c
> new file mode 100644
> index 000000000..a32dd1e9f
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
> +	tst_run_script("shell_test_check_argv.sh", params);
> +}
> +
> +static struct tst_test test = {
> +	.runs_script = 1,
> +	.test_all = run_test,
> +};
> diff --git a/testcases/lib/tests/shell_test05.c b/testcases/lib/tests/shell_test05.c
> new file mode 100644
> index 000000000..771af8fc3
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
> +	pid = tst_run_script("shell_test_checkpoint.sh", NULL);
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
> +	.runs_script = 1,
> +	.needs_checkpoints = 1,
> +	.test_all = run_test,
> +};
> diff --git a/testcases/lib/tests/shell_test06.c b/testcases/lib/tests/shell_test06.c
> new file mode 100644
> index 000000000..89d66bab0
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
> +	tst_run_script("shell_test_brk.sh", NULL);
> +}
> +
> +static struct tst_test test = {
> +	.runs_script = 1,
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
> index 000000000..ce357027d
> --- /dev/null
> +++ b/testcases/lib/tests/shell_test_check_argv.sh
> @@ -0,0 +1,23 @@
> +#!/bin/sh
> +
> +. tst_env.sh
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
> index 000000000..948bc5024
> --- /dev/null
> +++ b/testcases/lib/tst_env.sh
> @@ -0,0 +1,21 @@
> +#!/bin/sh
> +
> +tst_script_name=$(basename $0)
> +
> +if [ -z "$LTP_IPC_PATH" ]; then
> +	echo "This script has to be executed from a LTP loader!"
> +	exit 1
> +fi
> +
> +tst_brk_()
> +{
> +	tst_res_ "$@"
> +
> +	case "$3" in
> +		"TBROK") exit 2;;
> +		*) exit 0;;
> +	esac
> +}
> +
> +alias tst_res="tst_res_ $tst_script_name \$LINENO"
> +alias tst_brk="tst_brk_ $tst_script_name \$LINENO"
> diff --git a/testcases/lib/tst_res_.c b/testcases/lib/tst_res_.c
> new file mode 100644
> index 000000000..a43920f36
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
> +	tst_res_(argv[1], atoi(argv[2]), type, "%s", msg);
> +
> +	return 0;
> +help:
> +	print_help();
> +	return 1;
> +}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
