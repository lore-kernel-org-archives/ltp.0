Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6456C61DA4
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 13:04:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 121DF3CC0F0
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 14:04:29 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F25A3C304A
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 14:04:18 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D081D60069A
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 14:04:16 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6EFFE5CE86;
 Thu,  9 Feb 2023 13:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1675947856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hVUig4sUPaRKRVQ/6NgNdTp1B1XTEmIZuNDASdg6hBo=;
 b=fvpOL9FUkS3aPo97fZoVLRKWBDOkr2omDQqJoG9btZfefp6uDBrHOYMKZtenZZTFZCM/3+
 WSTkLkPdPe5IEiDhQ+JQy/gNlajHQHDY62QmDzmLqPoSOdwW2//Z1MoEd+szej58iNyYGS
 J4ArqRh+zNnAwA7oIMPnVcic42VazEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1675947856;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hVUig4sUPaRKRVQ/6NgNdTp1B1XTEmIZuNDASdg6hBo=;
 b=g7pCKk6F+gV8dnsTHHFo/cqChkZfEdXrBrPN3qNdD7Ypy1LRE3aa55kwjb5aZmm9+KcJ/D
 jjt6cQD++Iku09DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5DA3F1339E;
 Thu,  9 Feb 2023 13:04:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id T5rdFVDv5GPmZwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 09 Feb 2023 13:04:16 +0000
Date: Thu, 9 Feb 2023 14:05:46 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Leo Yu-Chi Liang <ycliang@andestech.com>
Message-ID: <Y+Tvqit/PmTn8Da5@yuki>
References: <20230207124008.1788759-1-ycliang@andestech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230207124008.1788759-1-ycliang@andestech.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_pids.c: fix fork failure on small memory
 systems
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
>  lib/tst_pid.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/tst_pid.c b/lib/tst_pid.c
> index 21cadef2a..3fb3f39ad 100644
> --- a/lib/tst_pid.c
> +++ b/lib/tst_pid.c
> @@ -31,6 +31,7 @@
>  #include "tst_safe_macros.h"
>  
>  #define PID_MAX_PATH "/proc/sys/kernel/pid_max"
> +#define THREADS_MAX_PATH "/proc/sys/kernel/threads-max"
>  #define CGROUPS_V1_SLICE_FMT "/sys/fs/cgroup/pids/user.slice/user-%d.slice/pids.max"
>  #define CGROUPS_V2_SLICE_FMT "/sys/fs/cgroup/user.slice/user-%d.slice/pids.max"
>  /* Leave some available processes for the OS */
> @@ -113,7 +114,7 @@ static int get_session_pids_limit(void (*cleanup_fn) (void))
>  int tst_get_free_pids_(void (*cleanup_fn) (void))
>  {
>  	FILE *f;
> -	int rc, used_pids, max_pids, max_session_pids;
> +	int rc, used_pids, max_pids, max_session_pids, max_threads;
>  
>  	f = popen("ps -eT | wc -l", "r");
>  	if (!f) {
> @@ -129,6 +130,8 @@ int tst_get_free_pids_(void (*cleanup_fn) (void))
>  	}
>  
>  	SAFE_FILE_SCANF(cleanup_fn, PID_MAX_PATH, "%d", &max_pids);
> +	SAFE_FILE_SCANF(cleanup_fn, THREADS_MAX_PATH, "%d", &max_threads);
> +	max_pids = (max_pids < max_threads) ? max_pids : max_threads;

BTW: We do have a MIN() macro definition in tst_minmax.h header so we
     can just do max_pids = MIN(max_pids, max_threads);

>  	max_session_pids = get_session_pids_limit(cleanup_fn);
>  	if ((max_session_pids > 0) && (max_session_pids < max_pids))

Otherwise:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
