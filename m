Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866CDCD5BD0
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 15:41:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2033F3CB964
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 17:41:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B3BA3C71DC
 for <ltp@lists.linux.it>; Wed, 27 May 2026 17:40:51 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4E4311400C60
 for <ltp@lists.linux.it>; Wed, 27 May 2026 17:40:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4B6FB66DF7;
 Wed, 27 May 2026 15:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779896450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sVWX+iwdqssyauaa4ZhX+celI8rUOZSrGp6sY86ZDbE=;
 b=Ql8R8wEDMTGjGtjg6lCNZxP5kq8+oMzCwbpZiI60b5ZB+goPKeWyKIRg/By0/uCMscwCd6
 uh1nT0GeuHetIA5gN5V2/W68I+u1vFKSy8NHYFPRZ+ITco+l6G08yZ+l5d1xDar5hN0lqL
 dtVce8h3QrqRaTSKFkKwR776/X468b8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779896450;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sVWX+iwdqssyauaa4ZhX+celI8rUOZSrGp6sY86ZDbE=;
 b=WwvDqnwvR9j8ZSNimx2Eh2GxgSCZEtnQuXjZqQ5Chb1okaDq6gHVG59b1rrJvhr/dY9479
 nbZJvwUObLCLcDAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qdpymkVh;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OBCEmzoC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779896446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sVWX+iwdqssyauaa4ZhX+celI8rUOZSrGp6sY86ZDbE=;
 b=qdpymkVhIPW+cK/G3ykD4S4TH6kitGGQb8W7jxm5WAyPJ1aPtEFfG67AtwG4EM+1od4N8s
 5/Rrjth144e71bhhl+6Ek5Tn0e4XQlFqLOyzK+lr0TccPiZD+LpFQsWkDHjHUuc2qVIwCo
 2NMyGEtDWCS/E08liY9SNbWXSfP6bv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779896446;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sVWX+iwdqssyauaa4ZhX+celI8rUOZSrGp6sY86ZDbE=;
 b=OBCEmzoCqb+ap2i34i+xms+UMYLgt87bqSubG3vhcSO8zh9uRFpU3VIZzpwaGxfADSZN/1
 KuszjwkzsvIMLWBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38AB35A8DA;
 Wed, 27 May 2026 15:40:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UZ2bDH4QF2q9LgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 27 May 2026 15:40:46 +0000
Date: Wed, 27 May 2026 17:40:39 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <ahcQd-5ffiCDU8IE@yuki.lan>
References: <20260527050843.14963-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260527050843.14963-1-wegao@suse.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4B6FB66DF7
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid,suse.com:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mem/min_free_kbytes: Add grace period for
 memory reclaim
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
> High memory pressure can cause MemFree to temporarily drop below the
> min_free_kbytes threshold before the kernel reclaimer can catch up.
> This results in intermittent test failures, particularly observed on
> openQA aarch64 machines.
> 
> Implement a 1-second grace period with exponential backoff polling
> (from 1ms up to 512ms) in check_monitor() to allow the kernel time to
> reclaim memory.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
> v1->v2:
> - Combine TINFO and TFAIL messages in check_monitor() for cleaner output.
> - Remove end = 0;
> 
>  .../kernel/mem/tunable/min_free_kbytes.c      | 33 +++++++++++++------
>  1 file changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
> index a62e4ae9d..e0342ef06 100644
> --- a/testcases/kernel/mem/tunable/min_free_kbytes.c
> +++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * Copyright (c) Linux Test Project, 2012-2025
> + * Copyright (c) Linux Test Project, 2012-2026
>   * Copyright (C) 2012-2017  Red Hat, Inc.
>   */
>  
> @@ -140,14 +140,13 @@ static void test_tune(unsigned long overcommit_policy)
>  		} else {
>  			if (WIFEXITED(status)) {
>  				if (WEXITSTATUS(status) != 0) {
> -					tst_res(TFAIL, "child unexpectedly "
> -						 "failed: %d", status);
> +					tst_res(TFAIL, "child unexpectedly failed: %d",
> +						status);

We do have tst_strstatus().

>  				}
>  			} else if (!WIFSIGNALED(status) ||
>  				   WTERMSIG(status) != SIGKILL) {
> -				tst_res(TFAIL,
> -					 "child unexpectedly failed: %d",
> -					 status);
> +				tst_res(TFAIL, "child unexpectedly failed: %d",
> +					status);
>  			}
>  		}
>  	}
> @@ -183,18 +182,32 @@ static void check_monitor(void)
>  {
>  	unsigned long tune;
>  	unsigned long memfree;
> +	int i;
>  
>  	while (!end) {
>  		memfree = SAFE_READ_MEMINFO("MemFree:");
>  		tune = TST_SYS_CONF_LONG_GET(MIN_FREE_KBYTES);
>  
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
> +				tst_res(TFAIL, "MemFree %lu kB < min_free_kbytes %lu kB",
> +					memfree, tune);
> +			}
>  		}

Looks good.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

I think that we also want to change the test so that the monitor is
started and stopped for each testcase with a specific value we set the
min_free_kbytes to. Running it asynchronously like this may mean that we
will be looking for a wrong value for the second if we are unlucky. But
that can be done later on.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
