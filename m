Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F13D0C433FE
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 11:53:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DFDB83CAEF6
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 13:53:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C47733CAE31
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 13:52:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2D293200C74
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 13:52:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2CA8521CE6;
 Thu, 13 Oct 2022 11:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665661971;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=StZeaC+TY8kQRFEi4ETTXnWuyAYL/py+GS4t4hZA8CU=;
 b=t9SK0UmMXvV+5B1fatFHLAfWA/GIMUvOglcyNXCzNUoMrYdc3a9DJ7zHCxM+CCUdpV6h/W
 3L1Sk4a32xb1peX6vyN4ip1DlnTZBDctOiemEBIph1raicqAULVUFotqU4mN7eww1TbQka
 ZpQrQVRjlr9Y+W0zQ6e658lzmoyDFV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665661971;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=StZeaC+TY8kQRFEi4ETTXnWuyAYL/py+GS4t4hZA8CU=;
 b=5LpnDAajDU7PVSMSsfynVKJpRFJdC0M3TtWPKQe55iP/8ljPumhk80MrairuDChtTvzWUW
 P+BcKPxrZLiWPWBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0111113AAA;
 Thu, 13 Oct 2022 11:52:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TXDXORL8R2OubwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 13 Oct 2022 11:52:50 +0000
Date: Thu, 13 Oct 2022 13:52:49 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Y0f8EdFXNBO+O6Zt@pevik>
References: <20220617085914.22034-1-andrea.cervesato@suse.com>
 <Yz/ukhT0a+CDb/UB@pevik>
 <79bf7590-6459-3653-54d1-60125e6b6b30@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <79bf7590-6459-3653-54d1-60125e6b6b30@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7] Rewrite aio-stress test using LTP API
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

Hi Andrea,

> > > +++ b/runtest/ltp-aio-stress.part2
> > Both applies to this runtest level as well.
> Apparently we don't need part2 anymore, because we replaced $TMPDIR with
> .needs_tmpdir functionality and now some tests are duplicated. I add the
> remaining part2 tests which are not yet in part1 and rename the file from
> ltp-aio-stress.part1 in ltp-aio-stress.

Good catch, thanks!

Kind regards,
Petr


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
