Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26535C001DF
	for <ltp@archiver.kernel.org>; Thu,  3 Aug 2023 10:51:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A3673CD523
	for <ltp@archiver.kernel.org>; Thu,  3 Aug 2023 12:51:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF9F33C8952
 for <ltp@lists.linux.it>; Thu,  3 Aug 2023 12:51:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C3D151A00EF5
 for <ltp@lists.linux.it>; Thu,  3 Aug 2023 12:51:25 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 78EE41F45A;
 Thu,  3 Aug 2023 10:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1691059885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dAI+2+PEj5W5pW+f86zousB00Is5U3BdYcfS+DBftPw=;
 b=nwWDUkszuqyJZHyPhH26C8O/Jo+PKKeE9mq9cFDE85E5YM0O5pLUMNxWJUNafqOzGl3xVo
 y6SwgSQT734koxqSghwR4K7xnZKXv10ikaNXFSeEK8aZvP+jAYqNM01YWn6p+1nWZ5+031
 oqFpqI2dpMwV2oLaFI8GgSnIBCCXrtI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1691059885;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dAI+2+PEj5W5pW+f86zousB00Is5U3BdYcfS+DBftPw=;
 b=csS6TtjUzj1Drm8+phqo4x842LUPd8nkOJf5Jah9ngOlQM4xGUXYzX5vhYLbuBCOvFD/mY
 k+Lsm1ETFmTE5lBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6363F134B0;
 Thu,  3 Aug 2023 10:51:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4Ps0F62Gy2TQHgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 03 Aug 2023 10:51:25 +0000
Date: Thu, 3 Aug 2023 12:52:22 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Ian Wienand <iwienand@redhat.com>
Message-ID: <ZMuG5iOmeLH_OhxV@yuki>
References: <20230803015149.69906-1-iwienand@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230803015149.69906-1-iwienand@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] kernel/device-drivers/zram/zram01.sh : add a sync
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
> diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
> index 58d233f91..5f3964f6c 100755
> --- a/testcases/kernel/device-drivers/zram/zram01.sh
> +++ b/testcases/kernel/device-drivers/zram/zram01.sh
> @@ -119,6 +119,9 @@ zram_fill_fs()
>  				>/dev/null 2>err.txt || break
>  			b=$(($b + 1))
>  		done
> +                # Give the system time to catch up, otherwise the mm_stat
> +                # checking below can give a false negative
> +		sync

I guess that the files written by the dd above end up in page cache and
are not written out until much later. Does it fix the problem if you add
fdatasync to the dd commandline? That should be faster than using the
big hammer and sysncing the whole system.

>  		if [ $b -eq 0 ]; then
>  			[ -s err.txt ] && tst_res TWARN "dd error: $(cat err.txt)"
>  			tst_brk TBROK "cannot fill zram $i"
> @@ -134,6 +137,9 @@ zram_fill_fs()
>  		fi
>  
>  		mem_used_total=`awk '{print $3}' "/sys/block/zram$i/mm_stat"`
> +		if [ $mem_used_total -eq 0 ]; then
> +			test_res FAIL "/sys/block/zram$i/mm_stat reports 0 size : $(cat /sys/block/zram$i/mm_stat)"
> +		fi
>  		v=$((100 * 1024 * $b / $mem_used_total))
>  		r=`echo "scale=2; $v / 100 " | bc`
>  
> -- 
> 2.41.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
