Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455EBC433EF
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 12:24:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ADA473C8776
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 13:24:16 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 087A73C7729
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 13:24:05 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C0495100136A
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 13:24:04 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0BA2D210FA;
 Fri, 10 Dec 2021 12:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639139044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WLetHtdlWQAO6bt2LD9BnAU0XY1Wzh7cRjrpbWC05zA=;
 b=er5cN5goRh1BPCECROHM2VroApbUX6XtkTAOD9o13DPLXoxz9jeSaGvnzt+Sk+hIXDFaCZ
 EmfpzfE8M8c3ypWbGx+QGpMVnLwDvHzxvaz/7qDroELXMydLMtZCk+InGMsE6qfXma6dfM
 aslsNZ33ljHRJWUM6eHA6k8/ayzeAow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639139044;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WLetHtdlWQAO6bt2LD9BnAU0XY1Wzh7cRjrpbWC05zA=;
 b=T+/LFZsaACaoO3e4KrhMpXYanMbHLutDsSQzX4J4xSpjdzOxDR0Aj28DME05M9wrEx0MFC
 XKkTeqbujqmytzAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E8B9B13E02;
 Fri, 10 Dec 2021 12:24:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id d3FcOONGs2FnCAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 10 Dec 2021 12:24:03 +0000
Date: Fri, 10 Dec 2021 13:25:24 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YbNHND+vtQBC4Ltr@yuki>
References: <YbJ3SKsLu7iNoqZc@pevik>
 <1639136448-2148-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639136448-2148-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1639136448-2148-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] zram/zram_lib.sh: Skip test if zram module
 can not be removed
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
> +	lsmod | grep -q '^zram'
> +	if [ $? -eq 0 ]; then

Why not just:
	if grep -q '^zram' /proc/modules; then
		...

Here as well what the lsmod does it to open /proc/modules and for each
entry it also looks at /sys/module/$name/refcnt and
/sys/module/$name/hodlers. But we are not interested in the second part
at all...

> +		 rmmod zram > /dev/null 2>&1 || tst_brk TCONF "zram module is being used"
> +	fi
> +
>  	tst_set_timeout $((dev_num*450))
>  
>  	tst_res TINFO "create '$dev_num' zram device(s)"
> @@ -54,10 +64,12 @@ zram_load()
>  	modprobe zram num_devices=$dev_num || \
>  		tst_brk TBROK "failed to insert zram module"
>  
> +	dev_zram_load=1
>  	dev_num_created=$(ls /dev/zram* | wc -w)
>  
>  	if [ "$dev_num_created" -ne "$dev_num" ]; then
> -		tst_brk TFAIL "unexpected num of devices: $dev_num_created"
> +		tst_brk TFAIL "expected num of devices $dev_num, but created"\
> +				"$dev_num_created"
>  	fi
>  
>  	tst_res TPASS "all zram devices successfully created"
> -- 
> 2.23.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
