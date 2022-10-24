Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA74FA3740
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 16:16:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 960383CA1B5
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 18:16:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCF2D3C8F82
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 18:15:53 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9C7DB6001A9
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 18:15:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B69021FD56;
 Mon, 24 Oct 2022 16:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666628151;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KJ7rwEXkIY2E/aSQgGlBGrB0j7EMZMFiAzVP1nXlbo4=;
 b=RLMCGEvpdeGNgnCAQwmPmst+e/uGo0Uz/c47qgPVW5TdhPVaqutuSgy1jGGrv227jdx0HA
 5tTAajjY0rUTizwmfp4IgvdfrVJD04RakvGMnz1mAX+r2jvYkLQiNsdC+vcfZGscDhE54z
 HbpnrUC4ZXdTzTTPi8wD3dRo0Glc/2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666628151;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KJ7rwEXkIY2E/aSQgGlBGrB0j7EMZMFiAzVP1nXlbo4=;
 b=OmVBgEHXt0xzPi1nKgSKnoVUtDI2TJ6A/RD6VvNIwIHL+9iAEKVdGUFV+cvvQKA2qg84X4
 0ozCf/egXsXGe9CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6C8AE13357;
 Mon, 24 Oct 2022 16:15:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id G1VZFze6VmOgXwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 24 Oct 2022 16:15:51 +0000
Date: Mon, 24 Oct 2022 18:15:49 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Y1a6NXkayyy7esM+@pevik>
References: <20221020130843.15147-1-mdoucha@suse.cz>
 <20221020130843.15147-3-mdoucha@suse.cz>
 <CAOQ4uxi=3aS+ROZ_kcQbVK9C4qiW76M1junEz2J+fdai5xjnAQ@mail.gmail.com>
 <b3443f46-37fc-3c15-76d6-0985e6da0535@suse.cz>
 <CAOQ4uxianp4e7gykk_N-yPKPPsK4xYu2HnH5d=N93+gAM60c=Q@mail.gmail.com>
 <9b1164dd-68fa-0335-0b38-f820e3d303be@suse.cz>
 <CAOQ4uxizXrthqR7G8Tx7kq+bz6kPTUxTSYs1BfireEXRpiNw4w@mail.gmail.com>
 <ea4fd7d6-0985-2983-d0ce-489a32a2f6dc@suse.cz>
 <CAOQ4uxib_vxncQa3RiObKYwQg0CQvPXLH+nyRckO9FVg=ihERQ@mail.gmail.com>
 <d80e2e12-899d-f0d2-27c2-f4a92f1b2be4@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d80e2e12-899d-f0d2-27c2-f4a92f1b2be4@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] Add fanotify_get_supported_init_flags()
 helper function
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
Cc: Jan Kara <jack@suse.cz>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> On 24. 10. 22 16:34, Amir Goldstein wrote:
> > This is how I would fix the problem:

> > <snip>

> > Give or take using more macros and your nicer flag prints.
> > There is no need for auto-detection of the unsupported kernel flags.

> > If the test case is expected to get to fanotify_mark() (i.e. non-zero tc->mask)
> > EINVAL from fanotify_init() always means "unsupported".

> This would be a good approach if fanotify_init() returned distinct error
> code for "flag not implemented", like ENOTSUP. But when EINVAL is returned
> for both "not implemented" and "wrong use", this has a risk of hiding real
> bugs. That's why I'm trying to detect the actual set of flags implemented in
> the running kernel before running the real tests.
Indeed, that's quite surprising (not really, it was added in 2.6.36 and remember
Jan Kara's talk about dnotify/inotify/fanotify history). I wonder if it's
possible to fix (backward compatibility would suffer).

> And since some flags may be backported to older kernels, generating feature
> sets based on kernel version is not a solution.
I guess even some not-important fix was not backported. I guess features aren't
backported to the stable kernel maybe to enterprise kernels (SLES, RHEL), but
even there I'd guess there are related patches backported, not features. But
maybe I'm wrong. Jan and Amir?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
