Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7198FC2BD09
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 19:09:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A540D3D19B0
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 21:09:51 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 65DFC3C0746
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 21:09:35 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5AD4E100203F
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 21:09:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2DD4221A36;
 Fri, 12 Jul 2024 19:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720811372;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fs6qviyA0ihD6/aMwe9kkDxHC09HfUXbBAqknaLM/UI=;
 b=eUi4n5FpzgNTFY93O++OGTdUtMmk2954Bk35H+pgTXgz3UzdDtPAMViFz+zxbTVZZ2WEQ/
 j7HZhqii90eJBs7eGUKsUZXhOT/Dh5vo8Hp07LzsYM0xZ8XqvTs04FrPReQbXzxgwLW8dQ
 Kk6CAAaZ188y1WRCUv34aeRERUKvRzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720811372;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fs6qviyA0ihD6/aMwe9kkDxHC09HfUXbBAqknaLM/UI=;
 b=8/EuibOruhrUG39cYyNAEmw+EzEuyQq12n+k/zBZMz84PSa1tKMDGuYDJ1H3isgmXiwODc
 ucUHa2bzUqmKPrBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eUi4n5Fp;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="8/EuibOr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720811372;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fs6qviyA0ihD6/aMwe9kkDxHC09HfUXbBAqknaLM/UI=;
 b=eUi4n5FpzgNTFY93O++OGTdUtMmk2954Bk35H+pgTXgz3UzdDtPAMViFz+zxbTVZZ2WEQ/
 j7HZhqii90eJBs7eGUKsUZXhOT/Dh5vo8Hp07LzsYM0xZ8XqvTs04FrPReQbXzxgwLW8dQ
 Kk6CAAaZ188y1WRCUv34aeRERUKvRzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720811372;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fs6qviyA0ihD6/aMwe9kkDxHC09HfUXbBAqknaLM/UI=;
 b=8/EuibOruhrUG39cYyNAEmw+EzEuyQq12n+k/zBZMz84PSa1tKMDGuYDJ1H3isgmXiwODc
 ucUHa2bzUqmKPrBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C666213686;
 Fri, 12 Jul 2024 19:09:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id M0B1Lmt/kWaTSAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 12 Jul 2024 19:09:31 +0000
Date: Fri, 12 Jul 2024 21:09:26 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240712190926.GA399927@pevik>
References: <20240711104400.63355-1-pvorel@suse.cz>
 <20240711104400.63355-2-pvorel@suse.cz> <ZpERtIxWiodTJiYS@rei>
 <20240712132205.GA145191@pevik> <ZpE5q627g9bpxfwj@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZpE5q627g9bpxfwj@yuki>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2DD4221A36
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 2/2] sched_football: Rewrite into new API
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
Cc: John Stultz <jstultz@google.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > Hm, after doing make clean of the library everything magically worked. I'm sorry
> > for the noise.

> I guess that the reason for most problems we have is that LTP does not
> have a proper dependencies in the build system. I guess that I can try
> to add support for autogenerating dep files and including them, but I'm
> afraid that with the amount of complexity we have there because of the
> out-of-tree build support things will get very complicated quite fast.

I hoped there is something I just overlooked. Even I'm not a big fan of meson,
instead of implementing something own I would consider migrating to it.
Looking into Andrea's POV, where he did at least some work [1].

But back to the reality, would it be possible to merge this even with broken
dependency? I'm not sure myself.

Kind regards,
Petr

[1] https://github.com/acerv/ltp-core/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
