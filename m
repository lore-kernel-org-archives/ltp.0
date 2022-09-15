Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4403EECAAD3
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 11:04:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB7CD3CAC1C
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 13:04:39 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26B7F3CAB98
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 13:04:29 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5FBAB200B69
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 13:04:28 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 473A633777;
 Thu, 15 Sep 2022 11:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663239868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8UoNDwXVJc5FtBVjetba5ZF7PdNuW/LJCENrOepNQtY=;
 b=27f006aenPUZDuC2hSr6UAaWgqLBVSe3RvcR73RrJz6NKZThqFCqYqsjK0rFiRqODoYZ0n
 JtEa8IRw/dck2BN+V8KfLml754gSKMFhHf4KOhskCBQy4LZOadJdwOxqkh4MYXzasEpuwS
 yWeK8Rr6doePpMx4Ik5NH/cD+3U0p8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663239868;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8UoNDwXVJc5FtBVjetba5ZF7PdNuW/LJCENrOepNQtY=;
 b=gk9yNeWxhIoFkCeztrGB/wNI84NRtrkApAPYa5/cxYhvf78jijCtrpas2ZYhfInQ2DXBp2
 aLbt1NnRHi0hZoDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3FDF613A49;
 Thu, 15 Sep 2022 11:04:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /NtYDrsGI2NmHwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 15 Sep 2022 11:04:27 +0000
Date: Thu, 15 Sep 2022 13:06:24 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Dylan Jhong <dylan@andestech.com>
Message-ID: <YyMHMI/QyGAa2B2x@yuki>
References: <20220914131950.1783054-1-dylan@andestech.com>
 <YyLpUMPMlGoXjwls@yuki> <YyL4cqTctXZ4TMmt@atcsi01>
 <YyL5w+DzuI7U06Td@yuki> <YyL/QxV+D0ei0vGX@atcsi01>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YyL/QxV+D0ei0vGX@atcsi01>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] kernel/uevent: Adjust the number of uevents
 dynamically in uevent02
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
Cc: "Mina Hui-Min Chou\(\(\(\(\(\(\(\)" <minachou@andestech.com>,
 "x5710999x@gmail.com" <x5710999x@gmail.com>,
 "Charles Ci-Jyun Wu\(\(\(\(\(\(\(\)" <dminus@andestech.com>,
 "Alan Quey-Liang Kao\(\(\(\(\(\(\(\)" <alankao@andestech.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Oh, i got it!!! Sorry for the misunderstanding.
> I thought this was talking about adding the .needs_kconfigs property.
> I will add setup() function in v2 patch.
> 
> And about the adjustment of uevent declaration, any comments that I can
> do in v2 patch?

I would avoid any unnecessary changes.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
