Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF63C36010
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 16:52:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D7B713CA081
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 17:52:43 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C8AD33C9FF4
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 17:52:27 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CB1631400F48
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 17:52:26 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 44B2F1F388;
 Thu, 27 Mar 2025 16:52:25 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 335A3139D4;
 Thu, 27 Mar 2025 16:52:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SfVoC0mC5WfDEAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 27 Mar 2025 16:52:25 +0000
Date: Thu, 27 Mar 2025 17:52:46 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Z-WCXnrZ1BIRQtER@yuki.lan>
References: <20250327-landlock_unix_socket-v1-0-584653f66d9c@suse.com>
 <20250327-landlock_unix_socket-v1-4-584653f66d9c@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250327-landlock_unix_socket-v1-4-584653f66d9c@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 44B2F1F388
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/4] landlock: add landlock10 test
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
> Verify that landlock's LANDLOCK_SCOPE_SIGNAL rule rejects any
> signal coming from a process on a different domain, but accept
> signals from processes in the same domain.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  testcases/kernel/syscalls/landlock/.gitignore   |   1 +
>  testcases/kernel/syscalls/landlock/landlock10.c | 110 ++++++++++++++++++++++++
>  2 files changed, 111 insertions(+)

Here as well, runtest entry?

> diff --git a/testcases/kernel/syscalls/landlock/.gitignore b/testcases/kernel/syscalls/landlock/.gitignore
> index cda8d871e051ec88abba4634a2bcda4b10470d9f..8c88803df4580605da800c414ada62994b35d268 100644
> --- a/testcases/kernel/syscalls/landlock/.gitignore
> +++ b/testcases/kernel/syscalls/landlock/.gitignore
> @@ -8,3 +8,4 @@ landlock06
>  landlock07
>  landlock08
>  landlock09
> +landlock10
> diff --git a/testcases/kernel/syscalls/landlock/landlock10.c b/testcases/kernel/syscalls/landlock/landlock10.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..572c3dfe35810e2da301aae4b9807bcc55682f91
> --- /dev/null
> +++ b/testcases/kernel/syscalls/landlock/landlock10.c
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2025 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * Verify that landlock's LANDLOCK_SCOPE_SIGNAL rule rejects any signal coming
> + * from a process on a different domain, but accept signals from processes in
> + * the same domain.
> + */
> +
> +#include "tst_test.h"
> +#include "landlock_common.h"
> +
> +static struct tst_landlock_ruleset_attr_abi6 *ruleset_attr;
> +
> +enum {
> +	DOMAIN_PAUSED = 0,
> +	DOMAIN_KILLER,
> +	DOMAIN_BOTH,
> +	DOMAIN_LENGTH,
                ^
		CNT

Otherwise it looks good:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
