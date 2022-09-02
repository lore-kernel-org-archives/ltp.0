Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BAE7ECAAD5
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 09:32:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A061F3CA88D
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 11:32:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E3353CA708
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 11:32:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 153A7200C3E
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 11:32:31 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 5756620F4F;
 Fri,  2 Sep 2022 09:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1662111151;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QObm/UsGis7fVXjWi9Lw7LK3Lw6HXh+LP4+T9QV1f8Y=;
 b=uX7xVVRgmOYy/iaVSDvFnrCp+ThFjLA1rkA6fWgGWGnLQ7v44rfv9xy6s81BXHqk7wxgLs
 zWE7Sxj2+I2daxqZohneZoECA65rNEJyielZft97/Pu+Fg0RS0Jt2VEIOQoFrz87e/UVkh
 R3ovpEB6RUfps4fVLpSBxleuOIF43bE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1662111151;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QObm/UsGis7fVXjWi9Lw7LK3Lw6HXh+LP4+T9QV1f8Y=;
 b=FvuuIvS2mMPiz9Xz4yjnEeedfgpMmfdPpmySk4IY53YOc0buLgAeziPr50tm6yVwhoBxMo
 d0fZdlP1bw/d8HAw==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id E36162C141;
 Fri,  2 Sep 2022 09:32:25 +0000 (UTC)
References: <20220804121946.19564-1-pvorel@suse.cz>
 <20220804121946.19564-5-pvorel@suse.cz>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 02 Sep 2022 10:32:22 +0100
In-reply-to: <20220804121946.19564-5-pvorel@suse.cz>
Message-ID: <87y1v215qp.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 04/10] tst_mount_device.sh: Cover early
 tst_umount call
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


Acked-by: Richard Palethorpe <rpalethorpe@suse.com>

Petr Vorel <pvorel@suse.cz> writes:

> Caused by tst_brk in tests with TST_MOUNT_DEVICE=1.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> New in v3
>
>  lib/newlib_tests/shell/tst_mount_device.sh | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/lib/newlib_tests/shell/tst_mount_device.sh b/lib/newlib_tests/shell/tst_mount_device.sh
> index c8f185626..561f878d2 100755
> --- a/lib/newlib_tests/shell/tst_mount_device.sh
> +++ b/lib/newlib_tests/shell/tst_mount_device.sh
> @@ -5,7 +5,7 @@
>  TST_MOUNT_DEVICE=1
>  TST_FS_TYPE=ext4
>  TST_TESTFUNC=test
> -TST_CNT=2
> +TST_CNT=3
>  
>  test1()
>  {
> @@ -17,5 +17,10 @@ test2()
>  	EXPECT_PASS "grep '$TST_MNTPOINT $TST_FS_TYPE' /proc/mounts"
>  }
>  
> +test3()
> +{
> +	tst_brk TCONF "quit early to test early tst_umount"
> +}
> +
>  . tst_test.sh
>  tst_run
> -- 
> 2.37.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
