Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805AFC3271E
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 05:27:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB9583CC2E8
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 07:27:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 356A83C0625
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 07:27:09 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 81404208DEF
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 07:27:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7947621B21;
 Thu, 11 Jul 2024 05:27:06 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E0780136D6;
 Thu, 11 Jul 2024 05:27:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LCOWLyltj2YcIQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 11 Jul 2024 05:27:05 +0000
Date: Thu, 11 Jul 2024 07:27:04 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20240711052704.GB3591@pevik>
References: <20240701-landlock-v1-0-58e9af649a72@suse.com>
 <20240701-landlock-v1-3-58e9af649a72@suse.com>
 <20240710155308.GB300896@pevik>
 <9a33a68e-3cd2-4a51-b525-97516fe97b7f@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9a33a68e-3cd2-4a51-b525-97516fe97b7f@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 7947621B21
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 03/10] Add landlock SAFE_* macros
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

> Hi Petr,

> this is already done in the v2 which has not been sent yet.

Thanks for info, this was not obvious until I check github actions in your fork
(or I miss some message). I keep patches with NEW state so that other can have
look until you send v2.

Kind regards,
Petr

> On 7/10/24 17:53, Petr Vorel wrote:
> > Hi Andrea, Li,

> > ...
> > > +++ b/include/tst_safe_macros.h
> > > @@ -14,6 +14,7 @@
> > >   #include <sys/stat.h>
> > >   #include <sys/vfs.h>
> > >   #include <sys/sysinfo.h>
> > > +#include <linux/landlock.h>
> > This will break build for more than half of the distros:

> > https://github.com/pevik/ltp/actions/runs/9876952862

> > It's mostly due missing <linux/landlock.h> on old distros, but there were also
> > redefinition of 'landlock_net_port_attr' at least on Fedora.

> > You even have some fixed version in your CI where only Leap 42 fails due
> > different problem), please send it (or post a diff here).
> > https://github.com/acerv/ltp/actions/runs/9778823237

> > Kind regards,
> > Petr

> Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
