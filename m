Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE9DCC5AD5A
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 11:07:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 087453E6C9E
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 13:07:16 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 749E23DC3E9
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 13:07:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C3F29140017D
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 13:06:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A43E23E54;
 Wed, 12 Aug 2026 11:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786532814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SZh6qyHSm+gO1dVAZ7fnVFS7EBGpCi3MoDxE6SM2OEw=;
 b=aCz8uGJk+88eT06qO4ZNJSBtOgkIgodlMh9LlNAnLl1+bxCJBosXHjPNj8B+4jeM0U+lWn
 MfMiPCQUcTvV4pIybiIKYvZk9m/JrtKW403G6Z/R1L4El31yELVjNAHkiZqhLZmVft3lDR
 RNrf7d56sa6fkicA1dFcPxVBf4CTk1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786532814;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SZh6qyHSm+gO1dVAZ7fnVFS7EBGpCi3MoDxE6SM2OEw=;
 b=kwjpUamzCOtHu7at4jl6hcXUDma3GfSLCzP1yWSByoUUeplY9W3hlzDv4EKsTCw7uy9AYd
 krtKtRm5mtQEoDDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kPPWQ5PN;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=SSUhypOJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786532810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SZh6qyHSm+gO1dVAZ7fnVFS7EBGpCi3MoDxE6SM2OEw=;
 b=kPPWQ5PN658GM6SFbLIHo9yoOJ74IgYfvkA/nyKXY8f6zZaaZJyRKsofLJ5sW6i0XnF/fg
 kEcXthdS5zy8PSXI/XgP33YGd8UGLb0mL5e9IjIwY3O7dHPmbDOeNCIf5DSaW/T3JHxW/6
 Uf39d5ysGi8ZOwVf5+ro13nDVSFb0TI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786532810;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SZh6qyHSm+gO1dVAZ7fnVFS7EBGpCi3MoDxE6SM2OEw=;
 b=SSUhypOJuVJ9NFhKkA64+dZxkzHES5hoh+WQUyTCmvNTYp6WCXpXZdK2rDGHAcDeKWDIyR
 AICjZzPad0R9YLDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93EB5779B1;
 Wed, 12 Aug 2026 11:06:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3QLEIspTfGoTWgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 12 Aug 2026 11:06:50 +0000
Date: Wed, 12 Aug 2026 13:06:49 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <anxTyVyeeMo6EQfG@yuki.lan>
References: <20260810160048.1040517-1-pvorel@suse.cz>
 <20260810160048.1040517-4-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260810160048.1040517-4-pvorel@suse.cz>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,yuki.lan:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: A43E23E54
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 3/7] lib: Add support for max_kver to struct
 tst_test and tst_fs
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
> diff --git a/include/tst_test.h b/include/tst_test.h
> index c69362485e..30c32b844e 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -280,6 +280,9 @@ struct tst_ulimit_val {
>   *
>   * @min_kver: A minimum kernel version supporting the filesystem which has been
>   *            created with mkfs.
> + *
> + * @max_kver: A maximum kernel version supporting the filesystem which has been
> + *            created with mkfs.
>   */
>  struct tst_fs {
>  	const char *type;
> @@ -292,6 +295,7 @@ struct tst_fs {
>  	const void *mnt_data;
>  
>  	const char *min_kver;
> +	const char *max_kver;

Also I would consider not adding this, it may feel like we are
completing something, but in reality we are adding interface that is
very unlikely to be ever used.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
