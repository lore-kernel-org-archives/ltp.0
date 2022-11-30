Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ABB2C4321E
	for <ltp@archiver.kernel.org>; Wed, 30 Nov 2022 08:06:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BFEC33CC4F2
	for <ltp@archiver.kernel.org>; Wed, 30 Nov 2022 09:06:54 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F0533C01D2
 for <ltp@lists.linux.it>; Wed, 30 Nov 2022 09:06:44 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4639E100096A
 for <ltp@lists.linux.it>; Wed, 30 Nov 2022 09:06:42 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0100921B10;
 Wed, 30 Nov 2022 08:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669795602;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WEBTus34gnapckwJn04ukI1XBuD6xPnqjlz7dUDOlvY=;
 b=vKz7yIIjs56lBGNEeXx4JbPtvSWwXpUwBeFQWCnecVlvdzeRCOD+uqtpnDEnLZ9ulWsZcU
 gQ1ldLIo1hOGSSBKZZjfDn7S/uUHAXIXST6Nq1GuezWHf4My15ufc61fRyjSM/fPfxfXbK
 TbIHhvbhiXN34162f+PTnk7oxPKwti8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669795602;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WEBTus34gnapckwJn04ukI1XBuD6xPnqjlz7dUDOlvY=;
 b=+wW4X8Aw5VRw0ZupGEZrOG7Ufp0a3KMctUNTCMaWHii0/pog+LzBLsp83zgI/EXWm3StOS
 NX0I2vTyXJyAX/Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B8C5113A70;
 Wed, 30 Nov 2022 08:06:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rJmlKhEPh2M9NgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 30 Nov 2022 08:06:41 +0000
Date: Wed, 30 Nov 2022 09:06:39 +0100
From: Petr Vorel <pvorel@suse.cz>
To: zenghongling <zenghongling@kylinos.cn>, ltp@lists.linux.it
Message-ID: <Y4cPD+1DJhMwGPpj@pevik>
References: <1669691831-23456-1-git-send-email-zenghongling@kylinos.cn>
 <Y4Xd4jd/X5zsmoqH@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y4Xd4jd/X5zsmoqH@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Hi zenghongling,

> > Number of total data blocks in filesystem reported by statfs
> > may be less than current formula of 90%. For example ext4 will
> > subtract "s_first_data_block plus internal journal blocks".

> > With recent change to e2fsprogs, overhead calculated in user-space increased
> Do you know in which version it got changed?

For a record, zenghongling send html mail
https://lore.kernel.org/ltp/2oc1dehrobv-2oc577y0tt8@nsmail7.0.0--kylin--1/T/#u

thus repeat it here: the affected commit is here:
https://github.com/tytso/e2fsprogs/commit/59037c5357d39c6d0f14a0aff70e67dc13eafc84
which is from v1.46.0.

I'm testing it on openSUSE with 1.46.5 and it does not have problem.
Maybe there is some problem on the system you test and lower the barrier you
just hide it. Maybe others see it differently.

> Maybe it'd be worth to mention that to ext4 maintainers,
> just to be sure it's not a regression.

> > slightly and LTP test started failing: tytso/e2fsprogs
> A bit cryptic description :(. You mean probably https://github.com/tytso/e2fsprogs
> which is also on
> https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/

@zenghongling basic mailing list rules
1) sent text/plain (not text/html), otherwise mail is not readable
https://lore.kernel.org/ltp/2oc1dehrobv-2oc577y0tt8@nsmail7.0.0--kylin--1/T/#u
and not even in patchwork:
https://patchwork.ozlabs.org/project/ltp/patch/1669691831-23456-1-git-send-email-zenghongling@kylinos.cn/

Compare with my mail:
https://lore.kernel.org/ltp/Y4Xd4jd%2FX5zsmoqH@pevik/T/#m76d4ae3f396a6ae63382cb569c33d8c746ce0974

More instructions are:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#no-mime-no-links-no-compression-no-attachments-just-plain-text

2) reply to mail thread so that mail is connected to the thread
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#explicit-in-reply-to-headers

Actually most of the reading for kernel applies to LTP as well
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
