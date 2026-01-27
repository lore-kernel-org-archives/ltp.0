Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C85D2F02A
	for <ltp@archiver.kernel.org>; Tue, 27 Jan 2026 13:25:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CED723CB2D7
	for <ltp@archiver.kernel.org>; Tue, 27 Jan 2026 14:25:35 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 987433CAE83
 for <ltp@lists.linux.it>; Tue, 27 Jan 2026 14:25:18 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DB8DC600907
 for <ltp@lists.linux.it>; Tue, 27 Jan 2026 14:25:17 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C7CB15BCE6;
 Tue, 27 Jan 2026 13:25:16 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 45FA93EA61;
 Tue, 27 Jan 2026 13:25:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fWYnCry8eGlbCAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 27 Jan 2026 13:25:16 +0000
Date: Tue, 27 Jan 2026 14:25:14 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260127132514.GB146899@pevik>
References: <aWjZX0fsrTJMqq49@yuki.lan>
 <aXi4P0YdKx5rFZ8C@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aXi4P0YdKx5rFZ8C@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: C7CB15BCE6
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preprations
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

> Hi!
> Are there any other fixes that should be considered before the git is
> tagged?

* ioctl_pidfd02-06: Add CONFIG_USER_NS and CONFIG_PID_NS to needs_kconfigs
https://patchwork.ozlabs.org/project/ltp/patch/20251209211629.95436-1-terry.tritton@linaro.org/
(Or I can prepare an alternative fix to do a runtime check, I also plan to send
a patch with formalising the rules)

* tst_net.sh fixes would be nice to get merged:
https://patchwork.ozlabs.org/project/ltp/list/?series=489902&state=*
https://lore.kernel.org/ltp/20260127131427.146592-1-pvorel@suse.cz/
https://lore.kernel.org/ltp/20260127131427.146592-2-pvorel@suse.cz/

https://patchwork.ozlabs.org/project/ltp/list/?series=489469&state=*

It should be safe to merge these:

* v5 tst_filesystems01.c: Add test for .filesystems
https://patchwork.ozlabs.org/project/ltp/list/?series=489469&state=*

* checkpatch.pl enhancement to check for typos
https://patchwork.ozlabs.org/project/ltp/list/?series=487179&state=*
(I did not merged it as I hoped for a discussion what else to enable for
warnings, but that could be done as a separate effort after the release).

FYI I dared to merge IMA fix:
https://github.com/linux-test-project/ltp/commit/1ba58805ea5466df5202ff2e7b5b3d0cd5c81c37

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
