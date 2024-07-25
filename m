Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7655FC3DA49
	for <ltp@archiver.kernel.org>; Thu, 25 Jul 2024 14:35:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD7233D1CB1
	for <ltp@archiver.kernel.org>; Thu, 25 Jul 2024 16:35:22 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC0E63D1C17
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 16:35:06 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=jack@suse.cz;
 receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CD1B01001194
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 16:35:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A792F1FC24;
 Thu, 25 Jul 2024 14:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721918104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=STqOgjYPrSihbFE1Tv+dGyn7l7r20fE7PYYy1gEhTDc=;
 b=Bke2CmGqiZaewEdNsbblkmjxkP7ep9qkNFDPNnEKeWAFnJRA/dxwo2XVL8rTnEw11Op7d1
 0CXFPHXW6OIFMBA0D0i4h86S9ZQsN4jgQF1RkCDCh/BJt7brFo1vPqASipL/LGGDvvexSo
 XTxDIrvZCbi1C6ygASuDnq7PLMk/KfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721918104;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=STqOgjYPrSihbFE1Tv+dGyn7l7r20fE7PYYy1gEhTDc=;
 b=nzNfjSUzJ1QMgyTTIQyUEEDGM0g7yzP0aizjwW6fyvB8Glh5OlkRvAWWYdzN8nIaDFLe4D
 alc755U0dK85LlCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Bke2CmGq;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nzNfjSUz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721918104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=STqOgjYPrSihbFE1Tv+dGyn7l7r20fE7PYYy1gEhTDc=;
 b=Bke2CmGqiZaewEdNsbblkmjxkP7ep9qkNFDPNnEKeWAFnJRA/dxwo2XVL8rTnEw11Op7d1
 0CXFPHXW6OIFMBA0D0i4h86S9ZQsN4jgQF1RkCDCh/BJt7brFo1vPqASipL/LGGDvvexSo
 XTxDIrvZCbi1C6ygASuDnq7PLMk/KfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721918104;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=STqOgjYPrSihbFE1Tv+dGyn7l7r20fE7PYYy1gEhTDc=;
 b=nzNfjSUzJ1QMgyTTIQyUEEDGM0g7yzP0aizjwW6fyvB8Glh5OlkRvAWWYdzN8nIaDFLe4D
 alc755U0dK85LlCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D5E81368A;
 Thu, 25 Jul 2024 14:35:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tPViJphiomZ5GAAAD6G6ig
 (envelope-from <jack@suse.cz>); Thu, 25 Jul 2024 14:35:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 5CDF5A0996; Thu, 25 Jul 2024 16:35:00 +0200 (CEST)
Date: Thu, 25 Jul 2024 16:35:00 +0200
From: Jan Kara <jack@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240725143500.k4g5e6oqcauf2533@quack3>
References: <20240724-ioctl_ficlone-v3-1-bdf7551380ee@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240724-ioctl_ficlone-v3-1-bdf7551380ee@suse.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.81 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_LAST(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: A792F1FC24
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Add ioctl_ficlone04 test
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
Cc: jack@suse.cz, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed 24-07-24 22:02:11, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> This test verifies that ioctl() FICLONE/FICLONERANGE feature raises
> the right error according with bad file descriptors.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
...
> +static void test_bad_fd(struct tst_fd *fd_src, struct tst_fd *fd_dst)
> +{
> +	if (fd_src->type == TST_FD_FILE && fd_src->type == fd_dst->type) {
> +		tst_res(TCONF, "Skipping file: SUCCESS");
> +		return;
> +	}
> +
> +	if (fd_src->type == TST_FD_MEMFD && fd_src->type == fd_dst->type) {
> +		tst_res(TCONF, "Skipping memory: EOPNOTSUPP");
> +		return;
> +	}
> +
> +	int exp_errnos[] = {
> +		EISDIR,
> +		EBADF,
> +		EINVAL,
> +		EXDEV,
> +	};

Two comments here: Sometimes security modules forbid operations on
unexpected file types and you get EPERM in that case so I'd add it to the
list of allowed error codes. Also the test for EOPNOTSUPP looks a bit
fragile to me. Currently TST_FD_MEMFD is the only fd type where we'd get as
far as checking whether the fs actually supports reflink but that could
change in the future. So I'd not special-case MEMFD and instead add
EOPNOTSUPP as another allowed error code. Otherwise the test looks good to
me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
