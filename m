Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D44D61013
	for <ltp@archiver.kernel.org>; Thu, 29 Jan 2026 13:08:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E138F3CC23B
	for <ltp@archiver.kernel.org>; Thu, 29 Jan 2026 14:08:52 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 47DF53CBF09
 for <ltp@lists.linux.it>; Thu, 29 Jan 2026 14:08:33 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 347181000601
 for <ltp@lists.linux.it>; Thu, 29 Jan 2026 14:08:32 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C015A340FA;
 Thu, 29 Jan 2026 13:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769692111;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z5C6bVncc4+p29YtT2Nylg+KP5bOtoZF5F421uW+O4w=;
 b=MKtp8C17ZMI7s7I+0e8jXZPMk4TIrJx3DVKCHkTw/HmLatnhazZYEHgQ/gaXwXhaHid4NE
 LjXgshW3F81OEybq8q1ienz0otYAP844GaDLHfX3Jgt18Bwb0E7TDjqyybg6weQvY9wxvq
 p4equpWbgqDQGkS6vroEGt7s1nIUq+Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769692111;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z5C6bVncc4+p29YtT2Nylg+KP5bOtoZF5F421uW+O4w=;
 b=2PpLdNRvEyfoI7xfraG/gYHzOUC5F3f7w9m3oPVpMALNDhO1Du4Lf41n/bKvMWQkxnZwN3
 0MztjcH53ZqIHeBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769692111;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z5C6bVncc4+p29YtT2Nylg+KP5bOtoZF5F421uW+O4w=;
 b=MKtp8C17ZMI7s7I+0e8jXZPMk4TIrJx3DVKCHkTw/HmLatnhazZYEHgQ/gaXwXhaHid4NE
 LjXgshW3F81OEybq8q1ienz0otYAP844GaDLHfX3Jgt18Bwb0E7TDjqyybg6weQvY9wxvq
 p4equpWbgqDQGkS6vroEGt7s1nIUq+Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769692111;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z5C6bVncc4+p29YtT2Nylg+KP5bOtoZF5F421uW+O4w=;
 b=2PpLdNRvEyfoI7xfraG/gYHzOUC5F3f7w9m3oPVpMALNDhO1Du4Lf41n/bKvMWQkxnZwN3
 0MztjcH53ZqIHeBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86F173EA61;
 Thu, 29 Jan 2026 13:08:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id znrxH89be2lNCwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 29 Jan 2026 13:08:31 +0000
Date: Thu, 29 Jan 2026 14:08:30 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Piotr Kubaj <piotr.kubaj@intel.com>
Message-ID: <20260129130830.GA102238@pevik>
References: <20260129111556.501121-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260129111556.501121-2-piotr.kubaj@intel.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] thermal: add new test group
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

Hi Piotr, all,

thanks for your work, v5 looks better. I'd like others have look into the code.
We have LTP release this week (hopefully, or next week if there is too much
work), then I ping others to have a look.

> This is a new test for checking thermal interrupt events.
> All but one points from v4 were addressed. The one that is still
> not addressed requires changing testing algorithm and is under
> discussion with our architect.

Thanks!

...
> diff --git a/testcases/kernel/thermal/thermal_interrupt_events.c b/testcases/kernel/thermal/thermal_interrupt_events.c
> new file mode 100644
> index 000000000..b4e457434
> --- /dev/null
> +++ b/testcases/kernel/thermal/thermal_interrupt_events.c
> @@ -0,0 +1,202 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/*
> + * Copyright (C) 2025-2026 Intel - http://www.intel.com/
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
> +#include "tst_safe_stdio.h"
> +#include "tst_test.h"
> +
> +#define	RUNTIME		30
> +#define	SLEEP		10
> +#define	TEMP_INCREMENT	10
> +
> +static bool x86_pkg_temp_tz_found;
> +static bool *x86_pkg_temp_tz;
> +static char trip_path[NAME_MAX];
> +static int nproc, trip, tz_counter;
> +static uint64_t *interrupt_init, *interrupt_later;
> +
> +static void interrupts(uint64_t *interrupt_array, const int nproc)

FYI in previous version I meant to rename uint64_t *interrupt_array => uint64_t
*interrupts. Function name read_interrupts() was actually more descriptive.
But that's a minor detail.


> +static void test_zone(int i)
> +{
> +			char path[NAME_MAX], temp_path[NAME_MAX];
> +			int sleep_time = SLEEP, temp_high, temp;
> +			double run_time = RUNTIME;
> +
> +			snprintf(path, NAME_MAX, "/sys/class/thermal/thermal_zone%d/", i);
> +			strncpy(temp_path, path, NAME_MAX);
> +			strncat(temp_path, "temp", 4);
> +			tst_res(TINFO, "Testing %s", temp_path);
> +			SAFE_FILE_SCANF(temp_path, "%d", &temp);
> +			if (temp < 0)
> +				tst_brk(TINFO, "Unexpected zone temperature value %d", temp);
I noted that in v4 that this should be tst_brk(TBROK, ...);
This is really worth to fix.
But please wait with next version for other reviewers, 


> +			tst_res(TDEBUG, "Current temperature for %s: %d", path, temp);
> +
> +			temp_high = temp + TEMP_INCREMENT;
> +
> +			strncpy(trip_path, path, NAME_MAX);
> +			strncat(trip_path, "trip_point_1_temp", 17);
> +
> +			tst_res(TDEBUG, "Setting new trip_point_1_temp value: %d", temp_high);
> +			SAFE_FILE_SCANF(trip_path, "%d", &trip);
> +			SAFE_FILE_PRINTF(trip_path, "%d", temp_high);
> +
> +			while (sleep_time > 0) {
> +				tst_res(TDEBUG, "Running for %f seconds, then sleeping for %d seconds", run_time, sleep_time);
> +
> +				for (int j = 0; j < nproc; j++) {
> +					if (!SAFE_FORK()) {
> +						cpu_workload(run_time);
> +						exit(0);
> +					}
> +				}
> +
> +				tst_reap_children();
> +
> +				SAFE_FILE_SCANF(temp_path, "%d", &temp);
> +				tst_res(TDEBUG, "Temperature for %s after a test: %d", path, temp);
> +
> +				if (temp > temp_high)
> +					break;
> +				sleep(sleep_time--);
> +				run_time -= 3;
> +			}
> +
> +			if (temp <= temp_high)
> +				tst_brk(TCONF, "Zone temperature is not rising as expected");

I hope not raising Zone is not an error. Otherwise there should be
tst_brk(TBROK), or tst_res(TFAIL) if it makes sense to verify the rest of the
zones.

> +}
> +
> +static void cleanup(void)
> +{
> +	SAFE_FILE_PRINTF(trip_path, "%d", trip);
> +	free(interrupt_init);
> +	free(interrupt_later);
> +}
> +
> +static void run(void)
> +{
> +	for (int i = 0; i < tz_counter; i++) {
> +		if (x86_pkg_temp_tz[i])
> +			test_zone(i);
> +	}
> +	interrupts(interrupt_later, nproc);
> +
> +	for (int i = 0; i < nproc; i++) {
> +		if (interrupt_later[i] < interrupt_init[i])
> +			tst_res(TFAIL, "CPU %d interrupt counter: %ld (previous: %ld)",
> +				i, interrupt_later[i], interrupt_init[i]);
You need some bool flag to remember the failure. Otherwise even if this fails...
> +	}
> +
> +	tst_res(TPASS, "x86 package thermal interrupt triggered");
... you still print TPASS (a bit confusing).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
