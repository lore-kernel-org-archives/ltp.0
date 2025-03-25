Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3EBC35FFC
	for <ltp@archiver.kernel.org>; Tue, 25 Mar 2025 14:00:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF8743C070D
	for <ltp@archiver.kernel.org>; Tue, 25 Mar 2025 15:00:39 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6ABE23C2FC6
 for <ltp@lists.linux.it>; Tue, 25 Mar 2025 15:00:22 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4FE586024AF
 for <ltp@lists.linux.it>; Tue, 25 Mar 2025 15:00:20 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 557CD2118D;
 Tue, 25 Mar 2025 14:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1742911220;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O341YEq1Ppd0x0lAJB7nRRoCxpjBMWwyY0YYhQYAhHg=;
 b=UCm6bm3kHr2Mz6Jvt2HP+YlIO4iI6zlCOvRub9pWvWfeoqCKhjOyWEuKM3SaYG2uW9JVGm
 V+Q7u+Dh+h9YwBvfS+hPa35mrsZc+u2Od2bF8619YQUBuroFQMV24Gj9ZeD6u+GAvrafJE
 s3VIdQcVdeo+OEE/XtMfM/L9WeM+Z+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1742911220;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O341YEq1Ppd0x0lAJB7nRRoCxpjBMWwyY0YYhQYAhHg=;
 b=h9qOzxk3qpjouudlEIpVgaahAZiNln+8/zsKZScUBHA1jfVBOIOtnFlAszl8BMtm+1tB/D
 9KTJ/J+2kAux3vAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1742911220;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O341YEq1Ppd0x0lAJB7nRRoCxpjBMWwyY0YYhQYAhHg=;
 b=UCm6bm3kHr2Mz6Jvt2HP+YlIO4iI6zlCOvRub9pWvWfeoqCKhjOyWEuKM3SaYG2uW9JVGm
 V+Q7u+Dh+h9YwBvfS+hPa35mrsZc+u2Od2bF8619YQUBuroFQMV24Gj9ZeD6u+GAvrafJE
 s3VIdQcVdeo+OEE/XtMfM/L9WeM+Z+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1742911220;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O341YEq1Ppd0x0lAJB7nRRoCxpjBMWwyY0YYhQYAhHg=;
 b=h9qOzxk3qpjouudlEIpVgaahAZiNln+8/zsKZScUBHA1jfVBOIOtnFlAszl8BMtm+1tB/D
 9KTJ/J+2kAux3vAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3BB7137AC;
 Tue, 25 Mar 2025 14:00:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TJqKNfO24mfuEwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 25 Mar 2025 14:00:19 +0000
Date: Tue, 25 Mar 2025 15:00:18 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20250325140018.GA448693@pevik>
References: <20250305050805.7905-1-wegao@suse.com>
 <20250324120049.29270-1-wegao@suse.com>
 <20250324120049.29270-2-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250324120049.29270-2-wegao@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email,imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 1/2] cpuset02: Convert the test6 from
 cpuset_memory_testset.sh to C code
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

...
> +++ b/testcases/kernel/mem/cpuset/cpuset02.c
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (c) 2025 SUSE LLC <wegao@suse.com>
> + */
> +
> +/*\
> + * Test checks cpuset.mems works with hugepage file.
> + * Based on test6 from cpuset_memory_testset.sh.

very nit: I would add the author name:

 * Based on test6 from cpuset_memory_testset.sh written by Miao Xie.

(We don't need to keep the copyright, but because we likely sooner or later
delete cpuset_memory_testset.sh it's nice to give the original author his credit
for his original idea.)

> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <sys/mount.h>
> +#include <limits.h>
> +#include <sys/param.h>
> +#include <sys/types.h>
> +#include "tst_test.h"
> +
> +#ifdef HAVE_NUMA_V2
> +#include <numa.h>
<numa.h> is not needed, please delete it.

> +#include <numaif.h>
> +#include <errno.h>
<errno.h> is not needed either, please delete it.

> +#include "tst_numa.h"
> +#include "tst_safe_stdio.h"
tst_safe_stdio.h is not needed either, please delete it.

> +#include "numa_helper.h"

numa_helper.h is not needed either, please delete it.

...
> +static void run_test(void)
> +{
> +	int pid;
> +	char node_id_str[256];
> +
> +	cg_cpuset_0 = tst_cg_group_mk(tst_cg, "0");
> +
> +	sprintf(node_id_str, "%u", check_node_id);
> +	SAFE_CG_PRINT(cg_cpuset_0, "cpuset.mems", node_id_str);
> +	SAFE_FILE_PRINTF("/proc/sys/vm/nr_hugepages", "%d", 1);

You changed the /proc/sys/vm/nr_hugepages to 1, because Cyril objected the code
in v6:

SAFE_FILE_PRINTF("/proc/sys/vm/nr_hugepages", "%d", 2 * node->cnt);

But as I note there [1], the original shell test did it this way and kernel docs
allows more than 1 to allocate. I'm obviously missing something.

[1] https://lore.kernel.org/ltp/20250325133611.GB372417@pevik/

> +
> +	pid = SAFE_FORK();
> +
> +	if (!pid) {
> +		SAFE_CG_PRINTF(cg_cpuset_0, "cgroup.procs", "%d", pid);
> +		child();
> +		return;
> +	}
> +
> +	SAFE_WAITPID(pid, NULL, 0);
> +
> +	cg_cpuset_0 = tst_cg_group_rm(cg_cpuset_0);
> +}
> +
> +static void setup(void)
> +{
> +	node = tst_get_nodemap(TST_NUMA_MEM, getpagesize() / 1024);
> +	if (node->cnt <= 1)
> +		tst_brk(TCONF, "test requires NUMA system");
This fails on system with single NUMA memory node. Either it should be compared as:
	if (node->cnt < 1)

or you're checking for 2 NUMA memory nodes (IMHO you want just single ATM.

Also maybe worth to change to "test requires at least one NUMA memory node" as
other tests do, you do have check for NUMA itsef anyway in
TST_TEST_TCONF(NUMA_ERROR_MSG).

> +
> +	check_node_id = node->map[0];
> +
> +	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
> +}
> +
> +static void cleanup(void)
> +{
> +	if (cg_cpuset_0)
> +		cg_cpuset_0 = tst_cg_group_rm(cg_cpuset_0);
> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.runs_script = 1,
> +	.mntpoint = MNTPOINT,
> +	.needs_hugetlbfs = 1,
> +	.setup = setup,
> +	.forks_child = 1,
> +	.cleanup = cleanup,
> +	.test_all = run_test,
> +	.hugepages = {3, TST_NEEDS},
> +	.needs_checkpoints = 1,
> +	.needs_cgroup_ver = TST_CG_V1,
> +	.needs_cgroup_ctrls = (const char *const []){ "cpuset", NULL },
> +	.save_restore = (const struct tst_path_val[]) {
> +		{"/proc/sys/vm/nr_hugepages", NULL, TST_SR_TBROK},
Shouldn't here be rather TST_SR_TCONF?

Thanks for the changelog, the rest of the changes LGTM.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
