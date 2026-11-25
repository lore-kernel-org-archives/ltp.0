Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00536606A33A
	for <ltp@archiver.kernel.org>; Wed, 25 Nov 2026 12:22:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2DF863E9C34
	for <ltp@archiver.kernel.org>; Wed, 25 Nov 2026 13:21:59 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 89C7A3E1541
 for <ltp@lists.linux.it>; Wed, 25 Nov 2026 13:21:44 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EBE6310000F2
 for <ltp@lists.linux.it>; Wed, 25 Nov 2026 13:21:43 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 417031F45A;
 Wed, 25 Nov 2026 12:21:43 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10845134CA;
 Wed, 25 Nov 2026 12:21:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RXy+NtbSBmtNXwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 25 Nov 2026 12:21:43 +0000
Date: Wed, 25 Nov 2026 13:22:06 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Ricardo Branco <rbranco@suse.de>
Message-ID: <awbS7qkrPNhm7Kfq@yuki.lan>
References: <20261124180149.614825-1-rbranco@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261124180149.614825-1-rbranco@suse.de>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Queue-Id: 417031F45A
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] userfaultfd: Add tests for UFFDIO_RWPROTECT
 and UFFDIO_SET_MODE
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: "Claude Opus 5.5" <noreply@anthropic.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +static void run(unsigned int n)
> +{
> +	pthread_t thr;
> +	struct uffdio_api uffdio_api = { .api = UFFD_API };
> +	struct uffdio_register uffdio_register;
> +	struct uffdio_set_mode uffdio_set_mode = {
> +		.disable = UFFD_FEATURE_RWP_ASYNC,
> +	};
> +	struct pollfd pollfd;
> +	unsigned char val;
> +
> +	uffdio_api.features = UFFD_FEATURE_RWP;
> +	if (n) {
> +		CHECK_UFFD_FEATURE(UFFD_FEATURE_RWP_ASYNC);
> +		uffdio_api.features |= UFFD_FEATURE_RWP_ASYNC;
> +	}
> +
> +	set_page();
> +	rwp_fault_seen = 0;
> +
> +	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
> +
> +	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
> +
> +	uffdio_register.range.start = (unsigned long)page;
> +	uffdio_register.range.len = page_size;
> +	uffdio_register.mode = UFFDIO_REGISTER_MODE_RWP;
> +
> +	SAFE_IOCTL(uffd, UFFDIO_REGISTER, &uffdio_register);
> +
> +	if (n) {
> +		/* Async mode is active, access must auto-resolve. */
> +		rwprotect((unsigned long)page, UFFDIO_RWPROTECT_MODE_RWP);
> +
> +		val = page[0];
> +
> +		if (val != PAGE_BYTE) {
> +			tst_res(TFAIL, "Async access corrupted content: got 0x%02x, expected 0x%02x",
> +				val, PAGE_BYTE);
> +			goto out;
> +		}
> +
> +		pollfd.fd = uffd;
> +		pollfd.events = POLLIN;
> +		if (SAFE_POLL(&pollfd, 1, 0) != 0) {
> +			tst_res(TFAIL, "Unexpected pagefault message in async mode");
> +			goto out;
> +		}
> +
> +		/* Switch to sync mode via UFFDIO_SET_MODE. */
> +		SAFE_IOCTL(uffd, UFFDIO_SET_MODE, &uffdio_set_mode);
> +	}
> +
> +	rwprotect((unsigned long)page, UFFDIO_RWPROTECT_MODE_RWP);
> +
> +	SAFE_PTHREAD_CREATE(&thr, NULL, handle_thread, NULL);
> +
> +	/* Try to read the RWP-protected page. */
> +	val = page[0];
> +
> +	SAFE_PTHREAD_JOIN(thr, NULL);
> +
> +	if (!rwp_fault_seen) {
> +		tst_res(TFAIL, "No RWPROTECT pagefault observed");
> +		goto out;
> +	}
> +
> +	if (val != PAGE_BYTE) {
> +		tst_res(TFAIL, "Page content corrupted: got 0x%02x, expected 0x%02x",
> +			val, PAGE_BYTE);
> +		goto out;
> +	}

Shouldn't this part be in else branch? Otherwise we run both tests for n
= 1.

I suppose that we would have to run the handle_thread in the first if
branch as well, but not as a thread, since it's asynchronous we can run
it as a normal function.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
