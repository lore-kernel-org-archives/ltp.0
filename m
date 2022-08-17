Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6E7C25B08
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 00:00:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4D2D3C98D4
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 02:00:04 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 05B623C954D
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 01:59:53 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A937E600564
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 01:59:52 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8F0E26135E;
 Wed, 17 Aug 2022 23:59:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1AAC433C1;
 Wed, 17 Aug 2022 23:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1660780789;
 bh=BCWaD0W3+D8jP5xghOGVmxEqzKuUAV4FiTkSKXXOZtg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Z8iUEryA+ZMyyhMqJaUYvp0PAXGgreOuEdVM3F23bmtnGA0SLNeFEFy+TWKDMG4jR
 Yd8vqMEIVnwbYG3vFAXGU72cDy4rw4i1sU24+qM1d6pkZc6dexQZ8mH6zjLghwEXPT
 VfBe1nXcRRF8CsgUDR0SPeIPMKm3N/9YuC3W9f9f+t6xjxpmNJKfZR/WZ9Bgos1Yzf
 d07BhwDPhh9IPYOvoPjAdZXz4mOu3m42EsCa0qjRFoaBXwuVRdObX9tXiDG9U83QqD
 BAOEagw0oXJxK1ZdU9+0S9DA1MVqkrTgDV3sW5/TLuIrWmTouUi0cv0rGvIbjjU0ej
 ZllVBf0Ot7YEw==
Date: Wed, 17 Aug 2022 16:59:48 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Yv2A9Ggkv/NBrTd4@magnolia>
References: <20220817204015.31420-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220817204015.31420-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] API: Allow to use xfs filesystems < 300 MB
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
Cc: linux-xfs@vger.kernel.org, automated-testing@yoctoproject.org,
 ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Aug 17, 2022 at 10:40:15PM +0200, Petr Vorel wrote:
> mkfs.xfs since v5.19.0-rc1 [1] refuses to create filesystems < 300 MB.
> Reuse workaround intended for fstests: set 3 environment variables:
> export TEST_DIR=1 TEST_DEV=1 QA_CHECK_FS=1
> 
> Workaround added to both C API (for .needs_device) and shell API (for
> TST_NEEDS_DEVICE=1).
> 
> Fix includes any use of filesystem (C API: .all_filesystems,
> .format_device, shell API: TST_MOUNT_DEVICE=1, TST_FORMAT_DEVICE=1).
> 
> Fixes various C and shell API failures, e.g.:
> 
> ./mkfs01.sh -f xfs
> mkfs01 1 TINFO: timeout per run is 0h 5m 0s
> tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
> mkfs01 1 TFAIL: 'mkfs -t xfs  -f /dev/loop0 ' failed.
> Filesystem must be larger than 300MB.
> 
> ./creat09
> ...
> tst_test.c:1599: TINFO: Testing on xfs
> tst_test.c:1064: TINFO: Formatting /dev/loop0 with xfs opts='' extra opts=''
> Filesystem must be larger than 300MB.
> 
> Link: https://lore.kernel.org/all/164738662491.3191861.15611882856331908607.stgit@magnolia/
> 
> Reported-by: Martin Doucha <mdoucha@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Dave, please next time remember there are other testsuites testing XFS,

Dave?? <cough>

> not just fstests :). How long do you plan to keep this workaround?

Forever.  In the ideal world we'll some day get around to restructuring
all the xfstests that do tricky things with sub-500M filesystems, but
that's the unfortunate part of removing support for small disks.

Most of the fstests don't care about the fs size and so they'll run with
the configured storage (some tens or millions of gigabytes) so we're
mostly using the same fs sizes that users are expected to have.

> LTP community: do we want to depend on this behavior or we just increase from 256MB to 301 MB
> (either for XFS or for all). It might not be a good idea to test size users are required
> to use.

It might *not*? <confused>

--D

> 
> Kind regards,
> Petr
>  lib/tst_test.c            | 7 +++++++
>  testcases/lib/tst_test.sh | 6 +++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 4b4dd125d..657348732 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1160,6 +1160,13 @@ static void do_setup(int argc, char *argv[])
>  	if (tst_test->all_filesystems)
>  		tst_test->needs_device = 1;
>  
> +	/* allow to use XFS filesystem < 300 MB */
> +	if (tst_test->needs_device) {
> +		putenv("TEST_DIR=1");
> +		putenv("TEST_DEV=1");
> +		putenv("QA_CHECK_FS=1");
> +	}
> +
>  	if (tst_test->min_cpus > (unsigned long)tst_ncpus())
>  		tst_brk(TCONF, "Test needs at least %lu CPUs online", tst_test->min_cpus);
>  
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 24a3d29d8..b42e54ca1 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -671,7 +671,11 @@ tst_run()
>  
>  	[ "$TST_MOUNT_DEVICE" = 1 ] && TST_FORMAT_DEVICE=1
>  	[ "$TST_FORMAT_DEVICE" = 1 ] && TST_NEEDS_DEVICE=1
> -	[ "$TST_NEEDS_DEVICE" = 1 ] && TST_NEEDS_TMPDIR=1
> +	if [ "$TST_NEEDS_DEVICE" = 1 ]; then
> +		TST_NEEDS_TMPDIR=1
> +		# allow to use XFS filesystem < 300 MB
> +		export TEST_DIR=1 TEST_DEV=1 QA_CHECK_FS=1
> +	fi
>  
>  	if [ "$TST_NEEDS_TMPDIR" = 1 ]; then
>  		if [ -z "$TMPDIR" ]; then
> -- 
> 2.37.1
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
