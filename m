Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21817C433EF
	for <ltp@archiver.kernel.org>; Tue,  4 Jan 2022 11:04:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E75ED3C908E
	for <ltp@archiver.kernel.org>; Tue,  4 Jan 2022 12:04:47 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 16D913C1D3C
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 12:04:38 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 77760600120
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 12:04:37 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BEA27210F2;
 Tue,  4 Jan 2022 11:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641294276;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1cSKDHl6U6uZT9kz+Lb7f9FRj30vo8ndIYGhGUywbOQ=;
 b=2nLglbeer0MuT+sXJJP/0sEv0ONwbZqh8E90yFMN8O8SnZlh+8ODJE4lsI+07vm0LvEqMK
 ut+vS6Ych42UId2aK2AJszW0dn2XX1HrEcO6FPRgCLnp9nsmMcMM4b1842A02PO31/k+Ve
 Sx2ngzp2PftENCas1JjoZm/sH21bAMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641294276;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1cSKDHl6U6uZT9kz+Lb7f9FRj30vo8ndIYGhGUywbOQ=;
 b=TneNgR30smy1HnUEFDzZb1v+wF5kvu7vv6V5cIa96+u+qxocL3XWRL7COLNMljCpymGGF+
 lt25IxIk9jLG40AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9171B13ADF;
 Tue,  4 Jan 2022 11:04:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id lIGTIcQp1GFmLwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 04 Jan 2022 11:04:36 +0000
Date: Tue, 4 Jan 2022 12:04:34 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YdQpwpbyGGNKx84z@pevik>
References: <1641279439-2421-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641279439-2421-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1641279439-2421-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/3] shell: add kconfig parse api
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

> Use tst_check_kconfigs command to call tst_kconfig_check function in internal.
> It introduces three variables in tst_test.sh
> TST_NEEDS_KCONFIGS
> TST_NEEDS_KCONFIG_IFS (default value is comma)
> TST_TCONF_IF_KCONFIG (default value is 1, 0 means to use TWRAN and case continue)

> Also, we can use tst_check_kconfigs in your shell case if you want to skip subtest
> case instead the whole test.

> ps:Don't use array in tst_require_kconfigs because dash doesn't support shell array.
IFS instead of array is has been used since tst_test.sh creation, maybe we can
omit this info.

> Fixes:#891
> Suggested-by: Petr Vorel <pvorel@suse.cz>
> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>

> +++ b/doc/shell-test-api.txt
> @@ -193,22 +193,23 @@ simply by setting right '$TST_NEEDS_FOO'.

>  [options="header"]
>  |=============================================================================
> -| Variable name      | Action done
> -| 'TST_NEEDS_ROOT'   | Exit the test with 'TCONF' unless executed under root.
> -|                    | Alternatively the 'tst_require_root' command can be used.
> -| 'TST_NEEDS_TMPDIR' | Create test temporary directory and cd into it.
> -| 'TST_NEEDS_DEVICE' | Prepare test temporary device, the path to testing
> -                       device is stored in '$TST_DEVICE' variable.
> -                       The option implies 'TST_NEEDS_TMPDIR'.
> -| 'TST_NEEDS_CMDS'   | String with command names that has to be present for
> -                       the test (see below).
> -| 'TST_NEEDS_MODULE' | Test module name needed for the test (see below).
> -| 'TST_NEEDS_DRIVERS'| Checks kernel drivers support for the test.
> -| 'TST_TIMEOUT'      | Maximum timeout set for the test in sec. Must be int >= 1,
> -                       or -1 (special value to disable timeout), default is 300.
> -                       Variable is meant be set in tests, not by user.
> -                       It's an equivalent of `tst_test.timeout` in C, can be set
> -                       via 'tst_set_timeout(timeout)' after test has started.
> +| Variable name       | Action done
> +| 'TST_NEEDS_ROOT'    | Exit the test with 'TCONF' unless executed under root.
> +|                     | Alternatively the 'tst_require_root' command can be used.
> +| 'TST_NEEDS_TMPDIR'  | Create test temporary directory and cd into it.
> +| 'TST_NEEDS_DEVICE'  | Prepare test temporary device, the path to testing
> +                        device is stored in '$TST_DEVICE' variable.
> +                        The option implies 'TST_NEEDS_TMPDIR'.
> +| 'TST_NEEDS_CMDS'    | String with command names that has to be present for
> +                        the test (see below).
> +| 'TST_NEEDS_MODULE'  | Test module name needed for the test (see below).
> +| 'TST_NEEDS_DRIVERS' | Checks kernel drivers support for the test.
> +| 'TST_NEEDS_KCONFIGS'| Checks kernel kconfigs support for the test (see below).
+1 for adding TST_NEEDS_KCONFIG_IFS, it's needed e.g. for: CONFIG_LSM="integrity,apparmor"
Could you please mention TST_NEEDS_KCONFIG_IFS and TST_TCONF_IF_KCONFIG here in docs?

> +| 'TST_TIMEOUT'       | Maximum timeout set for the test in sec. Must be int >= 1,
> +                        or -1 (special value to disable timeout), default is 300.
> +                        Variable is meant be set in tests, not by user.
> +                        It's an equivalent of `tst_test.timeout` in C, can be set
> +                        via 'tst_set_timeout(timeout)' after test has started.
>  |=============================================================================

>  [options="header"]
> @@ -742,3 +743,27 @@ TST_NEEDS_CHECKPOINTS=1
>  Since both the implementations are compatible, it's also possible to start
>  a child binary process from a shell test and synchronize with it. This process
>  must have checkpoints initialized by calling 'tst_reinit()'.
> +
> +1.7 Parsing kernel .config
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The shell library provides an implementation of the kconfig parsing interface
> +compatible with the C version.
> +
> +It's possible to pass kernel kconfig list for tst_require_kconfigs api with
nit: s/api/API/ (it's an abbreviation). Also before merge please update git commit message.

> +'$TST_NEEDS_KCONFIGS'.
> +Optional '$TST_NEEDS_KCONFIG_IFS' is used for splitting, default value is comma.
> +Optional '$TST_TCONF_IF_KCONFIG' is used for deciding how to exit the test if kernel
> +.config doesn't meet test's requirement, default value is 1(TCONF). Otherwise, just
I wonder if we need TST_TCONF_IF_KCONFIG functionality in the test or if it's an
user request (i.e. user like variable LTP_TCONF_IF_KCONFIG doc/user-guide.txt).
Because I'm not sure whether test would need it, but I can imagine user want to
have test running even kernel config is not available (e.g. embedded platforms).
Or maybe we need both user variable and test variable.

Also not sure about TST_TCONF_IF_KCONFIG name, IMHO "IF" should be replaced to
something which describes what it does.

Also this patchset is about syncing C API functionality with shell API. But you
introduce TST_TCONF_IF_KCONFIG only for shell. Shouldn't it be functionality for
both parts?

More notes about this variable also below.

BTW github actions have probably kernel config on expected place, which means
that most of the new tests TCONF, but tst_check_kconfig05.sh TFAIL.

tst_rhost_run 1 TCONF: veth(null)      0  TWARN  :  /__w/ltp/ltp/lib/tst_kernel.c:110: expected file /lib/modules/5.11.0-1022-azure/modules.dep does not exist or not a file
320
(null)      0  TWARN  :  /__w/ltp/ltp/lib/tst_kernel.c:110: expected file /lib/modules/5.11.0-1022-azure/modules.builtin does not exist or not a file driver not available

> +use TWRAN and continue to run test.
> +
> +Now, we support the length of kconfig list is 10.
Why 10? Cyril suggested that in PR, where he suggested to use separated
variables:
https://github.com/linux-test-project/ltp/issues/891#issuecomment-989712350

But for string used like array there is no performance limitation, thus I'd use
something like 50 or 100. Because for certain IMA tests there are at least 6
kconfig requirements, thus > 10 could be hit.

...
> diff --git a/lib/newlib_tests/shell/tst_check_kconfig01.sh b/lib/newlib_tests/shell/tst_check_kconfig01.sh
> new file mode 100755
> index 000000000..dc09b6092
> --- /dev/null
> +++ b/lib/newlib_tests/shell/tst_check_kconfig01.sh
> @@ -0,0 +1,26 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
> +
> +TST_TESTFUNC=do_test
> +TST_NEEDS_CMDS="tst_check_kconfigs"
> +TST_NEEDS_KCONFIGS="CONFIG_GENERIC_IRQ_PROBE=y,
> +CONFIG_GENERIC_IRQ_SHOW=y,
> +CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y,
> +CONFIG_GENERIC_PENDING_IRQ=y,
> +CONFIG_GENERIC_IRQ_MIGRATION=y,
> +CONFIG_IRQ_DOMAIN=y,
> +CONFIG_IRQ_DOMAIN_HIERARCHY=y,
> +CONFIG_GENERIC_MSI_IRQ=y,
> +CONFIG_GENERIC_MSI_IRQ_DOMAIN=y,
> +CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y,
> +CONFIG_GENERIC_IRQ_RESERVATION_MODE=y"
> +
> +. tst_test.sh
> +
> +do_test()
> +{
> +	tst_res TFAIL "Kconfig api only supports 10 kernel kconfigs!"
s/api/API

...
> +++ b/lib/newlib_tests/shell/tst_check_kconfig05.sh
> @@ -0,0 +1,26 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
> +
> +TST_TESTFUNC=do_test
> +TST_NEEDS_CMDS="tst_check_kconfigs"
> +. tst_test.sh
> +
> +do_test()
> +{
> +	tst_check_kconfigs "CONFIG_EXT4_FS"
> +	if [ $? -eq 0 ]; then
> +		tst_res TPASS "kernel .config has CONFIG_EXT4_fs."
nit: I'd also remove dot at the end (we don't use it in tests).

> +	else
> +		tst_res TFAIL "kerenl .config doesn't have CONFIG_EXT4_FS."
s/kerenl/kernel/
> +	fi
> +
> +	tst_check_kconfigs "CONFIG_EXT4"
> +	if [ $? -eq 0 ]; then
> +		tst_res TFAIL "kernel .config has CONFIG_EXT4."
> +	else
> +		tst_res TPASS "kernel .config doesn't have CONFIG_EXT4."
> +	fi
> +}
> +
> +tst_run
> diff --git a/lib/newlib_tests/shell/tst_check_kconfig06.sh b/lib/newlib_tests/shell/tst_check_kconfig06.sh
> new file mode 100755
> index 000000000..6a6d68fd7
> --- /dev/null
> +++ b/lib/newlib_tests/shell/tst_check_kconfig06.sh
> @@ -0,0 +1,17 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
> +
> +TST_TESTFUNC=do_test
> +TST_NEEDS_CMDS="tst_check_kconfigs"
> +TST_NEEDS_KCONFIGS="CONFIG_EXT4"
> +TST_TCONF_IF_KCONFIG=0
IMHO in shell is better to have empty value for "false", not zero.
Also, we use it that way for shell variables.

But that would mean you'd have to allow to be empty, i.e. use : instead of :-:
+TST_TCONF_IF_KCONFIG="${TST_TCONF_IF_KCONFIG:-1}"
-TST_TCONF_IF_KCONFIG="${TST_TCONF_IF_KCONFIG:1}"

But maybe it'd be better to have variable which is off by default (thus variable
with reverse meaning).

...
> +++ b/testcases/lib/tst_check_kconfigs.c
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.*/
> +
> +#include <stdio.h>
> +#include "tst_kconfig.h"
> +
> +int main(int argc, const char *argv[])
> +{
> +	if (argc < 2) {
> +		fprintf(stderr, "Please provide kernel kconfig list\n");
> +		return 1;
> +	}
> +
> +	if (tst_kconfig_check(argv+1))
> +		return 1;
nit: I'd add space here (readability).
> +	return 0;
> +}
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 2556b28f5..c8134692e 100644
...

> --- a/testcases/lib/tst_test.sh
> +	tst_check_kconfigs $kconfig1 $kconfig2 $kconfig3 $kconfig4 $kconfig5 $kconfig6\
> +			$kconfig7 $kconfig8 $kconfig9 $kconfig10
> +	if [ $? -ne 0 ]; then
> +		if [ $TST_TCONF_IF_KCONFIG -eq 1 ]; then
> +			tst_brk TCONF "kconfig not available"

> +		else
> +			tst_res TWARN "kconfig not available"
This is quite strong: either test "fails" due TWARN non-zero exit code or it's
skipped. I'd prefer to have user variable for systems which are properly
configured (user will make sure all kconfig options are set), but it's just
missing kconfig due system configuration.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
