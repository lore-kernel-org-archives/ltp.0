Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA152EB64DA
	for <ltp@archiver.kernel.org>; Wed, 19 Jul 2023 11:21:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EDAEB3CDD37
	for <ltp@archiver.kernel.org>; Wed, 19 Jul 2023 13:21:50 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 800803C9753
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 13:21:40 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C366C60081B
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 13:21:39 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1D0B71FE99;
 Wed, 19 Jul 2023 11:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689765699;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CL6zWa7lw7sIuV2Jg643OeYAj2G6p2CpNAc2SRUEpQ8=;
 b=1CeUjh5s3vg1cFto/9ZDbGCTVdszTdb/M+tyhGlUQxwvsrB8AHvVrFT7t5WkeyxY0hQwDH
 1t/iQvOl8+shHCgyHbeepkTM2rThTHED33laTdjpendMjC6DxEp+xbkf41s6Y6Q6Nh2Mkw
 Dd7sOfIysAdyMYEDZ0iiP/Nz4l7wUI8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689765699;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CL6zWa7lw7sIuV2Jg643OeYAj2G6p2CpNAc2SRUEpQ8=;
 b=rTA7yFELXf0R91FljTJmH6Wj2AJV4CnHYHQSVTpuCNovMynOp3/G7Zc75oY9bS3RdzAJMa
 qwhG8RM+wOWSBKCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 51B331361C;
 Wed, 19 Jul 2023 11:21:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2mJvEkLHt2S8XQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 19 Jul 2023 11:21:38 +0000
Date: Wed, 19 Jul 2023 13:21:36 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230719112136.GA1239020@pevik>
References: <20230719103743.4775-1-chrubis@suse.cz>
 <20230719103743.4775-2-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230719103743.4775-2-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Juri Lelli <juri.lelli@redhat.com>, Shile Zhang <shile.zhang@nokia.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Jiri Bohac <jbohac@suse.cz>,
 Peter Zijlstra <peterz@infradead.org>,
 Shile Zhang <shile.zhang@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

[ Cc Shile Zhang ]

> Thre is 10% rounding error in the intial value of the
> sysctl_sched_rr_timeslice with  CONFIG_HZ_300=y.

> This was found with LTP test sched_rr_get_interval01:

> sched_rr_get_interval01.c:57: TPASS: sched_rr_get_interval() passed
> sched_rr_get_interval01.c:64: TPASS: Time quantum 0s 99999990ns
> sched_rr_get_interval01.c:72: TFAIL: /proc/sys/kernel/sched_rr_timeslice_ms != 100 got 90
> sched_rr_get_interval01.c:57: TPASS: sched_rr_get_interval() passed
> sched_rr_get_interval01.c:64: TPASS: Time quantum 0s 99999990ns
> sched_rr_get_interval01.c:72: TFAIL: /proc/sys/kernel/sched_rr_timeslice_ms != 100 got 90

> What this test does is to compare the return value from the
> sched_rr_get_interval() and the sched_rr_timeslice_ms sysctl file and
> fails if they do not match.

> The prolem it found is the intial sysctl file value which was computed as:

> static int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;

> which works fine as long as MSEC_PER_SEC is multiple of HZ, however it
> introduces 10% rounding error for CONFIG_HZ_300:

> (MSEC_PER_SEC / HZ) * (100 * HZ / 1000)

> (1000 / 300) * (100 * 300 / 1000)

> 3 * 30 = 90

> This can be easily fixed by reversing the order of the multiplication
> and division. After this fix we get:

> (MSEC_PER_SEC * (100 * HZ / 1000)) / HZ

> (1000 * (100 * 300 / 1000)) / 300

> (1000 * 30) / 300 = 100

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> CC: Jiri Bohac <jbohac@suse.cz>
> ---
>  kernel/sched/rt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 00e0e5074115..185d3d749f6b 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -25,7 +25,7 @@ unsigned int sysctl_sched_rt_period = 1000000;
>  int sysctl_sched_rt_runtime = 950000;

>  #ifdef CONFIG_SYSCTL
> -static int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;
> +static int sysctl_sched_rr_timeslice = (MSEC_PER_SEC * RR_TIMESLICE) / HZ;

It looks like very old bug, from v4.11-rc1. I guess this should go to all stable
and LTS kernels.

Fixes: 975e155ed873 ("sched/rt: Show the 'sched_rr_timeslice' SCHED_RR timeslice tuning knob in milliseconds")

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

>  static int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
>  		size_t *lenp, loff_t *ppos);
>  static int sched_rr_handler(struct ctl_table *table, int write, void *buffer,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
