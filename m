Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D6CC433EF
	for <ltp@archiver.kernel.org>; Tue, 31 May 2022 12:23:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C4B63C2C02
	for <ltp@archiver.kernel.org>; Tue, 31 May 2022 14:23:14 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E71D3C0574
 for <ltp@lists.linux.it>; Tue, 31 May 2022 14:23:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 23D041000A36
 for <ltp@lists.linux.it>; Tue, 31 May 2022 14:23:02 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B57FE1F903;
 Tue, 31 May 2022 12:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1653999781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rNt2varoSQBlbS6sR1BeowX8RkON4v0HWs43zeWA9EE=;
 b=SfUysB8TI6SC/fxVsz177fFxqxD8xHs7RerypaqqQ0sexAtIv/KGsvsWpQVy1FDvZLxu4D
 OHGYX/T6r1a3k7azItY017qufeJYlc1gwxNQFUwgEQoHKW6XCkdIPPHAD9SCY1NtGIYS6P
 7ks/KrvvrsTY6EqjDki+7oUsDEukA0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1653999781;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rNt2varoSQBlbS6sR1BeowX8RkON4v0HWs43zeWA9EE=;
 b=L6JMV2xXFLABMyBJIszU7HMs8bhDTUUkmyzvv+qwN9o6IocNq4WafQ3pg68PxgpIQLZKco
 LQcMtzB9g2quNbBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F443132F9;
 Tue, 31 May 2022 12:23:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fVDDJaUIlmLGawAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 31 May 2022 12:23:01 +0000
Date: Tue, 31 May 2022 14:25:07 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YpYJI7khXNJOjU4/@yuki>
References: <20220512194557.30911-1-pvorel@suse.cz>
 <20220512194557.30911-7-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220512194557.30911-7-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 6/8] tst_test.sh: Add $TST_ALL_FILESYSTEMS
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +_prepare_device()
> +{
> +	if [ "$TST_FORMAT_DEVICE" = 1 ]; then
> +		tst_clear_device $TST_DEVICE
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
> +	for _tst_fs in $(tst_supported_fs); do
> +		tst_res TINFO "Testing on $_tst_fs"
> +		TST_FS_TYPE="$_tst_fs"
> +		_prepare_device
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
>  
>  	if [ -n "$TST_TEST_PATH" ]; then
>  		for _tst_i in $(grep '^[^#]*\bTST_' "$TST_TEST_PATH" | sed 's/.*TST_//; s/[="} \t\/:`'"'"'].*//'); do
>  			case "$_tst_i" in
> -			DISABLE_APPARMOR|DISABLE_SELINUX);;
> +			ALL_FILESYSTEMS|DISABLE_APPARMOR|DISABLE_SELINUX);;
>  			SETUP|CLEANUP|TESTFUNC|ID|CNT|MIN_KVER);;
>  			OPTS|USAGE|PARSE_ARGS|POS_ARGS);;
>  			NEEDS_ROOT|NEEDS_TMPDIR|TMPDIR|NEEDS_DEVICE|DEVICE);;
> @@ -668,12 +679,23 @@ tst_run()
>  			tst_brk TCONF "test requires kernel $TST_MIN_KVER+"
>  	fi
>  
> -	_tst_setup_timer
> +	[ -n "$TST_NEEDS_MODULE" ] && tst_require_module "$TST_NEEDS_MODULE"
>  
> +	[ "$TST_ALL_FILESYSTEMS" = 1 ] && TST_MOUNT_DEVICE=1
>  	[ "$TST_MOUNT_DEVICE" = 1 ] && TST_FORMAT_DEVICE=1
>  	[ "$TST_FORMAT_DEVICE" = 1 ] && TST_NEEDS_DEVICE=1
>  	[ "$TST_NEEDS_DEVICE" = 1 ] && TST_NEEDS_TMPDIR=1
>  
> +	if [ "$TST_NEEDS_DEVICE" = 1 -a -z "$TST_MOUNT_FLAG" ]; then

I do not get the TST_MOUNT_FLAG, what do we need it for? The tst_run()
should be called exactly once in the test and at this point the
TST_MOUNT_FLAG cannot be set.

> +		TST_DEVICE=$(tst_device acquire)
> +
> +		if [ ! -b "$TST_DEVICE" -o $? -ne 0 ]; then
> +			unset TST_DEVICE
> +			tst_brk TBROK "Failed to acquire device"
> +		fi
> +		TST_DEVICE_FLAG=1
> +	fi
>
>  	if [ "$TST_NEEDS_TMPDIR" = 1 ]; then
>  		if [ -z "$TMPDIR" ]; then
>  			export TMPDIR="/tmp"
> @@ -684,35 +706,30 @@ tst_run()
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
> +	[ -z "$TST_ALL_FILESYSTEMS" ] && _prepare_device
>  
> -		TST_DEVICE_FLAG=1
> +	if [ -n "$TST_ALL_FILESYSTEMS" ]; then
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
>  
> -	if [ "$TST_MOUNT_DEVICE" = 1 ]; then
> -		tst_mount
> -		TST_MOUNT_FLAG=1
> -	fi
> +	[ "$TST_NEEDS_TMPDIR" = 1 ] && cd "$TST_TMPDIR"
>  
> -	[ -n "$TST_NEEDS_CHECKPOINTS" ] && _tst_init_checkpoints
> +	_tst_setup_timer
>  
>  	if [ -n "$TST_SETUP" ]; then
>  		if command -v $TST_SETUP >/dev/null 2>/dev/null; then
> @@ -724,7 +741,7 @@ tst_run()
>  	fi
>  
>  	#TODO check that test reports some results for each test function call
> -	while [ $TST_ITERATIONS -gt 0 ]; do
> +	while [ $_tst_i -gt 0 ]; do
>  		if [ -n "$TST_TEST_DATA" ]; then
>  			tst_require_cmds cut tr wc
>  			_tst_max=$(( $(echo $TST_TEST_DATA | tr -cd "$TST_TEST_DATA_IFS" | wc -c) +1))
> @@ -735,9 +752,22 @@ tst_run()
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
> +	if [ "$TST_MOUNT_DEVICE" = 1 -a "$TST_MOUNT_FLAG" = 1 ]; then
> +		tst_umount
> +	fi
> +
> +	_tst_cleanup_timer
>  }
>  
>  _tst_run_tests()
> -- 
> 2.36.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
