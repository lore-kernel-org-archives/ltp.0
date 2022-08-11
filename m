Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E5CC25B07
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 14:25:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 291123C9575
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 16:25:05 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D1DA03C8889
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 16:24:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CB4C51A00CD4
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 16:24:53 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CC15B5CDA1;
 Thu, 11 Aug 2022 14:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660227892;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/ktzHj521kUW0CwBDqdKBupv8fQyie1Sd0bK4UUcVD4=;
 b=nvnlMhtbj2FmEFWJQdKBzV7VYvFK3wCa6670ckB1f5dYhlNRGV25Bx8LOkpaAE7StIx704
 7F9wC4Gnrouel1kRWFDUIRTlJt8JIEnW6tCm0mlW6b/C9WbvAurokUu1nmWDj61tmYuR7d
 Rgw1GDS2gJotr76pP6vCpF7v+65MV7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660227892;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/ktzHj521kUW0CwBDqdKBupv8fQyie1Sd0bK4UUcVD4=;
 b=y1OTGm7wLUK+VfJEV74a+pu1hcpUeguB97wjEGmGAH8qeIRDeJrjYRupHPlaJrXnU+U0wn
 LPU6rCVA0+y9A+Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 940141342A;
 Thu, 11 Aug 2022 14:24:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EcpFITQR9WL+AQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 11 Aug 2022 14:24:52 +0000
Date: Thu, 11 Aug 2022 16:24:51 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <YvURMyyNWoBohA5h@pevik>
References: <20220811131358.18906-1-akumar@suse.de>
 <20220811131358.18906-5-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220811131358.18906-5-akumar@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/5] alarm07: cleanup and simplify
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

Hi Avinesh,

thanks, patchset merged!

> +++ b/testcases/kernel/syscalls/alarm/alarm07.c
> @@ -2,45 +2,38 @@
>  /*
>   * Copyright (c) International Business Machines  Corp., 2001
>   * Author: Wayne Boyer
> + * Copyright (c) Linux Test Project, 2009-2022
FYI this was 2002 (fixed).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
