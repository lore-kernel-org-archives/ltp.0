Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD9CC433EF
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 08:48:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 082763C9005
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 09:48:04 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4EB953C0E12
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 09:47:54 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 62CF61001F43
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 09:47:53 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 772162111A;
 Fri, 17 Dec 2021 08:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639730873;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4gvZnFC8y5IC2wXm1UuVMvVbiL1iriiCtETeOuCgMhc=;
 b=diTmHx4MW1zYzWgIzPZzeFgB1fqKtlcSehNs7JUsbpiElL3SSywKVFr7A89L0fkWHWtH88
 YtCugQ8+PCTJmi8ncTHHU0z8X7ilBChyR7j5l4BYcQUh/xBS9DkrNjW6fpNQ8kBQOHGHRy
 6i9dJs151y76bkLOPQ7C9+RoNA0yVDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639730873;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4gvZnFC8y5IC2wXm1UuVMvVbiL1iriiCtETeOuCgMhc=;
 b=2fN6ich7+6Ivw/wHT3oopOi0A9sgafuWax26BIy64eSJa1CJTl9WL9KyE3F06MYMpasWeM
 Cj2AYNNlqs5rKQAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4BDA313C6D;
 Fri, 17 Dec 2021 08:47:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2xu+ELlOvGGnfQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 17 Dec 2021 08:47:53 +0000
Date: Fri, 17 Dec 2021 09:47:51 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YbxOtyzYsbgZ578D@pevik>
References: <1639552849-2251-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639552849-2251-4-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1639552849-2251-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 4/4] zram/zram01.sh: Use mem_used_total field
 instead of compr_data_size field
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

[ Cc Martin ]

> Before ltp commit 4372f7a2156 ("Fix compression ratio calculation in zram01")[1], we
> used free -m changes to calculate the compression ratio.

> After the above patch, we used compr_data_size to calculate. kernel documentation[2] has
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

Thank you for addressing this issue. replacing "data *stored* in this disk" with
"*allocated* for this disk" could help (although looking at kernel code
mm_stat_show(), I would not be sure).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
