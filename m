Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4006EF013DC
	for <ltp@archiver.kernel.org>; Mon, 16 Mar 2026 08:49:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B796D3E2B7A
	for <ltp@archiver.kernel.org>; Mon, 16 Mar 2026 09:49:44 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 471883E235B
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 09:49:26 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 78DF21400B6A
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 09:49:25 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5461B5BCC3;
 Mon, 16 Mar 2026 08:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773650962;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fEpFmKBPq1FQ9xhLICymRIZ3i0DwWqptrdHc4AfRVAU=;
 b=a5fwC6BEnP8CRZSyFSIwaKf34QT8VqnMPzNYNJ5rCoigp2MFdoo4vZzhjH9H1zSAxFSpxM
 AK0NKOFOSK4/WYqUupTNBD9+5JKnALdwURgMZC6mFIJ0YBv7/O9iCp+u/N9dETa+50wNbF
 SF1kLY0T1My23lJ7U/d7dHHIx6Fg+WE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773650962;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fEpFmKBPq1FQ9xhLICymRIZ3i0DwWqptrdHc4AfRVAU=;
 b=+GsG200SbDpqFTLBI0hamMzXSCT2eVQlwDSkAAFBYugsFNMQ5Lg7rB7npJgDX6Tcr/QqDh
 QlEOT8VhDiGvMHDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773650962;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fEpFmKBPq1FQ9xhLICymRIZ3i0DwWqptrdHc4AfRVAU=;
 b=a5fwC6BEnP8CRZSyFSIwaKf34QT8VqnMPzNYNJ5rCoigp2MFdoo4vZzhjH9H1zSAxFSpxM
 AK0NKOFOSK4/WYqUupTNBD9+5JKnALdwURgMZC6mFIJ0YBv7/O9iCp+u/N9dETa+50wNbF
 SF1kLY0T1My23lJ7U/d7dHHIx6Fg+WE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773650962;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fEpFmKBPq1FQ9xhLICymRIZ3i0DwWqptrdHc4AfRVAU=;
 b=+GsG200SbDpqFTLBI0hamMzXSCT2eVQlwDSkAAFBYugsFNMQ5Lg7rB7npJgDX6Tcr/QqDh
 QlEOT8VhDiGvMHDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 348494273B;
 Mon, 16 Mar 2026 08:49:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GmI+CxLEt2kxcgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 16 Mar 2026 08:49:22 +0000
Date: Mon, 16 Mar 2026 09:49:20 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20260316084920.GA291437@pevik>
References: <20250526143551.1321709-1-wegao@suse.com>
 <20250603214503.3792293-1-wegao@suse.com>
 <DEW4S4LXK0U5.RSZM163LCKXN@suse.com>
 <aZ7Am0YgYLK33spn@autotest-wegao.qe.prg2.suse.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aZ7Am0YgYLK33spn@autotest-wegao.qe.prg2.suse.org>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_HAS_DN(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] fsconfig04.c: Check FSCONFIG_SET_PATH
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

Hi Andrea, Wei,

> On Fri, Dec 12, 2025 at 10:29:35AM +0100, Andrea Cervesato wrote:
> > Hi!

> > please, re-read the previous reviews before submitting a new version,
> > because there are still some issues not achieved.

If you *were* a concrete what is wrong, you'd have saved Wei's and my time :).

> Thanks for take a look.
> I think Cyril comments should be fixed in current version after recheck, so i move patch into
> Needs Review in patchwork again.

I'd also say all issues has been fixed. What exactly do you mean?

Also, test needs rebase after Wei's and Li's changes to fix compilation.

Kind regards,
Petr

+++ testcases/kernel/syscalls/fsconfig/fsconfig04.c
@@ -24,7 +24,7 @@
 
 #include "tst_test.h"
 #include "lapi/fsmount.h"
-#include "old/old_device.h"
+#include "old/tso_device.h"
 
 #define MNTPOINT	"mntpoint"
 #define LOOP_DEV_SIZE 10
@@ -150,9 +150,9 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.format_device = 1,
 	.mntpoint = MNTPOINT,
-	.needs_cmds = (const char *[]) {
-		"tune2fs",
-		NULL
+	.needs_cmds = (struct tst_cmd[]) {
+		{.cmd = "tune2fs"},
+		{}
 	},
 	.filesystems = (struct tst_fs []) {
 		{.type = "ext3"},

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
