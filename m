Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7528606A323
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 15:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=gXwqEiXO;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=saRa36j9;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Ybjc7rP4;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8RjXnmx5
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 741E43EAF73
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 17:41:07 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 15F423E291B
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 17:40:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8E8271400BC8
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 17:40:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E194D21BE1;
 Tue, 20 Oct 2026 15:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792510851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6U23XNhLQb+7+9kvgA8uExJRoo2x0p1yphfc7b1xfjw=;
 b=gXwqEiXOCK+pAd0RsSwnNtQ67z04NnQEBYN7I9ZPZqCIALO4SrQ4k7AQguS8DdfqdbeamG
 SYeNNzH+JB1zaWKM0eM/+0xmKlNpRDq/MoNXALblU2x8Uy7V+Fv0aKCGBSZB7P0cx80pTN
 MBCE4a999r8TtpiztEwZOWZBfcSLQlk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792510851;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6U23XNhLQb+7+9kvgA8uExJRoo2x0p1yphfc7b1xfjw=;
 b=saRa36j9w672gluyI3WHizZrw6mwxDok7KCu3PZdSDbfZbVgpGD9yXznSVAW1fpVx56sMu
 XxW5I5rWNafHv9CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792510850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6U23XNhLQb+7+9kvgA8uExJRoo2x0p1yphfc7b1xfjw=;
 b=Ybjc7rP42pGqRPhxRwtYq5HcT/Sdf8SqbWTLCMzCXYbI5w0vBa3D0R2WcICMZsrB+SrjEh
 /ULqLdXpvavudPBr/qiFaR41JhU5jV2Epl9IndQDMB48MHQYItNHC1vnDOCfO+VXKSa+Wv
 TzvZWKlVoAX0hJs1ULGsNh+9yJaFQps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792510850;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6U23XNhLQb+7+9kvgA8uExJRoo2x0p1yphfc7b1xfjw=;
 b=8RjXnmx557ZApPqB98s1dBjhJ857enGTqz0CKGp7FqTUwoG0qsdKYbCDCxDVehlqbQsY4f
 A+Q3j8nfgkS64SDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF024136C6;
 Tue, 20 Oct 2026 15:40:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iowGIoKL12oBDQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 20 Oct 2026 15:40:50 +0000
Date: Tue, 20 Oct 2026 17:41:06 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ateLkrRHX80CVc1L@yuki.lan>
References: <20261020-fchroot-v5-0-63aa6faff503@suse.com>
 <20261020-fchroot-v5-12-63aa6faff503@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261020-fchroot-v5-12-63aa6faff503@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]
X-Spam-Score: -8.30
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 12/14] fchroot11: test failfs entry with
 no_new_privs
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +static void run(void)
> +{
> +	int status;
> +	pid_t pid;
> +
> +	if (SAFE_FORK())
> +		return;
> +
> +	SAFE_SETRESUID(ltpuser->pw_uid, ltpuser->pw_uid,
> +		ltpuser->pw_uid);
> +
> +	SAFE_PRCTL(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
> +
> +	pid = SAFE_FORK();
> +	if (!pid) {
> +		if (unshare(CLONE_NEWUSER) == -1)
> +			exit(1);
> +		return;

It would be a bit cleaner to do the unpriviledged user namespace
support probe in setup. But that is minor.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
