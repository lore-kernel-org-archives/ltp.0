Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD5EC5518F
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 08:47:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E4B023E7184
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 10:47:33 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC6F73E194B
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 10:47:14 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 89BD71A002D7
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 10:47:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 72D2440A5;
 Tue,  4 Aug 2026 08:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785833222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=grVR/7pH/6RzieK1aXa4l0SRbmhwmdSf49wV3mEHEd4=;
 b=E+NNJ9c3iNxp3jGWbQBnQvfQTdIhcHdiXZueIV4CJGGGyt/bo0XFf8NC1GeZifJn0jIUh5
 BaSYiLUG4b7ab4Qm0DKihtEGHHsibbflDD8crFwAe/vZQLzKdzS8KkqofwuHaDQ/C+xy3V
 qPmN97npyKfuFIuY0vaFI39i4kk+zog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785833222;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=grVR/7pH/6RzieK1aXa4l0SRbmhwmdSf49wV3mEHEd4=;
 b=Xn9BzUXMO5emk1hr9T9vvJtWbFin/agYStGPZpkt/KD6J5lxVaK7fLTxQkRjbD7BNoWqSE
 cOL5yYx1w7U7LrBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZiwXpyd5;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1ab0StqV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785833218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=grVR/7pH/6RzieK1aXa4l0SRbmhwmdSf49wV3mEHEd4=;
 b=ZiwXpyd5E3QlNzKarbZP4i+C1n1aiX4TVsRO5h1jMtP6Kl9fF/HpEwiy16QnkUCvcR2x1b
 AP93s96iUW4AlzNpvDk4FbjDNVeDLWRZHu90F58Z3w4jYzZzGNrBCew6pGdNLnO55zi61f
 z9/Jl+/cuWa1dVNPj80BXm+N6eltVtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785833218;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=grVR/7pH/6RzieK1aXa4l0SRbmhwmdSf49wV3mEHEd4=;
 b=1ab0StqVH31G885X4IoWOAqvY1Ec7cRZGPhbhQ0OriFp67xAyMqGql5J8peaRb2kzr9upQ
 v/SMN6lofywEWBDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62A85779BE;
 Tue,  4 Aug 2026 08:46:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Y64pFwKncWoHbQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 04 Aug 2026 08:46:58 +0000
Date: Tue, 4 Aug 2026 10:46:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Pavithra <pavrampu@linux.ibm.com>
Message-ID: <anGnAn9tl9WHQB_f@yuki.lan>
References: <20260717180533.1203314-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260717180533.1203314-1-pavrampu@linux.ibm.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 72D2440A5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hugemmap/hugemmap41: Migrate
 ptrace-write-hugepage from libhugetlbfs
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
> Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
> ---
>  runtest/hugetlb                               |   1 +
>  testcases/kernel/mem/.gitignore               |   1 +
>  .../kernel/mem/hugetlb/hugemmap/hugemmap41.c  | 147 ++++++++++++++++++
>  3 files changed, 149 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c
> 
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index 8ee0e6f82..32412ed45 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -37,6 +37,7 @@ hugemmap31 hugemmap31
>  hugemmap32 hugemmap32
>  hugemmap34 hugemmap34
>  hugemmap35 hugemmap35
> +hugemmap41 hugemmap41
>  hugemmap05_1 hugemmap05 -m
>  hugemmap05_2 hugemmap05 -s
>  hugemmap05_3 hugemmap05 -s -m
> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> index 0e59035df..29eb83d16 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -37,6 +37,7 @@
>  /hugetlb/hugemmap/hugemmap32
>  /hugetlb/hugemmap/hugemmap34
>  /hugetlb/hugemmap/hugemmap35
> +/hugetlb/hugemmap/hugemmap41
>  /hugetlb/hugeshmat/hugeshmat01
>  /hugetlb/hugeshmat/hugeshmat02
>  /hugetlb/hugeshmat/hugeshmat03
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c
> new file mode 100644
> index 000000000..0fbe7b448
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
> + * Copyright (c) 2026 Pavithra <pavrampu@linux.ibm.com>
> + */
> +
> +/*\
> + * Test :manpage:`ptrace(2)` write to hugepage memory.
> + *
> + * A child process maps a hugepage via hugetlbfs, zeroes it, and sends
> + * the mapped address to the parent. The parent attaches with
> + * :manpage:`ptrace(2)`, then uses PTRACE_POKEDATA and PTRACE_PEEKDATA
> + * to write and read back a known value at two different offsets within
> + * the hugepage, verifying that ptrace operates correctly on
> + * hugepage-backed memory regions.
> + *
> + * Requires root to mount hugetlbfs and for :manpage:`ptrace(2)`
> + * PTRACE_ATTACH to work across processes when ptrace_scope is
> + * restrictive.
> + */
> +
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +#include <sys/ptrace.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +
> +#include "tst_test.h"
> +#include "hugetlb.h"
> +
> +#define CONST	0xdeadbeefL
> +#define MNTPOINT "hugetlbfs/"
> +
> +static long hpage_size;
> +static int fd = -1;
> +
> +static void child(int hugefd, int pipefd[2])
> +{
> +	void *p;
> +
> +	SAFE_CLOSE(pipefd[0]);
> +
> +	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
> +		      hugefd, 0);
> +
> +	memset(p, 0, hpage_size);
> +
> +	tst_res(TINFO, "Child mapped data at %p", p);
> +
> +	SAFE_WRITE(SAFE_WRITE_ALL, pipefd[1], &p, sizeof(p));
> +	SAFE_CLOSE(pipefd[1]);
> +
> +	pause();
> +	/* Child is killed by parent via SIGKILL, so cleanup is not reached */
> +}
> +
> +static void do_poke(pid_t pid, void *p)
> +{
> +	tst_res(TINFO, "Poking at %p...", p);
> +	TEST(ptrace(PTRACE_POKEDATA, pid, p, (void *)CONST));
> +	if (TST_RET != 0)
> +		tst_brk(TFAIL | TTERRNO, "ptrace(POKEDATA) failed");

We have SAFE_PTRACE() make use of that.

> +	tst_res(TINFO, "Peeking at %p...", p);
> +	errno = 0;

No need to clear errno, the TEST() macro does that.

> +	TEST(ptrace(PTRACE_PEEKDATA, pid, p, NULL));
> +	if (TST_RET == -1 && TST_ERR)
> +		tst_brk(TFAIL | TTERRNO, "ptrace(PEEKDATA) failed");

Here as well.

> +	if (TST_RET != CONST)
> +		tst_brk(TFAIL, "Value mismatch: got %lx, expected %lx",
> +			TST_RET, CONST);

This can be TST_EXP_EQ_LI()

> +}
> +
> +static void run_test(void)
> +{
> +	int pipefd[2];
> +	pid_t cpid;
> +	void *p;
> +	int status;
> +
> +	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
> +
> +	SAFE_PIPE(pipefd);
> +
> +	cpid = SAFE_FORK();
> +
> +	if (cpid == 0) {
> +		child(fd, pipefd);
> +		exit(0);
> +	}
> +
> +	/* Parent */

Please bo comments commenting the obvious like this one.

> +	SAFE_CLOSE(pipefd[1]);
> +	SAFE_READ(1, pipefd[0], &p, sizeof(p));
> +	SAFE_CLOSE(pipefd[0]);
> +
> +	tst_res(TINFO, "Parent received address %p", p);
> +
> +	if (ptrace(PTRACE_ATTACH, cpid, NULL, NULL)) {
> +		if (errno == EPERM)
> +			tst_brk(TCONF | TERRNO, "ptrace(ATTACH) not permitted (check /proc/sys/kernel/yama/ptrace_scope)");
> +		tst_brk(TBROK | TERRNO, "ptrace(ATTACH) failed");
> +	}

This should be just SAFE_PTRACE() if we need to check for EPERM because
of security checks it should be done, in a separate patch, in
tst_safe_ptrace() instead.

> +	TST_PROCESS_STATE_WAIT(cpid, 't', 0);

The more canonical way is to SAFE_WAITPID() and check for WIFSTOPPED().

> +	do_poke(cpid, p);
> +	do_poke(cpid, p + getpagesize());
> +
> +	SAFE_KILL(cpid, SIGKILL);
> +	SAFE_WAITPID(cpid, &status, 0);
> +
> +	if (fd != -1) {
> +		SAFE_CLOSE(fd);
> +		fd = -1;
> +	}

This should be just SAFE_CLOSE(fd)

- we cannot get here if the fd == -1 since the tst_create_unlinked()
  exits the test on a failure

- the fd is set to -1 by SAFE_CLOSE() macro.

> +	tst_res(TPASS, "ptrace write to hugepage succeeded");
> +}
> +
> +static void setup(void)
> +{
> +	hpage_size = tst_get_hugepage_size();
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd != -1)
> +		SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.tags = (struct tst_tag[]) {
> +		{"linux-git", "ebed4bfc8da8"},
> +		{}
> +	},
> +	.needs_root = 1,
> +	.mntpoint = MNTPOINT,
> +	.needs_hugetlbfs = 1,
> +	.hugepages = {4, TST_NEEDS},

The test needs just 1 hugepage.

> +	.forks_child = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run_test,
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
