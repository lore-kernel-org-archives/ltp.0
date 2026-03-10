Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB91EEB104C
	for <ltp@archiver.kernel.org>; Tue, 10 Mar 2026 11:05:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 471F93CA670
	for <ltp@archiver.kernel.org>; Tue, 10 Mar 2026 12:05:52 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E4ED3C23AC
 for <ltp@lists.linux.it>; Tue, 10 Mar 2026 12:05:33 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id ED880200322
 for <ltp@lists.linux.it>; Tue, 10 Mar 2026 12:05:32 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 368405BCDE;
 Tue, 10 Mar 2026 11:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773140732;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HOjzBaBAYpsOmYNXWVDW2MqFNrP5+VEPXjobPYnIHvM=;
 b=EV1+2lhgCOV6SooDo0YzJkZNjuy7fJ8qlq29pWcmjOqEBsW1WfqRuul3E7lJ2NM3pEcecO
 lH5FuLsQySGPF2gLEbP6QcNd9QnIoX4WyX2+pMXHsACoAyQag+yOSTnI/4tLSNySmcLo5L
 VNQwV6tRalKCMPLLs1OH+SkCzAnls3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773140732;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HOjzBaBAYpsOmYNXWVDW2MqFNrP5+VEPXjobPYnIHvM=;
 b=8ilR6dGBf8uigjDX8SZpBFd/fEBPGVtSc/wP92eQy8sr4UtGtnyuv1YlDvf8F2Uksb6Ouy
 ntp0iARPSa6+IUAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EV1+2lhg;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8ilR6dGB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773140732;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HOjzBaBAYpsOmYNXWVDW2MqFNrP5+VEPXjobPYnIHvM=;
 b=EV1+2lhgCOV6SooDo0YzJkZNjuy7fJ8qlq29pWcmjOqEBsW1WfqRuul3E7lJ2NM3pEcecO
 lH5FuLsQySGPF2gLEbP6QcNd9QnIoX4WyX2+pMXHsACoAyQag+yOSTnI/4tLSNySmcLo5L
 VNQwV6tRalKCMPLLs1OH+SkCzAnls3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773140732;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HOjzBaBAYpsOmYNXWVDW2MqFNrP5+VEPXjobPYnIHvM=;
 b=8ilR6dGBf8uigjDX8SZpBFd/fEBPGVtSc/wP92eQy8sr4UtGtnyuv1YlDvf8F2Uksb6Ouy
 ntp0iARPSa6+IUAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EEECD3F409;
 Tue, 10 Mar 2026 11:05:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id r49fOfv6r2nOOAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 10 Mar 2026 11:05:31 +0000
Date: Tue, 10 Mar 2026 12:05:30 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260310110530.GB39882@pevik>
References: <20260304130658.262532-2-piotr.kubaj@intel.com>
 <20260306134705.GB528953@pevik> <aa_0YkA4UKwhOjpi@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aa_0YkA4UKwhOjpi@yuki.lan>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 368405BCDE
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v11] thermal: add new test group
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
Cc: helena.anna.dubel@intel.com, tomasz.ossowski@intel.com,
 rafael.j.wysocki@intel.com, ltp@lists.linux.it, daniel.niestepski@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

TL;DR: no more concerns from my side.

> Hi!
> > > +static void read_interrupts(uint64_t *interrupts, const int nproc)
> > > +{
> > > +	bool interrupts_found = false;
> > > +	char line[8192];
> > > +
> > > +	memset(interrupts, 0, nproc * sizeof(*interrupts));
> > > +	FILE *fp = SAFE_FOPEN("/proc/interrupts", "r");
> > > +
> > > +	while (fgets(line, sizeof(line), fp)) {
> > > +		if (strstr(line, "Thermal event interrupts")) {
> > > +			interrupts_found = true;
> > > +			char *ptr = strchr(line, ':');
> > > +
> > > +			for (int i = 0; i < nproc; i++) {
> > > +				char *endptr;
> > > +
> > > +				while (*ptr && !isdigit(*ptr))
> > > +					ptr++;
> > > +
> > > +				errno = 0;
> > > +
> > > +				interrupts[i] = strtoull(ptr, &endptr, 10);
> > > +
> > > +				if (ptr == endptr)
> > > +					tst_brk(TBROK, "interrupt not found");
> > > +
> > > +				if (errno == ERANGE)
> > > +					tst_brk(TCONF, "interrupt out of range");

> > I wonder if this is expected to happen. Can be value really over LLONG_MAX?

> That's just to make sure that kernel generated sane result. In tests we
> shouldn't blindly trust anything.

Makes sense.

> > Because arch/x86/include/asm/hardirq.h has

> > unsigned int irq_thermal_count

> > => if it's over the range, I'd quit with tst_brk(TBROK).

> It should be TBROK indeed.

> > Also we don't have safe_strtoull() in lib/safe_macros.c
> > (it would be trivial to add) otherwise I would just use it.

> > (Otherwise IMHO Cyril's request from v8 was done
> > https://lore.kernel.org/ltp/aZ72j9KvkhsDF7Yf@yuki.lan/)

> > > +
> > > +				ptr = endptr;
> > > +				tst_res(TDEBUG, "interrupts[%d]: %ld", i, interrupts[i]);
> > > +			}
> > > +			break;
> > > +		}
> > > +	}
> > > +	SAFE_FCLOSE(fp);
> > > +	if (!interrupts_found)
> > > +		tst_brk(TCONF, "No Thermal event interrupts line in /proc/interrupts");
> > > +}

> > ...
> > > +static void cleanup(void)
> > > +{
> > > +	if (x86_pkg_temp_tz_found)
> > > +		SAFE_FILE_PRINTF(trip_path, "%d", trip);
> > > +
> > > +	free(x86_pkg_temp_tz);
> > > +	free(interrupt_init);
> > > +	free(interrupt_later);
> > > +}
> > > +
> > > +static void run(void)
> > > +{
> > > +	for (int i = 0; i < tz_counter; i++) {
> > > +		if (x86_pkg_temp_tz[i])
> > > +			test_zone(i);
> > > +	}
> > > +	read_interrupts(interrupt_later, nproc);
> > > +
> > > +	for (int i = 0; i < nproc; i++) {
> > > +		if (interrupt_later[i] < interrupt_init[i])
> > > +			tst_res(TFAIL, "CPU %d interrupt counter: %ld (previous: %ld)",
> > > +				i, interrupt_later[i], interrupt_init[i]);
> > > +	}
> > > +
> > > +	if (temp <= temp_high)
> > > +		tst_res(TFAIL, "Zone temperature is not rising as expected");
> > > +	else
> > > +		tst_res(TPASS, "x86 package thermal interrupt triggered");
> > > +}
> > > +
> > > +static struct tst_test test = {
> > > +	.cleanup = cleanup,
> > > +	.forks_child = 1,
> > > +	.needs_drivers = (const char *const []) {
> > > +		"x86_pkg_temp_thermal",
> > > +		NULL
> > > +	},
> > nit: Alternatively instead of needs drivers we could check via .needs_kconfigs
> > for CONFIG_X86_THERMAL_VECTOR (functionality wrapped in kernel, defined in
> > drivers/thermal/intel/Kconfig). Cyril WDYT?

> We would need to apply the kconfig patch I've send and then add hook for
> the CONFIG_X86_THERMAL_VECTOR. I wouldn't wait for that with this patch,
> we can fix it once our infrastructure is ready.

Ah, I haven't noticed x86_pkg_temp_thermal driver can be disabled in the runtime
(otherwise there is always /sys/class/thermal/ when compiled with
CONFIG_X86_THERMAL_VECTOR). But sure, let's keep it this way, I also don't want
to block this effort.

> > IMHO we slowly convert from modules.{dep,builtin} based search in
> > lib/tst_kernel.c to kconfig related checks (functionality which come to LTP
> > later).

> > > +	.min_runtime = 180,

> > Test is mostly super quick. I suppose we can lower down this to e.g. 5
> > because it depends on number of the zones.
> > But could we define it to 5 here and set in the setup correct value via
> > tst_set_runtime().

> > > +	.needs_root = 1,
> > > +	.setup = setup,
> > > +	.supported_archs = (const char *const []) {
> > > +		"x86",
> > > +		"x86_64",
> > > +		NULL
> > > +	},
> > This is somehow redundant to .needs_drivers/.needs_kconfigs. OTOH it nicely
> > defines which arch is targeted.

> That's why I requested it to be added.

I'm sorry, I overlooked you asked for it.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
