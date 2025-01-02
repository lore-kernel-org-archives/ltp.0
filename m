Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B0CE77188
	for <ltp@archiver.kernel.org>; Thu,  2 Jan 2025 12:57:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E7D93EFDBA
	for <ltp@archiver.kernel.org>; Thu,  2 Jan 2025 13:57:19 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D76F63EFB32
 for <ltp@lists.linux.it>; Thu,  2 Jan 2025 13:57:01 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6CFF51400258
 for <ltp@lists.linux.it>; Thu,  2 Jan 2025 13:57:01 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1936A1F38E;
 Thu,  2 Jan 2025 12:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735822620;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TnQUYqsG8WP1NXPrfuXjQ8eCfe1JKRrlqsMR8RmRHsE=;
 b=D9+mTTS/aBEafAY33tUi+0x/tOhIhTgX6jnJrDtuWj5xON9bgpERQmdT/IUErUaii8RvMd
 MDpJgr1IHEzhLO60XYsYgonZa7U/m5lZgWuzQPta8zEqsM3Em3SnvX25x2vDZ50hjolSGC
 Yi6/pJYYfAUuvh7vPAEaDKnR0F+yf3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735822620;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TnQUYqsG8WP1NXPrfuXjQ8eCfe1JKRrlqsMR8RmRHsE=;
 b=7LBpbunabOVwc41P7iWlXejD/95UMkC75cJKZ7NE6wIHaAaEMSLaD56psI1gd7lKgX/BN0
 RpP81SaM4XsnvfCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="D9+mTTS/";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7LBpbuna
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735822620;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TnQUYqsG8WP1NXPrfuXjQ8eCfe1JKRrlqsMR8RmRHsE=;
 b=D9+mTTS/aBEafAY33tUi+0x/tOhIhTgX6jnJrDtuWj5xON9bgpERQmdT/IUErUaii8RvMd
 MDpJgr1IHEzhLO60XYsYgonZa7U/m5lZgWuzQPta8zEqsM3Em3SnvX25x2vDZ50hjolSGC
 Yi6/pJYYfAUuvh7vPAEaDKnR0F+yf3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735822620;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TnQUYqsG8WP1NXPrfuXjQ8eCfe1JKRrlqsMR8RmRHsE=;
 b=7LBpbunabOVwc41P7iWlXejD/95UMkC75cJKZ7NE6wIHaAaEMSLaD56psI1gd7lKgX/BN0
 RpP81SaM4XsnvfCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D56E13418;
 Thu,  2 Jan 2025 12:56:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iiceHxuNdmeJfQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 02 Jan 2025 12:56:59 +0000
Date: Thu, 2 Jan 2025 13:56:53 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250102125653.GB81987@pevik>
References: <20241222072251.13150-1-liwang@redhat.com>
 <20241222072251.13150-2-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241222072251.13150-2-liwang@redhat.com>
X-Rspamd-Queue-Id: 1936A1F38E
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] starvation: skip test on slow kernel
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

Hi Li,

> Systems with slow kernel configurations may not meet
> the performance requirements necessary for the starvation
> test to produce valid results.

> Skipping the test ensures that it runs only on systems
> where its results are meaningful.
...
> +	if (tst_has_slow_kconfig())
> +		tst_brk(TCONF, "Skip test due to slow kernel configuration");
> +

Reviewed-by: Petr Vorel <pvorel@suse.cz>

I suppose you have strong reason for this (e.g. it's failing on some slow
machine). I'm testing it on emulated riscv64 to see whether it's needed to be
skipped. Because due CONFIG_LATENCYTOP it will always be skipped on Tumbleweed.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
