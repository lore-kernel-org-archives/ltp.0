Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3687C4452D
	for <ltp@archiver.kernel.org>; Wed, 22 Jul 2026 08:05:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 05B783E1EAE
	for <ltp@archiver.kernel.org>; Wed, 22 Jul 2026 10:05:20 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CAD463C0571
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 10:05:03 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8A7E060223F
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 10:05:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B1EB57A9A7;
 Wed, 22 Jul 2026 08:05:01 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93359779B0;
 Wed, 22 Jul 2026 08:05:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6NCwIq15YGp3PAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 22 Jul 2026 08:05:01 +0000
Date: Wed, 22 Jul 2026 10:04:56 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260722080456.GA826637@pevik>
References: <20260722063259.GA821485@pevik>
 <6a60708d.ba2bb225.b4339.1916@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a60708d.ba2bb225.b4339.1916@mx.google.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: B1EB57A9A7
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] checkpatch: relax parenthesis style checks
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

> Hi Petr,

> > Hi Andrea, Cyril,

> > I found both rules useful (more readable and more consistent code). Can we put
> > it back? Over the years you will recognise on the code of single test that it
> > was written/modified by several people with a different styles. And that makes
> > it less readable.

> > * PARENTHESIS_ALIGNMENT check enforces space behind 'while' or 'if'.
> > i.e. instead of:
> > 	while(tst_fzsync_run_b(&fzsync_pair)) {
> > have:
> > 	while (tst_fzsync_run_b(&fzsync_pair)) {

> > cve-2014-0196.c mixes 'while()' and 'while ()'. Is it that hard to be
> > consistent on it?

> im not sure that rule is checking for spaces after the statements. that

I'm sorry, indeed, that is checked by SPACING which is still on.

> rule is avoiding stuff like:

> 	ruleset_fd = SAFE_LANDLOCK_CREATE_RULESET(ruleset_attr,
> 																						sizeof(struct tst_landlock_ruleset_attr_abi1), 0);

> because parenthesis should allign the attributes of the functions. that
> is super ugly when functions have really long names. Instead, this would
> make much more sense:


> 	ruleset_fd = SAFE_LANDLOCK_CREATE_RULESET(ruleset_attr,
> 							     sizeof(struct tst_landlock_ruleset_attr_abi1), 0);

Yes, it forces alignment after '('. Example of fix in the kernel:
https://lore.kernel.org/all/1421748570-14282-2-git-send-email-Emilian.Medve@Freescale.com/

 		pr_err("Could not register clock provider for node:%s\n",
-			 np->name);
+		       np->name);

I'd say it depends how your displays tabs (if tabs are in the sources, we have
.editorconfig, but not all not all developers have their editor set to use it).
In certain setup it does not look OK + the problem of inconsistency, but I'm ok
to ignore it.

> > * OPEN_ENDED_LINE asks for not ending line with '(' or '['.
> > i.e. instead of this:
> > 	ruleset_fd = TST_EXP_FD_SILENT(
> > 								   tst_syscall(__NR_landlock_create_ruleset, ruleset_attr,
> > 						   sizeof(struct tst_landlock_ruleset_attr_abi1), 0));
> > have this:
> > 	ruleset_fd = TST_EXP_FD_SILENT(tst_syscall(__NR_landlock_create_ruleset, ruleset_attr,
> > 						   sizeof(struct tst_landlock_ruleset_attr_abi1), 0));

> you choose the right example, landlock testing suite has been updated to
> match this rule and now it has stuff like:

> 	apply_landlock_fs_layer(ruleset_attr, sizeof(struct tst_landlock_ruleset_attr_abi1),
> 				path_beneath_attr, MNTPOINT, LANDLOCK_ACCESS_FS_IOCTL_DEV);

In my personal preference is this above better ...

> instead of

> 	apply_landlock_fs_layer(
> 				ruleset_attr,
> 				sizeof(struct tst_landlock_ruleset_attr_abi1),
> 				path_beneath_attr,
> 				MNTPOINT,
> 				LANDLOCK_ACCESS_FS_IOCTL_DEV
> 	);

... than this. Why? Instead of 2 lines you have 7 lines. That would be ok, if we all
use portrait screens, but most of us code on landscape. (Too much scrolling.)

IMHO you introduced that style, which is still not widely used in the code.
Sooner or later we will have mix of 2 styles even in the single source file
which will be less readable.

> that is more clear what are the functions attributes.

Maybe this is is slightly more readable, but for me it does not pay off the
numer of extra lines. And functions with more than 3 parameters are hard to read
anyway (specially if passed parameters are just numbers).

> For the second one, maybe it's more like a personal preference, but the
> first rule is actually generating a lot of weird code when functions and
> attributes have long names, forcing to write long lines without staying
> into the 80-100 chars.

I'm ok with ignoring OPEN_ENDED_LINE, but I vote for putting back
PARENTHESIS_ALIGNMENT.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
