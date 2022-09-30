Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 207CDC433FE
	for <ltp@archiver.kernel.org>; Fri, 30 Sep 2022 09:33:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C89BE3CA74A
	for <ltp@archiver.kernel.org>; Fri, 30 Sep 2022 11:33:57 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 73DB23C0FA6
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 11:33:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D102B140134B
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 11:33:46 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0212B21901;
 Fri, 30 Sep 2022 09:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1664530426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=00n9u1VdMbtEIw+fb6lvkLEg38nHJaq/x4p++exFFb4=;
 b=wQa514GefxIcNoRi5OOglBXNaWSREACc4Am4GhznYNkTWf9l+UV6MSTES6Gyc99qmphPhI
 Y9WcoDZpzStOLhYsMgaPEHIzDUR7lfTV5KLcIt3dOOqlrfAS5ObX7FxRyOnVh6Hr+aKK80
 bPNqJ+yvLjkmfRz/1hin53Q9BGVVEbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1664530426;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=00n9u1VdMbtEIw+fb6lvkLEg38nHJaq/x4p++exFFb4=;
 b=onbJFWGVZ5p3tqWfhnGYF2oqn9MtMP2VTUu+KBbNXtJatR/HSqKuJnvunHawlNB+IhpE9Q
 V7yb+egbCxH1DsAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DECB913677;
 Fri, 30 Sep 2022 09:33:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /wESNfm3NmO0XwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 30 Sep 2022 09:33:45 +0000
Date: Fri, 30 Sep 2022 11:35:39 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Yza4a2Icm+M9cTiK@yuki>
References: <20220930091208.5688-1-pvorel@suse.cz> <Yza1B8t2LOueCVUC@yuki>
 <Yza2jwpow0uhaLHu@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yza2jwpow0uhaLHu@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] zram01.sh: Fix minimal size for XFS on
 kernel 5.19
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
> > Looks good to me. Please make sure that this gets tested fairly before
> > pushing.
> +1. I've tested it on Tumbleweed, kernel 6.0.0-rc7-1.g74aafe0-default,
> mkfs.xfs 5.19.0.
> 
> > Also Li if you can please double check since we are very late in the
> > release process.
> +1
> I can merge it tonight, or wait for Li on next week.

I'm going to tag the git in the evening/afternoon so it would be nice to
get this in ASAP.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
