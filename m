Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D23C47DDF
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 13:14:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D0463CF97C
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 14:14:52 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 697293CE101
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 14:14:36 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EE8231A008B1
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 14:14:35 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E5A96222CB;
 Tue, 30 Jan 2024 13:14:34 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BF23613212;
 Tue, 30 Jan 2024 13:14:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id WKxGLDr2uGXmJwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 30 Jan 2024 13:14:34 +0000
Date: Tue, 30 Jan 2024 14:14:29 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <20240130131429.GA786076@pevik>
References: <20240129174647.635944-1-pvorel@suse.cz>
 <12395443.O9o76ZdvQC@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <12395443.O9o76ZdvQC@localhost>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E5A96222CB
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] README: Mention -f param for strace
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

Hi Avinesh,

> Hi Petr,
> > -Debugging with gdb
> > -==================
> > +Debugging with gdb and strace
> > +=============================

> >  The new test library runs the actual test, i.e. the `test()` function in a
> >  forked process. To get stack trace of a crashing test in gdb it's needed to
> > [`set follow-fork-mode
> > child`](https://ftp.gnu.org/old-gnu/Manuals/gdb/html_node/gdb_25.html). +To
> > trace test with strace use `-f`.
> For a second I thought ltp tests has `-f` option.
> So maybe if we can make it absolutely clear, or maybe it is just me. :D

thanks for having a look!

There is currently no -f parameter, but sure, it could be in the future.
./fanotify01 -h # shows no -f parameter

./fanotify01 -f
...
tst_test.c:688: TBROK: Invalid option

But I meant '-f' as strace parameter, e.g.:

strace -f ./fanotify01

should I wrote this?

	To trace test with strace use call strace with `-f` parameter.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
