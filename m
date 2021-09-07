Return-Path: <SRS0=89zk=N5=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29965C433F5
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 09:54:27 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8975C6105A
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 09:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8975C6105A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 673DC3C9513
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 11:54:24 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 322BF3C222D
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 11:54:16 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 78BE7200905
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 11:54:15 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 64E661FE84;
 Tue,  7 Sep 2021 09:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631008454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FSYblDQA+tXmZdl0NPPHZJ1w4iVz5N/SkGBqOv+kmM0=;
 b=CBv+olxQ8ZdRf4tUUhUbO+3EQOoL/lIsJQKne5aEB0VDPvHvcbPwQ1Pxrh1CdAehZpNZEl
 BvvcVtKMUB9X9gprdjV1tw7owNPqfXRfbWISFv4sS3ShqI3787kQPs9jt7LcntOki6tXWS
 QYo6kvWoZi7e/ZRLsQuM9MrfWV0fPsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631008454;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FSYblDQA+tXmZdl0NPPHZJ1w4iVz5N/SkGBqOv+kmM0=;
 b=oO+cD3ccq0X5bPyOxy6pwvzoj1232jIDc+WY/OD3ObCZHXKDsQw5NLXCAoKocXNmCwbQ5/
 YkHwdbIMnNdnQ2DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4C75413C56;
 Tue,  7 Sep 2021 09:54:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4bWGEcY2N2ECawAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 07 Sep 2021 09:54:14 +0000
Date: Tue, 7 Sep 2021 11:54:26 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YTc20vtM2HbhTVTg@yuki>
References: <20210907025258.3294914-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210907025258.3294914-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] openposix: make use of tst_process_state_wait3
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
Message-ID: <20210907095426.yNGOefSYqOv9GSIsVzGvMjov5mlZKJgeoW4QeycSRYI@z>

Hi!
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/9-1.c
> index 04ef0a2cc..554714695 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/9-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/9-1.c
> @@ -17,6 +17,7 @@
>  #include <stdlib.h>
>  #include <errno.h>
>  #include "posixtest.h"
> +#include "proc.h"
>  
>  #define SLEEPSEC 30
>  
> @@ -88,7 +89,7 @@ int main(void)
>  		/* parent here */
>  		int i;
>  
> -		sleep(1);
> +		tst_process_state_wait3(pid, 'S', 1);

This test is actually the only one that looks at the remining time as
returned by clock_nanosleep() so it may make a sense to keep the
sleep(1) in this test so that the remaining time is smaller than the
sleep time by some reasonable margin. But I guess that the test will
work fine without it as well.

The rest is obviously fine.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
