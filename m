Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44D9C77B75
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 11:24:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D29D3CBEC3
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 13:24:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5E8283CB329
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 13:24:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 84D271A00251
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 13:24:41 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BF02021976;
 Fri, 21 Apr 2023 11:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682076280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mE4OFgFMr/O2i2CytRPLHAdtCVLYQT4egAqTavjb8Ck=;
 b=MlI+KQctSPuHhIZDW4YxqM51bieH55aXyyLbUtIXIuJKRnjMdU+IGzlkNgBblxf1b1Azsz
 E2LlDQknKj8jxvGUdhAFbSWXT95U+EDEF+bdssTbUbSzZVTkqIx4eCngq/LoQ4HpQlq1gS
 T9w1jG+6N4rHVgjLOGXdbS38tvFL+ZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682076280;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mE4OFgFMr/O2i2CytRPLHAdtCVLYQT4egAqTavjb8Ck=;
 b=Y+sVgb2kNs6dvG1bwLH2WVkjgppHN3tjf3glcT0uroJldY7IM5Lkj3vlGg5r9b0cew5NsU
 xFsuqh2YtKewZWDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ADBDD13456;
 Fri, 21 Apr 2023 11:24:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id emumKXhyQmTWEQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 21 Apr 2023 11:24:40 +0000
Date: Fri, 21 Apr 2023 13:25:45 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: zenghao <crawler2015@163.com>
Message-ID: <ZEJyud8Yxb1QdZbh@yuki>
References: <3620f7c2.2af5.18768f7ce86.Coremail.crawler2015@163.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3620f7c2.2af5.18768f7ce86.Coremail.crawler2015@163.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Subject: [PATCH] fs/doio:Use the snprintf function to
 prevent buffer overflow
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> From 044a942863dc0ac84701bc14d78f4d7fc0bb8dcb Mon Sep 17 00:00:00 2001
> From: Hao Zeng <zenghao@kylinos.cn>
> Date: Mon, 10 Apr 2023 09:17:34 +0800
> Subject: [PATCH] fs/doio:Use the snprintf function to prevent buffer over=
flow
> =A0Use the snprintf function instead of sprintf in the write_log.c file
> =A0Signed-off-by: Hao Zeng <zenghao@kylinos.cn>

The actual change looks good, however the patch is corrupted, looks like
your email client replaced spaces 0x20 with unicode non-breakable spaces
0xc2a0.

See: https://www.kernel.org/doc/html/v4.10/process/email-clients.html

> ---
> =A0testcases/kernel/fs/doio/write_log.c | 20 ++++++++++----------
> =A01 file changed, 10 insertions(+), 10 deletions(-)
> =

> =

> diff --git a/testcases/kernel/fs/doio/write_log.c b/testcases/kernel/fs/d=
oio/write_log.c
> index e8ef9c7cb..86297b01d 100644
> --- a/testcases/kernel/fs/doio/write_log.c
> +++ b/testcases/kernel/fs/doio/write_log.c
> @@ -129,7 +129,7 @@ int wlog_open(struct wlog_file *wfile, int trunc, int=
 mode)
> =A0	umask(omask);
> =A0
> =A0	if (wfile->w_afd =3D=3D -1) {
> -		sprintf(Wlog_Error_String,
> +		snprintf(Wlog_Error_String,sizeof(Wlog_Error_String),
                                           ^
					   There should be space after
					   comma.

-- =

Cyril Hrubis
chrubis@suse.cz

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
