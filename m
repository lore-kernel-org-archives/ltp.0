Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01566EB64DA
	for <ltp@archiver.kernel.org>; Tue, 18 Jul 2023 14:36:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E08E3CBA66
	for <ltp@archiver.kernel.org>; Tue, 18 Jul 2023 16:36:26 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C2373C98F6
 for <ltp@lists.linux.it>; Tue, 18 Jul 2023 16:36:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5AB341A00880
 for <ltp@lists.linux.it>; Tue, 18 Jul 2023 16:36:14 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4482F218FB;
 Tue, 18 Jul 2023 14:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689690974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ugId5MFEinYVdMFUosmKcibHRhbSM9sFA7wXis1czaE=;
 b=bSnNXZXn7lP184kQuZ5bJcbaDvGCt6undJdCQt6W/8RQ65POeU0CTEBsF9g7BS096xDJe3
 ydSp0AAgppMryIEPay/4fOqe6hb8/G7GRffG01WGBVyAXD9Lg0BlTO3aPjsj8YI5IiUn1s
 c32gll4TKRMZI6VxyU2KCA1D1xm2s3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689690974;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ugId5MFEinYVdMFUosmKcibHRhbSM9sFA7wXis1czaE=;
 b=lBkPnHlbNF0j2FyDoq6IFxn1e200VjXKwMOOvY7X/ty9wAjYjjHMF6M81x1ytjdNGMZRPj
 gJq1WfTbj0mlO6BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 312EF134B0;
 Tue, 18 Jul 2023 14:36:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EcfPCl6jtmQSDgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 18 Jul 2023 14:36:14 +0000
Date: Tue, 18 Jul 2023 16:37:17 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZLajnVugi-F3Lx_U@yuki>
References: <20230718114027.GA1172148@pevik> <ZLaYMAkKxMK3h7mC@yuki>
 <ZLab3JV7ECyGIccZ@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZLab3JV7ECyGIccZ@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] sched_rr_get_interval01 depends on particular CONFIG_HZ
 value
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
Cc: Jiri Bohac <jbohac@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > sched_rr_get_interval01.c depends on particular CONFIG_HZ value.
> > > Recent change in openSUSE kernel from the default 250 to 300 breaks it:
> > > 
> > > sched_rr_get_interval01.c:57: TPASS: sched_rr_get_interval() passed
> > > sched_rr_get_interval01.c:64: TPASS: Time quantum 0s 99999990ns
> > > sched_rr_get_interval01.c:72: TFAIL: /proc/sys/kernel/sched_rr_timeslice_ms != 100 got 90
> > > sched_rr_get_interval01.c:57: TPASS: sched_rr_get_interval() passed
> > > sched_rr_get_interval01.c:64: TPASS: Time quantum 0s 99999990ns
> > > sched_rr_get_interval01.c:72: TFAIL: /proc/sys/kernel/sched_rr_timeslice_ms != 100 got 90
> > > 
> > > According to kernel/Kconfig.hz CONFIG_HZ can have various values (100, 250, 300,
> > > 1000). Should we adapt the test to expect any of these? Or should we require
> > > kernel config to read CONFIG_HZ value and check for correct value?
> > 
> > We had the same problem with getrusage04.c, see the
> > guess_timer_resolution() function there.
> 
> However in the case of sched_rr_get_interval() both values are supposed
> to be in seconds. The sched_rr_get_interval() fills in a timespec and
> the proc file is in miliseconds. As far as I can tell we actually
> compare apples to apples in the test and not oranges and apples.

So I suppose that this is just rounding error in kernel.

We do have RR_TIMESLICE defined as:

include/linux/sched/rt.h:

#define RR_TIMESLICE           (100 * HZ / 1000)

And we get the proc file from that by:

static int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;

If you put 300 you get:

(1000 / 300) * (100 * 300 / 1000)

Which in integer arithmetic is:

3 * 30 = 90

While the syscall acutally does a bit more work to get the numbers right
as it uses the timeslice (RR_TIMESLICE) in jiffies, which itself is
precise and converts that into timespec. We still getthe 99999990ns
instead of 100000000ns I suppose that is because jiffies_to_timespec64()
uses TICK_NSEC, which is more precise in integer arithmetics but still
rounded (we get 3333333 in the case of 300HZ and that multiplied by
RR_TIMESLICE is still 99999990).


Maybe the fix sould be to change the division as:

static int sysctl_sched_rr_timeslice = (MSEC_PER_SEC * RR_TIMESLICE) / HZ


Jiri any ideas on this, should I send a patch?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
