Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F5E8C3DA4A
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 16:16:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 844953D1CC3
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 18:16:23 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EFB4C3D0F94
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 18:16:07 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5CB9A100077D
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 18:16:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2C9681FCFE;
 Fri, 26 Jul 2024 16:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722010566;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ctQA8q/n+3V4QQuKNMcegIK8b1EatuBAGY5IUAUTQns=;
 b=nS+LcbHYbdc8lkTXnFVD8pO+a8y2erDhAOQskm5xp26RmGjSGOFwUxeSCzBWtPAAhZ17f0
 xVebKO7GlHa+EW7ZFs1cUnOgqfdU8Xo3VkCc04ynGbtvBmVOwoSCErGsKDMFy+hYA8CaBr
 Lbp85NCt5iZfrryw1Ca+pBjsK/5cB5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722010566;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ctQA8q/n+3V4QQuKNMcegIK8b1EatuBAGY5IUAUTQns=;
 b=xIzHsoRTAM8NRCxRv+UfUzhiQv/r0rM2tDQ+47S+PNls0BFqfdYvmicTW2LE+fKKmnQkND
 mnRYZteat4zEQWDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nS+LcbHY;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xIzHsoRT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722010566;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ctQA8q/n+3V4QQuKNMcegIK8b1EatuBAGY5IUAUTQns=;
 b=nS+LcbHYbdc8lkTXnFVD8pO+a8y2erDhAOQskm5xp26RmGjSGOFwUxeSCzBWtPAAhZ17f0
 xVebKO7GlHa+EW7ZFs1cUnOgqfdU8Xo3VkCc04ynGbtvBmVOwoSCErGsKDMFy+hYA8CaBr
 Lbp85NCt5iZfrryw1Ca+pBjsK/5cB5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722010566;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ctQA8q/n+3V4QQuKNMcegIK8b1EatuBAGY5IUAUTQns=;
 b=xIzHsoRTAM8NRCxRv+UfUzhiQv/r0rM2tDQ+47S+PNls0BFqfdYvmicTW2LE+fKKmnQkND
 mnRYZteat4zEQWDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 060BF1396E;
 Fri, 26 Jul 2024 16:16:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yzhfO8XLo2buPQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 26 Jul 2024 16:16:05 +0000
Date: Fri, 26 Jul 2024 18:16:03 +0200
From: Petr Vorel <pvorel@suse.cz>
To: =?iso-8859-2?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
 gnoack@google.com, ltp@lists.linux.it
Message-ID: <20240726161603.GA1107201@pevik>
References: <20240725-landlock-v4-0-66f5a1c0c693@suse.com>
 <20240725-landlock-v4-5-66f5a1c0c693@suse.com>
 <20240726132440.GC1066866@pevik>
 <20240726.Moowae0jipai@digikod.net>
 <20240726143246.GB1104577@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240726143246.GB1104577@pevik>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto,suse.cz:dkim];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2C9681FCFE
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 5/5] Add landlock06 test
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > On Fri, Jul 26, 2024 at 03:24:40PM +0200, Petr Vorel wrote:
> > > Hi Andrea,

> > > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > > Few notes below.

> > > ...
> > > > +static struct tst_test test = {
> > > > +	.test_all = run,
> > > > +	.setup = setup,
> > > > +	.cleanup = cleanup,
> > > > +	.min_kver = "6.10",
> > > nit: would not be able to check the availablity via landlock ABI == 5?

> > Because Landlock is available since 5.13, I guess min_kver should be set
> > to the same version.

> If anybody backport this, kernel version will not match. IMHO it's better to
> avoid specifying version if we can detect with something else (ABI version in
> this case). Also avoid kernel config reading if not needed is IMHO better.

Although functionality is not backported often to the enterprise kernels (e.g.
SLES, RHEL), certain things are backported, e.g. [1]. And that is the reason why
LTP even has a way to detect enterprise kernel [2]. Obviously the easiest thing
is to avoid kernel version if there is way to detect functionality by different
way.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/commit/c354ba291da3e255c135ef78da0c7b8c5556da07
[2] https://github.com/linux-test-project/ltp/blob/master/lib/tst_kvercmp.c#L131

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
