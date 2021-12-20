Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6305C433F5
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 10:49:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 50C0C3C8F82
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 11:49:41 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6257D3C4DBB
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 11:49:31 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 62419600774
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 11:49:30 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A2D281F381;
 Mon, 20 Dec 2021 10:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639997370;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u3yRlVWVCZ4ALLKy994As+KPMMx7RbVk3cR74apH3jc=;
 b=3XGjLIHdjJ+pMZQBRu4C/iuhzxR4swrqzgMv0R+ngrPLrKKKUN9OKs2hVggf+xliEOQ9Dx
 WABY+mdvSrfg9flNxgEMvPCYuJvdWUfAvnBtu10BbczZ5RxNgL2Ai+xEmm+x7AtnuMC2LM
 ZL2rtN8mo8RYb726Gw8NvZVa7Z4r238=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639997370;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u3yRlVWVCZ4ALLKy994As+KPMMx7RbVk3cR74apH3jc=;
 b=PSnn2pqUsid8OXYblgMo7lQ1EFMlrWlbJEAskCl+fhoCFtrhcayB3YA/TCh9IB+hLWiIDY
 jr5q1p+1/AeWKADg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8391B13B83;
 Mon, 20 Dec 2021 10:49:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MMzcHrpfwGGiNQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 20 Dec 2021 10:49:30 +0000
Date: Mon, 20 Dec 2021 11:49:28 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YcBfuCPg1ENZHvud@pevik>
References: <1639983142-2247-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639983142-2247-4-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1639983142-2247-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 4/4] zram/zram01.sh: replacing data stored in
 this disk with allocated for this disk
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

> Before ltp commit 4372f7a2156 ("Fix compression ratio calculation in zram01")[1], we
nit: we can drop [1]
> used free -m changes to calculate the compression ratio.

> After the above patch, we used compr_data_size to calculate. kernel documentation[2] has
nit: I'd add link to the doc also in this commit message.

Kind regards,
Petr

> the following info:
> orig_data_size: uncompressed size of data stored in this disk.
> compr_data_size: compressed size of data stored in this disk
> mem_used_total: the amount of memory allocated for this disk

> We should calculate the compression ratio by used disk size divided into used mem size.
> It can also avoid the situation that division by 0 as below:
> zram01 7 TINFO: filling zram4 (it can take long time)
> zram01 7 TPASS: zram4 was filled with '25568' KB
> zram01 7 TINFO: compr_size 0
>  /opt/ltp/testcases/bin/zram01.sh: line 131: 100 * 1024 * 25568 / 0: division by 0 (error token is "0")

> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
