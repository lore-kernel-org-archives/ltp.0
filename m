Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75260C636CD
	for <ltp@archiver.kernel.org>; Wed,  1 Feb 2023 12:25:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 06D1D3CC550
	for <ltp@archiver.kernel.org>; Wed,  1 Feb 2023 13:25:10 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 883583CB7E6
 for <ltp@lists.linux.it>; Wed,  1 Feb 2023 13:25:01 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A06631000A1D
 for <ltp@lists.linux.it>; Wed,  1 Feb 2023 13:24:59 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 89C6020E06;
 Wed,  1 Feb 2023 12:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1675254299;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gNhUCybcIhaABbq6qLovki8mNllCr0pdCmAlWgWc1/I=;
 b=goHERZA/axaAjopPJjX1GN3frmM1Fs8C+Rq1nAi2YV7iZXgI/dISsm37msqb7agrqcHqAl
 JU4fKY8YBn1ggm6nIz1l0f3uqySiC1vr8Zdo1Yb1Uh9ojWmYZNm1w32mpY6+nwP7PaqIw2
 CCbp/U92YWXVp1pAZ02GQa/zrqArcOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1675254299;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gNhUCybcIhaABbq6qLovki8mNllCr0pdCmAlWgWc1/I=;
 b=7o3g83Zv0KGkXOlcpgiMketkP4RTmEGO5LZDRMq1mesDwp10xK1m8xDMvz/vXcgU+Y3gR1
 tdCADXwSZF5CQYAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 618991348C;
 Wed,  1 Feb 2023 12:24:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7ldUFhta2mPNOQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 01 Feb 2023 12:24:59 +0000
Date: Wed, 1 Feb 2023 13:24:57 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Edward Liaw <edliaw@google.com>
Message-ID: <Y9paGafh97zKnu/j@pevik>
References: <20230131002532.459456-1-edliaw@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230131002532.459456-1-edliaw@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] close_range: check for kernel support below 5.9
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Edward,

good catch :).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> +++ b/include/lapi/close_range.h
> @@ -25,4 +25,17 @@ static inline int close_range(unsigned int fd, unsigned int max_fd,
>  	return tst_syscall(__NR_close_range, fd, max_fd, flags);
>  }
>  # endif
> +
> +static inline void close_range_supported_by_kernel(void)
> +{
> +	long ret;
> +
> +	if ((tst_kvercmp(5, 9, 0)) < 0) {
> +		/* Check if the syscall is backported on an older kernel */
BTW what particular use case this fixed? Is it backported to some android
kernel? Or to some enterprise distro? Because I don't think kernel stable trees
accept new functionality, just fixes.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
