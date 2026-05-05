Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55128CD342C
	for <ltp@archiver.kernel.org>; Tue,  5 May 2026 03:05:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E84F3E6B49
	for <ltp@archiver.kernel.org>; Tue,  5 May 2026 05:05:09 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2A0613E4991
 for <ltp@lists.linux.it>; Tue,  5 May 2026 05:04:50 +0200 (CEST)
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com
 [91.218.175.189])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5CE19200756
 for <ltp@lists.linux.it>; Tue,  5 May 2026 05:04:50 +0200 (CEST)
Date: Tue, 5 May 2026 11:04:38 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1777950289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F9AcS0C9su8ekcVi/2VwM8bfDXd1v1bxZO4WOthAi6I=;
 b=QX5oFD0PqQlJ3p2rCMK2t1Fz7AWUmx2Sw+ZfW8sGvETb1RTphG2rtXEvMFbR4zdTSobJud
 3H7pul1zdakkmUWzsLMd22f0tGO1kiadAtahbBQ5jtpaka2SwV+X5KFPg2RlgKfBQ3pxzI
 yMECWMKQ57TGj2UC/0NkCaZAH+TgRKQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <aflePEoKwEB_oad6@linux.dev>
Mail-Followup-To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <20260501135100.42278-1-li.wang@linux.dev>
 <20260504133020.14129-1-li.wang@linux.dev>
 <afi3Ml5vFv2irnc0@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <afi3Ml5vFv2irnc0@yuki.lan>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib: Introduce tst_path.h to consolidate
 system paths
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

Cyril Hrubis wrote:

> > @@ -25,8 +25,8 @@ static struct tst_test test = {
> >  	.setup = setup,
> >  	.save_restore = (const struct tst_path_val[]) {
> >  		{"/proc/nonexistent", NULL, TST_SR_SKIP},
> > -		{"/proc/sys/kernel/numa_balancing", NULL, TST_SR_TBROK},
> > -		{"/proc/sys/kernel/core_pattern", NULL, TST_SR_TCONF},
> > +		{PROC_SYS_KERNEL "numa_balancing", NULL, TST_SR_TBROK},
> > +		{PROC_SYS_KERNEL "core_pattern", NULL, TST_SR_TCONF},
> 
> This is exactly what I'm unsure about, it's not shorter, nor more
> readable.
> 
> Maybe if this was PATH_NUMA_BALANCING and PATH_CORE_PATTERN it would be
> shorter and would make much more sense.

v3-A version:

Yes, that ways would be simpler. Then we will finally get v3-A as below:

  /* KERNEL */
  #define PATH_HOSTNAME			"/proc/sys/kernel/hostname"
  #define PATH_OSRELEASE		"/proc/sys/kernel/osrelease"
  #define PATH_VERSION			"/proc/sys/kernel/version"
  #define PATH_DOMAINNAME		"/proc/sys/kernel/domainname"
  #define PATH_PRINTK			"/proc/sys/kernel/printk"
  #define PATH_PID_MAX			"/proc/sys/kernel/pid_max"
  #define PATH_SHMMAX			"/proc/sys/kernel/shmmax"
  #define PATH_SHMMNI			"/proc/sys/kernel/shmmni"
  #define PATH_SHMALL			"/proc/sys/kernel/shmall"
  #define PATH_MSGMNI			"/proc/sys/kernel/msgmni"
  #define PATH_SHM_NEXT_ID		"/proc/sys/kernel/shm_next_id"
  #define PATH_MSG_NEXT_ID		"/proc/sys/kernel/msg_next_id"
  #define PATH_SEM			"/proc/sys/kernel/sem"
  #define PATH_CORE_PATTERN		"/proc/sys/kernel/core_pattern"
  #define PATH_CAP_LAST_CAP		"/proc/sys/kernel/cap_last_cap"
  #define PATH_NUMA_BALANCING		"/proc/sys/kernel/numa_balancing"
  #define PATH_IO_URING_DISABLED	"/proc/sys/kernel/io_uring_disabled"
  #define PATH_OVERFLOWUID		"/proc/sys/kernel/overflowuid"
  #define PATH_OVERFLOWGID		"/proc/sys/kernel/overflowgid"
  #define PATH_PERF_EVENT_PARANOID	"/proc/sys/kernel/perf_event_paranoid"
  #define PATH_PERF_EVENT_MLOCK_KB	"/proc/sys/kernel/perf_event_mlock_kb"
  #define PATH_PERF_EVENT_MAX_SAMPLE_RATE	"/proc/sys/kernel/perf_event_max_sample_rate"
  #define PATH_SCHED_RT_PERIOD_US		"/proc/sys/kernel/sched_rt_period_us"
  #define PATH_SCHED_RT_RUNTIME_US	"/proc/sys/kernel/sched_rt_runtime_us"
  #define PATH_SCHED_RR_TIMESLICE_MS	"/proc/sys/kernel/sched_rr_timeslice_ms"
  #define PATH_UNPRIVILEGED_USERNS_CLONE	"/proc/sys/kernel/unprivileged_userns_clone"
  
  /* USER */
  #define PATH_MAX_USER_NAMESPACES	"/proc/sys/user/max_user_namespaces"
  
  /* FS */
  #define PATH_FS_PIPE_MAX_SIZE		"/proc/sys/fs/pipe-max-size"
  #define PATH_FS_PIPE_MAX_PAGES	"/proc/sys/fs/pipe-max-pages"
  
  /* VM */
  #define PATH_VM_NR_HPAGES		"/proc/sys/vm/nr_hugepages"
  #define PATH_VM_OVERCOMMIT_HPAGES	"/proc/sys/vm/nr_overcommit_hugepages"
  #define PATH_VM_DROP_CACHES		"/proc/sys/vm/drop_caches"
  #define PATH_VM_COMPACT_MEMORY	"/proc/sys/vm/compact_memory"
  #define PATH_VM_VFS_CACHE_PRESSURE	"/proc/sys/vm/vfs_cache_pressure"
  #define PATH_VM_OVERCOMMIT_MEMORY	"/proc/sys/vm/overcommit_memory"
  
  /* HUGETLB */
  #define PATH_MM_HUGEPAGES	"/sys/kernel/mm/hugepages/"
  #define PATH_MM_THP		"/sys/kernel/mm/transparent_hugepage/"
  
  /* KSM */
  #define PATH_MM_KSM		"/sys/kernel/mm/ksm/"
  #define MM_KSM_FP(s)		(PATH_MM_KSM s)
  
  /* NETWORK */
  #define PATH_NET_IPV4		"/proc/sys/net/ipv4/"
  #define NET_IPV4_FP(s)	(PATH_NET_IPV4 s)
  
  /* MEMINFO */
  #define MEMINFO_HPAGE_TOTAL	"HugePages_Total:"
  #define MEMINFO_HPAGE_FREE	"HugePages_Free:"
  #define MEMINFO_HPAGE_RSVD	"HugePages_Rsvd:"
  #define MEMINFO_HPAGE_SURP	"HugePages_Surp:"
  #define MEMINFO_HPAGE_SIZE	"Hugepagesize:"


> Shortening this to SYS_KERNEL("numa_balancing") would be confusing since
> we have both /proc/sys/ and /sys/

v3-B version:

After looking through all the LTP frequently used knobs (shown above),
I found that '/sys/kernel/' is not quite often used like '/proc/sys/kernel',
so basically we only need to handle the /proc one.

thus, maybe define PROC_KER_FP() or PROC_SYS_KERNEL_FP() instead of
list many KERNEL files in tst_path.h:

  /* KERNEL */
  #define PROC_KER_FP(s)		("/proc/sys/kernel/" s)
  
  /* USER */
  #define PROC_USER_FP(s)		("/proc/sys/user/" s)

  ...

In testcase used like:

  PROC_KER_FP("pid_max");
  PROC_KER_FP("shmmni");
  PROC_KER_FP("perf_event_mlock_kb");
  PROC_USER_FP("max_user_namespaces");


Which version (v3-A or v3-B) do you think is better?
Or any other suggestion?

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
