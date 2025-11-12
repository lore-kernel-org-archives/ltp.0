Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08913CCF9F8
	for <ltp@archiver.kernel.org>; Wed, 12 Nov 2025 11:43:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80EE93CF730
	for <ltp@archiver.kernel.org>; Wed, 12 Nov 2025 12:43:34 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C36B63CF701
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 12:43:18 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 22E4E2002BE
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 12:43:17 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 80DF121211;
 Wed, 12 Nov 2025 11:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762947796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5/loOfJKmDinmU5746XK94FRZCRNhgKU8JM9/HlCAmk=;
 b=fOHI6IccKU/TvtGC/iDhXzlS/y0MyDHEBM2JBfwB7lUK3CP18z9NoYCXNQFXM3RN9YzLTw
 u+O0UR6xT4MqKbyjEhszw2a3ieIRr2We4G+Xl4cH1of4LFigfea6ajXUZSRKVCUubV7jhN
 +1TDN15bAldvCObAfuhybk+hwQggFHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762947796;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5/loOfJKmDinmU5746XK94FRZCRNhgKU8JM9/HlCAmk=;
 b=5vGm2+xhF+6vzXmnFn9vjQuAm7bp58ORL4Rr5n8NmlSKSlvRST5a77CqJ1G/BHGwF07eVW
 SbuvIT7q1aYawZAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="EqFx9SV/";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="pr/6TE+G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762947794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5/loOfJKmDinmU5746XK94FRZCRNhgKU8JM9/HlCAmk=;
 b=EqFx9SV/+RvaRR/3arG5IK6p2WqG31KQCdej8daD1tbp+nWJFRY3irJFiaEpXXYaqLxFC+
 snFM3xxBI+cSSk8vOg7hBBi7Mk/nXzSvdX1p1cZ2YitDa0vvihZN52oRNP0WDPvlvcGchR
 S9SJ4k/tiIO+OUcAJmZDCP6yR6ssERA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762947794;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5/loOfJKmDinmU5746XK94FRZCRNhgKU8JM9/HlCAmk=;
 b=pr/6TE+GwqKtGQeo1usXUIcoGTkocHc/au4ng4qAfzw4mAAuiV2UijWVObD3TmvLGJSSVs
 Fzfmg5EURUoTY6Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61BE33EA61;
 Wed, 12 Nov 2025 11:43:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yHogF9JyFGnsBwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 12 Nov 2025 11:43:14 +0000
Date: Wed, 12 Nov 2025 12:44:03 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <aRRzA1ZRZA0osKsc@yuki.lan>
References: <20250924084223.20597-1-wegao@suse.com>
 <20251101012320.24972-1-wegao@suse.com>
 <20251101012320.24972-2-wegao@suse.com>
 <20251111120600.GA50277@pevik>
 <aRQuc47d3PpTczVB@autotest-wegao.qe.prg2.suse.org>
 <20251112092236.GA80114@pevik> <aRRiLUyES4M5qjOm@yuki.lan>
 <aRRwuF-KGB4AqXS5@autotest-wegao.qe.prg2.suse.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aRRwuF-KGB4AqXS5@autotest-wegao.qe.prg2.suse.org>
X-Rspamd-Queue-Id: 80DF121211
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, yuki.lan:mid, suse.cz:dkim, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] tst_filesystems01.c: Add test for
 .filesystems
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
> > > Thanks for info. Sure, no problem.
> > > 
> > > Cc Cyril in case it's worth to fix it in metaparse.c.
> > 
> > The metaparse tool does macro expansion, that shouldn't be a problem.
> > 
> > Also metaparse only scans testcases/ directory during the build. The
> > lib/ directory is not parsed at all.
> 
> @Cyril 
> Could you help confirm following is the correct way use ?

Yes, forcing double pass for the macro preprocessor is the correct
solution and We already have the same code in TST_TO_STR() in
tst_common.h

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
