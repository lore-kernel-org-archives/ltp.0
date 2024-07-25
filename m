Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB4BC3DA70
	for <ltp@archiver.kernel.org>; Thu, 25 Jul 2024 21:44:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B4C23D1C9E
	for <ltp@archiver.kernel.org>; Thu, 25 Jul 2024 23:44:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 247713D0FB0
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 23:44:38 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 40D996020B2
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 23:44:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0CB6021224;
 Thu, 25 Jul 2024 21:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721943877;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BTdNmAGGDDiYq38mCa3SjNwf3ieh/ly8dPOx9B8hkmU=;
 b=2IiYs4ZDx1n+MgriRTALtbgyE5Do2ZOcdNH88fanI16Q0xYoswRclN6wGPGt0A6WcocD/E
 pV4g0t/+PBS8umCbgeAASx8LtXsaQ26UsrHNJtpuz13OFMH98wFdxVOPmaSDhvjqImbqVL
 whuPf5B9b/HigrHLjx645Bqg51L9th8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721943877;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BTdNmAGGDDiYq38mCa3SjNwf3ieh/ly8dPOx9B8hkmU=;
 b=RgVkrWUGuh/hRj7RUUN7S9niweFYZnHwlbSQ1FtXF/MSqN76VFpIuSPU7x/7miQUQ7UpyC
 u0yaznu6cUPsXtCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721943877;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BTdNmAGGDDiYq38mCa3SjNwf3ieh/ly8dPOx9B8hkmU=;
 b=2IiYs4ZDx1n+MgriRTALtbgyE5Do2ZOcdNH88fanI16Q0xYoswRclN6wGPGt0A6WcocD/E
 pV4g0t/+PBS8umCbgeAASx8LtXsaQ26UsrHNJtpuz13OFMH98wFdxVOPmaSDhvjqImbqVL
 whuPf5B9b/HigrHLjx645Bqg51L9th8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721943877;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BTdNmAGGDDiYq38mCa3SjNwf3ieh/ly8dPOx9B8hkmU=;
 b=RgVkrWUGuh/hRj7RUUN7S9niweFYZnHwlbSQ1FtXF/MSqN76VFpIuSPU7x/7miQUQ7UpyC
 u0yaznu6cUPsXtCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFF9D13874;
 Thu, 25 Jul 2024 21:44:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KAMBNUTHombQEgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 25 Jul 2024 21:44:36 +0000
Date: Thu, 25 Jul 2024 23:44:19 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240725214419.GA1002956@pevik>
References: <20240716153604.22984-1-chrubis@suse.cz>
 <20240716153604.22984-3-chrubis@suse.cz>
 <d5cb1dc4-7bd7-4084-952d-95511cbbb907@suse.cz>
 <20240725110206.GA982789@pevik>
 <9066c23e-444e-4975-a3c8-505fbd4b6042@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9066c23e-444e-4975-a3c8-505fbd4b6042@suse.cz>
X-Spamd-Result: default: False [-7.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 MIME_GOOD(-0.10)[text/plain]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_THREE(0.00)[3]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 2/2] testcaes/lib: Add shell loader
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

> On 25. 07. 24 13:02, Petr Vorel wrote:
> > Hi Martin, Cyril,

> > > > +mounted=$(grep $TST_MNTPOINT /proc/mounts)

> > > This check might produce false positive for example when another LTP shell
> > > script runs in parallel in another temp directory. I'd recommend using
> > > $(realpath ...) to disambiguate the mountpoints.

> > FYI this is just a test, not a library script.

> > Also maybe just prepend it with $PWD/ would be enough:

> > mounted=$(grep $PWD/$TST_MNTPOINT /proc/mounts)

> > (Not to require yet another binary. It's ok to have it here, because developers
> > have coreutils, but in case it's in the tst_test.sh or its dependencies some
> > minimal systems might have problem - busybox based embedded systems realpath is
> > configurable via CONFIG_REALPATH=y. It would help if we specify shell library
> > dependencies).

> The test could still get confused by leftover mounts from other tests or
> failed runs of itself. That'll be annoying to deal with when you try to
> modify something in the shell loader.

Fair point.

> I've checked what happens if you mount a filesystem on a mountpoint path
> that contains symlinks and in that case, /proc/mounts will report the real
> path. So $(realpath $TST_MNTPOINT) is what you need to search for. Grep
> might get confused by special characters in the path, though. Another
> problem is that /proc/mounts converts spaces to octal codes to prevent
> column parsing issues.

OK, I would hope users would not use symlinks, but OTOH I'm ok with using
realpath for tests, thus no reason to block using symlinks (which we would do
with my suggestion to use $PWD instead of realpath).

But I would not waste our time with effort to fix special characters:

1) Build system does not work with some of them anyway (Cyril reported at least
" due out-of-tree complexity of our build system).
2) Old doc somewhere warned that project would ignore broken compilation due
special characters.
3) I don't expect many people will be forced to have LTP on directory with
strange characters.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
