Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E12F606A31C
	for <ltp@archiver.kernel.org>; Fri, 27 Nov 2026 12:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=OXaDHwor;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=zvua5P3M;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=OXaDHwor;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=zvua5P3M
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 99EAF3EA8DA
	for <ltp@archiver.kernel.org>; Fri, 27 Nov 2026 13:28:35 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C4CBC3E9DC9
 for <ltp@lists.linux.it>; Fri, 27 Nov 2026 13:28:19 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1EB24200ADA
 for <ltp@lists.linux.it>; Fri, 27 Nov 2026 13:28:18 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 645AF2293B;
 Fri, 27 Nov 2026 12:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1795782497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SSr0pcE5KILDHaL/hJ+G+4r9J1ZSf3q5+d/PrteZjxs=;
 b=OXaDHwor0YEBtWl7umIYR5YUmeLCm76xzLrIrPZ8y5mk7XXGLE7R/Hbb5HHOKb3op1ZaYD
 A33trjQusnxCtD03ytsLOKFbaFj8+cxMjsEb3YNgpwNlXWTqZCY/3tadzmVIcdEWvwYUJf
 R8yz1u7bnDRqbZrdn0oGkGaAL/Bny+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1795782497;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SSr0pcE5KILDHaL/hJ+G+4r9J1ZSf3q5+d/PrteZjxs=;
 b=zvua5P3MgjuMhqz7gty1MohoqCOgfow8Wno1a0JUPAB8Emn7QvEu2+xaJ35HBgjvndkg5J
 8GvA/YcrVE2qCyAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OXaDHwor;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zvua5P3M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1795782497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SSr0pcE5KILDHaL/hJ+G+4r9J1ZSf3q5+d/PrteZjxs=;
 b=OXaDHwor0YEBtWl7umIYR5YUmeLCm76xzLrIrPZ8y5mk7XXGLE7R/Hbb5HHOKb3op1ZaYD
 A33trjQusnxCtD03ytsLOKFbaFj8+cxMjsEb3YNgpwNlXWTqZCY/3tadzmVIcdEWvwYUJf
 R8yz1u7bnDRqbZrdn0oGkGaAL/Bny+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1795782497;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SSr0pcE5KILDHaL/hJ+G+4r9J1ZSf3q5+d/PrteZjxs=;
 b=zvua5P3MgjuMhqz7gty1MohoqCOgfow8Wno1a0JUPAB8Emn7QvEu2+xaJ35HBgjvndkg5J
 8GvA/YcrVE2qCyAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36124134E8;
 Fri, 27 Nov 2026 12:28:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OBsTBWF3CWs0VgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 27 Nov 2026 12:28:17 +0000
Date: Fri, 27 Nov 2026 13:28:48 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Samir Mulani <samir@linux.ibm.com>
Message-ID: <awl3gDBVkYtgW9oB@yuki.lan>
References: <20261024023044.80055-1-samir@linux.ibm.com>
 <20261024023044.80055-2-samir@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261024023044.80055-2-samir@linux.ibm.com>
X-Spamd-Result: default: False [-13.51 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 645AF2293B
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/4] sched/psi: Add psi_invalid_trigger01 test
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Add a test case to verify trigger input validation in /proc/pressure/memory.
> 
> In the kernel (kernel/sched/psi.c), the trigger parsing logic (psi_trigger_create)
> is identical and shared across /proc/pressure/{cpu,memory,io}. Therefore,
> testing /proc/pressure/memory validates the parser for all PSI interfaces.
> 
> The test checks that invalid trigger strings return -EINVAL:
> - Invalid trigger state (not "some" or "full")
> - Missing threshold or window values
> - Non-numeric or negative numbers
> - Zero threshold or zero window
> - Threshold larger than window
> - Window larger than the 10 second maximum
> 
> It also checks that valid boundary values succeed:
> - Smallest threshold (1us)
> - Threshold equal to window
> - Valid windows of 500ms, 2s, and 10s
> - Valid "full" state
> 
> Note: The kernel overwrites the last byte of the input buffer with '\0',
> so we write strlen() + 1 bytes to prevent losing the last character.
> 
> Requires CAP_SYS_RESOURCE for custom window sizes. Reports TCONF if
> CONFIG_PSI is not enabled or disabled with psi=0.
> 
> This patch also adds the testcases/kernel/sched/psi directory, Makefile,
> and .gitignore.
> 
> Signed-off-by: Samir Mulani <samir@linux.ibm.com>
> ---
>  runtest/sched                                 |   2 +
>  testcases/kernel/sched/psi/.gitignore         |   1 +
>  testcases/kernel/sched/psi/Makefile           |   7 +
>  .../kernel/sched/psi/psi_invalid_trigger01.c  | 135 ++++++++++++++++++
>  4 files changed, 145 insertions(+)
>  create mode 100644 testcases/kernel/sched/psi/.gitignore
>  create mode 100644 testcases/kernel/sched/psi/Makefile
>  create mode 100644 testcases/kernel/sched/psi/psi_invalid_trigger01.c
> 
> diff --git a/runtest/sched b/runtest/sched
> index ecedd1a92..cc6e703d7 100644
> --- a/runtest/sched
> +++ b/runtest/sched
> @@ -20,3 +20,5 @@ sched_stress sched_stress.sh
>  autogroup01 autogroup01
>  
>  sched_football sched_football
> +
> +psi_invalid_trigger01 psi_invalid_trigger01
> diff --git a/testcases/kernel/sched/psi/.gitignore b/testcases/kernel/sched/psi/.gitignore
> new file mode 100644
> index 000000000..1d615553a
> --- /dev/null
> +++ b/testcases/kernel/sched/psi/.gitignore
> @@ -0,0 +1 @@
> +/psi_invalid_trigger01
> diff --git a/testcases/kernel/sched/psi/Makefile b/testcases/kernel/sched/psi/Makefile
> new file mode 100644
> index 000000000..18896b6f2
> --- /dev/null
> +++ b/testcases/kernel/sched/psi/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/sched/psi/psi_invalid_trigger01.c b/testcases/kernel/sched/psi/psi_invalid_trigger01.c
> new file mode 100644
> index 000000000..c532d1ae4
> --- /dev/null
> +++ b/testcases/kernel/sched/psi/psi_invalid_trigger01.c
> @@ -0,0 +1,135 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2026 IBM Corp.
> + * Author: Samir Mulani <samir@linux.ibm.com>
> + */
> +
> +/*\
> + * Verify that the PSI trigger parser rejects invalid trigger definitions
> + * written to /proc/pressure/memory with EINVAL and accepts valid ones.
> + *
> + * Each sub-case opens a fresh file descriptor, because only one trigger can
> + * be registered per open file description (a second write fails with EBUSY).
> + *
> + * Rejected with EINVAL:
> + *
> + * - Invalid state keyword: "invalid 100000 1000000"
> + * - Only state keyword: "some"
> + * - Missing window value: "some 100000"
> + * - Non-numeric threshold: "some abc 1000000"
> + * - Non-numeric window: "some 100000 abc"
> + * - Negative threshold: "some -1 1000000"
> + * - Zero threshold: "some 0 1000000"
> + * - Zero window: "some 100000 0"
> + * - Threshold greater than window: "some 1000001 1000000"
> + * - Window greater than the 10s maximum: "some 100000 10000001"
> + * - Window far above the maximum: "some 100000 4294967295"
> + *
> + * Accepted, the write returns the number of bytes written:
> + *
> + * - Smallest threshold: "some 1 1000000"
> + * - Documented minimum window of 500ms: "some 100000 500000"
> + * - Window of 2s: "some 100000 2000000"
> + * - Threshold equal to window: "some 1000000 1000000"
> + * - Window equal to the 10s maximum: "some 100000 10000000"
> + * - The "full" state: "full 100000 1000000"
> + *
> + * The documentation says that windows below 500ms are not accepted, but the
> + * kernel does not enforce a lower limit, so the test does not check for it.
> + */
> +
> +#include <string.h>
> +
> +#include "tst_test.h"
> +
> +#define PSI_MEM "/proc/pressure/memory"
> +
> +static struct tcase {
> +	const char *desc;
> +	const char *input;
> +	int exp_errno;		/* 0 = expect success */
                                   ^
				   This is commeting obvious.

> +} tcases[] = {
> +	{"invalid state keyword", "invalid 100000 1000000", EINVAL},
> +	{"only state keyword", "some", EINVAL},
> +	{"missing window value", "some 100000", EINVAL},
> +	{"non-numeric threshold", "some abc 1000000", EINVAL},
> +	{"non-numeric window", "some 100000 abc", EINVAL},
> +	{"negative threshold", "some -1 1000000", EINVAL},
> +	{"zero threshold", "some 0 1000000", EINVAL},
> +	{"zero window", "some 100000 0", EINVAL},
> +	{"threshold greater than window", "some 1000001 1000000", EINVAL},
> +	{"window greater than 10s maximum", "some 100000 10000001", EINVAL},
> +	{"window far above 10s maximum", "some 100000 4294967295", EINVAL},
> +	{"smallest threshold", "some 1 1000000", 0},
> +	{"500ms window", "some 100000 500000", 0},
> +	{"2s window", "some 100000 2000000", 0},
> +	{"threshold equal to window", "some 1000000 1000000", 0},
> +	{"window equal to 10s maximum", "some 100000 10000000", 0},
> +	{"full state", "full 100000 1000000", 0},
> +};
> +
> +static void run(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +	/*
> +	 * The kernel overwrites the last byte of the written buffer with
> +	 * a NUL, so the terminating '\0' has to be part of the write.
> +	 */
> +	size_t len = strlen(tc->input) + 1;
> +	int fd;
> +
> +	fd = SAFE_OPEN(PSI_MEM, O_RDWR);
> +
> +	if (tc->exp_errno) {
> +		TST_EXP_FAIL2(write(fd, tc->input, len), tc->exp_errno,
> +			      "%s", tc->desc);
> +	} else {
> +		TEST(write(fd, tc->input, len));
> +
> +		if (TST_RET == (long)len)
> +			tst_res(TPASS, "%s: trigger accepted", tc->desc);
> +		else if (TST_RET == -1)
> +			tst_res(TFAIL | TTERRNO, "%s: write failed", tc->desc);
> +		else
> +			tst_res(TFAIL, "%s: wrote %ld bytes, expected %zu",
> +				tc->desc, TST_RET, len);
> +	}
> +
> +	SAFE_CLOSE(fd);
> +}
> +
> +static void setup(void)
> +{
> +	char buf[64];
> +	int fd;
> +
> +	if (access(PSI_MEM, F_OK))
> +		tst_brk(TCONF, "%s not available (CONFIG_PSI not set)", PSI_MEM);

We already have CONFIG_PSI in needs kconfigs, so this message is
misleading at best.

> +	fd = SAFE_OPEN(PSI_MEM, O_RDONLY);
> +
> +	/* psi=0 on the kernel command line makes the interface return EOPNOTSUPP */
> +	if (read(fd, buf, sizeof(buf)) < 0) {
> +		if (errno == EOPNOTSUPP)
> +			tst_brk(TCONF, "PSI is disabled (psi=0 on kernel command line)");
> +
> +		tst_brk(TBROK | TERRNO, "read(%s) failed", PSI_MEM);
> +	}
> +
> +	SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = run,
> +	.setup = setup,
> +	.needs_root = 1,
> +	.caps = (struct tst_cap []) {
> +		TST_CAP(TST_CAP_REQ, CAP_SYS_RESOURCE),
> +		{}
> +	},
> +	.needs_kconfigs = (const char *const[]) {
> +		"CONFIG_PSI=y",
> +		NULL
> +	},

We should add .save_restore entry for the PSI_MEM here as well.

> +};
> -- 
> 2.53.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
