Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5D2EA3C5E
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 13:45:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 605823E4D40
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 15:45:32 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E16F83E298F
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 15:45:12 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 678A9608A8B
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 15:45:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8775A5BD28;
 Thu,  9 Apr 2026 13:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775742311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VphYRaxN1F1ebCTOUpOnHwu66hk2BaK16hr0MjKpDOY=;
 b=E+RjdnMbfG3k5GEzdRXAHoFhmzRdWvXSPHRSRLw1TENlsd4x27ICvD+gHzMLs4527llF74
 53EDxhMCZrtXiiOrr6kNY/DHpxbfsj98fIj4D7YFJjbLP8+MyUlBK8By25HMNvJV3X2pPh
 JMcTR3rlx2MGy9j9+fAeLPYpBI1phyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775742311;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VphYRaxN1F1ebCTOUpOnHwu66hk2BaK16hr0MjKpDOY=;
 b=ihdvHYHa0XZaQSeklRhy8cGc9de3YhV/FF7vJnLleJ8BjGc1EaPVdqb+UsiXeaEvR5pZxw
 wURbLG8H1qO8gkBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775742311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VphYRaxN1F1ebCTOUpOnHwu66hk2BaK16hr0MjKpDOY=;
 b=E+RjdnMbfG3k5GEzdRXAHoFhmzRdWvXSPHRSRLw1TENlsd4x27ICvD+gHzMLs4527llF74
 53EDxhMCZrtXiiOrr6kNY/DHpxbfsj98fIj4D7YFJjbLP8+MyUlBK8By25HMNvJV3X2pPh
 JMcTR3rlx2MGy9j9+fAeLPYpBI1phyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775742311;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VphYRaxN1F1ebCTOUpOnHwu66hk2BaK16hr0MjKpDOY=;
 b=ihdvHYHa0XZaQSeklRhy8cGc9de3YhV/FF7vJnLleJ8BjGc1EaPVdqb+UsiXeaEvR5pZxw
 wURbLG8H1qO8gkBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 754DA4A0B3;
 Thu,  9 Apr 2026 13:45:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gXS4G2et12lpUQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 09 Apr 2026 13:45:11 +0000
Date: Thu, 9 Apr 2026 15:45:22 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <adetcgMqVhB0YOmd@yuki.lan>
References: <20260317114635.944-1-wegao@suse.com>
 <20260404011340.13288-1-wegao@suse.com> <adZot378W4Rg-g4V@yuki.lan>
 <adcOPxR0ZgVuRS-a@autotest-wegao.qe.prg2.suse.org>
 <adddTXNrEKBkbv9k@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <adddTXNrEKBkbv9k@yuki.lan>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:email,
 yuki.lan:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7] io_submit04: Add test case for RWF_NOWAIT flag
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
> > If you are agree then i will send next patch with s/strerror/tst_strerrno fix.
> > Thanks.
> 
> No need to send another revision. I can fix that before applying the
> patch.

Pushed with two adjustements.

- changed strerror() to tst_strerrno()
- used full link for the Fixes tag

Thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
