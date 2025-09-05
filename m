Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1555CA1010
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 07:31:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F7553CD4DF
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 09:31:52 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BF7B3CD4D1
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 09:31:36 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8421A200997
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 09:31:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 003BE4D8A2;
 Fri,  5 Sep 2025 07:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1757057493;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pvta3/lRbYsG52cW1BgeyW/O/4y3oOJi0BrPRgcZZTI=;
 b=DVdPwqztKQGlWlNisZ9kNkG0MOKfQxzG7w998XJQ6K47ddTTY1bu0Xqsl09OklUruZ9eIj
 UyK1oJ+vb1IEQIr3r3ff2vYeUPgpa+/BMLjEjJ0twA4wDNFSDyS2uhKpqRVu2epWfVBgnl
 rwBCXtJl2A9pqsu1sEbw+KqaRGvh/rs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1757057493;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pvta3/lRbYsG52cW1BgeyW/O/4y3oOJi0BrPRgcZZTI=;
 b=5wFDpO7fYqIA9ynvkoX98GJu5fn3tyF1C2Hy+SsyKWMgANaWYl9+CG7C+dK7Rg7dp75UMf
 QALH9UDmriaCziBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DVdPwqzt;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5wFDpO7f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1757057493;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pvta3/lRbYsG52cW1BgeyW/O/4y3oOJi0BrPRgcZZTI=;
 b=DVdPwqztKQGlWlNisZ9kNkG0MOKfQxzG7w998XJQ6K47ddTTY1bu0Xqsl09OklUruZ9eIj
 UyK1oJ+vb1IEQIr3r3ff2vYeUPgpa+/BMLjEjJ0twA4wDNFSDyS2uhKpqRVu2epWfVBgnl
 rwBCXtJl2A9pqsu1sEbw+KqaRGvh/rs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1757057493;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pvta3/lRbYsG52cW1BgeyW/O/4y3oOJi0BrPRgcZZTI=;
 b=5wFDpO7fYqIA9ynvkoX98GJu5fn3tyF1C2Hy+SsyKWMgANaWYl9+CG7C+dK7Rg7dp75UMf
 QALH9UDmriaCziBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C231D13306;
 Fri,  5 Sep 2025 07:31:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zT6rLtSRumioCAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 05 Sep 2025 07:31:32 +0000
Date: Fri, 5 Sep 2025 09:31:27 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>, Cyril Hrubis <chrubis@suse.cz>,
 ltp@lists.linux.it, Andrea Cervesato <andrea.cervesato@suse.com>,
 Chunyu Hu <chuhu@redhat.com>
Message-ID: <20250905073127.GA16065@pevik>
References: <20250904102609.133359-1-liwang@redhat.com>
 <20250904110018.GA56668@pevik> <aLl7ConfYPBglqhx@rei.lan>
 <CAEemH2f=6MRZTk95ZctgPG-MKdyw5oK9WNgh3Tm8WNHQ9NcW_g@mail.gmail.com>
 <aLmwLn9RDo2qmk7K@yuki.lan>
 <CAEemH2cK3idxQHmpSGs8VuWSOosHrFNYK=ic0s90B_WNh7AVjw@mail.gmail.com>
 <CAEemH2cXQ=_F=Bq5CZN1j=SbeceDCKCdZh4jDdGSz-x10XZLtA@mail.gmail.com>
 <20250905070312.GA4185@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250905070312.GA4185@pevik>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 003BE4D8A2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] sched_football: synchronize with kickoff flag
 to reduce skew
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi all,

> ...
> > Checking the configurations of the stock kernel and the real-time
> > kernel, the stock kernel uses "CONFIG_PREEMPT_VOLUNTARY=y,"
> > which only provides voluntary preemption.

> Yes, CONFIG_PREEMPT_VOLUNTARY=y is in all mainline defconfigs
> (arch/*/configs/*_defconfig). Therefore we have it in our Tumbleweed (6.16.3-1)
> and in upcoming SLES16 (6.12 based). SLE15-SP7 (6.4 based) use
> CONFIG_PREEMPT_NONE=y instead.

> Looking at the history It works well on all archs, we just recently had a
> problem with ppc64le hmc on SLE16 (regular ppc64le works). Later I'll check
> history of older SLES versions.

> And most importantly I'll try to run manually with -i (more stress test).

> > This preemption model is designed to strike a balance between throughput
> > and latency. It only allows the kernel to be preempted at specific, well
> > defined
> > "safe points," potentially resulting in long, unbounded latencies.

> > However, the sched_football test was most likely designed to measure or
> > stress-test the deterministic, low-latency scheduling behavior that is
> > characteristic of real-time (RT) kernel.

> > So, I tend to believe the test's failure on the stock kernel is acceptable.
> > And, by the way, what does the SUSE kernel configuration look like?


> > # grep CONFIG_PREEMPT /boot/config-6.12.0-55.29.1.el10_0.x86_64
> > CONFIG_PREEMPT_BUILD=y
> > CONFIG_PREEMPT_VOLUNTARY=y
> > # CONFIG_PREEMPT is not set
> > # CONFIG_PREEMPT_RT is not set
> > CONFIG_PREEMPT_COUNT=y
> > CONFIG_PREEMPTION=y
> > CONFIG_PREEMPT_DYNAMIC=y
> > CONFIG_PREEMPT_RCU=y
> > CONFIG_PREEMPT_NOTIFIERS=y

> > (^ I built my v6.17-rc4 with this config too)

> /boot/config-6.12.0-160000.4-default # Tumbleweed x68_64
> CONFIG_PREEMPT_BUILD=y
> # CONFIG_PREEMPT_NONE is not set
> CONFIG_PREEMPT_VOLUNTARY=y
> # CONFIG_PREEMPT is not set
> # CONFIG_PREEMPT_LAZY is not set
> # CONFIG_PREEMPT_RT is not set
> CONFIG_PREEMPT_COUNT=y
> CONFIG_PREEMPTION=y
> CONFIG_PREEMPT_DYNAMIC=y
> CONFIG_PREEMPT_RCU=y
> CONFIG_PREEMPT_NOTIFIERS=y
> # CONFIG_PREEMPT_TRACER is not set
> CONFIG_PREEMPTIRQ_DELAY_TEST=m

> Upcoming SLE16 is similar to Tumbleweed.

> /boot/config-6.4.0-150700.714.ga8e7017-default # SLE15-SP7 x86_64 RT
> CONFIG_PREEMPT_BUILD=y
> CONFIG_PREEMPT_NONE=y
> # CONFIG_PREEMPT_VOLUNTARY is not set
> # CONFIG_PREEMPT is not set
> # CONFIG_PREEMPT_RT is not set
> CONFIG_PREEMPT_COUNT=y
> CONFIG_PREEMPTION=y
> CONFIG_PREEMPT_DYNAMIC=y
> CONFIG_PREEMPT_RCU=y
> CONFIG_PREEMPT_NOTIFIERS=y
> # CONFIG_PREEMPT_TRACER is not set
> CONFIG_PREEMPTIRQ_DELAY_TEST=m

> /boot/config-6.4.0-150700.5-rt # SLE15-SP7 x86_64 RT
> CONFIG_PREEMPT_LAZY=y
> # CONFIG_PREEMPT_NONE is not set
> # CONFIG_PREEMPT_VOLUNTARY is not set
> # CONFIG_PREEMPT is not set
> CONFIG_PREEMPT_RT=y
> CONFIG_PREEMPT_COUNT=y
> CONFIG_PREEMPTION=y
> CONFIG_PREEMPT_RCU=y
> CONFIG_PREEMPT_NOTIFIERS=y
> # CONFIG_PREEMPT_TRACER is not set
> CONFIG_PREEMPTIRQ_DELAY_TEST=m

And looking on some other distros, e.g. Debian had CONFIG_PREEMPT_VOLUNTARY=y on
6.12.38+deb13 (from recently released stable Debian 13 trixie), but they changed
it to CONFIG_PREEMPT_LAZY=y in 6.16.3+deb14 (for upcoming Debian forky (testing)
- in devel for now). I would expect that setup for RT kernel.

> Kind regards,
> Petr

> > # grep CONFIG_PREEMPT /boot/config-6.12.0-55.31.1.el10_0.x86_64+rt
> > CONFIG_PREEMPT_BUILD=y
> > CONFIG_PREEMPT=y
> > CONFIG_PREEMPT_RT=y
> > CONFIG_PREEMPT_COUNT=y
> > CONFIG_PREEMPTION=y
> > # CONFIG_PREEMPT_DYNAMIC is not set
> > CONFIG_PREEMPT_RCU=y
> > CONFIG_PREEMPT_NOTIFIERS=y

I suppose this RT kernel has CONFIG_PREEMPT_LAZY=y, right?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
