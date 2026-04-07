Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B88FEEF29
	for <ltp@archiver.kernel.org>; Tue,  7 Apr 2026 12:17:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EDE443E29B7
	for <ltp@archiver.kernel.org>; Tue,  7 Apr 2026 14:17:10 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 266713D082A
 for <ltp@lists.linux.it>; Tue,  7 Apr 2026 14:16:51 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A0AC7600805
 for <ltp@lists.linux.it>; Tue,  7 Apr 2026 14:16:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 365545BD70;
 Tue,  7 Apr 2026 12:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775564209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gz8uPnSDyMPTw5bQro765XGlLbmm82FUw3BqRhCK5sM=;
 b=GryNutgs02fgmOKfIuYjthBAX3NAqilxyVYdC6+riZiUrAOo+RoMZvACfD9PGhyDOc6uh/
 va9l8L0v7poSxSY2Eeu9+TMpqx692/naP62V0JENyPBQlg/OYREBJbwdTtYil/NwyeOe4p
 RN5M0dNTzUOGBd0N5/e9+dF+Hol9McE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775564209;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gz8uPnSDyMPTw5bQro765XGlLbmm82FUw3BqRhCK5sM=;
 b=hWdmaR/Wd2KkVzq8Fuo8xEl3VODebkML5UKHX2aEB7pfiZrcYBxm8/Z7zvsh8NMJjqlPow
 bdnbg9XAVYDTMbDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775564209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gz8uPnSDyMPTw5bQro765XGlLbmm82FUw3BqRhCK5sM=;
 b=GryNutgs02fgmOKfIuYjthBAX3NAqilxyVYdC6+riZiUrAOo+RoMZvACfD9PGhyDOc6uh/
 va9l8L0v7poSxSY2Eeu9+TMpqx692/naP62V0JENyPBQlg/OYREBJbwdTtYil/NwyeOe4p
 RN5M0dNTzUOGBd0N5/e9+dF+Hol9McE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775564209;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gz8uPnSDyMPTw5bQro765XGlLbmm82FUw3BqRhCK5sM=;
 b=hWdmaR/Wd2KkVzq8Fuo8xEl3VODebkML5UKHX2aEB7pfiZrcYBxm8/Z7zvsh8NMJjqlPow
 bdnbg9XAVYDTMbDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 257A04A0B0;
 Tue,  7 Apr 2026 12:16:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cvrhB7H11Gl/CQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 07 Apr 2026 12:16:49 +0000
Date: Tue, 7 Apr 2026 14:16:55 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <adT1t083QxgjBX6i@yuki.lan>
References: <20260304141236.9080-3-chrubis@suse.cz>
 <69a84fdb.050a0220.18749d.4545@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69a84fdb.050a0220.18749d.4545@mx.google.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] syscalls: sysinfo01: Rewrite
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
> > +	sys_load1 = sys_buf->loads[0] / 65536.0;
> > +	sys_load5 = sys_buf->loads[1] / 65536.0;
> > +	sys_load15 = sys_buf->loads[2] / 65536.0;
> 
> I would go for:
> 
> 	sys_load1 = sys_buf->loads[0] / (float)(1 << SI_LOAD_SHIFT);
> 
> That "magic value" needs at least to be explained on a comment
> otherwise. With this fixed:

I've fixed the test to use SI_LOAD_SHIFT and TST_KB and also to use
:manpage:`sysinfo(2)` in the doc comment and pushed, thanks for the
reviews.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
