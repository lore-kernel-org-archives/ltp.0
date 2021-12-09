Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF26C433EF
	for <ltp@archiver.kernel.org>; Thu,  9 Dec 2021 15:16:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EBDF33C8095
	for <ltp@archiver.kernel.org>; Thu,  9 Dec 2021 16:16:31 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DAF5E3C0480
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 16:16:22 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 76BD61A00922
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 16:16:21 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6DBF71F37E;
 Thu,  9 Dec 2021 15:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639062981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HRePiY+D3q40aHcOvo8+xEA46ekZc3/4U5mqoGmhlP8=;
 b=tJhgqnHoQDSiLe9E8v8yF7jRlpIyVOlbb6mbWwsVindxgCGh+c3+FMobEFC82BQwzNtkil
 CKFK+xjJjfkeSpXgAuWf5NbPfmGxynnD+64MPDVDP3UrqJi/RfBkJxMXS/cVq5HGowhjME
 4sLuWB51D2LToYN8nKzDA2K/LP84RD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639062981;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HRePiY+D3q40aHcOvo8+xEA46ekZc3/4U5mqoGmhlP8=;
 b=tH0vIdDsMLjPooetQx1OHmQHgvgZSifNbtXRiUXddNagwTQcD4pXr5j3abrKW8PUGBJ+sq
 mormFQahyqkOLABw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 59DD413B2D;
 Thu,  9 Dec 2021 15:16:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id h5Q7FcUdsmEtPwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 09 Dec 2021 15:16:21 +0000
Date: Thu, 9 Dec 2021 16:17:40 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YbIeFLfVb36DaVq8@yuki>
References: <1639035823-5786-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639035823-5786-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1639035823-5786-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] zram/zram_lib.sh: Skip test if zram module
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
>  	tst_set_timeout $((dev_num*450))
>  
> +	rmmod zram > /dev/null 2>&1 || tst_brk TCONF "zram module is being used"
> +
>  	tst_res TINFO "create '$dev_num' zram device(s)"
>  
>  	modprobe zram num_devices=$dev_num || \
> @@ -57,7 +59,8 @@ zram_load()
>  	dev_num_created=$(ls /dev/zram* | wc -w)
>  
>  	if [ "$dev_num_created" -ne "$dev_num" ]; then
> -		tst_brk TFAIL "unexpected num of devices: $dev_num_created"
> +		tst_brk FAIL "num of devices expected $dev_num, but created"\
                        ^
			This should have stayed TFAIL right?
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
