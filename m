Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A81C433FE
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 11:40:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 04B573CAE99
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 13:40:57 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40C053C7319
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 13:40:45 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 409DD2003A6
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 13:40:44 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 838681FA49
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 11:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1665488444;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D/SQivAzs1fPUHchzdbvf/RpEfv7LNoy2Dwk7cqI5M8=;
 b=u1Pp3Y/Xshohk5cap8UoweCVfoI5wrgG800MltQGWyLzUKa1c8JsxYWzmYBx0QRhbhdRkV
 pxgc2RLtrcRq50L1Iyco+WP7iNAhGiHfS8TRYvob7W2AiF3o/PsCvhL7Qf4M1h0/lExdu3
 ydXe3M39+2VPLzfUVsQ+DE7DjtI1YEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1665488444;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D/SQivAzs1fPUHchzdbvf/RpEfv7LNoy2Dwk7cqI5M8=;
 b=HjnPQHPAXpglQooa8dW8SaXZQCXT6GdVB/dLntjY6NiqRxy68pGjMYAWZDl6FfxLa4lQxH
 8szWVYQEfpU4z1CA==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id E42592C141;
 Tue, 11 Oct 2022 11:40:43 +0000 (UTC)
References: <20220816074449.30861-1-akumar@suse.de>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Avinesh Kumar <akumar@suse.de>
Date: Tue, 11 Oct 2022 12:36:20 +0100
In-reply-to: <20220816074449.30861-1-akumar@suse.de>
Message-ID: <875ygq7fm0.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] stat01: cleanup, use TST_EXP macros
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Merged!

Avinesh Kumar <akumar@suse.de> writes:

> - update copyright
> - turn comment into docparse format
> - remove redundant headers
> - make check fixes: static vars
> - use TST_EXP_* macros
>
> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---
>  testcases/kernel/syscalls/stat/stat01.c | 60 ++++++-------------------
>  1 file changed, 14 insertions(+), 46 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/stat/stat01.c b/testcases/kernel/syscalls/stat/stat01.c
> index 0f5c1dcc2..e0dbfbf2f 100644
> --- a/testcases/kernel/syscalls/stat/stat01.c
> +++ b/testcases/kernel/syscalls/stat/stat01.c
> @@ -2,16 +2,17 @@
>  /* Copyright (c) International Business Machines  Corp., 2001
>   *	07/2001 John George
>   *		-Ported
> + * Copyright (c) Linux Test Project, 2002-2022
> + */
> +
> +/*\
> + * [Description]
>   *
>   *  Verify that, stat(2) succeeds to get the status of a file and fills the
>   *  stat structure elements regardless of whether process has or doesn't
>   *  have read access to the file.
>   */
>  
> -#include <sys/types.h>
> -#include <fcntl.h>
> -#include <sys/stat.h>
> -#include <errno.h>
>  #include <pwd.h>
>  #include "tst_test.h"
>  
> @@ -22,9 +23,9 @@
>  #define NEW_MODE         0222
>  #define MASK             0777
>  
> -uid_t user_id;
> -gid_t group_id;
> -struct passwd *ltpuser;
> +static uid_t user_id;
> +static gid_t group_id;
> +static struct passwd *ltpuser;
>  
>  static struct tcase{
>  	char *pathname;
> @@ -38,47 +39,14 @@ static void verify_stat(unsigned int n)
>  {
>  	struct tcase *tc = TC + n;
>  	struct stat stat_buf;
> -	int fail = 0;
> -
> -	TEST(stat(tc->pathname, &stat_buf));
> -
> -	if (TST_RET == -1) {
> -		tst_res(TFAIL | TTERRNO, "stat(%s) failed", tc->pathname);
> -		return;
> -	}
> -
> -	if (stat_buf.st_uid != user_id) {
> -		tst_res(TFAIL, "stat_buf.st_uid = %i expected %i",
> -			stat_buf.st_uid, user_id);
> -		fail++;
> -	}
>  
> -	if (stat_buf.st_gid != group_id) {
> -		tst_res(TFAIL, "stat_buf.st_gid = %i expected %i",
> -			stat_buf.st_gid, group_id);
> -		fail++;
> -	}
> -
> -	if (stat_buf.st_size != FILE_SIZE) {
> -		tst_res(TFAIL, "stat_buf.st_size = %li expected %i",
> -			(long)stat_buf.st_size, FILE_SIZE);
> -		fail++;
> -	}
> -
> -	if ((stat_buf.st_mode & MASK) != tc->mode) {
> -		tst_res(TFAIL, "stat_buf.st_mode = %o expected %o",
> -			(stat_buf.st_mode & MASK), tc->mode);
> -		fail++;
> -	}
> -
> -	if (stat_buf.st_nlink != 1) {
> -		tst_res(TFAIL, "stat_buf.st_nlink = %lu expected 1",
> -			stat_buf.st_nlink);
> -		fail++;
> -	}
> +	TST_EXP_PASS(stat(tc->pathname, &stat_buf));
>  
> -	if (!fail)
> -		tst_res(TPASS, "stat(%s)", tc->pathname);
> +	TST_EXP_EQ_LU(stat_buf.st_uid, user_id);
> +	TST_EXP_EQ_LU(stat_buf.st_gid, group_id);
> +	TST_EXP_EQ_LI(stat_buf.st_size, FILE_SIZE);
> +	TST_EXP_EQ_LU(stat_buf.st_mode & MASK, tc->mode);
> +	TST_EXP_EQ_LU(stat_buf.st_nlink, 1);
>  }
>  
>  static void setup(void)
> -- 
> 2.37.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
