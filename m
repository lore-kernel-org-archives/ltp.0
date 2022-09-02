Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9D7C38145
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 09:28:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C2F73CA8C7
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 11:28:39 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C9153CA708
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 11:28:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 233F9200C39
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 11:28:21 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 111A020F3C;
 Fri,  2 Sep 2022 09:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1662110901;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s7jVkExq1eTDn6aM7SyMZxIXjLRupLzxPW41/XG3rs4=;
 b=mhf1BspQqoX8F5W2IS2RZQd5KhH/y2p2B8KImFWUeNItXqXfDzbVDwBD/YK4QkWAio/X8U
 fIkfnDAerxQajkrPOzVGNDOjQG8+foaKwHX2lnvbBkI/9sQFXjeFQj4XXgFEr+G/1zv42Q
 56pN94stoOhcFAO/a+YaK/ewuY2EVOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1662110901;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s7jVkExq1eTDn6aM7SyMZxIXjLRupLzxPW41/XG3rs4=;
 b=VAyfqP6IW4feUEUX8aJ6cgtbsJWJrVJHMw8bsHe7E0HQWCjUbVq4p8L+/0VidbnmJCCLg2
 RPA6p51Ej5N8RaBw==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 4B0902C141;
 Fri,  2 Sep 2022 09:28:15 +0000 (UTC)
References: <20220804121946.19564-1-pvorel@suse.cz>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 02 Sep 2022 10:26:01 +0100
In-reply-to: <20220804121946.19564-1-pvorel@suse.cz>
Message-ID: <877d2m2ki3.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 00/10] shell: nfs: $TST_ALL_FILESYSTEMS
 (.all_filesystems)
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

If there are no objections then let's merge.

Acked-by: Richard Palethorpe <rpalethorpe@suse.com>

Petr Vorel <pvorel@suse.cz> writes:

> Hi,
>
> changes v2->v3:
> * add $TST_SKIP_FILESYSTEMS implementation
> * various fixes for tst_test.sh + tests
>   - tst_test.sh: Fix tst_mkfs() for tmpfs
>
> Diff to v2:
>
> diff --git doc/shell-test-api.txt doc/shell-test-api.txt
> index 93073be13..ecadb8e32 100644
> --- doc/shell-test-api.txt
> +++ doc/shell-test-api.txt
> @@ -200,6 +200,8 @@ simply by setting right '$TST_FOO'.
>  |=============================================================================
>  | Variable name            | Action done
>  | 'TST_ALL_FILESYSTEMS'    | Testing on all available filesystems (tst_test.all_filesystems equivalent).
> +                             When 'TST_SKIP_FILESYSTEMS' any listed filesystem is not
> +                             included in the resulting list of supported filesystems.
>  | 'TST_DEV_EXTRA_OPTS'     | Pass extra 'mkfs' options _after_ device name,
>                               to 'tst_mkfs', use with 'TST_FORMAT_DEVICE=1'.
>  | 'TST_DEV_FS_OPTS'        | Pass 'mkfs' options _before_ the device name,
> @@ -230,6 +232,8 @@ simply by setting right '$TST_FOO'.
>  | 'TST_NEEDS_KCONFIGS'     | Checks kernel kconfigs support for the test (see below).
>  | 'TST_NEEDS_KCONFIGS_IFS' | Used for splitting '$TST_NEEDS_KCONFIGS' variable,
>                               default value is comma, it only supports single character.
> +| 'TST_SKIP_FILESYSTEMS'   | Comma separated list of filesystems on which test will be skipped
> +                             (tst_test.skip_filesystems equivalent).
>  | 'TST_TIMEOUT'            | Maximum timeout set for the test in sec. Must be int >= 1,
>                               or -1 (special value to disable timeout), default is 300.
>                               Variable is meant be set in tests, not by user.
> diff --git include/tst_fs.h include/tst_fs.h
> index 8159b99eb..2fe97f174 100644
> --- include/tst_fs.h
> +++ include/tst_fs.h
> @@ -182,6 +182,16 @@ enum tst_fs_impl {
>   */
>  enum tst_fs_impl tst_fs_is_supported(const char *fs_type);
>  
> +/*
> + * Check filesystem support (@see tst_fs_is_supported()), but consider also
> + * filesystems to skip.
> + *
> + * @fs_type A filesystem name to check the support for.
> + * @skiplist A NULL terminated array of filesystems to skip.
> + */
> +enum tst_fs_impl tst_fs_is_supported_skiplist(const char *fs_type, const char
> +					      *const *skiplist);
> +
>  /*
>   * Returns NULL-terminated array of kernel-supported filesystems.
>   *
> diff --git lib/newlib_tests/shell/tst_mount_device.sh lib/newlib_tests/shell/tst_mount_device.sh
> index c8f185626..561f878d2 100755
> --- lib/newlib_tests/shell/tst_mount_device.sh
> +++ lib/newlib_tests/shell/tst_mount_device.sh
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
> diff --git lib/newlib_tests/shell/tst_mount_device_tmpfs.sh lib/newlib_tests/shell/tst_mount_device_tmpfs.sh
> new file mode 100755
> index 000000000..36a78bc85
> --- /dev/null
> +++ lib/newlib_tests/shell/tst_mount_device_tmpfs.sh
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
> diff --git lib/newlib_tests/shell/tst_skip_filesystems.sh lib/newlib_tests/shell/tst_skip_filesystems.sh
> new file mode 100755
> index 000000000..dd57d6b42
> --- /dev/null
> +++ lib/newlib_tests/shell/tst_skip_filesystems.sh
> @@ -0,0 +1,34 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
> +
> +TST_MOUNT_DEVICE=1
> +TST_FS_TYPE=ext4
> +TST_TESTFUNC=test
> +TST_SKIP_FILESYSTEMS="btrfs,ext2,ext3,xfs,vfat,exfat,ntfs,tmpfs"
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
> diff --git lib/newlib_tests/shell/tst_skip_filesystems_skip.sh lib/newlib_tests/shell/tst_skip_filesystems_skip.sh
> new file mode 100755
> index 000000000..0d291a0a0
> --- /dev/null
> +++ lib/newlib_tests/shell/tst_skip_filesystems_skip.sh
> @@ -0,0 +1,16 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
> +
> +TST_MOUNT_DEVICE=1
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
> diff --git lib/tst_supported_fs_types.c lib/tst_supported_fs_types.c
> index 9726d193a..8c9379c1b 100644
> --- lib/tst_supported_fs_types.c
> +++ lib/tst_supported_fs_types.c
> @@ -134,6 +134,24 @@ enum tst_fs_impl tst_fs_is_supported(const char *fs_type)
>  	return TST_FS_UNSUPPORTED;
>  }
>  
> +enum tst_fs_impl tst_fs_is_supported_skiplist(const char *fs_type, const char
> +					      *const *skiplist)
> +{
> +	int ret;
> +
> +	ret = tst_fs_is_supported(fs_type);
> +
> +	if (!ret)
> +		return ret;
> +
> +	if (tst_fs_in_skiplist(fs_type, skiplist)) {
> +		tst_brk(TCONF, "%s is not supported by the test",
> +			fs_type);
> +	}
> +
> +	return ret;
> +}
> +
>  const char **tst_get_supported_fs_types(const char *const *skiplist)
>  {
>  	unsigned int i, j = 0;
> diff --git testcases/lib/tst_supported_fs.c testcases/lib/tst_supported_fs.c
> index 43eac194f..75945c809 100644
> --- testcases/lib/tst_supported_fs.c
> +++ testcases/lib/tst_supported_fs.c
> @@ -5,42 +5,74 @@
>   */
>  
>  #include <stdio.h>
> +#include <stdlib.h>
>  #include <string.h>
>  
> +#define SKIP_DELIMITER ','
> +
>  #define TST_NO_DEFAULT_MAIN
>  #include "tst_test.h"
>  #include "tst_fs.h"
>  
>  static void usage(void)
>  {
> -	fprintf(stderr, "Usage: tst_supported_fs [fs_type]\n");
> +	fprintf(stderr, "Usage: tst_supported_fs [-s skip_list] [fs_type]\n");
>  	fprintf(stderr, "   If fs_type is supported, return 0\n");
>  	fprintf(stderr, "   If fs_type isn't supported, return 1\n");
>  	fprintf(stderr, "   If fs_type isn't specified, print the list of supported filesystems\n");
>  	fprintf(stderr, "   fs_type - a specified filesystem type\n");
> +	fprintf(stderr, "   skip_list - filesystems to skip, delimiter: '%c'\n",
> +			SKIP_DELIMITER);
>  }
>  
>  int main(int argc, char *argv[])
>  {
> -	const char *skiplist[] = {"tmpfs", NULL};
>  	const char *const *filesystems;
> -	int i;
> +	int i, ret, cnt = 1;
> +	char **skiplist = NULL;
> +	char *fs;
>  
> -	if (argc > 2) {
> -		fprintf(stderr, "Can't specify multiple fs_type\n");
> -		usage();
> -		return 2;
> +	while ((ret = getopt(argc, argv, "hs:"))) {
> +		if (ret < 0)
> +			break;
> +
> +		switch (ret) {
> +		case '?':
> +			return 1;
> +
> +		case 'h':
> +			usage();
> +			return 0;
> +
> +		case 's':
> +			fs = optarg;
> +			for (i = 0; fs[i]; i++) {
> +				if (optarg[i] == SKIP_DELIMITER)
> +					cnt++;
> +			}
> +			skiplist = malloc(++cnt * sizeof(char *));
> +			if (!skiplist) {
> +				fprintf(stderr, "malloc() failed\n");
> +				return 1;
> +			}
> +
> +			fs = optarg;
> +			for (i = 0; i < cnt; i++)
> +				skiplist[i] = strtok_r(fs, TST_TO_STR(SKIP_DELIMITER), &fs);
> +			break;
> +		}
>  	}
>  
> -	if (argv[1] && !strcmp(argv[1], "-h")) {
> +	if (argc - optind > 1) {
> +		fprintf(stderr, "Can't specify multiple fs_type\n");
>  		usage();
> -		return 0;
> +		return 2;
>  	}
>  
> -	if (argv[1])
> -		return !tst_fs_is_supported(argv[1]);
> +	if (optind < argc)
> +		return !tst_fs_is_supported_skiplist(argv[optind], (const char * const*)skiplist);
>  
> -	filesystems = tst_get_supported_fs_types(skiplist);
> +	filesystems = tst_get_supported_fs_types((const char * const*)skiplist);
>  	for (i = 0; filesystems[i]; i++)
>  		printf("%s\n", filesystems[i]);
>  
> diff --git testcases/lib/tst_test.sh testcases/lib/tst_test.sh
> index 54b505e44..b679339a0 100644
> --- testcases/lib/tst_test.sh
> +++ testcases/lib/tst_test.sh
> @@ -28,12 +28,13 @@ fi
>  trap "tst_brk TBROK 'test interrupted'" INT
>  trap "unset _tst_setup_timer_pid; tst_brk TBROK 'test terminated'" TERM
>  
> -# FIXME: debug called more times => check things moved out of it
>  _tst_do_exit()
>  {
>  	local ret=0
>  	TST_DO_EXIT=1
>  
> +	[ "$TST_MOUNT_FLAG" = 1 ] && tst_umount
> +
>  	if [ "$TST_NEEDS_DEVICE" = 1 -a "$TST_DEVICE_FLAG" = 1 ]; then
>  		if ! tst_device release "$TST_DEVICE"; then
>  			tst_res TWARN "Failed to release device '$TST_DEVICE'"
> @@ -50,6 +51,8 @@ _tst_do_exit()
>  		rm $LTP_IPC_PATH
>  	fi
>  
> +	_tst_cleanup_timer
> +
>  	if [ $TST_FAIL -gt 0 ]; then
>  		ret=$((ret|1))
>  	fi
> @@ -338,6 +341,11 @@ tst_mkfs()
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
> @@ -461,6 +469,7 @@ LTPROOT              Prefix for installed LTP (default: /opt/ltp)
>  LTP_COLORIZE_OUTPUT  Force colorized output behaviour (y/1 always, n/0: never)
>  LTP_DEV              Path to the block device to be used (for .needs_device)
>  LTP_DEV_FS_TYPE      Filesystem used for testing (default: ext2)
> +LTP_SINGLE_FS_TYPE   Testing only - specifies filesystem instead all supported (for TST_ALL_FILESYSTEMS=1)
>  LTP_TIMEOUT_MUL      Timeout multiplier (must be a number >=1, ceiled to int)
>  TMPDIR               Base directory for template directory (for .needs_tmpdir, default: /tmp)
>  EOF
> @@ -616,10 +625,9 @@ _prepare_device()
>  
>  _tst_run_tcases_per_fs()
>  {
> -	for _tst_fs in $(tst_supported_fs); do
> -		tst_res TINFO "Testing on $_tst_fs"
> +	for _tst_fs in $(tst_supported_fs -s "$TST_SKIP_FILESYSTEMS"); do
> +		tst_res TINFO "=== Testing on $_tst_fs ==="
>  		TST_FS_TYPE="$_tst_fs"
> -		_prepare_device
>  		_tst_run_iterations
>  	done
>  }
> @@ -631,9 +639,11 @@ tst_run()
>  	local _tst_fs
>  	local _tst_max
>  	local _tst_name
> +	local _tst_pattern='[='\''"} \t\/:`$\;].*'
> +	local ret
>  
>  	if [ -n "$TST_TEST_PATH" ]; then
> -		for _tst_i in $(grep '^[^#]*\bTST_' "$TST_TEST_PATH" | sed 's/.*TST_//; s/[='\''"} \t\/:`].*//'); do
> +		for _tst_i in $(grep '^[^#]*\bTST_' "$TST_TEST_PATH" | sed "s/.*TST_//; s/$_tst_pattern//"); do
>  			case "$_tst_i" in
>  			ALL_FILESYSTEMS|DISABLE_APPARMOR|DISABLE_SELINUX);;
>  			SETUP|CLEANUP|TESTFUNC|ID|CNT|MIN_KVER);;
> @@ -649,11 +659,12 @@ tst_run()
>  			CHECKPOINT_WAIT|CHECKPOINT_WAKE);;
>  			CHECKPOINT_WAKE2|CHECKPOINT_WAKE_AND_WAIT);;
>  			DEV_EXTRA_OPTS|DEV_FS_OPTS|FORMAT_DEVICE|MOUNT_DEVICE);;
> +			SKIP_FILESYSTEMS);;
>  			*) tst_res TWARN "Reserved variable TST_$_tst_i used!";;
>  			esac
>  		done
>  
> -		for _tst_i in $(grep '^[^#]*\b_tst_' "$TST_TEST_PATH" | sed 's/.*_tst_//; s/[="} \t\/:`].*//'); do
> +		for _tst_i in $(grep '^[^#]*\b_tst_' "$TST_TEST_PATH" | sed "s/.*_tst_//; s/$_tst_pattern//"); do
>  			tst_res TWARN "Private variable or function _tst_$_tst_i used!"
>  		done
>  	fi
> @@ -687,6 +698,12 @@ tst_run()
>  	[ "$TST_FORMAT_DEVICE" = 1 ] && TST_NEEDS_DEVICE=1
>  	[ "$TST_NEEDS_DEVICE" = 1 ] && TST_NEEDS_TMPDIR=1
>  
> +	if [ "$TST_ALL_FILESYSTEMS" != 1 ]; then
> +		tst_supported_fs -s "$TST_SKIP_FILESYSTEMS" $TST_FS_TYPE
> +		ret=$?
> +		[ $ret -ne 0 ] && return $ret
> +	fi
> +
>  	if [ "$TST_NEEDS_DEVICE" = 1 ]; then
>  		TST_DEVICE=$(tst_device acquire)
>  
> @@ -713,9 +730,8 @@ tst_run()
>  	[ -n "$TST_NEEDS_CHECKPOINTS" ] && _tst_init_checkpoints
>  
>  	TST_MNTPOINT="${TST_MNTPOINT:-$PWD/mntpoint}"
> -	[ -z "$TST_ALL_FILESYSTEMS" ] && _prepare_device
>  
> -	if [ -n "$TST_ALL_FILESYSTEMS" ]; then
> +	if [ "$TST_ALL_FILESYSTEMS" = 1 ]; then
>  		_tst_run_tcases_per_fs
>  	else
>  		_tst_run_iterations
> @@ -727,9 +743,12 @@ tst_run()
>  _tst_run_iterations()
>  {
>  	local _tst_i=$TST_ITERATIONS
> +	local _tst_j
>  
>  	[ "$TST_NEEDS_TMPDIR" = 1 ] && cd "$TST_TMPDIR"
>  
> +	_prepare_device
> +
>  	_tst_setup_timer
>  
>  	if [ -n "$TST_SETUP" ]; then
> @@ -746,8 +765,8 @@ _tst_run_iterations()
>  		if [ -n "$TST_TEST_DATA" ]; then
>  			tst_require_cmds cut tr wc
>  			_tst_max=$(( $(echo $TST_TEST_DATA | tr -cd "$TST_TEST_DATA_IFS" | wc -c) +1))
> -			for _tst_i in $(seq $_tst_max); do
> -				_tst_data="$(echo "$TST_TEST_DATA" | cut -d"$TST_TEST_DATA_IFS" -f$_tst_i)"
> +			for _tst_j in $(seq $_tst_max); do
> +				_tst_data="$(echo "$TST_TEST_DATA" | cut -d"$TST_TEST_DATA_IFS" -f$_tst_j)"
>  				_tst_run_tests "$_tst_data"
>  			done
>  		else
> @@ -766,9 +785,8 @@ _tst_run_iterations()
>  
>  	if [ "$TST_MOUNT_FLAG" = 1 ]; then
>  		tst_umount
> +		TST_MOUNT_FLAG=
>  	fi
> -
> -	_tst_cleanup_timer
>  }
>  
>  _tst_run_tests()
> diff --git testcases/misc/lvm/generate_lvm_runfile.sh testcases/misc/lvm/generate_lvm_runfile.sh
> index 72b286a69..843dd6bb8 100755
> --- testcases/misc/lvm/generate_lvm_runfile.sh
> +++ testcases/misc/lvm/generate_lvm_runfile.sh
> @@ -16,7 +16,7 @@ generate_runfile()
>  	trap 'tst_brk TBROK "Cannot create LVM runfile"' ERR
>  	INFILE="$LTPROOT/testcases/data/lvm/runfile.tpl"
>  	OUTFILE="$LTPROOT/runtest/lvm.local"
> -	FS_LIST=`tst_supported_fs`
> +	FS_LIST=$(tst_supported_fs -s tmpfs)
>  	echo -n "" >"$OUTFILE"
>  
>  	for fsname in $FS_LIST; do
> diff --git testcases/misc/lvm/prepare_lvm.sh testcases/misc/lvm/prepare_lvm.sh
> index d3ae4b23f..29f386df8 100755
> --- testcases/misc/lvm/prepare_lvm.sh
> +++ testcases/misc/lvm/prepare_lvm.sh
> @@ -70,7 +70,7 @@ prepare_mounts()
>  
>  prepare_lvm()
>  {
> -	FS_LIST=`tst_supported_fs | sort -u`
> +	FS_LIST=$(tst_supported_fs -s tmpfs | sort -u)
>  	ROD mkdir -p "$LVM_TMPDIR"
>  	ROD mkdir -p "$LVM_IMGDIR"
>  	chmod 777 "$LVM_TMPDIR"
> diff --git testcases/network/nfs/nfs_stress/nfs_lib.sh testcases/network/nfs/nfs_stress/nfs_lib.sh
> index a6557177b..b9872bb31 100644
> --- testcases/network/nfs/nfs_stress/nfs_lib.sh
> +++ testcases/network/nfs/nfs_stress/nfs_lib.sh
> @@ -8,6 +8,7 @@ VERSION=${VERSION:=3}
>  NFILES=${NFILES:=1000}
>  SOCKET_TYPE="${SOCKET_TYPE:-udp}"
>  NFS_TYPE=${NFS_TYPE:=nfs}
> +TST_SKIP_FILESYSTEMS="ntfs,vfat"
>  
>  nfs_usage()
>  {
> @@ -205,7 +206,9 @@ nfs_cleanup()
>  		n=$(( n + 1 ))
>  	done
>  
> -	systemctl restart nfs-server
> +	restart_daemon nfs-server
> +	tst_sleep 500ms
>  }
>  
> +. daemonlib.sh
>  . tst_net.sh
>
> Petr Vorel (10):
>   tst_test.sh: Fix tst_mkfs() for tmpfs
>   tst_device: Add clear command
>   tst_test.sh: Allow $ ; after whitelisted variable
>   tst_mount_device.sh: Cover early tst_umount call
>   tst_supported_fs: Implement skip list
>   tst_supported_fs: Support skip list when query single fs
>   shell: Add $TST_SKIP_FILESYSTEMS + tests
>   tst_test.sh: Add $TST_ALL_FILESYSTEMS
>   shell: Add test for TST_ALL_FILESYSTEMS=1
>   nfs: Use TST_ALL_FILESYSTEMS=1
>
>  doc/shell-test-api.txt                        |   5 +
>  include/tst_fs.h                              |  10 ++
>  lib/newlib_tests/shell/tst_all_filesystems.sh |  27 ++++
>  lib/newlib_tests/shell/tst_mount_device.sh    |   7 +-
>  .../shell/tst_mount_device_tmpfs.sh           |  15 +++
>  .../shell/tst_skip_filesystems.sh             |  34 +++++
>  .../shell/tst_skip_filesystems_skip.sh        |  16 +++
>  lib/tst_supported_fs_types.c                  |  18 +++
>  testcases/lib/tst_device.c                    |  20 ++-
>  testcases/lib/tst_supported_fs.c              |  56 ++++++--
>  testcases/lib/tst_test.sh                     | 126 ++++++++++++------
>  testcases/misc/lvm/generate_lvm_runfile.sh    |   2 +-
>  testcases/misc/lvm/prepare_lvm.sh             |   2 +-
>  testcases/network/nfs/nfs_stress/nfs_lib.sh   |  28 ++--
>  14 files changed, 299 insertions(+), 67 deletions(-)
>  create mode 100755 lib/newlib_tests/shell/tst_all_filesystems.sh
>  create mode 100755 lib/newlib_tests/shell/tst_mount_device_tmpfs.sh
>  create mode 100755 lib/newlib_tests/shell/tst_skip_filesystems.sh
>  create mode 100755 lib/newlib_tests/shell/tst_skip_filesystems_skip.sh
>
> -- 
> 2.37.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
