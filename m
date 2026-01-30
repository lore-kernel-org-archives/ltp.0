Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF86AD49C9E
	for <ltp@archiver.kernel.org>; Fri, 30 Jan 2026 10:46:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 45D493CC19A
	for <ltp@archiver.kernel.org>; Fri, 30 Jan 2026 11:46:49 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 259A43CBF01
 for <ltp@lists.linux.it>; Fri, 30 Jan 2026 11:46:30 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C8AD420077C
 for <ltp@lists.linux.it>; Fri, 30 Jan 2026 11:46:29 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A0B363467D;
 Fri, 30 Jan 2026 10:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769769988;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2BBkwhKGsjWlO0tWZFYSCnnH/Ule1u+HHUNVuD15JFY=;
 b=1p2XSKKkVoMOLuMk/DKcbazjhy95QKtnzLICJs3u3bkjrLT/8gVSmhSB/uSInfLuBmaGdJ
 uG3UEJ+fUylbYTkb3S2YIqdD8+qg8oy3fO90oK90gR0aAALKYPe40Luh4Bv7TIpclMNX8m
 IzatQzQpYdAXLVOdPfnAqeuJvzmb5jQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769769988;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2BBkwhKGsjWlO0tWZFYSCnnH/Ule1u+HHUNVuD15JFY=;
 b=TOOsBN5wHkgf0gXjonbwczJ8SZYYBBOPo9wQlq6VCzLByuYrdX/+cZNEuISltGe5TsvWoL
 xAm5YEc9hAwSaHDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769769988;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2BBkwhKGsjWlO0tWZFYSCnnH/Ule1u+HHUNVuD15JFY=;
 b=1p2XSKKkVoMOLuMk/DKcbazjhy95QKtnzLICJs3u3bkjrLT/8gVSmhSB/uSInfLuBmaGdJ
 uG3UEJ+fUylbYTkb3S2YIqdD8+qg8oy3fO90oK90gR0aAALKYPe40Luh4Bv7TIpclMNX8m
 IzatQzQpYdAXLVOdPfnAqeuJvzmb5jQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769769988;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2BBkwhKGsjWlO0tWZFYSCnnH/Ule1u+HHUNVuD15JFY=;
 b=TOOsBN5wHkgf0gXjonbwczJ8SZYYBBOPo9wQlq6VCzLByuYrdX/+cZNEuISltGe5TsvWoL
 xAm5YEc9hAwSaHDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5513A3EA61;
 Fri, 30 Jan 2026 10:46:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hRBZEgSMfGlFagAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 30 Jan 2026 10:46:28 +0000
Date: Fri, 30 Jan 2026 11:46:22 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260130104622.GA138796@pevik>
References: <20260130002041.124571-1-pvorel@suse.cz>
 <aXyIVhHNdOn4C2lk@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aXyIVhHNdOn4C2lk@yuki.lan>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] pidns: ioctl: unshare05: Require kconfig
 CONFIG_PID_NS
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
Cc: ltp@lists.linux.it, Terry Tritton <terry.tritton@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > ---
> > Probably after the release.

> This looks obviously correct hence I would dare to merge before the
> release.

Thanks, merged!

In the end added these three tests, clone304.c required also CONFIG_USER_NS
(uses CLONE_NEWUSER).

I guess that was the last one before the release.

Kind regards,
Petr

+++ testcases/kernel/syscalls/clone/clone11.c
@@ -69,6 +69,10 @@ static struct tst_test test = {
 		TST_CAP(TST_CAP_DROP, CAP_SYS_ADMIN),
 		{},
 	},
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_PID_NS",
+		NULL,
+	},
 	.bufs = (struct tst_buffers[]) {
 		{&child_stack, .size = CHILD_STACK_SIZE},
 		{},
diff --git testcases/kernel/syscalls/clone3/clone301.c testcases/kernel/syscalls/clone3/clone301.c
index deed30b9f0..902e890919 100644
--- testcases/kernel/syscalls/clone3/clone301.c
+++ testcases/kernel/syscalls/clone3/clone301.c
@@ -176,6 +176,10 @@ static struct tst_test test = {
 	.setup = setup,
 	.needs_root = 1,
 	.needs_checkpoints = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_PID_NS",
+		NULL,
+	},
 	.bufs = (struct tst_buffers []) {
 		{&args, .size = sizeof(*args)},
 		{},
diff --git testcases/kernel/syscalls/clone3/clone304.c testcases/kernel/syscalls/clone3/clone304.c
index 9faaf44bb2..f0ef7d7e81 100644
--- testcases/kernel/syscalls/clone3/clone304.c
+++ testcases/kernel/syscalls/clone3/clone304.c
@@ -80,6 +80,11 @@ static struct tst_test test = {
 		TST_CAP(TST_CAP_DROP, CAP_SYS_ADMIN),
 		{},
 	},
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_USER_NS",
+		"CONFIG_PID_NS",
+		NULL,
+	},
 	.bufs = (struct tst_buffers[]) {
 		{&args, .size = sizeof(struct clone_args)},
 		{},

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
