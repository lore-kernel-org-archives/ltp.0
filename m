Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278D9CD4851
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 12:06:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D149D3E5432
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 14:06:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C5053DD13F
 for <ltp@lists.linux.it>; Wed, 13 May 2026 14:06:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C43DD2000EE
 for <ltp@lists.linux.it>; Wed, 13 May 2026 14:06:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2DA52765DF;
 Wed, 13 May 2026 12:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778673996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pCL9tyaIBvR6EN7MhCTAZcpUF9JGRuEqoWyGEuOvBdM=;
 b=e6rpCFb0Ij88XGWamTi6j+xeK80EfXUZDytv/KpYnd+K7BvkT9GITgouZafZ/LaSm1fn6k
 dnldgxXDHTS0VN/4+3tTN3H2q4dLOW/NE93NehCdZrNyDnS2uK4jJHhvu1OFwaNifZpA4b
 FmUs1crawnY9q94arsxzyY4rl3sh4Hc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778673996;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pCL9tyaIBvR6EN7MhCTAZcpUF9JGRuEqoWyGEuOvBdM=;
 b=ybbZ6flE4yP6/MEM92OhartThG0gFtwB7Jli5jJpR/UBeXcyzx3KlcK4kcXUVIDqyV/VH/
 F9Yb0rmIqJJyOqAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=e6rpCFb0;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ybbZ6flE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778673996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pCL9tyaIBvR6EN7MhCTAZcpUF9JGRuEqoWyGEuOvBdM=;
 b=e6rpCFb0Ij88XGWamTi6j+xeK80EfXUZDytv/KpYnd+K7BvkT9GITgouZafZ/LaSm1fn6k
 dnldgxXDHTS0VN/4+3tTN3H2q4dLOW/NE93NehCdZrNyDnS2uK4jJHhvu1OFwaNifZpA4b
 FmUs1crawnY9q94arsxzyY4rl3sh4Hc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778673996;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pCL9tyaIBvR6EN7MhCTAZcpUF9JGRuEqoWyGEuOvBdM=;
 b=ybbZ6flE4yP6/MEM92OhartThG0gFtwB7Jli5jJpR/UBeXcyzx3KlcK4kcXUVIDqyV/VH/
 F9Yb0rmIqJJyOqAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D730593A9;
 Wed, 13 May 2026 12:06:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3WdDBkxpBGr5CgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 13 May 2026 12:06:36 +0000
Date: Wed, 13 May 2026 14:06:37 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <agRpTUXG52nluZ-U@yuki.lan>
References: <20260506112420.67516-2-piotr.kubaj@intel.com>
 <agL5X898iY6MXK75@yuki.lan> <20260513105417.GC318856@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260513105417.GC318856@pevik>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2DA52765DF
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v19] thermal: add new test group
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
Cc: helena.anna.dubel@intel.com, tomasz.ossowski@intel.com,
 rafael.j.wysocki@intel.com, daniel.niestepski@intel.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> And other thing which is on my machine broken is to run with more iterations, it
> randomly fails or get stuck after first iteration:
> 
> ./thermal_interrupt_events -i3
> thermal_interrupt_events.c:207: TINFO: CPU 23 interrupt counter: 23 (previous: 21)
> thermal_interrupt_events.c:217: TPASS: x86 package thermal interrupt triggered
> thermal_interrupt_events.c:142: TINFO: Testing /sys/class/thermal/thermal_zone9/temp
> thermal_interrupt_events.c:213: TFAIL: No thermal interrupt increase detected

That may as well be because the CPU heatsink accumulated too much heat
and cannot increase it further. Interacting with the physical world
outside is a bit tricky. The test may need a cooldown period
(e.g. sleep(300)) at the end of the test iteration.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
