Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BC8103E17D
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 13:53:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 889393E6096
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 14:53:06 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 754AE3C9F77
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 14:52:47 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D353F140097F
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 14:52:46 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 440865BD46;
 Wed, 18 Mar 2026 13:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773841960;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qn243bDVVOCFYAwGapzhy+kVR0/prbe1wQ9iket0wmE=;
 b=1RgEg4wmRk/DNzRRfGBhiK/HD8iqq/UzPF9muB6T6NvlVp9u1AX7+JXsK9BzZ6Yj4fBfbE
 l2igXxjCqX6KH0kWkfNope2uOtZbIba32iHF8GIrif9wVT3/ly1+61r9zKJ6C9J3HJwRG1
 +0RWmmdNQPL1tNSIhMnW5mgtk0q9yBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773841960;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qn243bDVVOCFYAwGapzhy+kVR0/prbe1wQ9iket0wmE=;
 b=ahAX6uQFdKYmmQzfSEFX6AaruKfgaUQ6R/t70gqFsPMN/fPgkWUGJMzqmo0kbpJEXLsAWx
 X6anLfJsID8kEYAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773841960;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qn243bDVVOCFYAwGapzhy+kVR0/prbe1wQ9iket0wmE=;
 b=1RgEg4wmRk/DNzRRfGBhiK/HD8iqq/UzPF9muB6T6NvlVp9u1AX7+JXsK9BzZ6Yj4fBfbE
 l2igXxjCqX6KH0kWkfNope2uOtZbIba32iHF8GIrif9wVT3/ly1+61r9zKJ6C9J3HJwRG1
 +0RWmmdNQPL1tNSIhMnW5mgtk0q9yBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773841960;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qn243bDVVOCFYAwGapzhy+kVR0/prbe1wQ9iket0wmE=;
 b=ahAX6uQFdKYmmQzfSEFX6AaruKfgaUQ6R/t70gqFsPMN/fPgkWUGJMzqmo0kbpJEXLsAWx
 X6anLfJsID8kEYAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E4084273B;
 Wed, 18 Mar 2026 13:52:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id b3eoBiiuumlcOgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 18 Mar 2026 13:52:40 +0000
Date: Wed, 18 Mar 2026 14:52:30 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Piotr Kubaj <piotr.kubaj@intel.com>
Message-ID: <20260318135230.GB18914@pevik>
References: <20260318130250.68495-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260318130250.68495-2-piotr.kubaj@intel.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,intel.com:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] high_freq_hwp_cap_cppc.c: new test
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
Cc: daniel.niestepski@intel.com, tomasz.ossowski@intel.com,
 helena.anna.dubel@intel.com, rafael.j.wysocki@intel.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Verify for all online logical CPUs that their highest performance value are
> the same for HWP Capability MSR 0x771 and CPPC sysfs file.

> Signed-off-by: Piotr Kubaj <piotr.kubaj@intel.com>
> ---
>  testcases/kernel/power_management/.gitignore  |  1 +
>  .../power_management/high_freq_hwp_cap_cppc.c | 66 +++++++++++++++++++

As I wrote in v1, any tests needs to be added into runtest file,
runtest/power_management_tests in this case.

>  2 files changed, 67 insertions(+)
>  create mode 100644 testcases/kernel/power_management/high_freq_hwp_cap_cppc.c

...
> +static void run(void)
> +{
> +	bool status = true;
> +
> +	for (int i = 0; i < nproc; i++) {
> +		char path[PATH_MAX];
> +		unsigned long long msr_highest_perf = 0, sysfs_highest_perf = 0;
> +
> +		snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/acpi_cppc/highest_perf", i);
> +		SAFE_FILE_SCANF(path, "%llu", &sysfs_highest_perf);
> +		tst_res(TDEBUG, "%s: %llu", path, sysfs_highest_perf);
> +
> +		snprintf(path, sizeof(path), "/dev/cpu/%d/msr", i);
> +		int fd = SAFE_OPEN(path, O_RDONLY);
> +
> +		if (SAFE_PREAD(1, fd, &msr_highest_perf, sizeof(msr_highest_perf), 0x771) == -1)
> +			tst_brk(TBROK | TERRNO, "MSR read error");

SAFE_*() functions contain error check, tst_brk() is redundant.

> +		msr_highest_perf &= (1ULL << 8) - 1;
> +		tst_res(TDEBUG, "%s: %llu", path, msr_highest_perf);
> +
> +		if (msr_highest_perf != sysfs_highest_perf)
> +			status = false;
> +	}
> +
> +	if (status)
> +		tst_res(TPASS, "Sysfs and MSR values are equal");
> +	else
> +		tst_res(TFAIL, "Highest performance values differ between sysfs and MSR");
I would print TFAIL in the for loop with CPU ID and both values.
And here print only final TPASS.

> +}
> +
> +static struct tst_test test = {
> +	.needs_kconfigs = (const char *const []) {
> +		"CONFIG_ACPI_CPPC_LIB",
> +		"CONFIG_X86_MSR",

Also even on this version I have:
high_freq_hwp_cap_cppc.c:31: TBROK: Failed to open FILE '/sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf' for reading: ENOENT (2)

on 6.18 kernel even I run modprobe msr

$ grep -e CONFIG_X86_MSR -e CONFIG_ACPI_CPPC_LIB /boot/config-6.18.*
CONFIG_X86_MSR=m
CONFIG_ACPI_CPPC_LIB=y

OTOH on 7.0.0-rc2 with the same config values autoloading worked.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
