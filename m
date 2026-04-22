Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 181B5F94CC3
	for <ltp@archiver.kernel.org>; Wed, 22 Apr 2026 05:37:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BFCD93E1B20
	for <ltp@archiver.kernel.org>; Wed, 22 Apr 2026 07:37:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7DD623E1AA6
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 07:37:24 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C1A49140026E
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 07:37:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 792AA5BD47;
 Wed, 22 Apr 2026 05:37:22 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57A81593AF;
 Wed, 22 Apr 2026 05:37:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hTaLFJJe6GnXKgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 22 Apr 2026 05:37:22 +0000
Date: Wed, 22 Apr 2026 07:37:12 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Cermak <mcermak@redhat.com>
Message-ID: <20260422053712.GB392764@pevik>
References: <20260421152349.1673057-1-mcermak@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260421152349.1673057-1-mcermak@redhat.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 792AA5BD47
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Valgrind-developers] [PATCH] Make userfaultfd0{1, 3,
 4} LTP tests valgrind compatible
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
Cc: valgrind-developers@lists.sourceforge.net, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

[ Cc Ricardo ]

> Historically a page fault is handled in the linux kernel. The
> userfaultfd mechanism [1] was introduced in Linux 4.3 (2015) to allow
> custom handling page faults in userspace. It allows for custom page
> fault handling strategies such as lazy loading, live migration of qemu
> VMs, etc.  With userfaultfd, kernel communicates with userspace via a
> file descriptor (userfaultfd).  Userfaultfd LTP tests cover this.

> These tests set up a main thread and a page fault handler thread.  Once
> a page fault happens in the main thread, kernel stops it, and let's the
> handler take care of the page fault.

> This is a problem for Valgrind, because it serializes the threads
> execution (using one "big mutex", VG_(acquire_BigLock)).  Once kernel
> stops the main thread, under valgrind, the handler thread doesn't have
> a chance to handle the page fault.  Valgrind stalls till the timeout
> (adjustable via LTP_TIMEOUT_MUL ;)

> However, some of the testcases can be easily changed to use forked
> processes instead of threads.  That's what this patch does.  When
> client program forks, Valgrind forks too, and that allows for the needed
> parallelism to handle the page fault.

You understand process vs. threads more than me. But shouldn't mmap() use
MAP_SHARED instead of MAP_PRIVATE for those which aren't using /dev/userfaultfd?

> This redesign can't be easily done with some of the tests, such as e.g.
> userfaultfd02 where both the main thread and the handler thread need to
> share the address space.  That could be done via clone() and is proven

What is the difference with userfaultfd02 then?

> to work.  But unfortunately there is another Valgrind limitation in clone
> flags it supports, so this also isn't a practical way to go.

> That said, this update tweaks userfaultfd01, userfaultfd03, and
> userfaultfd04 in a way that they become "compatible" with Valgrind.
> It's a test coverage improvement.

Also doc should be updated (mentions thread).

Please don't forget to add it next time:
Signed-off-by: Martin Cermak <mcermak@redhat.com>

> [1] https://www.kernel.org/doc/html/latest/admin-guide/mm/userfaultfd.html
> ---
>  .../kernel/syscalls/userfaultfd/userfaultfd01.c   | 13 +++++++++----
>  .../kernel/syscalls/userfaultfd/userfaultfd03.c   | 15 ++++++++++-----
>  .../kernel/syscalls/userfaultfd/userfaultfd04.c   | 13 +++++++++----
>  3 files changed, 28 insertions(+), 13 deletions(-)

> diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
> index 7368d3863..c927cda95 100644
> --- a/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
> +++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
> @@ -57,7 +57,7 @@ static void reset_pages(void)
>  	SAFE_MUNMAP(copy_page, page_size);
>  }

> -static void *handle_thread(void)
> +static void *pagefault_handler(void)
>  {
>  	static struct uffd_msg msg;
>  	struct uffdio_copy uffdio_copy = {};
> @@ -91,7 +91,7 @@ static void *handle_thread(void)

>  static void run(unsigned int i)
>  {
> -	pthread_t thr;
> +	pid_t pid;
>  	struct uffdio_api uffdio_api = {};
>  	struct uffdio_register uffdio_register;
>  	struct tcase *tc = &tcases[i];
> @@ -112,7 +112,11 @@ static void run(unsigned int i)

>  	SAFE_IOCTL(uffd, UFFDIO_REGISTER, &uffdio_register);

> -	SAFE_PTHREAD_CREATE(&thr, NULL, (void *) handle_thread, NULL);
> +	pid = SAFE_FORK();
> +	if (pid == 0) {
> +		pagefault_handler();
> +		_exit(0);
> +	}

>  	char c = page[0xf];

> @@ -121,7 +125,7 @@ static void run(unsigned int i)
>  	else
>  		tst_res(TFAIL, "Pagefault not handled!");

> -	SAFE_PTHREAD_JOIN(thr, NULL);
> +	SAFE_WAITPID(pid, NULL, 0);
>  	reset_pages();
>  }

> @@ -129,4 +133,5 @@ static struct tst_test test = {
>  	.setup = setup,
>  	.test = run,
>  	.tcnt = ARRAY_SIZE(tcases),
> +	.forks_child = 1,
>  };
> diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd03.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd03.c
> index b65f39eca..f5d3be1ae 100644
> --- a/testcases/kernel/syscalls/userfaultfd/userfaultfd03.c
> +++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd03.c
> @@ -61,7 +61,7 @@ static void reset_pages(void)
>  	SAFE_MUNMAP(copy_page, page_size);
>  }

> -static void *handle_thread(void)
> +static void *pagefault_handler(void)
>  {
>  	static struct uffd_msg msg;
>  	struct uffdio_copy uffdio_copy = {};
> @@ -95,7 +95,7 @@ static void *handle_thread(void)

>  static void run(void)
>  {
> -	pthread_t thr;
> +	pid_t pid;
>  	struct uffdio_api uffdio_api = {};
>  	struct uffdio_register uffdio_register;

> @@ -112,7 +112,11 @@ static void run(void)

>  	SAFE_IOCTL(uffd, UFFDIO_REGISTER, &uffdio_register);

> -	SAFE_PTHREAD_CREATE(&thr, NULL, (void *) handle_thread, NULL);
> +	pid = SAFE_FORK();
> +		if (pid == 0) {
> +		pagefault_handler();
> +		_exit(0);
> +	}

>  	char c = page[0xf];

> @@ -121,7 +125,7 @@ static void run(void)
>  	else
>  		tst_res(TFAIL, "Pagefault not handled via /dev/userfaultfd");

> -	SAFE_PTHREAD_JOIN(thr, NULL);
> +	SAFE_WAITPID(pid, NULL, 0);
>  	reset_pages();
>  }

> @@ -132,5 +136,6 @@ static struct tst_test test = {
>  	.needs_kconfigs = (const char *[]) {
>  		"CONFIG_USERFAULTFD=y",
>  		NULL
> -	}
> +	},
> +	.forks_child = 1,
>  };
> diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd04.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd04.c
> index 4eb811e45..13883a711 100644
> --- a/testcases/kernel/syscalls/userfaultfd/userfaultfd04.c
> +++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd04.c
> @@ -33,7 +33,7 @@ static void reset_pages(void)
>  	SAFE_MUNMAP(page, page_size);
>  }

> -static void *handle_thread(void)
> +static void *pagefault_handler(void)
>  {
>  	static struct uffd_msg msg;
>  	struct uffdio_zeropage uffdio_zeropage = {};
> @@ -64,7 +64,7 @@ static void *handle_thread(void)

>  static void run(void)
>  {
> -	pthread_t thr;
> +	pid_t pid;
>  	struct uffdio_api uffdio_api = {};
>  	struct uffdio_register uffdio_register;

> @@ -81,7 +81,11 @@ static void run(void)

>  	SAFE_IOCTL(uffd, UFFDIO_REGISTER, &uffdio_register);

> -	SAFE_PTHREAD_CREATE(&thr, NULL, (void *) handle_thread, NULL);
> +	pid = SAFE_FORK();
> +	if (pid == 0) {
> +		pagefault_handler();
> +		_exit(0);
> +	}

>  	for (int i = 0; i < page_size; i++) {
>  		if (page[i] != 0) {
> @@ -92,10 +96,11 @@ static void run(void)

>  	tst_res(TPASS, "Pagefault handled with UFFDIO_ZEROPAGE");

> -	SAFE_PTHREAD_JOIN(thr, NULL);
> +	SAFE_WAITPID(pid, NULL, 0);
>  	reset_pages();
>  }

>  static struct tst_test test = {
>  	.test_all = run,
> +	.forks_child = 1,
>  };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
