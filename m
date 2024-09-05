Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5325ACD5BAE
	for <ltp@archiver.kernel.org>; Thu,  5 Sep 2024 12:03:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 454E73C23FB
	for <ltp@archiver.kernel.org>; Thu,  5 Sep 2024 14:02:58 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9FD563C23CA
 for <ltp@lists.linux.it>; Thu,  5 Sep 2024 14:02:39 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D2991601E0C
 for <ltp@lists.linux.it>; Thu,  5 Sep 2024 14:02:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 587531F7D4;
 Thu,  5 Sep 2024 12:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725537755;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zKVY5pnCjeGk1EBwTPasUmvBQYZwAmb9qWf8JuMpBUM=;
 b=Ok+np+8+67zgge1gMvXleNMnJWzA0PYI0zvKHF3HT7lrbJ0SoWKotmivxJeZ3cpVttK1l2
 VxEhGFrM9GxPJM4B59fwEIHdnpqiTVaWsW28GvnbUqa/7dqZtswllRhsKfwlhcCTgoeKmh
 6S6Kowtj8uwI8rF4ycmUHgm1FYl/FHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725537755;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zKVY5pnCjeGk1EBwTPasUmvBQYZwAmb9qWf8JuMpBUM=;
 b=UMLCXqOSmfuVg6xXElUfO2sKjrwmy278ZuCGrWutb48W+GdcJv+LN+VMPyrgO3qUmB1drb
 YUXm+YPx53zul1Cg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Ok+np+8+;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UMLCXqOS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725537755;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zKVY5pnCjeGk1EBwTPasUmvBQYZwAmb9qWf8JuMpBUM=;
 b=Ok+np+8+67zgge1gMvXleNMnJWzA0PYI0zvKHF3HT7lrbJ0SoWKotmivxJeZ3cpVttK1l2
 VxEhGFrM9GxPJM4B59fwEIHdnpqiTVaWsW28GvnbUqa/7dqZtswllRhsKfwlhcCTgoeKmh
 6S6Kowtj8uwI8rF4ycmUHgm1FYl/FHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725537755;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zKVY5pnCjeGk1EBwTPasUmvBQYZwAmb9qWf8JuMpBUM=;
 b=UMLCXqOSmfuVg6xXElUfO2sKjrwmy278ZuCGrWutb48W+GdcJv+LN+VMPyrgO3qUmB1drb
 YUXm+YPx53zul1Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2626513419;
 Thu,  5 Sep 2024 12:02:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id b7K+Btud2Wb8aQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 05 Sep 2024 12:02:35 +0000
Date: Thu, 5 Sep 2024 14:02:18 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240905120218.GA943402@pevik>
References: <20240904064817.29813-1-wegao@suse.com>
 <20240904065653.31086-1-wegao@suse.com>
 <20240905051259.GA890060@pevik> <ZtlwGkEJMUusVSp-@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZtlwGkEJMUusVSp-@yuki.lan>
X-Rspamd-Queue-Id: 587531F7D4
X-Rspamd-Action: no action
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] mpls01: Add --allow-unsupported for
 modprobe(fixing all mpls cases)
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

Hi Cyril,

> Hi!
> > > +mpls_setup_driver()
> > > +{
> > > +	local args
> > > +
> > > +	grep -q 'sl-micro' /etc/os-release && args='--allow-unsupported'

> > I'm going to merge in few hours with following change

> > -       grep -q 'sl-micro' /etc/os-release && args='--allow-unsupported'
> > +       grep -q -w ID_LIKE.*suse /etc/os-release && args='--allow-unsupported'

> > (to implement Cyril's wish to apply the change also for SLES and openSUSE. I'm
> > sorry although I suggested that in v4, then in the full example I in the end
> > used 'sl-micro'.

> Works for me. Acked-by: Cyril Hrubis <chrubis@suse.cz>

Thanks for your ack, merged.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
