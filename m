Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B8F3C38145
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 09:41:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB4043CA8ED
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 11:41:01 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A2ABD3CA708
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 11:40:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 424FE1A003D3
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 11:40:52 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id A319D20F65;
 Fri,  2 Sep 2022 09:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1662111651;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Le84N20dDhUqw/r+PwhDpJ1yqNAw5vM49u7utv0+CyY=;
 b=PyKHyPxKEiPIvkfNh5SZNzm14+w8XY4bj9aZEe62YJcI0OVHa8Ify+cMiBvq9ORZcrSv/a
 JmaW2hgaJuDABpdGzHpBQw3u2HTcsSa7gwcnGnOfFIHDKZ4L3T7ZINfavbjWnfqM78WJGb
 qTfjiCpuD8SPfLB9xIowL1sb+e2udAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1662111651;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Le84N20dDhUqw/r+PwhDpJ1yqNAw5vM49u7utv0+CyY=;
 b=rACJOoi53bN47eQoB9i7ORZiloUav9HutsrlMMSuiCkPSsVxSDtPVOgIQwpFI21EL4zMRT
 UZzNsu81cHACTcAA==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 347AF2C141;
 Fri,  2 Sep 2022 09:40:46 +0000 (UTC)
References: <20220804121946.19564-1-pvorel@suse.cz>
 <20220804121946.19564-10-pvorel@suse.cz>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 02 Sep 2022 10:40:40 +0100
In-reply-to: <20220804121946.19564-10-pvorel@suse.cz>
Message-ID: <87h71q15ct.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 09/10] shell: Add test for TST_ALL_FILESYSTEMS=1
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

Hi,

Acked-by: Richard Palethorpe <rpalethorpe@suse.com>

Petr Vorel <pvorel@suse.cz> writes:

> Unfortunately GitHub Actions don't have loop devices, thus cannot be run
> in CI:
>
> tst_format_device 1 TINFO: timeout per run is 0h 5m 0s
> /__w/ltp/ltp/lib/tst_device.c:139: TINFO: No free devices found
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
> Reviewed-by: Li Wang <liwang@redhat.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  lib/newlib_tests/shell/tst_all_filesystems.sh | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100755 lib/newlib_tests/shell/tst_all_filesystems.sh
>
> diff --git a/lib/newlib_tests/shell/tst_all_filesystems.sh b/lib/newlib_tests/shell/tst_all_filesystems.sh
> new file mode 100755
> index 000000000..8509a7481
> --- /dev/null
> +++ b/lib/newlib_tests/shell/tst_all_filesystems.sh
> @@ -0,0 +1,27 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
> +
> +TST_ALL_FILESYSTEMS=1
> +TST_TESTFUNC=test
> +TST_CNT=2
> +
> +test1()
> +{
> +	tst_res TPASS "device using filesystem"
> +}
> +
> +test2()
> +{
> +	local pattern
> +
> +
> +	if [ "$TST_FS_TYPE" = "exfat" -o "$TST_FS_TYPE" = "ntfs" ]; then
> +		pattern="|fuseblk"
> +	fi
> +
> +	EXPECT_PASS "grep -E '$TST_MNTPOINT ($TST_FS_TYPE${pattern})' /proc/mounts"
> +}
> +
> +. tst_test.sh
> +tst_run
> -- 
> 2.37.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
