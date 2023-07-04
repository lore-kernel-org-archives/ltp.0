Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890BFEB64D9
	for <ltp@archiver.kernel.org>; Tue,  4 Jul 2023 10:32:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B8F83C993F
	for <ltp@archiver.kernel.org>; Tue,  4 Jul 2023 12:32:20 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A9F793C993F
 for <ltp@lists.linux.it>; Tue,  4 Jul 2023 12:32:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F338410008F8
 for <ltp@lists.linux.it>; Tue,  4 Jul 2023 12:32:09 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CABEA204C6;
 Tue,  4 Jul 2023 10:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1688466727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0UjVzqaEqPDIfYuXmelobThvvsbeB5T2RoHgFiX4yac=;
 b=j2htoboeGWBKEBDvM9i8x8rfoq7qtN7P7lwv2VVvzSrwziM4YJGRPjWn1fXq3d6CWZxX3A
 KSglYaMQ00P6I4fYr+kGqrfZyh+mOBwf3iwdsiussVkjZpaswqCgiwC4/nphSPHCOfORL0
 bk78aMQ/hEkUi9mbYKFA2V0bWKFBNqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1688466727;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0UjVzqaEqPDIfYuXmelobThvvsbeB5T2RoHgFiX4yac=;
 b=j9mCr0aOYq4ia/7YSmX491Lu+I1KAXWZZ6yDYvA0FM0VYfEwD8JBbh4EIdd9BtH/C1Y354
 TIlrBX901BI3IRAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC6FA1346D;
 Tue,  4 Jul 2023 10:32:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id x2N9Jyf1o2TocAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 04 Jul 2023 10:32:07 +0000
Date: Tue, 4 Jul 2023 12:33:13 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZKP1afDMgcKSIESE@yuki>
References: <20230704091933.496989-1-pvorel@suse.cz>
 <20230704091933.496989-3-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230704091933.496989-3-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 2/3] lib/C-API: Add option -V to print LTP
 version
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
> It can be useful for troubleshooting reported issues.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  lib/tst_test.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 04da456c6..e81a3d036 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -34,6 +34,7 @@
>  #include "old_resource.h"
>  #include "old_device.h"
>  #include "old_tmpdir.h"
> +#include "ltp-version.h"
>  
>  /*
>   * Hack to get TCID defined in newlib tests
> @@ -509,6 +510,7 @@ static struct option {
>  	{"h",  "-h       Prints this help"},
>  	{"i:", "-i n     Execute test n times"},
>  	{"I:", "-I x     Execute test for n seconds"},
> +	{"V",  "-V       Prints LTP version"},
>  	{"C:", "-C ARG   Run child process with ARG arguments (used internally)"},
>  };
>  
> @@ -686,6 +688,10 @@ static void parse_opts(int argc, char *argv[])
>  			else
>  				duration = SAFE_STRTOF(optarg, 0.1, HUGE_VALF);
>  		break;
> +		case 'V':
> +			fprintf(stderr, LTP_VERSION "\n");
> +			exit(0);
> +		break;

Why don't we print that as a part of help? Do we really need to allocate
a flag for this?

>  		case 'C':
>  #ifdef UCLINUX
>  			child_args = optarg;
> -- 
> 2.40.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
