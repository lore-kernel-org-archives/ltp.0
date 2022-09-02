Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C91ECAAD5
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 09:40:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2524B3CA8CE
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 11:40:25 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E3763CA708
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 11:40:15 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 15049600C57
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 11:40:14 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id E276420F67;
 Fri,  2 Sep 2022 09:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1662111613;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2xISFtli1gxL6mQjUDokc2xW72eOyZ9rK+i9/fBzqtY=;
 b=0k/mgsfFuoEuG1N5F8QvJNc5/5hMpLsvd93ffo3BnMOpXxc9Q1Z1FXBwwzOrZSRuA7kIoD
 5XHVVx+vUENMqH75tLn1+Y4E79YUBoYUOGe672LxLnfe+cN7IVVE+V10cdAINL0EmE8qIy
 UB2QlMtLYaDGI3TfB6OoOOQquaVG8Mk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1662111613;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2xISFtli1gxL6mQjUDokc2xW72eOyZ9rK+i9/fBzqtY=;
 b=pYWFTZNWyOI4qPU4Rqv5znvTJUAHRDuwIcpeZxlGfeShcUm097NkIta5mukSwtseyUKKT+
 G8hlF8jkuu7i3PCQ==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 4F4642C141;
 Fri,  2 Sep 2022 09:40:08 +0000 (UTC)
References: <20220804121946.19564-1-pvorel@suse.cz>
 <20220804121946.19564-9-pvorel@suse.cz>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 02 Sep 2022 10:40:05 +0100
In-reply-to: <20220804121946.19564-9-pvorel@suse.cz>
Message-ID: <87ler215du.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 08/10] tst_test.sh: Add $TST_ALL_FILESYSTEMS
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

> $TST_ALL_FILESYSTEMS is shell API equivalent of .all_filesystems from
> C API.
>
> Improve also $TST_SKIP_FILESYSTEMS to behave like .skip_filesystems.
>
> Reviewed-by: Li Wang <liwang@redhat.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Changes v2->v3:
> * Fixed various functional problems
> * Added $TST_SKIP_FILESYSTEMS support
>
>
>
>  doc/shell-test-api.txt    |   6 +-
>  testcases/lib/tst_test.sh | 118 +++++++++++++++++++++++++-------------
>  2 files changed, 82 insertions(+), 42 deletions(-)
>
> diff --git a/doc/shell-test-api.txt b/doc/shell-test-api.txt
> index 0961dc5ef..ecadb8e32 100644
> --- a/doc/shell-test-api.txt
> +++ b/doc/shell-test-api.txt
> @@ -199,6 +199,9 @@ simply by setting right '$TST_FOO'.
>  [options="header"]
>  |=============================================================================
>  | Variable name            | Action done
> +| 'TST_ALL_FILESYSTEMS'    | Testing on all available filesystems (tst_test.all_filesystems equivalent).
> +                             When 'TST_SKIP_FILESYSTEMS' any listed filesystem is not
> +                             included in the resulting list of supported filesystems.
>  | 'TST_DEV_EXTRA_OPTS'     | Pass extra 'mkfs' options _after_ device name,
>                               to 'tst_mkfs', use with 'TST_FORMAT_DEVICE=1'.
>  | 'TST_DEV_FS_OPTS'        | Pass 'mkfs' options _before_ the device name,
> @@ -229,7 +232,8 @@ simply by setting right '$TST_FOO'.
>  | 'TST_NEEDS_KCONFIGS'     | Checks kernel kconfigs support for the test (see below).
>  | 'TST_NEEDS_KCONFIGS_IFS' | Used for splitting '$TST_NEEDS_KCONFIGS' variable,
>                               default value is comma, it only supports single character.
> -| 'TST_SKIP_FILESYSTEMS'   | Comma separated list of filesystems on which test will be skipped.
> +| 'TST_SKIP_FILESYSTEMS'   | Comma separated list of filesystems on which test will be skipped
> +                             (tst_test.skip_filesystems equivalent).
>  | 'TST_TIMEOUT'            | Maximum timeout set for the test in sec. Must be int >= 1,
>                               or -1 (special value to disable timeout), default is 300.
>                               Variable is meant be set in tests, not by user.
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 926053357..b679339a0 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -33,17 +33,7 @@ _tst_do_exit()
>  	local ret=0
>  	TST_DO_EXIT=1
>  
> -	if [ -n "$TST_DO_CLEANUP" -a -n "$TST_CLEANUP" -a -z "$TST_NO_CLEANUP" ]; then
> -		if command -v $TST_CLEANUP >/dev/null 2>/dev/null; then
> -			$TST_CLEANUP
> -		else
> -			tst_res TWARN "TST_CLEANUP=$TST_CLEANUP declared, but function not defined (or cmd not found)"
> -		fi
> -	fi
> -
> -	if [ "$TST_MOUNT_FLAG" = 1 ]; then
> -		tst_umount
> -	fi
> +	[ "$TST_MOUNT_FLAG" = 1 ] && tst_umount
>  
>  	if [ "$TST_NEEDS_DEVICE" = 1 -a "$TST_DEVICE_FLAG" = 1 ]; then
>  		if ! tst_device release "$TST_DEVICE"; then
> @@ -479,6 +469,7 @@ LTPROOT              Prefix for installed LTP (default: /opt/ltp)
>  LTP_COLORIZE_OUTPUT  Force colorized output behaviour (y/1 always, n/0: never)
>  LTP_DEV              Path to the block device to be used (for .needs_device)
>  LTP_DEV_FS_TYPE      Filesystem used for testing (default: ext2)
> +LTP_SINGLE_FS_TYPE   Testing only - specifies filesystem instead all supported (for TST_ALL_FILESYSTEMS=1)
>  LTP_TIMEOUT_MUL      Timeout multiplier (must be a number >=1, ceiled to int)
>  TMPDIR               Base directory for template directory (for .needs_tmpdir, default: /tmp)
>  EOF
> @@ -619,10 +610,33 @@ _tst_init_checkpoints()
>  	export LTP_IPC_PATH
>  }
>  
> +_prepare_device()
> +{
> +	if [ "$TST_FORMAT_DEVICE" = 1 ]; then
> +		tst_device clear "$TST_DEVICE"
> +		tst_mkfs $TST_FS_TYPE $TST_DEV_FS_OPTS $TST_DEVICE $TST_DEV_EXTRA_OPTS
> +	fi
> +
> +	if [ "$TST_MOUNT_DEVICE" = 1 ]; then
> +		tst_mount
> +		TST_MOUNT_FLAG=1
> +	fi
> +}
> +
> +_tst_run_tcases_per_fs()
> +{
> +	for _tst_fs in $(tst_supported_fs -s "$TST_SKIP_FILESYSTEMS"); do
> +		tst_res TINFO "=== Testing on $_tst_fs ==="
> +		TST_FS_TYPE="$_tst_fs"
> +		_tst_run_iterations
> +	done
> +}
> +
>  tst_run()
>  {
>  	local _tst_i
>  	local _tst_data
> +	local _tst_fs
>  	local _tst_max
>  	local _tst_name
>  	local _tst_pattern='[='\''"} \t\/:`$\;].*'
> @@ -631,7 +645,7 @@ tst_run()
>  	if [ -n "$TST_TEST_PATH" ]; then
>  		for _tst_i in $(grep '^[^#]*\bTST_' "$TST_TEST_PATH" | sed "s/.*TST_//; s/$_tst_pattern//"); do
>  			case "$_tst_i" in
> -			DISABLE_APPARMOR|DISABLE_SELINUX);;
> +			ALL_FILESYSTEMS|DISABLE_APPARMOR|DISABLE_SELINUX);;
>  			SETUP|CLEANUP|TESTFUNC|ID|CNT|MIN_KVER);;
>  			OPTS|USAGE|PARSE_ARGS|POS_ARGS);;
>  			NEEDS_ROOT|NEEDS_TMPDIR|TMPDIR|NEEDS_DEVICE|DEVICE);;
> @@ -677,16 +691,29 @@ tst_run()
>  			tst_brk TCONF "test requires kernel $TST_MIN_KVER+"
>  	fi
>  
> -	tst_supported_fs -s "$TST_SKIP_FILESYSTEMS" $TST_FS_TYPE
> -	ret=$?
> -	[ $ret -ne 0 ] && return $ret
> -
> -	_tst_setup_timer
> +	[ -n "$TST_NEEDS_MODULE" ] && tst_require_module "$TST_NEEDS_MODULE"
>  
> +	[ "$TST_ALL_FILESYSTEMS" = 1 ] && TST_MOUNT_DEVICE=1
>  	[ "$TST_MOUNT_DEVICE" = 1 ] && TST_FORMAT_DEVICE=1
>  	[ "$TST_FORMAT_DEVICE" = 1 ] && TST_NEEDS_DEVICE=1
>  	[ "$TST_NEEDS_DEVICE" = 1 ] && TST_NEEDS_TMPDIR=1
>  
> +	if [ "$TST_ALL_FILESYSTEMS" != 1 ]; then
> +		tst_supported_fs -s "$TST_SKIP_FILESYSTEMS" $TST_FS_TYPE
> +		ret=$?
> +		[ $ret -ne 0 ] && return $ret
> +	fi
> +
> +	if [ "$TST_NEEDS_DEVICE" = 1 ]; then
> +		TST_DEVICE=$(tst_device acquire)
> +
> +		if [ ! -b "$TST_DEVICE" -o $? -ne 0 ]; then
> +			unset TST_DEVICE
> +			tst_brk TBROK "Failed to acquire device"
> +		fi
> +		TST_DEVICE_FLAG=1
> +	fi
> +
>  	if [ "$TST_NEEDS_TMPDIR" = 1 ]; then
>  		if [ -z "$TMPDIR" ]; then
>  			export TMPDIR="/tmp"
> @@ -697,35 +724,32 @@ tst_run()
>  		chmod 777 "$TST_TMPDIR"
>  
>  		TST_STARTWD=$(pwd)
> -
>  		cd "$TST_TMPDIR"
>  	fi
>  
> -	TST_MNTPOINT="${TST_MNTPOINT:-$PWD/mntpoint}"
> -	if [ "$TST_NEEDS_DEVICE" = 1 ]; then
> -
> -		TST_DEVICE=$(tst_device acquire)
> +	[ -n "$TST_NEEDS_CHECKPOINTS" ] && _tst_init_checkpoints
>  
> -		if [ ! -b "$TST_DEVICE" -o $? -ne 0 ]; then
> -			unset TST_DEVICE
> -			tst_brk TBROK "Failed to acquire device"
> -		fi
> +	TST_MNTPOINT="${TST_MNTPOINT:-$PWD/mntpoint}"
>  
> -		TST_DEVICE_FLAG=1
> +	if [ "$TST_ALL_FILESYSTEMS" = 1 ]; then
> +		_tst_run_tcases_per_fs
> +	else
> +		_tst_run_iterations
>  	fi
>  
> -	[ -n "$TST_NEEDS_MODULE" ] && tst_require_module "$TST_NEEDS_MODULE"
> +	_tst_do_exit
> +}
>  
> -	if [ "$TST_FORMAT_DEVICE" = 1 ]; then
> -		tst_mkfs $TST_FS_TYPE $TST_DEV_FS_OPTS $TST_DEVICE $TST_DEV_EXTRA_OPTS
> -	fi
> +_tst_run_iterations()
> +{
> +	local _tst_i=$TST_ITERATIONS
> +	local _tst_j
>  
> -	if [ "$TST_MOUNT_DEVICE" = 1 ]; then
> -		tst_mount
> -		TST_MOUNT_FLAG=1
> -	fi
> +	[ "$TST_NEEDS_TMPDIR" = 1 ] && cd "$TST_TMPDIR"
>  
> -	[ -n "$TST_NEEDS_CHECKPOINTS" ] && _tst_init_checkpoints
> +	_prepare_device
> +
> +	_tst_setup_timer
>  
>  	if [ -n "$TST_SETUP" ]; then
>  		if command -v $TST_SETUP >/dev/null 2>/dev/null; then
> @@ -737,20 +761,32 @@ tst_run()
>  	fi
>  
>  	#TODO check that test reports some results for each test function call
> -	while [ $TST_ITERATIONS -gt 0 ]; do
> +	while [ $_tst_i -gt 0 ]; do
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
>  			_tst_run_tests
>  		fi
> -		TST_ITERATIONS=$((TST_ITERATIONS-1))
> +		_tst_i=$((_tst_i-1))
>  	done
> -	_tst_do_exit
> +
> +	if [ -n "$TST_DO_CLEANUP" -a -n "$TST_CLEANUP" -a -z "$TST_NO_CLEANUP" ]; then
> +		if command -v $TST_CLEANUP >/dev/null 2>/dev/null; then
> +			$TST_CLEANUP
> +		else
> +			tst_res TWARN "TST_CLEANUP=$TST_CLEANUP declared, but function not defined (or cmd not found)"
> +		fi
> +	fi
> +
> +	if [ "$TST_MOUNT_FLAG" = 1 ]; then
> +		tst_umount
> +		TST_MOUNT_FLAG=
> +	fi
>  }
>  
>  _tst_run_tests()
> -- 
> 2.37.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
