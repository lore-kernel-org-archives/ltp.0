Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4720C25B47
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 00:05:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 272F83CF4D9
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 02:05:54 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA0203CB596
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 02:05:42 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 595A0200905
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 02:05:41 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B6CBD1FD68;
 Thu, 26 Oct 2023 00:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698278740;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PFBA6H+ezpxX7YjAQLIDxRXuCp5EdDvUxhdJTUOe9wY=;
 b=RXsGdnl6zMmeRUs5Br4ssNJwd47+WN+3EFUIZTcXgcI7GsCqgX5Sz4sc5BTx1HCy24mmdl
 Z5SMMwAX7DPSlVz2K0oIErPpAXJ27rcgdoKhRNS0oXb48fVLZ6RpcCjxEZUSSjNnQzapG5
 78hn2IeJwaY6Eu0Zj9HgrSd77//71U0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698278740;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PFBA6H+ezpxX7YjAQLIDxRXuCp5EdDvUxhdJTUOe9wY=;
 b=XKF9zEORhDExrVWbISjZ4cb63baN+ETVSy2B/iyawYvzXprrr7luz5SjNsNyKWEGI/1Eyv
 Sre0d8qoZY+vFbDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C0EF13398;
 Thu, 26 Oct 2023 00:05:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rFFXJFStOWVuYwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 26 Oct 2023 00:05:40 +0000
Date: Thu, 26 Oct 2023 02:05:39 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20231026000539.GB540370@pevik>
References: <1697100058-2859-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1697100058-2859-3-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1697100058-2859-3-git-send-email-xuyang2018.jy@fujitsu.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-5.94 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.64)[98.42%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] umount03: Simplify test using TST_ macros
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

> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  testcases/kernel/syscalls/umount/umount03.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)

this is not needed:
#include <errno.h>

This is for all 3 patches.

> diff --git a/testcases/kernel/syscalls/umount/umount03.c b/testcases/kernel/syscalls/umount/umount03.c
> index 1cef06fa1..e6bb523b4 100644
> --- a/testcases/kernel/syscalls/umount/umount03.c
> +++ b/testcases/kernel/syscalls/umount/umount03.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
> + * Copyright (c) Linux Test Project, 2003-2023
>   * Author: Nirmala Devi Dhanasekar <nirmala.devi@wipro.com>
>   *
>   * Verify that umount(2) returns -1 and sets errno to  EPERM if the user
> @@ -20,19 +21,12 @@ static int mount_flag;

>  static void verify_umount(void)
>  {
> -	TEST(umount(MNTPOINT));
> -
> -	if (TST_RET != -1) {
> -		tst_res(TFAIL, "umount() succeeds unexpectedly");
> -		return;
> -	}
> +	TST_EXP_FAIL(umount(MNTPOINT), EPERM, "umount(%s) Failed", MNTPOINT);
nit: I would prefer just:

	TST_EXP_FAIL(umount(MNTPOINT), EPERM);


>  	if (TST_ERR != EPERM) {
>  		tst_res(TFAIL | TTERRNO, "umount() should fail with EPERM");
>  		return;
>  	}
This should have been removed, it's redundant when TST_EXP_FAIL() is done.
> -
> -	tst_res(TPASS | TTERRNO, "umount() fails as expected");
>  }

>  static void setup(void)

With <errno.h> and if (TST_ERR != EPERM) removed you can add:
Reviewed-by: Petr Vorel <pvorel@suse.cz>

It would be good (as a separate commit) to reword the documentation and convert
it to docparse. Feel free to do it, or please let me know if I should do it.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
