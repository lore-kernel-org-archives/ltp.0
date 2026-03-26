Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88F010A62F3
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 14:39:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3CB443CCDB0
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 15:38:59 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6EBAD3CB935
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 15:38:39 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 10331200216
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 15:38:38 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C20515BD11;
 Thu, 26 Mar 2026 14:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774535917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ELA2D7LPgaQuefrTH+dygf7wEFMZZe+TvhaW0ccgOjQ=;
 b=DXKB0GMFUl54ZyaDKtHl5ob77CLRzwP40mPTVrpBWNthPzLa9OJAWtYWUzOEDdTa4aNlU8
 SnS1yGVPhjm7JWvqTH8BFJ0JLVTMXgM74TRX2+tOPo826whvWxly5OhRx7qWln7056SvFL
 bH3wjdhY472tn1YpLjg1AHcnhl+R6SM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774535917;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ELA2D7LPgaQuefrTH+dygf7wEFMZZe+TvhaW0ccgOjQ=;
 b=0t1wzbgH+2L3eaVw2/oyYiRbn+XV1QbUstfOKZTVHN4FqHziy8MtRUyG9maNjjMOor7DnO
 Q6mJw92hJ6gbOwBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774535917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ELA2D7LPgaQuefrTH+dygf7wEFMZZe+TvhaW0ccgOjQ=;
 b=DXKB0GMFUl54ZyaDKtHl5ob77CLRzwP40mPTVrpBWNthPzLa9OJAWtYWUzOEDdTa4aNlU8
 SnS1yGVPhjm7JWvqTH8BFJ0JLVTMXgM74TRX2+tOPo826whvWxly5OhRx7qWln7056SvFL
 bH3wjdhY472tn1YpLjg1AHcnhl+R6SM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774535917;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ELA2D7LPgaQuefrTH+dygf7wEFMZZe+TvhaW0ccgOjQ=;
 b=0t1wzbgH+2L3eaVw2/oyYiRbn+XV1QbUstfOKZTVHN4FqHziy8MtRUyG9maNjjMOor7DnO
 Q6mJw92hJ6gbOwBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2A314A0A3;
 Thu, 26 Mar 2026 14:38:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tRXNKu1ExWllLgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 26 Mar 2026 14:38:37 +0000
Date: Thu, 26 Mar 2026 15:38:39 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <acVE76yDEM8pymPW@yuki.lan>
References: <20260205135724.23772-1-chrubis@suse.cz>
 <20260205174756.GA338897@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260205174756.GA338897@pevik>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, yuki.lan:mid,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_kconfig: Add runtime checks
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
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> nit: please use /* */ otherwise checkpatch complains.

Hmm, so apparently kernel has a bit crazy rule that the SPDX has to be
between /* */ in headers and start with // in C sources. Because of some
tooling that parses kernel headers couldn't handle //.

I do not think that there will be any tooling parsing LTP internal
headers. Maybe we can silence that rule in checkpatch?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
