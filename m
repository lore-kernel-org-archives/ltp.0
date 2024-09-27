Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C392CEBF8F
	for <ltp@archiver.kernel.org>; Fri, 27 Sep 2024 10:31:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C2A33C5270
	for <ltp@archiver.kernel.org>; Fri, 27 Sep 2024 12:31:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9091B3C4F7F
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 12:31:13 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 13A81603270
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 12:31:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3AFAC1FD9A;
 Fri, 27 Sep 2024 10:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727433072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jYRaj9J62xDP3L5s+xEDd8qcneaZw3MXaCCTYgCdcWo=;
 b=clnVbZRTfgkTt7B9dT3b0EzRr79H7kYEHWlR2sQA23mEzScn+C66GpNfrTUPNly6Vduw9u
 UT1dbuQTgR49A1vKr1LqNvKeRf/TJElbImf56PjslbwYIZ7bAheo9y6dQNqBtLOvmGBOQC
 vmDg/kNMNy9Jm9fyjiqpywPsQElzlVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727433072;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jYRaj9J62xDP3L5s+xEDd8qcneaZw3MXaCCTYgCdcWo=;
 b=8JE8EdNgKfbiTWqFlWLIY1mJyZZlqitUL7uwRfJM+Pf1D9hM5vw/WNLvhLHoPfzlUdd9+Y
 C/NywUxlgMY5vwDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727433071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jYRaj9J62xDP3L5s+xEDd8qcneaZw3MXaCCTYgCdcWo=;
 b=vneF9aRHY+ROX9WTfuy3jCb/Dc5zva1MkRXoPBmg7vpP8G7318fVP7gcx746S9zfRaFPd2
 seSI8E3NNxoQ5q+9IzrTPOAOU2fPRtSzOmZPzaBi0UsLrGc1AuPCLHqLqctoVFcRqJLSsU
 W5b2uBjT5ZKPOd/hcaafFbpIgcMsGPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727433071;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jYRaj9J62xDP3L5s+xEDd8qcneaZw3MXaCCTYgCdcWo=;
 b=Cg/2fD5TzePt8bhoD53HDZZvdEhNHuAcWVXfiNRLLLww3ojEs3qZostQsKY12zJit9FvPa
 AHBQl/biVyQVhZDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2BB541386E;
 Fri, 27 Sep 2024 10:31:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id T0auCW+J9mYTWwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 27 Sep 2024 10:31:11 +0000
Date: Fri, 27 Sep 2024 12:30:04 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <ZvaJLMcoPXgscmw1@yuki.lan>
References: <20240819044901.17380-1-wegao@suse.com>
 <20240926061936.21499-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240926061936.21499-1-wegao@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] cpuset02: Reimplementing the test6 of
 cpuset_memory_testset.sh as a separate C testcase
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
> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> index d88484fa1..0845297cb 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -1,4 +1,5 @@
>  /cpuset/cpuset01
> +/cpuset/cpuset02
>  /hugetlb/hugefallocate/hugefallocate01
>  /hugetlb/hugefallocate/hugefallocate02
>  /hugetlb/hugefork/hugefork01
> diff --git a/testcases/kernel/mem/cpuset/cpuset02.c b/testcases/kernel/mem/cpuset/cpuset02.c
> new file mode 100644
> index 000000000..05ed5c791
> --- /dev/null
> +++ b/testcases/kernel/mem/cpuset/cpuset02.c
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (c) 2009 FUJITSU LIMITED  Miao Xie <miaox@cn.fujitsu.com>
> + * Copyright (c) 2023 SUSE LLC <wegao@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This is reimplementing the test6 of cpuset_memory_testset.sh

This is _WRONG_.

You have to describe what the test does here, not where it came from.

> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <sys/mount.h>
> +#include <limits.h>
> +#include <sys/param.h>
> +#include <sys/types.h>
> +
> +#include "tst_test.h"
> +
> +#if HAVE_NUMA_H
> +#include <numa.h>
> +#endif
> +#if HAVE_NUMAIF_H
> +#include <numaif.h>
> +#endif
> +
> +#include "tst_safe_stdio.h"
> +#include "mem.h"
> +#include "numa_helper.h"
> +
> +#define MNTPOINT "hugetlbfs/"
> +#define CPUSET "cpuset_mnt"
> +
> +#ifdef HAVE_NUMA_V2
> +
> +static long hpage_size;
> +static int ncpus;
> +static int *nodes;
> +static int nnodes;
> +
> +static void count_cpus_mems(void)
> +{
> +	while (path_exist(PATH_SYS_SYSTEM "/cpu/cpu%d", ncpus))
> +		ncpus++;
> +	if (get_allowed_nodes_arr(NH_MEMS | NH_CPUS, &nnodes, &nodes) < 0)
> +		tst_brk(TBROK | TERRNO, "get_allowed_nodes_arr");
> +	if (nnodes <= 1)
> +		tst_brk(TCONF, "requires a NUMA system.");
> +}

You must use the tst_get_nodemap() instead which also allows you to
specify how much free memory is required for each NUMA node.

> +static void run_test(void)
> +{
> +	char path[256];
> +	char tmp_path[256];
> +
> +	snprintf(path, sizeof(path), "./%s/0", CPUSET);
> +	if (access(path, F_OK) != 0)
> +		SAFE_MKDIR(path, 0777);
> +	snprintf(tmp_path, sizeof(tmp_path), "./%s/cpuset.cpus", path);
> +	SAFE_FILE_PRINTF(tmp_path, "%s", "0");
> +	snprintf(tmp_path, sizeof(tmp_path), "./%s/cpuset.mems", path);
> +	SAFE_FILE_PRINTF(tmp_path, "%s", "0");
> +	snprintf(tmp_path, sizeof(tmp_path), "./%s/cpuset.sched_load_balance", path);
> +	SAFE_FILE_PRINTF(tmp_path, "%s", "0");
> +	SAFE_FILE_PRINTF("/proc/sys/vm/nr_hugepages", "%d", 2 * nnodes);
> +
> +	int pid;
> +	char str_hpage_size[20];
> +
> +	snprintf(str_hpage_size, sizeof(str_hpage_size), "%ld", hpage_size);
> +	snprintf(tmp_path, sizeof(tmp_path), "%shugepagefile", MNTPOINT);
> +
> +	char *argv[10] = {
> +		"--mmap-file",
> +		"--hugepage",
> +		"-s",
> +		str_hpage_size,
> +		"-f",
> +		tmp_path,
> +		NULL,
> +	};
> +
> +	int fd = SAFE_OPEN("memory_result", O_WRONLY | O_CREAT | O_TRUNC, 0644);
> +
> +	SAFE_DUP2(fd, STDOUT_FILENO);
> +	pid = tst_run_script("cpuset_memory_test", argv);
> +	close(fd);
> +
> +	sleep(1);
> +	snprintf(tmp_path, sizeof(tmp_path), "./%s/tasks", path);
> +	SAFE_FILE_PRINTF(tmp_path, "%d", pid);
> +	kill(pid, SIGUSR1);
> +	sleep(1);
> +	kill(pid, SIGUSR1);
> +	sleep(1);
> +	kill(pid, SIGINT);
> +	SAFE_WAITPID(pid, NULL, 0);
> +
> +	char node[20];
> +	FILE *file;
> +
> +	file  = SAFE_FOPEN("memory_result", "r");
> +
> +	if (fgets(node, sizeof(node), file) == NULL)
> +		tst_res(TFAIL, "read memory_result failed");
> +
> +	fclose(file);

The whole point of the rewrite is to get rid of this mess where we
propagate the test results in files.

The code that allocates the memory has to be in this test and use proper
synchronization between processes, i.e. checkpoints. This would also
avoid the need to propagate test results because the forked child could
report results directly.

> +	TST_EXP_PASS(strncmp(node, "0", 1));
> +}
> +
> +static void setup(void)
> +{
> +	count_cpus_mems();
> +
> +	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
> +	SAFE_MKDIR(CPUSET, 0777);
> +	SAFE_MOUNT("cpuset", CPUSET, "cgroup", 0, "cpuset");

You have to use the .needs_cgroup_ctrls in tst_test instead.

> +}
> +
> +static void cleanup(void)
> +{
> +	SAFE_UMOUNT(CPUSET);
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
> +	.save_restore = (const struct tst_path_val[]) {
> +		{"/proc/sys/vm/nr_hugepages", NULL, TST_SR_TBROK},
> +		{}
> +	},
> +};
> +
> +#else
> +TST_TEST_TCONF(NUMA_ERROR_MSG);
> +#endif
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
