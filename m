Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABEEFC2BD09
	for <ltp@archiver.kernel.org>; Fri, 28 Jun 2024 12:49:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E12B93D43C9
	for <ltp@archiver.kernel.org>; Fri, 28 Jun 2024 14:49:57 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A2F43D439D
 for <ltp@lists.linux.it>; Fri, 28 Jun 2024 14:49:43 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 62AC01001174
 for <ltp@lists.linux.it>; Fri, 28 Jun 2024 14:49:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1BC5521B11;
 Fri, 28 Jun 2024 12:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719578981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yLOvNPULCvvf6LGFpu75EvxljCLgxR3fW4+NshBitiw=;
 b=Pdj6mPUbcAKAQCLtYVr2ZjyB8EseMcU5KeGZFqsV+g5AJBrpR9/y4Kv/V1joYanrtBIIIp
 QDWRXZ+zMNidrE++WKQjuutz1aZ3Tm4YD0x+9Nre+k3n4dj8CeeHhgZX/HAaUN7CeOS/EB
 DguXKqIyKC9mDwq8IaV5H4CCSFmvlew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719578981;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yLOvNPULCvvf6LGFpu75EvxljCLgxR3fW4+NshBitiw=;
 b=E9f6uXSGR0inUiR9UzdtkYJFzWfW9bm3RAdsDE8fr0J+i4hNfpyUbYVqjkBUkea7/9S+IK
 PaTZyHnITyOi8yDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719578980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yLOvNPULCvvf6LGFpu75EvxljCLgxR3fW4+NshBitiw=;
 b=tI4aBcarDpnpIxBbhjpudvVoJwymFGT9nkTbBv/b4pQlNX5ocEu/cM079KYJrmoUeJYjeS
 0sOgNbXl2C/QeLCU2lioLsW8pSkeY554bsSpUjuL9g9hOADj8hYVw1/6B5w9SZiDg4FDva
 dKHH2fWmrTeVhSW92hTMix/fj+zKB4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719578980;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yLOvNPULCvvf6LGFpu75EvxljCLgxR3fW4+NshBitiw=;
 b=CMpKIsDZQFw6TBxymP6ksrBPuG8kJZBCBeeppApmrOvZaMVS9ZRlpkM7g32YCxbmPZWi+S
 rt0sEFF3+TZ8e0BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B2E61373E;
 Fri, 28 Jun 2024 12:49:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9v+XAWSxfmaCcwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 28 Jun 2024 12:49:40 +0000
Date: Fri, 28 Jun 2024 14:49:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: "joe.liu" <joe.liu@mediatek.com>
Message-ID: <Zn6xWVb6SL8Co0cU@yuki>
References: <20240612112311.10334-1-chrubis@suse.cz>
 <20240627092900.20985-1-joe.liu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240627092900.20985-1-joe.liu@mediatek.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.987]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] sched: starvation: Autocallibrate the timeout
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
Cc: alix.wu@mediatek.com, xufeifei1@oppo.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > Instead of hardcoding the values we attempt to measure the CPU speed and
> > set the timeout accordingly. Given that the difference in the duration
> > of the test when the kernel is buggy is about 30x we do not have to have
> > a precise callibration, just very rough estimate if we are running on a
> > server or small ARM board would suffice.
> 
> > So we attempt to measure how long does a bussy loop take and base the
> > default timeout on that. On x86_64 CPUs the resulting timeout is about
> > double of the value of the actual test runtime and works fine, but we
> > need to make sure that the coeficient we divide the result from
> > callibrate works for small boards too. So please run the test on as many
> > machines as you can and report if we need to make the dividor smaller or
> > not.
> 
> While applying this new patch, the test result of 32bit kernel is still failed. Please refers following log:
> 
> external/ltp/lib/tst_test.c:1690: TINFO: LTP version: 20230929
> external/ltp/lib/tst_test.c:1576: TINFO: Timeout per run is 0h 00m 30s
> external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:90: TPASS: sched_setaffinity(0, sizeof(mask), &mask) returned 0
> external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:58: TINFO: CPU did 100000000 loops in 198306us
> external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:99: TINFO: cal timeout: 198
> external/ltp/lib/tst_test.c:1583: TINFO: Updating max runtime to 0h 03m 18s
> external/ltp/lib/tst_test.c:1576: TINFO: Timeout per run is 0h 03m 48s
> Test timeouted, sending SIGKILL!
> 
> After using "time ./starvation" to check the timecost, we can see the timecost is about 26 mins and 48 seconds

This is really strange. I tested the code on RPi Zero with 32bit BCM2835
where the CPU is even slower and runtime limit is set to about 5
minutes, yet the test finished in a minute. That's with resonably recent
kernel 6.1 though.

What kernel version do you use?

Do you run LTP with background tasks to keep the CPU bussy?

Do you have any custom patches for kernel scheduller applied?

It really looks like something unexpected is happening at your end.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
