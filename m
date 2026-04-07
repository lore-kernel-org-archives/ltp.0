Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CA2EDB7FE
	for <ltp@archiver.kernel.org>; Tue,  7 Apr 2026 11:15:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C12F63E29A9
	for <ltp@archiver.kernel.org>; Tue,  7 Apr 2026 13:15:27 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D97433C9314
 for <ltp@lists.linux.it>; Tue,  7 Apr 2026 13:15:07 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 613091000609
 for <ltp@lists.linux.it>; Tue,  7 Apr 2026 13:15:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D7D6B5BD36;
 Tue,  7 Apr 2026 11:15:06 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB3A44A0B0;
 Tue,  7 Apr 2026 11:15:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zYOKJzrn1GmDSAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 07 Apr 2026 11:15:06 +0000
Date: Tue, 7 Apr 2026 13:15:01 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260407111501.GA25645@pevik>
References: <20260402121356.31266-1-chrubis@suse.cz>
 <20260402121356.31266-4-chrubis@suse.cz>
 <20260402214727.GE225068@pevik> <adTRqJao6jxdg-J1@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <adTRqJao6jxdg-J1@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: D7D6B5BD36
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 03/17] lib: tst_kernel: Add
 tst_check_module_driver()
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
> > > -	return -1;
> > > +int tst_check_module_driver(const char *driver)
> > > +{
> > > +	return tst_search_driver(driver, "modules.dep");

> > Thinking about it twice, could we check for the module by reading
> > /sys/module/? Our current approach shows what module *should* be available, but
> > that might not be true for some reason (i.e. loadable module not installed).

> The modules.dep file contains names of all modules installed in
> particular kernel modules directory. We cannot do anything better than
> parsing that file because it's (re)genrated on the system each time
> packages with modules have been installed/removed. If that wasn't the
> case modprobe that depends on that file wouldn't work either.

We effectively ask users to install modules.dep and modules.builtin. While this
is ok for distros and nobody has complained, I can imagine special embedded
systems can have problem. If everything was reliably detectable via /sys or
/proc I'd move to it. But even it's not working for all modules, checking first
/sys/module/ and fallback using modules.{builtin,dep} wouldn't take much effort.
But sure, we can postpone it until somebody has problems with the current
approach.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
