Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14182FF60DC
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 07:54:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA0A63E2AD3
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 09:54:12 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BEB7C3E21CF
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 09:53:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F10482010F7
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 09:53:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 20EE24D257;
 Tue, 31 Mar 2026 07:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774943632;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B4fXKlmlTDsi4ydtgkzCTpqgY54WV8XYpy0TleziLIg=;
 b=FxkVBEdDJyckv6qqHXNa6WwzY9xoFsZSm7WpW49aMC2XC4diXQ8zEsczC+qlY3KgwJmWEC
 AhbdrvVQDjb3GxUph84lRzIXTB4WnGQHBZZlSffuAF2TxE6DRQK3tWKbdR+VdycbX7Xn+z
 Ewilv+HjwAwXaQPwFZ067PEDawHvRPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774943632;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B4fXKlmlTDsi4ydtgkzCTpqgY54WV8XYpy0TleziLIg=;
 b=t44ymoE97JXiY1Xy7N7nZ5jIrVWh9IDxVoHO1Soflj8+CKguRIgi950o62ogte7FEtoZB3
 uGu9t0WgTlywmsCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774943632;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B4fXKlmlTDsi4ydtgkzCTpqgY54WV8XYpy0TleziLIg=;
 b=FxkVBEdDJyckv6qqHXNa6WwzY9xoFsZSm7WpW49aMC2XC4diXQ8zEsczC+qlY3KgwJmWEC
 AhbdrvVQDjb3GxUph84lRzIXTB4WnGQHBZZlSffuAF2TxE6DRQK3tWKbdR+VdycbX7Xn+z
 Ewilv+HjwAwXaQPwFZ067PEDawHvRPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774943632;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B4fXKlmlTDsi4ydtgkzCTpqgY54WV8XYpy0TleziLIg=;
 b=t44ymoE97JXiY1Xy7N7nZ5jIrVWh9IDxVoHO1Soflj8+CKguRIgi950o62ogte7FEtoZB3
 uGu9t0WgTlywmsCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0620F4A0A2;
 Tue, 31 Mar 2026 07:53:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CVbEAJB9y2kzcwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 31 Mar 2026 07:53:52 +0000
Date: Tue, 31 Mar 2026 09:53:46 +0200
From: Petr Vorel <pvorel@suse.cz>
To: lufei <lufei@uniontech.com>
Message-ID: <20260331075346.GB5254@pevik>
References: <20260330071554.49304-1-lufei@uniontech.com>
 <20260331015538.53326-1-lufei@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260331015538.53326-1-lufei@uniontech.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Rewrite ftrace_regression tests with new C API
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

Hi lufei,

> Rewritten from old shell scripts.

> ftrace_regression01: regression test for panic bug while using
> userstacktrace, set userstacktrace in loop and check if success.

> ftrace_regression02: for checking signal:signal_generate gives
> 2 more fields: grp res.

Thanks for the rewrite. Few things should be changed.

> +++ b/testcases/kernel/tracing/ftrace_test/Makefile
> @@ -2,6 +2,7 @@ top_srcdir              ?= ../../../..

>  include $(top_srcdir)/include/mk/testcases.mk

> -INSTALL_TARGETS         := *.sh ftrace_stress/*
> +INSTALL_TARGETS         := *.sh ftrace_stress/* ftrace_regression01 \
> +				ftrace_regression02

It's nice to actually run make install to verify it works:

$ make install
../../../../include/mk/env_post.mk:65: warning: overriding recipe for target '/opt/ltp/testcases/bin/ftrace_regression01'
../../../../include/mk/env_post.mk:64: warning: ignoring old recipe for target '/opt/ltp/testcases/bin/ftrace_regression01'
../../../../include/mk/env_post.mk:65: warning: overriding recipe for target '/opt/ltp/testcases/bin/ftrace_regression02'
../../../../include/mk/env_post.mk:64: warning: ignoring old recipe for target '/opt/ltp/testcases/bin/ftrace_regression02'

=> ftrace_regression01 ftrace_regression02 should not be added (C sources are already included).


...
> +#endif /* FTRACE_REGRESSION_H */
> diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression01.c b/testcases/kernel/tracing/ftrace_test/ftrace_regression01.c
> new file mode 100644
> index 000000000..b76d5bf7e
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_test/ftrace_regression01.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2015 Red Hat Inc.
> + * Copyright (c) 2026 lufei <lufei@uniontech.com>
> + */
> +
> +/*\
> + * Regression test for panic while using userstacktrace.
> + *
> + * BUG: unable to handle kernel paging request at 00000000417683c0
> + *      IP: [<ffffffff8105c834>] update_curr+0x124/0x1e0
> + *      Thread overran stack, or stack corrupted
> + *      Oops: 0000 [#1] SMP
> + *      last sysfs file: ../system/cpu/cpu15/cache/index2/shared_cpu_map
> + *
> + * The bug was fixed by:
> + *      1dbd195 (tracing: Fix preempt count leak)
Please use longer hash (12 chars).

> + */
> +
> +#include <unistd.h>
> +#include <stdio.h>
> +#include "ftrace_regression.h"
> +
> +#define DEBUGFS_DIR "debugfs"
> +#define STACK_TRACER_PATH "/proc/sys/kernel/stack_tracer_enabled"
> +#define TRACE_OPTIONS DEBUGFS_DIR "/tracing/trace_options"
> +#define EXC_PAGE_FAULT DEBUGFS_DIR "/tracing/events/exceptions/page_fault_kernel/enable"
> +#define MM_PAGE_FAULT DEBUGFS_DIR "/tracing/events/kmem/mm_kernel_pagefault/enable"
> +
> +#define LOOP 10
> +
> +static const char *page_fault_path;
> +static int page_fault_origin;
> +
> +static void setup(void)
> +{
> +	SAFE_MKDIR(DEBUGFS_DIR, 0755);
> +	SAFE_MOUNT(NULL, DEBUGFS_DIR, "debugfs", 0, NULL);
Maybe have helpers for mounting/unmounting debugfs in the header?
> +
> +	if (access(EXC_PAGE_FAULT, F_OK) == 0)
> +		page_fault_path = EXC_PAGE_FAULT;
> +	else if (access(MM_PAGE_FAULT, F_OK) == 0)
> +		page_fault_path = MM_PAGE_FAULT;
> +	else
> +		tst_brk(TCONF, "Page fault event not available");
> +
> +	SAFE_FILE_SCANF(page_fault_path, "%d", &page_fault_origin);
> +}
> +
> +static void run(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < LOOP; i++) {
> +		SAFE_FILE_PRINTF(STACK_TRACER_PATH, "1");
> +		SAFE_FILE_PRINTF(TRACE_OPTIONS, "userstacktrace");
> +
> +		if (!file_contains(TRACE_OPTIONS, "^userstacktrace"))
> +			tst_brk(TBROK, "Failed to set userstacktrace");
> +
> +		SAFE_FILE_PRINTF(page_fault_path, "1");
> +	}
> +
> +	SAFE_FILE_PRINTF(page_fault_path, "%d", page_fault_origin);
> +
> +	tst_res(TPASS, "Finished running the test");
Rewrite is not blind converting shell into C, but opportunity to improve the test.
Can we, please, have a meaningful message what passed?

> +}
> +
> +static void cleanup(void)
> +{
> +	SAFE_UMOUNT(DEBUGFS_DIR);
> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +	.setup = setup,
> +	.test_all = run,
> +	.cleanup = cleanup,
> +	.save_restore = (const struct tst_path_val[]) {
> +		{STACK_TRACER_PATH, NULL, TST_SR_TCONF},
> +		{}
> +	},
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "1dbd195"},
> +		{}
> +	},
> +};
> diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression02.c b/testcases/kernel/tracing/ftrace_test/ftrace_regression02.c
> new file mode 100644
> index 000000000..498db29e5
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_test/ftrace_regression02.c
> @@ -0,0 +1,68 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2015 Red Hat Inc.
> + * Copyright (c) 2026 lufei <lufei@uniontech.com>
> + */
> +
> +/*\
> + * Check signal:signal_generate gives 2 more fields: grp=[0-9] res=[0-9]
> + */
> +
> +#include <unistd.h>
> +#include <stdio.h>
> +#include "ftrace_regression.h"
> +
> +#define DEBUGFS_DIR "debugfs"
> +#define SET_EVENT DEBUGFS_DIR "/tracing/set_event"
> +#define TRACING_ON DEBUGFS_DIR "/tracing/tracing_on"
> +#define TRACE_FILE DEBUGFS_DIR "/tracing/trace"
> +
> +#define LOOP 100
> +
> +static void setup(void)
> +{
> +	SAFE_MKDIR(DEBUGFS_DIR, 0755);
> +	SAFE_MOUNT(NULL, DEBUGFS_DIR, "debugfs", 0, NULL);
> +}
> +
> +static void run(void)
> +{
> +	int i;
> +
> +	SAFE_FILE_PRINTF(SET_EVENT, "signal:signal_generate");
> +	SAFE_FILE_PRINTF(TRACING_ON, "1");
> +	SAFE_FILE_PRINTF(TRACE_FILE, "\n");
> +
> +	for (i = 0; i < LOOP; i++)
> +		tst_cmd((const char *[]){"ls", "-l", "/proc", NULL},
> +			"/dev/null", "/dev/null", 0);

> +	if (file_contains(TRACE_FILE, "grp=[0-9]") && file_contains(TRACE_FILE, "res=[0-9]"))
> +		tst_res(TPASS, "Finished running the test");
Also here, please, better tpass message.
> +	else
> +		tst_res(TFAIL, "Pattern grp=[0-9] res=[0-9] not found in trace");
> +}
> +
> +static void cleanup(void)
> +{
> +	SAFE_UMOUNT(DEBUGFS_DIR);
> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +	.setup = setup,
> +	.test_all = run,
> +	.cleanup = cleanup,
> +	.needs_cmds = (struct tst_cmd[]) {
> +		{.cmd = "ls"},
> +		{}
> +	},
> +	.min_kver = "3.2",
We now support kernel >= 4.4, this should be removed.
https://linux-test-project.readthedocs.io/en/latest/users/supported_systems.html#kernel-version

> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "6c303d3"},
> +		{"linux-git", "163566f"},
And longer hash.
> +		{}
> +	},
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
