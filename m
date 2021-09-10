Return-Path: <SRS0=5PST=OA=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE1FC433F5
	for <ltp@archiver.kernel.org>; Fri, 10 Sep 2021 08:34:47 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88BC3611B0
	for <ltp@archiver.kernel.org>; Fri, 10 Sep 2021 08:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 88BC3611B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 32F413C8C6C
	for <ltp@archiver.kernel.org>; Fri, 10 Sep 2021 10:34:44 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD7A43C20F4
 for <ltp@lists.linux.it>; Fri, 10 Sep 2021 10:34:34 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DAD74140142F
 for <ltp@lists.linux.it>; Fri, 10 Sep 2021 10:34:33 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E0C4B1FE4F;
 Fri, 10 Sep 2021 08:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631262872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AzZ/EWW1ALt6riq7DDaxLxEpHKNViJeyEzP00APUxAU=;
 b=V/6LoKa1L6INzsGBz3eR+Ga92LpIW5JxRaOHgOCYO3gSULgC/+E/cCdXP0uU/l4qQmCzw3
 x6NXAiwpexNOMlCMsjWvq4X+VWaulIEpq9IggAQXPZPxlwkpZjLnMhhQm8ZFlWl/1Q8jmp
 Rx/aySqJqjCZIJQVNJcVQ2MX8nuDGl0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631262872;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AzZ/EWW1ALt6riq7DDaxLxEpHKNViJeyEzP00APUxAU=;
 b=c6jWSpeeTGN9yfUFUG7c2nPEGSAO/fOGxwI11SJ+J4eiG9GzGvvn/g42+oc1jOtCSuyp20
 MyQzewKSun6TzTBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CFA1513D15;
 Fri, 10 Sep 2021 08:34:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MzkJMpgYO2FzVAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 10 Sep 2021 08:34:32 +0000
Date: Fri, 10 Sep 2021 10:34:48 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <YTsYqBJP8oWiuEGQ@yuki>
References: <20210909163326.42598-1-krzysztof.kozlowski@canonical.com>
 <20210909163326.42598-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210909163326.42598-2-krzysztof.kozlowski@canonical.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] rtc01: add workaround for broken CMOS RTC on
 Microsoft Hyper-V cloud
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
Message-ID: <20210910083448.iOh5QWBbFFXD3SctbysNjTJ2StCNtqmbsmvIgihlyQA@z>

Hi!
> rtc01 fails on missed alarm on multiple different Azure instances if the
> alarm is set for the next minute:
> 
>   rtc01 0 TINFO : RTC READ TEST:
>   rtc01 1 TPASS : RTC READ TEST Passed
>   rtc01 0 TINFO : Current RTC date/time is 11-6-2021, 09:00:58.
>   rtc01 0 TINFO : RTC ALARM TEST :
>   rtc01 0 TINFO : Alarm time set to 09:01:03.
>   rtc01 0 TINFO : Waiting 5 seconds for the alarm...
>   rtc01 2 TFAIL : rtc01.c:151: Timed out waiting for the alarm
> 
> Reproduced easily with rtcwake:
> 
>   $ rtcwake -d rtc0 -m on -s 50 -v
> 
> If alarm is set for now+60 seconds, it works fine.  Clearly Microsoft
> Hyper-V cloud instances have a broken CMOS RTC which unfortunately
> cannot be easily fixed.  Adding simple workaround to extend the time to
> 60 seconds allows to avoid false positives in expense of longer testing
> time.

I do not think that adding workarounds for a broken platforms into
testcases is a right thing to do.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
