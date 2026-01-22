Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A360ED3EE6C
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 14:27:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3AF243CB84D
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 15:27:28 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E2E83CB6E9
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 15:27:09 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A39DA20023A
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 15:27:08 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 845B55BD11;
 Thu, 22 Jan 2026 14:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769092027;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9xlLBOrLVfibtZFLc3UEofOEEQJCmagehXsnKh8RZNw=;
 b=IWRoLOTV3cFtGAzc9m+HayCmXPbnGbu03E2t5R7/yOlB/BVNZzOHK5Mk1N+oIr6FNWqVy6
 1oBAlwW3CP6k9QHglG07baXd2Evk1bzZ6plxcsm4GnHU2OyiFQr3PlyICk5rp0OnSyZlwO
 0ba8E85gaHldeDcKQyBHHe4IW189XeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769092027;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9xlLBOrLVfibtZFLc3UEofOEEQJCmagehXsnKh8RZNw=;
 b=yI3nVxlhODPI0UZ+pRk4QZhq0WJpHMVTTF/vFUMroynqSTYggBqO5rpMfoG7BqeYpw9bii
 SzLwLwD+Q1oyD3AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769092027;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9xlLBOrLVfibtZFLc3UEofOEEQJCmagehXsnKh8RZNw=;
 b=IWRoLOTV3cFtGAzc9m+HayCmXPbnGbu03E2t5R7/yOlB/BVNZzOHK5Mk1N+oIr6FNWqVy6
 1oBAlwW3CP6k9QHglG07baXd2Evk1bzZ6plxcsm4GnHU2OyiFQr3PlyICk5rp0OnSyZlwO
 0ba8E85gaHldeDcKQyBHHe4IW189XeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769092027;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9xlLBOrLVfibtZFLc3UEofOEEQJCmagehXsnKh8RZNw=;
 b=yI3nVxlhODPI0UZ+pRk4QZhq0WJpHMVTTF/vFUMroynqSTYggBqO5rpMfoG7BqeYpw9bii
 SzLwLwD+Q1oyD3AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22CF6139AC;
 Thu, 22 Jan 2026 14:27:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id C+a3A7szcmlxJQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 22 Jan 2026 14:27:07 +0000
Date: Thu, 22 Jan 2026 15:27:01 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "Kubaj, Piotr" <piotr.kubaj@intel.com>
Message-ID: <20260122142701.GA78350@pevik>
References: <20260120144626.231614-2-piotr.kubaj@intel.com>
 <20260120193851.GB65442@pevik>
 <4dd67d8bf040715bf5a6456bb4270f08dba3986b.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4dd67d8bf040715bf5a6456bb4270f08dba3986b.camel@intel.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 TO_DN_EQ_ADDR_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] thermal: add new test group
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
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Ossowski,
 Tomasz" <tomasz.ossowski@intel.com>, "Dubel,
 Helena Anna" <helena.anna.dubel@intel.com>, "Niestepski,
 Daniel" <daniel.niestepski@intel.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Piotr,
...
> > > +	bool interrupts_found = 0;
> > > +	char line[8192];
> > very nit: IMHO 1024 would be more than enough, but whatever.
> And I wasn't even sure 8192 would be enough. The reason is that, since
> it's a string, every digit is a single array element. With new 2S or 4S
> systems with hundreds of cores and each interrupt being up to 2^64,
> even 8192 might not be enough.

OK.

> > > +
> > > +	memset(interrupt_array, 0, nproc *
> > > sizeof(*interrupt_array));
> > > +	FILE *fp = SAFE_FOPEN("/proc/interrupts", "r");
> > > +
> > > +	while (fgets(line, sizeof(line), fp)) {
> > > +		if (strstr(line, "Thermal event interrupts")) {
> > Can't we use FILE_LINES_SCANF() or SAFE_FILE_LINES_SCANF() to instead
> > of whole
> > while() block to simplify?

> > See example code
> > https://github.com/linux-test-project/ltp/tree/master/lib/newlib_tests/tst_safe_fileops.c
> It's quite unclear to me. SAFE_FILE_LINES_SCANF() seems fine for
> reading a single interrupt number or even multiple, but only when well
> known how many cores we have. Here the number of elements in the array
> is equal to the number of logical cores the system has, in my case
> it's:
>  TRM:       7795       7795       7795       7795       7800       7800
> 7797       7797       7795       7795       7886       7886       7860
> 7860       7863       7863       7795       7795       7795       7795
> 7795       7795       7795       7795   Thermal event interrupts

> I tried:
> SAFE_FILE_LINES_SCANF("/proc/interrupts", " TRM:%sThermal event
> interrupts", line);

> to fit all the numbers in "line" string and then later parse them, but
> only the 1st number is read. Here we need to have all of them.

I'm sorry, I was wrong here. Yes, you right SAFE_FILE_LINES_SCANF() scans whole
file at once. With generic pattern it can cumulate the results (otherwise with
specific enough it finds only single place). Anyway, not suitable for you.

But you could process each line with SAFE_SSCANF(), that would help to avoid
strtok() (simplify code a lot).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
