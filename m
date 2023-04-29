Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0681C77B60
	for <ltp@archiver.kernel.org>; Sat, 29 Apr 2023 19:28:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E63A3CB9D1
	for <ltp@archiver.kernel.org>; Sat, 29 Apr 2023 21:28:25 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F32E63CB1C6
 for <ltp@lists.linux.it>; Sat, 29 Apr 2023 21:28:15 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 42488140032C
 for <ltp@lists.linux.it>; Sat, 29 Apr 2023 21:28:14 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 720731F74D;
 Sat, 29 Apr 2023 19:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682796492;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wor02wCBnWgcB1QdGyupjZU1gl2QrdIajEIuu8Mwi8w=;
 b=qTQgHXnRjLnzd/WnfeF3NJ31Mj1AMmzQz4qDjRsPwigE72R50cZYsp0FxcB+MnD1eWUiJe
 IeSKDeUjb+I01TaqQv0161wfmRRcvxEObmCVeCT3bRECcpbolp1tKcmvJ7YZdMKOlCTqni
 5eD4vSf7hmhtXNCrs9fgpCRo/gMeBu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682796492;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wor02wCBnWgcB1QdGyupjZU1gl2QrdIajEIuu8Mwi8w=;
 b=R5+G3r5WTd3CB33kxgfco/PbHg/mf8MbcZkM5/pySOXdUCw0bxGOznM68LAmYOSJCfjmMJ
 QP0dVzzgcwfSEsAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2FA15138E0;
 Sat, 29 Apr 2023 19:28:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id COqsCcxvTWT0YAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Sat, 29 Apr 2023 19:28:12 +0000
Date: Sat, 29 Apr 2023 21:28:22 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>, ltp@lists.linux.it,
 Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Message-ID: <20230429192822.GA3588012@pevik>
References: <20220112161942.4065665-1-nikita.yushchenko@virtuozzo.com>
 <9813e92e-da52-dcfc-3eca-930854fb754e@suse.cz>
 <YeHXEvfvnnc1WGfC@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YeHXEvfvnnc1WGfC@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] nfs_flock: fail the test if lock/unlock ops fail
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Hi Martin, Nikita,

> > The test program is quite short and simple. Why not rewrite it using the
> > current LTP API and make it even better? Some useful links to help with
> > that:

> +1

> It might not make it into this release due git freeze [1],
> but definitely worth of doing it.
> Thus I'd accept this patch for upcoming release.

I'm sorry I completely forgot on this patch. I merged it, because it
immediately stops broken test on NFS v3, which would otherwise timeout.

The problem itself would deserve debugging. If it's WONFTFIX due rpcbind
just not working on netns on NFS v3 [2], we should remove nfslock3t_01 and
nfslock3t_ipv6_01 from runtest/net.nfs and disable with TCONF NFS v3 (i.e. -v 3)
in nfslock01.sh. I'll try to not forget on posting a RFC patch to linux-nfs ML.

Kind regards,
Petr

[2] https://lore.kernel.org/ltp/3cb5de6e-6f8f-e46a-96bd-a3d88a871f3a@virtuozzo.com/


> Kind regards,
> Petr

> > https://github.com/linux-test-project/ltp/wiki/C-Test-Case-Tutorial
> > https://github.com/linux-test-project/ltp/wiki/C-Test-API
> > https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines

> [1] https://lore.kernel.org/ltp/YeFGwLzrR3t%2FVQLq@yuki/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
