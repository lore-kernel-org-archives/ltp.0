Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C48606A31A
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 15:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=DmFEs8GA;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=QeYd4aGh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=DmFEs8GA;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=QeYd4aGh
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 78AD23D26E1
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 17:45:00 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E10803D26CD
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 17:44:44 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 51C88140021E
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 17:44:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BFA6E21F4F;
 Thu, 22 Oct 2026 15:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792683882;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pLRYfOJc3rzEGXbWlKP0OCPxqmkHok2laHz68ncdf4s=;
 b=DmFEs8GAU25VBiyoYd3QBtrdvgaJRF3ijiQES+Y2L1P1DeVpDRsZnZdOkiMnZP1nts8DUZ
 hA/UHNieFiO3K4485FvpMtmIBZ7Kg7qWjuUjDOShBs+CoVoHUCD98B0Hsu8ob1bnQChcfr
 d2jHpDIouA9fmno79J6uUx4/mxjgRVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792683882;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pLRYfOJc3rzEGXbWlKP0OCPxqmkHok2laHz68ncdf4s=;
 b=QeYd4aGhJGwKl59y2mANXducyUwExtM3v+YFOIpLhroAIBSwcT0/2Wwv3EeWm63JXrVWxr
 MXUcm8jQoJM89aAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792683882;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pLRYfOJc3rzEGXbWlKP0OCPxqmkHok2laHz68ncdf4s=;
 b=DmFEs8GAU25VBiyoYd3QBtrdvgaJRF3ijiQES+Y2L1P1DeVpDRsZnZdOkiMnZP1nts8DUZ
 hA/UHNieFiO3K4485FvpMtmIBZ7Kg7qWjuUjDOShBs+CoVoHUCD98B0Hsu8ob1bnQChcfr
 d2jHpDIouA9fmno79J6uUx4/mxjgRVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792683882;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pLRYfOJc3rzEGXbWlKP0OCPxqmkHok2laHz68ncdf4s=;
 b=QeYd4aGhJGwKl59y2mANXducyUwExtM3v+YFOIpLhroAIBSwcT0/2Wwv3EeWm63JXrVWxr
 MXUcm8jQoJM89aAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A78D133F3;
 Thu, 22 Oct 2026 15:44:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id f+X4A2ov2moveQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 22 Oct 2026 15:44:42 +0000
Date: Thu, 22 Oct 2026 17:44:36 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20261022154436.GA419745@pevik>
References: <20261022022824.19735-1-wegao@suse.com>
 <20261022022824.19735-3-wegao@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261022022824.19735-3-wegao@suse.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-12.50 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -12.50
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v16 2/2] open16: allow restricted O_CREAT of FIFOs
 and regular files
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

...
> +static void verify_open(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +
> +	SAFE_FILE_PRINTF(PATH_FS_PROTECTED_REGULAR, "%u", n);
> +	SAFE_FILE_PRINTF(PATH_FS_PROTECTED_FIFOS, "%u", n);
> +
> +	if (tc->owner_uid != (uid_t)-1 || tc->use_nobody_gid) {
> +		gid_t gid = tc->use_nobody_gid ? gid1 : 0;
> +
> +		SAFE_CHOWN(DIR, tc->owner_uid, gid);
> +	}
> +
> +	if (tc->dir_mode)
> +		SAFE_CHMOD(DIR, tc->dir_mode);
> +
> +	if (SAFE_FORK())
> +		return;
> +
> +	SAFE_SETGID(gid1);
> +	SAFE_SETUID(uid2);
> +
> +	TST_EXP_FD_OR_FAIL(openat(dir_fd, TEST_FILE, O_RDWR | O_CREAT, 0777),
> +			   tc->exp_errno, "openat %s (sysctl_val=%u)", TEST_FILE, n);
> +	if (TST_RET != -1)
> +		SAFE_CLOSE(TST_RET);
> +
> +	TST_EXP_FD_OR_FAIL(open(TEST_FIFO_PATH, O_RDWR | O_CREAT, 0777),
> +			   tc->exp_errno, "open %s (sysctl_val=%u)", TEST_FIFO, n);
> +	if (TST_RET != -1)
> +		SAFE_CLOSE(TST_RET);
> +
> +	exit(0);

Do we need this explicit exit?

The rest LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
