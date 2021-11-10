Return-Path: <SRS0=1g5g=P5=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4C6C433EF
	for <ltp@archiver.kernel.org>; Wed, 10 Nov 2021 10:43:14 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5171C61168
	for <ltp@archiver.kernel.org>; Wed, 10 Nov 2021 10:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5171C61168
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 26E5F3C0E91
	for <ltp@archiver.kernel.org>; Wed, 10 Nov 2021 11:43:11 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C4D4B3C091D
 for <ltp@lists.linux.it>; Wed, 10 Nov 2021 11:43:01 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8F28C60081C
 for <ltp@lists.linux.it>; Wed, 10 Nov 2021 11:43:00 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7654E21B13;
 Wed, 10 Nov 2021 10:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1636540979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bWkCKtlZbYPzRPWZC7B09QuRr7KO9KkJ8QwAmC5n+gw=;
 b=fYChZ6DjsIIx/LO0ryu9fLC2WVg80bJjDo7SwimiEs/hnaogf/elRB/DaEvEWub2Msxcla
 wCmRfkfprDma1oWHSmEdRO73KVPVg3W2lc+MM2OvMpemy9WKTe0tLDiqsNoAZrzLP7Bn7b
 8VRN16F9WDSo0qs+plPnxlv2PA2KYoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1636540979;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bWkCKtlZbYPzRPWZC7B09QuRr7KO9KkJ8QwAmC5n+gw=;
 b=+M6JeUnc/36jI3NRJJJ39vQl17u8jseQbsCitoJJPaNdJJXHJk56UZPsOZBAXwOiPECPXH
 TI9VkP4lHQSgu1AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6083013BEA;
 Wed, 10 Nov 2021 10:42:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iIGSFzOii2EwPwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 10 Nov 2021 10:42:59 +0000
Date: Wed, 10 Nov 2021 11:44:01 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: tangmeng <tangmeng@uniontech.com>
Message-ID: <YYuicUZPjEVYoa6r@yuki>
References: <20211109085745.21531-1-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211109085745.21531-1-tangmeng@uniontech.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] getuid/getuid01: Convert to new API
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Signed-off-by: tangmeng <tangmeng@uniontech.com>
> ---
>  testcases/kernel/syscalls/getuid/getuid01.c | 88 ++++-----------------
>  1 file changed, 17 insertions(+), 71 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/getuid/getuid01.c b/testcases/kernel/syscalls/getuid/getuid01.c
> index cf8c77424..6e8cee96a 100644
> --- a/testcases/kernel/syscalls/getuid/getuid01.c
> +++ b/testcases/kernel/syscalls/getuid/getuid01.c
> @@ -1,84 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

The license below is GPL-2.0 not GPL-2.0-or-later.

Please make sure that you replace the license with correct tag.

>  /*
>   * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
>   *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it would be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> - *
> - * Further, this software is distributed without any warranty that it is
> - * free of the rightful claim of any third person regarding infringement
> - * or the like.  Any license provided herein, whether implied or
> - * otherwise, applies only to this software file.  Patent licenses, if
> - * any, provided herein do not apply to combinations of this program with
> - * other software, or any other product whatsoever.
> - *
> - * You should have received a copy of the GNU General Public License along
> - * with this program; if not, write the Free Software Foundation, Inc.,
> - * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> - *
> - * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
> - * Mountain View, CA  94043, or:
> - *
> - * http://www.sgi.com
> - *
> - * For further information regarding this notice, see:
> - *
> - * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
> - */
> -/*
>   *    AUTHOR		: William Roske
>   *    CO-PILOT		: Dave Fenner
>   */
> -#include <sys/types.h>
> -#include <fcntl.h>
> -#include <errno.h>
> -#include <string.h>
> -#include <signal.h>
> 
> -#include "test.h"
> -#include "compat_16.h"
> -
> -static void setup(void);
> -static void cleanup(void);
> +/*\
> + * [Description]
> + *
> + * Check the basic functionality of the getuid() system call.
> + */
> 
> -TCID_DEFINE(getuid01);
> -int TST_TOTAL = 1;
> +#include "tst_test.h"
> +#include "compat_tst_16.h"
> 
> -int main(int ac, char **av)
> +static void verify_getuid(void)
>  {
> -	int lc;
> +	TEST(GETUID());
> 
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		TEST(GETUID(cleanup));
> -
> -		if (TEST_RETURN == -1)
> -			tst_resm(TFAIL | TTERRNO, "getuid failed");
> -		else
> -			tst_resm(TPASS, "getuid returned %ld", TEST_RETURN);
> -
> -	}
> -
> -	cleanup();
> -	tst_exit();
> -}
> -
> -static void setup(void)
> -{
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -	TEST_PAUSE;
> +	if (TST_RET == -1)
> +		tst_res(TFAIL | TTERRNO, "getuid failed");
> +	else
> +		tst_res(TPASS, "getuid returned %ld", TST_RET);

This can be just TST_EXP_POSSITIVE()

>  }
> 
> -static void cleanup(void)
> -{
> -}
> +static struct tst_test test = {
> +	.test_all = verify_getuid,
> +};
> --
> 2.20.1
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
