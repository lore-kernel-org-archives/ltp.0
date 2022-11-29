Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B842C4332F
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 10:24:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4399E3CC5E7
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 11:24:47 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A71103C130F
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 11:24:37 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AD5FF1400749
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 11:24:36 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0BD8721B80;
 Tue, 29 Nov 2022 10:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669717476;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sG8s/IzTJS90cnMPQ3m+ZcQK8PBrniEIQX8ZkulHZek=;
 b=hZAObdoKAEjWon3Vid/Un+M9T7rJbfBKTr+E5vmvAxHsZd+4FVCo091XYLKut7RMiJX+6L
 yOMSaxHFypPx42k6pdoVb5Gb/HSK9KZeSyZbBrMxlOPzlWOUlx21cvRoO0V1GHtD9OYLL9
 XR+jFvfwUXU5lZY8cTTvMN9oadBHWJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669717476;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sG8s/IzTJS90cnMPQ3m+ZcQK8PBrniEIQX8ZkulHZek=;
 b=ru1Uo9//bIXhAY4D9zk87tIPIt5Fsgg+x3euNOy/rdn5I1V676o/5WsoynaVFxyKxoENpw
 gSsfDutRxPCmbmBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E101613AF6;
 Tue, 29 Nov 2022 10:24:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Ybu7NOPdhWNSQwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 29 Nov 2022 10:24:35 +0000
Date: Tue, 29 Nov 2022 11:24:34 +0100
From: Petr Vorel <pvorel@suse.cz>
To: zenghongling <zenghongling@kylinos.cn>
Message-ID: <Y4Xd4jd/X5zsmoqH@pevik>
References: <1669691831-23456-1-git-send-email-zenghongling@kylinos.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1669691831-23456-1-git-send-email-zenghongling@kylinos.cn>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mkfs: relax size check
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

Hi zenghongling,

> Number of total data blocks in filesystem reported by statfs
> may be less than current formula of 90%. For example ext4 will
> subtract "s_first_data_block plus internal journal blocks".

> With recent change to e2fsprogs, overhead calculated in user-space increased
Do you know in which version it got changed?
Maybe it'd be worth to mention that to ext4 maintainers,
just to be sure it's not a regression.

> slightly and LTP test started failing: tytso/e2fsprogs
A bit cryptic description :(. You mean probably https://github.com/tytso/e2fsprogs
which is also on
https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/

Kind regards,
Petr

> mkfs01 1 TPASS: 'mkfs -t ext4  /dev/loop0 ' passed.
> mkfs01 2 TFAIL: 'mkfs -t ext4  /dev/loop0 16000' failed, not expected.

> Since there's no strict rule how much the overhead will be,
> as rule of thumb relax the condition to 70%.

> Signed-off-by: zenghongling <zenghongling@kylinos.cn>
> ---
>  testcases/commands/mkfs/mkfs01.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

> diff --git a/testcases/commands/mkfs/mkfs01.sh b/testcases/commands/mkfs/mkfs01.sh
> index 263aa47..a964774 100755
> --- a/testcases/commands/mkfs/mkfs01.sh
> +++ b/testcases/commands/mkfs/mkfs01.sh
> @@ -66,11 +66,11 @@ mkfs_verify_size()
>  	# 1k-block size should be devided by this argument for ntfs verification.
>  	if [ "$1" = "ntfs" ]; then
>  		local rate=1024/512
> -		if [ $blocknum -lt "$(($2/$rate*8/10))" ]; then
> +		if [ $blocknum -lt "$(($2/$rate*7/10))" ]; then
>  			return 1
>  		fi
>  	else
> -		if [ $blocknum -lt "$(($2*8/10))" ]; then
> +		if [ $blocknum -lt "$(($2*7/10))" ]; then
>  			return 1
>  		fi
>  	fi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
