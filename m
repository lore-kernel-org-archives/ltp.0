Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89921C433EF
	for <ltp@archiver.kernel.org>; Mon, 30 May 2022 14:04:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 50D493C2836
	for <ltp@archiver.kernel.org>; Mon, 30 May 2022 16:04:32 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C05DB3C1D12
 for <ltp@lists.linux.it>; Mon, 30 May 2022 16:04:21 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CAC8314004F3
 for <ltp@lists.linux.it>; Mon, 30 May 2022 16:04:20 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 12C8E21986;
 Mon, 30 May 2022 14:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1653919460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3t+Vil9uvaDUEBNFZnDgMB6wqDld10P3aiYi1kU23DY=;
 b=ayO6lTiHopzJN4Qy5xyK7GLGncNEuWrY1AwzTfTiVKYQx8zFvPw2HIYzCFeMiBSKETbMtX
 nYs+sVp1En3QW6tXvmkzvbN4YxjRr3ZUbcmCFG94SXw+mUUYHx5FSERTGEp01VlTRzg1gG
 Z0eHiapk/6nfCRxPF4VRexaRk12AVUE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1653919460;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3t+Vil9uvaDUEBNFZnDgMB6wqDld10P3aiYi1kU23DY=;
 b=DADOovi6phhIZVk5u+sN/J6qvcvIUO/fDvQlfkl1XAVikT8+8ptgjPPhJ9ehTCuSIJzV6e
 Y9/G+l+Y+95RwABQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE40713A84;
 Mon, 30 May 2022 14:04:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id RtzVOOPOlGIVSgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 30 May 2022 14:04:19 +0000
Date: Mon, 30 May 2022 16:04:06 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YpTO1ttcqpbRzxoJ@rei>
References: <20220512194557.30911-1-pvorel@suse.cz>
 <20220512194557.30911-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220512194557.30911-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/8] tst_test.sh: Add $TST_MOUNT_DEVICE
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
> +	if [ "$TST_MOUNT_DEVICE" = 1 -a "$TST_MOUNT_FLAG" = 1 ]; then

Isn't the TST_MOUNT_DEVICE redundant here? We set the mount flag only if
the device was mounted by the library. Or do I miss something?

> +		tst_umount
> +	fi
> +
>  	if [ "$TST_NEEDS_DEVICE" = 1 -a "$TST_DEVICE_FLAG" = 1 ]; then
>  		if ! tst_device release "$TST_DEVICE"; then
>  			tst_res TWARN "Failed to release device '$TST_DEVICE'"
> @@ -632,7 +636,7 @@ tst_run()
>  			NET_SKIP_VARIABLE_INIT|NEEDS_CHECKPOINTS);;
>  			CHECKPOINT_WAIT|CHECKPOINT_WAKE);;
>  			CHECKPOINT_WAKE2|CHECKPOINT_WAKE_AND_WAIT);;
> -			DEV_EXTRA_OPTS|DEV_FS_OPTS|FORMAT_DEVICE);;
> +			DEV_EXTRA_OPTS|DEV_FS_OPTS|FORMAT_DEVICE|MOUNT_DEVICE);;
>  			*) tst_res TWARN "Reserved variable TST_$_tst_i used!";;
>  			esac
>  		done
> @@ -666,6 +670,7 @@ tst_run()
>  
>  	_tst_setup_timer
>  
> +	[ "$TST_MOUNT_DEVICE" = 1 ] && TST_FORMAT_DEVICE=1
>  	[ "$TST_FORMAT_DEVICE" = 1 ] && TST_NEEDS_DEVICE=1
>  	[ "$TST_NEEDS_DEVICE" = 1 ] && TST_NEEDS_TMPDIR=1
>  
> @@ -702,6 +707,11 @@ tst_run()
>  		tst_mkfs $TST_FS_TYPE $TST_DEV_FS_OPTS $TST_DEVICE $TST_DEV_EXTRA_OPTS
>  	fi
>  
> +	if [ "$TST_MOUNT_DEVICE" = 1 ]; then
> +		tst_mount
> +		TST_MOUNT_FLAG=1
> +	fi
> +
>  	[ -n "$TST_NEEDS_CHECKPOINTS" ] && _tst_init_checkpoints
>  
>  	if [ -n "$TST_SETUP" ]; then

Other than that it looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
