Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12D9C433EF
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 11:51:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 89E9F3C861B
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 12:51:10 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E31633C130C
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 12:51:00 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1BB291A0152F
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 12:50:59 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 43C2E1F3A1;
 Fri, 10 Dec 2021 11:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639137059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kXVH09tuSjBSqzwcCV0KZkYSWW+hPaYvwojGEtJcI2Y=;
 b=YGJvsmExA267hA4WEka3jWuSxgWE8LTYU432A+zEcUff9kVK1Se8NIybEwZJ0HGKKKIPSP
 bg7gIvMpexGPhSOqHruMojSAsnorav88tsvT6ZFSOm8P73r/Qu8wgnrzMBZb5FGYgYgUpx
 9z5AyXzGTzFxzt2Tj37BQk7sEaw5HRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639137059;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kXVH09tuSjBSqzwcCV0KZkYSWW+hPaYvwojGEtJcI2Y=;
 b=vZaSqIIowmCuffiZ2ddQhdMrMLQNRAPZiaA+cYV7tkeEzFR4dvV2p+VV320mfJdmgjt36g
 tQUdSjrNoVlTzDDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D79813DDE;
 Fri, 10 Dec 2021 11:50:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZdK4CiM/s2H3dgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 10 Dec 2021 11:50:59 +0000
Date: Fri, 10 Dec 2021 12:52:19 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YbM/c45u4KOHN9+h@yuki>
References: <YbJ3SKsLu7iNoqZc@pevik>
 <1639136448-2148-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1639136448-2148-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] swapping01: skip test if zram-swap is
 being used
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
> diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
> index 392b79d65..aef47e9a4 100644
> --- a/testcases/kernel/mem/swapping/swapping01.c
> +++ b/testcases/kernel/mem/swapping/swapping01.c
> @@ -40,10 +40,10 @@
>  
>  #include <sys/types.h>
>  #include <sys/wait.h>
> -#include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
>  #include <unistd.h>
> +#include "tst_safe_stdio.h"
>  #include "lapi/abisize.h"
>  #include "mem.h"
>  
> @@ -67,6 +67,14 @@ static void test_swapping(void)
>  #ifdef TST_ABI32
>  	tst_brk(TCONF, "test is not designed for 32-bit system.");
>  #endif
> +	FILE *file;
> +	char line[PATH_MAX];
> +
> +	file = SAFE_FOPEN("/proc/swaps", "r");
> +	while (fgets(line, sizeof(line), file)) {
> +		if (strstr(line, "/dev/zram"))
> +			tst_brk(TCONF, "zram-swap is being used!");
> +	}

Actually please add SAFE_FCLOSE(file) here, but otherwise Reviewed...

>  	init_meminfo();
>  
> -- 
> 2.23.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
