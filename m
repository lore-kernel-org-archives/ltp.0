Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF3F1C43334
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 10:22:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BAEDB3C93F3
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 12:22:45 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 46D293C1BAD
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 12:22:36 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 96572200211
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 12:22:35 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CF31321E79;
 Tue, 21 Jun 2022 10:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655806954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b565p1FFNTM0ixjwWG+w83pjlBMMc4uBo/eUSCBo73s=;
 b=stgKJUW3Nd3K0EN4oHP54iWHodjRwtaY0aieUI9XpT4+BYc7v3GRbEoxb3FIUw1ph3axpK
 ZzKLhePbR6AdnNvc8FhkSCwQuvvn25bvovrT1OfQr2Wt+8Tbx7U178Tv9UfS+ykBUYdTPn
 py9zNU7x21jF7ZnsNR+bHJ6j2p4LNtw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655806954;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b565p1FFNTM0ixjwWG+w83pjlBMMc4uBo/eUSCBo73s=;
 b=Z7quAL+r5vZJnVNch4YmvsQ9QAQPpjz/D6D63VYFY79qoH9WKEEFGJtzUbkquESXuxAXCR
 J/6RAiSuqjwDTpCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B8FDC13638;
 Tue, 21 Jun 2022 10:22:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6gRsLOqbsWLURQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 21 Jun 2022 10:22:34 +0000
Date: Tue, 21 Jun 2022 12:24:42 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <YrGcahVSR5fC5rus@yuki>
References: <20220617172025.23975-1-akumar@suse.de>
 <20220617172025.23975-4-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220617172025.23975-4-akumar@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/6] Remove unnecessary header includes
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
> ---
>  testcases/kernel/syscalls/utime/utime03.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/utime/utime03.c b/testcases/kernel/syscalls/utime/utime03.c
> index 2358fd70b..0c64518d2 100644
> --- a/testcases/kernel/syscalls/utime/utime03.c
> +++ b/testcases/kernel/syscalls/utime/utime03.c
> @@ -18,11 +18,8 @@
>   * - The user ID of the process has write access to the file.
>   */
>  
> -#include <sys/types.h>
>  #include <pwd.h>
>  #include <utime.h>
> -#include <sys/stat.h>
> -#include <time.h>
>  
>  #include "tst_test.h"
>  #include "tst_uid.h"
> @@ -60,7 +57,7 @@ static void run(void)
>  	struct stat statbuf;
>  	time_t mintime, maxtime;
>  
> -	utbuf.modtime = time(0) - 5;
> +	utbuf.modtime = tst_get_fs_timestamp() - 5;

This change is not explained in the patch description moreover ideally
patches should do one logical change so if we are going to accept these
changes they should be split into a patch that removes includes and
patch that replaces the time(0).

Although usage of time(0) is not really critical here, the difference
between the time(0) and tst_get_fs_timestamp() is that they may be out
of sync by 1 second as they are not incremenented at the exactly same
time. Hence it does not matter if we set time 5 +-1 seconds in the past
since the result is 100% different from current time.

>  	utbuf.actime = utbuf.modtime + 1;
>  	TST_EXP_PASS_SILENT(utime(TEMP_FILE, &utbuf));
>  	SAFE_STAT(TEMP_FILE, &statbuf);
> -- 
> 2.36.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
