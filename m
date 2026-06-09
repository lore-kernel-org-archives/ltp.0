Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA005CD8CA8
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 10:26:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B3D53E5F83
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 12:26:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 100C53C6F29
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 12:26:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 78DF71A007FE
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 12:26:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CA40775AC2;
 Tue,  9 Jun 2026 10:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781000789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uXNNxtuE6hZkn1oUUSC/B0IjFeO9OtHqR8melKSJtDs=;
 b=Us3JZ+49bv7vBDxvGdP0gIALaHeiuQLYj7kJslRH5RgvmvHk+v7SGjWQMYY2+PPYRqTdBi
 0j1wRY+/ABtt/jWVXUr68v67fALnE1AoRdhCAlhKcDQI5MAr/3HSc7d6x0ANFC7FCkY0QL
 eeoXPCgfJJ0IEZel4CxN2xMtKziBUZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781000789;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uXNNxtuE6hZkn1oUUSC/B0IjFeO9OtHqR8melKSJtDs=;
 b=Vr7bUoW5CpVdpetCOWA0lYHEhIHW7hZiFTJsDNOX+zWf8kKPpx099W2KUSJydGHHbiW4bZ
 7sMPGENKXY1xb9DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781000788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uXNNxtuE6hZkn1oUUSC/B0IjFeO9OtHqR8melKSJtDs=;
 b=UlzCcsAKsysdSOUGKZIbvKybqbmS858PPJmRjBc66+qoI1TGwHcP2onNorXVVonFoBgG6I
 LkTxuKwZ33SEwfFGzcq5kSEsmhr2tKyh2Vmtd+VvOCoXlZc8ZCzChKeFr34UXgZrK9Oyy+
 RPA5I/hjLQHcjYUklnfRwLzeyCQec4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781000788;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uXNNxtuE6hZkn1oUUSC/B0IjFeO9OtHqR8melKSJtDs=;
 b=QYtXsc0Z8QDOIeIuDU7oPQmN03Z7p1UR0Ty6ACgm/L5KSE2viPx+aJqddvAauzK0npiW/m
 yvehoGJ2NlRiyUAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3B3B779A7;
 Tue,  9 Jun 2026 10:26:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rwsCKlTqJ2q1WwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 09 Jun 2026 10:26:28 +0000
Date: Tue, 9 Jun 2026 12:26:18 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Piotr Kubaj <piotr.kubaj@intel.com>
Message-ID: <aifqSgdF-_F5nz8-@yuki.lan>
References: <20260514093559.125070-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260514093559.125070-2-piotr.kubaj@intel.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v13] high_freq_hwp_cap_cppc.c: new test
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
Cc: daniel.niestepski@intel.com, tomasz.ossowski@intel.com,
 helena.anna.dubel@intel.com, rafael.j.wysocki@intel.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +#include "tst_test.h"
> +#include "tst_safe_prw.h"
> +
> +#define MSR_HWP_CAPABILITIES	0x771
> +#define HIGHEST_PERF_MASK	0xFF
> +
> +static int nproc;
> +static int fd = -1;
> +static int *mismatch;
> +
> +static void setup(void)
> +{
> +	if (access("/dev/cpu/0/msr", F_OK) == -1)
> +		tst_brk(TCONF | TERRNO, "msr driver not loaded");
> +
> +	if (access("/sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf", F_OK) == -1)
> +		tst_brk(TCONF | TERRNO, "CPPC sysfs not available");
> +
> +	nproc = tst_ncpus_conf();
> +	mismatch = SAFE_MALLOC(nproc * sizeof(int));
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd != -1)
> +		SAFE_CLOSE(fd);
> +
> +	free(mismatch);
> +}
> +
> +static void run(void)
> +{
> +	bool status = true;
> +	char path[PATH_MAX];
> +
> +	memset(mismatch, 0, nproc * sizeof(*mismatch));
> +
> +	for (int i = 0; i < nproc; i++) {
> +		int online = 1;
> +		unsigned long long msr_highest_perf = 0, sysfs_highest_perf = 0;
> +
> +		if (i) {
> +			snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/online", i);
> +			SAFE_FILE_SCANF(path, "%d", &online);
> +		}
> +
> +		if (!online) {
> +			tst_res(TINFO, "CPU%d offline, skipping", i);
> +			continue;
> +		}
> +
> +		snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/acpi_cppc/highest_perf", i);
> +		SAFE_FILE_SCANF(path, "%llu", &sysfs_highest_perf);
> +		tst_res(TDEBUG, "%s: %llu", path, sysfs_highest_perf);
> +
> +		snprintf(path, sizeof(path), "/dev/cpu/%d/msr", i);
> +		fd = SAFE_OPEN(path, O_RDONLY);
> +
> +		SAFE_PREAD(1, fd, &msr_highest_perf, sizeof(msr_highest_perf), MSR_HWP_CAPABILITIES);

If I run the test on AMD Ryzen I get EIO here. I suppose that we need to
limit this test to a family of CPUs that match the MSR format we expect.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
