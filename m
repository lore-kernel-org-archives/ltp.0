Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CDC9CD98D2
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 08:03:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A7033E5967
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 10:03:53 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 791BD3C96A5
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 10:03:38 +0200 (CEST)
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AB30C1A00CBA
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 10:03:34 +0200 (CEST)
Date: Tue, 16 Jun 2026 16:03:14 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1781597006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9a9zONIpFruWTmep/b6MDQB+eRynhKqZhwnY5ISxXXk=;
 b=w5PAVVItRz74qk6eENi6l9ki/aU2PPHbvsfnmjH88WQfIAtg5Vp8eYKAlUuz0+SJyTWsL0
 mDbPfuqI0wV3tDvbexaxo2p+o1EGh97IltNA54u8EGkN5/SEGEntVTJJEkmIjfPgIQtJJc
 NUikFeK/FpZvugNGY7rrN3LSvWOfIFE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ajEDQhmd5AJTvpg2@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
References: <20260615-fix_pids_errors-v1-0-99a54a205180@suse.com>
 <20260615-fix_pids_errors-v1-2-99a54a205180@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260615-fix_pids_errors-v1-2-99a54a205180@suse.com>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] tst_cgroup: tolerate ESRCH in cgroup_drain()
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

> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> A process can die between reading cgroup.procs and writing its PID
> to the destination cgroup. When this happens, the kernel returns
> ESRCH which is a normal race condition, not a test infrastructure
> failure.
> 
> Skip ESRCH errors instead of aborting with TBROK.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  lib/tst_cgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> index a37bf1516aabfbcb9a02fedd6fddb98e85ecc653..42d07912aebc0fae423b52f22c36c6beab0ee5c6 100644
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -974,7 +974,7 @@ static void cgroup_drain(const enum tst_cg_ver ver,
>  	for (tok = strtok(pid_list, "\n"); tok; tok = strtok(NULL, "\n")) {
>  		ret = dprintf(fd, "%s", tok);
>  
> -		if (ret < (ssize_t)strlen(tok))
> +		if (ret < (ssize_t)strlen(tok) && errno != ESRCH)

errno is only meaningful after a call that actually failed (ret < 0).
With a short but non-negative return, errno holds whatever value some
earlier libc/syscall left there.

So maybe better like this:

    if (ret < (ssize_t)strlen(tok)) {
        if (ret < 0 && errno == ESRCH)
            continue;

        tst_brk(TBROK | TERRNO, "Failed to drain %s", tok);
    }

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
