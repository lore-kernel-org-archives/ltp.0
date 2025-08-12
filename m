Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B722CA0EC4
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 11:51:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A3D593CB3F2
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 13:51:22 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 440853C06B5
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 13:51:06 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A7F92140054B
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 13:51:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 809E11F45F;
 Tue, 12 Aug 2025 11:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754999464;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x8wSA3YiVyaa0OB/rNscRDxx9U7zVPcmdNe+DkVQrUo=;
 b=Bd1er6XQbFGfmj01RpsQbWcf2KjXxg4z8h0XvcGKykkvARDvoQIuCpjFn9YIU56PPsPU/j
 KqsDqX5K9FeZH2E9KNAPHfBciv/98x1aMtXOnYlxByefOGah5ehLy18/iwdtudmVouvf8J
 jL+qC9iBVKfsROQiQW/PNXkyM7x2BvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754999464;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x8wSA3YiVyaa0OB/rNscRDxx9U7zVPcmdNe+DkVQrUo=;
 b=P53dwOS4rBdAoQ0wtYgyGniemsiuN7bQRh2T4v1emqihSj3+yP1m3RGt4KzjPBiGo6qxg1
 S5XI1bRuRIpM/cBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754999464;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x8wSA3YiVyaa0OB/rNscRDxx9U7zVPcmdNe+DkVQrUo=;
 b=Bd1er6XQbFGfmj01RpsQbWcf2KjXxg4z8h0XvcGKykkvARDvoQIuCpjFn9YIU56PPsPU/j
 KqsDqX5K9FeZH2E9KNAPHfBciv/98x1aMtXOnYlxByefOGah5ehLy18/iwdtudmVouvf8J
 jL+qC9iBVKfsROQiQW/PNXkyM7x2BvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754999464;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x8wSA3YiVyaa0OB/rNscRDxx9U7zVPcmdNe+DkVQrUo=;
 b=P53dwOS4rBdAoQ0wtYgyGniemsiuN7bQRh2T4v1emqihSj3+yP1m3RGt4KzjPBiGo6qxg1
 S5XI1bRuRIpM/cBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55F98136C7;
 Tue, 12 Aug 2025 11:51:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id I0KHE6gqm2iKIQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 12 Aug 2025 11:51:04 +0000
Date: Tue, 12 Aug 2025 13:50:59 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250812115059.GD843668@pevik>
References: <20250812-cve_2025_38236-v1-1-e3617ada69c6@suse.com>
 <20250812105127.GB835467@pevik>
 <8a13181b-5fbc-4a10-9904-24fd26cb1ebe@suse.com>
 <aJsiE1HmAup1doOf@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aJsiE1HmAup1doOf@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cve: add CVE-2025-38236 test
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

> Hi!
> > We need to set a timeout for recv(), otherwise it will stuck on systems 
> > which are not bugged.

> Or just pass MSG_DONTWAIT to the recv()?

+1, that works.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
