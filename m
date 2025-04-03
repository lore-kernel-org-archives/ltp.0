Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57890C3601A
	for <ltp@archiver.kernel.org>; Thu,  3 Apr 2025 14:12:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B085F3CB2A9
	for <ltp@archiver.kernel.org>; Thu,  3 Apr 2025 16:12:18 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E01D3CA113
 for <ltp@lists.linux.it>; Thu,  3 Apr 2025 16:12:03 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D7521200760
 for <ltp@lists.linux.it>; Thu,  3 Apr 2025 16:12:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 64CD22111F;
 Thu,  3 Apr 2025 14:12:01 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 525C21392A;
 Thu,  3 Apr 2025 14:12:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2mfjEjGX7mfGUAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 03 Apr 2025 14:12:01 +0000
Date: Thu, 3 Apr 2025 16:12:27 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z-6XSwc9Rbu2RIzm@yuki.lan>
References: <20250403113053.20040-1-chrubis@suse.cz>
 <20250403123610.GA465253@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250403123610.GA465253@pevik>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: 64CD22111F
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib/tst_test.c: Fix tst_brk() handling
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
> One thing I'm worried is the fact that some shell loader tests core dumped in CI:
> https://github.com/pevik/ltp/actions/runs/14242818586/job/39916477770
> e.g. these which are supposed to TBROK due broken metadata:
> shell_loader_invalid_block.sh, shell_loader_no_metadata.sh,
> shell_loader_wrong_metadata.sh:
> 
> Segmentation fault (core dumped)

Ah, that's because if we call tst_brk() before we finished
initialization results is not defined. We need at least:

diff --git a/lib/tst_test.c b/lib/tst_test.c
index c6395a5eb..6b1100b09 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -407,7 +407,8 @@ void tst_vbrk_(const char *file, const int lineno, int ttype, const char *fmt,
         * current process.
         */
        if (TTYPE_RESULT(ttype) == TBROK) {
-               tst_atomic_inc(&results->abort_flag);
+               if (results)
+                       tst_atomic_inc(&results->abort_flag);

                /*
                 * If TBROK was called from one of the child processes we kill

> I also wonder if tst_brk() related doc should be updated.

I did update the documentation comment in the tst_test.h.

> Isn't there anything which should be updated in doc/old/C-Test-API.asciidoc ?
> This docs will stay with us for some time, the conversion to kerneldoc takes
> time, it'd be good to keep it updated (valuable texts will be migrated to
> kerneldoc).
> 
> Maybe parts:
> 1.8 Doing the test in the child process
> 1.9 Fork() and Parent-child synchronization
> (both code examples and the description).

I will have a look.

> very nit: please before merge fix typos in both code and commit message:
> exitting => exiting
> countes|countes => counters
> immediatelly => immediately
> filtesystem => filesyste

Uff, will do.

> NOTE: test_brk_pass could be added to lib/newlib_tests/runtest.sh. I would also
> prefer, if we changed tests to behave like testcases/lib/run_tests.sh, i.e.
> allow to run all tests and check exit code (intermediate step before we compare
> the test output).

Rewriting the tests is a more complex task that should be done in a
separate patchset.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
