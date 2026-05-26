Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2020BCD5BC8
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 14:11:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 297CE3E62BD
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 16:11:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 89FBF3CB041
 for <ltp@lists.linux.it>; Tue, 26 May 2026 16:10:59 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 059291A00812
 for <ltp@lists.linux.it>; Tue, 26 May 2026 16:10:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7C7C175B90;
 Tue, 26 May 2026 14:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779804657;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ef+o+v26vIeXJk79YPRVH7qvs/ZcUSvNgYO+j0AJd1g=;
 b=aa3sRB6g6sB6kz9mZoGv3nPfLvwpTH7oL8IOgB/q/2zyfXPOmUK4WjuQqO8uIaiqQuh9Ez
 dg7c/Phrg5v1mVHeKL42YGLrY4epdU1Gd26yhJJdkJ+Sm76m1zrqMCCge/lv3QE6v3JhhZ
 4JdswG1AW5tHmSI5DhHfAMdVZzkZW/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779804657;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ef+o+v26vIeXJk79YPRVH7qvs/ZcUSvNgYO+j0AJd1g=;
 b=cnNwcyJAI6zod9qiD70u24LbsQhm+luhnmnonx28L6mHgtSFA9Jn3eS8D3kgq193+WNhvY
 I57zI6cuusWdHiBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779804657;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ef+o+v26vIeXJk79YPRVH7qvs/ZcUSvNgYO+j0AJd1g=;
 b=aa3sRB6g6sB6kz9mZoGv3nPfLvwpTH7oL8IOgB/q/2zyfXPOmUK4WjuQqO8uIaiqQuh9Ez
 dg7c/Phrg5v1mVHeKL42YGLrY4epdU1Gd26yhJJdkJ+Sm76m1zrqMCCge/lv3QE6v3JhhZ
 4JdswG1AW5tHmSI5DhHfAMdVZzkZW/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779804657;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ef+o+v26vIeXJk79YPRVH7qvs/ZcUSvNgYO+j0AJd1g=;
 b=cnNwcyJAI6zod9qiD70u24LbsQhm+luhnmnonx28L6mHgtSFA9Jn3eS8D3kgq193+WNhvY
 I57zI6cuusWdHiBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0910F5A245;
 Tue, 26 May 2026 14:10:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VvfKN/CpFWqKHQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 26 May 2026 14:10:56 +0000
Date: Tue, 26 May 2026 16:10:54 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20260526141054.GA175193@pevik>
References: <20260526083650.14036-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260526083650.14036-1-wegao@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,suse.com:email]; 
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] min_free_kbytes: Handle transient memory drops
 in check_monitor
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

Hi Wei,

> High memory pressure can cause MemFree to temporarily drop below the
> min_free_kbytes threshold before the kernel reclaimer can catch up.
> This results in intermittent test failures, particularly observed on
> openQA aarch64 machines.

> Implement a 1-second grace period with exponential backoff polling
> (from 1ms up to 512ms) in check_monitor() to allow the kernel time to
> reclaim memory.

> Also the global 'end' flag is reset for multi-iteration
> support (-i).
IMHO this is not needed. Is it just wrong AI hint or you really spot it's
needed?

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  .../kernel/mem/tunable/min_free_kbytes.c      | 36 +++++++++++++------
>  1 file changed, 26 insertions(+), 10 deletions(-)

> diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
> index a62e4ae9d..59ba6a9e1 100644
> --- a/testcases/kernel/mem/tunable/min_free_kbytes.c
> +++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * Copyright (c) Linux Test Project, 2012-2025
> + * Copyright (c) Linux Test Project, 2012-2026
>   * Copyright (C) 2012-2017  Red Hat, Inc.
>   */

> @@ -53,6 +53,8 @@ static void min_free_kbytes_test(void)
>  	int pid, status;
>  	struct sigaction sa;

> +	end = 0;
Why I think it's not needed? Here you're in the parent. But the value is changed
only in child (forked process), they run in a separate memory spaces (change in
child is not visible for the parent).

In patch without it + updated commit message you may add:
Reviewed-by: Petr Vorel <pvorel@suse.cz>

> +
>  	sa.sa_handler = sighandler;
>  	if (sigemptyset(&sa.sa_mask) < 0)
>  		tst_brk(TBROK | TERRNO, "sigemptyset");
> @@ -140,14 +142,13 @@ static void test_tune(unsigned long overcommit_policy)
>  		} else {
>  			if (WIFEXITED(status)) {
>  				if (WEXITSTATUS(status) != 0) {
> -					tst_res(TFAIL, "child unexpectedly "
> -						 "failed: %d", status);
> +					tst_res(TFAIL, "child unexpectedly failed: %d",
> +						status);
>  				}
>  			} else if (!WIFSIGNALED(status) ||
>  				   WTERMSIG(status) != SIGKILL) {
> -				tst_res(TFAIL,
> -					 "child unexpectedly failed: %d",
> -					 status);
> +				tst_res(TFAIL, "child unexpectedly failed: %d",
> +					status);
>  			}
Unrelated cleanup, but thanks.

>  		}
>  	}
> @@ -183,18 +184,33 @@ static void check_monitor(void)
>  {
>  	unsigned long tune;
>  	unsigned long memfree;
> +	int i;

>  	while (!end) {
>  		memfree = SAFE_READ_MEMINFO("MemFree:");
>  		tune = TST_SYS_CONF_LONG_GET(MIN_FREE_KBYTES);

>  		if (memfree < tune) {
> -			tst_res(TINFO, "MemFree is %lu kB, "
> -				 "min_free_kbytes is %lu kB", memfree, tune);
> -			tst_res(TFAIL, "MemFree < min_free_kbytes");
> +			/*
> +			 * Give it some time to reclaim. The kernel should keep
> +			 * MemFree above min_free_kbytes, but transient drops
> +			 * are possible under high pressure.
> +			 */
> +			for (i = 1; i < 1024; i *= 2) {
> +				usleep(i * 1000);
> +				memfree = SAFE_READ_MEMINFO("MemFree:");
> +				if (memfree >= tune)
> +					break;
> +			}
> +
> +			if (memfree < tune) {
> +				tst_res(TINFO, "MemFree is %lu kB, min_free_kbytes is %lu kB",
> +					memfree, tune);
> +				tst_res(TFAIL, "MemFree < min_free_kbytes");
> +			}
>  		}

> -		sleep(2);
> +		usleep(100000);
>  	}
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
