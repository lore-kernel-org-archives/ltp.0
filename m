Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B8AC43458
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 16:41:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA47F3E4B09
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 18:41:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C95613E4B09
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 18:40:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8309A140042D
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 18:40:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E0EE375AAB;
 Tue, 30 Jun 2026 16:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782837653;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kz6fQzLTdCkm8LxGDMQcSVn5DOqVlR+Lf3Elk2USay4=;
 b=0tGZ9iJ8imISRa+drseGdECTQfDADWscmYsoGnBRSVpeu3XMcO+ZeaEyKbvb1BcgDzYbdl
 mGcM5etW4BdAH1TsVt+jecrXUXcTP4piRoCeStaD/RW38+TthGcslM+RheUfq3C9hcQNZ5
 uIj52DVgasGTn7nF+eVTxSo8of1zcsc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782837653;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kz6fQzLTdCkm8LxGDMQcSVn5DOqVlR+Lf3Elk2USay4=;
 b=qx+panEATGyjsNzN9I7yGKD5MA1O7PZvw3woFimEViVVd6I4Dn/wUwahEXATUO664amBRR
 D2ZEFrOORsRqQ5Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782837653;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kz6fQzLTdCkm8LxGDMQcSVn5DOqVlR+Lf3Elk2USay4=;
 b=0tGZ9iJ8imISRa+drseGdECTQfDADWscmYsoGnBRSVpeu3XMcO+ZeaEyKbvb1BcgDzYbdl
 mGcM5etW4BdAH1TsVt+jecrXUXcTP4piRoCeStaD/RW38+TthGcslM+RheUfq3C9hcQNZ5
 uIj52DVgasGTn7nF+eVTxSo8of1zcsc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782837653;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kz6fQzLTdCkm8LxGDMQcSVn5DOqVlR+Lf3Elk2USay4=;
 b=qx+panEATGyjsNzN9I7yGKD5MA1O7PZvw3woFimEViVVd6I4Dn/wUwahEXATUO664amBRR
 D2ZEFrOORsRqQ5Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A061779A8;
 Tue, 30 Jun 2026 16:40:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2krHEJXxQ2rHBAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 30 Jun 2026 16:40:53 +0000
Date: Tue, 30 Jun 2026 18:40:46 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260630164046.GA474697@pevik>
References: <20260630102026.GB417625@pevik>
 <6a43a12c.b2781ae3.f5268.13b3@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a43a12c.b2781ae3.f5268.13b3@mx.google.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 TO_DN_ALL(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscall02: add invalid syscall number test
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> Hi Petr,

> > > I suggest add two more cases check:
> > > 1) -1
> > > 2) __NR_syscalls +1 (Base arch/powerpc/kernel/syscall.c)


> that was my initial idea, but different architectures are starting
> from a different value and I wanted to make it generic. I guess
> the right way would be to include syscalls.h and use
> __LTP__NR_INVALID_SYSCALL at this point. WDYT?

Yes, __LTP__NR_INVALID_SYSCALL is better than -1 (for all archs we have
#define __LTP__NR_INVALID_SYSCALL -1)

But I'd also use __NR_syscalls from <asm-generic/unistd.h> (the second suggested
case), i.e. have arch dependent value based on UAPI headers.

Also, you could add a real description to the values to .desc.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
