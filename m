Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702CEECAAD1
	for <ltp@archiver.kernel.org>; Thu,  1 Sep 2022 06:51:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C69403CA887
	for <ltp@archiver.kernel.org>; Thu,  1 Sep 2022 08:51:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 611923CA729
 for <ltp@lists.linux.it>; Thu,  1 Sep 2022 08:50:51 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9694F60018E
 for <ltp@lists.linux.it>; Thu,  1 Sep 2022 08:50:49 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6327E1FA74;
 Thu,  1 Sep 2022 06:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662015049;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TFyxO/5VzpMvEH4nO5FvusHR/T/L94d5+017eAGO+Gk=;
 b=I5qacdOjafn5O9WffHqiUGn7QeNvK0tcklzyT37vXvMFBBv/q+J1inSlG6tz6xB1hz48yY
 0+f4DA4Yxc0T/NeO1+yCae8umJz6KnNqhAfTfeA2u29NqRcbT/94Boyn2Rsz+fdA1dB9Um
 RMYE4EB7tHW4opGrak7SrJR6FiLbdwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662015049;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TFyxO/5VzpMvEH4nO5FvusHR/T/L94d5+017eAGO+Gk=;
 b=1TKd/qgRZ7KkuY47H+zM+OMA4JiIpf/uGrCT7lnx1B6cPwOSsXCmb4tQc53QXKi6IFJPr4
 Y2bT1j6PiJlkdJDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 43F3C139C4;
 Thu,  1 Sep 2022 06:50:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rn4/DklWEGMjKAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 01 Sep 2022 06:50:49 +0000
Date: Thu, 1 Sep 2022 08:50:46 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <YxBWRndhRQRF69Cl@pevik>
References: <20220715061548.11574-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220715061548.11574-1-akumar@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] unlink07: use TST_EXP_FAIL() and turn comment
 into docparse, reword
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

Hi Avinesh,

> +++ b/testcases/kernel/syscalls/unlink/unlink07.c
> @@ -3,15 +3,17 @@
>   * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
Maybe adding copyright?
>   */

> +/*\
> + * [Description]
> + *
> + * Verify that unlink() fails with
> + * - ENOENT when file does not exist.
> + * - ENOENT when pathname is empty.
> + * - ENOENT when a component in pathname does not exist.
> + * - EFAULT when pathname points outside the accessible address space.
> + * - ENOTDIR when a component used as a directory in pathname is not,
> + * in fact, a directory.
> + * - ENAMETOOLONG when pathname is too long.
I'd remove dot in the end.
I don't like 'when', but I don't know anything better.
>   */

>  #include <errno.h>
> @@ -39,21 +41,9 @@ static void verify_unlink(unsigned int n)
>  {
>  	struct test_case_t *tc = &tcases[n];

> -	TEST(unlink(tc->name));
> -	if (TST_RET != -1) {
> -		tst_res(TFAIL, "unlink(<%s>) succeeded unexpectedly",
> -			tc->desc);
> -		return;
> -	}
> -
> -	if (TST_ERR == tc->exp_errno) {
> -		tst_res(TPASS | TTERRNO, "unlink(<%s>) failed as expected",
> -			tc->desc);
> -	} else {
> -		tst_res(TFAIL | TTERRNO,
> -			"unlink(<%s>) failed, expected errno: %s",
> -			tc->desc, tst_strerrno(tc->exp_errno));
> -	}
> +	TST_EXP_FAIL(unlink(tc->name),
> +				tc->exp_errno,
> +				"%s", tc->desc);
This should be on single line.
>  }

>  static void setup(void)

Other proposed changes:

* PATH_MAX is in limits.h + we usually don't put comments why it's included:
-#include <sys/param.h>	/* for PATH_MAX */
+#include <limits.h>

* use size_t in setup
 static void setup(void)
 {
-	unsigned int n;
+	size_t n;

BTW it'd build just with #include "tst_test.h", because all 4 headers are
included by headers which tst_test.h includes.

I guess most of that it applies to your patch unlink08.c as well, could you
please send v2?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
