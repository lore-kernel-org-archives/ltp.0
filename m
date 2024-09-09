Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4918FECE57A
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 14:16:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 42F6E3C1841
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 16:16:27 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B6FA3C0FB6
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 16:16:12 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 528606003C9
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 16:16:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5BE3221A54;
 Mon,  9 Sep 2024 14:16:10 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C35313312;
 Mon,  9 Sep 2024 14:16:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id g2B9ESoD32asdwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 09 Sep 2024 14:16:10 +0000
Date: Mon, 9 Sep 2024 16:14:55 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Zt8C3wF_zgpBtrxC@yuki.lan>
References: <20240909-regen_shutup_lsp-v1-1-d65ad07b822f@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240909-regen_shutup_lsp-v1-1-d65ad07b822f@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 5BE3221A54
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Remove cleanup.c inclusion from syscalls
 generation
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
> Remove cleanup.c from syscalls.h as it is part of the old library and
> its usage is discouraged. LSP(s) supporting C language correctly flag
> this file as problematic. This patch ensures that the lapi/syscalls/regen.sh
> script will no longer include cleanup.c, preventing unnecessary usage in
> generated headers.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  include/lapi/syscalls/regen.sh | 6 ++++--

Can we remove the cleanup.c as well? It does not seem to be used
anywhere after this change.

>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/lapi/syscalls/regen.sh b/include/lapi/syscalls/regen.sh
> index 97027e2f3..0dd3269bb 100755
> --- a/include/lapi/syscalls/regen.sh
> +++ b/include/lapi/syscalls/regen.sh
> @@ -33,7 +33,6 @@ cat << EOF > "${output_pid}"
>  #include <errno.h>
>  #include <sys/syscall.h>
>  #include <asm/unistd.h>
> -#include "cleanup.c"
>  
>  #ifdef TST_TEST_H__
>  #define TST_SYSCALL_BRK__(NR, SNR) ({ \\
> @@ -41,8 +40,11 @@ cat << EOF > "${output_pid}"
>  		"syscall(%d) " SNR " not supported on your arch", NR); \\
>  })
>  #else
> +static void dummy_cleanup(void) __attribute__ ((unused));

I do not think that we need this part, the function is always used
because it's passed to the tst_brkm().

> +static void dummy_cleanup(void) {}
> +
>  #define TST_SYSCALL_BRK__(NR, SNR) ({ \\
> -	tst_brkm(TCONF, CLEANUP, \\
> +	tst_brkm(TCONF, dummy_cleanup, \\
>  		"syscall(%d) " SNR " not supported on your arch", NR); \\
>  })
>  #endif
> 
> ---
> base-commit: d3f1f93eda69905932bde4f66b44d72f9211909a
> change-id: 20240909-regen_shutup_lsp-a35606a887b6
> 
> Best regards,
> -- 
> Andrea Cervesato <andrea.cervesato@suse.com>
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
