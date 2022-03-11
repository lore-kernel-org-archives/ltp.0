Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 404DAC433EF
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 12:35:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1FB5E3C8CA6
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 13:35:36 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B5853C0CEA
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 13:35:26 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1291A1000544
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 13:35:25 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 35B7B1F38D;
 Fri, 11 Mar 2022 12:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647002125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ri0jBcqgNMzy8WH0vIeE7L849xMa7qXeJ9wke9N2RbU=;
 b=JoU1BWjDNvR2HIl9yy5U0EAjQBeKdqQMPFG5bXmdS6q7gdB5tgjiL/YocWfaFEhotEKuY0
 oh/iMug5MsWIJEuhFJTgDriFUPb9HDohpEZvDIQ83v2ttjd+zvV6tR+my20lYqD3hCwina
 0eWLSOKaVHSiHJpSPGYsvD+RgKN3TQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647002125;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ri0jBcqgNMzy8WH0vIeE7L849xMa7qXeJ9wke9N2RbU=;
 b=IyDSCufuNjY/AUKa4A+/jvyp04FYyxdX7g985l37ALZlxsXm6xnyoV3NPyPWOEWauvtdDy
 hbi+/SpXFiCCWOAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 120BC13A85;
 Fri, 11 Mar 2022 12:35:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LxbmAw1CK2JfOAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 11 Mar 2022 12:35:25 +0000
Date: Fri, 11 Mar 2022 13:37:43 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YitCl4v9NSpnbyYH@yuki>
References: <20220311120151.601-1-pvorel@suse.cz>
 <20220311120151.601-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220311120151.601-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] madvise06: Move oom_score_adj initialization
 to struct tst_path_val
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
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Is it ok to define it earlier? i.e. before calling sync() ?
> 
>  testcases/kernel/syscalls/madvise/madvise06.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/madvise/madvise06.c b/testcases/kernel/syscalls/madvise/madvise06.c
> index b21f2cc7de..15171442cb 100644
> --- a/testcases/kernel/syscalls/madvise/madvise06.c
> +++ b/testcases/kernel/syscalls/madvise/madvise06.c
> @@ -55,6 +55,7 @@
>  #define PASS_THRESHOLD (CHUNK_SZ / 4)
>  #define PASS_THRESHOLD_KB (PASS_THRESHOLD / 1024)
>  #define SWAPPINESS "60"
> +#define OOM_SCORE_ADJ "-1000"
>  
>  static const char drop_caches_fname[] = "/proc/sys/vm/drop_caches";
>  static int pg_sz, stat_refresh_sup;
> @@ -116,9 +117,6 @@ static void setup(void)
>  			2 * CHUNK_SZ);
>  	}
>  
> -	check_path("/proc/self/oom_score_adj");
> -	SAFE_FILE_PRINTF("/proc/self/oom_score_adj", "%d", -1000);
> -
>  	SAFE_CG_PRINTF(tst_cg, "memory.max", "%ld", MEM_LIMIT);
>  	if (SAFE_CG_HAS(tst_cg, "memory.swap.max"))
>  		SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%ld", MEMSW_LIMIT);
> @@ -231,6 +229,7 @@ static struct tst_test test = {
>  	.needs_root = 1,
>  	.save_restore = (const struct tst_path_val const[]) {
>  		{"?/proc/sys/vm/swappiness", SWAPPINESS},
> +		{"/proc/self/oom_score_adj", OOM_SCORE_ADJ},

I do not think that this is even correct, after this change the file is
being written to by the test library and the 'self' points to a
different process as far as I can tell.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
