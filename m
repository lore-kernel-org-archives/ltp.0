Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE81C79F9B
	for <ltp@archiver.kernel.org>; Mon,  5 Jan 2026 14:12:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C4823C2659
	for <ltp@archiver.kernel.org>; Mon,  5 Jan 2026 15:12:03 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5CE0F3C25E9
 for <ltp@lists.linux.it>; Mon,  5 Jan 2026 15:11:43 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C90EA600660
 for <ltp@lists.linux.it>; Mon,  5 Jan 2026 15:11:42 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 290E75BE42;
 Mon,  5 Jan 2026 14:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767622302;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0/1A5lrUc/DTYrIYdftsIVLBMTes99Yp/UMtSOyfG9o=;
 b=Ibnlj1nbsaaU9q9D0n74FV360bQTuR9klmgz9Dqc6Xumpa0cbVMkeN+x422zBKJgvxyei5
 rzjVsf0FN+o/9FujYDqZPG541quYXJHzsttoUBXcav6VpQKYrJMz2i/JqX5CKlrwrbRzb1
 j375+QIflZQz/p8GhZb99adx5HlcCLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767622302;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0/1A5lrUc/DTYrIYdftsIVLBMTes99Yp/UMtSOyfG9o=;
 b=ZpcgnvCOU5LFBSUv0VuWd128GxFzc1TwhyY49Ai47pD4dEmv6EcVq0p0AP7AnTLuG+7OLB
 MAtgPadH/TDHAdDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767622302;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0/1A5lrUc/DTYrIYdftsIVLBMTes99Yp/UMtSOyfG9o=;
 b=Ibnlj1nbsaaU9q9D0n74FV360bQTuR9klmgz9Dqc6Xumpa0cbVMkeN+x422zBKJgvxyei5
 rzjVsf0FN+o/9FujYDqZPG541quYXJHzsttoUBXcav6VpQKYrJMz2i/JqX5CKlrwrbRzb1
 j375+QIflZQz/p8GhZb99adx5HlcCLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767622302;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0/1A5lrUc/DTYrIYdftsIVLBMTes99Yp/UMtSOyfG9o=;
 b=ZpcgnvCOU5LFBSUv0VuWd128GxFzc1TwhyY49Ai47pD4dEmv6EcVq0p0AP7AnTLuG+7OLB
 MAtgPadH/TDHAdDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C7D113EA63;
 Mon,  5 Jan 2026 14:11:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XKOeLp3GW2koAwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 05 Jan 2026 14:11:41 +0000
Date: Mon, 5 Jan 2026 15:11:36 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Terry Tritton <terry.tritton@linaro.org>
Message-ID: <20260105141136.GE654507@pevik>
References: <20251209211629.95436-1-terry.tritton@linaro.org>
 <20251215155330.GC272695@pevik>
 <DEYWYH3VLMDA.R2SSTA8T80LU@suse.com>
 <20251215161353.GA282302@pevik>
 <DEYXGZU8IXPQ.2N0IS65HUZ0LI@suse.com>
 <20251215165247.GC282302@pevik>
 <DF171554SNRA.2CKR0Q3FLG2TU@suse.com>
 <CABeuJB2TJ4bQDX709-sLO0tb0acYH770kS6X5zXMh0V0M3Yt-w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CABeuJB2TJ4bQDX709-sLO0tb0acYH770kS6X5zXMh0V0M3Yt-w@mail.gmail.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ioctl_pidfd02-06: Add CONFIG_USER_NS and
 CONFIG_PID_NS to needs_kconfigs
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

> Hi,

> > On Mon Dec 15, 2025 at 5:52 PM CET, Petr Vorel wrote:
> > > > > And https://www.man7.org/linux/man-pages/man7/user_namespaces.7.html.

> > > > > Yeah, I understand that. The dependency of CLONE_NEWUSER/CLONE_NEWPID is also
> > > > > visible in kernel sources (e.g. fs/nsfs.c). But my question was different:
> > > > > Do we now prefer everything kind of document with .needs_kconfigs, even it's
> > > > > possible to detect it otherwise? (speed of parsing kconfig, kind of hard request
> > > > > for kconfig being available even we can figure the support otherwise).

> > > > I believe we shouldn't see this as black/white but use this feature when
> > > > it's really needed. This is the case.

> > > Sure, .needs_kconfigs is used when test request some functionality based on
> > > kconfig.  But many tests use /proc or /sys based detection (e.g. ioctl_ns06.c)
> > > or based on certain errno, see include/lapi/syscalls.h or
> > > testcases/kernel/syscalls/fanotify/fanotify.h) because these were
> > > added before LTP supported kconfig. Later, when kconfig was added it was
> > > considering as a last resort (when there was no way to detect dependency
> > > otherwise).

> > > Have we decide to move everything into kconfig?

> > > I'm not sure myself.  needs_kconfigs is simpler and obvious, but it requires
> > > kernel config.  I suppose the speed of parsing config is not an issue.

> > > It'd be nice to mention the resolution (preferred vs. only if no other way to
> > > detect the support) into
> > > https://linux-test-project.readthedocs.io/en/latest/developers/writing_tests.html

> > Feel free to add this comment, but for me it's obvious that if a
> > feature can't be present in the kernel due to kconfigs we should check
> > kconfig :-)

> I've just taken another look at this and it appears the test would still
> fail if the config is not present or if KCONFIG_SKIP_CHECK is set, in
> which case perhaps the run time detection may be preferred as it will
> still work in these cases?

Maybe I'm missing something obvious. IMHO kconfig check for CONFIG_USER_NS and
CONFIG_PID_NS is equal to checking for /proc/self/ns/user and /proc/self/ns/pid.

"runtime detection" you mean looking at /proc, but actually both ways are
"runtime detections" because LTP expects correct kernel config for running
kernel or looks into /proc/config.gz.

Just looking at /proc is faster and works without KCONFIG_SKIP_CHECK. OTOH
kconfig is somehow documenting it. It could be documented in normal test doc if
we inspect /proc.

@Li @Cyril, I'm sorry to raise this again (I haven't found a thread in which we
discussed it last time). Which one do we prefer in case both can be used?

> I'm not sure how common either of those cases are though?

> Would it be better to have the run time detection in tst_kconfig_check
> as a fall back in case the config is not present?
> Then the tests can just define the needs_kconfigs and not have to worry
> about other checks.

Using both looks to me overkill.

Kind regards,
Petr

> > > or into upcommig doc/developers/ground_rules.rst
> > > https://patchwork.ozlabs.org/project/ltp/patch/20251215124404.16395-2-chrubis@suse.cz/

> > > Kind regards,
> > > Petr

> > > > > And if we decide for forcing kconfig, we should update ioctl_ns06.c, which does
> > > > > /proc based detection (i.e. to use the same approach).

> > > > I didn't check this, but I'm pretty sure we should go all around and
> > > > verify many other tests with the same issue. We should do it in this
> > > > patch-set or on a searate one.


> > > > > Kind regards,
> > > > > Petr

> > So what we do with the patch? Should we merge it?

> I'm happy to go through and update other tests in this patch or another.

> Thanks
> Terry

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
