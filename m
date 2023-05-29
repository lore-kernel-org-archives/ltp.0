Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0C9C7EE2C
	for <ltp@archiver.kernel.org>; Mon, 29 May 2023 18:20:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 56D2A3CD000
	for <ltp@archiver.kernel.org>; Mon, 29 May 2023 20:20:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2029A3CCFCB
 for <ltp@lists.linux.it>; Mon, 29 May 2023 20:20:40 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 87C1C1A002F5
 for <ltp@lists.linux.it>; Mon, 29 May 2023 20:20:39 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1696921A3C;
 Mon, 29 May 2023 18:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1685384438;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ftFmXSGS0xEuGkfNzWjQlf/iXoukbCKoWsPiyNKc1uw=;
 b=Bnw26i5GMPNKh32OgmyU0ZhyDY2TjNOnIUsTTJ6+9+K/Xyq9Iknua8TrjN8nqfauJ+2KQy
 7OEsxYNN4xdMRgEo1/+Zbq6y6lBwmQHvl4+LgeqLhB/BzbFnP4PhaTM9xx0P4NjisXRH5p
 EIc1ZBkyL3ZBxhqpx19SJ6QsOUqMBKs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1685384438;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ftFmXSGS0xEuGkfNzWjQlf/iXoukbCKoWsPiyNKc1uw=;
 b=V1Zl+CrvF3v1puLfJzRHOgOERt0PUcomr/6bgDDMO4RITu7JoA+mmO/lOCwH5s8tYV0VvS
 F/HiX5MDYvmQdLAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E717F13466;
 Mon, 29 May 2023 18:20:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id i/aKNPXsdGSpbgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 29 May 2023 18:20:37 +0000
Date: Mon, 29 May 2023 20:20:35 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <20230529182035.GB17253@pevik>
References: <20230427120800.27849-1-akumar@suse.de>
 <20230427120800.27849-5-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230427120800.27849-5-akumar@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/5] dup05.c: use TST_EXP_FD() macro and make
 check fixes
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

I slightly modified some of the commits and merged the patchset.
Thanks!

> + update copyright.
> + use SAFE_OPEN() and SAFE_CLOSE()


...
>  /*\
> - * [DESCRIPTION]
> + * [Description]
+1

>   *
>   * Basic test for dup(2) of a named pipe descriptor
>   */
> -#include <stdio.h>
> +
>  #include "tst_test.h"

> -char Fname[255];
> -int fd;
> +#define Fname "dupfile"
FYI I renamed to FNAME (don't hesitate to rename constants which aren't
lowercase or variables with very long name (expected_errno => exp_err - used
widely in LTP).

> +
> +static int fd;

>  static void run(void)
>  {
> -	TEST(dup(fd));
> -
> -	if (TST_RET == -1) {
> -		tst_res(TFAIL | TTERRNO, "dup failed");
> -	} else {
> -		tst_res(TPASS, "dup returned %ld",
> -			 TST_RET);
> -
> -		SAFE_CLOSE(TST_RET);
> -	}
> +	TST_EXP_FD(dup(fd), "dup(%d)", fd);
> +	SAFE_CLOSE(TST_RET);
>  }

> -void setup(void)
> +static void setup(void)
>  {
>  	fd = -1;
FYI I moved -1 to declaration:
static int fd = -1;

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
