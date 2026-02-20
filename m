Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80890C55190
	for <ltp@archiver.kernel.org>; Fri, 20 Feb 2026 10:41:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4A053D083B
	for <ltp@archiver.kernel.org>; Fri, 20 Feb 2026 11:41:54 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3AF493D07E9
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 11:41:36 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B56111A00931
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 11:41:34 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6DA345BCCC;
 Fri, 20 Feb 2026 10:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771584091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yv6PHfXZlYh+TLbwsr6Kj6GWpG7kLjavbyZ69vf3bPo=;
 b=MEDCjLul0hvnLJuazHOfEez5lQpRpk1+WuZiaARuew3ZUFLkyYRzojJ9v5h6r+boHMKiaf
 M2981xm9cuQt6PUsM7RC3QuXk7ZnLO3opV7bZ31R/WqjvQUbRPVJz+6dwHTVfsELBWyNWy
 CAfpmSJPSS4o3Djptyu9gaK1m218Hpw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771584091;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yv6PHfXZlYh+TLbwsr6Kj6GWpG7kLjavbyZ69vf3bPo=;
 b=6N9kMYVlstcrSQ7kVQxEgsfSllskHrKvEdqu5MnqmCdVAeSmqmwHWag/7SoJdeYoOtNYST
 p2aIQI1XY3SURvBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771584091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yv6PHfXZlYh+TLbwsr6Kj6GWpG7kLjavbyZ69vf3bPo=;
 b=MEDCjLul0hvnLJuazHOfEez5lQpRpk1+WuZiaARuew3ZUFLkyYRzojJ9v5h6r+boHMKiaf
 M2981xm9cuQt6PUsM7RC3QuXk7ZnLO3opV7bZ31R/WqjvQUbRPVJz+6dwHTVfsELBWyNWy
 CAfpmSJPSS4o3Djptyu9gaK1m218Hpw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771584091;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yv6PHfXZlYh+TLbwsr6Kj6GWpG7kLjavbyZ69vf3bPo=;
 b=6N9kMYVlstcrSQ7kVQxEgsfSllskHrKvEdqu5MnqmCdVAeSmqmwHWag/7SoJdeYoOtNYST
 p2aIQI1XY3SURvBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DFEF3EA65;
 Fri, 20 Feb 2026 10:41:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZywdEls6mGn7JwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 20 Feb 2026 10:41:31 +0000
Date: Fri, 20 Feb 2026 11:41:32 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Ricardo Branco <rbranco@suse.de>
Message-ID: <aZg6XN64W2TTvozw@yuki.lan>
References: <20260219225007.218697-1-rbranco@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260219225007.218697-1-rbranco@suse.de>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] userfaultfd: Add test using UFFDIO_POISON
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
> Signed-off-by: Ricardo Branco <rbranco@suse.de>
> ---
>  configure.ac                                  |   1 +
>  include/lapi/userfaultfd.h                    |  13 ++
>  .../kernel/syscalls/userfaultfd/.gitignore    |   1 +
>  .../kernel/syscalls/userfaultfd/Makefile      |   1 +
>  .../syscalls/userfaultfd/userfaultfd06.c      | 137 ++++++++++++++++++
>  5 files changed, 153 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/userfaultfd/userfaultfd06.c
> 
> diff --git a/configure.ac b/configure.ac
> index 7fa614dcb..94bcbcc98 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -278,6 +278,7 @@ AC_CHECK_TYPES([struct sockaddr_vm],,,[
>  ])
>  
>  AC_CHECK_TYPES([struct uffdio_move],,,[#include <linux/userfaultfd.h>])
> +AC_CHECK_TYPES([struct uffdio_poison],,,[#include <linux/userfaultfd.h>])
>  AC_CHECK_TYPES([struct uffdio_writeprotect],,,[#include <linux/userfaultfd.h>])
>  
>  # Tools knobs
> diff --git a/include/lapi/userfaultfd.h b/include/lapi/userfaultfd.h
> index 0c9e34c84..aab3890b7 100644
> --- a/include/lapi/userfaultfd.h
> +++ b/include/lapi/userfaultfd.h
> @@ -233,6 +233,19 @@ struct uffdio_writeprotect {
>  };
>  #endif	/* HAVE_STRUCT_UFFDIO_WRITEPROTECT */
>  
> +#ifndef HAVE_STRUCT_UFFDIO_POISON
> +#define UFFD_FEATURE_POISON			(1<<14)
> +#define _UFFDIO_POISON				(0x08)
> +#define UFFDIO_POISON		_IOWR(UFFDIO, _UFFDIO_POISON, \
> +				      struct uffdio_poison)
> +struct uffdio_poison {
> +        struct uffdio_range range;
> +#define UFFDIO_POISON_MODE_DONTWAKE		((__u64)1<<0)
> +        __u64 mode;
> +        __s64 updated;
> +};
> +#endif	/* HAVE_STRUCT_UFFDIO_POISON */
> +
>  #define SAFE_USERFAULTFD(flags, retry) \
>  	safe_userfaultfd(__FILE__, __LINE__, (flags), (retry))
>  
> diff --git a/testcases/kernel/syscalls/userfaultfd/.gitignore b/testcases/kernel/syscalls/userfaultfd/.gitignore
> index fb2ae243b..bc32fdf3b 100644
> --- a/testcases/kernel/syscalls/userfaultfd/.gitignore
> +++ b/testcases/kernel/syscalls/userfaultfd/.gitignore
> @@ -3,3 +3,4 @@
>  /userfaultfd03
>  /userfaultfd04
>  /userfaultfd05
> +/userfaultfd06
> diff --git a/testcases/kernel/syscalls/userfaultfd/Makefile b/testcases/kernel/syscalls/userfaultfd/Makefile
> index 96650a65a..3252e47df 100644
> --- a/testcases/kernel/syscalls/userfaultfd/Makefile
> +++ b/testcases/kernel/syscalls/userfaultfd/Makefile
> @@ -16,3 +16,4 @@ userfaultfd02: CFLAGS += -pthread
>  userfaultfd03: CFLAGS += -pthread
>  userfaultfd04: CFLAGS += -pthread
>  userfaultfd05: CFLAGS += -pthread
> +userfaultfd06: CFLAGS += -pthread
> diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c
> new file mode 100644
> index 000000000..1f132d4d5
> --- /dev/null
> +++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c
> @@ -0,0 +1,137 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2026 SUSE LLC
> + * Author: Ricardo Branco <rbranco@suse.com>
> + */
> +
> +/*\
> + * Force a pagefault event and handle it using :manpage:`userfaultfd(2)`
> + * from a different thread testing UFFDIO_POISON.
> + */
> +
> +#include "config.h"
> +#include <poll.h>
> +#include <setjmp.h>
> +#include <signal.h>
> +#include <unistd.h>
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
> +#include "tst_safe_pthread.h"
> +#include "lapi/userfaultfd.h"
> +
> +static int page_size;
> +static char *page;
> +static int uffd;
> +static int poison_fault_seen;
> +static volatile int sigbus_seen;
> +static sigjmp_buf jmpbuf;
> +
> +static void sigbus_handler(int sig)
> +{
> +	if (sig == SIGBUS) {
> +		sigbus_seen = 1;
> +		siglongjmp(jmpbuf, 1);
> +	}
> +}
> +
> +static void set_pages(void)
> +{
> +	page_size = sysconf(_SC_PAGE_SIZE);
> +	page = SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE,
> +			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (page) {
> +		SAFE_MUNMAP(page, page_size);
> +		page = NULL;
> +	}
> +}
> +
> +static void *handle_thread(void)
> +{
> +	static struct uffd_msg msg;
> +	struct uffdio_poison uffdio_poison = {};
> +	struct pollfd pollfd;
> +	int nready;
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
> +	tst_atomic_store(1, &poison_fault_seen);
> +
> +	/* Poison the page that triggered the fault */
> +	uffdio_poison.range.start = msg.arg.pagefault.address & ~(page_size - 1);
> +	uffdio_poison.range.len = page_size;
> +
> +	SAFE_IOCTL(uffd, UFFDIO_POISON, &uffdio_poison);
> +
> +	close(uffd);
> +	return NULL;
> +}
> +
> +static void run(void)
> +{
> +	pthread_t thr;
> +	struct uffdio_api uffdio_api = {};
> +	struct uffdio_register uffdio_register;
> +	struct sigaction sa = {};
> +	volatile char dummy;
> +
> +	sa.sa_handler = sigbus_handler;
> +	sigemptyset(&sa.sa_mask);
> +	SAFE_SIGACTION(SIGBUS, &sa, NULL);

The signal handle can be set once from the test setup().

And we have to reset the poison_fault_seen and sigbus_seen flags here so
that we actually test something with -i 2

> +	set_pages();
> +
> +	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
> +
> +	uffdio_api.api = UFFD_API;
> +	uffdio_api.features = UFFD_FEATURE_POISON;
> +
> +	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
> +
> +	if (!(uffdio_api.features & UFFD_FEATURE_POISON))
> +		tst_brk(TCONF, "UFFD_FEATURE_POISON not supported");
> +
> +	uffdio_register.range.start = (unsigned long) page;
> +	uffdio_register.range.len = page_size;
> +	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
> +
> +	SAFE_IOCTL(uffd, UFFDIO_REGISTER, &uffdio_register);
> +
> +	SAFE_PTHREAD_CREATE(&thr, NULL, (void *) handle_thread, NULL);
> +
> +	/* Try to read from the page: should trigger fault, get poisoned, then SIGBUS */
> +	if (sigsetjmp(jmpbuf, 1) == 0) {
> +		dummy = page[0];
> +		(void)dummy;

Does LTP_VAR_USED(dummy) = page[0] work here instead of the volatile and
cast to the (void) ?

> +	}
> +
> +	SAFE_PTHREAD_JOIN(thr, NULL);
> +
> +	int poisoned = tst_atomic_load(&poison_fault_seen);
> +
> +	if (poisoned && sigbus_seen)
> +		tst_res(TPASS, "POISON successfully triggered SIGBUS");
> +	else if (poison_fault_seen && !sigbus_seen)
> +		tst_res(TFAIL, "POISON fault seen but no SIGBUS received");
> +	else if (!poison_fault_seen && sigbus_seen)
> +		tst_res(TFAIL, "SIGBUS received but no poison fault seen");
> +	else
> +		tst_res(TFAIL, "No poison fault or SIGBUS observed");
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.cleanup = cleanup,
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
