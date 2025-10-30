Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDBE1CCF9F0
	for <ltp@archiver.kernel.org>; Thu, 30 Oct 2025 20:08:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 252243CC2D4
	for <ltp@archiver.kernel.org>; Thu, 30 Oct 2025 21:08:13 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3786B3CBBD5
 for <ltp@lists.linux.it>; Thu, 30 Oct 2025 21:07:57 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0499E60056F
 for <ltp@lists.linux.it>; Thu, 30 Oct 2025 21:07:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3D0051F76B;
 Thu, 30 Oct 2025 20:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761854873;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hmyGks6RO1+I5uOpdgMXw5Uxs2sWQKtWcKLOAh+CBOE=;
 b=kVHwEjjz/OehCgdRoxPcXnHCFcQdatTvge2sHkKfe26apMRzXgZhTU4CNS1wjs2byeNVss
 gpdTk7cWg1ySo/hSNSy/HhxmXTUtV+0vI12EZi3cZiXmchKX5QQ5ML22Cn+yqMf7g7jqub
 147B9xxJ9dxkIv0xMxKY7n/AVSS35NM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761854873;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hmyGks6RO1+I5uOpdgMXw5Uxs2sWQKtWcKLOAh+CBOE=;
 b=5OpFA9a60L9FRsGK283Nj1PCtZF+atQoSfiUyznik7DIgLl42OA85/mLaFIK+oDEP83pFb
 T/057HihExCAa+DQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kVHwEjjz;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5OpFA9a6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761854873;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hmyGks6RO1+I5uOpdgMXw5Uxs2sWQKtWcKLOAh+CBOE=;
 b=kVHwEjjz/OehCgdRoxPcXnHCFcQdatTvge2sHkKfe26apMRzXgZhTU4CNS1wjs2byeNVss
 gpdTk7cWg1ySo/hSNSy/HhxmXTUtV+0vI12EZi3cZiXmchKX5QQ5ML22Cn+yqMf7g7jqub
 147B9xxJ9dxkIv0xMxKY7n/AVSS35NM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761854873;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hmyGks6RO1+I5uOpdgMXw5Uxs2sWQKtWcKLOAh+CBOE=;
 b=5OpFA9a60L9FRsGK283Nj1PCtZF+atQoSfiUyznik7DIgLl42OA85/mLaFIK+oDEP83pFb
 T/057HihExCAa+DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7E2B1396A;
 Thu, 30 Oct 2025 20:07:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id w6bdNpjFA2lPawAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 30 Oct 2025 20:07:52 +0000
Date: Thu, 30 Oct 2025 21:07:50 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20251030200750.GB753947@pevik>
References: <20251015031540.2120-1-wegao@suse.com>
 <20251030054029.23511-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251030054029.23511-1-wegao@suse.com>
X-Rspamd-Queue-Id: 3D0051F76B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[pollfd.events:url,suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,ozlabs.org:url,suse.com:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:replyto,pollfd.events:url,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] mremap07.c: New case check mremap with
 MREMAP_DONTUNMAP
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

> This case test mremap() with MREMAP_DONTUNMAP and use userfaultfd
> verifies fault which triggered by accessing old memory region.

nit: Having a changelog would help reviewing.

...
> +++ b/configure.ac
> @@ -46,6 +46,7 @@ AC_CHECK_DECLS([MADV_MERGEABLE],,,[#include <sys/mman.h>])
>  AC_CHECK_DECLS([NFTA_CHAIN_ID, NFTA_VERDICT_CHAIN_ID],,,[#include <linux/netfilter/nf_tables.h>])
>  AC_CHECK_DECLS([PR_CAPBSET_DROP, PR_CAPBSET_READ],,,[#include <sys/prctl.h>])
>  AC_CHECK_DECLS([SEM_STAT_ANY],,,[#include <sys/sem.h>])
> +AC_CHECK_DECLS([MREMAP_DONTUNMAP],,,[#include <linux/mman.h>])
Obviously AC_CHECK_DECLS() does not require to define _GNU_SOURCE, interesting.

...
> +++ b/testcases/kernel/syscalls/mremap/mremap07.c
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2025 Wei Gao <wegao@suse.com>
> + */
> +
> +/*\
> + * LTP test case for mremap() with MREMAP_DONTUNMAP and userfaultfd.
> + *
> + * This test verifies a fault is triggered on the old memory region
> + * and is then correctly handled by a userfaultfd handler.
> + */

You should include config.h if you want to check for HAVE_DECL_MREMAP_DONTUNMAP:
#include "config.h"

This works just because some header already do it, but that can change in the
future.

> +#define _GNU_SOURCE
> +#include <poll.h>
> +#include <pthread.h>
> +
> +#include "tst_test.h"
> +#include "tst_safe_pthread.h"
> +#include "lapi/userfaultfd.h"
> +
> +#if HAVE_DECL_MREMAP_DONTUNMAP

Interesting, you don't include <linux/mman.h>, which should have
MREMAP_DONTUNMAP, but the check works as expected. But I would still prefer to
include <linux/mman.h>.

> +static int page_size;
> +static int uffd;
> +static char *fault_addr;
> +static char *new_remap_addr;
> +
> +static const char *test_string = "Hello, world! This is a test string that fills up a page.";
> +
> +static int sys_userfaultfd(int flags)
> +{
> +	return tst_syscall(__NR_userfaultfd, flags);
> +}

This is copy pasted from userfaultfd01.c. I factored it out to
include/lapi/userfaultfd.h, could you please use it in the next version?

https://lore.kernel.org/ltp/20251030192543.761804-1-pvorel@suse.cz/
https://patchwork.ozlabs.org/project/ltp/patch/20251030192543.761804-1-pvorel@suse.cz/

> +static void fault_handler_thread(void)
> +{
> +	struct uffd_msg msg;
> +	struct uffdio_copy uffdio_copy;
> +
> +	TST_CHECKPOINT_WAIT(0);
> +
> +	struct pollfd pollfd;
> +
> +	pollfd.fd = uffd;
> +	pollfd.events = POLLIN;
> +
> +	int nready = poll(&pollfd, 1, -1);
Interesting, we still don't have safe_poll().

> +	if (nready <= 0)
man poll(2) says:
return value of zero indicates that the system call timed out before any file descriptors became ready.
userfaultfd01.c checks only for nready == -1, I'm not sure maybe it should also check for 0.
But if you also check for 0, maybe printing nready would be useful (OTOH TERRNO
prints SUCCESS(0)).

> +		tst_brk(TBROK | TERRNO, "Poll on uffd failed");
Maybe just poll() failed?

> +
> +	SAFE_READ(1, uffd, &msg, sizeof(msg));
> +
> +	if (msg.event != UFFD_EVENT_PAGEFAULT)
> +		tst_brk(TBROK, "Received unexpected UFFD_EVENT: %d", msg.event);
> +
> +	if ((char *)msg.arg.pagefault.address != fault_addr)
> +		tst_brk(TBROK, "Page fault on unexpected address: %p", (void *)msg.arg.pagefault.address);
> +
> +	tst_res(TINFO, "Userfaultfd handler caught a page fault at %p", (void *)msg.arg.pagefault.address);
> +
> +	uffdio_copy.src = (unsigned long)new_remap_addr;
> +	uffdio_copy.dst = (unsigned long)fault_addr;
> +	uffdio_copy.len = page_size;
> +	uffdio_copy.mode = 0;
> +	uffdio_copy.copy = 0;

Most of this code is the same as in userfaultfd01.c, but I don't see a way to
factor it out more than what I sent in my patch.

> +
> +	SAFE_IOCTL(uffd, UFFDIO_COPY, &uffdio_copy);
> +	tst_res(TPASS, "Userfaultfd handler successfully handled the fault.");
very nit: please avoid '.' at the end.
> +}
> +
> +static void setup(void)
> +{
> +	page_size = getpagesize();
> +	struct uffdio_api uffdio_api;
> +	struct uffdio_register uffdio_register;
> +
> +	TEST(sys_userfaultfd(O_CLOEXEC | O_NONBLOCK));
> +	if (TST_RET == -1) {
> +		if (TST_ERR == EPERM) {
> +			tst_res(TCONF, "Hint: check /proc/sys/vm/unprivileged_userfaultfd");
> +			tst_brk(TCONF | TTERRNO, "userfaultfd() requires CAP_SYS_PTRACE on this system");
> +		} else {
> +			tst_brk(TBROK | TTERRNO, "Could not create userfault file descriptor");
> +		}
> +	}
This would be also replaced by my patch, only this would be used:
uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, true);

> +
> +	uffd = TST_RET;
> +	uffdio_api.api = UFFD_API;
> +	uffdio_api.features = 0;
> +	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
> +
> +	fault_addr = SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
nit: maybe split long line?
> +
> +	tst_res(TINFO, "Original mapping created at %p", (void *)fault_addr);
> +
> +	strcpy(fault_addr, "ABCD");
> +
> +	uffdio_register.range.start = (unsigned long)fault_addr;
> +	uffdio_register.range.len = page_size;
> +	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
> +	SAFE_IOCTL(uffd, UFFDIO_REGISTER, &uffdio_register);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (new_remap_addr != NULL)
> +		SAFE_MUNMAP(new_remap_addr, page_size);
> +
> +	if (fault_addr != NULL)
> +		SAFE_MUNMAP(fault_addr, page_size);
> +
> +	if (uffd != -1)
> +		SAFE_CLOSE(uffd);
> +}
> +
> +static void run(void)
> +{
> +	pthread_t handler_thread;
> +
> +	SAFE_PTHREAD_CREATE(&handler_thread, NULL,
> +		(void * (*)(void *))fault_handler_thread, NULL);
> +
> +	new_remap_addr = mremap(fault_addr, page_size, page_size, MREMAP_DONTUNMAP | MREMAP_MAYMOVE);
nit: long line.

> +
> +	if (new_remap_addr == MAP_FAILED)
> +		tst_brk(TBROK | TTERRNO, "mremap failed");
> +
> +	tst_res(TINFO, "New mapping created at %p", (void *)new_remap_addr);
> +
> +	strcpy(new_remap_addr, test_string);
> +
> +	TST_CHECKPOINT_WAKE(0);
> +
> +	tst_res(TINFO, "Main thread accessing old address %p to trigger fault. Access Content is \"%s\"",
> +			(void *)fault_addr, fault_addr);
nit: could we remove "Access Content is \"%s\"" ? It's not important for
the result if it pass (you print it also on the failure) and line is too long.

> +
> +	SAFE_PTHREAD_JOIN(handler_thread, NULL);
> +
> +	if (strcmp(fault_addr, test_string) != 0)
> +		tst_res(TFAIL, "Verification failed: Content at old address is '%s', expected '%s'", fault_addr, test_string);
Maybe s/at/of the/ ?

> +	else
> +		tst_res(TPASS, "Verification passed: Content at old address is correct after fault handling.");
nit: '.' at the end.
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.needs_checkpoints = 1,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_USERFAULTFD=y",
> +		NULL,
> +	},
> +	.min_kver = "5.7",

I wonder if we check for MREMAP_DONTUNMAP whether we need to have also explicit
check for MREMAP_DONTUNMAP. But sure, it's safer to have runtime kernel check
and check that it was not compiled with an old headers.

Kind regards,
Petr

> +};
> +
> +#else
> +TST_TEST_TCONF("Missing MREMAP_DONTUNMAP in <linux/mman.h>");
> +#endif

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
