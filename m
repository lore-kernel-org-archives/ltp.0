Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46616C46CD2
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 18:17:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 90D1B3CD0F5
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 19:17:51 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B9213C9207
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 19:17:35 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7C4AD601BA6
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 19:17:33 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 19CEA2205B;
 Wed, 24 Jan 2024 18:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706120253;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c5Z2CuKjsdVnxLvz/vWAr04e0SPwgIsdyGOuNmSr6jU=;
 b=ImQUaZF4wbJtiOn9W3y6BDvprdi+N3qBRVQj8o9Jfav7Crkt0gO11gnk4Cd7P22w5ZG7q0
 OmL2qI4WyaDlSwaSg2YTJ6/gxAqkH33X9Sk/xL/8dGicM3MGXKPfqKjtoYcqrfQ5rZGXIv
 hsrXjAUikRfFoNDFPXhgUkryhOaf55Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706120253;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c5Z2CuKjsdVnxLvz/vWAr04e0SPwgIsdyGOuNmSr6jU=;
 b=Vpk0UYqEXJsChqghTFMRkvmHZZarBWFzcU1W9FOHDv2VXcHDjICZXnl+WWQn2nbQ93y8Q4
 yiZrYb6pqaTm/YDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706120252;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c5Z2CuKjsdVnxLvz/vWAr04e0SPwgIsdyGOuNmSr6jU=;
 b=23HGknbNZGcuXv4x1Ntssiu6Bz8Ak0yID5UpKGW0Xx1bD/xLx3xhpXOmLfULMGdKI7oBmr
 dU20LMSiI+WuV+vMXIsi8Bwz1v5LhaOLxu5lAkqlv9ehHO5Z8UL+bGvylKsaYnr4Cb9Cx3
 9umBDBLpzLLi/e7931j4CU2hADcEe28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706120252;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c5Z2CuKjsdVnxLvz/vWAr04e0SPwgIsdyGOuNmSr6jU=;
 b=mhEuO3ROxHqu0IKsbIq2j7d7367CbF9J1LEKSehjVy71tkWf6Obb1KQ8IMZGsRSYYyUZES
 WLsTjS1kwfgn15Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D54141333E;
 Wed, 24 Jan 2024 18:17:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id J7m6MDtUsWUpRQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 24 Jan 2024 18:17:31 +0000
Date: Wed, 24 Jan 2024 19:17:29 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240124181729.GA333483@pevik>
References: <20240124044548.2652626-1-liwang@redhat.com>
 <20240124044548.2652626-6-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240124044548.2652626-6-liwang@redhat.com>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=23HGknbN;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mhEuO3RO
X-Spamd-Result: default: False [-2.51 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 19CEA2205B
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH V4 5/6] libswap: Introduce file contiguity check
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

> This patch introduces a new function file_is_contiguous to the
> libltpswap library to determine if a swap file is stored in a
> contiguous block of disk space, which is a typical requirement
> for swap files in Linux. The function performs a series of checks
> using the fiemap structure to assess the contiguity of the file
> and logs the result.

> It is integrated into the is_swap_supported function to replace
> the previous tst_fibmap check, providing a more reliable method
> for verifying that a file suitable for swap is indeed contiguous.

...
> +static int file_is_contiguous(const char *filename)
> +{
> +	int fd, contiguous = 0;
> +	struct fiemap *fiemap;
> +
> +	if (tst_fibmap(filename) == 0) {
> +		contiguous = 1;
> +		goto out;
> +	}
> +
> +	if (tst_fs_type(filename) == TST_TMPFS_MAGIC) {
> +		contiguous = 0;
nit: contiguous is already 0. Also I like that tst_fibmap is tested first (in
case tmpfs gets that support one day.
> +		goto out;
> +	}
> +
> +	fd = SAFE_OPEN(filename, O_RDONLY);
> +
> +	fiemap = (struct fiemap *)SAFE_MALLOC(sizeof(struct fiemap) + sizeof(struct fiemap_extent));
> +	memset(fiemap, 0, sizeof(struct fiemap) + sizeof(struct fiemap_extent));
> +
> +	fiemap->fm_start = 0;
> +	fiemap->fm_length = ~0;
> +	fiemap->fm_flags = 0;
> +	fiemap->fm_extent_count = 1;
> +
> +	SAFE_IOCTL(fd, FS_IOC_FIEMAP, fiemap);
> +
> +	/*
> +	 * fiemap->fm_mapped_extents != 1:
> +	 *   This checks if the file does not have exactly one extent. If there are more
> +	 *   or zero extents, the file is not stored in a single contiguous block.
> +	 *
> +	 * fiemap->fm_extents[0].fe_logical != 0:
> +	 *   This checks if the first extent does not start at the logical offset 0 of
> +	 *   the file. If it doesn't, it indicates that the file's first block of data
> +	 *   is not at the beginning of the file, which implies non-contiguity.
> +	 *
> +	 * (fiemap->fm_extents[0].fe_flags & FIEMAP_EXTENT_LAST) != FIEMAP_EXTENT_LAST:
> +	 *   This checks if the first extent does not have the FIEMAP_EXTENT_LAST flag set.
> +	 *   If the flag isn't set, it means that this extent is not the last one, suggesting
> +	 *   that there are more extents and the file is not contiguous.
> +	 */

Interesting, thanks for the doc!

LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
