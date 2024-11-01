Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D45CE674B0
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 07:57:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8844B3C745B
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 08:57:13 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0276D3C745B
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 08:56:56 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4946464AC6F
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 08:56:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DB0B121C1F;
 Fri,  1 Nov 2024 07:56:53 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4A9A13722;
 Fri,  1 Nov 2024 07:56:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id u/rCKcWJJGfmIgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 01 Nov 2024 07:56:53 +0000
Date: Fri, 1 Nov 2024 08:56:44 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20241101075644.GB1145995@pevik>
References: <20241031-generate_syscalls-v8-0-8e35a9d6783b@suse.com>
 <20241031-generate_syscalls-v8-4-8e35a9d6783b@suse.com>
 <ZyOw8qyh3py6wO8t@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZyOw8qyh3py6wO8t@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: DB0B121C1F
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 4/4] Add documentation about syscalls.h
 generator
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

HI Andrea, Cyril,

> > +++ b/doc/developers/test_case_tutorial.rst
> > @@ -302,24 +302,25 @@ for a distribution's C library version to be older than its kernel or it may use
> >  cut down C library in comparison to the GNU one. So we must call ``statx()``
> >  using the general ``syscall()`` interface.

> > -The LTP contains a library for dealing with the ``syscall`` interface, which is
> > +LTP contains a library for dealing with the ``syscall`` interface, which is
> >  located in :master:`include/lapi`. System call numbers are listed against the relevant
> >  call in the ``*.in`` files (e.g. ``x86_64.in``) which are used to generate
> > -``syscalls.h``, which is the header you should include. On rare occasions you
> > -may find the system call number is missing from the ``*.in`` files and will need
> > -to add it (see :master:`include/lapi/syscalls/strip_syscall.awk`).
> > +``syscalls.h``, the header you should include.

> > -System call numbers vary between architectures, hence there are multiple
> > -``*.in`` files for each architecture.

> I would keep this sentence in there, probably as a last sentence in the
> upper paragraph.

+1

> > - You can find the various values for the
> > -``statx`` system call across a number of ``unistd.h`` files in the Linux kernel.
> > +On rare occasions, you may find that system call number is missing from ``*.in``
> > +files. In these cases, they will need to be updated using
> > +`include/lapi/syscalls/generate_arch.sh` script as following:
>         ^
> 	Just `generate_arch.sh` here, we list the full path in the code
> 	block, no need to repeat it here as well.
+1. BTW it should be either ``generate_arch.sh`` (double `` is used for
other commands, e.g. ``make check`` or ``./configure``) or it could be a link to
a source:

:master:`include/lapi/syscalls/generate_arch.sh` script as following:

I like links, because reader can see the script content. Also it can help to
verify whether the script is still at the repository (was not moved/deleted).

> > -Note that we don't use the system-call-identifier value available in
> > -``/usr/include/linux/uinstd.h`` because the kernel might be much newer than the
> > -user land development packages.
> > +.. code-block:: bash
> > +
> > +    $ include/lapi/syscalls/generate_arch.sh /path/of/linux/sources
>                                                       ^
> 						      to

very nit: "path/to/Linux/kernel/sources" (upper "L", which you use later, also
it's used in the script).

> > +The script will generate all the needed ``*.in`` files according to the Linux
>                                                             ^
> 							  accordingly
+1
> > +source code which has been used. Make sure that your Linux source code has
> > +been updated to the latest version.

> > -For ``statx`` we had to add ``statx 332`` to :master:`include/lapi/syscalls/x86_64.in`,
> > -``statx 383`` to :master:`include/lapi/syscalls/powerpc.in`, etc.  Now lets look at
> > -the code, which I will explain in more detail further down.
> > +Once the new syscalls files have been updated, to rebuild our ``syscalls.h``
> > +file, please use ``./configure`` command.
>             ^                         ^
> 	 re-run			      script
+1

Otherwise LGTM, thanks a lot for bothering with the docs.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
