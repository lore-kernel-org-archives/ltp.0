Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76C2C55172
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 10:04:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D55E83D00A7
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 12:04:56 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 90FD73C332C
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 12:04:40 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8FA271A0069F
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 12:04:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F108D3E0A;
 Tue,  4 Aug 2026 10:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785837874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bgUbQGJriqsK5pqRgJXiiEyltEhTfeF2QqEIktifQ/w=;
 b=zRyO6Q7/oA4jd46HSg4AAv2BIfOxKAbi9q9zrr7brqFxpUr9ImX+NBjevNadL137HuUUWP
 lRyHknPx6Nl2nKn4sUc5cEARNaQJwJ4R5YxLGAjSuZkg44OLMEVs2/sScn0vPjoqiLLKGk
 uvTqsRVvrcd7981BYyhwn1ZTNXBdou8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785837874;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bgUbQGJriqsK5pqRgJXiiEyltEhTfeF2QqEIktifQ/w=;
 b=9t/IMip9ijjRF988CtN5K6nIfPGQXl9IYhIZe6dlbH7N5crtCv/9cUC4VndC5ek1lnFvyD
 oBU3epf2XVN/QNBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="uO91b/4N";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6NuLOpX1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785837869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bgUbQGJriqsK5pqRgJXiiEyltEhTfeF2QqEIktifQ/w=;
 b=uO91b/4NxJszh0r5srfCu9KaXKPqAkN4ASyYDVzbGmAqSScahiZuhYdvmplFm3jB8ucdb8
 C8TcfO85kZeGqwc8kcULfvVDF1nilzArDhD9hyY+kW68NxRD59hFBpkXUm/+Bf3aArekmt
 Kd3YBLH6BXXhth4glDpmYh7YVx7xxXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785837869;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bgUbQGJriqsK5pqRgJXiiEyltEhTfeF2QqEIktifQ/w=;
 b=6NuLOpX1yYvEClDeQLx04Mq7Zwd/qSO9Vcw8gQ8q6b9pciFMWOXRjcHRhcTmBgFysQhXU3
 NOShwHIwJtqVzECQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCC6A779BE;
 Tue,  4 Aug 2026 10:04:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6qLlNS25cWokOgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 04 Aug 2026 10:04:29 +0000
Date: Tue, 4 Aug 2026 12:04:30 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Pavithra <pavrampu@linux.ibm.com>
Message-ID: <anG5Luzze1ffLUKi@yuki.lan>
References: <20260717160234.1163566-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260717160234.1163566-1-pavrampu@linux.ibm.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,linux.it:url,suse.cz:email,suse.cz:dkim];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: F108D3E0A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hugetlb/hugemmap: add hugemmap33 to test
 hugetlbfs quota accounting
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
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index 8ee0e6f82..dbb05a9bc 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -35,6 +35,7 @@ hugemmap29 hugemmap29
>  hugemmap30 hugemmap30
>  hugemmap31 hugemmap31
>  hugemmap32 hugemmap32
> +hugemmap33 hugemmap33
>  hugemmap34 hugemmap34
>  hugemmap35 hugemmap35
>  hugemmap05_1 hugemmap05 -m
> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> index 0e59035df..0dd0345c8 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -35,6 +35,7 @@
>  /hugetlb/hugemmap/hugemmap30
>  /hugetlb/hugemmap/hugemmap31
>  /hugetlb/hugemmap/hugemmap32
> +/hugetlb/hugemmap/hugemmap33
>  /hugetlb/hugemmap/hugemmap34
>  /hugetlb/hugemmap/hugemmap35
>  /hugetlb/hugeshmat/hugeshmat01
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap33.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap33.c
> new file mode 100644
> index 000000000..f5b2a6335
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap33.c
> @@ -0,0 +1,275 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (C) 2005-2007 David Gibson & Adam Litke, IBM Corporation.
> + * Copyright (c) Linux Test Project, 2024
> + * Copyright (C) 2025-2026 Naveed & Pavithra, IBM Corporation.
> + * Assisted with AI tools
> + */
> +
> +/*\
> + * Test hugetlbfs quota accounting with filesystem size limits.
> + *
> + * The number of global huge pages available to a mounted hugetlbfs filesystem
> + * can be limited using a quota mechanism by setting the size attribute at
> + * mount time. Older kernels did not properly handle quota accounting in a
> + * number of cases (e.g., for MAP_PRIVATE pages, and with MAP_SHARED reservation).
> + *
> + * This test replays some scenarios on a privately mounted filesystem with
> + * quota to check for regressions in hugetlbfs quota accounting.
> + *
> + * Root is required to mount the quota-limited hugetlbfs instance.
> + */
> +
> +#define _GNU_SOURCE
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <sys/vfs.h>
> +#include <sys/statfs.h>
> +#include <sys/mount.h>
> +
> +#include "hugetlb.h"
> +
> +#define MNTPOINT "hugetlbfs/"
> +
> +static long hpage_size;
> +static int private_resv;
> +static char quota_mnt[PATH_MAX];
> +static int quota_mounted;
> +
> +/* map action flags */
> +#define ACTION_COW		0x0001
> +#define ACTION_TOUCH		0x0002
> +
> +/* Test result expectations */
> +#define EXPECT_SUCCESS	0
> +#define EXPECT_SIGNAL	1
> +#define EXPECT_FAILURE	2
> +
> +static void verify_quota_stat(long tot, long free, long avail)
> +{
> +	struct statfs s;
> +
> +	SAFE_STATFS(quota_mnt, &s);
> +
> +	if ((long)s.f_blocks != tot || (long)s.f_bfree != free || (long)s.f_bavail != avail) {
> +		tst_res(TFAIL,
> +			"Bad quota counters: total=%li (expected %li), "
> +			"free=%li (expected %li), avail=%li (expected %li)",
> +			(long)s.f_blocks, tot, (long)s.f_bfree, free,
> +			(long)s.f_bavail, avail);
> +	}
> +}
> +
> +static void do_map(unsigned long size, int mmap_flags, int action_flags)
> +{
> +	int fd;
> +	char *a = MAP_FAILED, *b, *c = MAP_FAILED;
> +	char path[PATH_MAX + 32];
> +
> +	snprintf(path, sizeof(path), "%s/test_file_%d", quota_mnt, getpid());
> +	fd = SAFE_OPEN(path, O_CREAT | O_RDWR, 0600);
> +	SAFE_UNLINK(path);
> +
> +	a = mmap(NULL, size, PROT_READ | PROT_WRITE, mmap_flags, fd, 0);
> +	if (a == MAP_FAILED) {
> +		if (errno == ENOMEM || errno == ENOSPC) {
> +			tst_res(TINFO | TERRNO, "mmap failed as expected due to quota");
> +			goto cleanup_fd;
> +		}
> +		tst_brk(TBROK | TERRNO, "mmap failed unexpectedly");
> +	}
> +
> +	if (action_flags & ACTION_TOUCH) {
> +		for (b = a; b < a + size; b += hpage_size)
> +			*b = 1;
> +	}
> +
> +	if (action_flags & ACTION_COW) {
> +		c = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
> +		if (c == MAP_FAILED) {
> +			if (errno == ENOMEM || errno == ENOSPC) {
> +				tst_res(TINFO | TERRNO, "COW mapping failed as expected due to quota");
> +				goto cleanup_a;
> +			}
> +			tst_brk(TBROK | TERRNO, "COW mapping failed unexpectedly");
> +		}
> +
> +		if (*c != 1) {
> +			tst_res(TINFO, "Data mismatch when setting up COW");
> +			goto cleanup_c;
> +		}
> +		*c = 0;
> +		SAFE_MUNMAP(c, size);
> +	}
> +
> +	SAFE_MUNMAP(a, size);
> +	SAFE_CLOSE(fd);
> +	return;
> +
> +cleanup_c:
> +	SAFE_MUNMAP(c, size);
> +cleanup_a:
> +	SAFE_MUNMAP(a, size);
> +cleanup_fd:
> +	SAFE_CLOSE(fd);
> +	exit(1);
> +}
> +
> +static void run_quota_test(int expected_result,
> +			   unsigned long size, int mmap_flags,
> +			   int action_flags)
> +{
> +	pid_t pid;
> +	int status;
> +	int actual_result;
> +
> +	pid = SAFE_FORK();
> +	if (pid == 0) {
> +		do_map(size, mmap_flags, action_flags);
> +		exit(0);
> +	}
> +
> +	SAFE_WAITPID(pid, &status, 0);
> +
> +	if (WIFEXITED(status)) {
> +		if (WEXITSTATUS(status) == 0)
> +			actual_result = EXPECT_SUCCESS;
> +		else
> +			actual_result = EXPECT_FAILURE;

Test results must not be propagated via exit values, PASS/FAIL must be
reported exactly at the spot in the code where it happened.

> +	} else {
> +		actual_result = EXPECT_SIGNAL;
> +	}
> +
> +	if (actual_result != expected_result) {
> +		static const char * const result_names[] = {"success", "signal", "failure"};
> +
> +		tst_res(TFAIL,
> +			"Unexpected result: expected %s, got %s",
> +			result_names[expected_result],
> +			result_names[actual_result]);
> +	} else {
> +		tst_res(TPASS, "Quota test passed as expected");
> +	}
> +}
> +
> +static int kernel_has_private_reservations(void)
> +{
> +	int fd;
> +	long t, f, r, s;
> +	long nt, nf, nr, ns;
> +	void *p;
> +	char path[PATH_MAX];
> +
> +	t = SAFE_READ_MEMINFO(MEMINFO_HPAGE_TOTAL);
> +	f = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
> +	r = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
> +	s = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SURP);
> +
> +	snprintf(path, sizeof(path), "%s/test_priv_resv", MNTPOINT);
> +	fd = SAFE_OPEN(path, O_CREAT | O_RDWR, 0600);
> +	SAFE_UNLINK(path);
> +
> +	p = SAFE_MMAP(NULL, hpage_size, PROT_READ | PROT_WRITE,
> +		      MAP_PRIVATE, fd, 0);
> +
> +	nt = SAFE_READ_MEMINFO(MEMINFO_HPAGE_TOTAL);
> +	nf = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
> +	nr = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
> +	ns = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SURP);
> +
> +	SAFE_MUNMAP(p, hpage_size);
> +	SAFE_CLOSE(fd);
> +
> +	/* Check if reservation was created for private mapping */
> +	if ((nt == t + 1) && (nf == f + 1) && (ns == s + 1) && (nr == r + 1))
> +		return 1;
> +	else if ((nt == t) && (nf == f) && (ns == s)) {
> +		if (nr == r + 1)
> +			return 1;
> +		else if (nr == r)
> +			return 0;
> +	}
> +
> +	tst_brk(TCONF, "Unexpected counter state - "
> +		"T:%li F:%li R:%li S:%li -> T:%li F:%li R:%li S:%li",
> +		t, f, r, s, nt, nf, nr, ns);
> +	return -1;
> +}

Was this changed recently in kernel? Adding a git hash that changed the
kernel behavior into the test description would help.

Also if this was a bug, we have a rule in LTP not to work around kernel
bugs, if kernel is broken it's fine that the test fails.

> +static void run_test(void)
> +{
> +	int bad_priv_resv = private_resv ? EXPECT_FAILURE : EXPECT_SIGNAL;
> +
> +	tst_res(TINFO, "Testing unused quota cleanup for untouched mappings");
> +	run_quota_test(EXPECT_SUCCESS, hpage_size, MAP_PRIVATE, 0);
> +	verify_quota_stat(1, 1, 1);
> +	run_quota_test(EXPECT_SUCCESS, hpage_size, MAP_SHARED, 0);
> +	verify_quota_stat(1, 1, 1);
> +
> +	tst_res(TINFO, "Testing page instantiation within quota limits");
> +	run_quota_test(EXPECT_SUCCESS, hpage_size, MAP_PRIVATE, ACTION_TOUCH);
> +	run_quota_test(EXPECT_SUCCESS, hpage_size, MAP_SHARED, ACTION_TOUCH);
> +
> +	tst_res(TINFO, "Testing page instantiation over quota");
> +	run_quota_test(EXPECT_FAILURE, 2 * hpage_size, MAP_SHARED, ACTION_TOUCH);
> +
> +	tst_res(TINFO, "Testing private mapping quota check");
> +	run_quota_test(bad_priv_resv, 2 * hpage_size, MAP_PRIVATE, ACTION_TOUCH);
> +
> +	tst_res(TINFO, "Testing COW over quota");
> +	run_quota_test(bad_priv_resv, hpage_size, MAP_SHARED,
> +		       ACTION_TOUCH | ACTION_COW);
> +	run_quota_test(bad_priv_resv, hpage_size, MAP_PRIVATE,
> +		       ACTION_TOUCH | ACTION_COW);
> +
> +	tst_res(TINFO, "Testing operations within quota after failures");
> +	run_quota_test(EXPECT_SUCCESS, hpage_size, MAP_SHARED, ACTION_TOUCH);
> +	run_quota_test(EXPECT_SUCCESS, hpage_size, MAP_PRIVATE, ACTION_TOUCH);
> +}
> +
> +static void setup(void)
> +{
> +	char mount_opts[BUFSIZ];
> +
> +	hpage_size = tst_get_hugepage_size();
> +
> +	/* Create a quota-limited hugetlbfs mount */
> +	snprintf(quota_mnt, sizeof(quota_mnt), "%s/quota_test", MNTPOINT);
> +	SAFE_MKDIR(quota_mnt, 0755);
> +
> +	snprintf(mount_opts, sizeof(mount_opts), "size=%luK",
> +		 hpage_size / 1024);
> +
> +	if (mount("none", quota_mnt, "hugetlbfs", 0, mount_opts) == -1) {
> +		if (errno == ENODEV)
> +			tst_brk(TCONF, "hugetlbfs not supported");
> +		tst_brk(TBROK | TERRNO, "mount() failed");
> +	}
> +	quota_mounted = 1;

Since we cannot determine the size= parameter at a compile time (and
hence cannot pass it in tst_test struct) wouldn't it make more sense to
MS_REMOUNT the hugetlbfs already mounted in the test library with the
size parameter? Would that work?

It does seem strange to mount hugetlbfs twice and keep one mount unused.

> +	tst_res(TINFO, "Mounted hugetlbfs with quota at %s (size=%luK)",
> +		quota_mnt, hpage_size / 1024);
> +
> +	private_resv = kernel_has_private_reservations();
> +	tst_res(TINFO, "Kernel %s private reservations",
> +		private_resv ? "has" : "does not have");
> +}
> +
> +static void cleanup(void)
> +{
> +	if (quota_mounted) {
> +		SAFE_UMOUNT(quota_mnt);
> +		SAFE_RMDIR(quota_mnt);
> +	}
> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.mntpoint = MNTPOINT,
> +	.needs_hugetlbfs = 1,
> +	.forks_child = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run_test,
> +	.hugepages = {2, TST_NEEDS},
> +};
> -- 
> 2.55.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
