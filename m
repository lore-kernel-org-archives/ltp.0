Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE41C35FFC
	for <ltp@archiver.kernel.org>; Tue, 25 Mar 2025 13:36:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 789BC3C9A79
	for <ltp@archiver.kernel.org>; Tue, 25 Mar 2025 14:36:33 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 45E0B3C19F4
 for <ltp@lists.linux.it>; Tue, 25 Mar 2025 14:36:16 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 89A661A0C27E
 for <ltp@lists.linux.it>; Tue, 25 Mar 2025 14:36:14 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9C61121179;
 Tue, 25 Mar 2025 13:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1742909772;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HkFqdEb1M8gM1xiCko5qhaGq3NqnAsCbRBIQhwUikV0=;
 b=NP2jdylyIEEMSOGivKUWvSd6Eb00j71Nn3IYY3VGUkZOXm7pbDL4OqTv2k3pRUB3GGVpxz
 zpB99cZtlYrbQr6m74fkWeF9DGLCnDvcWwEbFPNnbh+53EAGoCPC2WVudOHe2ZeHnIPEiz
 iDt7SC8iDP51JxhBSk2wzBKFA9fz9aE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1742909772;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HkFqdEb1M8gM1xiCko5qhaGq3NqnAsCbRBIQhwUikV0=;
 b=yf3RX5c5ckIppk5ViK6Edqa0h5HG9knGfQitdNqo72dmoyBWdhhlJaBHl3b+vkzX1FU1D7
 wzH5ElR9XaiwBBBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1742909772;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HkFqdEb1M8gM1xiCko5qhaGq3NqnAsCbRBIQhwUikV0=;
 b=NP2jdylyIEEMSOGivKUWvSd6Eb00j71Nn3IYY3VGUkZOXm7pbDL4OqTv2k3pRUB3GGVpxz
 zpB99cZtlYrbQr6m74fkWeF9DGLCnDvcWwEbFPNnbh+53EAGoCPC2WVudOHe2ZeHnIPEiz
 iDt7SC8iDP51JxhBSk2wzBKFA9fz9aE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1742909772;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HkFqdEb1M8gM1xiCko5qhaGq3NqnAsCbRBIQhwUikV0=;
 b=yf3RX5c5ckIppk5ViK6Edqa0h5HG9knGfQitdNqo72dmoyBWdhhlJaBHl3b+vkzX1FU1D7
 wzH5ElR9XaiwBBBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70DF913957;
 Tue, 25 Mar 2025 13:36:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bRblGUyx4meVCwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 25 Mar 2025 13:36:12 +0000
Date: Tue, 25 Mar 2025 14:36:11 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250325133611.GB372417@pevik>
References: <20241209060117.16870-1-wegao@suse.com>
 <20250305050805.7905-1-wegao@suse.com>
 <20250305050805.7905-2-wegao@suse.com> <Z88Ymlng3tEOKi0P@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z88Ymlng3tEOKi0P@yuki.lan>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/2] cpuset02: Convert the test6 from
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

> Hi!
> > diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> > index 73b696c58..545c779e7 100644
> > --- a/lib/tst_cgroup.c
> > +++ b/lib/tst_cgroup.c
> > @@ -204,6 +204,7 @@ static const struct cgroup_file cpuset_ctrl_files[] = {
> >  	{ "cpuset.cpus", "cpuset.cpus", CTRL_CPUSET },
> >  	{ "cpuset.mems", "cpuset.mems", CTRL_CPUSET },
> >  	{ "cpuset.memory_migrate", "cpuset.memory_migrate", CTRL_CPUSET },
> > +	{ "cpuset.sched_load_balance", "cpuset.sched_load_balance", CTRL_CPUSET },
> >  	{ }
> >  };

> > diff --git a/runtest/mm b/runtest/mm
> > index d8e62af81..5af29b0ea 100644
> > --- a/runtest/mm
> > +++ b/runtest/mm
> > @@ -75,6 +75,7 @@ ksm06_2 ksm06 -n 8000
> >  ksm07 ksm07

> >  cpuset01 cpuset01
> > +cpuset02 cpuset02

> >  oom01 oom01
> >  oom02 oom02
> > diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> > index 699e022fb..e24e96001 100644
> > --- a/testcases/kernel/mem/.gitignore
> > +++ b/testcases/kernel/mem/.gitignore
> > @@ -1,4 +1,5 @@
> >  /cpuset/cpuset01
> > +/cpuset/cpuset02
> >  /hugetlb/hugefallocate/hugefallocate01
> >  /hugetlb/hugefallocate/hugefallocate02
> >  /hugetlb/hugefork/hugefork01
> > diff --git a/testcases/kernel/mem/cpuset/Makefile b/testcases/kernel/mem/cpuset/Makefile
> > index bac13e02b..7010c7be4 100644
> > --- a/testcases/kernel/mem/cpuset/Makefile
> > +++ b/testcases/kernel/mem/cpuset/Makefile
> > @@ -19,6 +19,11 @@

> >  top_srcdir		?= ../../../..

> > +LTPLIBS = numa
> > +
> >  include $(top_srcdir)/include/mk/testcases.mk
> >  include $(top_srcdir)/testcases/kernel/include/lib.mk
> > +
> > +cpuset02: LTPLDLIBS = -lltpnuma
> > +
> >  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> > diff --git a/testcases/kernel/mem/cpuset/cpuset02.c b/testcases/kernel/mem/cpuset/cpuset02.c
> > new file mode 100644
> > index 000000000..f43d8e98a
> > --- /dev/null
> > +++ b/testcases/kernel/mem/cpuset/cpuset02.c
> > @@ -0,0 +1,139 @@
> > +// SPDX-License-Identifier: LGPL-2.1-or-later
> > +/*
> > + * Copyright (c) 2009 FUJITSU LIMITED  Miao Xie <miaox@cn.fujitsu.com>
> > + * Copyright (c) 2023 SUSE LLC <wegao@suse.com>
> > + */
> > +
> > +/*\
> > + * Test checks cpuset.mems works with hugepage file.
> > + */
> > +
> > +#define _GNU_SOURCE
> > +#include <stdio.h>
> > +#include <sys/mount.h>
> > +#include <limits.h>
> > +#include <sys/param.h>
> > +#include <sys/types.h>
> > +#include "tst_test.h"
> > +
> > +#ifdef HAVE_NUMA_V2
> > +#include <numa.h>
> > +#include <numaif.h>
> > +#include <errno.h>
> > +#include "tst_numa.h"
> > +#include "tst_safe_stdio.h"
> > +#include "numa_helper.h"
> > +
> > +#define MNTPOINT "hugetlbfs/"
> > +#define HUGE_PAGE_FILE MNTPOINT "hugepagefile"
> > +#define PAGES_ALLOCATED 16u
> > +
> > +static long hpage_size;
> > +static struct tst_nodemap *node;
> > +static struct tst_cg_group *cg_cpuset_0;
> > +
> > +static void touch_memory_and_check_node(char *p, int size)
> > +{
> > +	int i;
> > +	int node = -1;
> > +	long ret;
> > +	int pagesize = sysconf(_SC_PAGESIZE);
> > +
> > +	for (i = 0; i < size; i += pagesize)
> > +		p[i] = 0xef;
> > +
> > +	ret = get_mempolicy(&node, NULL, 0, p, MPOL_F_NODE | MPOL_F_ADDR);
> > +	if (ret < 0)
> > +		tst_brk(TBROK | TERRNO, "get_mempolicy() failed");
> > +
> > +	if (node == 0)
> > +		tst_res(TPASS, "check node pass");
> > +	else
> > +		tst_res(TFAIL, "check node failed");
> > +}
> > +
> > +static void child(void)
> > +{
> > +	char *p;
> > +	int fd_hugepage;
> > +
> > +	TST_CHECKPOINT_WAIT(0);
> > +
> > +	fd_hugepage = SAFE_OPEN(HUGE_PAGE_FILE, O_CREAT | O_RDWR, 0755);
> > +	p = SAFE_MMAP(NULL, hpage_size, PROT_WRITE | PROT_READ,
> > +				MAP_SHARED, fd_hugepage, 0);
> > +
> > +	touch_memory_and_check_node(p, hpage_size);
> > +
> > +	SAFE_MUNMAP(p, hpage_size);
> > +	SAFE_CLOSE(fd_hugepage);
> > +
> > +	TST_CHECKPOINT_WAKE(1);
> > +}
> > +
> > +static void run_test(void)
> > +{
> > +	int pid;
> > +
> > +	cg_cpuset_0 = tst_cg_group_mk(tst_cg, "0");
> > +
> > +	SAFE_CG_PRINT(cg_cpuset_0, "cpuset.cpus", "0");
> > +	SAFE_CG_PRINT(cg_cpuset_0, "cpuset.mems", "0");
> > +	SAFE_CG_PRINT(cg_cpuset_0, "cpuset.sched_load_balance", "0");

> Here you are locking the process to node0 but that does not necessarily
> means that the node0 has enough memory or CPUs. You have to choose a
> node from the nodemap that you got in the setup.

> Also if you want to have a node with CPU, so that you can lock the
> process there, you need to add TST_NUMA_CPU flag to the
> tst_get_nodemap(). And yes, there are machines that can have node with
> just memory or just CPU.

> However in the touch_memory_and_check_node() we just check a node the
> memory was allocated on. So I do not think that we need to lock the
> process on a particular CPU. And I do not think that we need the se the
> sched_load_balance either.

[ commenting old version, there is v7 already ]

Thanks for catching these. For a record original shell test does not set
cpuset.cpus, only cpuset.mems.

> > +	SAFE_FILE_PRINTF("/proc/sys/vm/nr_hugepages", "%d", 2 * node->cnt);

> What is this needed for and why is there the 2*node->cnt useful for? As
> far as I can tell, we allocate a single page on a given node.

For a record, shell test does:

echo $((2*$nr_mems)) > /proc/sys/vm/nr_hugepages

I don't have deep understanding of hugetlbpage and NUMA, but kernel hugetlbpage
allows more huge pages in the kernel's huge page pool:
https://www.kernel.org/doc/Documentation/vm/hugetlbpage.txt

echo 20 > /proc/sys/vm/nr_hugepages

Kind regards,
Petr

> > +	pid = SAFE_FORK();
> > +
> > +	if (!pid) {
> > +		child();
> > +		return;
> > +	}
> > +
> > +	SAFE_CG_PRINTF(cg_cpuset_0, "cgroup.procs", "%d", pid);

> We can just get rid of all the checkpoints if this is done by the child
> process before it calls the child() function.

> > +	TST_CHECKPOINT_WAKE(0);
> > +	TST_CHECKPOINT_WAIT(1);
> > +
> > +	SAFE_WAITPID(pid, NULL, 0);

> We should not wait processes if we are not interested in their return
> value. Such children are collected automatically by the test library.

> > +	cg_cpuset_0 = tst_cg_group_rm(cg_cpuset_0);
> > +}
> > +
> > +static void setup(void)
> > +{
> > +	node = tst_get_nodemap(TST_NUMA_MEM, PAGES_ALLOCATED * getpagesize() / 1024);
>                                                ^
> 					       Why is this here? The
> 					       child in the test
> 					       allocates just a single
> 					       page.
> > +	if (node->cnt <= 1)
> > +		tst_brk(TCONF, "test requires NUMA system");
> > +
> > +	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
> > +}
> > +
> > +static void cleanup(void)
> > +{
> > +	if (cg_cpuset_0)
> > +		cg_cpuset_0 = tst_cg_group_rm(cg_cpuset_0);
> > +}
> > +
> > +static struct tst_test test = {
> > +	.needs_root = 1,
> > +	.runs_script = 1,
> > +	.mntpoint = MNTPOINT,
> > +	.needs_hugetlbfs = 1,
> > +	.setup = setup,
> > +	.forks_child = 1,
> > +	.cleanup = cleanup,
> > +	.test_all = run_test,
> > +	.hugepages = {3, TST_NEEDS},
> > +	.needs_checkpoints = 1,
> > +	.needs_cgroup_ver = TST_CG_V1,
> > +	.needs_cgroup_ctrls = (const char *const []){ "cpuset", NULL },
> > +	.save_restore = (const struct tst_path_val[]) {
> > +		{"/proc/sys/vm/nr_hugepages", NULL, TST_SR_TBROK},
> > +		{}
> > +	},
> > +};
> > +
> > +#else
> > +TST_TEST_TCONF(NUMA_ERROR_MSG);
> > +#endif
> > -- 
> > 2.35.3


> > -- 
> > Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
