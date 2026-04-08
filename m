Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A40FD5F86
	for <ltp@archiver.kernel.org>; Wed,  8 Apr 2026 06:53:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1085B3E2999
	for <ltp@archiver.kernel.org>; Wed,  8 Apr 2026 08:53:03 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE5DF3E2177
 for <ltp@lists.linux.it>; Wed,  8 Apr 2026 08:52:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F09D91000935
 for <ltp@lists.linux.it>; Wed,  8 Apr 2026 08:52:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 262CC5BD01;
 Wed,  8 Apr 2026 06:52:43 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E36994A0B3;
 Wed,  8 Apr 2026 06:52:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gnTrNTr71Wn5dAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 08 Apr 2026 06:52:42 +0000
Date: Wed, 8 Apr 2026 08:52:33 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260408065233.GA33386@pevik>
References: <20260304144424.10101-1-chrubis@suse.cz>
 <20260306125417.GA528953@pevik> <adTyD98tVRCJFUuY@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <adTyD98tVRCJFUuY@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 262CC5BD01
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls: ulimit01; Convert to the new library
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
> > > +/*\
> > > + * Tests the basic functionality of ulimit() with UL_GETFSIZE and UL_SETFSIZE.
> > nit: Could you please change before merge ulimit() to
> > :manpage:`ulimit(3)`
> > so that we get link to https://man7.org/linux/man-pages/man3/ulimit.3.html ?

> Fixed and pushed, thanks.

> > FYI kernel uses automarkup to recognise various things e.g. git hash [1].
> > Maybe we could employ it for git kernel commits.
> > But for man page it can have false positives [2].

> > [1] https://lore.kernel.org/linux-doc/87a4ydo1hf.fsf@trenco.lwn.net/
> > [2] https://lore.kernel.org/linux-doc/aWqg5XwPRXlzq4FI@devuan/

> I think that we should have the kernel commits mostly in the tags which
> gets translated based on the tag type, so this shouldn't be needed.

Agree, but people keep adding it into our /*\ docparse section as well.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
