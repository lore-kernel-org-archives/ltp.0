Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29AAC0032E
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 00:12:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D65CD3CF902
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 02:12:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E41753CCB57
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 02:12:22 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 17FCE600A57
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 02:12:21 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1522821A5F;
 Thu, 26 Oct 2023 00:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698279139;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lzzsHyeE8cp3xwhQOzgn9g6oDTLOQon5rk7WjMCWrw8=;
 b=cpeCbuoWQBdyebTISMVU40rSnFLF56CYjexs4oGM3NYBseXCaZHTByThHLAWqJ56EMG0cx
 EJl2TtS5AqGrIIrH2Rdz/TFjSBa02KffZYuZ/AdhSBt7DuO2hoom9PjsOKBxLvlXratCI6
 sWn9oSOwrDtffpjoaB/o5HmycYJE04Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698279139;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lzzsHyeE8cp3xwhQOzgn9g6oDTLOQon5rk7WjMCWrw8=;
 b=yMMfI2Ygs7B8Lowe0l0ibAl0+W+3Se6uflx+vbodBRe/O1G+Wz8LV/jVW2aextJdoudMDO
 XcF8g7ZqEV4OqPCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F024413398;
 Thu, 26 Oct 2023 00:12:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UjZCOeKuOWWFZQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 26 Oct 2023 00:12:18 +0000
Date: Thu, 26 Oct 2023 02:12:17 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20231026001217.GD540370@pevik>
References: <1697100058-2859-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1697100058-2859-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1697100058-2859-2-git-send-email-xuyang2018.jy@fujitsu.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-6.27 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.97)[99.89%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] umount02: Simplify test using TST_ macros
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

> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  testcases/kernel/syscalls/umount/umount02.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)

> diff --git a/testcases/kernel/syscalls/umount/umount02.c b/testcases/kernel/syscalls/umount/umount02.c
> index 34a38c998..40fed1fbd 100644
> --- a/testcases/kernel/syscalls/umount/umount02.c
> +++ b/testcases/kernel/syscalls/umount/umount02.c
> @@ -2,6 +2,7 @@
>  /*
>   * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
>   * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
> + * Copyright (c) Linux Test Project, 2003-2023
>   * Author: Nirmala Devi Dhanasekar <nirmala.devi@wipro.com>
>   *
>   * Check for basic errors returned by umount(2) system call.
> @@ -41,21 +42,14 @@ static void verify_umount(unsigned int n)
>  {
>  	struct tcase *tc = &tcases[n];

> -	TEST(umount(tc->mntpoint));
> -
> -	if (TST_RET != -1) {
> -		tst_res(TFAIL, "umount() succeeds unexpectedly");
> -		return;
> -	}
> +	TST_EXP_FAIL(umount(tc->mntpoint), tc->exp_errno,
> +		     "umount() fail with %s", tc->err_desc);

I'd prefer just:
TST_EXP_FAIL(umount(tc->mntpoint), tc->exp_errno);

>  	if (tc->exp_errno != TST_ERR) {
>  		tst_res(TFAIL | TTERRNO, "umount() should fail with %s",
>  			tst_strerrno(tc->exp_errno));
>  		return;
>  	}
Also this is redundant and should be removed.
With it removed you may add:
Reviewed-by: Petr Vorel <pvorel@suse.cz>

nit: #include <string.h> could be removed.
Also doc could be converted to docparse.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
