Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E52CA0EC4
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 10:51:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 080F03CB2D0
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 12:51:53 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 475D03C052E
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 12:51:35 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CEBF02002DE
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 12:51:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 56F741F795;
 Tue, 12 Aug 2025 10:51:33 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A41D1351A;
 Tue, 12 Aug 2025 10:51:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pLY3DbUcm2iyDwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 12 Aug 2025 10:51:33 +0000
Date: Tue, 12 Aug 2025 12:51:27 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20250812105127.GB835467@pevik>
References: <20250812-cve_2025_38236-v1-1-e3617ada69c6@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250812-cve_2025_38236-v1-1-e3617ada69c6@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 56F741F795
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cve: add CVE-2025-38236 test
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

Hi Andrea,

> +++ b/testcases/cve/cve-2025-38236.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2025 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * Test for CVE-2025-38236 fixed in kernel v6.16-rc4:
> + * af_unix: Don't leave consecutive consumed OOB skbs.
> + *
> + * The bug is triggered by sending multiple out-of-band data to a socket and
> + * reading it back from it. According to the MSG_OOB implementation, this
> + * shouldn't be possible. When system is affected by CVE-2025-38236, instead,
> + * skb queue holds MSG_OOB data, breaking recv() and causing a use-after-free
> + * condition.
> + *
> + * Even if MSG_OOB is mostly used inside Oracle's product, it is enabled by
> + * default in linux kernel via CONFIG_AF_UNIX_OOB. This is accessible via
> + * Chrome's renderer sandbox, which might cause an attacker to escalate and to
> + * obtain privileges in the system.

Maybe mention it's based on the reproducer from
https://project-zero.issues.chromium.org/issues/423023990

(That adds both background info + kind of credit of the author of the patch who
was the author of the initial reproducer).

> + */
> +
> +#include "tst_test.h"
> +
> +static const struct timeval sock_timeout = {
> +	.tv_sec = 1,
> +};
> +
> +static char dummy;
> +static int sock[2];
> +
> +static void run(void)
> +{
> +	int ret;
> +
> +	dummy = '\0';
> +
> +	tst_res(TINFO, "#1 send and receive out-of-band data");
> +	SAFE_SEND(0, sock[1], "A", 1, MSG_OOB);
> +	SAFE_RECV(0, sock[0], &dummy, 1, MSG_OOB);
> +
> +	tst_res(TINFO, "#2 send and receive out-of-band data");
> +	SAFE_SEND(0, sock[1], "A", 1, MSG_OOB);
> +	SAFE_RECV(0, sock[0], &dummy, 1, MSG_OOB);
> +
> +	tst_res(TINFO, "Send out-of-band data");
> +	SAFE_SEND(0, sock[1], "A", 1, MSG_OOB);
> +
> +	tst_res(TINFO, "Receive data from normal stream");
> +
> +	ret = recv(sock[0], &dummy, 1, 0);

+1 the core part from the original verifier.

> +	if (ret == -1) {
> +		if (errno == EWOULDBLOCK)
> +			tst_res(TPASS, "Can't read out-of-band data from normal stream");
> +		else
> +			tst_brk(TBROK | TERRNO, "recv error");
> +	} else {
very nit: using 'if' with return is more readable than short 'if' part and long
'else' part:

if (...) {
	...
	return;
}

const char *msg = "We are able to read out-of-band data from normal stream";
...


> +		const char *msg = "We are able to read out-of-band data from normal stream";
> +
> +		if (dummy == 'A') {
> +			tst_res(TFAIL, "%s", msg);
> +		} else {
> +			tst_res(TFAIL, "%s, but data doesn't match: '%c' != 'A'",
> +				msg, dummy);
> +		}

> +
> +		SAFE_RECV(0, sock[0], &dummy, 1, MSG_OOB);

FYI: on vulnerable kernel with SELinux I get (nothing to be fixed):
cve-2025-38236.c:48: TINFO: Receive data from normal stream
cve-2025-38236.c:60: TFAIL: We are able to read out-of-band data from normal stream
cve-2025-38236.c:66: TBROK: recv(3, 0x4391d8, 1, 1) failed: EFAULT (14)
> +
> +		tst_res(TFAIL, "We are able to access data from skb queue (use-after-free)");
> +	}
> +}
> +
> +static void setup(void)
> +{
> +	SAFE_SOCKETPAIR(AF_UNIX, SOCK_STREAM, 0, sock);
> +	SAFE_SETSOCKOPT(sock[0], SOL_SOCKET, SO_RCVTIMEO,
> +		 &sock_timeout, sizeof(struct timeval));
> +}

Why is struct timeval needed? I haven't found that in
https://project-zero.issues.chromium.org/issues/423023990
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=32ca245464e1

and test works as a verifier without it. If really not needed please remove it
before merge.

> +
> +static void cleanup(void)
> +{
> +	if (sock[0] != -1)
> +		SAFE_CLOSE(sock[0]);
> +
> +	if (sock[1] != -1)
> +		SAFE_CLOSE(sock[1]);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_AF_UNIX_OOB=y",
Although this is true I wonder if we should limit the reproducer to this.
If one day config silently renames / is removed (but OOB kept) the reproducer
will be lost.

LGTM, thanks for a quickly porting the reproducer!

With added entry to runtest/cve you may add:
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> +		NULL
> +	},
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "32ca245464e1"},
> +		{"CVE", "2025-38236"},
> +		{}
> +	}
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
