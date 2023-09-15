Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77532EE6457
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 11:12:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A63A63CE680
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 13:12:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CBB843CB576
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 13:11:51 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AB6CA1BB9FD2
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 13:11:49 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6BCA31F38C;
 Fri, 15 Sep 2023 11:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694776309;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZDLthXSbiQ+qWb+i3+aPXmaNMccyTECdn3Qd6M2vPBg=;
 b=flHntAgiQ4ONEVYcdwzAmN/SPLjPoDVtU5DrnrRmion+1r/VTWaG6OtJXF32tkMO6jPewv
 KnPSYhKbyUvNYndqhb/oetApPqfx0IIUmBQCfFy6ePYzplBLWUbFb6PXNhZrioyd6hBc3z
 iXKthhRbH8Niz/GvfJSwoMl6QcOsIyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694776309;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZDLthXSbiQ+qWb+i3+aPXmaNMccyTECdn3Qd6M2vPBg=;
 b=8rDGr0C8ifm/7ZPW/q2y0gkUJOa9xBktVJHQLOgmSz1a21Z6Kv3OWtN1Lo4aSeOQRfxQII
 jgSZYR63QCEZj8Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 255991358A;
 Fri, 15 Sep 2023 11:11:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id FinfB/U7BGV8GQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 15 Sep 2023 11:11:49 +0000
Date: Fri, 15 Sep 2023 13:11:47 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230915111147.GA46324@pevik>
References: <20230728132120.17322-1-pvorel@suse.cz>
 <ZQQ2y1AXL1yMV9EA@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZQQ2y1AXL1yMV9EA@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/4] shell: Add TST_SKIP_IN_{LOCKDOWN,
 SECUREBOOT}=1
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it,
 Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> Looks good.

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Thank you for your review. Unless anybody complains, I'll merge this tonight.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
