Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC26CA0FED
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 09:18:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB7C83C9EB8
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 11:18:27 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 879733C9EB8
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 11:18:11 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DB8906009E2
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 11:18:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1592E4DDB5;
 Fri,  5 Sep 2025 09:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1757063889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RpDqPT49nYI9dZJEx6an6oESM5vdzGuHtooM3xBTGoI=;
 b=uQFPQgDSyLMSnPdVF/hgxl232TLK9psg7qJe64tm2DaEP9iq9A+xWIv6zC/BEpTvIWkBUb
 ABxcVCePYfX3LJh1dPCB3KforolvB+5jK6eBl66dXwKY3cEYGiF/GPQ27t0Oi11M6kk/4V
 BjVTs8DlUTI+lPOJoNWmbaeUTg4JtlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1757063889;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RpDqPT49nYI9dZJEx6an6oESM5vdzGuHtooM3xBTGoI=;
 b=zW2PYNtwDA4fR39Rudx2WcQfDFomebMWQsJf1V9VROdPQVP9mXZL8IWXknjVR2njXss/IY
 duCG2pjOLhlzIXCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1757063889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RpDqPT49nYI9dZJEx6an6oESM5vdzGuHtooM3xBTGoI=;
 b=uQFPQgDSyLMSnPdVF/hgxl232TLK9psg7qJe64tm2DaEP9iq9A+xWIv6zC/BEpTvIWkBUb
 ABxcVCePYfX3LJh1dPCB3KforolvB+5jK6eBl66dXwKY3cEYGiF/GPQ27t0Oi11M6kk/4V
 BjVTs8DlUTI+lPOJoNWmbaeUTg4JtlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1757063889;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RpDqPT49nYI9dZJEx6an6oESM5vdzGuHtooM3xBTGoI=;
 b=zW2PYNtwDA4fR39Rudx2WcQfDFomebMWQsJf1V9VROdPQVP9mXZL8IWXknjVR2njXss/IY
 duCG2pjOLhlzIXCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE233139B9;
 Fri,  5 Sep 2025 09:18:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SQz3ONCqumgdKQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 05 Sep 2025 09:18:08 +0000
Date: Fri, 5 Sep 2025 11:18:46 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <aLqq9o9Dkbhr957V@yuki.lan>
References: <20250904102609.133359-1-liwang@redhat.com>
 <20250904110018.GA56668@pevik> <aLl7ConfYPBglqhx@rei.lan>
 <CAEemH2f=6MRZTk95ZctgPG-MKdyw5oK9WNgh3Tm8WNHQ9NcW_g@mail.gmail.com>
 <aLmwLn9RDo2qmk7K@yuki.lan>
 <CAEemH2cK3idxQHmpSGs8VuWSOosHrFNYK=ic0s90B_WNh7AVjw@mail.gmail.com>
 <CAEemH2cXQ=_F=Bq5CZN1j=SbeceDCKCdZh4jDdGSz-x10XZLtA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cXQ=_F=Bq5CZN1j=SbeceDCKCdZh4jDdGSz-x10XZLtA@mail.gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
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
> Checking the configurations of the stock kernel and the real-time
> kernel, the stock kernel uses "CONFIG_PREEMPT_VOLUNTARY=y,"
> which only provides voluntary preemption.
>
> This preemption model is designed to strike a balance between throughput
> and latency. It only allows the kernel to be preempted at specific, well
> defined
> "safe points," potentially resulting in long, unbounded latencies.
> 
> However, the sched_football test was most likely designed to measure or
> stress-test the deterministic, low-latency scheduling behavior that is
> characteristic of real-time (RT) kernel.
> 
> So, I tend to believe the test's failure on the stock kernel is acceptable.

I still find it a bit unexpected though. The preeption models apply only
to kernel code. The user space code can be stil preempted at any point,
so the offense threads should be preempted and replaced by high priority
tasks and never executed again since we do not call to the kernel there
at all, we just run a loop that increments an integer there. I guess
that one possibility is that we saturate the machine with real-time
tasks to the extend that scheduller code in kernel does not get to
distribute the processes. If that is a problem we need to give kernel
chance to shuffle the processes when we wait for the kickoff flag.

Does things start to work if we change the loops that wait for the final
kickoff to:

       while (!tst_atomic_load(&kickoff_flag))
               sched_yield();

This should trigger the scheduller code to be executed so that it has
chance to distribute the processes around.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
