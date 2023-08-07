Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE4AEB64DD
	for <ltp@archiver.kernel.org>; Mon,  7 Aug 2023 09:32:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B65BA3CD721
	for <ltp@archiver.kernel.org>; Mon,  7 Aug 2023 11:31:58 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C2C3D3CD2C6
 for <ltp@lists.linux.it>; Mon,  7 Aug 2023 11:31:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D606F10009DE
 for <ltp@lists.linux.it>; Mon,  7 Aug 2023 11:31:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 95B361F8AB;
 Mon,  7 Aug 2023 09:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1691400704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4K/c7PrxNg+YxV4YWQeYfNIu/SAtxLJkx+E8jvKcH1A=;
 b=HC3XYezsMQJws3QB8+9ix6TXcsdCzNUvHiUqtfLLkRaMOukMQnvMP4Ie1wFDu7eHEsbJgL
 lHgZ+fa1AI+M+1XnqdLGIvm6vL8XVYdHc3PEgSETgmWrfgR82H29p80/Krlz+VpqZJVYeO
 1ntMC99Yw80kKAa16l9l86UE4mI4blc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1691400704;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4K/c7PrxNg+YxV4YWQeYfNIu/SAtxLJkx+E8jvKcH1A=;
 b=xSLpWXZj/4Mp71NpIhW1RYrc9F9mIuLBsakIA0EhAl/6oD5CZtKoZ3xUdzC47G09BdcYDN
 Jssz1Bn7qhBN1TCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7FDE613910;
 Mon,  7 Aug 2023 09:31:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id lJNfHgC60GS3JAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 07 Aug 2023 09:31:44 +0000
Date: Mon, 7 Aug 2023 11:32:41 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: ybonatakis <ybonatakis@suse.com>
Message-ID: <ZNC6OfTHdzrh1FKI@yuki>
References: <20230804164918.31756-1-ybonatakis@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230804164918.31756-1-ybonatakis@suse.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Rewrite the gethostname01 using new LTP API
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
>  .../syscalls/gethostname/gethostname01.c      | 173 +++---------------
>  1 file changed, 23 insertions(+), 150 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/gethostname/gethostname01.c b/testcases/kernel/syscalls/gethostname/gethostname01.c
> index a7cb5417f..1c07c46b7 100644
> --- a/testcases/kernel/syscalls/gethostname/gethostname01.c
> +++ b/testcases/kernel/syscalls/gethostname/gethostname01.c
> @@ -1,161 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.

This is GPL-2.0 only, please fix the SPDX

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
> - *
> + * Copyright (c) International Business Machines  Corp., 2001
> + * 07/2001 Ported by Wayne Boyer
> + * Copyright (c) Linux Test Project, 2002-2015
> + * Copyright (c) 2023 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>

And this is completely wrong, I suppose you copy & pasted the copyrights
and haven't checked if they are correct...

>   */
> -/* $Id: gethostname01.c,v 1.6 2009/10/26 14:55:47 subrata_modak Exp $ */
> -/**********************************************************
> - *
> - *    OS Test - Silicon Graphics, Inc.
> - *
> - *    TEST IDENTIFIER	: gethostname01
> - *
> - *    EXECUTED BY	: anyone
> - *
> - *    TEST TITLE	: Basic test for gethostname(2)
> - *
> - *    PARENT DOCUMENT	: usctpl01
> - *
> - *    TEST CASE TOTAL	: 1
> - *
> - *    WALL CLOCK TIME	: 1
> - *
> - *    CPU TYPES		: ALL
> - *
> - *    AUTHOR		: William Roske
> - *
> - *    CO-PILOT		: Dave Fenner
> - *
> - *    DATE STARTED	: 03/30/92
> - *
> - *    INITIAL RELEASE	: UNICOS 7.0
> - *
> - *    TEST CASES
> - *
> - * 	1.) gethostname(2) returns...(See Description)
> - *
> - *    INPUT SPECIFICATIONS
> - * 	The standard options for system call tests are accepted.
> - *	(See the parse_opts(3) man page).
> - *
> - *    DURATION
> - * 	Terminates - with frequency and infinite modes.
> - *
> - *    SIGNALS
> - * 	Uses SIGUSR1 to pause before test if option set.
> - * 	(See the parse_opts(3) man page).
> - *
> - *    RESOURCES
> - * 	None
> - *
> - *    ENVIRONMENTAL NEEDS
> - *      No run-time environmental needs.
> - *
> - *    SPECIAL PROCEDURAL REQUIREMENTS
> - * 	None
> - *
> - *    INTERCASE DEPENDENCIES
> - * 	None
> - *
> - *    DETAILED DESCRIPTION
> - *	This is a Phase I test for the gethostname(2) system call.  It is intended
> - *	to provide a limited exposure of the system call, for now.  It
> - *	should/will be extended when full functional tests are written for
> - *	gethostname(2).
> - *
> - * 	Setup:
> - * 	  Setup signal handling.
> - *	  Pause for SIGUSR1 if option specified.
> - *
> - * 	Test:
> - *	 Loop if the proper options are given.
> - * 	  Execute system call
> - *	  Check return code, if system call failed (return=-1)
> - *		Log the errno and Issue a FAIL message.
> - *	  Otherwise, Issue a PASS message.
> - *
> - * 	Cleanup:
> - * 	  Print errno log and/or timing stats if options given
> - *
> - *
> - *#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#**/
> -
> -#include <errno.h>
> -#include <signal.h>
> -#include <string.h>
> -
> -#include "test.h"
>  
> -void setup();
> -void cleanup();
> +/*
> + * [Description]
> + *
> + *      This is a Phase I test for the gethostname(2) system call.  It is intended
> + *      to provide a limited exposure of the system call, for now.  It
> + *      should/will be extended when full functional tests are written for
> + *      gethostname(2).
       ^
       Too many spaces here, I suppose that this will render wrong in
       the generated docs.

Also can we please write something more sensible here? Something along the
lines of "Checks that gethostname() succeeds."

> + */
>  
> -char *TCID = "gethostname01";
> -int TST_TOTAL = 1;
> +#include "tst_test.h"
> +#include <stdlib.h>
>  
> -int main(int ac, char **av)
> +static void run(void)
>  {
> -	int lc;
> +	char hname[100];
> +	int ret = gethostname(hname, sizeof(hname));
>  
> -	char hname[100];	/* host name */
> +	if (!ret)
> +		tst_res(TPASS, "gethostname %s", hname)

There is no tst_res(TFAIL, ...) if the call fails.

Also we do have a nice TST_EXP_PASS() macros now that should be used in
this case.

> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		TEST(gethostname(hname, sizeof(hname)));
> -
> -		if (TEST_RETURN == -1) {
> -			tst_resm(TFAIL | TTERRNO, "gethostname failed");
> -			continue;	/* next loop for MTKERNEL */
> -		}
> -
> -		tst_resm(TPASS, "gethostname returned %ld",
> -			 TEST_RETURN);
> -	}
> -
> -	cleanup();
> -	tst_exit();
>  }
>  
> -void setup(void)
> -{
> -
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -}
>  
> -void cleanup(void)
> -{
> -}
> +static struct tst_test test = {
> +	.test_all = run
> +};
> -- 
> 2.41.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
