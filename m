Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B971C3DA63
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 07:43:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6805F3D1C19
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 09:43:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 067223C60BA
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 09:42:52 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AA6B620A6A7
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 09:42:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D50AD1F74B;
 Wed, 24 Jul 2024 07:42:50 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 989E713411;
 Wed, 24 Jul 2024 07:42:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sAYNJHqwoGaGOgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 24 Jul 2024 07:42:50 +0000
Date: Wed, 24 Jul 2024 09:42:47 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20240724074247.GA924796@pevik>
References: <20240712134412.30853-1-chrubis@suse.cz>
 <20240717082547.GA584952@pevik> <20240717083116.GA587967@pevik>
 <20240722130651.GA857641@pevik> <Zp5aPZZikKndIqgi@yuki>
 <205c3123-be3b-41e5-adf3-3458bee9ec89@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <205c3123-be3b-41e5-adf3-3458bee9ec89@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: D50AD1F74B
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add tst_tmpdir_path() and tst_tmpdir_mkpath()
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

Hi Andrea,

> Hi!

> On 7/22/24 15:10, Cyril Hrubis wrote:
> > Hi!
> > > merged with tiny documentation format fixes we discussed.
> > Thanks a lot.

> I had a strange SEGFAULT when .needs_tmpdir is not defined. Are you sure the
> feature is correctly working in that case? TCONF should be expected in that
> case.

Could you be more specific what is wrong? (failing test, what backtrace from gdb
outputs. Maybe run it both *with* and *without* set follow-fork-mode child, not
sure if the info will be in the library run or in the test fork run).

I tested bind02.c, which is *without* .needs_tmpdir and it works. bind01.c is
*with* .needs_tmpdir and it also works.  These are not modified by the merged
change (c5d95b6d3), thus I also tested chroot01.c (*without* .needs_tmpdir) and
it also works.

Besides, openSUSE LTP testing of LTP syscalls with c5d95b6d3 [1] does not have
any new failures.

Kind regards,
Petr

[1] https://openqa.opensuse.org/tests/4355417#step/boot_ltp/159

> Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
