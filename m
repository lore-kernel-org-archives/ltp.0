Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E69C4321E
	for <ltp@archiver.kernel.org>; Mon,  5 Dec 2022 10:46:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A0813CC1FD
	for <ltp@archiver.kernel.org>; Mon,  5 Dec 2022 11:46:10 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F1E03CC1EA
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 11:46:00 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6E6B31400E19
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 11:45:59 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 69DCA1FFF1
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 10:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1670237158;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=awcPfGJCLPs84E6sKJU789SC0toR2BIRrP0ip2FDg4I=;
 b=wktHmYxGfzcN1oAYTMOM50zEknASGDTCY+utuvH2JATvPj3ZvbES9PLtmXCoppsppeTfqr
 RdC5gtTjCtSEqYlfrYiZ+Lo9lQlBXH3ResGREglRk3X6Vi6A+uRhRah1BlO0KZo77BogcA
 jYD77XSJoVC4h1v3XI+57hccNSdGvH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1670237158;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=awcPfGJCLPs84E6sKJU789SC0toR2BIRrP0ip2FDg4I=;
 b=E5/liOlBFLbrxQP5AlXeiNY7VbFpX0xsaoFWNPS4m72rKhbWRL1QH9tD/SkAFwmxugw1RD
 lCxqyt7BiZcCOzAQ==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 423282C141;
 Mon,  5 Dec 2022 10:45:58 +0000 (UTC)
References: <20221201084351.31644-1-akumar@suse.de>
 <20221201111112.8183-1-akumar@suse.de>
User-agent: mu4e 1.8.11; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Avinesh Kumar <akumar@suse.de>
Date: Mon, 05 Dec 2022 10:38:59 +0000
Organization: Linux Private Site
In-reply-to: <20221201111112.8183-1-akumar@suse.de>
Message-ID: <87zgc2t9ga.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] statvfs01: Convert to new LTP API
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

Avinesh Kumar <akumar@suse.de> writes:

> Removed the TINFO statements,
> Added a validation of statvfs.f_namemax field by trying to create
> files of valid and invalid length names.
>
> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---
>  testcases/kernel/syscalls/statvfs/statvfs01.c | 102 ++++++------------
>  1 file changed, 33 insertions(+), 69 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/statvfs/statvfs01.c b/testcases/kernel/syscalls/statvfs/statvfs01.c
> index e3b356c93..b59d2e450 100644
> --- a/testcases/kernel/syscalls/statvfs/statvfs01.c
> +++ b/testcases/kernel/syscalls/statvfs/statvfs01.c
> @@ -1,92 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) Wipro Technologies Ltd, 2005.  All Rights Reserved.
>   *    AUTHOR: Prashant P Yendigeri <prashant.yendigeri@wipro.com>
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it would be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> - *
> - * You should have received a copy of the GNU General Public License along
> - * with this program; if not, write the Free Software Foundation, Inc.,
> - * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> - *
> + * Copyright (c) 2022 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
>   */
> -/*
> - *    DESCRIPTION
> - *      This is a Phase I test for the statvfs(2) system call.
> - *      It is intended to provide a limited exposure of the system call.
> - *	This call behaves similar to statfs.
> +
> +/*\
> + * [Description]
> + *
> + * Verify that statvfs() executes successfully for all
> + * available filesystems. Verify statvfs.f_namemax field
> + * by trying to create files of valid and invalid length names.
>   */
>  
>  #include <stdio.h>
> -#include <unistd.h>
> -#include <errno.h>
>  #include <sys/statvfs.h>
> -#include <stdint.h>
> -
> -#include "test.h"
> -
> -#define TEST_PATH "/"
> +#include "tst_test.h"
>  
> -static void setup(void);
> -static void cleanup(void);
> +#define MNT_POINT "mntpoint"
> +#define TEST_PATH MNT_POINT"/testfile"
>  
> -char *TCID = "statvfs01";
> -int TST_TOTAL = 1;
> -
> -int main(int ac, char **av)
> +static void run(void)
>  {
>  	struct statvfs buf;
> -	int lc;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +	char *valid_fname, *toolong_fname;
> +	long fs_type;
>  
> -		tst_count = 0;
> +	TST_EXP_PASS(statvfs(TEST_PATH, &buf));
>  
> -		TEST(statvfs(TEST_PATH, &buf));
> +	valid_fname = SAFE_MALLOC(buf.f_namemax - 1);
> +	toolong_fname = SAFE_MALLOC(buf.f_namemax + 1);
>  
> -		if (TEST_RETURN == -1) {
> -			tst_resm(TFAIL | TTERRNO, "statvfs(%s, ...) failed",
> -				 TEST_PATH);
> -		} else {
> -			tst_resm(TPASS, "statvfs(%s, ...) passed", TEST_PATH);
> -		}
> +	memset(valid_fname, 'a', buf.f_namemax - 1);
> +	memset(toolong_fname, 'b', buf.f_namemax + 1);
>  
> -	}
> +	fs_type = tst_fs_type(TEST_PATH);
> +	if (fs_type != TST_VFAT_MAGIC && fs_type != TST_EXFAT_MAGIC)
> +		TST_EXP_FD(creat(valid_fname, 0444));

I suppose, thanks to Petr, we now know using a unicode character will
allow you to construct a valid name of the maximum length.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
