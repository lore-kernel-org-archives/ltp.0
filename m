Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 295CBC25B4E
	for <ltp@archiver.kernel.org>; Fri, 20 Jan 2023 07:47:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 04CB53CD731
	for <ltp@archiver.kernel.org>; Fri, 20 Jan 2023 08:47:11 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A4C093C18A6
 for <ltp@lists.linux.it>; Fri, 20 Jan 2023 08:47:00 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CA5F3600F36
 for <ltp@lists.linux.it>; Fri, 20 Jan 2023 08:46:59 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7D6EB5D90F;
 Fri, 20 Jan 2023 07:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1674200818;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sCua9QWMVlU0a8UaRQbdsO5G10mUt+dJKYq9G40ysJ4=;
 b=bK/R3h2H2tqGNnAdK5domCPz3WDuO/vqg+/t3M8xW6EAYA0/JjErqyz2gmq6/f2IQd6IHf
 vzvN3ACdxa49pSJn0gKZrL0WC//RHJVdFZBh1TvHPOcXrKDGXuNsN+sWZccBEC36eDlhRX
 lLWgrTiZV2xjJfJnIvSVxvznKca9hxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1674200818;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sCua9QWMVlU0a8UaRQbdsO5G10mUt+dJKYq9G40ysJ4=;
 b=wX7iU+h6C9DZP9wqKvNPYMt6b4lSPseKX7zzJybt877dJ3qfD1NbvYDeIQeGVkrdoNDDbr
 vFMMECfS3CuSbYAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 605971390C;
 Fri, 20 Jan 2023 07:46:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4ir5FfJGymPAdgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 20 Jan 2023 07:46:58 +0000
Date: Fri, 20 Jan 2023 08:46:56 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <Y8pG8LJURK9ysW2p@pevik>
References: <20230120061247.8361-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230120061247.8361-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] io_uring02.c: Check EOPNOTSUPP errno
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

Hi Wei,

> Add check for errno == EOPNOTSUPP and quit with TCONF instead of TBROK

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  lib/tst_safe_io_uring.c | 4 ++++
>  1 file changed, 4 insertions(+)

> diff --git a/lib/tst_safe_io_uring.c b/lib/tst_safe_io_uring.c
> index f300fd38c..923c3e43d 100644
> --- a/lib/tst_safe_io_uring.c
> +++ b/lib/tst_safe_io_uring.c
> @@ -15,6 +15,10 @@ int safe_io_uring_init(const char *file, const int lineno,
>  	uring->fd = io_uring_setup(entries, params);

>  	if (uring->fd == -1) {
> +		if (errno == EOPNOTSUPP) {
> +			tst_brk(TCONF,
> +				"io_uring_setup() is not supported");
> +		}

I merged with these changes:

		if (errno == EOPNOTSUPP)
			tst_brk(TCONF, "CONFIG_IO_URING is not enabled");

* changed subject to: "tst_safe_io_uring.c: Check EOPNOTSUPP errno"
* Adjusted commit message (no io_uring_*() syscall will be working due
  CONFIG_IO_URING not enabled in the kernel).
* simplify if style

Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
