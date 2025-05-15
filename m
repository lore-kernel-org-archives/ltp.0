Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC63C3ABDD
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 10:33:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 78B483CC4A3
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 12:33:58 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD93F3C1A7F
 for <ltp@lists.linux.it>; Thu, 15 May 2025 12:33:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1746A1A01477
 for <ltp@lists.linux.it>; Thu, 15 May 2025 12:33:40 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 87AC81F38A;
 Thu, 15 May 2025 10:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747305219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K68ydN6AzOtn2i3OkkxwU4xi0XBUUPEVIxyBXbbFn+A=;
 b=23KSyhed2LvYDEG6DqtU0FiMuQeGhfNo1xbfmv0btuHAAEeqz/Y6G5pYLQ/Uu4DkMmFMbL
 RhlFD/AMA3OdRYWW9lxyP0xu2FNk+vRwDy39o3jNSySx3F3d+fbyUsZ+tqyldk36WKCnaa
 z3bfXIp2K65vLo1bQTL88HYkNNbrWW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747305219;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K68ydN6AzOtn2i3OkkxwU4xi0XBUUPEVIxyBXbbFn+A=;
 b=12bKJzVsufPrtlNNcwqGdyf1GgoqrsQUfxs7xiLeVOGYrUocToXf/Fe1Le7KiZY+Z6C5U6
 o40W1ut04eb+3HCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=23KSyhed;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=12bKJzVs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747305219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K68ydN6AzOtn2i3OkkxwU4xi0XBUUPEVIxyBXbbFn+A=;
 b=23KSyhed2LvYDEG6DqtU0FiMuQeGhfNo1xbfmv0btuHAAEeqz/Y6G5pYLQ/Uu4DkMmFMbL
 RhlFD/AMA3OdRYWW9lxyP0xu2FNk+vRwDy39o3jNSySx3F3d+fbyUsZ+tqyldk36WKCnaa
 z3bfXIp2K65vLo1bQTL88HYkNNbrWW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747305219;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K68ydN6AzOtn2i3OkkxwU4xi0XBUUPEVIxyBXbbFn+A=;
 b=12bKJzVsufPrtlNNcwqGdyf1GgoqrsQUfxs7xiLeVOGYrUocToXf/Fe1Le7KiZY+Z6C5U6
 o40W1ut04eb+3HCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76E68137E8;
 Thu, 15 May 2025 10:33:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sBUsHAPDJWiHYwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 15 May 2025 10:33:39 +0000
Date: Thu, 15 May 2025 12:34:18 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aCXDKh_biyimb32N@yuki.lan>
References: <20250509092813.12860-1-chrubis@suse.cz>
 <20250512180605.GA337908@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250512180605.GA337908@pevik>
X-Rspamd-Queue-Id: 87AC81F38A
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib: tst_test: Add reproducible output.
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
Cc: valgrind-developers@lists.sourceforge.net, Mark Wielaard <mark@klomp.org>,
 Martin Cermak <mcermak@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> LTP_COLORIZE_OUTPUT allows more complicated setup (y/1 always, n/0: never),
> but any value here enables the feature (e.g. LTP_COLORIZE_OUTPUT=0).
> This would be nice to unify, but I'm ok to ignore it as it's before release.

We also have LTP_ENABLE_DEBUG that has the same values so let's keep the
API the same. I've send v3 with this and the docs changes.

> > +
> >  	assert_test_fn();
> 
> >  	TCID = tid = get_tid(argv);
> 
> Adding docs (+ sort variables while at it).

I've only added the docs for LTP_REPRODUCIBLE_OUTPUT in v3, the sorting
should go in a separate patch. We also miss at least TST_ENABLE_DEBUG in
the output of -h switch as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
