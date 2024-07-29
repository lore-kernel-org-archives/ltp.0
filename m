Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1EBC3DA4A
	for <ltp@archiver.kernel.org>; Mon, 29 Jul 2024 20:51:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A5CB13D1D7C
	for <ltp@archiver.kernel.org>; Mon, 29 Jul 2024 22:51:39 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C1413D1C89
 for <ltp@lists.linux.it>; Mon, 29 Jul 2024 22:51:23 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 27B851400330
 for <ltp@lists.linux.it>; Mon, 29 Jul 2024 22:51:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6F38C1FBCD;
 Mon, 29 Jul 2024 20:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722286281;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RdLrg2TQEuMLM+GMhlPs5nhBgVy1nD8wsLzzZfIJxug=;
 b=g131/HBoRtXDFH9jPXdbFY7MOjV6IilDQ75mClm5PZYyArFmpzVRENZWWkYEoriDjgKE//
 hHkJ7ECgGP9hiSNTRLXi5y3nq9ETl8WPTgbZyJwognstjRvzYDLwbnAHDxbdDWRmUSJk2o
 zfMC6Q5XcIzW/KUtqDlGurf5QH1FzVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722286281;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RdLrg2TQEuMLM+GMhlPs5nhBgVy1nD8wsLzzZfIJxug=;
 b=bbzaY1VX9CFbVLS8C7f9L4/vgkZf+++TKGefZYjrultCBHUZwpmxUuCYWAjZV4cZuT08sS
 Fh1s4rIgQNlP4jCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722286281;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RdLrg2TQEuMLM+GMhlPs5nhBgVy1nD8wsLzzZfIJxug=;
 b=g131/HBoRtXDFH9jPXdbFY7MOjV6IilDQ75mClm5PZYyArFmpzVRENZWWkYEoriDjgKE//
 hHkJ7ECgGP9hiSNTRLXi5y3nq9ETl8WPTgbZyJwognstjRvzYDLwbnAHDxbdDWRmUSJk2o
 zfMC6Q5XcIzW/KUtqDlGurf5QH1FzVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722286281;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RdLrg2TQEuMLM+GMhlPs5nhBgVy1nD8wsLzzZfIJxug=;
 b=bbzaY1VX9CFbVLS8C7f9L4/vgkZf+++TKGefZYjrultCBHUZwpmxUuCYWAjZV4cZuT08sS
 Fh1s4rIgQNlP4jCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49F87138A7;
 Mon, 29 Jul 2024 20:51:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id D3oYEMkAqGZ6UAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 29 Jul 2024 20:51:21 +0000
Date: Mon, 29 Jul 2024 22:51:12 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240729205112.GA1287954@pevik>
References: <20240722145443.19104-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240722145443.19104-1-chrubis@suse.cz>
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] sched: starvation: Autocallibrate the timeout
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
Cc: joe.liu@mediatek.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Instead of hardcoding the values we attempt to measure the CPU speed and
> set the runtime accordingly. Given that the difference in the duration
> of the test when the kernel is buggy is about 30x we do not have to have
> a precise callibration, just very rough estimate if we are running on a
> server or small ARM board would suffice.

> So we attempt to measure how long does a bussy loop take and base the
> default timeout on that. On x86_64 CPUs the resulting runtime seems to
> be between 2x and 10x of the actual runtime which seems to be in the
> required range.

> We also make sure to check the runtime at the end of the test because
> the failures could have been masked by a timeout multiplier, i.e. if you
> set LTP_TIMEOUT_MUL=10 the test would previously pass on a buggy kernel
> as well. The side efect is that we now get better PASS/FAIL messages as
> well.

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---

> Changes in v3:

> - Increased the CALLIBRATE_LOOPS a bit, since some of the numbers
>   reported by the linaro lab had the runtime very close to the
>   calculated runtime.

Anders, Joe, can you please recheck?

> - Removed some curly braces, as suggested by pvorel

> - Added runtime check at the end of test to avoid false positives with
>   LTP_TIMEOUT_MUL.

Great!

LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Tested-by: Petr Vorel <pvorel@suse.cz>

Tested on Tumbleweed (kernel 6.10.1):

tst_tmpdir.c:316: TINFO: Using /tmp/LTP_starv8seE as tmpdir (tmpfs filesystem)
tst_test.c:1806: TINFO: LTP version: 20240524
tst_test.c:1650: TINFO: Timeout per run is 0h 00m 30s
starvation.c:71: TINFO: Setting affinity to CPU 0
tst_test.c:1658: TINFO: Updating max runtime to 0h 04m 00s
tst_test.c:1650: TINFO: Timeout per run is 0h 04m 30s
starvation.c:117: TPASS: wait_for_pid(child_pid) passed

=> test runs ~ 13s - 19s on aarch64, ppc64le and x86_64. Therefore not sure if
04m max runtime is good.

I'll have tomorrow some tests on various SLES versions.

Kind regards,
Petr

> .../kernel/sched/cfs-scheduler/starvation.c   | 41 +++++++++++++++++--
>  1 file changed, 38 insertions(+), 3 deletions(-)

> diff --git a/testcases/kernel/sched/cfs-scheduler/starvation.c b/testcases/kernel/sched/cfs-scheduler/starvation.c
> index 9ac388fdc..e707e0865 100644
> --- a/testcases/kernel/sched/cfs-scheduler/starvation.c
> +++ b/testcases/kernel/sched/cfs-scheduler/starvation.c
> @@ -21,11 +21,38 @@
>  #include <sched.h>

>  #include "tst_test.h"
> +#include "tst_safe_clocks.h"
> +#include "tst_timer.h"

>  static char *str_loop;
> -static long loop = 2000000;
> +static long loop = 1000000;
>  static char *str_timeout;
> -static int timeout = 240;
> +static int timeout;
> +
> +#define CALLIBRATE_LOOPS 120000000
> +
> +static int callibrate(void)
> +{
> +	int i;
> +	struct timespec start, stop;
> +	long long diff;
> +
> +	for (i = 0; i < CALLIBRATE_LOOPS; i++)
> +		__asm__ __volatile__ ("" : "+g" (i) : :);
> +
> +	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC_RAW, &start);
> +
> +	for (i = 0; i < CALLIBRATE_LOOPS; i++)
> +		__asm__ __volatile__ ("" : "+g" (i) : :);
> +
> +	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC_RAW, &stop);
> +
> +	diff = tst_timespec_diff_us(stop, start);
> +
> +	tst_res(TINFO, "CPU did %i loops in %llius", CALLIBRATE_LOOPS, diff);
> +
> +	return diff;
> +}

>  static int wait_for_pid(pid_t pid)
>  {
> @@ -78,6 +105,8 @@ static void setup(void)

>  	if (tst_parse_int(str_timeout, &timeout, 1, INT_MAX))
>  		tst_brk(TBROK, "Invalid number of timeout '%s'", str_timeout);
> +	else
> +		timeout = callibrate() / 1000;

>  	tst_set_max_runtime(timeout);
>  }
> @@ -114,7 +143,13 @@ static void do_test(void)
>  		sleep(1);

>  	SAFE_KILL(child_pid, SIGTERM);
> -	TST_EXP_PASS(wait_for_pid(child_pid));
> +
> +	if (!tst_remaining_runtime())
> +		tst_res(TFAIL, "Scheduller starvation reproduced.");
> +	else
> +		tst_res(TPASS, "Haven't reproduced scheduller starvation.");
> +
> +	TST_EXP_PASS_SILENT(wait_for_pid(child_pid));
>  }

>  static struct tst_test test = {

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
