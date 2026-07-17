Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E263C4451B
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 13:52:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 70F1E3E735A
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 15:52:33 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E9AF03E2549
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 15:52:18 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5BF27600ABE
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 15:52:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 891C578EE5;
 Fri, 17 Jul 2026 13:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784296337;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=idOye+d02qeBx/P6lRZg5c4nQD/YnW5wsP2Tu879X+g=;
 b=MN55UXmkoE4S7LW8B6gNEncM97oyqFDXgFdPYx6rmj6SO4BJKH/oGtUr/hYA8tSLDLb8uv
 sa7UVRH4gB0d3xvpFYyaB/ugIFS3sLhpXhWcnOdrKfiOUuozrqMemB01VlfWuPuL3I6XNz
 GkaKOgUiCgav5mkextJu+KVo5tr+Oqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784296337;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=idOye+d02qeBx/P6lRZg5c4nQD/YnW5wsP2Tu879X+g=;
 b=vE8B59X2pbTvyZ4W2UbTTSaZYMiiqHx3XnDsTsQ8Hy+IAojJUj+zPkYoQjBCfgr7JPE1mq
 dzsoljhlX7zflKCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MN55UXmk;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vE8B59X2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784296337;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=idOye+d02qeBx/P6lRZg5c4nQD/YnW5wsP2Tu879X+g=;
 b=MN55UXmkoE4S7LW8B6gNEncM97oyqFDXgFdPYx6rmj6SO4BJKH/oGtUr/hYA8tSLDLb8uv
 sa7UVRH4gB0d3xvpFYyaB/ugIFS3sLhpXhWcnOdrKfiOUuozrqMemB01VlfWuPuL3I6XNz
 GkaKOgUiCgav5mkextJu+KVo5tr+Oqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784296337;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=idOye+d02qeBx/P6lRZg5c4nQD/YnW5wsP2Tu879X+g=;
 b=vE8B59X2pbTvyZ4W2UbTTSaZYMiiqHx3XnDsTsQ8Hy+IAojJUj+zPkYoQjBCfgr7JPE1mq
 dzsoljhlX7zflKCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06434779AA;
 Fri, 17 Jul 2026 13:52:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9cXeOJAzWmq8fAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 17 Jul 2026 13:52:16 +0000
Date: Fri, 17 Jul 2026 15:52:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260717135215.GA331241@pevik>
References: <alSz9CsUarbMjg6n@yuki.lan>
 <6a54c3a3.c9089686.76aeb.9e76@mx.google.com>
 <alUDuts2SiT7Mu5B@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alUDuts2SiT7Mu5B@yuki.lan>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 891C578EE5
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/8] metadata: test.sh: Add support for
 building out-of-tree
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
> > This is questionable, I think it would take no more than half a day with
> > the LLMs applied to the PoC I wrote a couple of years ago. I can try it
> > in the free time and see how it looks like.

+1

> That's certainly true.

> > When it's available I will send you a draft so you can take a look at it
> > and we can evaluate if it makes sense to try or not. I'm sure there are
> > corner cases where autotools is better and vice versa.

> Feel free. From what I've seen the modern make replacements were not
> working that well with projects that produces many small binaries. But
> that was a few years ago, maybe they are better now.

Well, many of the user space tools migrated to meson (not only Mesa), other big
project use it (e.g. GIMP), I'd say meson + ninja are mature now. And I would
not be worried much for python3 compiler dependency, we have it for the host on
kirk anyway (we certainly don't want it on the guest).

Anyway, patchset merged.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
