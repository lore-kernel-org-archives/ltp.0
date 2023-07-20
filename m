Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8789EEB64DA
	for <ltp@archiver.kernel.org>; Thu, 20 Jul 2023 15:06:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA61D3CE98B
	for <ltp@archiver.kernel.org>; Thu, 20 Jul 2023 17:06:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 556FE3C02F7
 for <ltp@lists.linux.it>; Thu, 20 Jul 2023 11:58:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 398F26000F8
 for <ltp@lists.linux.it>; Thu, 20 Jul 2023 11:58:02 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 4A5D022B4E;
 Thu, 20 Jul 2023 09:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1689847082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sHzbbuCMHfXitdRlhu6CbOu8h6g1SgL0u67GCVg312E=;
 b=EH0tPb84wa+gVtdOZdXgNL5NQIPNb66mpUXoBRWwL6GOYaDmeJ73oNfl7Vnc1UGIKuDYCW
 87auuZNyKIItvtaFxRyTxVFb9V2A0cDPsjNUH+dPBwogyQ/fyByenD1Gkhd0VeKEdK1SLq
 b2m93e0Sc4zkgddM/cqJkfjnAZLNqGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1689847082;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sHzbbuCMHfXitdRlhu6CbOu8h6g1SgL0u67GCVg312E=;
 b=jS4/SYMM25FVLJF4c4U12FGyRKwC3mQUVQ0Cl7iLBI28ToDyEnpBbAJQAtXLSUXA72pVfp
 CfMX2sjLjxRp2LDQ==
Received: from suse.de (unknown [10.163.43.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 7AFCF2C143;
 Thu, 20 Jul 2023 09:58:00 +0000 (UTC)
Date: Thu, 20 Jul 2023 10:57:57 +0100
From: Mel Gorman <mgorman@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230720095757.syyntxzoqgiucxng@suse.de>
References: <20230719103743.4775-1-chrubis@suse.cz>
 <20230719103743.4775-2-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230719103743.4775-2-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 20 Jul 2023 17:05:53 +0200
Subject: Re: [LTP] [PATCH 1/2] sched/rt: Fix sysctl_sched_rr_timeslice
 intial value
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
Cc: Juri Lelli <juri.lelli@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Jiri Bohac <jbohac@suse.cz>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Ingo Molnar <mingo@redhat.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Jul 19, 2023 at 12:37:42PM +0200, Cyril Hrubis wrote:
> Thre is 10% rounding error in the intial value of the
> sysctl_sched_rr_timeslice with  CONFIG_HZ_300=y.
> 
> This was found with LTP test sched_rr_get_interval01:
> 
> sched_rr_get_interval01.c:57: TPASS: sched_rr_get_interval() passed
> sched_rr_get_interval01.c:64: TPASS: Time quantum 0s 99999990ns
> sched_rr_get_interval01.c:72: TFAIL: /proc/sys/kernel/sched_rr_timeslice_ms != 100 got 90
> sched_rr_get_interval01.c:57: TPASS: sched_rr_get_interval() passed
> sched_rr_get_interval01.c:64: TPASS: Time quantum 0s 99999990ns
> sched_rr_get_interval01.c:72: TFAIL: /proc/sys/kernel/sched_rr_timeslice_ms != 100 got 90
> 
> What this test does is to compare the return value from the
> sched_rr_get_interval() and the sched_rr_timeslice_ms sysctl file and
> fails if they do not match.
> 
> The prolem it found is the intial sysctl file value which was computed as:
> 
> static int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;
> 
> which works fine as long as MSEC_PER_SEC is multiple of HZ, however it
> introduces 10% rounding error for CONFIG_HZ_300:
> 
> (MSEC_PER_SEC / HZ) * (100 * HZ / 1000)
> 
> (1000 / 300) * (100 * 300 / 1000)
> 
> 3 * 30 = 90
> 
> This can be easily fixed by reversing the order of the multiplication
> and division. After this fix we get:
> 
> (MSEC_PER_SEC * (100 * HZ / 1000)) / HZ
> 
> (1000 * (100 * 300 / 1000)) / 300
> 
> (1000 * 30) / 300 = 100
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> CC: Jiri Bohac <jbohac@suse.cz>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
