Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16EFC433FE
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 10:25:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 637603CD212
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 11:25:55 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8CA343C25A5
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 11:25:46 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 99A151A0067E
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 11:25:45 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 9AF1A21E91;
 Mon, 14 Nov 2022 10:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1668421544;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y8e15cbmlclLRY6JYSWKrr9K4kZ3cCC03gmnxQairWs=;
 b=m0RDqRtwgkakyq6Nj3BuJqhZVacmMo0GGTp6LmtR5U+bNpIGefEZwlKE37pRzTwWW7c1UR
 1PTELQ27EUXJyOEH+uok6YvwQTwAJkOG8ewHRuuM+Wvm3Lp1Y5AEVsuAXqzs8a5J+cb+Gp
 ND5LlAhdZsw446x9plTpmvMkEBe+tss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1668421544;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y8e15cbmlclLRY6JYSWKrr9K4kZ3cCC03gmnxQairWs=;
 b=pvF1JywGYNb4UAVJD3aLwxvHH5zwWPhfIVD8f/wyxQEzsoSUZjEeMEtvqVVKdd9OTFQFTA
 EHfXnxz8bUUiXNBw==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 558E92C141;
 Mon, 14 Nov 2022 10:25:44 +0000 (UTC)
References: <20221110175236.32094-1-pvorel@suse.cz>
 <20221110175236.32094-3-pvorel@suse.cz>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 14 Nov 2022 10:25:10 +0000
Organization: Linux Private Site
In-reply-to: <20221110175236.32094-3-pvorel@suse.cz>
Message-ID: <87sfilu920.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] doc/c-test-api.txt: Improve
 tst_find_backing_dev() doc
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
Reply-To: rpalethorpe@suse.de
Cc: Yang Xu <xuyang2018.jy@cn.fujitsu.com>,
 Alessandro Carminati <alessandro.carminati@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> Doc added in 606903cf8 was too complicated. Also there was repeating
> sentence, typo 'unevent'.
>
> While at it, fix also 'voud' typo from 9343d0486.
>
> Fixes: 606903cf8 ("c-test-api: Documentation updated")
> Fixes: 9343d0486 ("tst_device: Add new api tst_find_backing_dev(path, dev)")
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Thanks

Acked-by: Richard Palethorpe <rpalethorpe@suse.com>

> ---
>  doc/c-test-api.txt | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
> index 8844d9f2f..834a342fd 100644
> --- a/doc/c-test-api.txt
> +++ b/doc/c-test-api.txt
> @@ -1075,12 +1075,9 @@ is created for that intention.
>  void tst_find_backing_dev(const char *path, char *dev);
>  -------------------------------------------------------------------------------
>  
> -This function finds the block dev that this path belongs to, it uses stat function
> -to get the major/minor number of the path.
> -This function finds the block dev that this path belongs to, it uses the unevent
> -file in sysfs to find the device name. It needs to discriminate between btrfs
> -and not btrfs. For non btrfs filesystems it uses the minor, major numbers. For
> -btrfs it uses the fs uuid.
> +This function finds the block dev that this path belongs to, using uevent in sysfs.
> +For Btrfs it uses '/sys/fs/btrfs/UUID/devices/DEV_NAME/uevent'; for other
> +filesystems it uses '/sys/dev/block/MAJOR:MINOR/uevent'.
>  
>  [source,c]
>  -------------------------------------------------------------------------------


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
