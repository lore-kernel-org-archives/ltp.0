Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 196D8C6FA82
	for <ltp@archiver.kernel.org>; Mon, 12 Sep 2022 15:08:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9FB0F3CAACA
	for <ltp@archiver.kernel.org>; Mon, 12 Sep 2022 17:08:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B4083C010E
 for <ltp@lists.linux.it>; Mon, 12 Sep 2022 17:08:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 625AE6000EC
 for <ltp@lists.linux.it>; Mon, 12 Sep 2022 17:08:27 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B20EB20371;
 Mon, 12 Sep 2022 15:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662995306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mNg989T4GwjtI8l3s7nCeDlr/Gb2bnU8n05ulqhAX1g=;
 b=ko1bCernvUGMAJzMkCRa5LD0PwU0qqGfXmWQGylDm8hAwYtwVg1Kydfj3BC+mGjPJnewMH
 fi373ADVID9eKXTN6ST2znx24s7deQ9dtTsfE10oi8SpOhMimnf0XHjY+5Z6OLCVYUSByd
 j/04XtuuA3ugtWr2V9R9Mb8U1hpu2OQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662995306;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mNg989T4GwjtI8l3s7nCeDlr/Gb2bnU8n05ulqhAX1g=;
 b=Q8jIs3rnkx+x+elRw/gQF7Z+2PkJwKW0POtIlsnzGdlWmx8pR5+xw/FJNJkGf/LRdjKgPB
 4MTHj5aggpeNQ/Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 94C11139E0;
 Mon, 12 Sep 2022 15:08:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XxEdH2pLH2OcWAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 12 Sep 2022 15:08:26 +0000
Date: Mon, 12 Sep 2022 17:10:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Yx9L3SfGpS9LlcEi@yuki>
References: <20220909141840.18327-1-pvorel@suse.cz>
 <20220909141840.18327-7-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220909141840.18327-7-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 06/10] shell: Add $TST_SKIP_FILESYSTEMS + tests
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> C API struct tst_test skip_filesystems member equivalent.
> 
> Now only running on single filesystem (will be improved in the next
> commit)
> 
> Acked-by: Richard Palethorpe <rpalethorpe@suse.com>
> Reviewed-by: Li Wang <liwang@redhat.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> changes v4->v5:
> * add fuse to lib/newlib_tests/shell/tst_skip_filesystems.sh
> 
>  doc/shell-test-api.txt                        |  2 ++
>  .../shell/tst_skip_filesystems.sh             | 35 +++++++++++++++++++
>  .../shell/tst_skip_filesystems_skip.sh        | 17 +++++++++
>  lib/tst_supported_fs_types.c                  |  1 +
>  testcases/lib/tst_test.sh                     |  6 ++++
>  5 files changed, 61 insertions(+)
>  create mode 100755 lib/newlib_tests/shell/tst_skip_filesystems.sh
>  create mode 100755 lib/newlib_tests/shell/tst_skip_filesystems_skip.sh
> 
> diff --git a/doc/shell-test-api.txt b/doc/shell-test-api.txt
> index 65444541e..18ed144a9 100644
> --- a/doc/shell-test-api.txt
> +++ b/doc/shell-test-api.txt
> @@ -229,6 +229,8 @@ simply by setting right '$TST_FOO'.
>  | 'TST_NEEDS_KCONFIGS'     | Checks kernel kconfigs support for the test (see below).
>  | 'TST_NEEDS_KCONFIGS_IFS' | Used for splitting '$TST_NEEDS_KCONFIGS' variable,
>                               default value is comma, it only supports single character.
> +| 'TST_SKIP_FILESYSTEMS'   | Comma separated list of filesystems on which test will be skipped
> +                             (tst_test.skip_filesystems equivalent).
>  | 'TST_TIMEOUT'            | Maximum timeout set for the test in sec. Must be int >= 1,
>                               or -1 (special value to disable timeout), default is 300.
>                               Variable is meant be set in tests, not by user.
> diff --git a/lib/newlib_tests/shell/tst_skip_filesystems.sh b/lib/newlib_tests/shell/tst_skip_filesystems.sh
> new file mode 100755
> index 000000000..675d0ee5f
> --- /dev/null
> +++ b/lib/newlib_tests/shell/tst_skip_filesystems.sh
> @@ -0,0 +1,35 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
> +
> +TST_MOUNT_DEVICE=1
> +TST_NEEDS_ROOT=1
> +TST_FS_TYPE=ext4
> +TST_TESTFUNC=test
> +TST_SKIP_FILESYSTEMS="btrfs,exfat,ext2,ext3,fuse,ntfs,vfat,tmpfs,xfs"
> +TST_CNT=3
> +
> +test1()
> +{
> +	EXPECT_PASS "cd $TST_MNTPOINT"
> +}
> +
> +test2()
> +{
> +	EXPECT_PASS "grep '$TST_MNTPOINT $TST_FS_TYPE' /proc/mounts"
> +}
> +
> +test3()
> +{
> +	local fs fs_skip
> +
> +	fs=$(grep "$TST_MNTPOINT $TST_FS_TYPE" /proc/mounts | cut -d ' ' -f3)
> +	EXPECT_PASS "[ '$fs' = '$TST_FS_TYPE' ]"
> +
> +	for fs_skip in $TST_SKIP_FILESYSTEMS; do
> +		EXPECT_FAIL "[ $fs = $fs_skip ]"
> +	done
> +}
> +
> +. tst_test.sh
> +tst_run
> diff --git a/lib/newlib_tests/shell/tst_skip_filesystems_skip.sh b/lib/newlib_tests/shell/tst_skip_filesystems_skip.sh
> new file mode 100755
> index 000000000..6748d021d
> --- /dev/null
> +++ b/lib/newlib_tests/shell/tst_skip_filesystems_skip.sh
> @@ -0,0 +1,17 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
> +
> +TST_MOUNT_DEVICE=1
> +TST_NEEDS_ROOT=1
> +TST_FS_TYPE=ext4
> +TST_TESTFUNC=test
> +TST_SKIP_FILESYSTEMS="ext4"
> +
> +test()
> +{
> +	tst_res TFAIL "test should be skipped with TCONF"
> +}
> +
> +. tst_test.sh
> +tst_run
> diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
> index cde162555..41d9bcd27 100644
> --- a/lib/tst_supported_fs_types.c
> +++ b/lib/tst_supported_fs_types.c
> @@ -14,6 +14,7 @@
>  #include "tst_test.h"
>  #include "tst_fs.h"
>  
> +/* NOTE: new filesystem should be also added to tst_skip_filesystems.sh */
>  static const char *const fs_type_whitelist[] = {
>  	"ext2",
>  	"ext3",
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 7c97b69fe..2937bd80c 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -626,6 +626,7 @@ tst_run()
>  	local _tst_max
>  	local _tst_name
>  	local _tst_pattern='[='\''"} \t\/:`$\;].*'
> +	local ret
>  
>  	if [ -n "$TST_TEST_PATH" ]; then
>  		for _tst_i in $(grep '^[^#]*\bTST_' "$TST_TEST_PATH" | sed "s/.*TST_//; s/$_tst_pattern//"); do
> @@ -644,6 +645,7 @@ tst_run()
>  			CHECKPOINT_WAIT|CHECKPOINT_WAKE);;
>  			CHECKPOINT_WAKE2|CHECKPOINT_WAKE_AND_WAIT);;
>  			DEV_EXTRA_OPTS|DEV_FS_OPTS|FORMAT_DEVICE|MOUNT_DEVICE);;
> +			SKIP_FILESYSTEMS);;
>  			*) tst_res TWARN "Reserved variable TST_$_tst_i used!";;
>  			esac
>  		done
> @@ -675,6 +677,10 @@ tst_run()
>  			tst_brk TCONF "test requires kernel $TST_MIN_KVER+"
>  	fi
>  
> +	tst_supported_fs -s "$TST_SKIP_FILESYSTEMS" $TST_FS_TYPE
> +	ret=$?
> +	[ $ret -ne 0 ] && return $ret

So we actually depend here on the tst_supported_fs return value. So at
least we have to do return TCONF in the helper binary even if ve move
the messages into the library.

>  	_tst_setup_timer
>  
>  	[ "$TST_MOUNT_DEVICE" = 1 ] && TST_FORMAT_DEVICE=1
> -- 
> 2.37.3
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
