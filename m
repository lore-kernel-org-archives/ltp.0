Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3005CC3DA5D
	for <ltp@archiver.kernel.org>; Thu, 25 Jul 2024 11:02:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96D8E3D1C9F
	for <ltp@archiver.kernel.org>; Thu, 25 Jul 2024 13:02:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B4DC73C0123
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 13:02:25 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EF61811F646C
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 13:02:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1DB8521B38;
 Thu, 25 Jul 2024 11:02:24 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E150A13874;
 Thu, 25 Jul 2024 11:02:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 60R/Nb8womZ3VAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 25 Jul 2024 11:02:23 +0000
Date: Thu, 25 Jul 2024 13:02:06 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240725110206.GA982789@pevik>
References: <20240716153604.22984-1-chrubis@suse.cz>
 <20240716153604.22984-3-chrubis@suse.cz>
 <d5cb1dc4-7bd7-4084-952d-95511cbbb907@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d5cb1dc4-7bd7-4084-952d-95511cbbb907@suse.cz>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1DB8521B38
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 2/2] testcaes/lib: Add shell loader
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

Hi Martin, Cyril,

> Hi,
> one note below.
...
> > --- /dev/null
> > +++ b/testcases/lib/tests/shell_loader_all_filesystems.sh
> > @@ -0,0 +1,22 @@
> > +#!/bin/sh
> > +#
> > +# needs_root=1
> > +# mount_device=1
> > +# all_filesystems=1
> > +
> > +TST_MNTPOINT=ltp_mntpoint
> > +
> > +. tst_env.sh
> > +
> > +tst_res TINFO "IN shell"
> > +
> > +mounted=$(grep $TST_MNTPOINT /proc/mounts)

> This check might produce false positive for example when another LTP shell
> script runs in parallel in another temp directory. I'd recommend using
> $(realpath ...) to disambiguate the mountpoints.

FYI this is just a test, not a library script.

Also maybe just prepend it with $PWD/ would be enough:

mounted=$(grep $PWD/$TST_MNTPOINT /proc/mounts)

(Not to require yet another binary. It's ok to have it here, because developers
have coreutils, but in case it's in the tst_test.sh or its dependencies some
minimal systems might have problem - busybox based embedded systems realpath is
configurable via CONFIG_REALPATH=y. It would help if we specify shell library
dependencies).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
