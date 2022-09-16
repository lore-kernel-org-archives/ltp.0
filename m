Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9759FECAAD8
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 21:33:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 331983CACB2
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 23:33:43 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EFD013CAC6F
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 23:33:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5E6941000F69
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 23:33:32 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A840B33FA2;
 Fri, 16 Sep 2022 21:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663364010;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iVZie1eJt2+3DIG/BUAxu6506JK3DkIA4+0/+keFZV0=;
 b=VoWHrjoVrOLdi6huhHi4Jq54ewvNZ0F859jP12F9l5rCkACyn5Yl5wDC1STZ0aGPnHBRLh
 7HabszTpQLKEc95JOWN4Ejd1vW9aNFCJO6qQsWlyBTLI+B/EebnYC5yxE/yWOEwvCqPo0J
 8P0IFR/kNbJZqSAvUL8z6D9wOoWvYT4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663364010;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iVZie1eJt2+3DIG/BUAxu6506JK3DkIA4+0/+keFZV0=;
 b=gxrlKyajwOEdbIQVB5pZTO+fOdlrzHa7UUxJIrrYxITzic4lepZ6YdIfROUuQfG0LXGGhU
 KCNfzY353d6w4pBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5291A1332E;
 Fri, 16 Sep 2022 21:33:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cYSCEarrJGOVZQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 16 Sep 2022 21:33:30 +0000
Date: Fri, 16 Sep 2022 23:33:28 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <YyTrqPxEABXGtAYF@pevik>
References: <20220818100945.7935-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220818100945.7935-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/2] Fix mkfs.xfs 300MB min size requirement
 (v5.19.0)
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
Cc: automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Changes v1->v2:
> * bump min size to 300 MB instead using workaround (export TEST_DIR=1
>   TEST_DEV=1 QA_CHECK_FS=1)
> * increase test for .dev_min_size (so that we don't test for the default
>   value)

Do we want to merge this patchset to get XFS fix before the release?
I'll finish tracking minimal filesystem size after the release.

Kind regards,
Petr

> Kind regards,
> Petr

> Petr Vorel (2):
>   tst_device: Increase DEV_MIN_SIZE to 300 MB
>   lib/tests: Increase .dev_min_size

>  lib/newlib_tests/tst_device.c | 2 +-
>  lib/tst_device.c              | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
