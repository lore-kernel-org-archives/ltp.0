Return-Path: <SRS0=5PST=OA=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1D1C433EF
	for <ltp@archiver.kernel.org>; Fri, 10 Sep 2021 09:14:13 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADE6060E0B
	for <ltp@archiver.kernel.org>; Fri, 10 Sep 2021 09:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ADE6060E0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 77C143C8C6C
	for <ltp@archiver.kernel.org>; Fri, 10 Sep 2021 11:14:10 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 90E353C2170
 for <ltp@lists.linux.it>; Fri, 10 Sep 2021 11:14:01 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 092DC1001455
 for <ltp@lists.linux.it>; Fri, 10 Sep 2021 11:14:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5334522422;
 Fri, 10 Sep 2021 09:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631265240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b4hRBYdoFlNeWTBh4cXIR4k/R+KG8RTf7c5rtH5isHs=;
 b=D4unUEi8MchTUHIFDPKoN9PTH5UFtCL8psEf037ZqOJpaERhzUV65wunYLtsnAumBRuuLE
 QH814Z9C8mVIAKriENFcQhKDxWB95Cc/hpL/bFfjmMidDXXLoe6gkIemSYJNj97z9aGPDV
 3Tzwo+uPuComzn8w7x2NKHJcoQ83y0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631265240;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b4hRBYdoFlNeWTBh4cXIR4k/R+KG8RTf7c5rtH5isHs=;
 b=J5ommQzYWT7yM64g44tVmMGXVGMhjiKnRfpflua6LrumiorA71lctaWUT/iJDKxaVBsyBP
 P69jGOcmddhT2XBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 409FD13D26;
 Fri, 10 Sep 2021 09:14:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id duCiD9ghO2GGawAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 10 Sep 2021 09:14:00 +0000
Date: Fri, 10 Sep 2021 11:14:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <YTsh5wcAbNDjJQpi@yuki>
References: <20210909163326.42598-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210909163326.42598-1-krzysztof.kozlowski@canonical.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] rtc01: add space to beginning of comments
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
Message-ID: <20210910091415._zt2iA5ymDgzxBCmnmWkkUjtalqNiSbp_AOu2IeJS1g@z>

Hi!
> Improve readability of comments - no functional change.

Actually some of the comments are really commenting the obvious so it
would be better just to remove most.

For instance this:

	/* Read and alarm tests */
	read_alarm_test();

How does the comment here add any value?

And I would say that it's mostly the same for the ioclt() calls as well,
the constants do have reasonable names so I guess that in cases like
this:

	/* Read current alarm time */
	ret = ioctl(rtc_fd, RTC_ALM_READ, &rtc_tm);

it's kind of obvious that we do read the alarm even without the comment.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
