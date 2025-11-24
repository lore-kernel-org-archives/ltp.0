Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3B1CFD341
	for <ltp@archiver.kernel.org>; Mon, 24 Nov 2025 18:00:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C8D903C9ED8
	for <ltp@archiver.kernel.org>; Mon, 24 Nov 2025 19:00:13 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E22A73C8307
 for <ltp@lists.linux.it>; Mon, 24 Nov 2025 18:59:57 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6A3D56007B6
 for <ltp@lists.linux.it>; Mon, 24 Nov 2025 18:59:57 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C48AF5BCD9;
 Mon, 24 Nov 2025 17:59:56 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 931753EA63;
 Mon, 24 Nov 2025 17:59:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Kw6sIhydJGmFXAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 24 Nov 2025 17:59:56 +0000
Date: Mon, 24 Nov 2025 18:59:51 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251124175951.GA127343@pevik>
References: <20251124164307.20516-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251124164307.20516-1-chrubis@suse.cz>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: C48AF5BCD9
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] doc: Add basic shell test description
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

Hi Cyril,

TL;DR You already add my RBT (thanks), please amend your patch with the diff below.

...
> +    'shell_lib': (f'{ltp_repo}/blob/master/testcases/lib/%s', '%s'),
+1. I was thinking about it previously for C helpers, then I preferred to show
full path. I guess I'll later use 'shell_lib' prefix for these. I suppose we can
keep lib/*.c path, but sure, we could also (later) add 'lib' and 'include'.

I wish extlinks module allow to pass more params than just one.

...
> +The test setup and cleanup functions are optional and passed via variables.
> +Similarily to the C API the setup is executed exactly once at the start of the

Similarily => Similarly

> +test and the test cleanup is executed at the test end or when test was
> +interrupted by ref:`tst_brk`.
=> missing leading ':' causes text "by ref:tst_brk."

interrupted by :ref:`tst_brk`.

> +
> +   .. literalinclude:: ../../testcases/lib/tests/shell_loader_setup_cleanup.sh
> +   :language: shell

+1, nice feature.  "language : shell" require another level of indentation,
otherwise it just shows as a test below code.

Kind regards,
Petr

+++ doc/developers/api_shell_tests.rst
@@ -87,9 +87,9 @@ Test setup and cleanup
 ----------------------
 
 The test setup and cleanup functions are optional and passed via variables.
-Similarily to the C API the setup is executed exactly once at the start of the
+Similarly to the C API the setup is executed exactly once at the start of the
 test and the test cleanup is executed at the test end or when test was
-interrupted by ref:`tst_brk`.
+interrupted by :ref:`tst_brk`.
 
    .. literalinclude:: ../../testcases/lib/tests/shell_loader_setup_cleanup.sh
-   :language: shell
+      :language: shell

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
