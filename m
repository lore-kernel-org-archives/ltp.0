Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61814606A32F
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 12:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=n3ENqMAy;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=FcbKcH9s;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=u6ksRtf+;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Hbo6kgdw
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EFDEB3CBF37
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 13:57:45 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 64A223C4E3F
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 13:57:27 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6AB051000414
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 13:57:26 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E581621DCB;
 Wed,  4 Nov 2026 12:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793797045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HvrQczCEEbkGWRJIA00cRCwmIC8LLyc8q+JxDAA9irM=;
 b=n3ENqMAy6nIiIjC+mHmGZYaIOfZuCyAZPQkXqQgHAbVqqMwwB4YfKmRm9LFp4ht3AF2dtb
 SUUzfQJIHbJWjo2y0r/N3lHWY/ZykVk4Y9flBBkVRh1hMQMGfvBvB744Kdee89cXcFp/Ck
 mcPwCQpPEhFUOf8XKKEXlch2lIQ+DNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793797045;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HvrQczCEEbkGWRJIA00cRCwmIC8LLyc8q+JxDAA9irM=;
 b=FcbKcH9sQQ6nzUx0PbPGLPfIRSeg8+7pHlZQG9lmac22aGJZU+cYWLSjtx4HIqR4KxTOKe
 LB4AybGZGdYUSDDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793797043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HvrQczCEEbkGWRJIA00cRCwmIC8LLyc8q+JxDAA9irM=;
 b=u6ksRtf+DXF6C4OPu4yGQW+ZCBrOeJTebSTJz0OwFfZYraAaBqqwUwGmBLJAmpnr4YE5BH
 PjWL/bgKcaqs12DKlZhMd5c5UNmLRKaxGDizu3ntM+IfgZTuXGJR0AUX/pn6b+yL5+Fych
 NbDxGipOjdmE4O8CYBrA7XZXpVF7P3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793797043;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HvrQczCEEbkGWRJIA00cRCwmIC8LLyc8q+JxDAA9irM=;
 b=Hbo6kgdwqG+m3vfuhSeVUSU3FKL8w4pbuvlYaV/CrHixcslhjrIjH+FxiKTDGXb7rMz90r
 zT06We5iBzdD8DBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D934134F0;
 Wed,  4 Nov 2026 12:57:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Sm/qGLMr62qYDQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 04 Nov 2026 12:57:23 +0000
Date: Wed, 4 Nov 2026 13:57:43 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Changwei Zou <changwei.zou@canonical.com>
Message-ID: <ausrxwEqjwaTRVOe@yuki.lan>
References: <20261104071908.128726-1-changwei.zou@canonical.com>
 <20261104071908.128726-2-changwei.zou@canonical.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261104071908.128726-2-changwei.zou@canonical.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-17.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 REPLY(-4.00)[]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:email,
 cpuset_funcs.sh:url, fujitsu.com:email]
X-Spam-Score: -17.30
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 1/1] cpuset_memory_spread: rewrite as a C test
 using the LTP cgroup library
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
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread01.c b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread01.c
> new file mode 100644
> index 000000000..21d3c0205
> --- /dev/null
> +++ b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread01.c
> @@ -0,0 +1,355 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2009 FUJITSU LIMITED
> + * Author: Miao Xie <miaox@cn.fujitsu.com>
> + *
> + * Rewritten into a single C test using the LTP cgroup library.
> + */
> +
> +/*\
> + * Verify the ``cpuset.memory_spread_page`` control file.
> + *
> + * A task's file-backed page cache is normally allocated on the node the
> + * task is running on (local allocation). When ``cpuset.memory_spread_page``
> + * is enabled, the page cache of a task in the cpuset is instead spread
> + * evenly over all the memory nodes allowed by ``cpuset.mems``.
> + *
> + * The test attaches itself to a cpuset, populates the page cache of a data
> + * file (by dropping the caches and reading the whole file) and then checks
> + * where the file's pages landed. Instead of looking at the noisy global
> + * per-node page-cache counters in ``/sys``, it accounts for only the data
> + * file's own pages: after reading the file it mmaps it, faults every page
> + * in and uses :manpage:`move_pages(2)` (with a NULL node array, so nothing
> + * is migrated) to learn the NUMA node each of the file's pages resides on.
> + * Every page must be accounted for -- a per-page error fails the run -- so
> + * unrelated page-cache activity on the system cannot perturb the result.
> + *
> + * The test is run with and without spreading over a single and over two
> + * memory nodes and the resulting distribution is verified:
> + *
> + * - with spreading off the pages must land on the local (expected) node,
> + * - with spreading on over several nodes the pages must be spread evenly.
> + *
> + * ``cpuset.memory_spread_page`` exists only in the cgroup v1 cpuset
> + * controller, so the test requires a v1 cpuset hierarchy and is skipped
> + * (TCONF) when cpuset is mounted on the unified (v2) hierarchy.
> + */
> +
> +#include "config.h"
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +
> +#ifdef HAVE_NUMA_H
> +# include <numa.h>
> +#endif
> +
> +#include "tst_test.h"
> +#include "tst_cgroup.h"
> +#include "numa_helper.h"

numa_helper.h is deprecated, please use include/tse_numa.h instead

> +#include "lapi/syscalls.h"
> +
> +#ifdef HAVE_NUMA_V2
> +
> +/* The file whose page-cache placement we test. */
> +#define DATAFILE	"datafile"
> +
> +/* Size of the data file. Large enough to measure an even spread. */
> +#define FILE_MB		100
> +
> +/* Each node needs enough free memory to hold the whole file plus slack. */
> +#define MIN_FREE_KB	(FILE_MB * 1024 + 50 * 1024)
> +
> +/* Query the residing NUMA node of at most this many pages per syscall. */
> +#define MOVE_PAGES_CHUNK	1024
> +
> +/*
> + * The pages must land on the expected node(s); the other nodes may hold at
> + * most this fraction (in percent) of them.
> + */
> +#define UNEXPECTED_TOLERANCE	5
> +
> +/*
> + * When the page cache is spread across several expected nodes, the kernel
> + * spreads it evenly. Every expected node must hold at least
> + * (100 - BALANCE_TOLERANCE) percent of its even share.
> + */
> +#define BALANCE_TOLERANCE	20
> +
> +static int *nodes;
> +static int nnodes;
> +static long page_size;
> +static unsigned long *counts;
> +
> +/* Per-node free memory in kB from /sys/.../nodeN/meminfo. */
> +static long node_memfree(int nd)
> +{
> +	long free_kb = 0;
> +	char path[PATH_MAX];
> +
> +	snprintf(path, sizeof(path),
> +		 PATH_SYS_SYSTEM "/node/node%d/meminfo", nd);
> +	SAFE_FILE_LINES_SCANF(path, "Node %*d MemFree: %ld", &free_kb);
> +
> +	return free_kb;
> +}
> +
> +/*
> + * Populate the page cache of DATAFILE under the current cpuset constraints
> + * by dropping the caches and reading the whole file.
> + */
> +static void populate_page_cache(void)
> +{
> +	int fd;
> +	char buf[BUFSIZ];
> +
> +	sync();
> +	SAFE_FILE_PRINTF("/proc/sys/vm/drop_caches", "3");
> +
> +	fd = SAFE_OPEN(DATAFILE, O_RDONLY);
> +	while (SAFE_READ(0, fd, buf, sizeof(buf)) > 0)
> +		;
> +	SAFE_CLOSE(fd);
> +}
> +
> +/*
> + * Count only DATAFILE's own page-cache pages per NUMA node.
> + *
> + * move_pages(2) with a NULL node array does not move anything; it only
> + * reports, in status[], the NUMA node each already-present page resides on.
> + */
> +static void account_file_pages(void)
> +{
> +	int fd;
> +	struct stat st;
> +	char *addr;
> +	unsigned long npages, i, off;
> +	void **pages;
> +	int *status;
> +
> +	memset(counts, 0, MAXNODES * sizeof(*counts));
> +
> +	fd = SAFE_OPEN(DATAFILE, O_RDONLY);
> +	SAFE_FSTAT(fd, &st);
> +	npages = (st.st_size + page_size - 1) / page_size;
> +	addr = SAFE_MMAP(NULL, st.st_size, PROT_READ, MAP_SHARED, fd, 0);
> +	SAFE_CLOSE(fd);
> +
> +	pages = SAFE_MALLOC(npages * sizeof(*pages));
> +	status = SAFE_MALLOC(npages * sizeof(*status));
> +
> +	/*
> +	 * Fault in every page so it maps the page-cache page populated by
> +	 * populate_page_cache(); move_pages() then reports the node that
> +	 * cache page resides on.
> +	 */
> +	for (i = 0; i < npages; i++) {
> +		volatile char c = addr[i * page_size];
> +
> +		(void)c;
> +		pages[i] = addr + i * page_size;
> +		status[i] = -1;
> +	}
> +
> +	for (off = 0; off < npages; off += MOVE_PAGES_CHUNK) {
> +		unsigned long n = npages - off;
> +
> +		if (n > MOVE_PAGES_CHUNK)
> +			n = MOVE_PAGES_CHUNK;
> +
> +		/*
> +		 * tst_syscall() reports TCONF if move_pages() is not
> +		 * implemented (CONFIG_NUMA_MIGRATION disabled).
> +		 */
> +		TEST(tst_syscall(__NR_move_pages, 0, n, pages + off,
> +				 NULL, status + off, 0));
> +		if (TST_RET == -1)
> +			tst_brk(TBROK | TTERRNO, "move_pages");
> +	}
> +
> +	/*
> +	 * move_pages() can return success while reporting a per-page error
> +	 * (e.g. -ENOENT or -EFAULT) in status[]. Treat any such page as a
> +	 * failure: otherwise the distribution would be computed from only a
> +	 * subset of DATAFILE and could pass incorrectly.
> +	 */
> +	for (i = 0; i < npages; i++) {
> +		if (status[i] < 0 || status[i] >= MAXNODES)
> +			tst_brk(TBROK, "page %lu not accounted (status %d)",
> +				i, status[i]);
> +		counts[status[i]]++;
> +	}
> +
> +	SAFE_MUNMAP(addr, st.st_size);
> +	free(pages);
> +	free(status);
> +}
> +
> +static void check_result(const int *expect, int n_expect, const char *desc)
> +{
> +	unsigned long total = 0, expected_sum = 0, unexpected;
> +	int i;
> +
> +	for (i = 0; i < MAXNODES; i++)
> +		total += counts[i];
> +
> +	if (!total) {
> +		tst_res(TFAIL, "%s: no page cache was populated", desc);
> +		return;
> +	}
> +
> +	for (i = 0; i < n_expect; i++)
> +		expected_sum += counts[expect[i]];
> +
> +	unexpected = total - expected_sum;
> +
> +	tst_res(TINFO,
> +		"%s: unexpected nodes hold %.2f%% of the page cache (tolerance %d%%)",
> +		desc, (double)unexpected * 100 / total, UNEXPECTED_TOLERANCE);
> +
> +	if (unexpected * 100 > total * UNEXPECTED_TOLERANCE) {
> +		tst_res(TFAIL,
> +			"%s: too much page cache on unexpected node(s)", desc);
> +		return;
> +	}
> +
> +	/*
> +	 * Every expected node must hold at least (100 - BALANCE_TOLERANCE)%
> +	 * of its even share. This enforces an even spread across several
> +	 * expected nodes and rejects an expected node that received nothing.
> +	 * A single expected node always passes this check.
> +	 */
> +	for (i = 0; i < n_expect; i++) {
> +		if (counts[expect[i]] * n_expect * 100 <
> +		    expected_sum * (100 - BALANCE_TOLERANCE)) {
> +			tst_res(TFAIL,
> +				"%s: node %d holds too little page cache",
> +				desc, expect[i]);
> +			return;
> +		}
> +	}
> +
> +	tst_res(TPASS, "%s", desc);
> +}
> +
> +/*
> + * The task's CPUs are bound to the local node (nodes[0]) for every case
> + * (see setup()); only cpuset.mems and cpuset.memory_spread_page change.
> + *
> + * mems/expect hold indices into nodes[]: 0 is the local node, 1 the remote
> + * one; a second entry of -1 means "unused".
> + */
> +static const struct tcase {
> +	int spread;
> +	int mems[2];

This could be just const char *mems and we could have just written that
in the run() function instead.

> +	int expect[2];
> +	const char *desc;
> +} tcases[] = {
> +	{0, {0, -1}, {0, -1}, "spread off, mems on the local node"},
> +	{1, {0, -1}, {0, -1}, "spread on, mems on the local node"},
> +	{0, {1, -1}, {1, -1}, "spread off, mems on the remote node"},
> +	{1, {1, -1}, {1, -1}, "spread on, mems on the remote node"},
> +	{0, {0, 1}, {0, -1}, "spread off, mems on both nodes (local allocation)"},
> +	{1, {0, 1}, {0, 1}, "spread on, mems on both nodes (even spread)"},
> +};
> +
> +static void run(unsigned int n)
> +{
> +	const struct tcase *tc = &tcases[n];
> +	int expect[2];
> +	int n_expect = 1;
> +
> +	if (tc->mems[1] >= 0)
> +		SAFE_CG_PRINTF(tst_cg, "cpuset.mems", "%d,%d",
> +			       nodes[tc->mems[0]], nodes[tc->mems[1]]);
> +	else
> +		SAFE_CG_PRINTF(tst_cg, "cpuset.mems", "%d",
> +			       nodes[tc->mems[0]]);
> +
> +	SAFE_CG_PRINTF(tst_cg, "cpuset.memory_spread_page", "%d", tc->spread);
> +
> +	expect[0] = nodes[tc->expect[0]];
> +	if (tc->expect[1] >= 0) {
> +		expect[1] = nodes[tc->expect[1]];
> +		n_expect = 2;
> +	}
> +
> +	populate_page_cache();
> +	account_file_pages();
> +	check_result(expect, n_expect, tc->desc);
> +}
> +
> +static void setup(void)
> +{
> +	int i;
> +
> +	page_size = getpagesize();
> +
> +	if (get_allowed_nodes_arr(NH_MEMS | NH_CPUS, &nnodes, &nodes) < 0)
> +		tst_brk(TBROK | TERRNO, "get_allowed_nodes_arr");
> +	if (nnodes < 2)
> +		tst_brk(TCONF, "requires at least 2 NUMA nodes with CPUs and memory");
> +
> +	/*
> +	 * cpuset.memory_spread_page is a cgroup v1 only knob; it was not
> +	 * carried over to the unified (v2) hierarchy. .needs_cgroup_ver
> +	 * below already restricts the test to a v1 cpuset, this is just a
> +	 * belt-and-suspenders check.
> +	 */
> +	if (!SAFE_CG_HAS(tst_cg, "cpuset.memory_spread_page"))
> +		tst_brk(TCONF, "cpuset.memory_spread_page not available");
> +
> +	for (i = 0; i < 2; i++) {
> +		if (node_memfree(nodes[i]) < MIN_FREE_KB)
> +			tst_brk(TCONF,
> +				"node %d has less than %d kB free memory",
> +				nodes[i], MIN_FREE_KB);
> +	}
> +
> +	counts = SAFE_MALLOC(MAXNODES * sizeof(*counts));
> +
> +	if (tst_fill_file(DATAFILE, 0, 1024 * 1024, FILE_MB))
> +		tst_brk(TBROK | TERRNO, "tst_fill_file(%s)", DATAFILE);
> +
> +	/*
> +	 * Bind the task's CPUs to the local node (nodes[0]) once; every case
> +	 * runs on this node and only varies cpuset.mems. write_node_cpusets()
> +	 * also sets cpuset.mems to nodes[0], which run() overrides per case.
> +	 */
> +	write_node_cpusets(tst_cg, nodes[0]);
> +
> +	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
> +}
> +
> +static void cleanup(void)
> +{
> +	free(nodes);
> +	free(counts);
> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +	/*
> +	 * On tmpfs/ramfs the file data is the page cache itself, so
> +	 * drop_caches cannot evict it and the pages keep the node they got
> +	 * at write time rather than the one chosen by the cpuset policy.
> +	 * The page-cache placement is then not measurable.
> +	 */

Comments like this shouldn't be sprinkled in the code, most of the
documentation about the test should be in the top level doc comment that
gets exported into the documentation.

> +	.skip_filesystems = (const char *const []){ "tmpfs", "ramfs", NULL },
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test = run,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.needs_cgroup_ctrls = (const char *const []){ "cpuset", NULL },
> +	.needs_cgroup_ver = TST_CG_V1,
> +};
> +
> +#else
> +TST_TEST_TCONF("test requires libnuma >= 2");
> +#endif
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
> deleted file mode 100755
> index 4c49bb8fd..000000000
> --- a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
> +++ /dev/null
> @@ -1,362 +0,0 @@
> -#!/bin/sh
> -
> -################################################################################
> -#                                                                              #
> -# Copyright (c) 2009 FUJITSU LIMITED                                           #
> -#                                                                              #
> -# This program is free software;  you can redistribute it and#or modify        #
> -# it under the terms of the GNU General Public License as published by         #
> -# the Free Software Foundation; either version 2 of the License, or            #
> -# (at your option) any later version.                                          #
> -#                                                                              #
> -# This program is distributed in the hope that it will be useful, but          #
> -# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY   #
> -# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License     #
> -# for more details.                                                            #
> -#                                                                              #
> -# You should have received a copy of the GNU General Public License            #
> -# along with this program;  if not, write to the Free Software                 #
> -# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA      #
> -#                                                                              #
> -# Author: Miao Xie <miaox@cn.fujitsu.com>                                      #
> -#                                                                              #
> -################################################################################
> -
> -export TCID="cpuset_memory_spread"
> -export TST_TOTAL=6
> -export TST_COUNT=1
> -
> -. cpuset_funcs.sh
> -
> -check
> -
> -exit_status=0
> -nr_cpus=$NR_CPUS
> -nr_mems=$N_NODES
> -
> -# In general, the cache hog will use more than 10000 kb slab space on the nodes
> -# on which it is running. The other nodes' slab space has littler change.(less
> -# than 1000 kb).
> -upperlimit=10000
> -
> -# set lowerlimit according to pagesize
> -# pagesize(bytes)  | lowerlimit(kb)
> -# ------------------------------------
> -#  4096            | 2048
> -#  16384           | 8192
> -
> -PAGE_SIZE=`tst_getconf PAGESIZE`
> -lowerlimit=$((PAGE_SIZE * 512 / 1024))
> -
> -cpus_all="$(seq -s, 0 $((nr_cpus-1)))"
> -mems_all="$(seq -s, 0 $((nr_mems-1)))"
> -
> -nodedir="/sys/devices/system/node"
> -
> -FIFO="./myfifo"
> -
> -# memsinfo is an array implementation of the form of a multi-line string
> -# _0: value0
> -# _1: value1
> -# _2: value2
> -#
> -memsinfo=""
> -
> -# set value to memsinfo ($1 - index, $2 - value)
> -set_memsinfo_val()
> -{
> -	local nl='
> -'
> -	# clearing existent value (if present)
> -	memsinfo=`echo "$memsinfo" | sed -r "/^\_$1\: /d"`
> -
> -	if [ -z "$memsinfo" ]; then
> -		memsinfo="_$1: $2"
> -	else
> -		memsinfo="$memsinfo${nl}_$1: $2"
> -	fi
> -}
> -
> -# get value from memsinfo ($1 - index)
> -get_memsinfo_val()
> -{
> -	local value=
> -	value=`echo "$memsinfo" | grep -e "^_$1: "`
> -	value=`echo "$value" | sed -r "s/^.*\: (.*)$/\1/"`
> -	echo "$value"
> -}
> -
> -
> -init_memsinfo_array()
> -{
> -	local i=
> -
> -	for i in `seq 0 $((nr_mems-1))`
> -	do
> -		set_memsinfo_val $i 0
> -	done
> -}
> -
> -# get_meminfo <nodeid> <item>
> -get_meminfo()
> -{
> -	local nodeid="$1"
> -	local nodepath="$nodedir/node$nodeid"
> -	local nodememinfo="$nodepath/meminfo"
> -	local item="$2"
> -	local info=`cat $nodememinfo | grep $item | awk '{print $4}'`
> -	set_memsinfo_val $nodeid $info
> -}
> -
> -# freemem_check
> -# We need enough memory space on every node to run this test, so we must check
> -# whether every node has enough free memory or not.
> -# return value: 1 - Some node doesn't have enough free memory
> -#               0 - Every node has enough free memory, We can do this test
> -freemem_check()
> -{
> -	local i=
> -
> -	for i in `seq 0 $((nr_mems-1))`
> -	do
> -		get_meminfo $i "MemFree"
> -	done
> -
> -	for i in `seq 0 $((nr_mems-1))`
> -	do
> -		# I think we need 100MB free memory to run test
> -		if [ $(get_memsinfo_val $i) -lt 100000 ]; then
> -			return 1
> -		fi
> -	done
> -}
> -
> -# get_memsinfo
> -get_memsinfo()
> -{
> -	local i=
> -
> -	for i in `seq 0 $((nr_mems-1))`
> -	do
> -		get_meminfo $i "FilePages"
> -	done
> -}
> -
> -# account_meminfo <nodeId>
> -account_meminfo()
> -{
> -	local nodeId="$1"
> -	local tmp="$(get_memsinfo_val $nodeId)"
> -	get_meminfo $@ "FilePages"
> -	set_memsinfo_val $nodeId $(($(get_memsinfo_val $nodeId)-$tmp))
> -}
> -
> -# account_memsinfo
> -account_memsinfo()
> -{
> -	local i=
> -
> -	for i in `seq 0 $((nr_mems-1))`
> -	do
> -		account_meminfo $i
> -	done
> -}
> -
> -
> -# result_check <nodelist>
> -# return 0: success
> -#	 1: fail
> -result_check()
> -{
> -	local nodelist="`echo $1 | sed -e 's/,/ /g'`"
> -	local i=
> -
> -	for i in $nodelist
> -	do
> -		if [ $(get_memsinfo_val $i) -le $upperlimit ]; then
> -			return 1
> -		fi
> -	done
> -
> -	local allnodelist="`echo $mems_all | sed -e 's/,/ /g'`"
> -	allnodelist=" "$allnodelist" "
> -	nodelist=" "$nodelist" "
> -
> -	local othernodelist="$allnodelist"
> -	for i in $nodelist
> -	do
> -		othernodelist=`echo "$othernodelist" | sed -e "s/ $i / /g"`
> -	done
> -
> -	for i in $othernodelist
> -	do
> -		if [ $(get_memsinfo_val $i) -gt $lowerlimit ]; then
> -			return 1
> -		fi
> -	done
> -}
> -
> -# general_memory_spread_test <cpusetpath> <is_spread> <cpu_list> <node_list> \
> -# <expect_nodes> <test_pid>
> -# expect_nodes: we expect to use the slab or cache on which node
> -general_memory_spread_test()
> -{
> -	local cpusetpath="$CPUSET/1"
> -	local is_spread="$1"
> -	local cpu_list="$2"
> -	local node_list="$3"
> -	local expect_nodes="$4"
> -	local test_pid="$5"
> -
> -	cpuset_set "$cpusetpath" "$cpu_list" "$node_list" "0" 2> $CPUSET_TMP/stderr
> -	if [ $? -ne 0 ]; then
> -		cpuset_log_error $CPUSET_TMP/stderr
> -		tst_resm TFAIL "set general group parameter failed."
> -		return 1
> -	fi
> -
> -	/bin/echo "$is_spread" > "$cpusetpath/cpuset.memory_spread_page" 2> $CPUSET_TMP/stderr
> -	if [ $? -ne 0 ]; then
> -		cpuset_log_error $CPUSET_TMP/stderr
> -		tst_resm TFAIL "set spread value failed."
> -		return 1
> -	fi
> -
> -	/bin/echo "$test_pid" > "$cpusetpath/tasks" 2> $CPUSET_TMP/stderr
> -	if [ $? -ne 0 ]; then
> -		cpuset_log_error $CPUSET_TMP/stderr
> -		tst_resm TFAIL "attach task failed."
> -		return 1
> -	fi
> -
> -	# we'd better drop the caches before we test page cache.
> -	sync
> -	/bin/echo 3 > /proc/sys/vm/drop_caches 2> $CPUSET_TMP/stderr
> -	if [ $? -ne 0 ]; then
> -		cpuset_log_error $CPUSET_TMP/stderr
> -		tst_resm TFAIL "drop caches failed."
> -		return 1
> -	fi
> -
> -	get_memsinfo
> -	/bin/kill -s SIGUSR1 $test_pid
> -	read exit_num < $FIFO
> -	if [ $exit_num -eq 0 ]; then
> -		tst_resm TFAIL "hot mem task failed."
> -		return 1
> -	fi
> -
> -	account_memsinfo
> -	result_check $expect_nodes
> -	if [ $? -ne 0 ]; then
> -		tst_resm TFAIL "hog the memory on the unexpected node(FilePages_For_Nodes(KB): ${memsinfo}, Expect Nodes: $expect_nodes)."
> -		return 1
> -	fi
> -}
> -
> -base_test()
> -{
> -	local pid=
> -	local result_num=
> -
> -	setup
> -	if [ $? -ne 0 ]; then
> -		exit_status=1
> -	else
> -		cpuset_mem_hog &
> -		pid=$!
> -		general_memory_spread_test "$@" "$pid"
> -		result_num=$?
> -		if [ $result_num -ne 0 ]; then
> -			exit_status=1
> -		fi
> -
> -		/bin/kill -s SIGUSR2 $pid
> -		wait $pid
> -
> -		cleanup
> -		if [ $? -ne 0 ]; then
> -			exit_status=1
> -		elif [ $result_num -eq 0 ]; then
> -			tst_resm TPASS "Cpuset memory spread page test succeeded."
> -		fi
> -	fi
> -	TST_COUNT=$(($TST_COUNT + 1))
> -}
> -
> -# test general spread page cache in a cpuset
> -test_spread_page1()
> -{
> -	while read spread cpus nodes exp_nodes
> -	do
> -		base_test "$spread" "$cpus" "$nodes" "$exp_nodes"
> -	done <<- EOF
> -		0	0	0	0
> -		1	0	0	0
> -		0	0	1	1
> -		1	0	1	1
> -		0	0	0,1	0
> -		1	0	0,1	0,1
> -	EOF
> -	# while read spread cpus nodes exp_nodes
> -}
> -
> -test_spread_page2()
> -{
> -	local pid=
> -	local result_num=
> -
> -	setup
> -	if [ $? -ne 0 ]; then
> -		exit_status=1
> -	else
> -		cpuset_mem_hog &
> -		pid=$!
> -		general_memory_spread_test "1" "$cpus_all" "0" "0" "$pid"
> -		result_num=$?
> -		if [ $result_num -ne 0 ]; then
> -			exit_status=1
> -		else
> -			general_memory_spread_test "1" "$cpus_all" "1" "1" "$pid"
> -			result_num=$?
> -			if [ $result_num -ne 0 ]; then
> -				exit_status=1
> -			fi
> -		fi
> -
> -		/bin/kill -s SIGUSR2 $pid
> -		wait $pid
> -
> -		cleanup
> -		if [ $? -ne 0 ]; then
> -			exit_status=1
> -		elif [ $result_num -eq 0 ]; then
> -			tst_resm TPASS "Cpuset memory spread page test succeeded."
> -		fi
> -	fi
> -}
> -
> -init_memsinfo_array
> -freemem_check
> -if [ $? -ne 0 ]; then
> -	tst_brkm TCONF "Some node doesn't has enough free memory(100MB) to do test(MemFree_For_Nodes(KB): ${memsinfo[*]})."
> -fi
> -
> -dd if=/dev/zero of=./DATAFILE bs=1M count=100
> -if [ $? -ne 0 ]; then
> -	tst_brkm TFAIL "Creating DATAFILE failed."
> -fi
> -
> -rm -f $FIFO
> -mkfifo $FIFO
> -if [ $? -ne 0 ]; then
> -	rm -f DATAFILE
> -	tst_brkm TFAIL "failed to mkfifo $FIFO"
> -fi
> -
> -test_spread_page1
> -test_spread_page2
> -
> -rm -f DATAFILE $FIFO
> -
> -exit $exit_status
> -- 
> 2.43.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
