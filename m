Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A692BC3600B
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 13:19:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1626C3C9FA1
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 14:18:59 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 65DD73C9BAE
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 14:18:42 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 56D221A00E63
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 14:18:40 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E1DC32116C;
 Thu, 27 Mar 2025 13:18:39 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8AEB1376E;
 Thu, 27 Mar 2025 13:18:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NtiAJy9Q5We7SwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 27 Mar 2025 13:18:39 +0000
Date: Thu, 27 Mar 2025 14:18:38 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20250327131838.GB77751@pevik>
References: <20250327-landlock_unix_socket-v1-0-584653f66d9c@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250327-landlock_unix_socket-v1-0-584653f66d9c@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: E1DC32116C
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/4] Landlock tests for ABI v6
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
Cc: =?iso-8859-2?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
 linux-security-module@vger.kernel.org,
 =?iso-8859-2?Q?G=FCnther?= Noack <gnoack@google.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

FYI new batch of Andrea's work on landlock test coverage in LTP.
Feel free to have a look.

https://patchwork.ozlabs.org/project/ltp/list/?series=450223&archive=both
https://lore.kernel.org/ltp/20250327-landlock_unix_socket-v1-0-584653f66d9c@suse.com/T/#t

Kind regards,
Petr

> Landlock released a new feature for IPC scoping in the new ABI.
> This includes the following new rules which will be tested in
> this patch-set:

> - LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET
> - LANDLOCK_SCOPE_SIGNAL

> https://docs.kernel.org/userspace-api/landlock.html#ipc-scoping

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Andrea Cervesato (4):
>       Add landlock ABI v6 fallback
>       landlock02: support landlock ABI v6
>       landlock: add landlock09 test
>       landlock: add landlock10 test

>  include/lapi/landlock.h                            |  23 +++-
>  testcases/kernel/syscalls/landlock/.gitignore      |   2 +
>  testcases/kernel/syscalls/landlock/landlock02.c    |  10 +-
>  testcases/kernel/syscalls/landlock/landlock09.c    | 132 +++++++++++++++++++++
>  testcases/kernel/syscalls/landlock/landlock10.c    | 110 +++++++++++++++++
>  .../kernel/syscalls/landlock/landlock_common.h     |  11 ++
>  6 files changed, 280 insertions(+), 8 deletions(-)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
