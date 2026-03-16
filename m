Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABC1F506C0
	for <ltp@archiver.kernel.org>; Mon, 16 Mar 2026 12:33:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CFBF93E565D
	for <ltp@archiver.kernel.org>; Mon, 16 Mar 2026 13:33:31 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 095CD3E4B85
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 13:33:11 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0917A6008EF
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 13:33:09 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 43AE65BD2C;
 Mon, 16 Mar 2026 12:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773664388;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yk9P4Iu3Fp95zt+5w5E2O/q+NIMSAW1i78UjgbxYgFw=;
 b=xGv9GqJrqI9aB3GIup+Q/kkqCe15ZHGjCU4jWTQ3sZY0HEJYy9DXl5bSGpu3LSxMBQUdlm
 wHkmkEO7+qXALShJbW7i3daosqV3QbPVdDf7vQrg0j3gjVzIQATMTC0MfSip6XLDhll/fH
 mvASBqQJzlWLqp9augBV1cTbamvLCaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773664388;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yk9P4Iu3Fp95zt+5w5E2O/q+NIMSAW1i78UjgbxYgFw=;
 b=PTTsDrLXPvNaeCpwf48p5URby2sdq5jbNCl89KiBFH+andJmSbi5zZgN1Rj22BA/gZZJbm
 fs0gxbApTeERA7BA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xGv9GqJr;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PTTsDrLX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773664388;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yk9P4Iu3Fp95zt+5w5E2O/q+NIMSAW1i78UjgbxYgFw=;
 b=xGv9GqJrqI9aB3GIup+Q/kkqCe15ZHGjCU4jWTQ3sZY0HEJYy9DXl5bSGpu3LSxMBQUdlm
 wHkmkEO7+qXALShJbW7i3daosqV3QbPVdDf7vQrg0j3gjVzIQATMTC0MfSip6XLDhll/fH
 mvASBqQJzlWLqp9augBV1cTbamvLCaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773664388;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yk9P4Iu3Fp95zt+5w5E2O/q+NIMSAW1i78UjgbxYgFw=;
 b=PTTsDrLXPvNaeCpwf48p5URby2sdq5jbNCl89KiBFH+andJmSbi5zZgN1Rj22BA/gZZJbm
 fs0gxbApTeERA7BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AFE3A4273B;
 Mon, 16 Mar 2026 12:33:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jz3fKIP4t2n4YgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 16 Mar 2026 12:33:07 +0000
Date: Mon, 16 Mar 2026 13:33:01 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Piotr Kubaj <piotr.kubaj@intel.com>
Message-ID: <20260316123301.GA313808@pevik>
References: <20260313125408.480770-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260313125408.480770-2-piotr.kubaj@intel.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:32098, ipnet:2800::/6, country:US];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 43AE65BD2C
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] high_freq_hwp_cap_cppc.c: new test
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

> Verify for all online logical CPUs that their highest performance value are
> the same for HWP Capability MSR 0x771 and CPPC sysfs file.

You were supposed to add your RBT:
Signed-off-by: Piotr Kubaj <piotr.kubaj@intel.com>

> ---
>  testcases/kernel/power_management/.gitignore  |  1 +
>  .../power_management/high_freq_hwp_cap_cppc.c | 57 +++++++++++++++++++

You did not add test into runtest/thermal. OTOH test will apply also after we
finally merge thermal_interrupt_events.c.

>  2 files changed, 58 insertions(+)
>  create mode 100644 testcases/kernel/power_management/high_freq_hwp_cap_cppc.c

> diff --git a/testcases/kernel/power_management/.gitignore b/testcases/kernel/power_management/.gitignore
> index 0c2a3ed4b..c13bca1c4 100644
> --- a/testcases/kernel/power_management/.gitignore
> +++ b/testcases/kernel/power_management/.gitignore
> @@ -1 +1,2 @@
> +high_freq_hwp_cap_cppc
>  pm_get_sched_values
> diff --git a/testcases/kernel/power_management/high_freq_hwp_cap_cppc.c b/testcases/kernel/power_management/high_freq_hwp_cap_cppc.c
> new file mode 100644
> index 000000000..4cbb81f0b
> --- /dev/null
> +++ b/testcases/kernel/power_management/high_freq_hwp_cap_cppc.c
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/*
> + * Copyright (C) 2025-2026 Intel - http://www.intel.com/
> + */
> +
> +/*\
> + * Verify for all online logical CPUs  that their highest performance value are
> + * the same for HWP Capability MSR 0x771 and CPPC sysfs file.
> + */
> +
> +#include "tst_test.h"
> +
> +static int nproc;
> +
> +static void setup(void)
> +{
> +	nproc = tst_ncpus();
> +}
> +
> +static void run(void)
> +{
> +	for (int i = 0; i < nproc; i++) {
> +		char path[PATH_MAX];
> +		unsigned long long msr_highest_perf = 0, sysfs_highest_perf = 0;
> +
> +		snprintf(path, PATH_MAX, "/sys/devices/system/cpu/cpu%d/acpi_cppc/highest_perf", i);
> +		SAFE_FILE_SCANF(path, "%llu", &sysfs_highest_perf);

I tried to run the test, but it fails due missing sysfs file:

$ grep CONFIG_X86_MSR /boot/config-6.19.0-rc1-1.g274aff5-default 
CONFIG_X86_MSR=m

$ lsmod |grep msr
intel_rapl_msr         20480  0
intel_rapl_common      53248  1 intel_rapl_msr

# ./high_freq_hwp_cap_cppc 
tst_test.c:1887: TINFO: Overall timeout per run is 0h 02m 00s
...
high_freq_hwp_cap_cppc.c:28: TBROK: Failed to open FILE '/sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf' for reading: ENOENT (2)

# modprobe msr

$ lsmod |grep msr
msr                    12288  0
intel_rapl_msr         20480  0
intel_rapl_common      53248  1 intel_rapl_msr

# ./high_freq_hwp_cap_cppc
...
high_freq_hwp_cap_cppc.c:28: TBROK: Failed to open FILE '/sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf' for reading: ENOENT (2)

=> obviously checking for CONFIG_X86_MSR is not enough.

OT: it'd be nice to extend 'save_restore' library functionality to
1) support glob (/sys/devices/system/cpu/cpu*/acpi_cppc/highest_perf)
2) read value into the variable (in case of glob into array).

> +		tst_res(TDEBUG, "%s: %llu", path, sysfs_highest_perf);
> +
> +		snprintf(path, PATH_MAX, "/dev/cpu/%d/msr", i);
> +		int fd = SAFE_OPEN(path, O_RDONLY);
> +
> +		if (pread(fd, &msr_highest_perf, sizeof(msr_highest_perf), 0x771) < 0) {
> +			SAFE_CLOSE(fd);
> +			tst_brk(TBROK | TERRNO, "MSR read error");
> +		}
> +		SAFE_CLOSE(fd);
> +		msr_highest_perf &= (1ULL << 8) - 1;
> +		tst_res(TDEBUG, "%s: %llu", path, msr_highest_perf);
> +
> +		if (msr_highest_perf != sysfs_highest_perf)
> +			tst_brk(TFAIL, "CPU %d: highest performance values differ between sysfs and MSR", i);
> +	}
> +
> +	tst_res(TPASS, "Test pass");

"Test pass" has zero information value.
Maybe something like:
"sysfs and MSR values are equal"

> +}
> +
> +static struct tst_test test = {
> +	.needs_kconfigs = (const char *const []) {
> +		"CONFIG_X86_MSR",
> +		NULL
> +	},
For thermal_interrupt_events.c we also have use .supported_archs (for the docs
purposes), why not to add it to this test as well?

+	.supported_archs = (const char *const []) {
+		"x86",
+		"x86_64",
+		NULL
+	},

Kind regards,
Petr

> +	.needs_root = 1,
> +	.setup = setup,
> +	.test_all = run
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
