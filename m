Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B534C54EE9
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 06:26:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D69E3CA8B0
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 08:26:29 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 27CA43CA4D7
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 08:26:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4CAF01A003D6
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 08:26:18 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7A3C033F86;
 Fri,  2 Sep 2022 06:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1662099977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VfcQK9zgl/7/JmCjSsB+6BF18v+kzOOWAdhMdUbcPGw=;
 b=KXeHC+Hb8ykP+6OWLK1MXN4hL6Q5zjd8nb+T4G/VCz56yqLE7KOPtmiK4cAo26aaUG8iSY
 2bUFCLrt2t2pW9R0d/fW1BgxWRTzxuy0AIYqzXB91Yb2zWSb9AZFgyUIf73BgkWVbdVk06
 o1W4LQjPDeQW2JUt9MoLwOfQikTwDmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1662099977;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VfcQK9zgl/7/JmCjSsB+6BF18v+kzOOWAdhMdUbcPGw=;
 b=Fj0jkQglD7LSJm7cWgIGK3m87WBIIjKpKgLL1itAbhoWcuNAmB6aT0a7QuxdU7J3kngrvx
 6Evf6lP4+I7o5dBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B2AAA1330E;
 Fri,  2 Sep 2022 06:26:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CmzXHAiiEWNoRgAAMHmgww
 (envelope-from <akumar@suse.de>); Fri, 02 Sep 2022 06:26:16 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it, Petr Vorel <pvorel@suse.cz>
Date: Fri, 02 Sep 2022 11:56:14 +0530
Message-ID: <1738963.VLH7GnMWUR@localhost>
Organization: SUSE
In-Reply-To: <YxBWRndhRQRF69Cl@pevik>
References: <20220715061548.11574-1-akumar@suse.de> <YxBWRndhRQRF69Cl@pevik>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On Thursday, September 1, 2022 12:20:46 PM IST Petr Vorel wrote:
> Hi Avinesh,
> 
> > +++ b/testcases/kernel/syscalls/unlink/unlink07.c
> > @@ -3,15 +3,17 @@
> >   * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
> Maybe adding copyright?
> >   */
> 
> > +/*\
> > + * [Description]
> > + *
> > + * Verify that unlink() fails with
> > + * - ENOENT when file does not exist.
> > + * - ENOENT when pathname is empty.
> > + * - ENOENT when a component in pathname does not exist.
> > + * - EFAULT when pathname points outside the accessible address space.
> > + * - ENOTDIR when a component used as a directory in pathname is not,
> > + * in fact, a directory.
> > + * - ENAMETOOLONG when pathname is too long.
> I'd remove dot in the end.
> I don't like 'when', but I don't know anything better.
> >   */
> 
> >  #include <errno.h>
> > @@ -39,21 +41,9 @@ static void verify_unlink(unsigned int n)
> >  {
> >  	struct test_case_t *tc = &tcases[n];
> 
> > -	TEST(unlink(tc->name));
> > -	if (TST_RET != -1) {
> > -		tst_res(TFAIL, "unlink(<%s>) succeeded unexpectedly",
> > -			tc->desc);
> > -		return;
> > -	}
> > -
> > -	if (TST_ERR == tc->exp_errno) {
> > -		tst_res(TPASS | TTERRNO, "unlink(<%s>) failed as expected",
> > -			tc->desc);
> > -	} else {
> > -		tst_res(TFAIL | TTERRNO,
> > -			"unlink(<%s>) failed, expected errno: %s",
> > -			tc->desc, tst_strerrno(tc->exp_errno));
> > -	}
> > +	TST_EXP_FAIL(unlink(tc->name),
> > +				tc->exp_errno,
> > +				"%s", tc->desc);
> This should be on single line.
> >  }
> 
> >  static void setup(void)
> 
> Other proposed changes:
> 
> * PATH_MAX is in limits.h + we usually don't put comments why it's included:
> -#include <sys/param.h>	/* for PATH_MAX */
> +#include <limits.h>
> 
> * use size_t in setup
>  static void setup(void)
>  {
> -	unsigned int n;
> +	size_t n;
> 
> BTW it'd build just with #include "tst_test.h", because all 4 headers are
> included by headers which tst_test.h includes.
> 
> I guess most of that it applies to your patch unlink08.c as well, could you
> please send v2?
Thank you for the review, I have incorporated your suggestions and sent v2.
> 
> Kind regards,
> Petr
> 

Regards,
Avinesh




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
