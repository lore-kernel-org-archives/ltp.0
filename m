Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17668C433F5
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 13:45:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D37923C9B5C
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 14:45:50 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7ED3D3C9B1B
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 14:45:39 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 556A41A00CCE
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 14:45:38 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6D2EA210F6;
 Tue,  8 Feb 2022 13:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644327938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FNHndpDw8/0ROQ3ZUGXqu/7Y3g2Q5hi/C9TQ+O6A/Vk=;
 b=mKaJEK4fEM7+3iTR4Fz6pS+n9e097AUQFMfrFrHcgQ1eigu7QbpWy9IXd3T60wxmG4Rrj1
 it6Zq2Lof5sHoO0W4lIFnEYZb/n6kxnG0LyNNAX9orJ77X6OjabfNLzEhBJaBZLffsTJLz
 ecCDWLhMGqe/aE+WpvbWk2z8ftvvwEE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644327938;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FNHndpDw8/0ROQ3ZUGXqu/7Y3g2Q5hi/C9TQ+O6A/Vk=;
 b=Q1tFJEL4reWpnMlNVxmOeUwFm67O0B8r9SW5ApFb4V7cIS4qHNHprPWNvo0IW1XXq1VzYm
 XYyBf6rSh2NlatAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 59B0313C99;
 Tue,  8 Feb 2022 13:45:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zhghFQJ0AmKvawAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 08 Feb 2022 13:45:38 +0000
Date: Tue, 8 Feb 2022 14:47:42 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YgJ0fnXClLSKuVu+@yuki>
References: <20220126181210.24897-1-pvorel@suse.cz>
 <20220126181210.24897-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220126181210.24897-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/5] tst_test.sh: Add $TST_DEFAULT_FS_TYPE
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
> index b821452e60..0d09e290ce 100755
> --- a/testcases/commands/df/df01.sh
> +++ b/testcases/commands/df/df01.sh
> @@ -23,13 +23,11 @@ usage: $0 [-f <ext2|ext3|ext4|vfat|...>]
>  
>  OPTIONS
>  -f	Specify the type of filesystem to be built.  If not
> -	specified, the default filesystem type (currently ext2)
> +	specified, the default filesystem type (currently $TST_DEFAULT_FS_TYPE)
>  	is used.
>  EOF
>  }
>  
> -TST_FS_TYPE=ext2
> -
>  parse_args()
>  {
>  	TST_FS_TYPE="$2"
> diff --git a/testcases/commands/mkfs/mkfs01.sh b/testcases/commands/mkfs/mkfs01.sh
> index 17c7fb9e4a..e2896858f9 100755
> --- a/testcases/commands/mkfs/mkfs01.sh
> +++ b/testcases/commands/mkfs/mkfs01.sh
> @@ -23,7 +23,7 @@ usage: $0 [-f <ext2|ext3|ext4|vfat|...>]
>  
>  OPTIONS
>  -f	Specify the type of filesystem to be built.  If not
> -	specified, the default filesystem type (currently ext2)
> +	specified, the default filesystem type (currently $TST_DEFAULT_FS_TYPE)
>  	is used.
>  EOF
>  }
> @@ -45,7 +45,7 @@ setup()
>  mkfs_verify_type()
>  {
>  	if [ -z "$1" ]; then
> -		blkid $2 -t TYPE="ext2" >/dev/null
> +		blkid $2 -t TYPE="$TST_DEFAULT_FS_TYPE" >/dev/null
>  	else
>  		if [ "$1" = "msdos" ]; then
>  			blkid $2 -t TYPE="vfat" >/dev/null
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 30614974c3..eb3bf0df12 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -17,6 +17,8 @@ export TST_ITERATIONS=1
>  export TST_TMPDIR_RHOST=0
>  export TST_LIB_LOADED=1
>  
> +export TST_DEFAULT_FS_TYPE="ext2"

Actually if we wanted to sync with the C library it should be:

if [ -z "$TST_FS_TYPE" ]; then
	if [ -n "$LTP_DEV_FS_TYPE" ]; then
		export TST_FS_TYPE="$LTP_DEV_FS_TYPE"
	else
		export TST_FS_TYPE="ext2"
	fi
fi

That's equivalent of the .dev_fs_type in the tst_test structure as we
do:

	if (tst_test->dev_fs_type)
		tdev.fs_type = tst_test->dev_fs_type;
	else
		tdev.fs_type = tst_dev_fs_type();

And the tst_dev_fs_type() returns either $LTP_DEV_FS_TYPE or "ext2" if
it's not defined.

>  . tst_ansi_color.sh
>  . tst_security.sh
>  
> @@ -338,15 +340,13 @@ tst_umount()
>  tst_mkfs()
>  {
>  	local fs_type=${1:-$TST_FS_TYPE}
> +	[ -z "$fs_type" ] && fs_type="$TST_DEFAULT_FS_TYPE"
> +
>  	local device=${2:-$TST_DEVICE}
>  	[ $# -ge 1 ] && shift
>  	[ $# -ge 1 ] && shift
>  	local fs_opts="$@"
>  
> -	if [ -z "$fs_type" ]; then
> -		tst_brk TBROK "No fs_type specified"
> -	fi
> -
>  	if [ -z "$device" ]; then
>  		tst_brk TBROK "No device specified"
>  	fi
> @@ -599,7 +599,7 @@ tst_run()
>  	local _tst_name
>  
>  	if [ -n "$TST_TEST_PATH" ]; then
> -		for _tst_i in $(grep '^[^#]*\bTST_' "$TST_TEST_PATH" | sed 's/.*TST_//; s/[="} \t\/:`].*//'); do
> +		for _tst_i in $(grep '^[^#]*\bTST_' "$TST_TEST_PATH" | sed 's/.*TST_//; s/[="} \t\/:`)].*//'); do
>  			case "$_tst_i" in
>  			DISABLE_APPARMOR|DISABLE_SELINUX);;
>  			SETUP|CLEANUP|TESTFUNC|ID|CNT|MIN_KVER);;
> @@ -614,6 +614,7 @@ tst_run()
>  			NET_SKIP_VARIABLE_INIT|NEEDS_CHECKPOINTS);;
>  			CHECKPOINT_WAIT|CHECKPOINT_WAKE);;
>  			CHECKPOINT_WAKE2|CHECKPOINT_WAKE_AND_WAIT);;
> +			DEFAULT_FS_TYPE);;
>  			*) tst_res TWARN "Reserved variable TST_$_tst_i used!";;
>  			esac
>  		done
> -- 
> 2.34.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
