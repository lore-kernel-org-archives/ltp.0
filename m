Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 106B4C433EF
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 04:37:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6AA2E3CA547
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 06:37:31 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5846D3CA38C
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 06:37:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 675FF1A0067E
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 06:37:19 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7A0F8227C4;
 Mon, 11 Jul 2022 04:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657514238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dlPRwKCoSkSPmZFmLaAvKz+bpleDFoR7SoXAS8Y9ZSY=;
 b=XWzI5OpC7LupxQoWhbzc0drFVasdy4AnCW1ENdyVSxEjDkrxls3TewUAgVO4ugwlFGvbVW
 mreuKh7JPo63sGWXD/oiStadPqMOZFBVzK7ya9AgG4+H0usNa5RoGB3MjzOAp0FoYikF4D
 /DgWD4PAisL0g6W63BRIsn1Xq1r5Odw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657514238;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dlPRwKCoSkSPmZFmLaAvKz+bpleDFoR7SoXAS8Y9ZSY=;
 b=318KTibCfjYlAB3kEmu4c64Bxx9WqCoF6AUD73IGo3P/8ZctKOhp4qX1KzI3rVxmZ2f27F
 Ex6oGuWhvkvcruDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E9CC13524;
 Mon, 11 Jul 2022 04:37:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HFe9C/2oy2KbUAAAMHmgww
 (envelope-from <akumar@suse.de>); Mon, 11 Jul 2022 04:37:17 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Mon, 11 Jul 2022 10:07:14 +0530
Message-ID: <2610886.aXfNR8sQ1B@localhost>
Organization: SUSE
In-Reply-To: <20220708110228.40301-1-luoxiaoyu9@huawei.com>
References: <20220708110228.40301-1-luoxiaoyu9@huawei.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Content-Type: multipart/mixed; boundary="===============0217592102=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This is a multi-part message in MIME format.

--===============0217592102==
Content-Type: multipart/alternative; boundary="nextPart1734913.W09cYGYhQn"
Content-Transfer-Encoding: 7Bit

This is a multi-part message in MIME format.

--nextPart1734913.W09cYGYhQn
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi

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

--nextPart1734913.W09cYGYhQn
Content-Transfer-Encoding: 7Bit
Content-Type: text/html; charset="us-ascii"

<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
</head>
<body><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Hi</p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">On Friday, July 8, 2022 4:32:28 PM IST Luo xiaoyu via ltp wrote:</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; Signed-off-by: Luo xiaoyu &lt;luoxiaoyu9@huawei.com&gt;</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; ---</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt;&nbsp; testcases/kernel/syscalls/open/open03.c | 103 +++++++-----------------</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt;&nbsp; 1 file changed, 27 insertions(+), 76 deletions(-)</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; diff --git a/testcases/kernel/syscalls/open/open03.c</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; b/testcases/kernel/syscalls/open/open03.c index aa15ee9e9..7926e50f4 100644</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; --- a/testcases/kernel/syscalls/open/open03.c</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +++ b/testcases/kernel/syscalls/open/open03.c</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; @@ -1,90 +1,41 @@</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +// SPDX-License-Identifier: GPL-2.0-or-later</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt;&nbsp; /*</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt;&nbsp;&nbsp; * Copyright (c) 2000 Silicon Graphics, Inc.&nbsp; All Rights Reserved.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; - *</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; - * This program is free software; you can redistribute it and/or modify it</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; - * under the terms of version 2 of the GNU General Public License as</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; - * published by the Free Software Foundation.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; - *</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; - * This program is distributed in the hope that it would be useful, but</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; - * WITHOUT ANY WARRANTY; without even the implied warranty of</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; - *</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; - * Further, this software is distributed without any warranty that it is</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; - * free of the rightful claim of any third person regarding infringement</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; - * or the like.&nbsp; Any license provided herein, whether implied or</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; - * otherwise, applies only to this software file.&nbsp; Patent licenses, if</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; - * any, provided herein do not apply to combinations of this program with</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; - * other software, or any other product whatsoever.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; - *</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; - * You should have received a copy of the GNU General Public License along</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; - * with this program; if not, write the Free Software Foundation, Inc.,</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; - * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; - *</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; - * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; - * Mountain View, CA&nbsp; 94043, or:</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; - *</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt;&nbsp;&nbsp; */</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -#include &lt;sys/types.h&gt;</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -#include &lt;fcntl.h&gt;</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -#include &lt;errno.h&gt;</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -#include &lt;string.h&gt;</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -#include &lt;signal.h&gt;</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -#include &quot;test.h&quot;</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -#include &quot;safe_macros.h&quot;</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -static void setup(void);</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -static void cleanup(void);</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +/*\</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; + * [DESCRIPTION]</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">^</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Description</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; + *</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; + * Testcase to check that open a new file with O_RDWR | O_CREAT</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; successfully. + */</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -char *TCID = &quot;open03&quot;;</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -int TST_TOTAL = 1;</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +#include &quot;tst_test.h&quot;</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -static char fname[255];</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -static int fd;</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +#define TEST_FILE &quot;testfile&quot;</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -int main(int ac, char **av)</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +static void verify_open(void)</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt;&nbsp; {</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -&nbsp;&nbsp;&nbsp; int lc;</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -&nbsp;&nbsp;&nbsp; tst_parse_opts(ac, av, NULL, NULL);</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -&nbsp;&nbsp;&nbsp; setup();</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -&nbsp;&nbsp;&nbsp; for (lc = 0; TEST_LOOPING(lc); lc++) {</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; tst_count = 0;</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; TEST(open(fname, O_RDWR | O_CREAT, 0700));</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; fd = TEST_RETURN;</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (TEST_RETURN == -1) {</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; tst_resm(TFAIL | TTERRNO,</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;  &quot;open(%s,O_RDWR|O_CREAT,0700) failed&quot;, fname);</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; } else {</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; tst_resm(TPASS,</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;  &quot;open(%s, O_RDWR|O_CREAT,0700) returned %ld&quot;,</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;  fname, TEST_RETURN);</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; SAFE_CLOSE(cleanup, fd);</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; SAFE_UNLINK(cleanup, fname);</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +&nbsp;&nbsp;&nbsp; int fd;</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +&nbsp;&nbsp;&nbsp; TEST(open(TEST_FILE, O_RDWR | O_CREAT, 0700));</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +&nbsp;&nbsp;&nbsp; fd = TST_RET;</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +&nbsp;&nbsp;&nbsp; if (TST_RET == -1) {</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; tst_res(TFAIL | TTERRNO,</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &quot;open(%s, O_RDWR | O_CREAT, 0700) failed&quot;, TEST_FILE);</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +&nbsp;&nbsp;&nbsp; } else {</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; tst_res(TPASS,</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &quot;open(%s, O_RDWR | O_CREAT, 0700) returned %ld&quot;,</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; TEST_FILE, TST_RET);</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt;&nbsp; &nbsp;&nbsp;&nbsp; }</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">I think we should use TST_EXP_FD() macro here -</p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;"><span style="font-family:Droid Sans Mono;"><span style="font-size:-0.083em;"><span style="color:#bbbbbb;">&nbsp;&nbsp;&nbsp; </span><span style="color:#268bd2;">TST_EXP_FD</span><span style="color:#bbbbbb;">(</span><span style="color:#268bd2;">open</span><span style="color:#bbbbbb;">(</span><span style="color:#268bd2;">TEST_FILE</span><span style="color:#bbbbbb;">, </span><span style="color:#268bd2;">O_RDWR</span><span style="color:#bbbbbb;">&nbsp;</span><span style="color:#859900;">|</span><span style="color:#bbbbbb;">&nbsp;</span><span style="color:#268bd2;">O_CREAT</span><span style="color:#bbbbbb;">, </span><span style="color:#859900;">0</span><span style="color:#d33682;">700</span><span style="color:#bbbbbb;">));</span></span></span></p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;"><span style="color:#bbbbbb;">&nbsp;&nbsp;&nbsp; </span><span style="color:#268bd2;">SAFE_CLOSE</span><span style="color:#bbbbbb;">(</span><span style="color:#268bd2;">TST_RET</span><span style="color:#bbbbbb;">);</span></p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -&nbsp;&nbsp;&nbsp; cleanup();</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -&nbsp;&nbsp;&nbsp; tst_exit();</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +&nbsp;&nbsp;&nbsp; SAFE_CLOSE(fd);</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +&nbsp;&nbsp;&nbsp; SAFE_UNLINK(TEST_FILE);</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt;&nbsp; }</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -static void setup(void)</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -{</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -&nbsp;&nbsp;&nbsp; tst_sig(NOFORK, DEF_HANDLER, cleanup);</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -&nbsp;&nbsp;&nbsp; TEST_PAUSE;</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -&nbsp;&nbsp;&nbsp; tst_tmpdir();</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -&nbsp;&nbsp;&nbsp; sprintf(fname, &quot;tfile_%d&quot;, getpid());</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -}</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -static void cleanup(void)</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -{</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -&nbsp;&nbsp;&nbsp; tst_rmdir();</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; -}</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +static struct tst_test test = {</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +&nbsp;&nbsp;&nbsp; .needs_tmpdir = 1,</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +&nbsp;&nbsp;&nbsp; .test_all = verify_open,</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +};</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; --</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; 2.17.1</p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">--</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Avinesh</p>
</body>
</html>
--nextPart1734913.W09cYGYhQn--




--===============0217592102==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0217592102==--



