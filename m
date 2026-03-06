Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B32AF01835
	for <ltp@archiver.kernel.org>; Fri,  6 Mar 2026 13:47:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C69263CF694
	for <ltp@archiver.kernel.org>; Fri,  6 Mar 2026 14:47:33 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A01933C2EA3
 for <ltp@lists.linux.it>; Fri,  6 Mar 2026 14:47:14 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DB7651A01091
 for <ltp@lists.linux.it>; Fri,  6 Mar 2026 14:47:13 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A6E9F5BDA4;
 Fri,  6 Mar 2026 13:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772804832;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NNsL2PggMGm07P4EZUqNUY/5SXAlknuFrR+NQBoCQcg=;
 b=AsbmRctHm2y8TBBllcmml47Dmw7nvaar5mve05ZypSacoWzynUHY7raip6v46es3OwPVdt
 T63e+pu9JgWl12lBcQMp4wHMDO/rksLqglme0O66NNriKp92juMaGoniBbtAsspm66iGb4
 fgwLek9IsdsSfc18TsOraxcx2LVjUkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772804832;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NNsL2PggMGm07P4EZUqNUY/5SXAlknuFrR+NQBoCQcg=;
 b=DP6ZmloGtlV+mLw7CzwwsNWYnp49Ss9dMv8SdVKg50AVGSfKysjIRDkkpwrOJnN6PwO9Hc
 NzRlU27n5PGZgnDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772804832;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NNsL2PggMGm07P4EZUqNUY/5SXAlknuFrR+NQBoCQcg=;
 b=AsbmRctHm2y8TBBllcmml47Dmw7nvaar5mve05ZypSacoWzynUHY7raip6v46es3OwPVdt
 T63e+pu9JgWl12lBcQMp4wHMDO/rksLqglme0O66NNriKp92juMaGoniBbtAsspm66iGb4
 fgwLek9IsdsSfc18TsOraxcx2LVjUkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772804832;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NNsL2PggMGm07P4EZUqNUY/5SXAlknuFrR+NQBoCQcg=;
 b=DP6ZmloGtlV+mLw7CzwwsNWYnp49Ss9dMv8SdVKg50AVGSfKysjIRDkkpwrOJnN6PwO9Hc
 NzRlU27n5PGZgnDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D8E63EA75;
 Fri,  6 Mar 2026 13:47:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lztiF9/aqmleEAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 06 Mar 2026 13:47:11 +0000
Date: Fri, 6 Mar 2026 14:47:05 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Piotr Kubaj <piotr.kubaj@intel.com>
Message-ID: <20260306134705.GB528953@pevik>
References: <20260304130658.262532-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260304130658.262532-2-piotr.kubaj@intel.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_SEVEN(0.00)[7]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo,intel.com:email];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
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

Hi Piotr,

> Currently consists of only one test for the CPU package thermal sensor
> interface for Intel platforms.
> It works by checking the initial count of thermal interrupts. Then it
> decreases the threshold for sending a thermal interrupt to just above
> the current temperature and runs a workload on the CPU. Finally, it
> restores the original thermal threshold and checks whether the number
> of thermal interrupts increased.

> Signed-off-by: Piotr Kubaj <piotr.kubaj@intel.com>
> ---
> Patch version 11
> Switched 1 to true and added reference to kernel fix.

Generally LGTM, maybe Cyril will have some comments.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> +static void read_interrupts(uint64_t *interrupts, const int nproc)
> +{
> +	bool interrupts_found = false;
> +	char line[8192];
> +
> +	memset(interrupts, 0, nproc * sizeof(*interrupts));
> +	FILE *fp = SAFE_FOPEN("/proc/interrupts", "r");
> +
> +	while (fgets(line, sizeof(line), fp)) {
> +		if (strstr(line, "Thermal event interrupts")) {
> +			interrupts_found = true;
> +			char *ptr = strchr(line, ':');
> +
> +			for (int i = 0; i < nproc; i++) {
> +				char *endptr;
> +
> +				while (*ptr && !isdigit(*ptr))
> +					ptr++;
> +
> +				errno = 0;
> +
> +				interrupts[i] = strtoull(ptr, &endptr, 10);
> +
> +				if (ptr == endptr)
> +					tst_brk(TBROK, "interrupt not found");
> +
> +				if (errno == ERANGE)
> +					tst_brk(TCONF, "interrupt out of range");

I wonder if this is expected to happen. Can be value really over LLONG_MAX?

Because arch/x86/include/asm/hardirq.h has

unsigned int irq_thermal_count

=> if it's over the range, I'd quit with tst_brk(TBROK).

Also we don't have safe_strtoull() in lib/safe_macros.c
(it would be trivial to add) otherwise I would just use it.

(Otherwise IMHO Cyril's request from v8 was done
https://lore.kernel.org/ltp/aZ72j9KvkhsDF7Yf@yuki.lan/)

> +
> +				ptr = endptr;
> +				tst_res(TDEBUG, "interrupts[%d]: %ld", i, interrupts[i]);
> +			}
> +			break;
> +		}
> +	}
> +	SAFE_FCLOSE(fp);
> +	if (!interrupts_found)
> +		tst_brk(TCONF, "No Thermal event interrupts line in /proc/interrupts");
> +}

...
> +static void cleanup(void)
> +{
> +	if (x86_pkg_temp_tz_found)
> +		SAFE_FILE_PRINTF(trip_path, "%d", trip);
> +
> +	free(x86_pkg_temp_tz);
> +	free(interrupt_init);
> +	free(interrupt_later);
> +}
> +
> +static void run(void)
> +{
> +	for (int i = 0; i < tz_counter; i++) {
> +		if (x86_pkg_temp_tz[i])
> +			test_zone(i);
> +	}
> +	read_interrupts(interrupt_later, nproc);
> +
> +	for (int i = 0; i < nproc; i++) {
> +		if (interrupt_later[i] < interrupt_init[i])
> +			tst_res(TFAIL, "CPU %d interrupt counter: %ld (previous: %ld)",
> +				i, interrupt_later[i], interrupt_init[i]);
> +	}
> +
> +	if (temp <= temp_high)
> +		tst_res(TFAIL, "Zone temperature is not rising as expected");
> +	else
> +		tst_res(TPASS, "x86 package thermal interrupt triggered");
> +}
> +
> +static struct tst_test test = {
> +	.cleanup = cleanup,
> +	.forks_child = 1,
> +	.needs_drivers = (const char *const []) {
> +		"x86_pkg_temp_thermal",
> +		NULL
> +	},
nit: Alternatively instead of needs drivers we could check via .needs_kconfigs
for CONFIG_X86_THERMAL_VECTOR (functionality wrapped in kernel, defined in
drivers/thermal/intel/Kconfig). Cyril WDYT?

IMHO we slowly convert from modules.{dep,builtin} based search in
lib/tst_kernel.c to kconfig related checks (functionality which come to LTP
later).

> +	.min_runtime = 180,

Test is mostly super quick. I suppose we can lower down this to e.g. 5
because it depends on number of the zones.
But could we define it to 5 here and set in the setup correct value via
tst_set_runtime().

> +	.needs_root = 1,
> +	.setup = setup,
> +	.supported_archs = (const char *const []) {
> +		"x86",
> +		"x86_64",
> +		NULL
> +	},
This is somehow redundant to .needs_drivers/.needs_kconfigs. OTOH it nicely
defines which arch is targeted.

> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "9635c586a559ba0e45b2bfbff79c937ddbaf1a62"},
FYI we normally use much shorter hash (12 chars), but IMHO this is good
approach. IMHO we should start to use sha1 (40 chars).

Kind regards,
Petr

> +		{}
> +	},
> +	.test_all = run
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
