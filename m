Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A844C44511
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 15:23:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC4363E58FB
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 17:23:22 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 988F53E2580
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 17:23:05 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E0DC5600A43
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 17:23:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 77A2F789EA;
 Thu, 16 Jul 2026 15:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784215383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hHU1iulSln1iq96yvUdofLtWp7QC6Z0qT6IXIk4AYLM=;
 b=2ZT3Yjkp/diR7txlce/0UaUHm3vMXuUjTsquLleXuMDtlrggJfgxqpEDI+z0AvhGpEGIhr
 w7jRYq8ePHDGTTPNUvPOQPhoGiudiKRsYb8HgqNM7CIrDnTm+DzC6PacQH83zUEPXMUQKR
 SJB8MACMut9LQEGxf0Um4TOuu5AaZDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784215383;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hHU1iulSln1iq96yvUdofLtWp7QC6Z0qT6IXIk4AYLM=;
 b=mWiC5nwJJTR8B3MhcKYV+HbTFV50YTp3SEW5AdYCb4QWOO0iByuNhg1OWDVqjMi7z8S79p
 ZxS0eAa+80b8z4Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784215383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hHU1iulSln1iq96yvUdofLtWp7QC6Z0qT6IXIk4AYLM=;
 b=2ZT3Yjkp/diR7txlce/0UaUHm3vMXuUjTsquLleXuMDtlrggJfgxqpEDI+z0AvhGpEGIhr
 w7jRYq8ePHDGTTPNUvPOQPhoGiudiKRsYb8HgqNM7CIrDnTm+DzC6PacQH83zUEPXMUQKR
 SJB8MACMut9LQEGxf0Um4TOuu5AaZDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784215383;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hHU1iulSln1iq96yvUdofLtWp7QC6Z0qT6IXIk4AYLM=;
 b=mWiC5nwJJTR8B3MhcKYV+HbTFV50YTp3SEW5AdYCb4QWOO0iByuNhg1OWDVqjMi7z8S79p
 ZxS0eAa+80b8z4Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65168779AD;
 Thu, 16 Jul 2026 15:23:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9Gp7F1f3WGoqeQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 16 Jul 2026 15:23:03 +0000
Date: Thu, 16 Jul 2026 17:22:55 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Kuba Pawlak <kuba.pawlak@canonical.com>
Message-ID: <alj3Tw_a1If59w3k@yuki.lan>
References: <20260716132459.1042752-1-kuba.pawlak@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260716132459.1042752-1-kuba.pawlak@canonical.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.it:url, imap1.dmz-prg2.suse.org:helo,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] rtc02: skip (TCONF) on read-only RTCs that reject
 RTC_SET_TIME
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
> Some RTC hardware does not allow setting the time from the host. For
> example Qualcomm PMIC RTCs (rtc-pm8xxx) that are configured without the
> allow-set-time DT property and without an nvmem/UEFI offset return
> -ENODEV from RTC_SET_TIME; the counter free-runs from the epoch and is
> only usable as an uptime source. On such devices rtc02 currently reports
> TFAIL, which is a hardware limitation rather than a kernel defect.
> 
> Probe whether the RTC can be set in the setup phase, writing back the
> value just read so a writable RTC is left unchanged. When RTC_SET_TIME
> fails with an errno that indicates the operation is unsupported or not
> permitted (ENODEV, EOPNOTSUPP, EINVAL, EACCES, EPERM), skip the whole
> test with TCONF.

This is rather broad range, are all of these really possible. Especially
the EINVAL in the set is rather troubling, since EINVAL is the most
common error returned by the Linux kernel.

> Doing the check in setup, before tst_rtc_clock_save(), also avoids the
> cleanup path (tst_rtc_clock_restore()) issuing RTC_SET_TIME and turning
> the run into a TBROK on such devices. If the probe succeeds the test body
> runs as before, so no additional handling is needed there.
> 
> Signed-off-by: Kuba Pawlak <kuba.pawlak@canonical.com>
> ---
>  testcases/kernel/device-drivers/rtc/rtc02.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/testcases/kernel/device-drivers/rtc/rtc02.c b/testcases/kernel/device-drivers/rtc/rtc02.c
> index 34509ab..9103d60 100644
> --- a/testcases/kernel/device-drivers/rtc/rtc02.c
> +++ b/testcases/kernel/device-drivers/rtc/rtc02.c
> @@ -16,6 +16,7 @@
>   */
>  
>  #include <stdio.h>
> +#include <errno.h>
>  #include "tst_rtctime.h"
>  #include "tst_wallclock.h"
>  #include "tst_test.h"
> @@ -133,10 +134,29 @@ static void set_rtc_test(void)
>  static void rtc_setup(void)
>  {
>  	int exists = access(rtc_dev, F_OK);
> +	struct rtc_time probe_tm;
>  
>  	if (exists < 0)
>  		tst_brk(TCONF, "RTC device %s not available", rtc_dev);
>  
> +	/*
> +	 * Skip on RTCs that do not allow setting the time, e.g. Qualcomm PMIC
> +	 * RTCs without allow-set-time or an nvmem offset, where RTC_SET_TIME
> +	 * returns -ENODEV. Probe with the current time so a writable RTC is
> +	 * left unchanged, and skip here (before tst_rtc_clock_save()) so the
> +	 * cleanup restore does not fail on such devices.
> +	 */

We usually keep this verbose information in the git commit rather than
in comments in the code, since the commit message is descriptive enough
I wouldn't add this comment at all.

> +	if (tst_rtc_gettime(rtc_dev, &probe_tm))
> +		tst_brk(TBROK | TERRNO, "ioctl() RTC_RD_TIME");
> +	if (tst_rtc_settime(rtc_dev, &probe_tm)) {
> +		if (errno == ENODEV || errno == EOPNOTSUPP ||
> +		    errno == EINVAL || errno == EACCES || errno == EPERM)
> +			tst_brk(TCONF | TERRNO,
> +				"RTC does not support setting the time");
> +
> +	    tst_brk(TBROK | TERRNO, "ioctl() RTC_SET_TIME");
> +	}
> +
>  	tst_rtc_clock_save(rtc_dev);
>  }
>  
> -- 
> 2.43.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
