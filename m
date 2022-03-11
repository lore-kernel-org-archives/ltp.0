Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53CAC433F5
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 12:26:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C85953C8C82
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 13:26:44 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B90963C0CEA
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 13:26:34 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2B2BF1400108
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 13:26:33 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 478DE1F381;
 Fri, 11 Mar 2022 12:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647001593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IodPWrW+K+ddFlmxTkMIzFts8V5NH34wEac1lmKbwAA=;
 b=rP+Ob/Fd+yzE1j3C0ljNwTgYI3Zoqle8UMTLmw0j1BHGiPGEhcw7aZmDrdXNbK0ra/J+gY
 C0yicrAhEDzy0qT6oCz8WLyFqrhcPtp5MT3CLIpnpRBk7Xh9t9BCeq6HZqfODWph6S353g
 su2T+3Zp2T/wrRlMEnInil/ppxdaS5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647001593;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IodPWrW+K+ddFlmxTkMIzFts8V5NH34wEac1lmKbwAA=;
 b=Ed/DgAt2/7ketuzwY8SGqAD6BrTbPCh7i5Z7xA25RNTMNsnlS17bKBm8kIPO/niCAWUJyf
 gh4rlQ/OdaEa9TCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EDB1613A89;
 Fri, 11 Mar 2022 12:26:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7GgeOfg/K2ILNAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 11 Mar 2022 12:26:32 +0000
Date: Fri, 11 Mar 2022 13:28:51 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YitAg8rGd++vHUlB@yuki>
References: <20220311120151.601-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220311120151.601-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] madvise06: Fix segfault
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Test required update after 687f0cbc00 to use struct tst_path_val.
> While at it, move the initialization to struct tst_path_val.
> 
> Fixes: 687f0cbc00 ("lib: enhance .save_restore to support set expected value")
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Is it ok to define it earlier? i.e. before calling sync() ?
> 
>  testcases/kernel/syscalls/madvise/madvise06.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/madvise/madvise06.c b/testcases/kernel/syscalls/madvise/madvise06.c
> index 54391db283..b21f2cc7de 100644
> --- a/testcases/kernel/syscalls/madvise/madvise06.c
> +++ b/testcases/kernel/syscalls/madvise/madvise06.c
> @@ -54,6 +54,7 @@
>  #define MEMSW_LIMIT (2 * CHUNK_SZ)
>  #define PASS_THRESHOLD (CHUNK_SZ / 4)
>  #define PASS_THRESHOLD_KB (PASS_THRESHOLD / 1024)
> +#define SWAPPINESS "60"
>  
>  static const char drop_caches_fname[] = "/proc/sys/vm/drop_caches";
>  static int pg_sz, stat_refresh_sup;
> @@ -123,10 +124,9 @@ static void setup(void)
>  		SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%ld", MEMSW_LIMIT);
>  
>  	if (SAFE_CG_HAS(tst_cg, "memory.swappiness")) {
> -		SAFE_CG_PRINT(tst_cg, "memory.swappiness", "60");
> +		SAFE_CG_PRINT(tst_cg, "memory.swappiness", SWAPPINESS);
>  	} else {
>  		check_path("/proc/sys/vm/swappiness");
> -		SAFE_FILE_PRINTF("/proc/sys/vm/swappiness", "%d", 60);
>  	}

I'm not sure if we want to set the "/proc/sys/vm/swappiness"
unconditinally in the .save_restore as previously we set it only if the
cgroup was missing the swappines knob.

So maybe we should go for a minimal fix here, just change the
save_restore to match the new format and don't set the value there.

>  	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
> @@ -229,8 +229,8 @@ static struct tst_test test = {
>  	.min_kver = "3.10.0",
>  	.needs_tmpdir = 1,
>  	.needs_root = 1,
> -	.save_restore = (const char * const[]) {
> -		"?/proc/sys/vm/swappiness",
> +	.save_restore = (const struct tst_path_val const[]) {
> +		{"?/proc/sys/vm/swappiness", SWAPPINESS},
>  		NULL

This has to be terminated by {} now.

>  	},
>  	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
> -- 
> 2.35.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
