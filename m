Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83ADAC433EF
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 07:48:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 723813C9F18
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 08:48:57 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 645D13C5A4C
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 08:48:47 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 97B4B601E00
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 08:48:46 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BC84A21135;
 Fri, 11 Feb 2022 07:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644565725;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XIg9SVRTrqTrkybiFbG/03QBrS+TSG+/0arEQ1HrHkQ=;
 b=F02Z1UlcW4Lxl4JpiFd74pi3nBtGWUGV/+sVQ6IUcO+7bl0U3XCJtWtU4k5YZd2YpTSLbf
 mYRpNM1q07N6fooYhjG/8R2FWx6duIJMpFraujiw71XxguhyELZRpNTXblPkyrap4Hx8kQ
 KE0NfxCpGuI3sHee3YSZva65Wn4R4FQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644565725;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XIg9SVRTrqTrkybiFbG/03QBrS+TSG+/0arEQ1HrHkQ=;
 b=lGmcih5vItYN7vet4ZcFI0MwMgvQTQL3MTh/E8tnkTq8CZfs0XZGMAHRJgva3r5ZAhOV1q
 scQI8t70Mov477Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8498B139E9;
 Fri, 11 Feb 2022 07:48:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vC/xHd0UBmKZZwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 11 Feb 2022 07:48:45 +0000
Date: Fri, 11 Feb 2022 08:48:43 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <YgYU26YmOgFsr4o9@pevik>
References: <20220210162739.30159-1-pvorel@suse.cz>
 <20220210162739.30159-7-pvorel@suse.cz>
 <62060233.6010505@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <62060233.6010505@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 6/6] doc: Add missing shell variables
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

> Hi Petr

> This patchset looks good to me, so
> Acked-by: Yang Xu <xuyang2018.jy@fujitsu.com>

> ps: I think we can add two basic tests for this,
> 1)test TST_FS_TYPE whether format the specified filesystem ie using ext4
BTW the default is ext2. Also not sure how to do it when formatting loop device.
Verifying filesystem I'll add when I add TST_NEEDS_MOUNT flag.

losetup prints:
/dev/loop0: [65025]:176189 (/tmp/LTP_tst_format_device.9bya3blyQD/test_dev.img)

> 2)test tst_mkfs whether format failed if not specifying TST_NEEDS_DEVICE
> and call tst_mkfs directly
+1. I'll also document here what is the purpose (we have many tests which are
expected to TFAIL/TBROK, but it's not documented in the tests thus it's hard to
run them locally.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
