Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9669DD3ABCA
	for <ltp@archiver.kernel.org>; Mon, 11 Nov 2024 16:08:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4EE233D55D8
	for <ltp@archiver.kernel.org>; Mon, 11 Nov 2024 17:08:31 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF8383C54A1
 for <ltp@lists.linux.it>; Mon, 11 Nov 2024 17:08:16 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0A9BE667B69
 for <ltp@lists.linux.it>; Mon, 11 Nov 2024 17:08:14 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 39F1321965;
 Mon, 11 Nov 2024 16:08:14 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2703C13301;
 Mon, 11 Nov 2024 16:08:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id V9KRCO4rMmdgCQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 11 Nov 2024 16:08:14 +0000
Date: Mon, 11 Nov 2024 17:08:21 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZzIr9bBKPmnN_3YY@yuki.lan>
References: <20241111143609.185692-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241111143609.185692-1-pvorel@suse.cz>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 39F1321965
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] syscalls: Add missing WEXITSTATUS() check
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
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> I haven't found any other test which would need it.
>  testcases/kernel/syscalls/madvise/madvise08.c | 2 +-
>  testcases/kernel/syscalls/select/select03.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/madvise/madvise08.c b/testcases/kernel/syscalls/madvise/madvise08.c
> index 96bcaf159a..cd5ce722a5 100644
> --- a/testcases/kernel/syscalls/madvise/madvise08.c
> +++ b/testcases/kernel/syscalls/madvise/madvise08.c
> @@ -173,7 +173,7 @@ static pid_t run_child(int advice)
>  	SAFE_WAITPID(pid, &status, 0);
>  	if (WIFSIGNALED(status) && WCOREDUMP(status))
>  		return pid;
> -	if (WIFEXITED(status))
> +	if (WIFEXITED(status) && !WEXITSTATUS(status))
>  		return 0;
>  
>  	tst_res(TCONF, "No coredump produced after signal (%d)",

This one is not complete. We do exit(1) if madvise fails that would be
previously caught here so we have to add:

diff --git a/testcases/kernel/syscalls/madvise/madvise08.c b/testcases/kernel/syscalls/madvise/madvise08.c
index 96bcaf159..f8f74ef4f 100644
--- a/testcases/kernel/syscalls/madvise/madvise08.c
+++ b/testcases/kernel/syscalls/madvise/madvise08.c
@@ -165,7 +165,7 @@ static pid_t run_child(int advice)
                                fmem,
                                FMEMSIZE,
                                advstr);
-                       exit(1);
+                       exit(0);
                }
                abort();
        }


> diff --git a/testcases/kernel/syscalls/select/select03.c b/testcases/kernel/syscalls/select/select03.c
> index 1cec3a4c76..216b22104f 100644
> --- a/testcases/kernel/syscalls/select/select03.c
> +++ b/testcases/kernel/syscalls/select/select03.c
> @@ -77,7 +77,7 @@ static void run(unsigned int n)
>  
>  	SAFE_WAITPID(pid, &status, 0);
>  
> -	if (WIFEXITED(status))
> +	if (WIFEXITED(status) && !WEXITSTATUS(status))
>  		return;
>  
>  	if (tst_variant == GLIBC_SELECT_VARIANT &&
> -- 
> 2.45.2
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
