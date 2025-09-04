Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D97CA1002
	for <ltp@archiver.kernel.org>; Thu,  4 Sep 2025 15:28:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D62983CD49F
	for <ltp@archiver.kernel.org>; Thu,  4 Sep 2025 17:28:28 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F87C3CD43D
 for <ltp@lists.linux.it>; Thu,  4 Sep 2025 17:28:12 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A8F491A00881
 for <ltp@lists.linux.it>; Thu,  4 Sep 2025 17:28:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2493A6041D;
 Thu,  4 Sep 2025 15:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1756999689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e4opW5z2JLT/vOMoVwkiQsHBOtdjfOzkG+1zMDoakSQ=;
 b=phm1SwZ+okWvNCLPzanLpm7Fy3CHHctR5hEkANxhuUl/gl8X0FLk//QeZP1Qb1yMzx06cP
 lS1o7OuSpaZyYGjkTg8hjfEVMgs4oL13awNiHtkCsd0yrefOAzkBqOBrZJYkxu5nBaCEU3
 48FPjZ8URM5/nK9AAnX/VIYxaZYYelE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1756999689;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e4opW5z2JLT/vOMoVwkiQsHBOtdjfOzkG+1zMDoakSQ=;
 b=Q40VDjB6HuZQVmsuG5ZykG3dlWt9s+LSpQYE9dzrM++7GRuAKEAVOdpeM3fMpO5eVoloaV
 6Q1ibWZtnhpi/EDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1756999689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e4opW5z2JLT/vOMoVwkiQsHBOtdjfOzkG+1zMDoakSQ=;
 b=phm1SwZ+okWvNCLPzanLpm7Fy3CHHctR5hEkANxhuUl/gl8X0FLk//QeZP1Qb1yMzx06cP
 lS1o7OuSpaZyYGjkTg8hjfEVMgs4oL13awNiHtkCsd0yrefOAzkBqOBrZJYkxu5nBaCEU3
 48FPjZ8URM5/nK9AAnX/VIYxaZYYelE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1756999689;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e4opW5z2JLT/vOMoVwkiQsHBOtdjfOzkG+1zMDoakSQ=;
 b=Q40VDjB6HuZQVmsuG5ZykG3dlWt9s+LSpQYE9dzrM++7GRuAKEAVOdpeM3fMpO5eVoloaV
 6Q1ibWZtnhpi/EDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C95613AA0;
 Thu,  4 Sep 2025 15:28:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RBnJAgmwuWhKDAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 04 Sep 2025 15:28:09 +0000
Date: Thu, 4 Sep 2025 17:28:46 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <aLmwLn9RDo2qmk7K@yuki.lan>
References: <20250904102609.133359-1-liwang@redhat.com>
 <20250904110018.GA56668@pevik> <aLl7ConfYPBglqhx@rei.lan>
 <CAEemH2f=6MRZTk95ZctgPG-MKdyw5oK9WNgh3Tm8WNHQ9NcW_g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2f=6MRZTk95ZctgPG-MKdyw5oK9WNgh3Tm8WNHQ9NcW_g@mail.gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > >  static void do_setup(void)
> > > >  {
> > > > +   if (!tst_check_preempt_rt())
> > > > +           tst_brk(TCONF, "Test requires real-time kernel");
> > >
> > > I understood Cyril is really suggesting to keep it [1]. I would also
> > vote to
> > > keep it (we still have some time to see if it got fixed before release).
> > >
> > > I know we had this discussion in the past (some of your colleague
> > suggesting it
> > > should not be run on non-RT kernel), so I'm not pushing for it.
> >
> > I stil do not understand reasons for disabling the test. The POSIX
> > realtime schedulling classes have to work properly regardless of the
> > kernel flavor. Why should we turn the test off on non-rt kernel then?
> >
> 
> No special reasons. I still can sporadically catch the failure on non-RT
> kernel with even sleep 2 seconds.

That is very strange. The SCHED_FIFO threads should preempty any lower
prio thread as long as they become runable and should stay running until
they finish or yield. Two seconds should be more than enough for that to
happen.

> Thus, I took this very extreme approach, because on non-RT kernel, sleep
> may not have a particularly perfect effect, I guess the stock kernel with
> sched_setscheduler(, SCHED_FIFO, ) is still has scheduling skew with
> workload.

Does this happen on vanilla Linux as well or only on RedHat kernels?

Because AFAIK the test started to fail on SUSE only after the change
that introduced barriers.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
