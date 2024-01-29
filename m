Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886B5C47DDB
	for <ltp@archiver.kernel.org>; Mon, 29 Jan 2024 17:36:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D5BE93CF9BC
	for <ltp@archiver.kernel.org>; Mon, 29 Jan 2024 18:36:23 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C52DB3CF9AE
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 18:36:08 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 20D6F1400E51
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 18:36:07 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 44DDF1F7F8;
 Mon, 29 Jan 2024 17:36:07 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DCD3A13911;
 Mon, 29 Jan 2024 17:36:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id BJf1MQbit2XZOAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Mon, 29 Jan 2024 17:36:06 +0000
Date: Mon, 29 Jan 2024 18:36:04 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20240129173604.GA621069@pevik>
References: <20240129101448.14463-1-andrea.cervesato@suse.de>
 <Zbe9y0MHJZezVeFp@rei>
 <76d62bc7-ce36-45d6-8f8a-bb6602e3e27b@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <76d62bc7-ce36-45d6-8f8a-bb6602e3e27b@suse.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 44DDF1F7F8
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Fix synchronization problem with dio tests
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

> On 1/29/24 16:01, Cyril Hrubis wrote:
> > Hi!
> > > When system is really fast processing I/O syscalls, multiple childrean
> > > running I/O operations might lock the parent, causing
> > > tst_reap_childrean() to stuck. By adding a small usleep at the
> > > end of the reading I/O operations, which are used by dio_append and
> > > dio_read tests, we ensure that system has enough breath to end tests
> > > correctly and to process children exit.
> > This does smell like a kernel bug to be honest.
> I thought the same at first, but I didn't find issues in the kernel. We can
> take a look deeper for sure.
> > Which test is this? How to reproduce?

FYI It's ADI000 => dio_append (without params), which is failing on s39Ox on SLE
15-SP6. It runs pretty quickly on other common archs.

Kind regards,
Petr


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
