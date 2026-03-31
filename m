Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA301061B21
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 10:18:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 86C093E2F78
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 12:18:28 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 323FA3CF3BD
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 12:18:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 299EF200C09
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 12:18:08 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 597C85BCD3;
 Tue, 31 Mar 2026 10:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774952288;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G3fXQZq6WBzaMymtTeM8TeAn08TNGdWiHtd7hjR6avw=;
 b=XaEbme2hLH3lbMQ4LD3XH5D8MPM5hKT9VGbATNP8GAbnsx/6lJ+OizUZgTSqLsfg8shrq7
 +w8GPNRPvLKNLzqoLlZTtp/d5vmV5ihpuWYBd9E+rYRQ1BeDyXLbJW1Uea4c5k5ba8fr6d
 zrh3IVfFneypj6xe+XgEDNLN7NA7NjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774952288;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G3fXQZq6WBzaMymtTeM8TeAn08TNGdWiHtd7hjR6avw=;
 b=ak34FcRwSSesdVSWXxWyWogovhLfysl8qgx5f6g+2oNLwxjRm4uiUusuyr8WSQkhoasCJ8
 k6BDJTWstCQtaMBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uSbvHxeH;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mb6QmyDp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774952287;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G3fXQZq6WBzaMymtTeM8TeAn08TNGdWiHtd7hjR6avw=;
 b=uSbvHxeH+8kHoX6CK/TLoQ4i7yMaCOdk7wyeItrfYCpv/tUyeNXrZcOdeZNkzKfWiKS/Fj
 nJog/6033AFgLN2/DFnoxg6fdzWrTZScqOyOoNqLA0meMw8uRQysv9mgo4rqcJKHC77Zeh
 TNIy40mBFa8CCMKF8w+KtzUccqEywsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774952287;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G3fXQZq6WBzaMymtTeM8TeAn08TNGdWiHtd7hjR6avw=;
 b=mb6QmyDpH0AuAvgZ2Ly3NMctNv6LXkW3+UXmPS5gsGdQP4ooLom1sqzgHCbhEfEd9/oHPn
 tw1uTdpChKXWmnDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DEF864A0A2;
 Tue, 31 Mar 2026 10:18:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DGBLLl6fy2lQDwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 31 Mar 2026 10:18:06 +0000
Date: Tue, 31 Mar 2026 12:18:00 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ricardo Branco <rbranco@suse.de>
Message-ID: <20260331101800.GA40946@pevik>
References: <20260330185759.398559-1-rbranco@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260330185759.398559-1-rbranco@suse.de>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 REPLYTO_EQ_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 597C85BCD3
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] userfaultfd: Add new test using UFFDIO_CONTINUE
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

Hi Ricardo,

> We test it with UFFD_PAGEFAULT_FLAG_MINOR.
Thanks, minor things below.

...
> diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd07.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd07.c
> new file mode 100644
> index 000000000..644e7724e
> --- /dev/null
> +++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd07.c
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2026 SUSE LLC
> + * Author: Ricardo Branco <rbranco@suse.com>
> + */
> +
> +/*\
> + * Force a pagefault event and handle it using :manpage:`userfaultfd(2)`
> + * from a different thread testing UFFDIO_CONTINUE.
> + */
> +
> +#include "config.h"
> +#include <poll.h>
> +#include <unistd.h>
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
> +#include "tst_safe_prw.h"
> +#include "tst_safe_pthread.h"
> +#include "lapi/memfd.h"
> +#include "lapi/userfaultfd.h"
> +#include "lapi/syscalls.h"
> +
> +static long page_size;
> +static char *page;
> +static int uffd = -1;
> +static int memfd = -1;
> +
> +static int sys_memfd_create(const char *name, unsigned int flags)
> +{
> +	return tst_syscall(__NR_memfd_create, name, flags);
We have this in testcases/kernel/syscalls/memfd_create/memfd_create_common.c.
Moving it as static inline into include/lapi/memfd.h would help to DRY.

> +}
> +
> +static void set_pages(void)
> +{
> +	char ch = 'A';
> +
> +	page_size = sysconf(_SC_PAGE_SIZE);
Maybe SAFE_SYSCONF(_SC_PAGE_SIZE) or because it should be safe:
getpagesize();

> +
> +	memfd = sys_memfd_create("ltp-uffd-continue", MFD_CLOEXEC);
> +	if (memfd < 0)
> +		tst_brk(TBROK | TERRNO, "memfd_create failed");
> +
> +	SAFE_FTRUNCATE(memfd, page_size);
> +
> +	/*
> +	 * Populate page cache so that after MADV_DONTNEED the next access
> +	 * can generate a MINOR fault rather than a MISSING fault.
> +	 */
> +	SAFE_PWRITE(1, memfd, &ch, 1, 0);
> +
> +	page = SAFE_MMAP(NULL, page_size, PROT_READ, MAP_SHARED, memfd, 0);
> +}
> +
> +static void reset_pages(void)
> +{
> +	if (page) {
> +		SAFE_MUNMAP(page, page_size);
> +		page = NULL;
> +	}
> +
> +	if (memfd != -1) {
> +		SAFE_CLOSE(memfd);
> +		memfd = -1;
This is not needed, see include/tst_safe_macros.h

#define SAFE_CLOSE(fd) do { \
		safe_close(__FILE__, __LINE__, NULL, (fd)); \
		fd = -1; \
	} while (0)

> +	}
> +
> +	if (uffd != -1) {
> +		SAFE_CLOSE(uffd);
> +		uffd = -1;
And here.

> +	}
> +}
> +
> +static void *handle_thread(void *arg LTP_ATTRIBUTE_UNUSED)
> +{
> +	static struct uffd_msg msg;
> +	struct uffdio_continue uffdio_continue = {};
> +	struct pollfd pollfd;
> +	int nready;
> +	char z = 'Z';
> +
> +	pollfd.fd = uffd;
> +	pollfd.events = POLLIN;
> +	nready = poll(&pollfd, 1, -1);
> +	if (nready == -1)
> +		tst_brk(TBROK | TERRNO, "Error on poll");
> +
> +	SAFE_READ(1, uffd, &msg, sizeof(msg));
> +
> +	if (msg.event != UFFD_EVENT_PAGEFAULT)
> +		tst_brk(TFAIL, "Received unexpected UFFD_EVENT %d", msg.event);
> +
> +	if (!(msg.arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_MINOR)) {
> +		tst_brk(TBROK, "expected MINOR fault, got flags=0x%llx",
> +			(unsigned long long)msg.arg.pagefault.flags);
> +	}
> +
> +	/* Update the shmem page in page cache before resuming the fault. */
> +	SAFE_PWRITE(1, memfd, &z, 1, 0);
> +
> +	uffdio_continue.range.start =
> +		msg.arg.pagefault.address & ~((unsigned long)page_size - 1);
> +	uffdio_continue.range.len = page_size;
> +
> +	SAFE_IOCTL(uffd, UFFDIO_CONTINUE, &uffdio_continue);
> +
> +	SAFE_CLOSE(uffd);
> +	return NULL;
> +}
> +
> +static void run(void)
> +{
> +	pthread_t thr;
> +	struct uffdio_api uffdio_api = {};
> +	struct uffdio_register uffdio_register;
> +
> +	set_pages();
Maybe have it as setup function instead of calling it manually at the beginning of run()?
I'm not sure if it justifies, but remember possible running -i1000.

THe rest LGTM.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
