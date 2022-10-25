Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE34C38A2D
	for <ltp@archiver.kernel.org>; Tue, 25 Oct 2022 09:42:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F27753CA31C
	for <ltp@archiver.kernel.org>; Tue, 25 Oct 2022 11:42:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 535283C793C
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 11:41:53 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9C95E200960
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 11:41:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 839761F895;
 Tue, 25 Oct 2022 09:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666690911;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CQXFaiH1IY+6Q+7S37rc+bKwC2h2+c6FYhRIl+m9hcU=;
 b=e1EKOXhFwqH/z360WOKOVLw6X6wEwhOYO7M6bXRd7O1YCXwrJkeAPDDEvGU02XNkIezuHs
 Dp39hP/TGF7V5hJr+SDnrK9tDxV7d/UMvVBmaLBDDIwFit6hjWX5qJowPMFwgMv0eQhPF8
 iE1xcX2kDSdhI6IlFifxAKM86CWbzMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666690911;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CQXFaiH1IY+6Q+7S37rc+bKwC2h2+c6FYhRIl+m9hcU=;
 b=q6DCWEwObWhJ1qX2etpDsGDpP321Bt803zofFQPVT8gmLUWV+NbDKZ0AxfPwGNLmGxYBly
 5EVq9ma6SmnYhrCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4EF47134CA;
 Tue, 25 Oct 2022 09:41:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9Z52EV+vV2NRRgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 25 Oct 2022 09:41:51 +0000
Date: Tue, 25 Oct 2022 11:41:49 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Y1evXZKLHnrs74fo@pevik>
References: <CAOQ4uxianp4e7gykk_N-yPKPPsK4xYu2HnH5d=N93+gAM60c=Q@mail.gmail.com>
 <9b1164dd-68fa-0335-0b38-f820e3d303be@suse.cz>
 <CAOQ4uxizXrthqR7G8Tx7kq+bz6kPTUxTSYs1BfireEXRpiNw4w@mail.gmail.com>
 <ea4fd7d6-0985-2983-d0ce-489a32a2f6dc@suse.cz>
 <CAOQ4uxib_vxncQa3RiObKYwQg0CQvPXLH+nyRckO9FVg=ihERQ@mail.gmail.com>
 <d80e2e12-899d-f0d2-27c2-f4a92f1b2be4@suse.cz>
 <Y1a6NXkayyy7esM+@pevik>
 <CAOQ4uxjGGxaa=snebi0wPnPWuFHgQ-9Mt9hPBr3wBAghGQQEJA@mail.gmail.com>
 <Y1bFWLQNBWG9zsdZ@pevik>
 <4ab4ec76-c62f-9aaa-94a7-72e8b75d91cb@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4ab4ec76-c62f-9aaa-94a7-72e8b75d91cb@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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

> On 24. 10. 22 19:03, Petr Vorel wrote:
> > > The kernel UAPI is not very consistent about ENOTSUP vs. EINVAL
> > > renameat(2), unlink(2), link(2) and other return EINVAL for unsupported flags
> > > fallocate(2), ioctl(2) and others return ENOTSUP for unsupported commands.
> > > It's not a clear cut, but ENOTSUP is generally for unsupported fs methods,
> > > not for unsupported options.

> > thanks for info, I didn't know that. Otherwise Martin's note to use ENOTSUP
> > would help.

> I was not suggesting to change the kernel API, that's not a reasonable
> option at this point. I was just pointing out that the API design limits our
> options how to write reliable tests.

Sure, that was my suggestion. I meant it more as future improvement than to
solution to our problem, but I wasn't sure myself whether it be a good way.
It just remind me a different case, where errno was changed by accident and
kept that way (fix [1] was not accepted, instead the change was backported to
all live stable/LTS so that errno is at least consistent).

I also wonder whether real users of the API (not just test writers) would
appreciate to distinguish between these two cases. But anyway, I understand that
there would have to be a strong need for it to be reason to change, thus not
acceptable.

Kind regards,
Petr

[1] https://lore.kernel.org/netdev/20170630073448.GA9546@unicorn.suse.cz/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
