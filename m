Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A01C5DF7D
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 14:54:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3FBA93CCBC4
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 16:54:33 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 978FD3C9E30
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 16:54:17 +0200 (CEST)
Received: from mail-pj2-x0b.google.com (mail-pj2-x0b.google.com
 [IPv6:2607:f8b0:4864:39::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E923F6008A8
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 16:54:16 +0200 (CEST)
Received: by mail-pj2-x0b.google.com with SMTP id
 98e67ed59e1d1-39569e136f9so15091a91.0
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 07:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787064855; x=1787669655; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z0VvkdF4EN9HyqBUKgRBwNTUaliX7t65DSz8kV8PeNE=;
 b=rouFTERQwY/zaqO0PNJ1HcLfYDs7LPc8724UTviSfhcc0nI+SxqjiKuKEi4Ncuni9F
 kD7pklaGZ28TM2svL2CeZlk0IvtjPHSZ+PEOCzEzdVR/3jKA0QMOwDeGq4oulcU9UJCA
 HWkwBGrGG0EGuQK+Mgs7oRZZk4WdNnjqy1EFIG2qF3ytwEoudkH1oqanzAvDueeow9xg
 2KNAHXhEDkjVQx1guE/Yt3HrGL7wSsajEm6blz+KScsfm3M+tnCwpZjg0UPCx9dHrrRf
 3tgdk/+JrcNZFIZe/LhkgLMNIfIHBPD0Z2z05uqZ5FdubNYOB0ojS60lMM1qpNkiMuXl
 9bKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787064855; x=1787669655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=z0VvkdF4EN9HyqBUKgRBwNTUaliX7t65DSz8kV8PeNE=;
 b=nfqEg7lu9DPAviU0Ggz85r/vIbjXS3E4DPvHoWpLpjcl8Kx4I1anEQSLnr+T2yiDyH
 KvOCQZrc7jC9b3jH5f7zjZzTzRmftTp+7VoK+XCf5Pd1y0rowVylw9vNHJTAT+9VGTYd
 njFMgLjVjxWrp5WxHxxbgzuyuxnYRG2juqU8cJqEP/5ZSQfbwv4UqvET9kr2S46WrX0q
 yPv8sMwLolzwJ68KIBLbW90SK6OcEIYHaM2az3F00Hc7R4X6lO9M8QTtcfR8F8KTh9eE
 4L+vEJY+YnxFWWjiwpzWYw1f1l5GIxYA5YXDS+LsnSULHrlF/PudO6egO+tbW3vxp/jT
 mwBw==
X-Gm-Message-State: AOJu0YwPZclMQbu1N14dd/uFFYkGg+B2JDPONpUh7SnzCpcGyI4Iz9ld
 A45hUUBJOkM/Jvo0uaZY+RBfVf8wrSfOFkRx5HgFOUGpg2z90WcyhK/d
X-Gm-Gg: AR+sD13kaOB1LFROrQYj0nG26D1pLRxHw7euTK3V70eebvUnQqDIUdNaqQYRtNhGYbw
 iMTV3MYeMHEDxroPpAAorUsdDvJF74FQM2fe8ECqcxiF9xWqdFl3fxKQh1j09UmHUlmTbJ6xIWw
 K20j1mADR6c88JsK/q2STykUYKc+xbr0wPKBm73PRbA2hhkDr8JqzfAAikzO8JGVGmKUGNuVlF3
 Tes1lIRZ3wFclucdQv6f9K1ooo8HlCm2UNUrPIHsH1Wb1s+yFjgPMTeOAGtejMnKWf8QBtf1799
 xzfG+F72Cb90OEKoB87gfiNH0OHXibn9WF2YKou/KZk6hQtM8R1LrDiheFtd3h75MMOwH0ZNyfE
 zLrNeRVJVSfNIcRld0W9njJc6tME6OjjIwgnRO7hQ3NPYcPLu8oMJ076XB3ue4MOOCkW1VyI4t2
 N7qCOh2k4I206IvEani4SMUE+1O5bxgD7VjA+wO6S6BbQ5KPKd+/fWPuGgS4Cw7jK5kmCSpk864
 TMth0Uc3Du8KrLQ3pk+E2tc7UbE6FNQiVBjEfAYQzqfO9pVkcYlpsXi1LPP5SS3CZz8d2hKrnY9
X-Received: by 2002:a17:90b:5291:b0:36a:5d1f:7b6 with SMTP id
 98e67ed59e1d1-3933bd18849mr38173751a91.2.1787064854967; 
 Tue, 18 Aug 2026 07:54:14 -0700 (PDT)
Received: from
 runnervmzvulz.f4rgwzscpswufdztdepgljvvtb.xx.internal.cloudapp.net
 ([20.64.204.250]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3954d2e64dbsm6175858a91.8.2026.08.18.07.54.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 07:54:14 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 18 Aug 2026 14:54:13 +0000
Message-ID: <20260818145413.9648-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818141311.1265557-4-chrubis@suse.cz>
References: <20260818141311.1265557-4-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Add tst_sysfs_assert
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

Hi Cyril,

On Tue, 18 Aug 2026 16:12:41 +0200, Cyril Hrubis wrote:
> [PATCH 01/31] lib: Add tst_sysfs_assert

Most commit bodies in patches 1-20 and 25-31 only restate what the subject
already says. Could they explain why the coverage or API is needed? Patch 1
also has the typo "testscases", and the subjects of patches 14 and 15 do not
say that a test is being added.

--- [PATCH 1/31] ---

> 	size = read_file(path, buf, sizeof(buf));
> 	...
> 	map = SAFE_CALLOC(max_id / 8 + 1, 1);
> 	size = read_file(path, buf, sizeof(buf));
> 	...
> 	return parse_list(path, buf, size, count, max_id, map);

Could the list be read once, or could parse_list() receive and enforce the
allocated bitmap size? A dynamic list such as CPU online can gain a higher
ID between these reads, after which parse_list() writes beyond map.

--- [PATCH 6/31] ---

> 	TST_SYSFS_ASSERT_PARSE_LIST(&count, &max_id, SYS_CPU "/online");
> 	...
> 	while (fgets(line, sizeof(line), f)) {
> 		if (sscanf(line, "cpu%u ", &cpu) == 1)
> 			cpu_count++;
> 	}

Could this retry unless the online list is stable around the /proc/stat
read? CPU hotplug between these independent snapshots produces different
counts even when both interfaces are correct.

--- [PATCH 7/31] ---

> 	snprintf(sub, sizeof(sub),
> 		 SYS_CPU "/cpu%d/topology/package_cpus_list", cpu);
> 	TST_SYSFS_ASSERT_LIST_SUBSET(sub, SYS_CPU "/online");

Could package_cpus_list be compared with possible/present instead? Topology
sibling masks can contain offline CPUs, so normal CPU hotplug makes this
assertion fail.

> 	for (cpu = 0; cpu <= max_id; cpu++)
> 		check_cpu_topology(cpu, poss_max_id);

Could this iterate the parsed online mask rather than every ID through its
maximum? CPU IDs can have offline holes.

> 	TST_SYSFS_ASSERT_RANGELL(0, poss_max_id,
> 			       SYS_CPU "/cpu%d/topology/physical_package_id",
> 			       cpu);

Could this accept -1? The generic topology implementation exports that
sentinel when an architecture does not provide a physical package ID.

--- [PATCH 9/31] ---

> static const char *const control_allowed[] = {
> 	"on", "off", "forceoff", "notsupported", "notimplemented", NULL
> };

Could this also parse the numeric control form? Linux 7.2 returns the active
thread count as a decimal value when partial SMT is enabled.

--- [PATCH 11/31] ---

> 	while ((ent = SAFE_READDIR(d))) {
> 		if (strncmp(ent->d_name, "clockevent", 10))
> 			continue;
>
> 		nclockevents++;
> 		check_clockevent(ent->d_name);
> 	}
> 	...
> 	if (nclockevents <= online_count) {

Could this validate only clockevent entries for online CPUs? Linux 7.2
registers clockeventN for every possible CPU, and current_device can be empty
for an offline CPU. Counting all entries against online CPUs therefore fails
on systems with offline CPUs.

--- [PATCH 12/31] ---

> 	d = SAFE_OPENDIR(ATA);

Could the class directory be checked before SAFE_OPENDIR()? Without libata,
its absence currently produces TBROK rather than the documented TCONF.

The same ordering appears for /sys/class/hwmon in patch 14,
/sys/class/leds in patch 15, /sys/class/wakeup in patch 16,
/sys/class/rtc in patch 17, and /sys/class/thermal in patch 18. Could those
also return TCONF when the corresponding class is unavailable?

--- [PATCH 13/31] ---

> 	min_bytes = TST_SYSFS_READ_LI(BDI "/%s/min_bytes", name);
> 	max_bytes = TST_SYSFS_READ_LI(BDI "/%s/max_bytes", name);

Could these use an unsigned 64-bit parser? Linux 7.2 exports both attributes
as u64, so valid values above LONG_MAX are rejected or misparsed, especially
on 32-bit systems.

--- [PATCH 14/31] ---

> 	TST_SYSFS_ASSERT_RANGELL(0, 1000000, HWMON "/%s/temp%d_input",
> 			       hwmon, nr);
> 	...
> 	if (min > max)
> 		tst_res(TFAIL, "temp%d_min (%ld) > temp%d_max (%ld)",
> 			nr, min, nr, max);

What kernel ABI guarantees these plausibility ranges and threshold
orderings? Hwmon values and writable thresholds are device-specific, and
the kernel does not enforce these policies. Valid hardware or configuration
can therefore fail the test.

--- [PATCH 16/31] ---

> 		TST_SYSFS_ASSERT_RANGELL(0, LONG_MAX, WAKEUP "/%s/%s",
> 				       name, counters[i]);

Could these counters use an unsigned-long parser? Linux 7.2 exports them with
"%lu", so a valid counter above LONG_MAX false-fails on 32-bit systems.

--- [PATCH 17/31] ---

> 	if (hctosys)
> 		check_system_time(rtc);
> 	...
> 	if (!hctosys_found)
> 		check_system_time("rtc0");

Could this comparison be removed or made informational? hctosys only records
that an RTC initialized system time at boot. NTP can subsequently correct
system time without updating the RTC, and rtc0 is not implicitly
synchronized when no hctosys attribute is set.

> 	TST_SYSFS_READ_STR(date, sizeof(date), RTC "/%s/date", rtc);
> 	TST_SYSFS_READ_STR(time, sizeof(time), RTC "/%s/time", rtc);

Could this use RTC_RD_TIME or verify matching date reads around the time
read? A midnight rollover between these files combines the previous date
with the next day's time and creates a false failure of about 24 hours.

--- [PATCH 19/31] ---

> /*
>  * Change the link-layer (MAC) address of an existing network device. Most
>  * drivers require the device to be administratively down for this to
>  * succeed.
>  */
> int tst_netdev_set_hwaddr(const char *file, const int lineno, int strict,
> 	const char *ifname, const void *addr, size_t addrlen);

Could the two new public APIs and their macros use kernel-doc, including
parameter documentation, so they are included in the generated C API
reference?

--- [PATCH 20/31] ---

>  * - carrier is a boolean (0 or 1) when readable
>  *
>  * carrier returns an error (EINVAL) when the interface is administratively
>  * down, which the test tolerates.

Could the promised carrier check be implemented, or could this claim be
removed? check_iface() currently validates only type, MTU, addr_len, address,
and operstate.

--- [PATCH 23/31] ---

> 	SAFE_CLOSE(fd);
> 	read_state(state);
> 	assert_state("down", 0, 0, state);
> 	...
> 	fd = open_tun();
> 	read_state(state);
> 	assert_state("up", 1, 1, state);

Could this poll for the expected operstate with a timeout? TUN updates
carrier synchronously, but netdev_state_change() schedules operstate updates
through linkwatch. These immediate reads can still observe the previous
operstate.

--- [PATCH 24/31] ---

> 	if (attached) {
> 		tst_res(TINFO, "Autoclear did not detach the loop device");
> 		tst_detach_device(loopdev);
> 		attached = 0;
> 	}

Could attached be cleared only when the fallback detach succeeds? If
tst_detach_device() fails, cleanup() skips the device and the system-wide
loop attachment is leaked.

--- [PATCH 25/31] ---

> 	TST_SYSFS_ASSERT_RANGELL(0, LONG_MAX,
> 			       QUEUE "/%s/discard_max_bytes", dev);

Could discard_max_bytes use an unsigned 64-bit parser and range? The block
queue ABI exports an unsigned 64-bit byte count, which can exceed LONG_MAX
on 32-bit systems.

> static const char *const schedulers[] = {
> 	"none", "mq-deadline", "kyber", "bfq", NULL
> };

Could the scheduler check validate only the bracketed single-selection
format? Elevators are registered dynamically, so vendor or future scheduler
names outside this fixed list are valid.

--- [PATCH 26/31] ---

> 	if (sscanf(line, "%u %u %*u %*s", &proc_major, &proc_minor) != 4)
> 		continue;

Could this compare the return value with 2? Assignment-suppressed conversions
do not count, so every valid /proc/partitions line is currently skipped and
the size comparison never runs.

--- [PATCH 27/31] ---

> 	nr = TST_SYSFS_READ_LI(HUGEPAGES "/%s/nr_hugepages", name);
> 	free = TST_SYSFS_READ_LI(HUGEPAGES "/%s/free_hugepages", name);
> 	resv = TST_SYSFS_READ_LI(HUGEPAGES "/%s/resv_hugepages", name);
> 	surp = TST_SYSFS_READ_LI(HUGEPAGES "/%s/surplus_hugepages", name);

Could these checks retry unless surrounding pool counters are stable?
Allocation, reservation, or pool resizing between the separate reads can
violate the asserted relationships even though every individual kernel
snapshot is consistent.

--- [PATCH 28/31] ---

> 	proc_val = tst_read_meminfo(proc_name);
> 	sys_val = TST_SYSFS_READ_LI(HUGEPAGES "/%s", sys_name);
> 	TST_EXP_EQ_LI(proc_val, sys_val);

Could this compare stable snapshots or retry on a concurrent change?
Hugepage allocation, reservation, and pool resizing can occur between the
/proc and sysfs reads, producing a false mismatch.

--- [PATCH 29/31] ---

> 	for (i = 0; i < ARRAY_SIZE(nonneg_counters); i++) {
> 		TST_SYSFS_ASSERT_RANGELL(0, LONG_MAX, KSM "/%s",
> 				       nonneg_counters[i]);
> 	}

Could pages_to_scan and the page counters use parsers matching their unsigned
kernel types? Linux 7.2 exports pages_to_scan as unsigned int and the counters
as unsigned long, so valid values above LONG_MAX false-fail on 32-bit systems.

--- [PATCH 30/31] ---

> +sys_swap01 sys_swap01

> +++ b/testcases/kernel/sysfs/kernel/mm/swap/sys_mm_swap01.c

Could the source/binary and runtest names be made consistent? This builds
sys_mm_swap01, while runtest invokes the nonexistent sys_swap01.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
