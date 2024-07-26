Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE05C3DA4A
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 16:22:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D3333D1CCC
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 18:22:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6843A3D0F94
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 18:22:06 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B30A060255E
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 18:22:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E00291F7DD;
 Fri, 26 Jul 2024 16:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722010924;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pSvAQwd5w7s+t+b/mCpL7rjWYaiHc+ZYX4t30lhWWJw=;
 b=RAHCz/+zNp0FJXw7MrIyVNH0sb3DfVH4zlaUYLOxE4tVxT6MA9hCwUeWEz5ICVzMthRqjd
 ecnSNIpvtjg+tRvIRFMrvlphdIVx5DrWVjN3sNJhGwJwtX8HbQ//1TFmKxv/S7Cn37T3nr
 BmSRItzx3q79w0C3yUreZcd7TSD8bL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722010924;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pSvAQwd5w7s+t+b/mCpL7rjWYaiHc+ZYX4t30lhWWJw=;
 b=czjg+EM3rD+H7IQOiowC7aybWnEGyTrYNIOYyDR1a8Q6GT3ZvC4tk+70s4p73shY8XWPIe
 m1OkegVH0kTSPzBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="JkQ/CeD6";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=oGETm3YS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722010923;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pSvAQwd5w7s+t+b/mCpL7rjWYaiHc+ZYX4t30lhWWJw=;
 b=JkQ/CeD6ngDzyQnInSCHJrS1DRVhALhDK4rHVKrESYGMJQv04IFalp2pA/JTejFdsdAZMo
 ff2XyMVAsw+Ke6/JGHRRASGbElPLFLYrX2yTWkll/rmqA2PLb59hskEWTjz4K54RC3qaNx
 0N2wf5ck1VgBmeh1C+zjh9nCCuFDa7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722010923;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pSvAQwd5w7s+t+b/mCpL7rjWYaiHc+ZYX4t30lhWWJw=;
 b=oGETm3YSl3yjVDEAf2cK7VUZhwtq0GIgm+GQsTF5MgQ9dydHDVRvV5gxW+U4qW7PU3wMQj
 zlt31C8zw9Kb3VCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF537138A7;
 Fri, 26 Jul 2024 16:22:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id D1bULSvNo2ZtPwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 26 Jul 2024 16:22:03 +0000
Date: Fri, 26 Jul 2024 18:21:53 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>, mic@digikod.net,
 gnoack@google.com, ltp@lists.linux.it
Message-ID: <20240726162153.GB1107201@pevik>
References: <20240725-landlock-v4-0-66f5a1c0c693@suse.com>
 <20240725-landlock-v4-5-66f5a1c0c693@suse.com>
 <20240726132440.GC1066866@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240726132440.GC1066866@pevik>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E00291F7DD
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
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

Hi all,

...
> > +	.mntpoint = MNTPOINT,
> > +	.all_filesystems = 1,
> > +	.skip_filesystems = (const char *[]) {
> > +		"vfat",
> > +		"exfat",
> I wonder why landlock is not supported...

It was probably obvious for others:

not only ioctl(file_fd, FIONREAD, &sz), but even mkfifo(sandbox/fifo, 0640)
fails on exfat and vfat.

Kind regards,
Petr

> > +		NULL
> > +	},
> > +};

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
