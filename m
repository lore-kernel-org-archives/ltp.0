Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836F1CA5FD4
	for <ltp@archiver.kernel.org>; Thu,  1 Oct 2026 16:16:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 60A963E626F
	for <ltp@archiver.kernel.org>; Thu,  1 Oct 2026 18:16:37 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 95DB33E5CC4
 for <ltp@lists.linux.it>; Thu,  1 Oct 2026 18:16:22 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F150C1000DC3
 for <ltp@lists.linux.it>; Thu,  1 Oct 2026 18:16:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BB9681FCFD;
 Thu,  1 Oct 2026 16:16:20 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E95813B83;
 Thu,  1 Oct 2026 16:16:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id a7gnFVSHvmqIZQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 01 Oct 2026 16:16:20 +0000
Date: Thu, 1 Oct 2026 18:16:04 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20261001161604.GA3084598@pevik>
References: <20261001-fix_aio_suspend-1-1-v2-1-d444497432ea@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261001-fix_aio_suspend-1-1-v2-1-d444497432ea@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: BB9681FCFD
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] openposix: Fix aio_suspend/1-1 completion race
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> The aio_suspend/1-1 test relies on regular-file I/O remaining pending
> until the test checks its status. If the selected request completes
> too quickly, the test reports an unresolved result.

> Replace regular-file I/O with writes to a socket pair, using the
> existing AIO setup and cleanup helpers. A second thread waits for the
> main thread to sleep before draining the socket. This preserves the
> pending-request check and exercises aio_suspend() waiting for I/O.

> The test passed 100 normal runs and 100 runs pinned to one CPU.
> It also rejected all 30 injected cases where aio_suspend() returned
> success without waiting. Build, checkpatch, and whitespace checks
> passed.

> Changes in v2:
> - Preserve the pending-I/O check, following Martin Doucha's feedback.
> - Use a full socket and a coordinated draining thread.
> - Reuse setup_aio() and cleanup_aio().
> - Link to v1:
>   https://lore.kernel.org/20261001-fix_aio_suspend-1-1-v1-1-ac365dc874ef@suse.com
> ---
>  .../conformance/interfaces/aio_suspend/1-1.c       | 284 +++++++++------------
>  1 file changed, 118 insertions(+), 166 deletions(-)

> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/1-1.c
> index 8f0c9ae95..d08709ee9 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/1-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/1-1.c
> @@ -7,216 +7,168 @@
>   */

>  /*
> - * assertion:
I'm not sure how important is to keep the doc structure, but other tests
keep having "assertion:" and "method:" (e.g.
testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/6-1.c
which Martin rewrote).
That somehow correlates with assertions for aio_suspend() in
testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/assertions.xml

nit: I'd also update copyright (worth for major rewrite).

The code itself LGTM. I wonder if Martin finds something.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
