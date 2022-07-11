Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D11DCC433EF
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 04:49:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ADA593CA57F
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 06:49:43 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 920D83CA51D
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 06:49:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 886D810005F4
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 06:49:32 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B0D61222C5;
 Mon, 11 Jul 2022 04:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657514971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aLyHS0ozxOUy+rlcRY2ocDE9tlryh/MYRVGYUZcT4lM=;
 b=Exoj2DEAaOMMm9z+7iup310ZaGgGS8QZ+Nwuh1xjQNqEpuFo7AxO5TV/XEv1R30WUR3MPW
 eHQlvLwb6NffH1fNQRJnNkLOXiybkFs5I03Bk9c0zp1mqrLbe5R9R4hiGGiZy6JgijFFz6
 yxpN3oBLiyRWhLNcSH2ox525AKlTQy8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657514971;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aLyHS0ozxOUy+rlcRY2ocDE9tlryh/MYRVGYUZcT4lM=;
 b=IGAH1pcnkpsyjNShDwRpcldgnmKGoChZrB3mlBMY0a1SGUUf7gI/HLj3FLiI0ZA7a37w+h
 ZRMwlRMUujrR1JCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E287413524;
 Mon, 11 Jul 2022 04:49:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id InKPJ9qry2L0UwAAMHmgww
 (envelope-from <akumar@suse.de>); Mon, 11 Jul 2022 04:49:30 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Mon, 11 Jul 2022 10:19:28 +0530
Message-ID: <2382802.UAoMgutKtF@localhost>
Organization: SUSE
In-Reply-To: <20220708110228.40301-1-luoxiaoyu9@huawei.com>
References: <20220708110228.40301-1-luoxiaoyu9@huawei.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/open03.c: Rewrite open03.c using new LTP
 API
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
Sorry for the ill-formatted previous response.

On Friday, July 8, 2022 4:32:28 PM IST Luo xiaoyu via ltp wrote:
> Signed-off-by: Luo xiaoyu <luoxiaoyu9@huawei.com>
> ---
>  testcases/kernel/syscalls/open/open03.c | 103 +++++++-----------------
>  1 file changed, 27 insertions(+), 76 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/open/open03.c
> b/testcases/kernel/syscalls/open/open03.c index aa15ee9e9..7926e50f4 100644
> --- a/testcases/kernel/syscalls/open/open03.c
> +++ b/testcases/kernel/syscalls/open/open03.c
> @@ -1,90 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
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
>   */
> 
> -#include <sys/types.h>
> -#include <fcntl.h>
> -#include <errno.h>
> -#include <string.h>
> -#include <signal.h>
> -#include "test.h"
> -#include "safe_macros.h"
> -
> -static void setup(void);
> -static void cleanup(void);
> +/*\
> + * [DESCRIPTION]
  ^
  Description
> + *
> + * Testcase to check that open a new file with O_RDWR | O_CREAT
> successfully. + */
> 
> -char *TCID = "open03";
> -int TST_TOTAL = 1;
> +#include "tst_test.h"
> 
> -static char fname[255];
> -static int fd;
> +#define TEST_FILE "testfile"
> 
> -int main(int ac, char **av)
> +static void verify_open(void)
>  {
> -	int lc;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -
> -		TEST(open(fname, O_RDWR | O_CREAT, 0700));
> -		fd = TEST_RETURN;
> -
> -		if (TEST_RETURN == -1) {
> -			tst_resm(TFAIL | TTERRNO,
> -				 "open(%s,O_RDWR|O_CREAT,0700) 
failed", fname);
> -		} else {
> -			tst_resm(TPASS,
> -				 "open(%s, O_RDWR|O_CREAT,0700) 
returned %ld",
> -				 fname, TEST_RETURN);
> -
> -			SAFE_CLOSE(cleanup, fd);
> -			SAFE_UNLINK(cleanup, fname);
> -		}
> +	int fd;
> +
> +	TEST(open(TEST_FILE, O_RDWR | O_CREAT, 0700));
> +	fd = TST_RET;
> +
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TTERRNO,
> +			"open(%s, O_RDWR | O_CREAT, 0700) failed", 
TEST_FILE);
> +	} else {
> +		tst_res(TPASS,
> +			"open(%s, O_RDWR | O_CREAT, 0700) returned 
%ld",
> +			TEST_FILE, TST_RET);
>  	}
 I think we should use TST_EXP_FD() macro here -

	TST_EXP_FD(open(TEST_FILE, O_RDWR | O_CREAT, 0700));
	SAFE_CLOSE(TST_RET);

> 
> -	cleanup();
> -	tst_exit();
> +	SAFE_CLOSE(fd);
> +	SAFE_UNLINK(TEST_FILE);
>  }
> 
> -static void setup(void)
> -{
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	tst_tmpdir();
> 
> -	sprintf(fname, "tfile_%d", getpid());
> -}
> 
> -static void cleanup(void)
> -{
> -	tst_rmdir();
> -}
> +static struct tst_test test = {
> +	.needs_tmpdir = 1,
> +	.test_all = verify_open,
> +};
> --
> 2.17.1

--
Avinesh




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
