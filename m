Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6861C25B08
	for <ltp@archiver.kernel.org>; Wed, 17 Aug 2022 14:28:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D6D33C9CF4
	for <ltp@archiver.kernel.org>; Wed, 17 Aug 2022 16:28:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 018F53C9B66
 for <ltp@lists.linux.it>; Wed, 17 Aug 2022 16:27:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 570E91A00916
 for <ltp@lists.linux.it>; Wed, 17 Aug 2022 16:27:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 922CC37C5B;
 Wed, 17 Aug 2022 14:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660746471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1Zky7ArJtl9WTrWA2VcSVLps48llmYbXHlAqaukp/3s=;
 b=RUCkG72mRnrBYH7Bos0Q2U2HXBpqwKFH1mbl4v4/CdGLRANEWrumb2FGIjQ2pcSkKhwq1K
 8QKW1Psn9/QOUrv1ggYHsETnJ8E2KXTrW8YSNWSvD7HkcBzavnR3dvMR3aomoe2inLinNz
 CFK3ZvUBQdNNdGAnFGh2gs1wIP5F1a4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660746471;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1Zky7ArJtl9WTrWA2VcSVLps48llmYbXHlAqaukp/3s=;
 b=AfjI+U7iIiabr3TkLNJTUJ5lgmGFIk+b8uowdVmFQTni/6yih69aHqvzwlMjuEO0s49EVd
 B8z0TYGtxb2GGSBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7097913A8E;
 Wed, 17 Aug 2022 14:27:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gZL6Gef6/GKfdAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 17 Aug 2022 14:27:51 +0000
Date: Wed, 17 Aug 2022 16:29:48 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Tudor Cretu <tudor.cretu@arm.com>
Message-ID: <Yvz7XPqVb/acIi6P@yuki>
References: <20220817133946.234985-1-tudor.cretu@arm.com>
 <20220817133946.234985-3-tudor.cretu@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220817133946.234985-3-tudor.cretu@arm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/4] syscalls/mprotect01: Invoke the syscall
 directly instead of the libc wrapper
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
> per POSIX: The mprotect() function shall change the access protections
> to be that specified by prot for those whole pages containing any part
> of the address space of the process starting at address addr and
> continuing for len bytes.
> 
> Issue 6 of POSIX introduces: The implementation may require that addr
> be a multiple of the page size as returned by sysconf().
> 
> Therefore it's not strictly required that addr is a multiple of the page
> size. Some libcs (e.g. Musl) indeed don't have this requirement, so calling
> the C standard library function doesn't fail in their case. As the
> testsuite focuses on mprotect(2), the testcases should call the syscall
> directly instead of the libc function.

So Musl mproctect() does clear a few bits of the start and rounds the
len. That sounds like a dangerous thing to do to be honest, since you
end up with a different region than you requested.

I guess that this patch is reasonable solution since the glibc
mprotect() seems to be just wrapper for the syscall.

> Signed-off-by: Tudor Cretu <tudor.cretu@arm.com>
> ---
>  testcases/kernel/syscalls/mprotect/mprotect01.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/mprotect/mprotect01.c b/testcases/kernel/syscalls/mprotect/mprotect01.c
> index be4d982ea..aa4685258 100644
> --- a/testcases/kernel/syscalls/mprotect/mprotect01.c
> +++ b/testcases/kernel/syscalls/mprotect/mprotect01.c
> @@ -43,6 +43,7 @@
>  #include <stdlib.h>
>  #include <unistd.h>
>  #include "test.h"
> +#include "lapi/syscalls.h"
>  #include "safe_macros.h"
>  
>  char *TCID = "mprotect01";
> @@ -97,7 +98,7 @@ int main(int ac, char **av)
>  			if (TC[i].setupfunc != NULL)
>  				TC[i].setupfunc(&TC[i]);
>  
> -			TEST(mprotect(TC[i].addr, TC[i].len, TC[i].prot));
> +			TEST(tst_syscall(__NR_mprotect, TC[i].addr, TC[i].len, TC[i].prot));
>  
>  			if (TEST_RETURN != -1) {
>  				tst_resm(TFAIL, "call succeeded unexpectedly");
> -- 
> 2.25.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
