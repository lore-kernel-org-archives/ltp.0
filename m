Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAC8C282EC
	for <ltp@archiver.kernel.org>; Mon, 10 Mar 2025 16:19:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8EC973CA23F
	for <ltp@archiver.kernel.org>; Mon, 10 Mar 2025 17:18:58 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 475A93C685A
 for <ltp@lists.linux.it>; Mon, 10 Mar 2025 17:18:42 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 94DB8600977
 for <ltp@lists.linux.it>; Mon, 10 Mar 2025 17:18:40 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ECF372116D;
 Mon, 10 Mar 2025 16:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741623520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JRjBaS4YiioJmaSCIBHd8bppsJmsd2TrTkKNTdBvRzU=;
 b=kcAykyk+/O9ihZmIm9EqeSlk5VYoOCt0VDsqxTtjATFU4d70FuBY7CFd0n0Yw2apub/Jyh
 0FK8FeuF5EJv8Fa1KWxTeFh1iMnBA9aNRPTk13n0WpLnoipgmbUwUunNp7eLRYnHh6yg56
 03N8x4IMHFtJpbQb5H9n/opTiBo/Xxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741623520;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JRjBaS4YiioJmaSCIBHd8bppsJmsd2TrTkKNTdBvRzU=;
 b=pQKviI9y0UFC00u+ul/oC+enCtWv5FFrbrXq+jDU/vhObdCrIyuM3M1x86JhhkrF8RgVlW
 7IAiWJE959VDJiCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LN3X80Pw;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6lKfe7Rx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741623519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JRjBaS4YiioJmaSCIBHd8bppsJmsd2TrTkKNTdBvRzU=;
 b=LN3X80Pw7GCkPGE0i6iuJbip3EeMdUi0SsHE2pCdyI5FSBfrDxlSYAc89Beku9nqUYtJS1
 BbkS36ugDM0dJ08ERr6D5PNA7hcbOcSBLMn5lzlkzz4VYmmnV4TdczRMid+xMjfH1JJuyl
 JMxSefqPZrb0u6RPLsdIAQ4Jma9NaJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741623519;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JRjBaS4YiioJmaSCIBHd8bppsJmsd2TrTkKNTdBvRzU=;
 b=6lKfe7RxI0EQKKgjOSIa6qZ2t6bcLq0YRB3YyaHCvU8GzQgmRf3SYhApR5+642WZ8V+h1X
 t06Tgtaph9ENkzBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBC67139E7;
 Mon, 10 Mar 2025 16:18:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9ZyzNN8Qz2f7WwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 10 Mar 2025 16:18:39 +0000
Date: Mon, 10 Mar 2025 17:18:57 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <Z88Q8TV13_PMKAIT@yuki.lan>
References: <20241228133217.28945-1-wegao@suse.com>
 <20250103135626.28672-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250103135626.28672-1-wegao@suse.com>
X-Rspamd-Queue-Id: ECF372116D
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mmap21.c: Test for new MAP_DROPPABLE flag for
 mmap
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
> diff --git a/testcases/kernel/syscalls/mmap/mmap21.c b/testcases/kernel/syscalls/mmap/mmap21.c
> new file mode 100644
> index 000000000..46f3ac7c5
> --- /dev/null
> +++ b/testcases/kernel/syscalls/mmap/mmap21.c
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2024 Wei Gao <wegao@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Test mmap(2) with MAP_DROPPABLE flag.
> + *
> + * Test base on kernel selftests/mm/droppable.c
> + */
> +
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <stdio.h>
> +#include <sys/types.h>
> +#include "tst_test.h"
> +#include "lapi/mmap.h"
> +
> +#define MEM_LIMIT (256 * TST_MB)
> +#define ALLOC_SIZE (128 * TST_MB)
> +
> +static struct tst_cg_group *cg_child;
> +
> +static void test_mmap(void)
> +{
> +	size_t alloc_size = ALLOC_SIZE;
> +	size_t page_size = getpagesize();
> +	void *alloc;
> +	pid_t child;
> +
> +	cg_child = tst_cg_group_mk(tst_cg, "child");
> +	SAFE_CG_PRINTF(tst_cg, "memory.max", "%d", MEM_LIMIT);
> +	SAFE_CG_PRINTF(cg_child, "cgroup.procs", "%d", getpid());
> +
> +	alloc = SAFE_MMAP(0, alloc_size, PROT_READ | PROT_WRITE,
> +			MAP_ANONYMOUS | MAP_DROPPABLE, -1, 0);
> +
> +	memset(alloc, 'A', alloc_size);
> +	for (size_t i = 0; i < alloc_size; i += page_size) {
> +		if (*(char *)(alloc + i) != 'A')
> +			tst_res(TFAIL, "memset failed");
> +	}
> +
> +	int *shared_var = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE,
> +			MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> +
> +	*shared_var = 0;
> +
> +	child = SAFE_FORK();
> +	if (!child) {
> +		for (;;) {
> +			*(char *)malloc(page_size) = 'B';
> +			if ((*shared_var) == 1)
> +				exit(0);
> +		}
> +	}
> +
> +	while (!(*shared_var)) {
> +		for (size_t i = 0; i < alloc_size; i += page_size) {
> +			if (!*(uint8_t *)(alloc + i)) {
> +				*shared_var = 1;

Why do we need the shared_var at all? Why can't we just SIGKILL the
child at this point the same way the selftest does it?

> +				break;
> +			}
> +		}
> +	}
> +
> +	TST_EXP_EQ_LI((*shared_var), 1);
> +
> +	SAFE_WAITPID(child, NULL, 0);
> +
> +	SAFE_MUNMAP(alloc, alloc_size);
> +	SAFE_MUNMAP(shared_var, sizeof(int));
> +}
> +
> +static void setup(void)
> +{
> +	void *addr = mmap(0, 1, PROT_READ | PROT_WRITE,
> +			MAP_ANONYMOUS | MAP_DROPPABLE, -1, 0);
> +	if (addr == MAP_FAILED && errno == EINVAL)
> +		tst_brk(TCONF, "MAP_DROPPABLE not support");
> +}
> +
> +static void cleanup(void)
> +{
> +	if (cg_child) {
> +		SAFE_CG_PRINTF(tst_cg_drain, "cgroup.procs", "%d", getpid());
> +		cg_child = tst_cg_group_rm(cg_child);
> +	}
> +}
> +
> +static struct tst_test test = {
> +	.test_all = test_mmap,
> +	.needs_tmpdir = 1,
> +	.forks_child = 1,
> +	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
> +	.needs_root = 1,
> +	.cleanup = cleanup,
> +	.setup = setup,
> +	.min_mem_avail = 300,
> +};
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
