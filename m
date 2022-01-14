Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B40FC433F5
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 20:03:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 916953C9551
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 21:03:43 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C76C3C9536
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 21:03:34 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C2A9F1A000BB
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 21:03:33 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E34CE219A5;
 Fri, 14 Jan 2022 20:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642190612;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HE4vcgDwGAU7uMPzUZTChm8S4SLlMFOzTks0kWTjhjw=;
 b=vIfT2F/AkjKsi+1r0aFLFPsw7RrUP6tT9ow+47mlhvSWNZiUtETaRyVv7UqGwqknPUVPWw
 VCd+pcxxnGg89kFoFqhwbFJH7nE6ENBt/3P+yial3NB4Z50lR1MHclaQdfhQ/gDL7/ge6V
 vMNHRX8AcgGHpnXB2wTVZ9AyZmMQqHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642190612;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HE4vcgDwGAU7uMPzUZTChm8S4SLlMFOzTks0kWTjhjw=;
 b=2P2Xdmg9l8QQHddumXNfC1fSYfxhkH6OUZ58jFqhIKzGjArnC8QZOMhMFf3lNazAzOxnBu
 /S+V5+UO6kviW6Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9B3EA1345F;
 Fri, 14 Jan 2022 20:03:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +m8hIBTX4WGrRwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 14 Jan 2022 20:03:32 +0000
Date: Fri, 14 Jan 2022 21:03:30 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YeHXEvfvnnc1WGfC@pevik>
References: <20220112161942.4065665-1-nikita.yushchenko@virtuozzo.com>
 <9813e92e-da52-dcfc-3eca-930854fb754e@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9813e92e-da52-dcfc-3eca-930854fb754e@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] nfs_flock: fail the test if lock/unlock ops fail
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
Cc: ltp@lists.linux.it, Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin, Nikita,

> The test program is quite short and simple. Why not rewrite it using the
> current LTP API and make it even better? Some useful links to help with
> that:

+1

It might not make it into this release due git freeze [1],
but definitely worth of doing it.
Thus I'd accept this patch for upcoming release.

Kind regards,
Petr

> https://github.com/linux-test-project/ltp/wiki/C-Test-Case-Tutorial
> https://github.com/linux-test-project/ltp/wiki/C-Test-API
> https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines

[1] https://lore.kernel.org/ltp/YeFGwLzrR3t%2FVQLq@yuki/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
