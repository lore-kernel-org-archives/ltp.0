Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA4DEB64DA
	for <ltp@archiver.kernel.org>; Wed, 19 Jul 2023 09:30:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B3ED83C9737
	for <ltp@archiver.kernel.org>; Wed, 19 Jul 2023 11:30:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 33ACF3C0D05
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 11:28:50 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9D7546007A1
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 11:28:48 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id EAECD1FD94
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 09:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689758927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cxXtbqeFpUpiJfFIHLQud/Yg8M8e/ZysIBgo3nI6G/4=;
 b=JfiC/eIRA6NnG9iMi9eTwDx6iqXDnuv0KDwVP5yN0PDTAryA0G2Tc8/WwC6+zclMd01QXQ
 Lc4PVjzCMKCa66Yv7uCTlxDfnjYmXyTPunbFvWWPxGXG5//V5lgxXdidAtEPcunqw5CcRV
 rw9F2E1aLkCvmqnkbE0hPzXXz4f534g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689758927;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cxXtbqeFpUpiJfFIHLQud/Yg8M8e/ZysIBgo3nI6G/4=;
 b=Z7z6qlsccgudpxCEeLmleY8AYO6AbqagHNbqKAG8SXtTAZTnYqUBLn/64/tyJ62iIPRT7v
 +sHrtfM7Y9bPMIAQ==
Received: from localhost (dwarf.suse.cz [10.100.12.32])
 by relay2.suse.de (Postfix) with ESMTP id C69412C142;
 Wed, 19 Jul 2023 09:28:47 +0000 (UTC)
Date: Wed, 19 Jul 2023 11:28:47 +0200
From: Jiri Bohac <jbohac@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <ZLesz+hBcRGh1XOh@dwarf.suse.cz>
References: <20230718114027.GA1172148@pevik> <ZLaYMAkKxMK3h7mC@yuki>
 <ZLab3JV7ECyGIccZ@yuki> <ZLajnVugi-F3Lx_U@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZLajnVugi-F3Lx_U@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 19 Jul 2023 11:30:12 +0200
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On Tue, Jul 18, 2023 at 04:37:17PM +0200, Cyril Hrubis wrote:
> > > > sched_rr_get_interval01.c:72: TFAIL: /proc/sys/kernel/sched_rr_timeslice_ms != 100 got 90
> > > > 
> > > > According to kernel/Kconfig.hz CONFIG_HZ can have various values (100, 250, 300,
> > > > 1000). Should we adapt the test to expect any of these? Or should we require
> > > > kernel config to read CONFIG_HZ value and check for correct value?
> > > 
> > > We had the same problem with getrusage04.c, see the
> > > guess_timer_resolution() function there.
> > 
> > However in the case of sched_rr_get_interval() both values are supposed
> > to be in seconds. The sched_rr_get_interval() fills in a timespec and
> > the proc file is in miliseconds. As far as I can tell we actually
> > compare apples to apples in the test and not oranges and apples.
> 
> So I suppose that this is just rounding error in kernel.
> 
> We do have RR_TIMESLICE defined as:
> 
> include/linux/sched/rt.h:
> 
> #define RR_TIMESLICE           (100 * HZ / 1000)
> 
> And we get the proc file from that by:
> 
> static int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;
> 
> If you put 300 you get:
> 
> (1000 / 300) * (100 * 300 / 1000)
> 
> Which in integer arithmetic is:
> 
> 3 * 30 = 90
> 
> While the syscall acutally does a bit more work to get the numbers right
> as it uses the timeslice (RR_TIMESLICE) in jiffies, which itself is
> precise and converts that into timespec. We still getthe 99999990ns
> instead of 100000000ns I suppose that is because jiffies_to_timespec64()
> uses TICK_NSEC, which is more precise in integer arithmetics but still
> rounded (we get 3333333 in the case of 300HZ and that multiplied by
> RR_TIMESLICE is still 99999990).
> 
> 
> Maybe the fix sould be to change the division as:
> 
> static int sysctl_sched_rr_timeslice = (MSEC_PER_SEC * RR_TIMESLICE) / HZ

makes sense to me; good catch!

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
