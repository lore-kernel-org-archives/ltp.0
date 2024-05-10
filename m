Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4036FC25B5F
	for <ltp@archiver.kernel.org>; Fri, 10 May 2024 14:40:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B63AD3CE4BC
	for <ltp@archiver.kernel.org>; Fri, 10 May 2024 16:40:08 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B285A3CC2F5
 for <ltp@lists.linux.it>; Fri, 10 May 2024 16:39:54 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0C5651A0145C
 for <ltp@lists.linux.it>; Fri, 10 May 2024 16:39:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8AD773F9B0;
 Fri, 10 May 2024 14:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715351992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2yFtIxkKtBQnpVDv3XDrrOayqYLup4jta0cdXd1Vey0=;
 b=B5yNwi8PkfY/YT+gnF/ZF8TQO8e8NOTt+4Tre5UqV3mlGu7uPcWF8cTfcNGVFr1QV0bzTs
 6xLN/es3nqZiZNuCf3xN5woygyQ71v2jurE91pq1H1Od01+L2pnZOAWhgsW8AoRqEN2iWc
 Z0+DwWFnhXhKPkxnxKFihHidP3+vu20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715351992;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2yFtIxkKtBQnpVDv3XDrrOayqYLup4jta0cdXd1Vey0=;
 b=yAUxf3aHbi4Di+DVemu9riOWrGwK/SpP6J+5z9v51DF6I4spQ2P7iIuF/uO4jgSAh15g0t
 EL6kwvUaDj5SnJBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=B5yNwi8P;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yAUxf3aH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715351992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2yFtIxkKtBQnpVDv3XDrrOayqYLup4jta0cdXd1Vey0=;
 b=B5yNwi8PkfY/YT+gnF/ZF8TQO8e8NOTt+4Tre5UqV3mlGu7uPcWF8cTfcNGVFr1QV0bzTs
 6xLN/es3nqZiZNuCf3xN5woygyQ71v2jurE91pq1H1Od01+L2pnZOAWhgsW8AoRqEN2iWc
 Z0+DwWFnhXhKPkxnxKFihHidP3+vu20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715351992;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2yFtIxkKtBQnpVDv3XDrrOayqYLup4jta0cdXd1Vey0=;
 b=yAUxf3aHbi4Di+DVemu9riOWrGwK/SpP6J+5z9v51DF6I4spQ2P7iIuF/uO4jgSAh15g0t
 EL6kwvUaDj5SnJBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7499B1386E;
 Fri, 10 May 2024 14:39:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gnqBG7gxPmawHAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 10 May 2024 14:39:52 +0000
Date: Fri, 10 May 2024 16:39:06 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Geetika <geetika@linux.ibm.com>
Message-ID: <Zj4xinlQQ1rpoo69@yuki>
References: <20240327062040.45457-1-geetika@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240327062040.45457-1-geetika@linux.ibm.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8AD773F9B0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Hugetlb: Migrating libhugetlbfs test
 truncate_reserve_wraparound.c
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
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap38.c
> @@ -0,0 +1,122 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
> + */
> +
> +/*\
> + *[Descripiton]
> + *
> + * Origin: https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/truncate_reserve_wraparound.c
> + *
> + * At one stage, improper handling of tests against i_size could mess
> + * up accounting of reserved hugepages on certain truncate
> + * operations.
> + *
> + */
> +
> +#include <signal.h>
> +#include <setjmp.h>
> +#include "hugetlb.h"
> +
> +#define MNTPOINT "hugetlbfs/"
> +
> +static long hpage_size;
> +static int fd = -1;
> +static int sigbus_count;
> +static unsigned long initial_rsvd, after_map_rsvd, after_touch_rsvd;
> +static unsigned long after_trunc_rsvd, after_unmap_rsvd, after_sigbus_rsvd;
> +static volatile unsigned int *q;
> +
> +static sigjmp_buf sig_escape;
> +
> +static void sigbus_handler(int signum LTP_ATTRIBUTE_UNUSED, siginfo_t *si LTP_ATTRIBUTE_UNUSED, void *uc LTP_ATTRIBUTE_UNUSED)
> +{
> +	siglongjmp(sig_escape, 17);
> +}
> +
> +static void run_test(void)
> +{
> +	void *p;
> +	struct sigaction sa = {
> +	.sa_sigaction = sigbus_handler,
> +	.sa_flags = SA_SIGINFO,

The inner content should ideally be intended with one tab as well.

> +	};
> +
> +	sigbus_count = 0;
> +
> +	initial_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
> +	tst_res(TINFO, "Reserve count before map: %lu\n", initial_rsvd);
                                                     ^
tst_res() format string must not contain newlines, it adds newline at
the end automatically, this should be fixed for all tst_res(TINFO, ...)
in the source code.

> +	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
> +			fd, 0);
> +	q = p;
> +
> +	after_map_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
> +	tst_res(TINFO, "Reserve count after map: %lu\n", after_map_rsvd);
> +
> +	*q = 0;
> +	after_touch_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
> +	tst_res(TINFO, "Reserve count after touch: %lu\n", after_touch_rsvd);
> +
> +	SAFE_FTRUNCATE(fd, 0);
> +	after_trunc_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
> +	tst_res(TINFO, "Reserve count after truncate: %lu\n", after_trunc_rsvd);
> +
> +	if (after_trunc_rsvd != initial_rsvd) {
> +		tst_res(TFAIL, "Reserved count is not restored after truncate: %lu instead of %lu", after_trunc_rsvd, initial_rsvd);
> +		goto windup;
> +	}
> +
> +	SAFE_SIGACTION(SIGBUS, &sa, NULL);

This can be done just once in the test setup.

> +	if (sigsetjmp(sig_escape, 1) == 0)
> +		*q; /* Fault, triggering a SIGBUS */
> +	else
> +		sigbus_count++;
> +
> +	if (sigbus_count != 1) {
> +		tst_res(TFAIL, "Didn't SIGBUS after truncate");
> +		goto windup;
> +	}
> +
> +	after_sigbus_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
> +	tst_res(TINFO, "Reserve count after truncate: %lu\n", after_sigbus_rsvd);
                                            ^
				      after sigbus

> +	if (after_trunc_rsvd != initial_rsvd) {
> +		tst_res(TFAIL, "Reserved count is altered by SIGBUS fault: %lu instead of %lu", after_sigbus_rsvd, initial_rsvd);
> +		goto windup;
> +	}
> +
> +	tst_res(TPASS, "Test passed!");
> +
> +windup:
> +	SAFE_MUNMAP(p, hpage_size);
> +	after_unmap_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
> +	tst_res(TINFO, "Reserve count after munmap: %lu\n", after_unmap_rsvd);
> +
> +}
> +
> +static void setup(void)
> +{
> +	hpage_size = tst_get_hugepage_size();
> +	fd = tst_creat_unlinked(MNTPOINT, 0);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd >= 0)
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
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run_test,
> +};


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
