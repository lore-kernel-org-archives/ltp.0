Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29228C433F5
	for <ltp@archiver.kernel.org>; Fri, 29 Apr 2022 11:05:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9EBFF3CA76F
	for <ltp@archiver.kernel.org>; Fri, 29 Apr 2022 13:05:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DF3263C1348
 for <ltp@lists.linux.it>; Fri, 29 Apr 2022 13:05:42 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AE1CB1A00A36
 for <ltp@lists.linux.it>; Fri, 29 Apr 2022 13:05:41 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 981A31F37F;
 Fri, 29 Apr 2022 11:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651230340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TWV6Ho/cbwHC6d4Miw03+yEC5lhGg58DhDsOM1ROZEY=;
 b=v9JtrXX0iHUxcKsI9pTb3iVBMmz/JE1Q/7MAA3wE9t/5kGHaFlBde4Frbyk7CNG7+RnrLB
 1G5m01w0fvWQ32WB03GH+w9/EnivdM3kEXh3nZgOKRho+HHFYhWooA5ClArsOWxbnKocDG
 jcvj+QVoJ7PV1DZhy/yzPkRoB5BEI20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651230340;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TWV6Ho/cbwHC6d4Miw03+yEC5lhGg58DhDsOM1ROZEY=;
 b=ONrWCjmIwXoPaXQ8JKSQmDNSeb4l/TmGjpUGlNWMTlT27hTQb8YSGYHeRfPix/FtNtuZ4E
 3MGGJ1ptQuladeDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 76CE413446;
 Fri, 29 Apr 2022 11:05:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NdHpG4TGa2J9NAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 29 Apr 2022 11:05:40 +0000
Date: Fri, 29 Apr 2022 13:07:57 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YmvHDc8esDqfAJj/@yuki>
References: <20220428132656.11075-1-liwang@redhat.com>
 <20220428132656.11075-2-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220428132656.11075-2-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] rtc02: skip test with unsupport set RTC
 platform
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
Cc: ltp@lists.linux.it, Hiroyuki Yasuhara <hyasuhar@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Some hardware(e.g. Fujisu FX700) does not provides a feature to set the
> RTC clock, thus test failed with EINVAL from ioctl(RTC_SET_TIME).
> 
>   tst_test.c:1431: TINFO: Timeout per run is 0h 05m 00s
>   rtc02.c:66: TINFO: To set RTC date/time is: 2020-10-09 13:23:30
>   rtc02.c:70: TFAIL: ioctl() RTC_SET_TIME: EINVAL (22)
>   tst_rtctime.c:116: TWARN: open(/dev/rtc,0,7020) failed: EBUSY (16)
>   tst_wallclock.c:117: TWARN: tst_rtc_settime() realtime failed: EBADF (9)
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Hiroyuki Yasuhara <hyasuhar@redhat.com>
> ---
>  testcases/kernel/device-drivers/rtc/rtc02.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/device-drivers/rtc/rtc02.c b/testcases/kernel/device-drivers/rtc/rtc02.c
> index ef83aad89..8484a0074 100644
> --- a/testcases/kernel/device-drivers/rtc/rtc02.c
> +++ b/testcases/kernel/device-drivers/rtc/rtc02.c
> @@ -22,6 +22,7 @@
>  #include "tst_wallclock.h"
>  #include "tst_test.h"
>  
> +static int rtc_unsupport;
>  static char *rtc_dev = "/dev/rtc";
>  
>  static char *rtctime_to_str(struct rtc_time *tm)
> @@ -67,6 +68,10 @@ static void set_rtc_test(void)
>  
>  	ret = tst_rtc_settime(rtc_dev, &set_tm);
>  	if (ret != 0) {
> +		if (errno == EINVAL) {
> +			rtc_unsupport = 1;
> +			tst_brk(TCONF, "RTC may not support be set via ioctl(RTC_SET_TIME)");
> +		}

I wonder if there is a different way how to figure out setting RTC is
not supported, this may potentionaly mask away a breakage in a driver
that is supposed to be able to set time like this.

>  		tst_res(TFAIL | TERRNO, "ioctl() RTC_SET_TIME");
>  		return;
>  	}
> @@ -99,7 +104,8 @@ static void rtc_setup(void)
>  
>  static void rtc_cleanup(void)
>  {
> -	tst_rtc_clock_restore(rtc_dev);
> +	if (!rtc_unsupport)
> +		tst_rtc_clock_restore(rtc_dev);
>  }
>  
>  static struct tst_test test = {
> -- 
> 2.35.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
