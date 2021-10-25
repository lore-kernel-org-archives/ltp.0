Return-Path: <SRS0=uLVz=PN=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74961C433F5
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 08:28:33 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D770F604AC
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 08:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D770F604AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD1E53C6576
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 10:28:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 273393C180D
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 10:28:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 43C536009CA
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 10:28:18 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5896A2191A;
 Mon, 25 Oct 2021 08:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635150498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DVVZF5tExILLaIVampWKARI4x4x8Xuu2mJeNLiJT3a8=;
 b=KFYGSvvpHlCzP/Nd47yBV2pud9sQg2AKWPq+eXD9386Ba7zLJNWyj6XFw4xCpfXGzU19Fw
 kpcKMZZIS1HzkeHalVSnlj+rzMl+irlgZXWELhoITfABGzRp8EpFoAlAcRqml4vwP12jVE
 d9F/NPfBa4i0xha4SuNDthgplA1mVws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635150498;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DVVZF5tExILLaIVampWKARI4x4x8Xuu2mJeNLiJT3a8=;
 b=MEcQwQ47UsFTQA1XPjdx3H0HlriTIvJyXlFkVCRoQv2ADxAM7pdbmxjR/sjLDWUVSZ+PFc
 SpQ1GptJdUB/AWAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 43A9513216;
 Mon, 25 Oct 2021 08:28:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bm6ZDqJqdmGlKQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 25 Oct 2021 08:28:18 +0000
Date: Mon, 25 Oct 2021 10:29:07 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Tang Meng <tangmeng@uniontech.com>
Message-ID: <YXZq0zWwcjM3+p2I@yuki>
References: <20211022033021.1351-1-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211022033021.1351-1-tangmeng@uniontech.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] link/link02: Convert to new API
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
> --- a/testcases/kernel/syscalls/link/link02.c
> +++ b/testcases/kernel/syscalls/link/link02.c
> @@ -1,115 +1,59 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
> - *  AUTHOR		: William Roske
> - *  CO-PILOT		: Dave Fenner
> - * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
> - *
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
> + * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.

The copyrights in this file were Silicon Graphics and mine. You have to
keep the original coypright instead of adding random ones.

>   */
> 
> -/*
> +/*\
> + * [Description]
>   * Tests that link(2) succeds.
                           ^
			   succeeds
>   */

Also ideally there should be an empty line between the [Description] and
the rest as:

/*
 * [Description]
 *
 * Lorem ipsum dolor sit amet.
 */

> -#include <sys/types.h>
> -#include <fcntl.h>
> +#include <unistd.h>
>  #include <sys/stat.h>
> -#include <errno.h>
> -#include <string.h>
> -#include <signal.h>
> -#include "test.h"
> -#include "safe_macros.h"
> -
> -static void setup(void);
> -static void cleanup(void);
> 
> -char *TCID = "link02";
> -int TST_TOTAL = 1;
> +#include "tst_test.h"
> 
>  #define OLDPATH "oldpath"
>  #define NEWPATH "newpath"
> 
> -static void verify_link(void)
> +static void verify_link02(void)
                 ^
		 Just keep this as verify_link(void) no need to add
		 numbers.
>  {
>  	struct stat fbuf, lbuf;
> 
>  	TEST(link(OLDPATH, NEWPATH));

This should be:

	TST_EXP_PASS(link(OLDPATH, NEWPATH));

	if (!TST_PASS)
		return;

	SAFE_STAT(...);
	SAFE_STAT(...);

	if (fbuf.st_nlink ...) {
		...
	} else {
		...
	}

> -	if (TEST_RETURN == 0) {
> -		SAFE_STAT(cleanup, OLDPATH, &fbuf);
> -		SAFE_STAT(cleanup, NEWPATH, &lbuf);
> +	if (TST_RET == 0) {
> +		SAFE_STAT(OLDPATH, &fbuf);
> +		SAFE_STAT(NEWPATH, &lbuf);
>  		if (fbuf.st_nlink > 1 && lbuf.st_nlink > 1 &&
>  		    fbuf.st_nlink == lbuf.st_nlink) {
> -			tst_resm(TPASS, "link("OLDPATH","NEWPATH") "
> +			tst_res(TPASS, "link("OLDPATH","NEWPATH") "
>  			         "returned 0 and link counts match");
>  		} else {
> -			tst_resm(TFAIL, "link("OLDPATH","NEWPATH") returned 0"
> +			tst_res(TFAIL, "link("OLDPATH","NEWPATH") returned 0"
>  				 " but stat lin count do not match %d %d",
>  				 (int)fbuf.st_nlink, (int)lbuf.st_nlink);
>  		}
> -		SAFE_UNLINK(cleanup, NEWPATH);
>  	} else {
> -		tst_resm(TFAIL | TTERRNO,
> +		tst_res(TFAIL | TTERRNO,
>  		         "link("OLDPATH","NEWPATH") returned %ld",
> -		         TEST_RETURN);
> -	}
> -}
> -
> -int main(int ac, char **av)
> -{
> -	int lc;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -		verify_link();
> +		         TST_RET);
>  	}
> -
> -	cleanup();
> -	tst_exit();
>  }
> 
>  static void setup(void)
>  {
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	tst_tmpdir();
> -
> -	SAFE_TOUCH(cleanup, OLDPATH, 0700, NULL);
> +	SAFE_TOUCH(OLDPATH, 0700, NULL);
>  }
> 
>  static void cleanup(void)
>  {
> -	tst_rmdir();
> +    SAFE_UNLINK(NEWPATH);
>  }

There is no need to unlink anything the the cleanup, the test library
will remove the test temporary directory recursively.

> +static struct tst_test test = {
> +    .test_all = verify_link02,
> +    .setup = setup,
> +    .cleanup = cleanup,
> +    .needs_tmpdir = 1,
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
