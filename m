Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58EC0C5DF86
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 19:12:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AC2033CF3D9
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 21:12:53 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 440183C7AB3
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 21:12:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 164FF2000A7
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 21:12:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2689A85253;
 Thu, 20 Aug 2026 19:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787253150;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ciY2DoGmp/PO6nYHi1ApIPLdLfA4Sns2y3hihdPiGbA=;
 b=ln8zLT8OJByT9tdkhXJbGFIZNuXa0Th8XfisIIMAdtQNrAQ32P7xzH94K5Ne0CcFTNaTza
 IVxaYyelch+7MduRZE5HOTjP12VrGpjBShpLytETKeA1kMXkvRjZjdEa70zbx61ltFGiDj
 3OnDGyYDwSxRKLzj869eDumrTmIWjtw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787253150;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ciY2DoGmp/PO6nYHi1ApIPLdLfA4Sns2y3hihdPiGbA=;
 b=QtZp9cHtzS/77xE3i368HEGfsfSoXIBqppQxTtfpZbm84RJmaMpgSazjjnBibSDBmVwuPz
 Vn3xsMwq4yoXxeBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pQEdPHeu;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lICeugeh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787253146;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ciY2DoGmp/PO6nYHi1ApIPLdLfA4Sns2y3hihdPiGbA=;
 b=pQEdPHeuhhYQZ26xCC5qTM3h7oFOwgh2glhOe0IqpsCXph/HVUDDphuRobFUgVwhCAlqDq
 ZFZjFrBZN0RYqr4CwLZaJBUjBUSU6S797Jht3XuYpQLTSQaiM1V7Gz9ENxZBYlToV4G32i
 3R4NMLbvJahH2EX29jm8HI/8xLljm48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787253146;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ciY2DoGmp/PO6nYHi1ApIPLdLfA4Sns2y3hihdPiGbA=;
 b=lICeugehTQPBOtTGjtah+ct94HwqWUJibS5DWdR7rVFeuT61oqcdAP1myeVOY05WQdxHuF
 IhSxio2xevh6ECCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD93727A8;
 Thu, 20 Aug 2026 19:12:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cFOcLplRh2pbAQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 20 Aug 2026 19:12:25 +0000
Date: Thu, 20 Aug 2026 21:12:23 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260820191223.GA511766@pevik>
References: <20260819161634.1341577-1-chrubis@suse.cz>
 <20260819161634.1341577-17-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260819161634.1341577-17-chrubis@suse.cz>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 2689A85253
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 16/31] testcases: sysfs: Add sys_wakeup01
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

Hi Cyril,

> A test for /sys/class/wakeup/*/* files.

> +++ b/testcases/kernel/sysfs/class/wakeup/sys_wakeup01.c
> @@ -0,0 +1,118 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
> + */
> +
> +/*\
> + * Sanity checks for the wakeup source statistics exported under
> + * /sys/class/wakeup/wakeupN/.
> + *
> + * For every wakeup source the test verifies that:
> + *
> + * - name is a non-empty string
> + * - active_count, active_time_ms, event_count, expire_count, last_change_ms,
> + *   max_time_ms, prevent_suspend_time_ms, total_time_ms and wakeup_count are
> + *   all non-negative
> + * - active_time_ms <= total_time_ms (currently active time is part of the
> + *   accumulated total)
> + * - max_time_ms <= total_time_ms (the longest single event cannot exceed the
> + *   accumulated total)
> + *
> + * The test skips with TCONF when no wakeup source is present.
> + */
> +
> +#include <string.h>
> +#include <limits.h>
> +#include <dirent.h>
> +#include "tst_test.h"
> +#include "tst_sysfs_assert.h"
> +
> +#define WAKEUP "/sys/class/wakeup"
FYI some archs does not have wake up support therefore it does not have
/sys/class/wakeup directory, e.g. s390x.
...
> +static void do_test(void)
> +{
> +	DIR *d;
> +	struct dirent *ent;
> +	int found = 0;
> +
> +	d = SAFE_OPENDIR(WAKEUP);
Therefore this fails:
sys_wakeup01.c:100: TBROK: opendir(/sys/class/wakeup) failed: ENOENT (2)

I believe we need CONFIG_PM_SLEEP=y kconfig check.

drivers/base/power/wakeup_stats.c creates that directory in __init
wakeup_sources_sysfs_init(), and that source is guarded by CONFIG_PM_SLEEP=y,
which depends on CONFIG_SUSPEND=y.

> +
> +	while ((ent = SAFE_READDIR(d))) {
> +		if (strncmp(ent->d_name, "wakeup", 6))
> +			continue;
> +
> +		found = 1;
> +		check_wakeup(ent->d_name);
> +	}
> +
> +	SAFE_CLOSEDIR(d);
> +
> +	if (!found)
> +		tst_res(TCONF, "No wakeup source found");

This TCONF is also valid, but too late.

There are similar failures in other tests, I guess I'll post you CI links.

Kind regards,
Petr

> +}
> +
> +static struct tst_test test = {
> +	.test_all = do_test,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
