Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CEF2C25B75
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 13:09:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF77E3CF864
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 15:09:37 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F7803C86A8
 for <ltp@lists.linux.it>; Wed, 15 May 2024 15:09:21 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9DCD460B2E2
 for <ltp@lists.linux.it>; Wed, 15 May 2024 15:09:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0A7D4206B7;
 Wed, 15 May 2024 13:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715778559;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l3aBRZQfdXwiU8hO2RTDOgNBd2ryYP6ajTwAdAr9GnU=;
 b=BWASpWrhjpPtiN6u673ayaE7c+qaxHObKBr/gsf4R9UOGGUJOsVhJn1eHA56yrLsILGDYW
 r1rFjyzc+XS76EL243J12ldkLk1NUHNiiLnuydarPkQLcwurxEDz2Og+qgVibXoPtiqHdX
 S4D+9eU+ilOKpU6TgpS3WJx6d2HzTpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715778559;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l3aBRZQfdXwiU8hO2RTDOgNBd2ryYP6ajTwAdAr9GnU=;
 b=nrJVAC40e5GgTwET7ihUc0CrDaRPBGD0InyBXGJQYDGgCzMSzJ7cv+gTi40EW06WZxggcm
 aSZg8iK3qqNVr0Cg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BWASpWrh;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nrJVAC40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715778559;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l3aBRZQfdXwiU8hO2RTDOgNBd2ryYP6ajTwAdAr9GnU=;
 b=BWASpWrhjpPtiN6u673ayaE7c+qaxHObKBr/gsf4R9UOGGUJOsVhJn1eHA56yrLsILGDYW
 r1rFjyzc+XS76EL243J12ldkLk1NUHNiiLnuydarPkQLcwurxEDz2Og+qgVibXoPtiqHdX
 S4D+9eU+ilOKpU6TgpS3WJx6d2HzTpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715778559;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l3aBRZQfdXwiU8hO2RTDOgNBd2ryYP6ajTwAdAr9GnU=;
 b=nrJVAC40e5GgTwET7ihUc0CrDaRPBGD0InyBXGJQYDGgCzMSzJ7cv+gTi40EW06WZxggcm
 aSZg8iK3qqNVr0Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6B76136A8;
 Wed, 15 May 2024 13:09:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gx8DM/6zRGaWSgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 15 May 2024 13:09:18 +0000
Date: Wed, 15 May 2024 15:09:17 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240515130917.GB222948@pevik>
References: <20240515094753.1072-1-mdoucha@suse.cz>
 <20240515101511.GA211618@pevik> <ZkSUG0EtSyu6GvvW@yuki>
 <20240515122245.GA220651@pevik>
 <4d88ed11-eb8c-480c-a443-30358855703f@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4d88ed11-eb8c-480c-a443-30358855703f@suse.cz>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0A7D4206B7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tcindex01: Pass if the tcindex module is
 blacklisted
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

> On 15. 05. 24 14:22, Petr Vorel wrote:
> > That reminds me .modprobe_module WIP patchset. I was not able to continue with
> > it, also I'm still gathering what is needed, I was not sure if it's needed to
> > add it or it'd be possible to enhance .needs_drivers. Also, I'd be great to
> > collect these few tests with non-standard requirements into a single ticket.

> For this test, we definitely don't want the LTP library to modprobe the
> module. Because explicit modprobe would succeed despite blacklist.

Thanks for info. Does it mean that test requires to tcindex be loaded
automatically via that traffic filter? I.e. simple modprobe tcindex
would spoil testing? Your way testing ENOENT is obviously correct (and working
now without library modifications), but modprobe for detection followed by
"modprobe -r" could also work (non-existing code).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
