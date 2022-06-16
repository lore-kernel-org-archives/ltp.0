Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B245EC43334
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 08:36:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DCADC3C62DD
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 10:36:45 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D5FA03C2FF1
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 10:36:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6397214010D6
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 10:36:34 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 70B33211C2;
 Thu, 16 Jun 2022 08:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655368594;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JhdlK2blgSJkmTsLR53HDDKbWYfICRodZJX0UR/SzbE=;
 b=BW5iA910vV6u0MwGndJK5aEgPdHUSvewF7DR4//SWgth7Tq3FrzlUD6dh0DiZL1VaUGZM7
 0bPZqtDCWkTXeVTZ7No4Mwp7HPof0VvmpODSdyfwTS4awkMm+1cypJOYuMuqbDnRCA+XP1
 sFrB3p3VBR9nPdaMeW9APm6wWZfhiMU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655368594;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JhdlK2blgSJkmTsLR53HDDKbWYfICRodZJX0UR/SzbE=;
 b=FFQj/o4hFoYPJXY1Zs8rTX+SVPxkaB8MSmV15cLhZL+zWophV68Opgm1Lqg5zdlW+IT4Ux
 pXzF2yFzcwHoDaCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 356481344E;
 Thu, 16 Jun 2022 08:36:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aqhzC5LrqmLvMwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 16 Jun 2022 08:36:34 +0000
Date: Thu, 16 Jun 2022 10:36:32 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <YqrrkM0bWS+1X192@pevik>
References: <20220613143826.1328830-1-amir73il@gmail.com>
 <20220613143826.1328830-3-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220613143826.1328830-3-amir73il@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/5] syscalls/fanotify23: Introduce
 FAN_MARK_EVICTABLE test
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
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Amir, Jan, all,

> Verify that evictable mark does not pin inode to cache and that
> drop_caches evicts inode from cache and removes the evictable mark.

> Verify that evictable mark can be upgraded to non-evictable but not
> downgraded to evictable afterwards.

We have policy for merging tests for rc kernels [1], thus I merged this patch
(added fanotify23 into runtest/staging).

I'll discuss with others what to do with fanotify10 (old test getting new
functionality for rc kernel).

Kind regards,
Petr

[1] 2c0ab6f65 ("Create policy for testing unstable kernel features")


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
