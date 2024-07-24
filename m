Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17003C3DA61
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 12:54:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 858253D1C3C
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 14:54:37 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 613783D0FA8
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 14:54:22 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7DC141A0C264
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 14:54:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CF6121FBCD;
 Wed, 24 Jul 2024 12:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721825660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6kYhg3l6l5QoBbJxOe5Fa9UDuDu7GVZDe45XCLOpSqA=;
 b=La5Mr/P58ugptly7QaAIzZ7vMzjWG5HwCuJColKdCWvLMnQkoIlPfjrlqL5z6evi0JngR4
 IqInSHeOWwiN9fpL6agpA0eCLfVTuqrVJcjD+LDYt5ScnmrvTzajz98GkCvLe3Laa/0AOV
 VPF9/SLhuxvWufmp6XRdrrC8j/dybWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721825660;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6kYhg3l6l5QoBbJxOe5Fa9UDuDu7GVZDe45XCLOpSqA=;
 b=ug7uvvKVlkC0WBLTJjZWru9a82icqsoONZecd+l6WnSluhAONFNegXl7Kf3mkpEroxnHeH
 mV2SThYlUKbXuXAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721825659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6kYhg3l6l5QoBbJxOe5Fa9UDuDu7GVZDe45XCLOpSqA=;
 b=N4ff3PSFtP8jEN+YquyksoU2gY9nn67/S/yn3VhZfU2UvD73T58nBZ5h9bJrZIdjd9OuZ2
 MfVHesr2E4pHtDU3hav29sI2wcjy/McMMGfTSdTGRP6Lgi6Q3zJOHurI0w/R8hN69GXEl7
 ypeu3RA6ITabqtIOSxGU3Hf0nnL1rNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721825659;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6kYhg3l6l5QoBbJxOe5Fa9UDuDu7GVZDe45XCLOpSqA=;
 b=oVgVnfWq38fecWXNfeHYShStOdL4l/c/GLgPpjBaXBtwH/FQx0GoiRYFaNRPn/pm1I8byk
 owl1X/wdnB1zc6Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C699A1324F;
 Wed, 24 Jul 2024 12:54:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NgM/MHv5oGY/DQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Wed, 24 Jul 2024 12:54:19 +0000
Message-ID: <d5cb1dc4-7bd7-4084-952d-95511cbbb907@suse.cz>
Date: Wed, 24 Jul 2024 14:54:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <20240716153604.22984-1-chrubis@suse.cz>
 <20240716153604.22984-3-chrubis@suse.cz>
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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
In-Reply-To: <20240716153604.22984-3-chrubis@suse.cz>
X-Spamd-Result: default: False [-4.09 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 2/2] testcaes/lib: Add shell loader
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
one note below.

On 16. 07. 24 17:36, Cyril Hrubis wrote:
> This commit implements a shell loader so that we don't have to write a C
> loader for each LTP shell test. The idea is simple, the loader parses
> the shell test and prepares the tst_test structure accordingly, then
> runs the actual shell test. Only small subset of the flags is
> implemented at the moment, since this is RFC, however it should be clear
> where this is going.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>   testcases/lib/.gitignore                      |  1 +
>   testcases/lib/Makefile                        |  3 +-
>   testcases/lib/run_tests.sh                    |  2 +
>   testcases/lib/tests/shell_loader.sh           | 11 ++-
>   .../lib/tests/shell_loader_all_filesystems.sh | 22 ++++++
>   testcases/lib/tst_run_shell.c                 | 78 +++++++++++++++++++
>   6 files changed, 114 insertions(+), 3 deletions(-)
>   mode change 100644 => 100755 testcases/lib/tests/shell_loader.sh
>   create mode 100755 testcases/lib/tests/shell_loader_all_filesystems.sh
>   create mode 100644 testcases/lib/tst_run_shell.c
> 
> diff --git a/testcases/lib/.gitignore b/testcases/lib/.gitignore
> index d0dacf62a..385f3c3ca 100644
> --- a/testcases/lib/.gitignore
> +++ b/testcases/lib/.gitignore
> @@ -24,3 +24,4 @@
>   /tst_supported_fs
>   /tst_timeout_kill
>   /tst_res_
> +/tst_run_shell
> diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
> index 928d76d62..fef284e35 100644
> --- a/testcases/lib/Makefile
> +++ b/testcases/lib/Makefile
> @@ -13,6 +13,7 @@ MAKE_TARGETS		:= tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp\
>   			   tst_getconf tst_supported_fs tst_check_drivers tst_get_unused_port\
>   			   tst_get_median tst_hexdump tst_get_free_pids tst_timeout_kill\
>   			   tst_check_kconfigs tst_cgctl tst_fsfreeze tst_ns_create tst_ns_exec\
> -			   tst_ns_ifmove tst_lockdown_enabled tst_secureboot_enabled tst_res_
> +			   tst_ns_ifmove tst_lockdown_enabled tst_secureboot_enabled tst_res_\
> +			   tst_run_shell
>   
>   include $(top_srcdir)/include/mk/generic_trunk_target.mk
> diff --git a/testcases/lib/run_tests.sh b/testcases/lib/run_tests.sh
> index 88607b146..9637ae327 100755
> --- a/testcases/lib/run_tests.sh
> +++ b/testcases/lib/run_tests.sh
> @@ -8,3 +8,5 @@ export PATH=$PATH:$PWD:$PWD/tests/
>   ./tests/shell_test04
>   ./tests/shell_test05
>   ./tests/shell_test06
> +./tst_run_shell shell_loader.sh
> +./tst_run_shell shell_loader_all_filesystems.sh
> diff --git a/testcases/lib/tests/shell_loader.sh b/testcases/lib/tests/shell_loader.sh
> old mode 100644
> new mode 100755
> index c3b3cf5fd..1a255fdee
> --- a/testcases/lib/tests/shell_loader.sh
> +++ b/testcases/lib/tests/shell_loader.sh
> @@ -1,5 +1,12 @@
> -#!/usr/bin/env tst_run_shell
> +#!/bin/sh
> +#
> +# needs_tmpdir=1
>   
>   . tst_env.sh
>   
> -tst_res TPASS "Shell loader works fine!"
> +case "$PWD" in
> +	/tmp/*)
> +	tst_res TPASS "We are running in temp directory in $PWD";;
> +	*)
> +	tst_res TFAIL "We are not running in temp directory but $PWD";;
> +esac
> diff --git a/testcases/lib/tests/shell_loader_all_filesystems.sh b/testcases/lib/tests/shell_loader_all_filesystems.sh
> new file mode 100755
> index 000000000..86d09d393
> --- /dev/null
> +++ b/testcases/lib/tests/shell_loader_all_filesystems.sh
> @@ -0,0 +1,22 @@
> +#!/bin/sh
> +#
> +# needs_root=1
> +# mount_device=1
> +# all_filesystems=1
> +
> +TST_MNTPOINT=ltp_mntpoint
> +
> +. tst_env.sh
> +
> +tst_res TINFO "IN shell"
> +
> +mounted=$(grep $TST_MNTPOINT /proc/mounts)

This check might produce false positive for example when another LTP 
shell script runs in parallel in another temp directory. I'd recommend 
using $(realpath ...) to disambiguate the mountpoints.

> +
> +if [ -n "$mounted" ]; then
> +	device=$(echo $mounted |cut -d' ' -f 1)
> +	path=$(echo $mounted |cut -d' ' -f 2)
> +
> +	tst_res TPASS "$device mounted at $path"
> +else
> +	tst_res TFAIL "Device not mounted!"
> +fi
> diff --git a/testcases/lib/tst_run_shell.c b/testcases/lib/tst_run_shell.c
> new file mode 100644
> index 000000000..583807376
> --- /dev/null
> +++ b/testcases/lib/tst_run_shell.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2024 Cyril Hrubis <chrubis@suse.cz>
> + */
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"
> +#include "tst_safe_stdio.h"
> +
> +static char *shell_filename;
> +
> +static void run_shell(void)
> +{
> +	tst_run_shell(shell_filename, NULL);
> +}
> +
> +struct tst_test test = {
> +	.test_all = run_shell,
> +	.runs_shell = 1,
> +};
> +
> +static void print_help(void)
> +{
> +	printf("Usage: tst_shell_loader ltp_shell_test.sh ...");
> +}
> +
> +#define FLAG_MATCH(str, name) (!strcmp(str, name "=1"))
> +#define PARAM_MATCH(str, name) (!strncmp(str, name "=", sizeof(name)))
> +#define PARAM_VAL(str, name) strdup(str + sizeof(name))
> +
> +static void prepare_test_struct(void)
> +{
> +	FILE *f;
> +	char line[4096];
> +	char path[4096];
> +
> +	if (tst_get_path(shell_filename, path, sizeof(path)) == -1)
> +		tst_brk(TBROK, "Failed to find %s in $PATH", shell_filename);
> +
> +	f = SAFE_FOPEN(path, "r");
> +
> +	while (fscanf(f, "%4096s[^\n]", line) != EOF) {
> +		if (FLAG_MATCH(line, "needs_tmpdir"))
> +			test.needs_tmpdir = 1;
> +		else if (FLAG_MATCH(line, "needs_root"))
> +			test.needs_root = 1;
> +		else if (FLAG_MATCH(line, "needs_device"))
> +			test.needs_device = 1;
> +		else if (FLAG_MATCH(line, "needs_checkpoints"))
> +			test.needs_checkpoints = 1;
> +		else if (FLAG_MATCH(line, "needs_overlay"))
> +			test.needs_overlay = 1;
> +		else if (FLAG_MATCH(line, "format_device"))
> +			test.format_device = 1;
> +		else if (FLAG_MATCH(line, "mount_device"))
> +			test.mount_device = 1;
> +		else if (PARAM_MATCH(line, "TST_MNTPOINT"))
> +			test.mntpoint = PARAM_VAL(line, "TST_MNTPOINT");
> +		else if (FLAG_MATCH(line, "all_filesystems"))
> +			test.all_filesystems = 1;
> +	}
> +
> +	fclose(f);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	if (argc < 2)
> +		goto help;
> +
> +	shell_filename = argv[1];
> +
> +	prepare_test_struct();
> +
> +	tst_run_tcases(argc - 1, argv + 1, &test);
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
