Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD71C433EF
	for <ltp@archiver.kernel.org>; Thu,  6 Jan 2022 09:53:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E76523C2E42
	for <ltp@archiver.kernel.org>; Thu,  6 Jan 2022 10:52:59 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EAD603C078E
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 10:52:50 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7DBAA600C77
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 10:52:50 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AFCC61F37C;
 Thu,  6 Jan 2022 09:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641462769;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=03GyzhuGeyzMJ3hsNKFwiuNVhgs7iRSwWxnfdrwWUZw=;
 b=nHZkoq6VTraC+/RH5ptyImqHsOSchVIPYE/zjgA0cXSrntRTtfK9uIi1V1RLVYDmCR+WoT
 OZ7qvNRwCqEujAgU9bMVTblYeZLY0HiCeR41X7wYmqv98pFuiNA8m2MCmQgTLRLTlcKfnv
 tWrkcqVdNIUyQEpUnJ/wMj98hNbQD+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641462769;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=03GyzhuGeyzMJ3hsNKFwiuNVhgs7iRSwWxnfdrwWUZw=;
 b=Rl7wOWRm42xG+cxFGYOQqvRd6aT90BjDqJVYlIAoS3SJBoYdAMR19jM0StFdSxA/vGxosq
 zEL54B/X8bx0L4Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 81CA113C0D;
 Thu,  6 Jan 2022 09:52:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KkgXHvG71mFncgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 06 Jan 2022 09:52:49 +0000
Date: Thu, 6 Jan 2022 10:52:47 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <Yda7741pVDS/vYum@pevik>
References: <YdWsZpTjnBLszubC@pevik>
 <1641461121-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641461121-2212-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1641461121-2212-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/4] lib: Introduce LTP_KCONFIG_DISABLE
 environment variables
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

Hi Xu,

> +| 'LTP_KCONFIG_DISABLE' | Switch for kernel config check functionality.
> +                          'y' or '1': disable kconfig check,
> +                          'n' or '0': enable kconfig check.
Also, regardless if we keep it this way,  it's worth to mention the default
value.

>  int tst_kconfig_check(const char *const kconfigs[])
>  {
>  	size_t expr_cnt = array_len(kconfigs);
> @@ -485,6 +506,11 @@ int tst_kconfig_check(const char *const kconfigs[])
>  	unsigned int i, var_cnt;
>  	int ret = 0;

> +	if (tst_kconfig_disabled()) {
> +		tst_res(TINFO, "Kernel config check functionality has been disabled.");
nit: please avoid the dot :).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
