Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89242C5DF85
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 16:14:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C50BA3CB738
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 18:13:59 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E1A983C56FF
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 18:13:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DE31420092D
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 18:13:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 49F3384C04;
 Wed, 19 Aug 2026 16:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787156017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9U0hWNgGP/m2SCThWYyrQnsKJR2ne1cvXesNPWZqW+Q=;
 b=zSPvsmyj2gYxKS0c0xKVVzX+P4G6UGIQHphtiSBxcDLEAKRV3/Rl1NiqjnvlcJxm3R1xwQ
 QZ7Pzp5BiPdjHXNEIJlrqv56dvvOEj3dqxjlWf4+Z6rPnFdVFrey6ef8bxCr4yTIab1lEx
 eb8Wv5P9frfqHsXJHwLV7RtUqR6m1s0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787156017;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9U0hWNgGP/m2SCThWYyrQnsKJR2ne1cvXesNPWZqW+Q=;
 b=/hW1ZE37hqP31DV58herUaS62rzOWZ8o5Zbng6l7qy9fugPoZjThmGgGUH9nkSFFxYV2Ej
 1krR8o39b/LWtvDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787156013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9U0hWNgGP/m2SCThWYyrQnsKJR2ne1cvXesNPWZqW+Q=;
 b=HrDe0jZPd9ejXFjs3kpimbNA2tbEUJ9+bAOo3z45yzdzIGx/4/RDeSsLno2FgV1E1IA6bm
 FOzxHydlxR6CrmGGz+3CeHW3Gtd6D/ntQQ6jY0LbhlVAyN/4SwUVXGOc0D/cbkcfS4y8V8
 md3dV3vS7XIqYj4o7nmfdnYYymj1Hy8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787156013;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9U0hWNgGP/m2SCThWYyrQnsKJR2ne1cvXesNPWZqW+Q=;
 b=gZlu3oe6Vp8jV6y7YXHZHfy3gH07M7HNRFlvT5RFb8n7GQHQW6+4q57jnSA5a+xdfvLO8G
 iBhVpckQ1dg1eGAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3527F2F81;
 Wed, 19 Aug 2026 16:13:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WkwPDC3WhWq7bwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 19 Aug 2026 16:13:33 +0000
Date: Wed, 19 Aug 2026 18:13:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: linuxtestproject.agent@gmail.com
Message-ID: <aoXWKZtN_Ei2xkxb@yuki.lan>
References: <20260818141311.1265557-4-chrubis@suse.cz>
 <20260818145413.9648-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260818145413.9648-1-linuxtestproject.agent@gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.980]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[gmail.com]; RCPT_COUNT_TWO(0.00)[2];
 TAGGED_RCPT(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
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

Hi!
> > [PATCH 01/31] lib: Add tst_sysfs_assert
> 
> Most commit bodies in patches 1-20 and 25-31 only restate what the subject
> already says. Could they explain why the coverage or API is needed?

I do not think that this is really needed. This information is in the
top level comment of each test. I do not see a reason to copy&paste it
into the commit description.

> Patch 1 also has the typo "testscases", and the subjects of patches 14
> and 15 do not say that a test is being added.

Will fix.

> --- [PATCH 1/31] ---
> 
> > 	size = read_file(path, buf, sizeof(buf));
> > 	...
> > 	map = SAFE_CALLOC(max_id / 8 + 1, 1);
> > 	size = read_file(path, buf, sizeof(buf));
> > 	...
> > 	return parse_list(path, buf, size, count, max_id, map);
> 
> Could the list be read once, or could parse_list() receive and enforce the
> allocated bitmap size? A dynamic list such as CPU online can gain a higher
> ID between these reads, after which parse_list() writes beyond map.

CPU hotplug during the testrun would break the assertions we have either
way. It must not happen when the test is running.

> --- [PATCH 6/31] ---
> 
> > 	TST_SYSFS_ASSERT_PARSE_LIST(&count, &max_id, SYS_CPU "/online");
> > 	...
> > 	while (fgets(line, sizeof(line), f)) {
> > 		if (sscanf(line, "cpu%u ", &cpu) == 1)
> > 			cpu_count++;
> > 	}
> 
> Could this retry unless the online list is stable around the /proc/stat
> read? CPU hotplug between these independent snapshots produces different
> counts even when both interfaces are correct.

Again, CPU hotplug must not happen during the testrun.

> --- [PATCH 7/31] ---
> 
> > 	snprintf(sub, sizeof(sub),
> > 		 SYS_CPU "/cpu%d/topology/package_cpus_list", cpu);
> > 	TST_SYSFS_ASSERT_LIST_SUBSET(sub, SYS_CPU "/online");
> 
> Could package_cpus_list be compared with possible/present instead? Topology
> sibling masks can contain offline CPUs, so normal CPU hotplug makes this
> assertion fail.

Right, "present" should be better here.

> > 	for (cpu = 0; cpu <= max_id; cpu++)
> > 		check_cpu_topology(cpu, poss_max_id);
> 
> Could this iterate the parsed online mask rather than every ID through its
> maximum? CPU IDs can have offline holes.

I do not see a reason, we properly skip the checks in
check_cpu_topology() if the .../cpu%d/toplogy/ does not exist.

> > 	TST_SYSFS_ASSERT_RANGELL(0, poss_max_id,
> > 			       SYS_CPU "/cpu%d/topology/physical_package_id",
> > 			       cpu);
> 
> Could this accept -1? The generic topology implementation exports that
> sentinel when an architecture does not provide a physical package ID.

Sure, will fix.

> --- [PATCH 9/31] ---
> 
> > static const char *const control_allowed[] = {
> > 	"on", "off", "forceoff", "notsupported", "notimplemented", NULL
> > };
> 
> Could this also parse the numeric control form? Linux 7.2 returns the active
> thread count as a decimal value when partial SMT is enabled.

Fixed as well.

> --- [PATCH 11/31] ---
> 
> > 	while ((ent = SAFE_READDIR(d))) {
> > 		if (strncmp(ent->d_name, "clockevent", 10))
> > 			continue;
> >
> > 		nclockevents++;
> > 		check_clockevent(ent->d_name);
> > 	}
> > 	...
> > 	if (nclockevents <= online_count) {
> 
> Could this validate only clockevent entries for online CPUs? Linux 7.2
> registers clockeventN for every possible CPU, and current_device can be empty
> for an offline CPU. Counting all entries against online CPUs therefore fails
> on systems with offline CPUs.

Fixed.

> --- [PATCH 12/31] ---
> 
> > 	d = SAFE_OPENDIR(ATA);
> 
> Could the class directory be checked before SAFE_OPENDIR()? Without libata,
> its absence currently produces TBROK rather than the documented TCONF.
> 
> The same ordering appears for /sys/class/hwmon in patch 14,
> /sys/class/leds in patch 15, /sys/class/wakeup in patch 16,
> /sys/class/rtc in patch 17, and /sys/class/thermal in patch 18. Could those
> also return TCONF when the corresponding class is unavailable?

Fixed.

> --- [PATCH 13/31] ---
> 
> > 	min_bytes = TST_SYSFS_READ_LI(BDI "/%s/min_bytes", name);
> > 	max_bytes = TST_SYSFS_READ_LI(BDI "/%s/max_bytes", name);
> 
> Could these use an unsigned 64-bit parser? Linux 7.2 exports both attributes
> as u64, so valid values above LONG_MAX are rejected or misparsed, especially
> on 32-bit systems.

I'm looking at path 13/31 and this code is not even there.

There is only:

>       max_bytes = TST_SYSFS_READ_LI(BDI_CLASS "/%s/max_bytes", id);

I guess that this is a hallucination. I can make the max_bytes 64bit
though.

> --- [PATCH 14/31] ---
> 
> > 	TST_SYSFS_ASSERT_RANGELL(0, 1000000, HWMON "/%s/temp%d_input",
> > 			       hwmon, nr);
> > 	...
> > 	if (min > max)
> > 		tst_res(TFAIL, "temp%d_min (%ld) > temp%d_max (%ld)",
> > 			nr, min, nr, max);
> 
> What kernel ABI guarantees these plausibility ranges and threshold
> orderings? Hwmon values and writable thresholds are device-specific, and
> the kernel does not enforce these policies. Valid hardware or configuration
> can therefore fail the test.

Fair enough, I've dropped these checks.

> --- [PATCH 16/31] ---
> 
> > 		TST_SYSFS_ASSERT_RANGELL(0, LONG_MAX, WAKEUP "/%s/%s",
> > 				       name, counters[i]);
> 
> Could these counters use an unsigned-long parser? Linux 7.2 exports them with
> "%lu", so a valid counter above LONG_MAX false-fails on 32-bit systems.

I've switched the helpers to long long, that allows us to pass ULONG_MAX
limits where needed.

And also added TST_SYSFS_ASSERT_RANGEUU() that works with unsigned long
long.

> --- [PATCH 17/31] ---
> 
> > 	if (hctosys)
> > 		check_system_time(rtc);
> > 	...
> > 	if (!hctosys_found)
> > 		check_system_time("rtc0");
> 
> Could this comparison be removed or made informational? hctosys only records
> that an RTC initialized system time at boot. NTP can subsequently correct
> system time without updating the RTC, and rtc0 is not implicitly
> synchronized when no hctosys attribute is set.

This is all described in the test comment. I've decided to keep the
assertion even though NTP may adjust the time.

> > 	TST_SYSFS_READ_STR(date, sizeof(date), RTC "/%s/date", rtc);
> > 	TST_SYSFS_READ_STR(time, sizeof(time), RTC "/%s/time", rtc);
> 
> Could this use RTC_RD_TIME or verify matching date reads around the time
> read? A midnight rollover between these files combines the previous date
> with the next day's time and creates a false failure of about 24 hours.

I've added a retry if the rollover is detected.

> --- [PATCH 19/31] ---
> 
> > /*
> >  * Change the link-layer (MAC) address of an existing network device. Most
> >  * drivers require the device to be administratively down for this to
> >  * succeed.
> >  */
> > int tst_netdev_set_hwaddr(const char *file, const int lineno, int strict,
> > 	const char *ifname, const void *addr, size_t addrlen);
> 
> Could the two new public APIs and their macros use kernel-doc, including
> parameter documentation, so they are included in the generated C API
> reference?

The file is not included in documentation and there are no doc comments,
so I decided not to add them.

> --- [PATCH 20/31] ---
> 
> >  * - carrier is a boolean (0 or 1) when readable
> >  *
> >  * carrier returns an error (EINVAL) when the interface is administratively
> >  * down, which the test tolerates.
> 
> Could the promised carrier check be implemented, or could this claim be
> removed? check_iface() currently validates only type, MTU, addr_len, address,
> and operstate.

I've removed the stale comment.

> --- [PATCH 23/31] ---
> 
> > 	SAFE_CLOSE(fd);
> > 	read_state(state);
> > 	assert_state("down", 0, 0, state);
> > 	...
> > 	fd = open_tun();
> > 	read_state(state);
> > 	assert_state("up", 1, 1, state);
> 
> Could this poll for the expected operstate with a timeout? TUN updates
> carrier synchronously, but netdev_state_change() schedules operstate updates
> through linkwatch. These immediate reads can still observe the previous
> operstate.

This was reported by Li as well, fixed.

> --- [PATCH 24/31] ---
> 
> > 	if (attached) {
> > 		tst_res(TINFO, "Autoclear did not detach the loop device");
> > 		tst_detach_device(loopdev);
> > 		attached = 0;
> > 	}
> 
> Could attached be cleared only when the fallback detach succeeds? If
> tst_detach_device() fails, cleanup() skips the device and the system-wide
> loop attachment is leaked.

This snippet is not present in the patchset. Looks like another
halucination.

> --- [PATCH 25/31] ---
> 
> > 	TST_SYSFS_ASSERT_RANGELL(0, LONG_MAX,
> > 			       QUEUE "/%s/discard_max_bytes", dev);
> 
> Could discard_max_bytes use an unsigned 64-bit parser and range? The block
> queue ABI exports an unsigned 64-bit byte count, which can exceed LONG_MAX
> on 32-bit systems.

Fixed.

> > static const char *const schedulers[] = {
> > 	"none", "mq-deadline", "kyber", "bfq", NULL
> > };
> 
> Could the scheduler check validate only the bracketed single-selection
> format? Elevators are registered dynamically, so vendor or future scheduler
> names outside this fixed list are valid.

It is expected that we will have to add new elevators into the list as
they are added into the kernel. If that proves to be a big hassle, we
will remove the array.

> --- [PATCH 26/31] ---
> 
> > 	if (sscanf(line, "%u %u %*u %*s", &proc_major, &proc_minor) != 4)
> > 		continue;
> 
> Could this compare the return value with 2? Assignment-suppressed conversions
> do not count, so every valid /proc/partitions line is currently skipped and
> the size comparison never runs.

Fixed.

> --- [PATCH 27/31] ---
> 
> > 	nr = TST_SYSFS_READ_LI(HUGEPAGES "/%s/nr_hugepages", name);
> > 	free = TST_SYSFS_READ_LI(HUGEPAGES "/%s/free_hugepages", name);
> > 	resv = TST_SYSFS_READ_LI(HUGEPAGES "/%s/resv_hugepages", name);
> > 	surp = TST_SYSFS_READ_LI(HUGEPAGES "/%s/surplus_hugepages", name);
> 
> Could these checks retry unless surrounding pool counters are stable?
> Allocation, reservation, or pool resizing between the separate reads can
> violate the asserted relationships even though every individual kernel
> snapshot is consistent.

The rest of LTP tests expect that hugepage pools are not manipulated
during their run.

> --- [PATCH 28/31] ---
> 
> > 	proc_val = tst_read_meminfo(proc_name);
> > 	sys_val = TST_SYSFS_READ_LI(HUGEPAGES "/%s", sys_name);
> > 	TST_EXP_EQ_LI(proc_val, sys_val);
> 
> Could this compare stable snapshots or retry on a concurrent change?
> Hugepage allocation, reservation, and pool resizing can occur between the
> /proc and sysfs reads, producing a false mismatch.

Here as well.

> --- [PATCH 29/31] ---
> 
> > 	for (i = 0; i < ARRAY_SIZE(nonneg_counters); i++) {
> > 		TST_SYSFS_ASSERT_RANGELL(0, LONG_MAX, KSM "/%s",
> > 				       nonneg_counters[i]);
> > 	}
> 
> Could pages_to_scan and the page counters use parsers matching their unsigned
> kernel types? Linux 7.2 exports pages_to_scan as unsigned int and the counters
> as unsigned long, so valid values above LONG_MAX false-fail on 32-bit systems.

Fixed.

> --- [PATCH 30/31] ---
> 
> > +sys_swap01 sys_swap01
> 
> > +++ b/testcases/kernel/sysfs/kernel/mm/swap/sys_mm_swap01.c
> 
> Could the source/binary and runtest names be made consistent? This builds
> sys_mm_swap01, while runtest invokes the nonexistent sys_swap01.

Fixed.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
