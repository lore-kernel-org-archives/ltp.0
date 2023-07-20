Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C81EB64DD
	for <ltp@archiver.kernel.org>; Thu, 20 Jul 2023 15:06:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D8B43CE989
	for <ltp@archiver.kernel.org>; Thu, 20 Jul 2023 17:06:14 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D0963C954B
 for <ltp@lists.linux.it>; Thu, 20 Jul 2023 12:00:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6A3CE1A000F2
 for <ltp@lists.linux.it>; Thu, 20 Jul 2023 12:00:07 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 528AB22B58;
 Thu, 20 Jul 2023 10:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1689847207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r79tnlOtDHR7by6b49/n8KfLuYC93z1qpLSo+YCupbI=;
 b=LptwLFcWcnatSFJtxVy5x+3RHOlxDXXrM2dFPtbVWkJXaQlGXAKIBssq9IfwIvgEkWnc88
 VOOzzx2xTz/3VDMdsQoeiEruaeGohwfn0dna/khKC878vVedmQBCi63/LJyal6tkb2cjQH
 ACfTQywy+nD4o2s2x6chZ+xTYPN8uS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1689847207;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r79tnlOtDHR7by6b49/n8KfLuYC93z1qpLSo+YCupbI=;
 b=LP20h7HggkF6ko4HO0b91i+hdxc2azG90KqDBVdx3vLLNsdjEY2PPEZ5h32bZY55qbzSB7
 azmFIAHUsLj11LDQ==
Received: from suse.de (unknown [10.163.43.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id EBEAC2C142;
 Thu, 20 Jul 2023 10:00:04 +0000 (UTC)
Date: Thu, 20 Jul 2023 11:00:02 +0100
From: Mel Gorman <mgorman@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230720100002.yk7lef3fsvtohlhg@suse.de>
References: <20230719103743.4775-1-chrubis@suse.cz>
 <20230719103743.4775-3-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230719103743.4775-3-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 20 Jul 2023 17:05:53 +0200
Subject: Re: [LTP] [PATCH 2/2] sched/rt: sysctl_sched_rr_timeslice show
 default timeslice after reset
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

On Wed, Jul 19, 2023 at 12:37:43PM +0200, Cyril Hrubis wrote:
> The sched_rr_timeslice can be reset to default by writing value that is
> <= 0. However after reading from this file we always got the last value
> written, which is not useful at all.
> 
> $ echo -1 > /proc/sys/kernel/sched_rr_timeslice_ms
> $ cat /proc/sys/kernel/sched_rr_timeslice_ms
> -1
> 
> Fix this by setting the variable that holds the sysctl file value to the
> jiffies_to_msecs(RR_TIMESLICE) in case that <= 0 value was written.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> CC: Jiri Bohac <jbohac@suse.cz>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
