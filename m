Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B800E7717F
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 01:47:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD2423E94CB
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 02:47:33 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 824573E935F
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 02:47:17 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7ADF310007EA
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 02:47:16 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5F8122110B;
 Wed, 11 Dec 2024 01:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733881636;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gv21yoQhT/8sB5xLz/LvoAOFhXBIx/Kd8G1aglwqaXs=;
 b=O9nON8B7HKAdFwqzmN1o702DGbE0ICXubXMfdKRHyvBXOcAOf3c2H+xQ8i4A7X4F9e2L0e
 A45fdSRqFevRU94McQnvayipUFhCheSO3S47+LhzPnCMr5sbejT3Fu4T//Xhf/SLPsRNN7
 Cpxuh9RC7R2i+5mthg6edRIrXwAbfrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733881636;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gv21yoQhT/8sB5xLz/LvoAOFhXBIx/Kd8G1aglwqaXs=;
 b=FXV4mr2cMGxJ2GviBtOeLA1rWotrdHybq/yGH0niGJrJ+Ya3NPVh9pFSO5+kxml/HNmi2U
 IUVEnLMTWuQ/4nCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733881636;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gv21yoQhT/8sB5xLz/LvoAOFhXBIx/Kd8G1aglwqaXs=;
 b=O9nON8B7HKAdFwqzmN1o702DGbE0ICXubXMfdKRHyvBXOcAOf3c2H+xQ8i4A7X4F9e2L0e
 A45fdSRqFevRU94McQnvayipUFhCheSO3S47+LhzPnCMr5sbejT3Fu4T//Xhf/SLPsRNN7
 Cpxuh9RC7R2i+5mthg6edRIrXwAbfrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733881636;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gv21yoQhT/8sB5xLz/LvoAOFhXBIx/Kd8G1aglwqaXs=;
 b=FXV4mr2cMGxJ2GviBtOeLA1rWotrdHybq/yGH0niGJrJ+Ya3NPVh9pFSO5+kxml/HNmi2U
 IUVEnLMTWuQ/4nCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F37E13695;
 Wed, 11 Dec 2024 01:47:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id d/BRCiTvWGd2VQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 11 Dec 2024 01:47:16 +0000
Date: Wed, 11 Dec 2024 02:47:10 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "Ricardo B. Marliere" <rbm@suse.com>
Message-ID: <20241211014710.GC383036@pevik>
References: <20241210-convert_mmap01-v4-1-c2338a2ca071@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241210-convert_mmap01-v4-1-c2338a2ca071@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] mmap01: Convert to new API
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

Hi Ricardo,

...
> +static void run(void)
>  {
> +	pid_t pid;
> +
> +	addr = SAFE_MMAP(NULL, page_sz, PROT_READ | PROT_WRITE,
> +			 MAP_FILE | MAP_SHARED, fildes, 0);
> +
> +	/*
> +	 * Check if mapped memory area beyond EOF are zeros and changes beyond
> +	 * EOF are not written to file.
> +	 */
> +	if (memcmp(&addr[file_sz], dummy, page_sz - file_sz))
> +		tst_brk(TFAIL, "mapped memory area contains invalid data");
FYI test fails when run more iterations (e.g. -i2)

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
