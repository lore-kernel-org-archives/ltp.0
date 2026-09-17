Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BD2C88E72
	for <ltp@archiver.kernel.org>; Thu, 17 Sep 2026 14:24:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0FA443E7604
	for <ltp@archiver.kernel.org>; Thu, 17 Sep 2026 16:24:17 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA1403E757D
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 16:24:01 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 26773600A29
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 16:24:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8F13421D80;
 Thu, 17 Sep 2026 14:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789655035;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bZEINPUGrukWsMvAwF1J8SOMbda+wSBjjZyxfEDyRok=;
 b=ztfAWhytySQDgtR3CZVNWznFEqqIiGMAKDj80sJyaSfvsMia1q0njYJ+zzwneqgb4ponjl
 TRzkK7nayRy/vQTxChW7maIc9xPvprnn/C83YijNbjt6wDNfo5XsgkVDzrCcx+in4xRYFP
 z7gtPpmviX1QE8yrgpWcq2hinnXa1m0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789655035;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bZEINPUGrukWsMvAwF1J8SOMbda+wSBjjZyxfEDyRok=;
 b=3IVO4L/Fqm0ygzX8jq6CMBdBJLxdWBQm9jLbgxz3138Q9I5tC0NkMmASTWJnCLO2Whz/I4
 xsoDccd5KTZvBtDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hQJgDQcP;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fOAVLqVL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789655031;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bZEINPUGrukWsMvAwF1J8SOMbda+wSBjjZyxfEDyRok=;
 b=hQJgDQcPCNFaB2p2fwAfjutixMdNFoBhIigI5Bzks7vXITvjLPnl2lqOXOsSzJZzNSeUqH
 n/i0Rj9a1mXSJ9TciWGLLBr2qfOllOxB74f/iHW06cQxQKLUUEbqhoRTNIpAAf0WjGsupe
 ejEgW6b+gcDj8/UTPZFmqW5Etf/sNMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789655031;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bZEINPUGrukWsMvAwF1J8SOMbda+wSBjjZyxfEDyRok=;
 b=fOAVLqVLOtbAGO/LIomrM2dg7VjtjBMYE/nRWbO2XiZMGoNNiwrU4pfV97sQlTKCbZWdpi
 6AonfscuX79r5wCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F6D6134B3;
 Thu, 17 Sep 2026 14:23:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dE4hBvf3q2qYfQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 17 Sep 2026 14:23:51 +0000
Date: Thu, 17 Sep 2026 16:23:45 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Gaurav Pathak <gpathak@suse.de>
Message-ID: <20260917142345.GB1856601@pevik>
References: <20260917025657.327887-1-gpathak@suse.de>
 <20260917105304.9674-1-gpathak@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260917105304.9674-1-gpathak@suse.de>
X-Rspamd-Queue-Id: 8F13421D80
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/statx13: Add basic test for
 STATX_WRITE_ATOMIC on regular file
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
Cc: Gaurav Pathak <gaurav.pathak@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> This patch adds a new test to validate these atomic write limit fields.
> The test ensures the filesystem correctly advertises the STATX_ATTR_WRITE_ATOMIC
> attribute when queried on a file opened with O_DIRECT. It also verifies that the
> reported optimized maximum is logically consistent by falling within the
> absolute minimum and maximum boundaries. Furthermore, it checks that all
> reported atomic write unit sizes are valid powers of two, adhering to the strict
> requirements of the kernel block layer.

> If the underlying storage hardware or filesystem lacks atomic write
> support, the test gracefully skips with TCONF.

> Fixes: #1224
...
> diff --git a/testcases/kernel/syscalls/statx/statx13.c b/testcases/kernel/syscalls/statx/statx13.c
> new file mode 100644
> index 000000000..ea42a102c
> --- /dev/null
> +++ b/testcases/kernel/syscalls/statx/statx13.c
...
> +#ifdef HAVE_STRUCT_STATX_STX_ATOMIC_WRITE_UNIT_MAX_OPT
Looking at this, I wonder why this and also older statx10.c, statx11.c does not
use ltp_statx added by Andrea in d89a232a7b ("Add SAFE_STATX macro")

Kind regards,
Petr

> +	if (buff.stx_atomic_write_unit_max_opt == 0) {
> +		tst_res(TINFO, "stx_atomic_write_unit_max_opt is 0 (no optimized max reported)");
> +	} else {
> +		if (buff.stx_atomic_write_unit_max_opt > buff.stx_atomic_write_unit_max)
> +			tst_res(TFAIL, "stx_atomic_write_unit_max_opt (%u) exceeds max (%u)",
> +					buff.stx_atomic_write_unit_max_opt,
> +					buff.stx_atomic_write_unit_max);
> +
> +		else if (buff.stx_atomic_write_unit_max_opt < buff.stx_atomic_write_unit_min)
> +			tst_res(TFAIL, "stx_atomic_write_unit_max_opt (%u) is less than min (%u)",
> +					buff.stx_atomic_write_unit_max_opt,
> +					buff.stx_atomic_write_unit_min);
> +		else
> +			tst_res(TPASS, "stx_atomic_write_unit_max_opt (%u) is within valid range [%u, %u]",
> +					buff.stx_atomic_write_unit_max_opt,
> +					buff.stx_atomic_write_unit_min,
> +					buff.stx_atomic_write_unit_max);
> +
> +		if (__builtin_popcount(buff.stx_atomic_write_unit_max_opt) != 1)
> +			tst_res(TFAIL, "stx_atomic_write_unit_max_opt (%u) is not a power of 2",
> +					buff.stx_atomic_write_unit_max_opt);
> +	}
> +#else
> +	tst_res(TCONF, "stx_atomic_write_unit_max_opt is not defined in struct statx");
> +#endif
> +}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
