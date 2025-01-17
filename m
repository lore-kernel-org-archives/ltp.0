Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8DB0C02183
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 07:36:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6CC313C7C2F
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 08:36:29 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 717613C7B97
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 08:36:11 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 510D014291AA
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 08:36:10 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 664502118D;
 Fri, 17 Jan 2025 07:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737099369;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HU78vDTCKSZ1RsC5nz7caUEhFfhA9VDq5Rl/HG8vhXs=;
 b=20e1KLE04m/ysOQnj7Co5tlS+wWzIY7eqT3wUvFH0X15ujmIdNNJkeQsx/SvY4nTNcXs6/
 qF1PW/x72XTRPmZzGfpBerouThso3T9WtUDpAR9WvF68ViGVyiv2S+EiOGfXFO/0+v+ihr
 UwFGM9FMqR0G01AZPRVqljxo2ba+xhM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737099369;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HU78vDTCKSZ1RsC5nz7caUEhFfhA9VDq5Rl/HG8vhXs=;
 b=ErMEhtE69XN0o2BqOfsLOQc71YxD0Tmv9Rl8QY6ZcY/rffNjH+Pwf5RbVhF9aFe8+4WYZA
 nD4JueZpRYd6IDDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=20e1KLE0;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ErMEhtE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737099369;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HU78vDTCKSZ1RsC5nz7caUEhFfhA9VDq5Rl/HG8vhXs=;
 b=20e1KLE04m/ysOQnj7Co5tlS+wWzIY7eqT3wUvFH0X15ujmIdNNJkeQsx/SvY4nTNcXs6/
 qF1PW/x72XTRPmZzGfpBerouThso3T9WtUDpAR9WvF68ViGVyiv2S+EiOGfXFO/0+v+ihr
 UwFGM9FMqR0G01AZPRVqljxo2ba+xhM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737099369;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HU78vDTCKSZ1RsC5nz7caUEhFfhA9VDq5Rl/HG8vhXs=;
 b=ErMEhtE69XN0o2BqOfsLOQc71YxD0Tmv9Rl8QY6ZcY/rffNjH+Pwf5RbVhF9aFe8+4WYZA
 nD4JueZpRYd6IDDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4636C139CB;
 Fri, 17 Jan 2025 07:36:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Wzk4D2kIimd4EAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 17 Jan 2025 07:36:09 +0000
Date: Fri, 17 Jan 2025 08:36:07 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250117073607.GA731427@pevik>
References: <20250117071758.120366-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250117071758.120366-1-liwang@redhat.com>
X-Rspamd-Queue-Id: 664502118D
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: add TST_NO_SLOW_KCONFIG_CHECK macro for
 testcase tools
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

Hi Li,

> The macro TST_NO_SLOW_KCONFIG_CHECK is added to control whether
> the tst_has_slow_kconfig() function (which presumably checks for
> slow kernel configurations) should be executed.

That was quick, thanks a lot!

But unfortunately the patch does not help to avoid printing TINFO
(tested on a fresh clone):

# make && ./tst_ns_exec 14536 net,mnt sh -c " cat /proc/sys/net/ipv6/conf/ltp_ns_veth1/disable_ipv6"
CC testcases/lib/tst_ns_exec
make[1]: Nothing to be done for 'all'.
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:667: TINFO: CONFIG_LATENCYTOP kernel option detected which might slow the execution
0

Maybe it's because safe_clone() triggers it? Or what am I missing?

Kind regards,
Petr

> This allows test cases and tools to opt out of this additional
> check, enabling more flexible and faster test execution in
> certain scenarios.

> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  lib/tst_test.c                    | 2 ++
>  testcases/lib/tst_device.c        | 1 +
>  testcases/lib/tst_get_free_pids.c | 1 +
>  testcases/lib/tst_ns_create.c     | 1 +
>  testcases/lib/tst_ns_exec.c       | 1 +
>  testcases/lib/tst_run_shell.c     | 1 +
>  6 files changed, 7 insertions(+)

> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index b204ad975..00d34b6f0 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1702,8 +1702,10 @@ unsigned int tst_multiply_timeout(unsigned int timeout)
>  	if (timeout < 1)
>  		tst_brk(TBROK, "timeout must to be >= 1! (%d)", timeout);

> +#ifndef TST_NO_SLOW_KCONFIG_CHECK
>  	if (tst_has_slow_kconfig())
>  		timeout *= 4;
> +#endif

>  	return timeout * timeout_mul;
>  }
> diff --git a/testcases/lib/tst_device.c b/testcases/lib/tst_device.c
> index 45f77a38b..386636610 100644
> --- a/testcases/lib/tst_device.c
> +++ b/testcases/lib/tst_device.c
> @@ -8,6 +8,7 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #define TST_NO_DEFAULT_MAIN
> +#define TST_NO_SLOW_KCONFIG_CHECK
>  #include "tst_test.h"
>  #include "old/old_device.h"

> diff --git a/testcases/lib/tst_get_free_pids.c b/testcases/lib/tst_get_free_pids.c
> index 370ec3e26..c6436687a 100644
> --- a/testcases/lib/tst_get_free_pids.c
> +++ b/testcases/lib/tst_get_free_pids.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later

>  #define TST_NO_DEFAULT_MAIN
> +#define TST_NO_SLOW_KCONFIG_CHECK
>  #include <stdio.h>
>  #include "tst_test.h"

> diff --git a/testcases/lib/tst_ns_create.c b/testcases/lib/tst_ns_create.c
> index ce3707a60..8c22ad449 100644
> --- a/testcases/lib/tst_ns_create.c
> +++ b/testcases/lib/tst_ns_create.c
> @@ -17,6 +17,7 @@
>   */

>  #define TST_NO_DEFAULT_MAIN
> +#define TST_NO_SLOW_KCONFIG_CHECK

>  #include <stdio.h>
>  #include <string.h>
> diff --git a/testcases/lib/tst_ns_exec.c b/testcases/lib/tst_ns_exec.c
> index 6a8e39339..ca5b717da 100644
> --- a/testcases/lib/tst_ns_exec.c
> +++ b/testcases/lib/tst_ns_exec.c
> @@ -14,6 +14,7 @@
>   */

>  #define TST_NO_DEFAULT_MAIN
> +#define TST_NO_SLOW_KCONFIG_CHECK

>  #include <stdio.h>
>  #include <sys/wait.h>
> diff --git a/testcases/lib/tst_run_shell.c b/testcases/lib/tst_run_shell.c
> index 7a446e004..b12a1e9f6 100644
> --- a/testcases/lib/tst_run_shell.c
> +++ b/testcases/lib/tst_run_shell.c
> @@ -5,6 +5,7 @@
>  #include <sys/mount.h>

>  #define TST_NO_DEFAULT_MAIN
> +#define TST_NO_SLOW_KCONFIG_CHECK
>  #include "tst_test.h"
>  #include "tst_safe_stdio.h"
>  #include "ujson.h"

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
