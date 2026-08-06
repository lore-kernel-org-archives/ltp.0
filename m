Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39702C56208
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 10:32:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 73C9A3E49DC
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 12:32:16 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 185433E2659
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 12:31:58 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4F8561A00657
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 12:31:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 76B7F3DF3;
 Thu,  6 Aug 2026 10:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786012312;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=McY2WTqKOZQmPJuJOYtVZi54cE9w1a9GsEuIg8Rau4s=;
 b=sZWv7/qnFw4lEgkYmFHOFGCft8mALRVaIm5gCutgX7TcNAjhDD92fZLfeI0YQsJbQ7wneu
 JE0WWKpt4RRWmj7nxk8fdefThR/yT8zQedZtZIXVQtpyqdygb/QpMfdrugAldojeEI9k5Z
 /PRpxTnuCna9KzPbTtrUIVsBfkuvV8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786012312;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=McY2WTqKOZQmPJuJOYtVZi54cE9w1a9GsEuIg8Rau4s=;
 b=PjOocSFfDVGSEUWTYPSZcqW6c30i2In4t01K4gitTy+azwujmpqUYUstQkvyUxEcaa74tr
 XwaCnrefoEXSvPBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786012308;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=McY2WTqKOZQmPJuJOYtVZi54cE9w1a9GsEuIg8Rau4s=;
 b=H1B1oo61IjGCpb8IBiS3tf9nLEbZATRpt5RhcrelaU3Qrsx+KmaZDF6pHLxpc9/HU68Dkh
 ysFP2O9VPfTsI/gjFxhTDsTR87DR1HoyBh0jLHUj0NK1qsgShh6n0xfcZzn3UCSVAkxBdY
 i8ueyRhgo8ujzXiIoeU/NiqN9XMXMEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786012308;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=McY2WTqKOZQmPJuJOYtVZi54cE9w1a9GsEuIg8Rau4s=;
 b=SLRHZASaCeUnQBtc3DaxIlJKvCrJo9RAnhKkmzcrDq7nxJj06LnTfEXyEx6BGA/gB98sYz
 zdXtWbOeAYiCk9AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E095779B6;
 Thu,  6 Aug 2026 10:31:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7cMNEpRidGr5aQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 06 Aug 2026 10:31:48 +0000
Date: Thu, 6 Aug 2026 12:31:46 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20260806103146.GA838915@pevik>
References: <20260602010137.27226-1-wegao@suse.com>
 <20260729053803.9823-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260729053803.9823-1-wegao@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] min_free_kbytes: Handle transient memory drops
 in check_monitor
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

Hi Wei,

> High memory pressure can cause MemFree to temporarily drop below the
> min_free_kbytes threshold before the kernel reclaimer can catch up.
> This results in intermittent test failures, observed on openQA aarch64
> virtual machines.

> Implement a 2-second grace period with high-accuracy 10ms fixed polling
> in check_monitor() to allow the kernel time to reclaim memory.

> Introduce a 10% tolerance (90% threshold) for the MemFree check.
> Measurements under extreme pressure show MemFree can dip as low as
> ~50% to ~70% of the target. While it typically recovers above 90%
> within one second, hitting the exact 100% watermark sometimes can take
> significantly longer. This tolerance prevents false positives during the
> slow recovery tail while still ensuring memory is maintained near the
> required level.

> Also, increase the monitor's idle polling frequency from 2s to 100ms
> to improve responsiveness during the test run.

+1

> Enhanced diagnostics are added to report the minimum memory level seen
> during the pressure period to aid in future calibration.

> +++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
...
>  	while (!end) {
>  		memfree = SAFE_READ_MEMINFO("MemFree:");
>  		tune = TST_SYS_CONF_LONG_GET(PATH_VM_MIN_FREE_KBYTES);
> +		/*
> +		 * Allow 10% tolerance to account for transient states.
> +		 */
> +		threshold = tune * 9 / 10;

>  		if (memfree < tune) {
> -			tst_res(TINFO, "MemFree is %lu kB, "
> -				"min_free_kbytes is %lu kB", memfree, tune);
> -			tst_res(TFAIL, "MemFree < min_free_kbytes");
> -			violated = 1;
> +			min_memfree = memfree;
> +			/*
> +			 * Give it some time to reclaim. The kernel should keep
> +			 * MemFree above min_free_kbytes, but transient drops
> +			 * are possible under high pressure.
> +			 * Check every 10ms for up to 2 seconds for high accuracy.
> +			 */
> +			for (i = 10; i <= 2000; i += 10) {
> +				usleep(10000);
You used i for usleep() in v1 and v2 [1]. Since v3 [2] you keep using
usleep(10000), therefore we could have just simple loop (readability):

			for (i = 0; i < 200; i++) {

Otherwise LGTM, thanks! (I don't agree with AI that 90% threshold is
hiding bugs). Please repost, so that we have patch in the new patchwork instance
in patchwork.kernel.org (+ please create an user on that instance if you haven't
already done), because old patchwork don't receive emails any more.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20260527050843.14963-1-wegao@suse.com/
[2] https://lore.kernel.org/ltp/20260531134250.25279-1-wegao@suse.com/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
