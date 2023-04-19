Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055ADC6FD18
	for <ltp@archiver.kernel.org>; Wed, 19 Apr 2023 11:45:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2FC9B3CC019
	for <ltp@archiver.kernel.org>; Wed, 19 Apr 2023 13:45:31 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 792E83C7E58
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 13:45:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 93F9D1000B5C
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 13:45:19 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CD8DE1FD87;
 Wed, 19 Apr 2023 11:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1681904718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2cvY8+CsaovkifjPoPMsHd1N9yRl2PfQEmXXSlsqDas=;
 b=MCScAv0un/AbSsRX2O53GOr6ktPqEdqieUNiEn5inyAaFrtADsIWj3NHxOeqvnOPpTRMZN
 xpfRoxlfehjey21ES7/0jv6xlfQhUJ0wym75M4xNxZTt46ohtbLcIXLiWYQKzZHxL70zji
 pmF6VSjtGnYGE3duvWVCHlMawKFaEfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1681904718;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2cvY8+CsaovkifjPoPMsHd1N9yRl2PfQEmXXSlsqDas=;
 b=Z48XqhiV8enm5Ux15BeM+nWT0R1m6DjTVkEK9KPVdibjYwWUPRVYKbw8z81HEK/gnQnYyD
 I+nmuu7jqJ8gRUDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 12A5C13580;
 Wed, 19 Apr 2023 11:45:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Eb2jNk3UP2SMZQAAMHmgww
 (envelope-from <akumar@suse.de>); Wed, 19 Apr 2023 11:45:17 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Wed, 19 Apr 2023 17:15:16 +0530
Message-ID: <1827762.iFF2E32hkL@localhost>
Organization: SUSE
In-Reply-To: <1680604594-16596-3-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1680604594-16596-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1680604594-16596-3-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/4] syscalls/mlock03: Convert into new api
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

Hi,

On Tuesday, April 4, 2023 4:06:33 PM IST Yang Xu wrote:
> Also remove tst_require_root. Test mlock/munlock instead of mlock by default.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  testcases/kernel/syscalls/mlock/mlock03.c | 137 +++++++---------------
>  1 file changed, 43 insertions(+), 94 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/mlock/mlock03.c b/testcases/kernel/syscalls/mlock/mlock03.c
> index 8bc65701c..0fc3fa8ed 100644
> --- a/testcases/kernel/syscalls/mlock/mlock03.c
> +++ b/testcases/kernel/syscalls/mlock/mlock03.c
> @@ -1,119 +1,68 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
Original test only has GPLv2

>  /*
> - * Stack size mapping is decreased through mlock/munlock call.
> - *
> - * This is to test kernel if it has a problem with shortening [stack]
> - * mapping through several loops of mlock/munlock of /proc/self/maps.
> - *
> - * From:
> - * munlock     76KiB bfef2000-bff05000 rw-p 00000000 00:00 0          [stack]
> - *
> - * To:
> - * munlock     44KiB bfefa000-bff05000 rw-p 00000000 00:00 0          [stack]
> - *
> - * with more iterations - could drop to 0KiB.
> - *
>   * Copyright (C) 2010  Red Hat, Inc.
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of version 2 of the GNU General Public
> - * License as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it would be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> - *
> - * Further, this software is distributed without any warranty that it
> - * is free of the rightful claim of any third person regarding
> - * infringement or the like.  Any license provided herein, whether
> - * implied or otherwise, applies only to this software file.  Patent
> - * licenses, if any, provided herein do not apply to combinations of
> - * this program with other software, or any other product whatsoever.
> + */
> +
> +/*\
> + * [Description]
>   *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> - * 02110-1301, USA.
> + * This case is designed to test kernel whether met a problem with shortening
> + * [stack] mapping through several loops of mlock/munlock of /proc/self/maps.
I don't understand how shortening of stack by calling to mlock/munlock
for maps regions may work, so no comments on actual patch.

>   */
> +
>  #include <sys/mman.h>
>  #include <stdio.h>
>  #include <string.h>
> -#include "test.h"
> +#include <pwd.h>
> +#include "tst_test.h"
> +#include "tst_safe_stdio.h"
>  
>  #define KB 1024
>  
> -char *TCID = "mlock03";
> -int TST_TOTAL = 1;
> -
> -static void setup(void);
> -static void cleanup(void);
> -
> -int main(int argc, char *argv[])
> +static void verify_mlock(void)
>  {
> -	int lc;
>  	long from, to;
>  	long first = -1, last = -1;
>  	char b[KB];
>  	FILE *fp;
>  
> -	tst_parse_opts(argc, argv, NULL, NULL);
> -
> -	setup();
> +	fp = SAFE_FOPEN("/proc/self/maps", "r");
> +	while (!feof(fp)) {
> +		if (!fgets(b, KB - 1, fp))
> +			break;
> +		b[strlen(b) - 1] = '\0';
> +		if (sscanf(b, "%lx-%lx", &from, &to) != 2) {
> +			tst_res(TFAIL, "parse %s start and end address failed",
> +					b);
> +			continue;
> +		}
>  
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		fp = fopen("/proc/self/maps", "r");
> -		if (fp == NULL)
> -			tst_brkm(TBROK | TERRNO, cleanup, "fopen");
> -		while (!feof(fp)) {
> -			if (!fgets(b, KB - 1, fp))
> -				break;
> -			b[strlen(b) - 1] = '\0';
> -			sscanf(b, "%lx-%lx", &from, &to);
> +		/* Record the initial stack size. */
> +		if (strstr(b, "[stack]") != NULL)
> +			first = (to - from) / KB;
>  
> -			/* Record the initial stack size. */
> -			if (lc == 0 && strstr(b, "[stack]") != NULL)
> -				first = (to - from) / KB;
> +		tst_res(TINFO, "mlock[%lx,%lx]", from, to);
> +		if (mlock((const void *)from, to - from) == -1)
> +			tst_res(TINFO | TERRNO, "mlock failed");
>  
> -			switch (lc & 1) {
> -			case 0:
> -				if (mlock((const void *)from, to - from) == -1)
> -					tst_resm(TINFO | TERRNO,
> -						 "mlock failed");
> -				break;
> -			case 1:
> -				if (munlock((void *)from, to - from) == -1)
> -					tst_resm(TINFO | TERRNO,
> -						 "munlock failed");
> -				break;
> -			default:
> -				break;
> -			}
> -			tst_resm(TINFO, "%s from %lx to %0lx",
> -				 (lc & 1) ? "munlock" : "mlock", from, to);
> +		tst_res(TINFO, "munlock [%lx,%lx]", from, to);
> +		if (munlock((void *)from, to - from) == -1)
> +			tst_res(TINFO | TERRNO, "munlock failed");
>  
> -			/* Record the final stack size. */
> -			if (strstr(b, "[stack]") != NULL)
> -				last = (to - from) / KB;
> -		}
> -		fclose(fp);
> +		/* Record the final stack size. */
> +		if (strstr(b, "[stack]") != NULL)
> +			last = (to - from) / KB;
>  	}
> -	tst_resm(TINFO, "starting stack size is %ld", first);
> -	tst_resm(TINFO, "final stack size is %ld", last);
> +	SAFE_FCLOSE(fp);
> +
> +	tst_res(TINFO, "starting stack size is %ld", first);
> +	tst_res(TINFO, "final stack size is %ld", last);
>  	if (last < first)
> -		tst_resm(TFAIL, "stack size is decreased.");
> +		tst_res(TFAIL, "stack size is decreased.");
>  	else
> -		tst_resm(TPASS, "stack size is not decreased.");
> -
> -	cleanup();
> -	tst_exit();
> +		tst_res(TPASS, "stack size is not decreased.");
>  }
>  
> -void setup(void)
> -{
> -	tst_require_root();
> -
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -	TEST_PAUSE;
> -}
> -
> -void cleanup(void)
> -{
> -}
> +static struct tst_test test = {
> +	.test_all = verify_mlock,
> +};
> 

--
Regards,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
