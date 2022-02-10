Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB89C433F5
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 15:45:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5395B3C9EE1
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 16:45:40 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 84AA53C98C8
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 16:45:30 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 07DFC1401268
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 16:45:29 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 37B821F399;
 Thu, 10 Feb 2022 15:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644507929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GzPcBZJtXp5p4Wk3KZJuKpBIP9g5OY5Xq8zaJnIx/Hs=;
 b=bKL01x4jyF4Rmos0s8AKVwVOiVXQ0QbuFq/H8bb9cbCxMGFeWB/+Ne5LiqCVVf120UjayV
 /NJq/Oi/n+m6hNbdLwxe80C3z5ityEU8RqBb/GoWhziUuStiEn3/qM8DKZk/yTDqSZ8qQD
 35+QDkEon6s94rA3acNq6jaELzFVk68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644507929;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GzPcBZJtXp5p4Wk3KZJuKpBIP9g5OY5Xq8zaJnIx/Hs=;
 b=Dvl9fGg2VJwWgBwKBHGsUes5VJsTYktuiRGgswG2tQ89/JTUtZUZAsBsTTmKWPgw3oNeok
 MK0Ae1vJWpwdVlCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F272E13BEF;
 Thu, 10 Feb 2022 15:45:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CfbaORgzBWLDGwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 10 Feb 2022 15:45:28 +0000
Date: Thu, 10 Feb 2022 16:47:35 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Kushal Chand <kushalkataria5@gmail.com>
Message-ID: <YgUzl77PjUgkBHtU@yuki>
References: <20220210111828.39927-1-kushalkataria5@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220210111828.39927-1-kushalkataria5@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] fstat_02: Increase test coverage by creating
 hard link to file and validate using fstat
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
> Please ignore patch v2, I think that is wrong.
> 
> Fix format specfiers and cast to correct type when printing.

Well either it's %li and cast to (long) or %i and cast to (int) both
will work fine in this case.

However the points stated in v2 still apply to this patch as well.

> Implements: #517
> ---
>  testcases/kernel/syscalls/fstat/fstat02.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/fstat/fstat02.c b/testcases/kernel/syscalls/fstat/fstat02.c
> index c0229de44..8084cd4c2 100644
> --- a/testcases/kernel/syscalls/fstat/fstat02.c
> +++ b/testcases/kernel/syscalls/fstat/fstat02.c
> @@ -17,8 +17,10 @@
>  #include "tst_safe_macros.h"
>  
>  #define TESTFILE        "test_file"
> +#define LINK_TESTFILE   "link_test_file"
>  #define FILE_SIZE       1024
>  #define FILE_MODE	0644
> +#define NLINK	        2
>  
>  static struct stat stat_buf;
>  static uid_t user_id;
> @@ -61,6 +63,12 @@ static void run(void)
>  		fail++;
>  	}
>  
> +	if (stat_buf.st_nlink != NLINK) {
> +		tst_res(TFAIL, "stat_buf.st_nlink = %i expected %i",
> +			(int)stat_buf.st_nlink, NLINK);
> +		fail++;
> +	}
> +
>  	if (fail)
>  		return;
>  
> @@ -78,6 +86,8 @@ static void setup(void)
>  
>  	if (tst_fill_file(TESTFILE, 'a', FILE_SIZE, 1))
>  		tst_brk(TBROK, "Could not fill Testfile!");
> +
> +	SAFE_LINK(TESTFILE, LINK_TESTFILE);
>  }
>  
>  static void cleanup(void)
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
