Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E53C433EF
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 14:12:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5DEA73C9293
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 15:12:51 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B28253C02F7
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 15:12:42 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 160C510004B9
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 15:12:41 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 413BE1F384;
 Wed, 22 Dec 2021 14:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640182361;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vMKNEiOE9Ch5kdW2trlzvS2gEzbdt3i/mH4V6pdWuOI=;
 b=kiaDrWOk/yKVeHXO5Qwr+zOoF4D4MjPFK/tNAE/Hy8tCl+/bF8AnNEu0SMBVd1dXZWOkEy
 ia+OOjXmbKz+IeLYW3jybGpd+5rAI5wrNvBhlXYVShcZTYyurnzYRcoaJ8DtKpVqTH6emC
 eMXh8lvbz2czlXiU2DWiImeV9gSBpac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640182361;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vMKNEiOE9Ch5kdW2trlzvS2gEzbdt3i/mH4V6pdWuOI=;
 b=uSfQgf2DwxsQOjzJl21ZNODTIrNtJqAFbj3Im/R/uAAVjVQ/m2GPQeomP0rrDi23iuoCmT
 Gwv4agLeQllV8HAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 00B7413D2F;
 Wed, 22 Dec 2021 14:12:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8qkpOVgyw2FPYAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 22 Dec 2021 14:12:40 +0000
Date: Wed, 22 Dec 2021 15:12:39 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <YcMyV/jZQWAC3nv8@pevik>
References: <1639983142-2247-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639983142-2247-4-git-send-email-xuyang2018.jy@fujitsu.com>
 <YcBfuCPg1ENZHvud@pevik> <61C1397A.1070904@fujitsu.com>
 <YcGTMcan0r2NOcR9@pevik> <61C2F10F.9000901@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <61C2F10F.9000901@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

> Hi Petr

> Thanks for your review, I have pushed this patchset.
> Also adding some debuginfo in zram03.c like you do in zram_lib.sh.
+1

> ps: I have sent a patchset in kernel selftest to update zram case a week 
> ago, but doesn't get any reponse...
> https://patchwork.kernel.org/project/linux-kselftest/list/?series=595877

Great thanks!
patchwork is temporarily down (502 Bad Gateway), thus posting lore link:
https://lore.kernel.org/linux-kselftest/1639562171-4434-1-git-send-email-xuyang2018.jy@fujitsu.com/#b

Although it's meant to be for kernel developers I might find a time to have a
look.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
