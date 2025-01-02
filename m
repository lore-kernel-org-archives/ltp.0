Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA5FE77188
	for <ltp@archiver.kernel.org>; Thu,  2 Jan 2025 14:50:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FA233F042A
	for <ltp@archiver.kernel.org>; Thu,  2 Jan 2025 15:50:25 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A5A703EB992
 for <ltp@lists.linux.it>; Thu,  2 Jan 2025 15:50:08 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B7FA9617D07
 for <ltp@lists.linux.it>; Thu,  2 Jan 2025 15:50:07 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DD84D1F395;
 Thu,  2 Jan 2025 14:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735829407;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hMHxLCoSeoE0+xFarTE6fWqh/53CNGCrg6z937pDysM=;
 b=lD6UtuXhJDQZN1YTjZLao5TCw+fzzPtia/L7RxVQ6hfAFgt7O1UFAHmqZSA1RDvZbHUKdZ
 ajHNVr5L5N0p4dNglBfRx7hjssQLr2NNJnehGTCIiDgq82riI8m5BzUyopIzEBbCCWeXZU
 xL6MRIV54eDmRZggykvMQxfCvHngFTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735829407;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hMHxLCoSeoE0+xFarTE6fWqh/53CNGCrg6z937pDysM=;
 b=12bqHJkU+TXv5D0iHGMFwSx9tzkM7yasCPXE5uuK+FKRDQq9i5pgztnYgxsDhNq61JHVC2
 e59e7kTu647vBODw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hPSLJ39r;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=r8yOXRF+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735829406;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hMHxLCoSeoE0+xFarTE6fWqh/53CNGCrg6z937pDysM=;
 b=hPSLJ39rDaR4q6spiofcQku6OO0dHqO+R7wsnq6NG0oMx89d32uaC+81u3royNDE5hKRaY
 L1k/b4Eq7etiACe17oLNnzZgMfbuK4jQ+1VaTedpYymysMwTrlV/1tpwzcPZfkwV62wITM
 pb4ze35P2CHQKTxqMlZ7HGaXKgwucBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735829406;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hMHxLCoSeoE0+xFarTE6fWqh/53CNGCrg6z937pDysM=;
 b=r8yOXRF+GgUguCIOTpKdf6X8u4FOjw7X1dMUESM5Crwx4RAXF+rj6NBV/ozMFMLTw3vgHD
 7F2P/GFOpG8WQDDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B56F013418;
 Thu,  2 Jan 2025 14:50:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UE+DKZ6ndmdfGgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 02 Jan 2025 14:50:06 +0000
Date: Thu, 2 Jan 2025 15:50:04 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250102145004.GC94207@pevik>
References: <20241222075102.14536-1-liwang@redhat.com>
 <20241222075102.14536-2-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241222075102.14536-2-liwang@redhat.com>
X-Rspamd-Queue-Id: DD84D1F395
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; REPLYTO_EQ_FROM(0.00)[]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] tst_fuzzy_sync: ingnore test result if loop
 termination occurs
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

> This patch updates the behavior of tst_fuzzy_sync tests to address
> scenarios where test results may be unreliable due to resource constraints.

> Specifically, if pair->exit is set (indicating exceeded loop termination),
> the test result is ignored, and a TCONF status is returned. This ensures
> invalid results are not falsely reported as failures or successes.

>   tst_fuzzy_sync.h:654: TINFO: Exceeded execution loops, requesting exit
>   /lib/newlib_tests/tst_fuzzy_sync02.c:164: TFAIL: 2| =:15

LGTM, good catch.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Below are noted typos, could you please fix them before merge?

> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  lib/newlib_tests/tst_fuzzy_sync01.c | 21 +++++++++++++++++++++
>  lib/newlib_tests/tst_fuzzy_sync02.c | 21 +++++++++++++++++++++
>  2 files changed, 42 insertions(+)

> diff --git a/lib/newlib_tests/tst_fuzzy_sync01.c b/lib/newlib_tests/tst_fuzzy_sync01.c
> index d510bd2dd..c8c195859 100644
> --- a/lib/newlib_tests/tst_fuzzy_sync01.c
> +++ b/lib/newlib_tests/tst_fuzzy_sync01.c
> @@ -212,10 +212,31 @@ static void run(unsigned int i)

>  		if (critical > 100) {
>  			tst_fzsync_pair_cleanup(&pair);
> +			tst_atomic_store(0, &pair.exit);
>  			break;
>  		}
>  	}

> +	/*
> +	 * If `pair->exit` is true, the test may fail to meet expected
> +	 * results due to resource constraints in shared CI environments
> +	 * (e.g., GitHub Actions). Limited control over CPU allocation
> +	 * can cause delays or interruptions in CPU time slices due to
> +	 * contention with other jobs.
> +	 *
> +	 * Binding the test to a single CPU core (e.g., via `taskset -c 0`)
> +	 * can worsen this by increasing contention, leading to performance
> +	 * degradation and premature loop termination.
> +	 *
> +	 * To ensure valid and reliable results in scenarios (e.g., HW, VM, CI),
> +	 * it is best to ingore test result when loop termination occurs,
s/ingore/ignore/
> +	 * avoiding unnecessary false postive.
s/postive/positive/

> +	 */
> +	if (pair.exit) {
> +		tst_res(TCONF, "Test may not be able to generate a valid result");
> +		return;
> +	}
> +
>  	tst_res(critical > 50 ? TPASS : TFAIL,
>  		"acs:%-2d act:%-2d art:%-2d | =:%-4d -:%-4d +:%-4d",
>  		a.critical_s, a.critical_t, a.return_t,
> diff --git a/lib/newlib_tests/tst_fuzzy_sync02.c b/lib/newlib_tests/tst_fuzzy_sync02.c
> index f95394371..ad19a675e 100644
> --- a/lib/newlib_tests/tst_fuzzy_sync02.c
> +++ b/lib/newlib_tests/tst_fuzzy_sync02.c
> @@ -192,10 +192,31 @@ static void run(unsigned int i)

>  		if (critical > 100) {
>  			tst_fzsync_pair_cleanup(&pair);
> +			tst_atomic_store(0, &pair.exit);
>  			break;
>  		}
>  	}

> +	/*
> +	 * If `pair->exit` is true, the test may fail to meet expected
> +	 * results due to resource constraints in shared CI environments
> +	 * (e.g., GitHub Actions). Limited control over CPU allocation
> +	 * can cause delays or interruptions in CPU time slices due to
> +	 * contention with other jobs.
> +	 *
> +	 * Binding the test to a single CPU core (e.g., via `taskset -c 0`)
> +	 * can worsen this by increasing contention, leading to performance
> +	 * degradation and premature loop termination.
> +	 *
> +	 * To ensure valid and reliable results in scenarios (e.g., HW, VM, CI),
> +	 * it is best to ingore test result when loop termination occurs,
s/ingore/ignore/
> +	 * avoiding unnecessary false postive.
s/postive/positive/

Also there is original typo from Richie:
s/Emperically/Empirically/

Kind regards,
Petr

> +	 */
> +	if (pair.exit) {
> +		tst_res(TCONF, "Test may not be able to generate a valid result");
> +		return;
> +	}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
