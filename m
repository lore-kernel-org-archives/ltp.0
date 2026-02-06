Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D15AEE20A8
	for <ltp@archiver.kernel.org>; Fri,  6 Feb 2026 14:48:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 498B83CDE8D
	for <ltp@archiver.kernel.org>; Fri,  6 Feb 2026 15:48:18 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC79E3CD17F
 for <ltp@lists.linux.it>; Fri,  6 Feb 2026 15:47:57 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 22606601D47
 for <ltp@lists.linux.it>; Fri,  6 Feb 2026 15:47:56 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B352F5BCC2;
 Fri,  6 Feb 2026 14:47:56 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68BAA3EA63;
 Fri,  6 Feb 2026 14:47:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7vPXFRz/hWnTBgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 06 Feb 2026 14:47:56 +0000
Date: Fri, 6 Feb 2026 15:47:54 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Ricardo Branco <rbranco@suse.de>
Message-ID: <20260206144754.GA404539@pevik>
References: <20260205205609.147851-1-rbranco@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260205205609.147851-1-rbranco@suse.de>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B352F5BCC2
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] userfaultfd: Add test using UFFDIO_POISON
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

...
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
> +static void reset_pages(void)
> +{
> +	SAFE_MUNMAP(page, page_size);
> +}
> +
> +static void *handle_thread(void)
> +{
> +	static struct uffd_msg msg;
> +	struct uffdio_poison uffdio_poison = {};
> +	struct pollfd pollfd;
> +	int nready;
> +
> +	SAFE_PTHREAD_BARRIER_WAIT(&barrier);
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
> +	poison_fault_seen = 1;
> +
> +	/* Poison the page that triggered the fault */
> +	uffdio_poison.range.start = msg.arg.pagefault.address & ~(page_size - 1);
> +	uffdio_poison.range.len = page_size;
> +
> +	SAFE_IOCTL(uffd, UFFDIO_POISON, &uffdio_poison);

CI shows old toolchains fail due:
error: 'UFFDIO_POISON' undeclared

We need a fallback definition in include/lapi/userfaultfd.h.

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
> +
> +	set_pages();
> +
> +	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
> +
> +	uffdio_api.api = UFFD_API;
> +	uffdio_api.features = UFFD_FEATURE_POISON;
> +
> +	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
> +
> +	uffdio_register.range.start = (unsigned long) page;
> +	uffdio_register.range.len = page_size;
> +	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
> +
> +	SAFE_IOCTL(uffd, UFFDIO_REGISTER, &uffdio_register);
> +
> +	SAFE_PTHREAD_BARRIER_INIT(&barrier, NULL, 2);
> +	SAFE_PTHREAD_CREATE(&thr, NULL, (void *) handle_thread, NULL);
> +
> +	SAFE_PTHREAD_BARRIER_WAIT(&barrier);
> +
> +	/* Try to read from the page: should trigger fault, get poisoned, then SIGBUS */
> +	if (sigsetjmp(jmpbuf, 1) == 0) {
> +		dummy = page[0];
> +		(void)dummy;
> +	}
> +
> +	SAFE_PTHREAD_JOIN(thr, NULL);
> +	SAFE_PTHREAD_BARRIER_DESTROY(&barrier);
> +	reset_pages();
If any of the SAFE_* functions fail, reset_pages() is not called.
We should call it also in cleanup(), guard it with variable not to be munmapped
twice.

The rest LGTM.

Kind regards,
Petr

> +
> +	if (poison_fault_seen && sigbus_seen) {
> +		tst_res(TPASS, "POISON successfully triggered SIGBUS");
> +	} else if (poison_fault_seen && !sigbus_seen) {
> +		tst_res(TFAIL, "POISON fault seen but no SIGBUS received");
> +	} else if (!poison_fault_seen && sigbus_seen) {
> +		tst_res(TFAIL, "SIGBUS received but no poison fault seen");
> +	} else {
> +		tst_res(TFAIL, "No poison fault or SIGBUS observed");
> +	}
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.min_kver = "6.6",
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
