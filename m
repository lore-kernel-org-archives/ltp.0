Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34824C47BF4
	for <ltp@archiver.kernel.org>; Tue,  6 Jan 2026 13:57:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B2F523C29E9
	for <ltp@archiver.kernel.org>; Tue,  6 Jan 2026 14:57:07 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 18E1B3C0F42
 for <ltp@lists.linux.it>; Tue,  6 Jan 2026 14:56:49 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6E75D600132
 for <ltp@lists.linux.it>; Tue,  6 Jan 2026 14:56:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 529BC339F3;
 Tue,  6 Jan 2026 13:56:48 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DA5E3EA63;
 Tue,  6 Jan 2026 13:56:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UZoHDqAUXWkbVwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 06 Jan 2026 13:56:48 +0000
Date: Tue, 6 Jan 2026 14:56:42 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260106135642.GA714081@pevik>
References: <20251215124404.16395-1-chrubis@suse.cz>
 <20251216112709.GC307257@pevik> <aV0EcJ7TjsgULZKl@yuki.lan>
 <aV0MQv3D3hjGZK2I@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aV0MQv3D3hjGZK2I@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 529BC339F3
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] doc: Document process_state
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
> > > > - * R - process is running
> > > > - * S - process is sleeping
> > > > - * D - process sleeping uninterruptibly
> > > > - * Z - zombie process
> > > > - * T - process is traced
> > > > + * Possible process states:
> > > Maybe: use link to https://man7.org/linux/man-pages/man1/ps.1.html ?

> > > -* Possible process states:
> > > +* Possible process states (see :man1:`ps`):

> > 1. We do not have man1 defined in exlinks in conf.py

> > 2. Even if added there exlinks does not seem work from documentation
> >    generated from headers

> This actually works, once I fixed typo in the conf.py change.

+1

...

> > > * Z

> > Zombie process is described in the list.

> > > Also, do we want specify the process states in both TST_PROCESS_STATE_WAIT() and
> > > TST_THREAD_STATE_WAIT(), or just specify it in one and mention in the other that
> > > they specify it? (via :ref: or c:func:).

> > Again, none of the :ref: or c:func: is working in docs generate from
> > headers.

Maybe c:func: really works only in the headers. I have in my notes
:c:func:`tst_kvercmp()`. We already use in doc/* some :ref: e.g.
:ref:`struct tst_device` or :ref:`tst_brk`.

> And this one needs to be just TST_PROCESS_STATE_WAIT() to be processed
> as a link in headers.

Interesting. For me works only :c:func:`TST_PROCESS_STATE_WAIT()` or
:c:func:`tst_brk()` when adding it into random file (e.g.
doc/maintainers/patch_review.rst). 

Anyway, thanks for taking care to link it.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
