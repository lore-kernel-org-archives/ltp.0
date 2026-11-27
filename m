Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77060606A31F
	for <ltp@archiver.kernel.org>; Fri, 27 Nov 2026 12:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=0USYCWpu;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=051Ocjue;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=0USYCWpu;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=051Ocjue
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 201ED3E9F08
	for <ltp@archiver.kernel.org>; Fri, 27 Nov 2026 13:55:39 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C06583C26A1
 for <ltp@lists.linux.it>; Fri, 27 Nov 2026 13:55:21 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CFD9B1A00672
 for <ltp@lists.linux.it>; Fri, 27 Nov 2026 13:55:20 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 78A9422965;
 Fri, 27 Nov 2026 12:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1795784117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gGBSFuAodhsxR7qzo+92JDgxuiB8io3xzWXpXYBVzRM=;
 b=0USYCWpuPSzc7BIZEJKPgX+VPWwqYIEC+TRbpnG28J4hoJyCVWLWLYBhEM2AHCe1XOIlnf
 4b7OGlt+m/GPmmyXhCgA2DteN+L5EU8OxxSlYUUXQcQp2kYH4CKGIGAjKI34KkIl1Tfsk3
 65C43egLnzbhC/QimRofsfj2hOxKvfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1795784117;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gGBSFuAodhsxR7qzo+92JDgxuiB8io3xzWXpXYBVzRM=;
 b=051OcjueHjnjvlSn1qurbBR3IPQNSGX06F7Cn3DuUL6fMY2Tbp3A8E9Ntf6nfLk5g0SPfT
 G69ysYQzjBcK9aCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0USYCWpu;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=051Ocjue
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1795784117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gGBSFuAodhsxR7qzo+92JDgxuiB8io3xzWXpXYBVzRM=;
 b=0USYCWpuPSzc7BIZEJKPgX+VPWwqYIEC+TRbpnG28J4hoJyCVWLWLYBhEM2AHCe1XOIlnf
 4b7OGlt+m/GPmmyXhCgA2DteN+L5EU8OxxSlYUUXQcQp2kYH4CKGIGAjKI34KkIl1Tfsk3
 65C43egLnzbhC/QimRofsfj2hOxKvfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1795784117;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gGBSFuAodhsxR7qzo+92JDgxuiB8io3xzWXpXYBVzRM=;
 b=051OcjueHjnjvlSn1qurbBR3IPQNSGX06F7Cn3DuUL6fMY2Tbp3A8E9Ntf6nfLk5g0SPfT
 G69ysYQzjBcK9aCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48B88134E8;
 Fri, 27 Nov 2026 12:55:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dYK6CbV9CWtUcgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 27 Nov 2026 12:55:17 +0000
Date: Fri, 27 Nov 2026 13:55:49 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Samir Mulani <samir@linux.ibm.com>
Message-ID: <awl91YdvLTpgflcN@yuki.lan>
References: <20261024023044.80055-1-samir@linux.ibm.com>
 <20261024023044.80055-4-samir@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261024023044.80055-4-samir@linux.ibm.com>
X-Rspamd-Queue-Id: 78A9422965
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-13.51 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,linux.it:url];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -13.51
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 3/4] sched/psi: Add psi_proc_format01 test
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
> ---
>  runtest/sched                                 |   1 +
>  testcases/kernel/sched/psi/.gitignore         |   1 +
>  .../kernel/sched/psi/psi_proc_format01.c      | 191 ++++++++++++++++++
>  3 files changed, 193 insertions(+)
>  create mode 100644 testcases/kernel/sched/psi/psi_proc_format01.c
> 
> diff --git a/runtest/sched b/runtest/sched
> index b6dc478a0..0651fafd9 100644
> --- a/runtest/sched
> +++ b/runtest/sched
> @@ -23,3 +23,4 @@ sched_football sched_football
>  
>  psi_invalid_trigger01 psi_invalid_trigger01
>  psi_multiple_trigger01 psi_multiple_trigger01
> +psi_proc_format01 psi_proc_format01
> diff --git a/testcases/kernel/sched/psi/.gitignore b/testcases/kernel/sched/psi/.gitignore
> index 23a5e6567..8d1083ff2 100644
> --- a/testcases/kernel/sched/psi/.gitignore
> +++ b/testcases/kernel/sched/psi/.gitignore
> @@ -1,2 +1,3 @@
>  /psi_invalid_trigger01
>  /psi_multiple_trigger01
> +/psi_proc_format01
> diff --git a/testcases/kernel/sched/psi/psi_proc_format01.c b/testcases/kernel/sched/psi/psi_proc_format01.c
> new file mode 100644
> index 000000000..7467e13d5
> --- /dev/null
> +++ b/testcases/kernel/sched/psi/psi_proc_format01.c
> @@ -0,0 +1,191 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2026 IBM Corp.
> + * Author: Samir Mulani <samir@linux.ibm.com>
> + */
> +
> +/*\
> + * Verify the format of the PSI files in /proc/pressure/.
> + *
> + * - /proc/pressure/{cpu,memory,io} have two lines labelled "some" and "full",
> + *   each one carrying avg10, avg60, avg300 and total.
> + * - The averages are percentages, so they have to be between 0 and 100.
> + * - The totals never decrease between two consecutive reads.
> + * - The "full" line of /proc/pressure/cpu is always zero, the full stall
> + *   state is undefined at the system level and is reported as zero for
> + *   backward compatibility since Linux 5.13.
> + *
> + * The accounting of the counters under load is tested by psi_accounting01.
> + */
> +
> +#include <stdio.h>
> +#include <string.h>
> +
> +#include "tst_test.h"
> +#include "tst_safe_stdio.h"
> +
> +#define PSI_CPU "/proc/pressure/cpu"
> +#define PSI_MEM "/proc/pressure/memory"
> +#define PSI_IO "/proc/pressure/io"
> +
> +struct psi_line {
> +	char label[8];
> +	double avg10;
> +	double avg60;
> +	double avg300;
> +	unsigned long long total;
> +};
> +
> +struct psi_snap {
> +	struct psi_line some;
> +	struct psi_line full;
> +};
> +
> +#define PSI_LINE "%7s avg10=%lf avg60=%lf avg300=%lf total=%llu"
> +
> +static const char *const paths[] = {PSI_CPU, PSI_MEM, PSI_IO};
> +
> +/* Returns 0 if both lines were parsed, -1 otherwise */
> +static int read_psi(const char *path, struct psi_snap *snap)
> +{
> +	FILE *fp = SAFE_FOPEN(path, "r");
> +	int ret;
> +
> +	ret = fscanf(fp, PSI_LINE " " PSI_LINE,
> +		snap->some.label, &snap->some.avg10, &snap->some.avg60,
> +		&snap->some.avg300, &snap->some.total,
> +		snap->full.label, &snap->full.avg10, &snap->full.avg60,
> +		&snap->full.avg300, &snap->full.total);
> +
> +	SAFE_FCLOSE(fp);
> +
> +	if (ret != 10) {
> +		tst_res(TFAIL, "%s: parsed %d/10 values", path, ret);
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int avg_valid(double avg)
> +{
> +	/* A NaN fails both comparisons */
> +	return avg >= 0.0 && avg <= 100.0;
> +}
> +
> +static int line_valid(const char *path, const struct psi_line *line,
> +		      const char *label)
> +{
> +	if (strcmp(line->label, label)) {
> +		tst_res(TFAIL, "%s: label is '%s', expected '%s'",
> +			path, line->label, label);
> +		return 0;
> +	}
> +
> +	if (!avg_valid(line->avg10) || !avg_valid(line->avg60) ||
> +	    !avg_valid(line->avg300)) {
> +		tst_res(TFAIL, "%s: '%s' averages out of range: %.2f %.2f %.2f",
> +			path, label, line->avg10, line->avg60, line->avg300);
> +		return 0;
> +	}
> +
> +	return 1;
> +}
> +
> +static void verify_format(unsigned int n)
> +{
> +	struct psi_snap snap;
> +
> +	if (read_psi(paths[n], &snap))
> +		return;
> +
> +	if (line_valid(paths[n], &snap.some, "some") &&
> +	    line_valid(paths[n], &snap.full, "full"))
> +		tst_res(TPASS, "%s has the expected format", paths[n]);
> +}
> +
> +static void verify_monotonic(unsigned int n)
> +{
> +	struct psi_snap first, second;
> +	int i;
> +
> +	if (read_psi(paths[n], &first))
> +		return;
> +
> +	for (i = 0; i < 10; i++) {
> +		usleep(10000);
> +
> +		if (read_psi(paths[n], &second))
> +			return;
> +
> +		if (second.some.total < first.some.total ||
> +		    second.full.total < first.full.total) {
> +			tst_res(TFAIL,
> +				"%s: a total decreased: some %llu -> %llu, full %llu -> %llu",
> +				paths[n], first.some.total, second.some.total,
> +				first.full.total, second.full.total);
> +			return;
> +		}
> +
> +		first = second;

Maybe we should check that the total actually has changed during the
run here, otherwise this will pass with a stale values. Or do we need to
actually put the system under pressure for these to increment?

Also this part of test should be run with runtime, i.e. this loop should
run until tst_remaning_runtime() returns non-zero and the tst_test
structure needs .runtime (default) and .min_runtime set.

> +	}
> +
> +	tst_res(TPASS, "%s totals never decrease", paths[n]);
> +}
> +
> +static void verify_cpu_full_zero(void)
> +{
> +	struct psi_snap snap;
> +
> +	if (read_psi(PSI_CPU, &snap))
> +		return;
> +
> +	if (snap.full.total || snap.full.avg10 || snap.full.avg60 ||
> +	    snap.full.avg300)
> +		tst_res(TFAIL, "%s full line is not zero: avg10=%.2f total=%llu",
> +			PSI_CPU, snap.full.avg10, snap.full.total);
> +	else
> +		tst_res(TPASS, "%s full line is zero", PSI_CPU);
> +}
> +
> +static void run(unsigned int n)
> +{
> +	if (n < ARRAY_SIZE(paths))
> +		verify_format(n);
> +	else if (n < 2 * ARRAY_SIZE(paths))
> +		verify_monotonic(n - ARRAY_SIZE(paths));
> +	else
> +		verify_cpu_full_zero();

Given that we have only three paths, I think that it would be more
readable if we just do

	switch (n) {
	case 0:
		verify_format(PSI_CPU);
		verify_format(PSI_MEM);
		verify_format(PSI_IO);
	break;
	case 1:
		verify_monotonic(PSI_MEM);
		verify_monotonic(PSI_IO);
		verify_cpu_full_zero();
	break;
	}

And set .tcnt = 2,

> +}
> +
> +static void setup(void)
> +{
> +	char buf[64];
> +	int fd;
> +
> +	if (access(PSI_CPU, F_OK))
> +		tst_brk(TCONF, "%s not available (CONFIG_PSI not set)", PSI_CPU);

Again misleading message.

> +	fd = SAFE_OPEN(PSI_CPU, O_RDONLY);
> +
> +	/* psi=0 on the kernel command line makes the interface return EOPNOTSUPP */
> +	if (read(fd, buf, sizeof(buf)) < 0) {
> +		if (errno == EOPNOTSUPP)
> +			tst_brk(TCONF, "PSI is disabled (psi=0 on kernel command line)");
> +
> +		tst_brk(TBROK | TERRNO, "read(%s) failed", PSI_CPU);
> +	}
> +
> +	SAFE_CLOSE(fd);

This check is repeated in all tests, maybe it would make sense to put it
to a shared header.

> +}
> +
> +static struct tst_test test = {
> +	.tcnt = 2 * ARRAY_SIZE(paths) + 1,
> +	.test = run,
> +	.setup = setup,
> +	.min_kver = "5.13",
> +	.needs_kconfigs = (const char *const[]) {
> +		"CONFIG_PSI=y",
> +		NULL
> +	},
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
