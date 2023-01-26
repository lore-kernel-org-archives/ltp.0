Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C73C54E94
	for <ltp@archiver.kernel.org>; Thu, 26 Jan 2023 10:33:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 485953CB419
	for <ltp@archiver.kernel.org>; Thu, 26 Jan 2023 11:33:46 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 650F53C5E41
 for <ltp@lists.linux.it>; Thu, 26 Jan 2023 11:33:35 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4CD2E1400F8A
 for <ltp@lists.linux.it>; Thu, 26 Jan 2023 11:33:34 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 98F041F8BA;
 Thu, 26 Jan 2023 10:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1674729214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AEl94PFr4jYE5CiXJgnA/0ykEuDYO6DsNb/BV59kAgM=;
 b=pjn63m4A9EZ/rTaMx/l4SF2fkaxsW7AuZSvvhW7FkkX/6IjRrbu/hXYv+fmDkph4ze85MH
 SEH+THywmW+NvdRGvwfjHennnXJs1EWKBJUhA6byYLGA0VE1Ts3oSjLanOaPOyerk6caet
 URlkfUo86HUwXpJfrxltP8r0bf5z+Kw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1674729214;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AEl94PFr4jYE5CiXJgnA/0ykEuDYO6DsNb/BV59kAgM=;
 b=NL9EKr6ORVbbbQsPwqqA6yyjPpyZ+g7g6F39ZoMJNrZs9fqjSaAQ9n3ChfmcOcNxkCjnlg
 tZfTRKD+7osHSeAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8026613A09;
 Thu, 26 Jan 2023 10:33:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Go8yHv5W0mPpfQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 26 Jan 2023 10:33:34 +0000
Date: Thu, 26 Jan 2023 11:35:07 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Y9JXW4c9FkZEKqXx@yuki>
References: <20230125222703.19943-1-pvorel@suse.cz>
 <20230125222703.19943-3-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230125222703.19943-3-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] hugemmap15.c: Use TST_TEST_TCONF() for
 unsupported archs
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> 15625f6185 broke LTP build at least on riscv32 and mipsel32
> (and for any new arch in the future). Replace #error directive with
> TST_TEST_TCONF() fixes that.
> 
> Fixes: 15625f6185 ("Hugetlb: Migrating libhugetlbfs icache-hygiene")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
> index 4730d8d184..836225acd8 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
> @@ -19,6 +19,13 @@
>   */
>  
>  #define _GNU_SOURCE
> +
> +#include "hugetlb.h"
> +#if defined(__powerpc__) || defined(__powerpc64__) || defined(__ia64__) || \
> +	defined(__s390__) || defined(__s390x__) || defined(__sparc__) || \
> +	defined(__aarch64__) || (defined(__riscv) && __riscv_xlen == 64) || \
> +	defined(__i386__) || defined(__x86_64__) || defined(__arm__)
> +
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <setjmp.h>
> @@ -30,8 +37,6 @@
>  #include <sys/param.h>
>  #include <sys/types.h>
>  
> -#include "hugetlb.h"
> -
>  #define SUCC_JMP 1
>  #define FAIL_JMP 2
>  #define COPY_SIZE	128
> @@ -142,8 +147,6 @@ static void sig_handler(int signum, siginfo_t *si, void *uc)
>  		siglongjmp(sig_escape, FAIL_JMP + SIGSEGV);
>  	}
>  #endif
> -#else
> -#error "Need to setup signal conditions for this arch"
>  #endif
>  }
>  
> @@ -241,3 +244,6 @@ static struct tst_test test = {
>  	.test_all = run_test,
>  	.hugepages = {3, TST_NEEDS},
>  };
> +#else
> +	TST_TEST_TCONF("Architecture not supported");
                          ^
			  Maybe I would change this to be closer to the
			  original, so that it's clear that a piece of
			  code needs to be written for the test to be
			  enabled and that this is not inherently not
			  supported

Something as:

	TST_TEST_TCONF("Signal handler for this architecture hasn't been written");


Other than this it looks fine, with a better message:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
