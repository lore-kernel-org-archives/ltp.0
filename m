Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6B9C4829E
	for <ltp@archiver.kernel.org>; Thu, 15 Feb 2024 09:24:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A29C3CF062
	for <ltp@archiver.kernel.org>; Thu, 15 Feb 2024 10:24:07 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 609163CDC93
 for <ltp@lists.linux.it>; Thu, 15 Feb 2024 10:23:53 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=jack@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 58C631014723
 for <ltp@lists.linux.it>; Thu, 15 Feb 2024 10:23:51 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DC44821EA7;
 Thu, 15 Feb 2024 09:23:50 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C8D9A1346A;
 Thu, 15 Feb 2024 09:23:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id W+cDMSbYzWVUZgAAn2gu4w
 (envelope-from <jack@suse.cz>); Thu, 15 Feb 2024 09:23:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 5F826A0809; Thu, 15 Feb 2024 10:23:50 +0100 (CET)
Date: Thu, 15 Feb 2024 10:23:50 +0100
From: Jan Kara <jack@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20240215092350.c6ujpr52f7yb7nw2@quack3>
References: <20240214170949.793338-1-pvorel@suse.cz>
 <20240214170949.793338-4-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240214170949.793338-4-pvorel@suse.cz>
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: DC44821EA7
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
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
Cc: Jan Kara <jack@suse.cz>, Matthew Bobrowski <mbobrowski@mbobrowski.org>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed 14-02-24 18:09:49, Petr Vorel wrote:
> Cc: Cyril Hrubis <chrubis@suse.cz>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> Cc: Jan Stancek <jstancek@redhat.com>
> Cc: Martin Doucha <mdoucha@suse.cz>
> Cc: Richard Palethorpe <io@richiejp.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi all,
> 
> I'm sorry to steal your time with license cleanup.
> 
> LTP started as GPL v2 only around 2001. Later new tests were changed to
> GPL v2+. When we later started using SPDX, we use GPL-2.0 which actually
> means GPL-2.0-only. Please if you agree with changing GPL-2.0-or-later
> for tests you wrote ack this (or send a patch where you change it if you
> prefer). If you don't agree or you don't reply your files will stay
> GPL v2 only (just SPDX will be changed to GPL-2.0-only to be obvious.)
...
> Jan Kara
> testcases/kernel/syscalls/fanotify/fanotify01.c
> testcases/kernel/syscalls/fanotify/fanotify02.c
> testcases/kernel/syscalls/fanotify/fanotify03.c
> testcases/kernel/syscalls/fanotify/fanotify04.c
> testcases/kernel/syscalls/fanotify/fanotify05.c
> testcases/kernel/syscalls/fanotify/fanotify06.c
> testcases/kernel/syscalls/fanotify/fanotify10.c

Acked-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
