Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E47C4829E
	for <ltp@archiver.kernel.org>; Thu, 15 Feb 2024 08:40:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D7713CF086
	for <ltp@archiver.kernel.org>; Thu, 15 Feb 2024 09:40:52 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A5813CDC8C
 for <ltp@lists.linux.it>; Thu, 15 Feb 2024 09:40:37 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9FD13600085
 for <ltp@lists.linux.it>; Thu, 15 Feb 2024 09:40:36 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2A7331F86A;
 Thu, 15 Feb 2024 08:40:33 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E243A1346A;
 Thu, 15 Feb 2024 08:40:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id mcCVNQDOzWUbXQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 15 Feb 2024 08:40:32 +0000
Date: Thu, 15 Feb 2024 09:40:27 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240215084027.GA797046@pevik>
References: <20240214170949.793338-1-pvorel@suse.cz>
 <20240214170949.793338-4-pvorel@suse.cz>
 <9fd838e3-7eba-428c-a296-caf4860ba1fb@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9fd838e3-7eba-428c-a296-caf4860ba1fb@suse.cz>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2A7331F86A
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] tree: Relicense GPL-2.0 (v2 only) =>
 GPL-2.0-or-later
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
Cc: Jan Kara <jack@suse.cz>, Matthew Bobrowski <mbobrowski@mbobrowski.org>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On 14. 02. 24 18:09, Petr Vorel wrote:
> > Cc: Cyril Hrubis <chrubis@suse.cz>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > Cc: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> > Cc: Jan Stancek <jstancek@redhat.com>
> > Cc: Martin Doucha <mdoucha@suse.cz>
> > Cc: Richard Palethorpe <io@richiejp.com>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Hi all,

> > I'm sorry to steal your time with license cleanup.

> > LTP started as GPL v2 only around 2001. Later new tests were changed to
> > GPL v2+. When we later started using SPDX, we use GPL-2.0 which actually
> > means GPL-2.0-only. Please if you agree with changing GPL-2.0-or-later
> > for tests you wrote ack this (or send a patch where you change it if you
> > prefer). If you don't agree or you don't reply your files will stay
> > GPL v2 only (just SPDX will be changed to GPL-2.0-only to be obvious.)

> > Kind regards,
> > Petr

> > Martin Doucha
> > testcases/kernel/syscalls/ptrace/ptrace08.c

> I would ack licence change for ptrace08 but it's based on a reproducer by
> Andrew Lutomirsky which is licensed under GPL-2.0:
> https://github.com/linux-test-project/ltp/issues/593

> Therefore my ack is not sufficient.

Very good catch, thank you. This one will stay GPL-2.0-only.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
