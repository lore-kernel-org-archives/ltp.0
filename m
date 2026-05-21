Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B793CD4F3D
	for <ltp@archiver.kernel.org>; Thu, 21 May 2026 03:46:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 249493C73E0
	for <ltp@archiver.kernel.org>; Thu, 21 May 2026 05:46:44 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E7173C737E
 for <ltp@lists.linux.it>; Thu, 21 May 2026 05:46:25 +0200 (CEST)
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EC0A81A00660
 for <ltp@lists.linux.it>; Thu, 21 May 2026 05:46:22 +0200 (CEST)
Date: Thu, 21 May 2026 11:46:15 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1779335180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rvZd/5vg/v6qyhUMnz1lyl1kq0OtWt6BN3t5F4Oj+EY=;
 b=bXlWfQIeg+fEyKKN1LA0ASD6j7gXi/5NmewOncuO0H+gGawXH2hELVeqY7XBalB7OwzGrM
 IP7Yc/ewN24HfGFKuSgSkrBAKZiYvhbDOWFpoAOnvOl12jo9We09jcYNmZRhO38S1zTzJo
 Ed1qz2oMH4PAbVncDgG3yBOWNRTPgZI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: ltp@lists.linux.it
Message-ID: <ag6AB0v9am5pNoLQ@linux.dev>
Mail-Followup-To: ltp@lists.linux.it
References: <20260521032759.18727-1-li.wang@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260521032759.18727-1-li.wang@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/2] lib: Introduce tst_path_defs.h to
 consolidate system paths
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Li Wang wrote:

...

> +/* KERNEL */
> +#define PATH_KERNEL_HOSTNAME			"/proc/sys/kernel/hostname"
> +#define PATH_KERNEL_OSRELEASE			"/proc/sys/kernel/osrelease"
> +#define PATH_KERNEL_VERSION			"/proc/sys/kernel/version"
> +#define PATH_KERNEL_DOMAINNAME			"/proc/sys/kernel/domainname"
> +#define PATH_KERNEL_PRINTK			"/proc/sys/kernel/printk"
> +#define PATH_KERNEL_PID_MAX			"/proc/sys/kernel/pid_max"
> +#define PATH_KERNEL_SHMMAX			"/proc/sys/kernel/shmmax"
> +#define PATH_KERNEL_SHMMNI			"/proc/sys/kernel/shmmni"
> +#define PATH_KERNEL_SHMALL			"/proc/sys/kernel/shmall"
> +#define PATH_KERNEL_SHM_NEXT_ID			"/proc/sys/kernel/shm_next_id"
> +#define PATH_KERNEL_MSGMNI			"/proc/sys/kernel/msgmni"
> +#define PATH_KERNEL_MSG_NEXT_ID			"/proc/sys/kernel/msg_next_id"
> +#define PATH_KERNEL_SEM				"/proc/sys/kernel/sem"
> +#define PATH_KERNEL_CORE_PATTERN		"/proc/sys/kernel/core_pattern"
> +#define PATH_KERNEL_CAP_LAST_CAP		"/proc/sys/kernel/cap_last_cap"
> +#define PATH_KERNEL_NUMA_BALANCING		"/proc/sys/kernel/numa_balancing"
> +#define PATH_KERNEL_IO_URING_DISABLED		"/proc/sys/kernel/io_uring_disabled"
> +#define PATH_KERNEL_OVERFLOWUID			"/proc/sys/kernel/overflowuid"
> +#define PATH_KERNEL_OVERFLOWGID			"/proc/sys/kernel/overflowgid"
> +#define PATH_KERNEL_PERF_EVENT_PARANOID		"/proc/sys/kernel/perf_event_paranoid"
> +#define PATH_KERNEL_PERF_EVENT_MLOCK_KB		"/proc/sys/kernel/perf_event_mlock_kb"
> +#define PATH_KERNEL_PERF_EVENT_MAX_SAMPLE_RATE	"/proc/sys/kernel/perf_event_max_sample_rate"
> +#define PATH_KERNEL_SCHED_RT_PERIOD_US		"/proc/sys/kernel/sched_rt_period_us"
> +#define PATH_KERNEL_SCHED_RT_RUNTIME_US		"/proc/sys/kernel/sched_rt_runtime_us"
> +#define PATH_KERNEL_SCHED_RR_TIMESLICE_MS	"/proc/sys/kernel/sched_rr_timeslice_ms"
> +#define PATH_KERNEL_UNPRIVILEGED_USERNS_CLONE	"/proc/sys/kernel/unprivileged_userns_clone"

And, we could shorten those with PATH_KERN_* if people thinks
the marco string is too long.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
