Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC59606A330
	for <ltp@archiver.kernel.org>; Fri, 27 Nov 2026 11:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=oehTCN36;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Kavzguu2;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=sOazH1lT;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tl8NtlM1
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B88153EA8CB
	for <ltp@archiver.kernel.org>; Fri, 27 Nov 2026 12:02:23 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 06E003C0EC7
 for <ltp@lists.linux.it>; Fri, 27 Nov 2026 12:02:06 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 574E76008AE
 for <ltp@lists.linux.it>; Fri, 27 Nov 2026 12:02:05 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EE3911FB22;
 Fri, 27 Nov 2026 11:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1795777324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hHwct+xkVc6R1HIhxs1UVnq9CtIqyPxHemQlHiFz5Zs=;
 b=oehTCN36zaLlO9Vt2elU1B8wQpsE46Vq0KqXFYLoDtvw658vmSVw7Ycj3z7Y8dU/5E5fI1
 hZmeetcRACpyyFnePHKQjI0fW5wnbN4f8evm4L0GER/kQq7to7QflfW+JV6lJVzgsKVLLP
 x3UTW5Uo2GeWIz1swn0B3+yY8Xn0NA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1795777324;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hHwct+xkVc6R1HIhxs1UVnq9CtIqyPxHemQlHiFz5Zs=;
 b=Kavzguu2JctWZP5ffUg8k/3YoRP0N7/+NP/Wq6kpRTbh5yPwabpvYk4pbuUJfpv8Gwymen
 TgmlJ0fyRg6LR8Dg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sOazH1lT;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tl8NtlM1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1795777323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hHwct+xkVc6R1HIhxs1UVnq9CtIqyPxHemQlHiFz5Zs=;
 b=sOazH1lT+c7BUyiJskjrgBnFp6be6h6Rze/y2aMYtL8N03f+kmvHOJvdxb419rs+2RexyK
 sxDPu/fka/wtVZ9gKYxi0SsKMp62DmWNqmbzz2yISdu0poWGXygn+1EfH8BNeSqEwYLKCl
 E2LoqxpZZ6q79aW4cXxbyURF4+tDPys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1795777323;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hHwct+xkVc6R1HIhxs1UVnq9CtIqyPxHemQlHiFz5Zs=;
 b=tl8NtlM1u+aF9FyxdHS0Zg8HXFtf+Qu3vWyumB493B6htXpk8e3EJTFus/42grEc2O53WR
 +BcGPmFFhIpnS1Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC5D7134E8;
 Fri, 27 Nov 2026 11:02:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MewfJStjCWvFfAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 27 Nov 2026 11:02:03 +0000
Date: Fri, 27 Nov 2026 12:02:31 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Piotr Kubaj <piotr.kubaj@intel.com>
Message-ID: <awljR7i361DNAOS1@yuki.lan>
References: <20261021085932.20557-1-piotr.kubaj@intel.com>
 <20261021085932.20557-4-piotr.kubaj@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261021085932.20557-4-piotr.kubaj@intel.com>
X-Spamd-Result: default: False [-13.51 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.51
X-Spam-Level: 
X-Rspamd-Queue-Id: EE3911FB22
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 3/3] pmc_core: add ltr_counter test
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: daniel.niestepski@intel.com, tomasz.ossowski@intel.com,
 helena.anna.dubel@intel.com, rafael.j.wysocki@intel.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +/*
> + * Read the counter values, checking that the counter set itself has not changed
> + * since setup(). Only the values are of interest here - the format of the file
> + * is what the pkgc_ltr_blocker_show test covers - so anything unexpected about
> + * the lines makes this test unable to run rather than failing it.
> + */
> +static void read_counters(uint32_t *values)
> +{
> +	char line[256];
> +	FILE *fp;
> +	int n = 0;
> +
> +	fp = SAFE_FOPEN(PATH, "r");
> +
> +	while (fgets(line, sizeof(line), fp)) {
> +		char name[NAME_LEN];
> +		unsigned int value;
> +
> +		line[strcspn(line, "\n")] = '\0';

This shouldn't be needed here, the \n should be ingored since we ask for
%u at the end of the line here.

> +		if (n == MAX_COUNTERS)
> +			tst_brk(TBROK, "more than %d counters reported", MAX_COUNTERS);

This should be at the end of the loop just after n++, or we can even do:

		if (++n == MAX_COUNTERS)
			...
> +		if (sscanf(line, "%63s %u", name, &value) != 2)
> +			tst_brk(TBROK, "unexpected line format: '%s'", line);
> +
> +		values[n] = value;
> +
> +		if (cnt && strcmp(name, names[n])) {
> +			tst_brk(TBROK, "counter %d renamed during the test: %s -> %s",
> +				n, names[n], name);
> +		}
> +
> +		if (!cnt)
> +			strcpy(names[n], name);
> +
> +		n++;
> +	}
> +
> +	/*
> +	 * A telemetry read that fails in the driver aborts the seq_file read
> +	 * instead of ending it at EOF, so without this the counters lost to the
> +	 * error would look like counters that stopped advancing.
> +	 */
> +	if (ferror(fp))
> +		tst_brk(TBROK, "reading " PATH " failed after %d counters", n);
> +
> +	SAFE_FCLOSE(fp);
> +
> +	if (cnt && n != cnt)
> +		tst_brk(TBROK, "counter count changed during the test: %d -> %d", cnt, n);
> +
> +	cnt = n;
> +}
> +
> +static void spin(void)
> +{
> +	/* volatile so that the loop survives optimization */

This comment AFAIK states the obvious.

> +	for (;;)
> +		burn++;
> +}
> +
> +/*
> + * Keep every CPU the test may run on busy, so that the package cannot go idle
> + * and no package C-state entry can be attempted.
> + *
> + * The spinners are pinned one per CPU taken from the test's own affinity mask,
> + * rather than left to the load balancer, so that a CPU is not left idle by a
> + * scheduling decision. Offline CPUs and a restricted mask are handled by
> + * construction.

This paragraph again AFAIK states the obvious.

> + */
> +static void start_load(void)
> +{
> +	cpu_set_t mask;
> +	int nr_cpus;
> +	int cpu = 0;
> +
> +	if (sched_getaffinity(0, sizeof(mask), &mask))
> +		tst_brk(TBROK | TERRNO, "sched_getaffinity() failed");
> +
> +	nr_cpus = CPU_COUNT(&mask);
> +	spinners = SAFE_MALLOC(nr_cpus * sizeof(*spinners));
> +
> +	for (int i = 0; i < nr_cpus; i++) {
> +		pid_t pid;
> +
> +		while (!CPU_ISSET(cpu, &mask))
> +			cpu++;
> +
> +		pid = SAFE_FORK();
> +
> +		if (!pid) {
> +			cpu_set_t one;
> +
> +			CPU_ZERO(&one);
> +			CPU_SET(cpu, &one);
> +
> +			if (sched_setaffinity(0, sizeof(one), &one)) {
> +				tst_brk(TBROK | TERRNO,
> +					"sched_setaffinity(CPU %d) failed", cpu);
> +			}

It would be nicer if we added SAFE_SCHED_SETAFFINITY() and
SAFE_SCHED_GETAFFINITY().

> +			spin();
> +		}
> +
> +		/*
> +		 * Counted only once the child exists, so that a fork() that
> +		 * fails half way through does not leave stop_load() killing
> +		 * pids that were never written. A zeroed entry would mean
> +		 * kill() signalling the whole process group.
> +		 */

SAFE_FORK() cannot fail, this comment is wrong.

> +		spinners[nr_spinners++] = pid;
> +		cpu++;
> +	}
> +
> +	tst_res(TINFO, "keeping %d CPUs busy", nr_spinners);
> +}
> +
> +static void stop_load(void)
> +{
> +	if (!spinners)
> +		return;
> +
> +	for (int i = 0; i < nr_spinners; i++) {
> +		SAFE_KILL(spinners[i], SIGKILL);
> +		SAFE_WAITPID(spinners[i], NULL, 0);
> +	}
> +
> +	free(spinners);
> +	spinners = NULL;
> +	nr_spinners = 0;
> +}
> +
> +/*
> + * Wait for a counter to advance while the system idles, reporting how many did.
> + *
> + * This is what tells a counter that stops under load from one that never moves.
> + * On an idle system most counters read 0 permanently, because nothing posts an
> + * LTR that would block a package C-state entry, so a single counter advancing
> + * is enough.
> + */
> +static int wait_for_advance(const uint32_t *baseline)
> +{
> +	uint32_t values[MAX_COUNTERS];
> +	struct timespec start, now;
> +	int advanced = 0;
> +
> +	tst_clock_gettime(CLOCK_MONOTONIC, &start);
> +
> +	for (;;) {
> +		read_counters(values);
> +
> +		for (int i = 0; i < cnt; i++) {
> +			if (values[i] == baseline[i])
> +				continue;
> +
> +			tst_res(TINFO, "%s advanced by %u while idle", names[i],
> +				values[i] - baseline[i]);
> +			advanced++;
> +		}
> +
> +		if (advanced)
> +			return advanced;
> +
> +		tst_clock_gettime(CLOCK_MONOTONIC, &now);
> +
> +		if (tst_timespec_diff_ms(now, start) >= IDLE_WINDOW * 1000)
> +			return 0;
> +
> +		usleep(POLL_MS * 1000);
> +	}

The IDLE_WINDOW shouldn't be hardcoded, it should be controlled by
.runtime and .min_runtime and this loop should act on
tst_remanining_runtime()

> +}
> +
> +/*
> + * Require the counters to hold still for QUIET_WINDOW seconds of full load.
> + */
> +static void check_counters_stop(void)
> +{
> +	uint32_t first[MAX_COUNTERS], prev[MAX_COUNTERS], values[MAX_COUNTERS];
> +	struct timespec changed_at[MAX_COUNTERS];
> +	struct timespec start, last_change, now;
> +
> +	read_counters(first);
> +	memcpy(prev, first, sizeof(prev));
> +
> +	tst_clock_gettime(CLOCK_MONOTONIC, &start);
> +	last_change = start;
> +
> +	for (int i = 0; i < cnt; i++)
> +		changed_at[i] = start;
> +
> +	for (;;) {
> +		usleep(POLL_MS * 1000);
> +
> +		read_counters(values);
> +		tst_clock_gettime(CLOCK_MONOTONIC, &now);
> +
> +		for (int i = 0; i < cnt; i++) {
> +			if (values[i] == prev[i])
> +				continue;
> +
> +			changed_at[i] = now;
> +			last_change = now;
> +		}
> +
> +		memcpy(prev, values, sizeof(prev));
> +
> +		if (tst_timespec_diff_ms(now, last_change) >= QUIET_WINDOW * 1000) {
> +			tst_res(TPASS,
> +				"%d counters held still over %ds with every CPU busy",
> +				cnt, QUIET_WINDOW);
> +			return;
> +		}
> +
> +		if (tst_timespec_diff_ms(now, start) < LOAD_WINDOW * 1000)
> +			continue;
> +
> +		/*
> +		 * A counter that last changed a quiet window ago or more was
> +		 * only draining entries blocked before the load took hold. The
> +		 * ones that changed since are the ones that never stopped.
> +		 */
> +		for (int i = 0; i < cnt; i++) {
> +			if (tst_timespec_diff_ms(now, changed_at[i]) >=
> +			    QUIET_WINDOW * 1000)
> +				continue;
> +
> +			tst_res(TFAIL,
> +				"%s kept advancing over %ds with every CPU busy: %u -> %u",
> +				names[i], LOAD_WINDOW, first[i], values[i]);
> +		}
> +
> +		return;
> +	}
> +}
> +
> +static void setup(void)
> +{
> +	uint32_t values[MAX_COUNTERS];
> +
> +	if (access(PATH, R_OK))
> +		tst_brk(TCONF | TERRNO, "%s not available", PATH);
> +
> +	/* Learns the counter set the rest of the test compares against */
> +	read_counters(values);
> +
> +	if (!cnt)
> +		tst_brk(TBROK, "no LTR blocker counters reported");
> +}
> +
> +static void cleanup(void)
> +{
> +	stop_load();
> +}
> +
> +static void run(void)
> +{
> +	uint32_t baseline[MAX_COUNTERS];
> +
> +	read_counters(baseline);
> +
> +	/*
> +	 * Without a counter that moves while idle there is nothing to stop
> +	 * under load, a stuck counter would look exactly the same.
> +	 */
> +	if (!wait_for_advance(baseline)) {
> +		tst_brk(TCONF,
> +			"no LTR blocked a package C-state entry over %ds of idling",
> +			IDLE_WINDOW);
> +	}
> +
> +	start_load();
> +	check_counters_stop();
> +	stop_load();
> +}
> +
> +static struct tst_test test = {
> +	.min_kver = "7.2",
> +	.timeout = 90,
> +	.needs_debugfs = 1,
> +	.forks_child = 1,
> +	.needs_kconfigs = (const char *const []) {
> +		"CONFIG_DEBUG_FS",
> +		"CONFIG_INTEL_PMC_CORE",
> +		NULL
> +	},
> +	.supported_archs = (const char *const []) {
> +		"x86",
> +		"x86_64",
> +		NULL
> +	},
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "38c79dd63b72e36919ef097d4e5025ca0fa17f34"},
> +		{}
> +	},

Again tags are only for regression tests and point to kernel fixes.

> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run
> +};

What happens when the test is run in a KVM VM where only subset of CPUs
is exposed, will the counters in the file match the set of the CPUs
exposed to the VM?


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
