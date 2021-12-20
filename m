Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E10BC433F5
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 10:45:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6362C3C915E
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 11:45:25 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ADEA33C8F82
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 11:45:16 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8B8A860127A
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 11:45:15 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7FD8C1F381;
 Mon, 20 Dec 2021 10:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639997114;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4NF0MQy9waxRZzzUdnriWijUGf65CGAqZD3pmdB1HcY=;
 b=ambrnHgvMrVnPctAiUElyVICppbqXeqWWUPYD2+bfy+vyiSOz4/pszv8P3RIm2EGxZKPHE
 RPhB/MZTIrTiSMIxe8dCt9IhQLKQOu9eFU7j8v0KoSAbLul9LA/Jp6PRTde4Jj9lZXNqLn
 /z/U5yHZQNnuwWwcGwozgwrCPXE8TCg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639997114;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4NF0MQy9waxRZzzUdnriWijUGf65CGAqZD3pmdB1HcY=;
 b=91BeQcQxXDofWWtJiLoOgsrT6Pc4uexJS8Kgg8xVFjVigzmI5s7CuY67iKTEL6ZmZBoBg5
 9f+la493axlVMBDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 58A8813B83;
 Mon, 20 Dec 2021 10:45:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pPjzErpewGGzMwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 20 Dec 2021 10:45:14 +0000
Date: Mon, 20 Dec 2021 11:45:12 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YcBeuHSm65VC8qmA@pevik>
References: <1639983142-2247-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639983142-2247-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1639983142-2247-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 2/4] zram/zram_lib.sh: adapt the situation that
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

> The two interface was introduced since kernel commit 6566d1a32("zram: add dynamic
> device add/remove functionality")[2] in 2015.6. If kernel supports these two interface,
nit: instead of date (a bit non standard written) I'd just mention the kernel
release, i.e. v4.2-rc1.

> we use hot_add/hot_remove to slove this problem, if not, just check whether zram is
> being used or built in, then skip it on old kernel.

> Also, zram01,02 case are adjuested to adapt the situation that CONFIG_ZRAM=y and can
> run zram01,02 simultaneously on new kernel.

> [1]https://www.kernel.org/doc/html/latest/admin-guide/blockdev/zram.html#add-remove-zram-devices
> [2]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6566d1a32bf7

> -	modprobe zram num_devices=$dev_num || \
> -		tst_brk TBROK "failed to insert zram module"
> +# On kernel that supports /sys/class/zram-control interface but doesn't load zram,
> +# we dont' need to use hot_add/hot_remove interface. If system has loaded zram
> +# or buitin, we need to use hot_add/hot_remove interface.
> +# On old kernel that doesn't support /sys/class/zram-control interface, we just
> +# check whether zram module is being used or it is built in kernel(we can't create
> +# number of devices required). If so, skip it.
> +	if [ ! -d "/sys/class/zram-control" ]; then
> +		modprobe zram num_devices=$dev_num
> +		if [ ! -d "/sys/class/zram-control" ]; then
> +			if grep -q '^zram' /proc/modules; then
> +				rmmod zram > /dev/null 2>&1 || \
> +					tst_brk TCONF "zram module is being used"
nit: I'd be more clear already in the output.

> +			else
> +				tst_brk TCONF "test needs CONFIG_ZRAM=m"
Also here I'd somehow mention the old kernel.
> +			fi
> +			modprobe zram num_devices=$dev_num
> +		fi
> +		module_load=1
> +		dev_end=$(($dev_num - 1))
> +		tst_res TPASS "all zram devices (/dev/zram0~$dev_end) successfully created"
> +		return
> +	fi
> -	dev_num_created=$(ls /dev/zram* | wc -w)
> +	dev_start=$(ls /dev/zram* | wc -w)
> +	dev_end=$(($dev_start + $dev_num - 1))
> +	sys_control=1

> -	if [ "$dev_num_created" -ne "$dev_num" ]; then
> -		tst_brk TFAIL "unexpected num of devices: $dev_num_created"
> -	fi
> +	for i in $(seq  $dev_start $dev_end); do
> +		cat /sys/class/zram-control/hot_add > /dev/null
> +	done

> -	tst_res TPASS "all zram devices successfully created"
> +	tst_res TPASS "all zram devices (/dev/zram$dev_start~$dev_end) successfully created"
>  }

IMHO this should work and be a bit more readable
(put extra TINFO to help understand the problem on failure or what has been
tested):

	tst_res TINFO "create '$dev_num' zram device(s)"

	# zram module loaded, new kernel
	if [ -d "/sys/class/zram-control" ]; then
		tst_res TINFO "zram module already loaded, kernel supports zram-control interface"
		dev_start=$(ls /dev/zram* | wc -w)
		dev_end=$(($dev_start + $dev_num - 1))
		sys_control=1

		for i in $(seq  $dev_start $dev_end); do
			cat /sys/class/zram-control/hot_add > /dev/null
		done

		tst_res TPASS "all zram devices (/dev/zram$dev_start~$dev_end) successfully created"
		return
	fi

	modprobe zram num_devices=$dev_num

	# detect old kernel or built-in
	if [ ! -d "/sys/class/zram-control" ]; then
		if grep -q '^zram' /proc/modules; then
			rmmod zram > /dev/null 2>&1 || \
				tst_brk TCONF "zram module is being used on old kernel without zram-control interface"
		else
			tst_brk TCONF "test needs CONFIG_ZRAM=m on old kernel without zram-control interface"
		fi
		modprobe zram num_devices=$dev_num
	fi

	module_load=1
	dev_end=$(($dev_num - 1))
	tst_res TPASS "all zram devices (/dev/zram0~$dev_end) successfully created"
}


Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
