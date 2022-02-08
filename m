Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40ECC433EF
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 14:04:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F10443C9B53
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 15:04:41 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B19A13C24D6
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 15:04:33 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 389A860019B
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 15:04:32 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7FEAA210F6;
 Tue,  8 Feb 2022 14:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644329072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lu7JsNbcP8B+ittO31k03BN/1nuN1Q5GebqpSxs7D6U=;
 b=WSX3vFpjbEIhffCBIIDHV1CUDokZdbGsZzrTY2kLc1/Vo2EiUkZAnnhMoOz1luK0lje1CO
 0gVsfC+PvAVMGXMhRJLIVcxwqXI7gsTHCYOUHx6GscRa24bdSmQ+UUKc50cKwaZ0qeMSnU
 ZKY3XK4p7xjvNIxiah3HPRaX690IToc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644329072;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lu7JsNbcP8B+ittO31k03BN/1nuN1Q5GebqpSxs7D6U=;
 b=8EnC+ULHl72hDbrGPGY+XTy4m/e/9kUMspzsyIXH3eVcMcfQyAAahh0G3zYMomE22t0WLS
 +8c7XmGBw71TOSCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6AFFF13C99;
 Tue,  8 Feb 2022 14:04:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id lwO4GHB4AmIidgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 08 Feb 2022 14:04:32 +0000
Date: Tue, 8 Feb 2022 15:06:36 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YgJ47NfU3vP3XcyE@yuki>
References: <20220126181210.24897-1-pvorel@suse.cz>
 <20220126181210.24897-3-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220126181210.24897-3-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/5] tst_test.sh: tst_mkfs(): Add support for
 extra opts
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
> Allow to pass options after device name
> (to sync with C API).
> 
> NOTE: not adding it to legacy shell API (thus no need to change
> test_robind.sh).
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/tst_test.sh | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index eb3bf0df12..4707613158 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -343,9 +343,8 @@ tst_mkfs()
>  	[ -z "$fs_type" ] && fs_type="$TST_DEFAULT_FS_TYPE"
>  
>  	local device=${2:-$TST_DEVICE}
> -	[ $# -ge 1 ] && shift
> -	[ $# -ge 1 ] && shift
> -	local fs_opts="$@"
> +	local fs_opts="$3"
> +	local extra_opts="$4"

Doesn't this actually break the examples described in the
doc/shell-test-api.txt?

There we do have:

tst_mkfs ext4 /dev/device -T largefile

Which obviously parses as "-T" in the fs_opts and "largefile" in the
extra_opts.

I do not think that the support for extra opts can be added this way
without redesigning the tst_mkfs API. Maybe it would make more sense to
just pass the parameters in the same way we end up passing them on a
command line, i.e. we would only interpret the first parameter passed to
tst_mkfs as a filesystem type and pass the rest as $@.

>  	if [ -z "$device" ]; then
>  		tst_brk TBROK "No device specified"
> @@ -353,8 +352,8 @@ tst_mkfs()
>  
>  	tst_require_cmds mkfs.$fs_type
>  
> -	tst_res TINFO "Formatting $device with $fs_type extra opts='$fs_opts'"
> -	ROD_SILENT mkfs.$fs_type $fs_opts $device
> +	tst_res TINFO "Formatting $device with $fs_type opts='$fs_opts' extra opts='$extra_opts'"
> +	ROD_SILENT mkfs.$fs_type $fs_opts $device $extra_opts
>  }
>  
>  # Detect whether running under hypervisor: Microsoft Hyper-V
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
