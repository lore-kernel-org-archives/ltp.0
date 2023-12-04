Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B9EC4167B
	for <ltp@archiver.kernel.org>; Mon,  4 Dec 2023 10:40:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 35C543CC303
	for <ltp@archiver.kernel.org>; Mon,  4 Dec 2023 11:40:05 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 630B53CC207
 for <ltp@lists.linux.it>; Mon,  4 Dec 2023 11:39:54 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 90A23600D94
 for <ltp@lists.linux.it>; Mon,  4 Dec 2023 11:39:53 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1DC0622062;
 Mon,  4 Dec 2023 10:39:52 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E45DE139E2;
 Mon,  4 Dec 2023 10:39:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id mfwMNnesbWWCRAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Mon, 04 Dec 2023 10:39:51 +0000
Date: Mon, 4 Dec 2023 11:39:50 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Stefan Roesch <shr@devkernel.io>
Message-ID: <20231204103950.GA22019@pevik>
References: <20231201210930.2651725-1-shr@devkernel.io>
 <20231201210930.2651725-3-shr@devkernel.io>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231201210930.2651725-3-shr@devkernel.io>
X-Spamd-Bar: ++++++++++++
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de; dkim=none;
 spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither
 permitted nor denied by domain of pvorel@suse.cz)
 smtp.mailfrom=pvorel@suse.cz; dmarc=none
X-Rspamd-Queue-Id: 1DC0622062
X-Spamd-Result: default: False [12.18 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_SPAM_SHORT(2.99)[0.998]; MIME_GOOD(-0.10)[text/plain];
 MID_RHS_NOT_FQDN(0.50)[]; ARC_NA(0.00)[];
 R_SPF_SOFTFAIL(4.60)[~all]; DMARC_NA(1.20)[suse.cz];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 RCVD_COUNT_THREE(0.00)[3]; MX_GOOD(-0.01)[];
 NEURAL_SPAM_LONG(3.50)[1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(2.20)[]; MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] add ksm test for smart-scan feature
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
Cc: david@redhat.com, linux-mm@kvack.org, oliver.sang@intel.com,
 kernel-team@fb.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Stefan,

...
> +++ b/testcases/kernel/mem/ksm/ksm07.c
> @@ -0,0 +1,69 @@
> +/*
> + * Copyright (C) 2010-2017  Red Hat, Inc.
> + *

> + * This program is free software;  you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> + * the GNU General Public License for more details.
NOTE: we use SPDX instead of verbose GPL (see ksm06.c).
> + *

NOTE: we have special doc format which starts like this (see ksm06.c):
/*\
 * [Description]
 *
 * ...
> + * Kernel Samepage Merging (KSM)
> + *
> + * This adds a new ksm (kernel samepage merging) test to evaluate the new
> + * smart scan feature. It allocates a page and fills it with 'a'
> + * characters. It captures the pages_skipped counter, waits for a few
> + * iterations and captures the pages_skipped counter again. The expectation
> + * is that over 50% of the page scans are skipped (There is only one page
> + * that has KSM enabled and it gets scanned during each iteration and it
> + * cannot be de-duplicated).
> + *
> + * Prerequisites:
> + *
> + * 1) ksm and ksmtuned daemons need to be disabled. Otherwise, it could
> + *    distrub the testing as they also change some ksm tunables depends
> + *    on current workloads.
Hm, we don't have to any helper in LTP API to detect this, so at least we
document this.
> + *
> + */

The result is then uploaded:
https://github.com/linux-test-project/ltp/releases/download/20230929/metadata.20230929.html

Therefore please use:

// SPDX-License-Identifier: GPL-2.0-or-later
/*
 * Copyright (C) 2010-2017  Red Hat, Inc.
 */
/*\
 * [Description]
 *
 * Kernel Samepage Merging (KSM)
 *
 * This adds a new ksm (kernel samepage merging) test to evaluate the new
 * smart scan feature. It allocates a page and fills it with 'a'
 * characters. It captures the pages_skipped counter, waits for a few
 * iterations and captures the pages_skipped counter again. The expectation
 * is that over 50% of the page scans are skipped (There is only one page
 * that has KSM enabled and it gets scanned during each iteration and it
 * cannot be de-duplicated).
 *
 * Prerequisites:
 *
 * 1) ksm and ksmtuned daemons need to be disabled. Otherwise, it could
 *    distrub the testing as they also change some ksm tunables depends
 *    on current workloads.
 */

> +
> +#include <sys/types.h>
> +#include <sys/mman.h>
> +#include <sys/stat.h>
> +#include <sys/wait.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <signal.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include "../include/mem.h"
> +#include "ksm_common.h"
> +
> +static void verify_ksm(void)
> +{
> +	create_memory_for_smartscan();
I wonder, if we reusable create_memory_for_smartscan() later. Maybe it should be
put into ksm07 for the start.

Also, the test needs to run on older kernel - exit with TCONF (which is not
considered as a failure) instead of TBROK which does now:
mem.c:488: TBROK: Failed to open FILE '/sys/kernel/mm/ksm/pages_skipped' for reading: ENOENT (2)

If the testing code stays in testcases/kernel/mem/lib/mem.c, you will have to
stat() it. But if it's really just this test specific and you move it to
ksm07.c, then you can simply add the handling via .save_restore.

> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.forks_child = 1,
> +	.options = (struct tst_option[]) {
> +		{}
> +	},
> +	.save_restore = (const struct tst_path_val[]) {
> +		{"/sys/kernel/mm/ksm/run", NULL, TST_SR_TBROK},
> +		{"/sys/kernel/mm/ksm/sleep_millisecs", NULL, TST_SR_TBROK},
> +		{"/sys/kernel/mm/ksm/smart_scan", "1",
> +			TST_SR_SKIP_MISSING | TST_SR_TBROK_RO},
> +		{}
> +	},
> +	.needs_kconfigs = (const char *const[]){
> +		"CONFIG_KSM=y",
> +		NULL
> +	},
> +	.test_all = verify_ksm,
> +};

Also, there are missing static:
$ cd testcases/kernel/mem/ksm/; make check-ksm07
CHECK testcases/kernel/mem/ksm/ksm07.c
ksm07.c:1: WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
make: [../../../../include/mk/rules.mk:56: check-ksm07] Error 1 (ignored)
ksm07.c: note: in included file:
ksm_common.h:14:5: warning: Symbol 'size' has no prototype or library ('tst_') prefix. Should it be static?
ksm_common.h:14:29: warning: Symbol 'num' has no prototype or library ('tst_') prefix. Should it be static?
ksm_common.h:14:38: warning: Symbol 'unit' has no prototype or library ('tst_') prefix. Should it be static?
ksm_common.h:15:6: warning: Symbol 'opt_sizestr' has no prototype or library ('tst_') prefix. Should it be static?
ksm_common.h:15:20: warning: Symbol 'opt_numstr' has no prototype or library ('tst_') prefix. Should it be static?
ksm_common.h:15:33: warning: Symbol 'opt_unitstr' has no prototype or library ('tst_') prefix. Should it be static?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
