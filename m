Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377D5F88089
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 07:22:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C0ED63C9F04
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 09:22:51 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DD923C98AB
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 09:22:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 39E68600866
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 09:22:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7F7EE5BD1A;
 Thu, 16 Apr 2026 07:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776324150;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wk9M2/8gFqOKtobEM5V99FBsLWDKSR8kvd3mSjXSxas=;
 b=1HaR6JAYDrTtSdTPSw5Wci8WuurL+G/NCQqFJJr2Kx13nD7klqJhKa+O9t78wKAEuDwpCq
 c83mz5a2KqQHds+GQp7as0BgRQcTv4uGCA1rJBRqdVf3j8SosOc+cIXGvyapKlHchIm9Pk
 4fB69LRu0u0wcGkX97zUG2a/nlcIN5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776324150;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wk9M2/8gFqOKtobEM5V99FBsLWDKSR8kvd3mSjXSxas=;
 b=Z1aBSFZbmmtdK62ZoDfVRXYzoVOyKIh7sDNt46osOd5jLohgergDVs4azIIlMKqeqfHYFD
 wfbW8rco/B8bnDCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1HaR6JAY;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Z1aBSFZb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776324150;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wk9M2/8gFqOKtobEM5V99FBsLWDKSR8kvd3mSjXSxas=;
 b=1HaR6JAYDrTtSdTPSw5Wci8WuurL+G/NCQqFJJr2Kx13nD7klqJhKa+O9t78wKAEuDwpCq
 c83mz5a2KqQHds+GQp7as0BgRQcTv4uGCA1rJBRqdVf3j8SosOc+cIXGvyapKlHchIm9Pk
 4fB69LRu0u0wcGkX97zUG2a/nlcIN5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776324150;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wk9M2/8gFqOKtobEM5V99FBsLWDKSR8kvd3mSjXSxas=;
 b=Z1aBSFZbmmtdK62ZoDfVRXYzoVOyKIh7sDNt46osOd5jLohgergDVs4azIIlMKqeqfHYFD
 wfbW8rco/B8bnDCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 506F84BE38;
 Thu, 16 Apr 2026 07:22:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BFtdEjaO4GkoagAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 16 Apr 2026 07:22:30 +0000
Date: Thu, 16 Apr 2026 09:22:29 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Piotr Kubaj <piotr.kubaj@intel.com>
Message-ID: <20260416072229.GA287995@pevik>
References: <20260408132728.653586-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260408132728.653586-2-piotr.kubaj@intel.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 ASN_FAIL(0.00)[7.9.0.0.4.6.0.0.0.5.1.0.0.1.0.0.4.0.1.0.1.8.2.b.0.4.e.d.7.0.a.2.asn6.rspamd.com:server
 fail]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7F7EE5BD1A
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v16] thermal: add new test group
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
Cc: daniel.niestepski@intel.com, tomasz.ossowski@intel.com,
 helena.anna.dubel@intel.com, rafael.j.wysocki@intel.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Currently consists of only one test for the CPU package thermal sensor
> interface for Intel platforms.
> It works by checking the initial count of thermal interrupts. Then it
> decreases the threshold for sending a thermal interrupt to just above
> the current temperature and runs a workload on the CPU. Finally, it
> restores the original thermal threshold and checks whether the number
> of thermal interrupts increased.

> Signed-off-by: Piotr Kubaj <piotr.kubaj@intel.com>
> ---
> I previously missed Petr's email, this version addresses his feedback as well.

Thank you!

LGTM, minor formatting notes below (ignore, unless you need to send another
version, or it could be done before merge).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

We have (after update) few more fixes needed. But that can be done before merge.
thermal_interrupt_events.c:64: CHECK: Avoid CamelCase: <PRIu64>
thermal_interrupt_events.c:177: CHECK: Blank lines aren't necessary before a close brace '}'
thermal_interrupt_events.c:215: CHECK: Blank lines aren't necessary before a close brace '}'

>  runtest/thermal                               |   3 +
>  testcases/kernel/Makefile                     |   1 +
>  testcases/kernel/thermal/.gitignore           |   1 +
>  testcases/kernel/thermal/Makefile             |   9 +
>  .../kernel/thermal/thermal_interrupt_events.c | 235 ++++++++++++++++++
>  5 files changed, 249 insertions(+)
>  create mode 100644 runtest/thermal
>  create mode 100644 testcases/kernel/thermal/.gitignore
>  create mode 100644 testcases/kernel/thermal/Makefile
>  create mode 100644 testcases/kernel/thermal/thermal_interrupt_events.c

> diff --git a/runtest/thermal b/runtest/thermal
> new file mode 100644
> index 000000000..57e3d29f8
> --- /dev/null
> +++ b/runtest/thermal
> @@ -0,0 +1,3 @@
> +# Thermal driver API
> +# https://docs.kernel.org/driver-api/thermal/
> +thermal_interrupt_events thermal_interrupt_events
> diff --git a/testcases/kernel/Makefile b/testcases/kernel/Makefile
> index 98fd45a9d..ac816e4e8 100644
> --- a/testcases/kernel/Makefile
> +++ b/testcases/kernel/Makefile
> @@ -36,6 +36,7 @@ SUBDIRS			+= connectors \
>  			   sched \
>  			   security \
>  			   sound \
> +			   thermal \
>  			   tracing \
>  			   uevents \
>  			   watchqueue \
> diff --git a/testcases/kernel/thermal/.gitignore b/testcases/kernel/thermal/.gitignore
> new file mode 100644
> index 000000000..1090bdad8
> --- /dev/null
> +++ b/testcases/kernel/thermal/.gitignore
> @@ -0,0 +1 @@
> +thermal_interrupt_events
> diff --git a/testcases/kernel/thermal/Makefile b/testcases/kernel/thermal/Makefile
> new file mode 100644
> index 000000000..4657c3fb3
> --- /dev/null
> +++ b/testcases/kernel/thermal/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2025, Intel Corporation. All rights reserved.
> +# Author:Piotr Kubaj <piotr.kubaj@intel.com>
> +
> +top_srcdir             ?= ../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/thermal/thermal_interrupt_events.c b/testcases/kernel/thermal/thermal_interrupt_events.c
> new file mode 100644
> index 000000000..e3204784e
> --- /dev/null
> +++ b/testcases/kernel/thermal/thermal_interrupt_events.c
> @@ -0,0 +1,235 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 Intel - http://www.intel.com/
> + */
> +
> +/*\
> + * Tests the CPU package thermal sensor interface for Intel platforms.
> +
> + * Works by checking the initial count of thermal interrupts. Then it
> + * decreases the threshold for sending a thermal interrupt to just above
> + * the current temperature and runs a workload on the CPU. Finally, it restores
> + * the original thermal threshold and checks whether the number of thermal
> + * interrupts increased.
> + */
> +
> +#include <ctype.h>
> +#include <inttypes.h>
> +#include "tst_safe_stdio.h"
> +#include "tst_test.h"
> +#include "tst_timer_test.h"
> +
> +#define	TEST_RUNTIME	3
> +#define	RUNTIME		30
> +#define	SLEEP		10
> +#define	TEMP_INCREMENT	10
> +
> +static bool x86_pkg_temp_tz_found, *x86_pkg_temp_tz;
> +static char temp_path[PATH_MAX], trip_path[PATH_MAX];
> +static int nproc, temp_high, temp, *trip_orig, tz_counter;
> +static uint64_t *interrupt_init, *interrupt_later;
> +
> +static void read_interrupts(uint64_t *interrupts)
> +{
> +	bool interrupts_found = false;
> +	char line[8192];
> +
> +	memset(interrupts, 0, nproc * sizeof(*interrupts));
> +	FILE *fp = SAFE_FOPEN("/proc/interrupts", "r");
> +
> +	while (fgets(line, sizeof(line), fp)) {
> +		if (strstr(line, "Thermal event interrupts")) {
very nit: reverting the condition would allow to remove one indentation level
(helps readability):

	while (fgets(line, sizeof(line), fp)) {
		if (!strstr(line, "Thermal event interrupts"))
			continue;

		interrupts_found = true;
		char *ptr = strchr(line, ':');

The rest LGTM.

Kind regards,
Petr

> +			interrupts_found = true;
> +			char *ptr = strchr(line, ':');
> +
> +			for (int i = 0; i < nproc; i++) {
> +				char *endptr;
> +
> +				while (*ptr && !isdigit(*ptr))
> +					ptr++;
> +
> +				errno = 0;
> +
> +				interrupts[i] = strtoull(ptr, &endptr, 10);
> +
> +				if (ptr == endptr)
> +					tst_brk(TBROK, "CPU %d: interrupt not found", nproc);
> +
> +				if (errno == ERANGE)
> +					tst_brk(TBROK, "CPU %d: interrupt out of range", nproc);
> +
> +				ptr = endptr;
> +				tst_res(TDEBUG, "interrupts[%d]: %" PRIu64, i, interrupts[i]);
> +			}
> +			break;
> +		}
> +	}
> +	SAFE_FCLOSE(fp);
> +	if (!interrupts_found)
> +		tst_brk(TCONF, "No Thermal event interrupts line in /proc/interrupts");
> +}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
