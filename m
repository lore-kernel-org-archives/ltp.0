Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7015BC5CFEB
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 14:16:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A35F3C287C
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 16:16:09 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA7F63C2804
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 16:15:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 815F7600715
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 16:15:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DABA63EA7;
 Thu, 13 Aug 2026 14:15:51 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CBB3377E68;
 Thu, 13 Aug 2026 14:15:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IKjRMJfRfWpYNwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 13 Aug 2026 14:15:51 +0000
Date: Thu, 13 Aug 2026 16:15:46 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <an3RkmTWSfZQjb6K@yuki.lan>
References: <6a7da094.a02854e2.9191a.a277@mx.google.com>
 <6349138c-6d02-4df9-90c9-c766fa480c3d@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6349138c-6d02-4df9-90c9-c766fa480c3d@suse.cz>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: DABA63EA7
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] refluxfs: Check kernel reflink support before
 mount
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
> > @@ -993,9 +993,15 @@ int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
> >   			"mount.%s failed with %i", filesystemtype, rval);
> >   		return -1;
> >   	} else if (rval == -1) {
> > -		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
> > -			"mount(%s, %s, %s, %lu, %p) failed", source, target,
> > -			filesystemtype, mountflags, data);
> > +		if (errno == EOPNOTSUPP) {
> > +			tst_brkm_(file, lineno, TCONF | TERRNO, cleanup_fn,
> > +				"mount(%s, %s, %s, %lu, %p) failed with EOPNOTSUPP", source, target,
> > +				filesystemtype, mountflags, data);
> > +		} else {
> > +			tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
> > +				"mount(%s, %s, %s, %lu, %p) failed", source, target,
> > +				filesystemtype, mountflags, data);
> > +		}
> >   	} else {
> >   		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
> >   			"Invalid mount(%s, %s, %s, %lu, %p) return value %d",
> 
> Hi,
> yes, but I think it'd be better to add a setting to struct tst_test to 
> enable this TCONF check only for specific tests. By default, EOPNOTSUPP 
> should still trigger TBROK.
> 
> Something like:
> .mount_check_support = 1

Shoudn't that be per filesystem and live in tst_fs structure?

Either way we will need a flag to the safe_mount() added first...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
