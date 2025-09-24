Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D713CAC5B0
	for <ltp@archiver.kernel.org>; Wed, 24 Sep 2025 11:52:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 048453CDF71
	for <ltp@archiver.kernel.org>; Wed, 24 Sep 2025 13:51:59 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 93A333CDECB
 for <ltp@lists.linux.it>; Wed, 24 Sep 2025 13:51:41 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D85431400455
 for <ltp@lists.linux.it>; Wed, 24 Sep 2025 13:51:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E21A0340DD;
 Wed, 24 Sep 2025 11:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758714698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4sQB4P4nAf05HosHdsfaqnkdKPKue9PDmi/13n4YRLc=;
 b=cBZ0d8dIRscE6XDHSl8OBBYXBVa8OqKI8DYiqoZyaR8VAx0TbbnC0ikGPTS2b04qoQ2uDK
 2e1avix4LvaWZKpO3bft5i3tQ7kf83GoYIMJbphTpUumfCb4umJY8iPxjpB8GlF+lUllK2
 of2+dzEbsiaZ7I1G22mawlS75FkUw2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758714698;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4sQB4P4nAf05HosHdsfaqnkdKPKue9PDmi/13n4YRLc=;
 b=nN5B0WJVIHDXJ2jXOihwR3gvcmsK0ocgH6MM6OB//lA4X2eyKpdup9bkpQ+Rky2liWPxK3
 jKuoJFK0nCJbt+BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758714698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4sQB4P4nAf05HosHdsfaqnkdKPKue9PDmi/13n4YRLc=;
 b=cBZ0d8dIRscE6XDHSl8OBBYXBVa8OqKI8DYiqoZyaR8VAx0TbbnC0ikGPTS2b04qoQ2uDK
 2e1avix4LvaWZKpO3bft5i3tQ7kf83GoYIMJbphTpUumfCb4umJY8iPxjpB8GlF+lUllK2
 of2+dzEbsiaZ7I1G22mawlS75FkUw2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758714698;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4sQB4P4nAf05HosHdsfaqnkdKPKue9PDmi/13n4YRLc=;
 b=nN5B0WJVIHDXJ2jXOihwR3gvcmsK0ocgH6MM6OB//lA4X2eyKpdup9bkpQ+Rky2liWPxK3
 jKuoJFK0nCJbt+BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEAD613647;
 Wed, 24 Sep 2025 11:51:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2E5EMUrb02iqRQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 24 Sep 2025 11:51:38 +0000
Date: Wed, 24 Sep 2025 13:52:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <aNPbb6IDKO2IaMaj@yuki.lan>
References: <20250923154827.74305-1-mdoucha@suse.cz>
 <aNOyLCG_Yhv4Rk30@yuki.lan>
 <1c7404a7-87aa-4c1f-a8f5-08fab2c69fea@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1c7404a7-87aa-4c1f-a8f5-08fab2c69fea@suse.cz>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] epoll_pwait06: Skip BPF map file descriptor
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
> >> diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait06.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait06.c
> >> index 3bedc2cf5..d47327bed 100644
> >> --- a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait06.c
> >> +++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait06.c
> >> @@ -36,6 +36,7 @@ static void run(void)
> >>   		case TST_FD_DIR:
> >>   		case TST_FD_DEV_ZERO:
> >>   		case TST_FD_PROC_MAPS:
> >> +		case TST_FD_BPF_MAP:
> >>   		case TST_FD_FSOPEN:
> >>   		case TST_FD_FSPICK:
> >>   		case TST_FD_OPEN_TREE:
> > 
> > Can we make this kernel version dependent? I do not like disabling tests
> > that work on newer kernels just because it does not work on something
> > that is eight years old.
> 
> I like kernel version checks even less. I could call epoll_ctl() 
> directly without the safe macro instead and check for EPERM. That's the 
> appropriate feature check.

That does not work either. We had patches that were misapplied and broke
kernel so that it wrongly returned error instead of the expected
operation. Just checking for EPERM would silence such bugs.

In the end I came to a conclusion that the only way how to make sure
things are not broken is to expect that certain functionality is present
either on CONFIG_ options or if that is not possible on kernel version.
It's ugly but that's how things are.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
