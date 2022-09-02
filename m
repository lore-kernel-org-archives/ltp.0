Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36527C54EE9
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 09:20:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E80473CA708
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 11:20:39 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 304393CA2E6
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 11:20:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E7BC3601236
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 11:20:28 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 51DED20F19;
 Fri,  2 Sep 2022 09:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1662110428;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0VQXAEhmhBZk/h62Q4mPcxwa5QvhGofjRTy4bZLMIPM=;
 b=vuQKaZOlTkBYBEB9lxxP/bsLroDUfDA88fNlYFYSvoMCxbHhbUOJS41fNuMDOXo1aac3uQ
 olIHxBNFfUEKMMxjbRq8ZFlmoToqtpmPB14LdGBiXuZjWhUYK8ccuf+2Cmu4grapPvqhQJ
 mGj0+//ULieOxMqVNEz+1dl5oyo04V4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1662110428;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0VQXAEhmhBZk/h62Q4mPcxwa5QvhGofjRTy4bZLMIPM=;
 b=rtSg7R0jX7IyrTbjniVy0YGUAINQXKC+h94hzTe5l4ZBug8KUcur28SwR8SQVG6e5WY+OC
 NZxs47KeelUxrxCQ==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id E15352C142;
 Fri,  2 Sep 2022 09:20:22 +0000 (UTC)
References: <20220804121946.19564-1-pvorel@suse.cz>
 <20220804121946.19564-2-pvorel@suse.cz>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 02 Sep 2022 10:18:37 +0100
In-reply-to: <20220804121946.19564-2-pvorel@suse.cz>
Message-ID: <87bkry2kv8.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 01/10] tst_test.sh: Fix tst_mkfs() for tmpfs
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
Cc: ltp@lists.linux.it, automated-testing@yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

No response and seems reasonable, please merge!

Acked-by: Richard Palethorpe <rpalethorpe@suse.com>

Petr Vorel <pvorel@suse.cz> writes:

> + add test for it.
>
> This has been broken since ever, but get more problematic when
> $TST_FORMAT_DEVICE got introduced.
>
> Fixes: 7783ac3a0 ("lib/tst_test.sh: Add new shell library")
> Fixes: 95734791c ("tst_test.sh: Add $TST_FORMAT_DEVICE and related vars")
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> New in v3
>
>  lib/newlib_tests/shell/tst_mount_device_tmpfs.sh | 15 +++++++++++++++
>  testcases/lib/tst_test.sh                        |  5 +++++
>  2 files changed, 20 insertions(+)
>  create mode 100755 lib/newlib_tests/shell/tst_mount_device_tmpfs.sh
>
> diff --git a/lib/newlib_tests/shell/tst_mount_device_tmpfs.sh b/lib/newlib_tests/shell/tst_mount_device_tmpfs.sh
> new file mode 100755
> index 000000000..36a78bc85
> --- /dev/null
> +++ b/lib/newlib_tests/shell/tst_mount_device_tmpfs.sh
> @@ -0,0 +1,15 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
> +
> +TST_MOUNT_DEVICE=1
> +TST_FS_TYPE=tmpfs
> +TST_TESTFUNC=test
> +
> +test()
> +{
> +	EXPECT_PASS "cd $TST_MNTPOINT"
> +}
> +
> +. tst_test.sh
> +tst_run
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index a35fa2e7b..b7cf5f3d4 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -351,6 +351,11 @@ tst_mkfs()
>  
>  	opts="$@"
>  
> +	if [ "$fs_type" = tmpfs ]; then
> +		tst_res TINFO "Skipping mkfs for TMPFS filesystem"
> +		return
> +	fi
> +
>  	if [ -z "$opts" ]; then
>  		if [ "$TST_NEEDS_DEVICE" != 1 ]; then
>  			tst_brk "Using default parameters in tst_mkfs requires TST_NEEDS_DEVICE=1"
> -- 
> 2.37.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
