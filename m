Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8D7C36010
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 16:50:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 45F0B3C9EA9
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 17:49:58 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B0CF63C917D
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 17:49:40 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F24BE600FE1
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 17:49:39 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 938F71F388;
 Thu, 27 Mar 2025 16:49:38 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81744139D4;
 Thu, 27 Mar 2025 16:49:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id T+qNHqKB5Wf8DwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 27 Mar 2025 16:49:38 +0000
Date: Thu, 27 Mar 2025 17:50:03 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Z-WBu_MGIjlf-s8M@yuki.lan>
References: <20250327-landlock_unix_socket-v1-0-584653f66d9c@suse.com>
 <20250327-landlock_unix_socket-v1-3-584653f66d9c@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250327-landlock_unix_socket-v1-3-584653f66d9c@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 938F71F388
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/4] landlock: add landlock09 test
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
> Create landlock09 test in order to verify that sandboxed processes
> enforced with LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET rule can't
> connect to any UNIX socket from non-sandboxed processes.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  testcases/kernel/syscalls/landlock/.gitignore      |   1 +
>  testcases/kernel/syscalls/landlock/landlock09.c    | 132 +++++++++++++++++++++
>  .../kernel/syscalls/landlock/landlock_common.h     |  11 ++
>  3 files changed, 144 insertions(+)

Runtest entry?

> +/*\
> + * Verify that landlock's LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET rule reject any
> + * connect() coming from a client on a different server domain, but accept any
> + * connection.
> + */
> +
> +#include "tst_test.h"
> +#include "landlock_common.h"
> +
> +#define SOCKET_NAME "test.sock"
> +#define ABSTRACT_SOCKET_NAME "\0"SOCKET_NAME
> +#define SOCKET_LENGTH (offsetof(struct sockaddr_un, sun_path) + strlen(SOCKET_NAME) + 1)
                    ^
		    SIZE

> +enum {
> +	DOMAIN_CLIENT = 0,
> +	DOMAIN_SERVER,
> +	DOMAIN_BOTH,
> +	DOMAIN_LENGTH,
               ^
	       CNT


Other than that:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
