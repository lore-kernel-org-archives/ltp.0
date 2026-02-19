Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E62C531CC
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 20:21:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE9F63D077D
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 21:21:35 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D81BC3CAC50
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 21:21:18 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id ED219600A64
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 21:21:13 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0A24B3E72D;
 Thu, 19 Feb 2026 20:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771532473;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+xtJ2CCGt6dJ+55GzyfclNSIYRUbh54EliWbE2YgAgo=;
 b=eC4QQA7hNZZw+lRd9YK73UxHuMXQ68OclKGguqflrFtbXhkyNVkHGA4fr2WYexgBV8U0Oo
 qT5ICyYjOYgWVB6qYGLUvgzFcEdWeHf+p7x09+QwahZuCQt6qPCXDY1egpDg4mXvjDCJnc
 G9UrTWC52FBZqlOgao+k1SBVw/U2OeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771532473;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+xtJ2CCGt6dJ+55GzyfclNSIYRUbh54EliWbE2YgAgo=;
 b=ymLf1Bfg+KKtjX1sBFlgu0fyIo4lGrY+cIbM6DlzSZLgYF+E1VIzhtK4yPzNOdhQ0gO8mJ
 QDnODRmiD6/4WODg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Gvr5/N4R";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=SrFFLg1g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771532472;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+xtJ2CCGt6dJ+55GzyfclNSIYRUbh54EliWbE2YgAgo=;
 b=Gvr5/N4R3a4k0uP3iEJC/CeSVUGpLOze6TXU+5Ml8MTBePN5Bxqs+9X6GIZMg3Ndmgk2n9
 WU1wj05F0fGkKyB7OhAwh5lupwYd44jQGrXr9ViI/uIf/VtLeQrKmhgBi8HtMzETfxASsW
 BYoP1feVlnruZh7qDFO0+j8zzJy/oos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771532472;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+xtJ2CCGt6dJ+55GzyfclNSIYRUbh54EliWbE2YgAgo=;
 b=SrFFLg1gt0Y86lJgaXD0El1XxWoI0jlJYM8v/Ce7gP1esM6aOEElRMWYS5vZqglr4WczjQ
 ptf07JsubvdW1uDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3EAC03EA65;
 Thu, 19 Feb 2026 20:21:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oHFvOrRwl2kzXAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 19 Feb 2026 20:21:08 +0000
Date: Thu, 19 Feb 2026 21:20:51 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260219202051.GB341772@pevik>
References: <20260205121540.329921-1-pvorel@suse.cz>
 <20260205121540.329921-2-pvorel@suse.cz>
 <aZQytH7k6pVXqdsz@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aZQytH7k6pVXqdsz@yuki.lan>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_CC(0.00)[lists.linux.it,suse.com,redhat.com,lists.yoctoproject.org,gmail.com];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0A24B3E72D
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/6] doc: INSTALL: dma_thread_diotest.c: Remove
 runltp from doc
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
Cc: ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > Remove runltp from all doc, replace it with kirk.
> > Also replace the old runltp-ng with kirk.

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  INSTALL                                            |  4 +++-
> >  doc/developers/test_case_tutorial.rst              |  6 +++---
> >  doc/developers/todo.rst                            | 10 ----------
> >  metadata/README.md                                 |  2 +-
> >  testcases/kernel/fs/fs_readonly/test_robind.sh     |  2 +-
> >  testcases/kernel/io/direct_io/dma_thread_diotest.c |  3 +--
> >  testcases/kernel/security/smack/README             |  2 +-
> >  testcases/network/can/filter-tests/INSTALL         |  2 +-
> >  testcases/network/rpc/rpc-tirpc/README             |  2 +-
> >  testscripts/Readme_ROBind                          |  4 ++--
> >  10 files changed, 14 insertions(+), 23 deletions(-)

> > diff --git a/INSTALL b/INSTALL
> > index c44bb4e660..9ef929a971 100644
> > --- a/INSTALL
> > +++ b/INSTALL
> > @@ -105,9 +105,9 @@ Quick Start
> >  	$ ./configure
> >  	$ make all
> >  	# make install
>         ^
> 	This should be $ (not caused by this patch but worth fixing)

I can change it, but IMHO for creating /opt/ltp is needed to run it as root
for a first time. Or one must chmod/chown /opt/ltp under root.

> > -	$ /opt/ltp/runltp

> >  *NOTE:
> > +- For running tests use kirk [1], individual test you can run directly.
>                                                     ^
> 					 This sentece has wrong order of words.

> And also oversimplifies things, there is no mention of setting correct
> PATH that needs to be done in order to run these tests.

> I would just drop that and leave only the first sentence.

Sure, I can remove it:

+++ INSTALL
@@ -107,7 +107,7 @@ Quick Start
 	# make install
 
 *NOTE:
-- For running tests use kirk [1], individual test you can run directly.
+- For running tests use kirk [1].
 - LTP assumes the existence of the nobody, bin, and daemon users and their
 groups.  If these IDs do not exist, certain tests will fail. The respective
 user and group IDs should be the same, i.e. if `nobody's' user ID is 99, then
---
If I'm correct this is likely the only change. Can you add your RBT and I modify
before merge?

And I see Andrea already removed '-U ltp' kirk usage.

Anyway, I can wait little longer, but I got already quite a lot of ack to merge
whole patchset.

Kind regards,
Petr


> >  - LTP assumes the existence of the nobody, bin, and daemon users and their
> >  groups.  If these IDs do not exist, certain tests will fail. The respective
> >  user and group IDs should be the same, i.e. if `nobody's' user ID is 99, then
> > @@ -117,6 +117,8 @@ its group ID should also be 99. The names of the groups are irrelevant.
> >  DESTDIR= is also honored for install and will install into $DESTDIR/$prefix,
> >  if you want to install into a chroot or a rootfs for instance.

> > +[1] https://github.com/linux-test-project/kirk
> > +
> >  Detailed Installation
> >  ---------------------

> > diff --git a/doc/developers/test_case_tutorial.rst b/doc/developers/test_case_tutorial.rst
> > index 08bd1b1519..240897e36b 100644
> > --- a/doc/developers/test_case_tutorial.rst
> > +++ b/doc/developers/test_case_tutorial.rst
> > @@ -205,9 +205,9 @@ please do:

> >  This should build the test and then run it. However, even though the test is
> >  in :master:`testcases/kernel/syscalls` directory it won't be automatically ran
> > -as part of the syscalls test group (e.g. not run via ``kirk -r math`` or
> > -``./runltp -f syscalls``). For this we need to add it to the runtest file. So
> > -open :master:`runtest/syscalls` and add the lines starting with a ``+``.
> > +as part of the syscalls test group (e.g. not run via ``kirk -r math``.  For
>                                                                         ^
> 									missing
> 									closing
> 									)

> Also the path to syscalls is missing after the change.

> > +this we need to add it to the runtest file. So open :master:`runtest/syscalls`
> > +and add the lines starting with a ``+``.

> >  .. code-block::

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
