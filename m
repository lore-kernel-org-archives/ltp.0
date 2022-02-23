Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FAFCC433EF
	for <ltp@archiver.kernel.org>; Wed, 23 Feb 2022 14:04:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 49C3F3C98C5
	for <ltp@archiver.kernel.org>; Wed, 23 Feb 2022 15:04:13 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC2253C020F
 for <ltp@lists.linux.it>; Wed, 23 Feb 2022 15:04:03 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7AC4C1401733
 for <ltp@lists.linux.it>; Wed, 23 Feb 2022 15:04:02 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B15AC21155;
 Wed, 23 Feb 2022 14:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645625041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9TimozeEaGn5jhNrnnXJ8pZJMpdYWf+js7suP4zFLjQ=;
 b=DzpJ+mJJNLZN/wSsCBCSE2CoMALIjKl1pnKYGSXtEpE9n1/dKVI1R1GehVYxHDll1R0PlC
 5/bwiUeZnYxGguHMW5GWyPqP1qYUUIM68Qse+AetNvwut7NfJmEQl+RA8JywlHTBRATz2N
 OwBypwHhiZD0NM7cDpgKCqb5smTsTyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645625041;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9TimozeEaGn5jhNrnnXJ8pZJMpdYWf+js7suP4zFLjQ=;
 b=Jvqt4er4T/Ed57yvio8skqbD3/xMixkI7tEv/90FeCWNOW1f+KXbG2l+CvxLa67GwfE8ot
 i7LgGxoELuXXN2Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9888613D76;
 Wed, 23 Feb 2022 14:04:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id k6zAJNE+FmJxPAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 23 Feb 2022 14:04:01 +0000
Date: Wed, 23 Feb 2022 15:06:15 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <YhY/V3diG4W0XrBC@yuki>
References: <b32ed0e56099520bc3e75455e2472841aa0b3020.1645096642.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b32ed0e56099520bc3e75455e2472841aa0b3020.1645096642.git.jstancek@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/perf_event_open03: skip test on slower
 systems
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Some systems (specially with combination of -debug kernel
> with KASAN enabled) have trouble completing this test
> in specified timeout.
> 
> Lowering number of iterations would make the test condition
> less accurate as it's based on global counter.
> 
> Instead, calculate the rate of iterations system can do in
> first 5 seconds and used that to decide whether to continue
> to run the test. If the rate is too slow, TCONF after 5
> seconds.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  .../perf_event_open/perf_event_open03.c       | 43 ++++++++++++++++++-
>  1 file changed, 41 insertions(+), 2 deletions(-)
> 
> .needs_cmds = NULL gets rid of compile warning.

Please no workarounds for compiler bugs like this one.

This has been unfortunatelly broken in gcc for at least four releases
now but I do not think that it makes sense to add random field
initializers to most of the tests in the LTP sources.

> diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c
> index dcb70962771c..c7bf123a04b4 100644
> --- a/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c
> +++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c
> @@ -16,13 +16,16 @@
>  
>  #include "config.h"
>  #include "tst_test.h"
> +#include "tst_timer_test.h"
>  #include "lapi/syscalls.h"
>  
>  #include "perf_event_open.h"
>  
>  #define INTEL_PT_PATH "/sys/bus/event_source/devices/intel_pt/type"
>  
> +const int iterations = 12000000;
>  static int fd = -1;
> +static int timeout;
>  
>  static void setup(void)
>  {
> @@ -39,6 +42,38 @@ static void setup(void)
>  
>  	SAFE_FILE_SCANF(INTEL_PT_PATH, "%d", &ev.type);
>  	fd = perf_event_open(&ev, getpid(), -1, -1, 0);
> +
> +	timeout = tst_timeout_remaining();
> +}
> +
> +/*
> + * Check how fast we can do the iterations after 5 seconds of runtime.
> + * If the rate is too small to complete for current timeout then
> + * stop the test.
> + */
> +static void check_progress(int i)
> +{
> +	static float iter_per_ms;
> +	long long elapsed_ms;
> +
> +	if (iter_per_ms)
> +		return;
> +
> +	if (i % 1000 != 0)
> +		return;
> +
> +	tst_timer_stop();
> +	elapsed_ms = tst_timer_elapsed_ms();
> +	if (elapsed_ms > 5000) {
> +		iter_per_ms = (float) i / elapsed_ms;
> +		tst_res(TINFO, "rate: %f iters/ms", iter_per_ms);
> +		tst_res(TINFO, "needed rate for current test timeout: %f iters/ms",
> +			(float) iterations / (timeout * 1000));
> +
> +		if (iter_per_ms * 1000 * (timeout - 1) < iterations)
> +			tst_brk(TCONF, "System too slow to complete"
> +				" test in specified timeout");

String shouldn't be split like that even if they are over 80 chars, at
least if I remmeber LKML coding style correctly, the reason is that
splitting them like this breaks git grep for the output messages.

> +	}
>  }
>  
>  static void run(void)
> @@ -47,10 +82,13 @@ static void run(void)
>  	int i;
>  
>  	diff = SAFE_READ_MEMINFO("MemAvailable:");
> +	tst_timer_start(CLOCK_MONOTONIC);
>  
>  	/* leak about 100MB of RAM */
> -	for (i = 0; i < 12000000; i++)
> +	for (i = 0; i < iterations; i++) {
>  		ioctl(fd, PERF_EVENT_IOC_SET_FILTER, "filter,0/0@abcd");
> +		check_progress(i);
> +	}

Generally looks good. I guess that I will have to consider turning this
into a generic functionality when I return to the runtime patchset, but
for now this should be good to go.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
