Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF482D78777
	for <ltp@archiver.kernel.org>; Fri, 19 Dec 2025 14:02:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E9B23D0537
	for <ltp@archiver.kernel.org>; Fri, 19 Dec 2025 15:02:56 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 96CED3C5624
 for <ltp@lists.linux.it>; Fri, 19 Dec 2025 15:02:38 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 55C4A1A010D0
 for <ltp@lists.linux.it>; Fri, 19 Dec 2025 15:02:36 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4CC78336DB;
 Fri, 19 Dec 2025 14:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1766152954;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lXtWUDXNVPOS6VKLr35NFeKIanZoSREcS+H7nzDsk9c=;
 b=HcLztHNrwOKl/48/An2dQc3muKvy8oYZpbNYy4lN5K3ZX1F50nwMVquA80+1ks9sZSJk1F
 Cfk5q3d0zyQrs9Z5J1oFUkeNrumtvyTcoO0KrEO6duViQkScb64PhRyMee++YLbDINk0Q6
 goVx6SRh3awbaUp83oxTLG5Y8Ur8nM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1766152954;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lXtWUDXNVPOS6VKLr35NFeKIanZoSREcS+H7nzDsk9c=;
 b=GdEEZRH24wymAawTsHCreUrCh71j4mzLav2Kz5+KTQy3MHwIAkwRWbRW2lUTGntkrh+I6E
 5LBntipAoi/3thBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1766152953;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lXtWUDXNVPOS6VKLr35NFeKIanZoSREcS+H7nzDsk9c=;
 b=12URvJP+ruCQmCbRRrRV5PTmrwmN4prbji9FHS/1gHHlvmxV/JebSWP/roKRUFdzcQYZIR
 gbw5cdO6zko138QCaZkXuH9vJVYX5vquUh9yupj19vH/ViFKOdNvC/jowe5B59YZgL/Cnk
 bcKT47ykjpoFldqXvV7GhHiU6WuHfVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1766152953;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lXtWUDXNVPOS6VKLr35NFeKIanZoSREcS+H7nzDsk9c=;
 b=Pc0Uz7SOtTsawLJcCsIYu4aynWGKFQJv+uStQgu8JpDPcuFJyZrclLd7dE/kSN1oKLNu7l
 z+58irU+0AZPcUCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 294693EA63;
 Fri, 19 Dec 2025 14:02:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4QJPBflaRWlkNQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 19 Dec 2025 14:02:33 +0000
Date: Fri, 19 Dec 2025 15:02:16 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251219140216.GA247368@pevik>
References: <20251219094219.151887-1-pvorel@suse.cz>
 <aUUteQjVmMx1R_X9@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aUUteQjVmMx1R_X9@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.989]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/1] swapon03: Try to swapon() as many files
 until it fails
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

[ Removing Michal to not bother him with LTP internals ]

> Hi!
> >  	tst_res(TINFO, "Successfully created %d swap files", swapfiles);
> > -	MAKE_SMALL_SWAPFILE(TEST_FILE);

> This should stay here, right? I suppose that the test works even when we
> pass non-existing file in the verify_swapon() but we shouldn't bet on
> that.

FYI swap file is created by is_swap_supported(TEST_FILE). But sure, I can
also keep MAKE_SMALL_SWAPFILE(TEST_FILE) to make sure file is also created.
We talked about related cleanup, which I wanted to postpone, but should I
refactor is_swap_supported() to not include swapon() call. Because when there
are too many swap files already mounted, tests is skipped with:

libswap.c:224: TCONF: Permission denied for swapon()
due EPERM, which is actually subject of testing for swapon03.c

I'm not sure about naming. Maybe have is_swap_supported() without swapon() call
(for swapon03.c) and create new function is_swapon_supported(), which would call
is_swap_supported() + swapon() and swapoff() (for all other tests).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
