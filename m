Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22882C43458
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 09:40:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4F733E3004
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 11:40:38 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C3963E29FA
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 11:40:24 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EDC701000975
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 11:40:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B1FA575C23;
 Wed,  8 Jul 2026 09:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783503622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+uBPoV0u0lrJOwHUf8jxvphfoKnTZGIGpSFKciqU/xc=;
 b=Gd6tHi9ywcYaLhjdyD3McLqWoo6dWa4yhjKZryEfuWKv690ZkLUHIpm+QeSv2+pZ5ajcK0
 ikQ8jfu7a5uq7GnbxAahOcqERIdedv2mVu1w+gIzjlrbtofOd5mKfPogSET16wLt6Ghh04
 8Qsjy3hjzVpjqH/lI8xihB+5oLqK8ko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783503622;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+uBPoV0u0lrJOwHUf8jxvphfoKnTZGIGpSFKciqU/xc=;
 b=nFOgww2t7SfZWabJF2d7XtazJbynx8QbN9+nB6TSB1zHX81FPtfA9dBGdflJ1eOR+LdEAc
 VV/NPE0qWQIfFYDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Gd6tHi9y;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nFOgww2t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783503622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+uBPoV0u0lrJOwHUf8jxvphfoKnTZGIGpSFKciqU/xc=;
 b=Gd6tHi9ywcYaLhjdyD3McLqWoo6dWa4yhjKZryEfuWKv690ZkLUHIpm+QeSv2+pZ5ajcK0
 ikQ8jfu7a5uq7GnbxAahOcqERIdedv2mVu1w+gIzjlrbtofOd5mKfPogSET16wLt6Ghh04
 8Qsjy3hjzVpjqH/lI8xihB+5oLqK8ko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783503622;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+uBPoV0u0lrJOwHUf8jxvphfoKnTZGIGpSFKciqU/xc=;
 b=nFOgww2t7SfZWabJF2d7XtazJbynx8QbN9+nB6TSB1zHX81FPtfA9dBGdflJ1eOR+LdEAc
 VV/NPE0qWQIfFYDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97A0F779AE;
 Wed,  8 Jul 2026 09:40:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +B26IwYbTmq9YQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 08 Jul 2026 09:40:22 +0000
Date: Wed, 8 Jul 2026 11:40:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ak4a-xb6TNdHaq66@yuki.lan>
References: <20260624091900.4107041-13-chrubis@suse.cz>
 <6a3d24c3.d5b2c389.1eb8a2.4996@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a3d24c3.d5b2c389.1eb8a2.4996@mx.google.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B1FA575C23
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim,yuki.lan:mid];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 12/13] mem: vma03: Rewrite to the new test library
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
> > +	if (TST_ABI != 32 || tst_kernel_bits() != 32)
> > +		tst_brk(TCONF, "test is designed for 32-bit systems only");
> 
> I would use tst_test->needs_abi_bits, since there's no need to do this
> check at the beginning of setup().

Ah, right, will do. Do I need to send a V2 or can I commit with this
fixed?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
