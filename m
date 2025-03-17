Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FF6C35FF3
	for <ltp@archiver.kernel.org>; Mon, 17 Mar 2025 14:01:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C37FD3CAB73
	for <ltp@archiver.kernel.org>; Mon, 17 Mar 2025 15:01:07 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D44BE3C06D0
 for <ltp@lists.linux.it>; Mon, 17 Mar 2025 15:00:50 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E4454600878
 for <ltp@lists.linux.it>; Mon, 17 Mar 2025 15:00:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9396821E5A;
 Mon, 17 Mar 2025 14:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1742220048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gkTrHhFR2C4FuyWNVVSR/n2GMo4LPEzz4y1fI3iu2I8=;
 b=Q6RUM1lW3rhKjsO2/6e7a7G+d2GEcw2wVW4ykAe5kb1OIlEh9hnyrdLAjUXjdlfm/32v7f
 DDUwe0clb8ssurfvVeOC+Dbz64qriUAelwv3m5/IpTgWcJ7GzvUuXiIxxr3uYUTPItjgpo
 iXHja8LEkxLcvWv/OIXQto4m4F9Qy3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1742220048;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gkTrHhFR2C4FuyWNVVSR/n2GMo4LPEzz4y1fI3iu2I8=;
 b=pZBA/zTqzrdf2o57IsPFN/jzIx7SFWGfHfu1tSzyTvsqR55Qn5hVDxoIHyvr1osa2acB06
 04hWUPymMMlSpCDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1742220048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gkTrHhFR2C4FuyWNVVSR/n2GMo4LPEzz4y1fI3iu2I8=;
 b=Q6RUM1lW3rhKjsO2/6e7a7G+d2GEcw2wVW4ykAe5kb1OIlEh9hnyrdLAjUXjdlfm/32v7f
 DDUwe0clb8ssurfvVeOC+Dbz64qriUAelwv3m5/IpTgWcJ7GzvUuXiIxxr3uYUTPItjgpo
 iXHja8LEkxLcvWv/OIXQto4m4F9Qy3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1742220048;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gkTrHhFR2C4FuyWNVVSR/n2GMo4LPEzz4y1fI3iu2I8=;
 b=pZBA/zTqzrdf2o57IsPFN/jzIx7SFWGfHfu1tSzyTvsqR55Qn5hVDxoIHyvr1osa2acB06
 04hWUPymMMlSpCDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82956132CF;
 Mon, 17 Mar 2025 14:00:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jKb8HhAr2GcaZgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 17 Mar 2025 14:00:48 +0000
Date: Mon, 17 Mar 2025 15:01:09 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Z9grJVBa6G7qhBCF@yuki.lan>
References: <20250313-mmap_suite_refactoring-v4-0-efd682ece39a@suse.com>
 <20250313-mmap_suite_refactoring-v4-2-efd682ece39a@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250313-mmap_suite_refactoring-v4-2-efd682ece39a@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/8] Refactor mmap10 test
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
> +	struct tcase *tc = &tcases[i];
> +	int fd = -1;
>  
> -	if (opt_ksm) {
> +	if (tc->add_ksm) {
>  		if (access(PATH_KSM, F_OK) == -1)
> -			tst_brkm(TCONF, NULL,
> -				 "KSM configuration is not enabled");
> -#ifdef HAVE_DECL_MADV_MERGEABLE
> -		tst_resm(TINFO, "add to KSM regions.");
> -#else
> -		tst_brkm(TCONF, NULL, "MADV_MERGEABLE missing in sys/mman.h");
> -#endif
> +			tst_brk(TCONF, "KSM configuration is not enabled");
> +	} else {
> +		tst_res(TINFO, "Add to KSM regions");

This else looks like it's for wrong if, shouldn't this be the else for
the inner if?

The rest looks good. With that else branch fixed:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
