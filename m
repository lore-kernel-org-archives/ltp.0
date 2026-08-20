Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D19EC5DF85
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 14:11:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6CF6A3CE5F9
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 16:11:08 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4BAFD3C0962
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 16:10:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id ACEA8600124
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 16:10:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3502685113;
 Thu, 20 Aug 2026 14:10:52 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23BB9351D;
 Thu, 20 Aug 2026 14:10:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iMe0B+wKh2pRWwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 20 Aug 2026 14:10:52 +0000
Date: Thu, 20 Aug 2026 16:10:52 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aocK7DW6YLBocJdW@yuki.lan>
References: <20260820-fchroot-v2-0-062ed20957a0@suse.com>
 <20260820-fchroot-v2-5-062ed20957a0@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260820-fchroot-v2-5-062ed20957a0@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 3502685113
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH STAGING v2 05/16] fchroot02: test fchroot()
 invalid arguments
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +/*\
> + * Test the :manpage:`fchroot(2)` error paths for invalid arguments.
> + *
> + * :manpage:`fchroot(2)` was introduced in Linux v7.3. The syscall checks its
> + * arguments in this order:
> + *
> + * - a non-zero flags argument fails with ``EINVAL`` before anything else,
> + *   including with the ``FD_FAILFS_ROOT`` sentinel and with an invalid fd
> + * - an invalid fd fails with ``EBADF``, including the ``FD_PIDFS_ROOT`` and
> + *   ``FD_NSFS_ROOT`` sentinels which :manpage:`fchroot(2)` does not accept
> + * - a fd referring to a regular file fails with ``ENOTDIR``
> + *
> + * All these checks happen before the ``CAP_SYS_CHROOT`` check, so the test
> + * needs no privileges.

The order of check in kernel is never guaranteed and subject to change
at any time. We shouldn't rely on particular check being done first.


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
