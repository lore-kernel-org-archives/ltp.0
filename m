Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6B6C77B78
	for <ltp@archiver.kernel.org>; Wed,  3 May 2023 09:37:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80BFB3CB9C3
	for <ltp@archiver.kernel.org>; Wed,  3 May 2023 11:37:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF1C63CB794
 for <ltp@lists.linux.it>; Wed,  3 May 2023 11:37:05 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8CD44200983
 for <ltp@lists.linux.it>; Wed,  3 May 2023 11:37:05 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D0AE822549;
 Wed,  3 May 2023 09:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683106624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BwcWNGdf70JsmkMNMAv6QYUaebVLG0I1Y091U6Qe018=;
 b=MN0tfLZtnfkrInngUa3Ehb8r5hD4XET6YtvVO34zByL0MRXLVvQmzNarEw17MpggwBDuJ0
 Ew4TrXLdRg39lT996gmK/aeK6MppyMpXA8EJNNXeyPTdzPRdmcK4lvlwQEWZfjQpuOs/3Z
 rmAZL11NtwRiGBllVEy3WsDe7any7cQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683106624;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BwcWNGdf70JsmkMNMAv6QYUaebVLG0I1Y091U6Qe018=;
 b=8hnXdH3Sn2zJjLi1TPL9699XhPkxYrvLA/UX83516DY0+p3505Cb2X2urW0SJkXVgbhk7s
 5v80ZVcR4sBi3aCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C00A11331F;
 Wed,  3 May 2023 09:37:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2hXALUArUmRpGQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 03 May 2023 09:37:04 +0000
Date: Wed, 3 May 2023 11:35:12 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZFIq0CnSCS0jp8dE@rei>
References: <ZEjsKC6ESB1+mM0H@rei> <20230502143711.GA3665733@pevik>
 <20230502151457.GA3677937@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230502151457.GA3677937@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preparations
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
> * nfs08.sh: Skip on vfat
> https://patchwork.ozlabs.org/project/ltp/patch/20230502151348.3677809-1-pvorel@suse.cz/

This is workaround for bugs found by the "run nfs on all fs" patch,
right?

I suppose that it may be better not to enable nfs on all filesystems for
this release so that we have time to figure out what is wrong before
next release.

I really do not like applying "temporary" workarounds for real bugs in
the LTP codebase. There is always danger of "temporary" being forgotten
and we end up masking the real bug for eternity.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
