Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48AFDC433F5
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 14:35:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D88B83C90F9
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 15:35:39 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2AE2B3C8FD2
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 15:35:30 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8D5F9140098B
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 15:35:29 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B72AD1F38A;
 Fri, 17 Dec 2021 14:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639751728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rpepQvRT9EsbMvvYmvkOIEv2I1ugDTnc4MPmD1WhynE=;
 b=B44Dc4WEUNuBcTliPmY7ZOk8uXakmoYBbG315gnirr7pflvigdXf5q3nwk5lMB7+8/AuVc
 OEJEvoZrf7PbpMizRGnpdJNuVYwh/TB3rkHanjQotb0utg7VVC+mCc3WAPoqadM1879RGb
 9naQKY5hNwJ27NfqQIlZ8z9YfCUEKps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639751728;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rpepQvRT9EsbMvvYmvkOIEv2I1ugDTnc4MPmD1WhynE=;
 b=hE6/G0wzYwXQdnXC781AaByD9tAhQepyQLO6PRc1yJfs84eoloE/sSm+LBR2QSozXtMPMX
 PWs5ApBUKoykpsBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8C46B13E1C;
 Fri, 17 Dec 2021 14:35:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9oCYGjCgvGGwJgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 17 Dec 2021 14:35:28 +0000
Date: Fri, 17 Dec 2021 15:36:55 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Ybygh2yfNmM9vbRW@yuki>
References: <20211217113751.359613-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211217113751.359613-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] lib: add functions to adjust oom score
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
> +/*
> + * Enable OOM protection to prevent process($PID) being killed by OOM Killer.
> + *   echo -1000 >/proc/$PID/oom_score_adj
> + *
> + * Note:
> + *  This exported tst_enable_oom_protection function can be used at anywhere
> + *  you want to protect, but please remember that if you do enable protection
> + *  on a process($PID) that all the children will inherit its score and be
> + *  ignored by OOM Killer as well. So that's why tst_cancel_oom_protection is
> + *  recommended to combination in use.
> + */
> +void tst_enable_oom_protection(pid_t pid);
> +
> +/*
> + * Cancel the OOM protection for the process($PID).
> + *   echo 0 >/proc/$PID/oom_score_adj
> + */
> +void tst_cancel_oom_protection(pid_t pid);

Minor nit: opposite of enable is disable not cancel.

>  #endif /* TST_MEMUTILS_H__ */
> diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
> index bd09cf6fa..d97b35007 100644
> --- a/lib/tst_memutils.c
> +++ b/lib/tst_memutils.c
> @@ -3,6 +3,7 @@
>   * Copyright (c) 2020 SUSE LLC <mdoucha@suse.cz>
>   */
>  
> +#include <stdio.h>
>  #include <unistd.h>
>  #include <limits.h>
>  #include <sys/sysinfo.h>
> @@ -91,3 +92,31 @@ long long tst_available_mem(void)
>  
>  	return mem_available;
>  }
> +
> +static void set_oom_score_adj(pid_t pid, int value)
> +{
> +	int val;
> +	char score_path[64];
> +
> +	if (access("/proc/self/oom_score_adj", F_OK) == -1) {
> +		tst_res(TINFO, "Warning: oom_score_adj does not exist");
> +		return;
> +	}
> +
> +	sprintf(score_path, "/proc/%d/oom_score_adj", pid);
> +	SAFE_FILE_PRINTF(score_path, "%d", value);
> +
> +	SAFE_FILE_SCANF(score_path, "%d", &val);
> +	if (val != value)
> +		tst_brk(TBROK, "oom_score_adj = %d, but expect %d.", val, value);
> +}
> +
> +void tst_enable_oom_protection(pid_t pid)
> +{
> +	set_oom_score_adj(pid, -1000);
> +}
> +
> +void tst_cancel_oom_protection(pid_t pid)
> +{
> +	set_oom_score_adj(pid, 0);
> +}
> -- 
> 2.31.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
