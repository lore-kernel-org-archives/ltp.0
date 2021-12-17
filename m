Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 604BCC433EF
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 07:48:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C02A23C9047
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 08:48:21 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AAA5D3C2FA4
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 08:48:11 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6C7241001F2F
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 08:48:11 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 859281F3A1;
 Fri, 17 Dec 2021 07:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639727290;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BNrbOmLRB0Cn53DwZWAa4KhjNb3mJpyzJ48j+d7vmfA=;
 b=ueeOeJR3EK/032LbM5y/0sDafMS/swmOCZoosKXiT0n8k/wc5/M0UzpCEhHEHWM/E2WyyE
 3s1vNIda5X5F1goIhO5VBx6pDnI7TK/8ZJmx2M+eaDkVHsk7asqVBAG2ejjETtXgmwu7eg
 Xt52XrYZRI9ojYoieZRDZvoKB0Gbwsg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639727290;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BNrbOmLRB0Cn53DwZWAa4KhjNb3mJpyzJ48j+d7vmfA=;
 b=ClHIdmJ5aPW0CN4F1DFoza5DDpK4gAFSDk+5ZFp0Df5t7XEV9BKrU/7Uh5rAhLUDpaE7pP
 U7HYSzNn5tWMd7Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6677413C52;
 Fri, 17 Dec 2021 07:48:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CEZpF7pAvGEVZAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 17 Dec 2021 07:48:10 +0000
Date: Fri, 17 Dec 2021 08:48:08 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YbxAuBpxXtPXIwYO@pevik>
References: <1639552849-2251-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639552849-2251-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1639552849-2251-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/4] zram/zram_lib.sh: adapt the situation that
 zram device is being used
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

> If zram-generator package is installed and works, then we can not remove zram module
> because zram swap is being used. This case needs a clean zram environment, change this
> test by using hot_add/hot_remove interface[1]. So even zram device is being used, we
> still can add zram device and remove them in cleanup.

BTW this was added in v4.2-rc1 (6 years ago, 6566d1a32bf7 ("zram: add dynamic
device add/remove functionality")). Hopefully anybody still supporting older
kernels is using old LTP for it.

> Also, zram01,02 case are adjuested to adapt the situation that CONFIG_ZRAM=y.
Very nice, thanks!

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> 1]https://www.kernel.org/doc/html/latest/admin-guide/blockdev/zram.html#add-remove-zram-devices
nit: [1] https://www.kernel.org/doc/html/latest/admin-guide/blockdev/zram.html#add-remove-zram-devices

...
> -	modprobe zram num_devices=$dev_num || \
> -		tst_brk TBROK "failed to insert zram module"
> +	if [ ! -d "/sys/class/zram-control" ]; then
> +		modprobe zram num_devices=$dev_num
> +		module_load=1
> +		dev_start=0
> +		dev_end=$(($dev_num - 1))
> +		tst_res TPASS "all zram devices(/dev/zram0~$dev_end) successfully created"
nit: please all zram devices (/dev/zram0~$dev_end) ... (add space after devices)
> +		return
> +	fi

> -	dev_num_created=$(ls /dev/zram* | wc -w)
> +	dev_start=$(ls /dev/zram* | wc -w)
> +	dev_end=$(($dev_start + $dev_num - 1))

> -	if [ "$dev_num_created" -ne "$dev_num" ]; then
> -		tst_brk TFAIL "unexpected num of devices: $dev_num_created"
> -	fi
> +	for i in $(seq  $dev_start $dev_end); do
> +		cat /sys/class/zram-control/hot_add > /dev/null
> +	done

> -	tst_res TPASS "all zram devices successfully created"
> +	tst_res TPASS "all zram devices(/dev/zram$dev_start~$dev_end) successfully created"
and here.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
