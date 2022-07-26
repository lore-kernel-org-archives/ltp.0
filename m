Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B294C433EF
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 07:00:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 847AA3C9F6D
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 09:00:32 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CABB33C0727
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 09:00:22 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E07D01000D16
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 09:00:21 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 35E04349C1;
 Tue, 26 Jul 2022 07:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1658818821;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kCwlbbBL86DtlNFUHUrfkFItlp6NQu8Ww61u6r4H+iY=;
 b=MIOOnbdBchxNzJjZmAtl2OpKGuGPihA52a3WkYM15HsvDF9ccNTV/YuDzcd0N7oZEqbA1l
 zUH18b0ID1Iwd14sPxYh23Pu9RZ9oJ6PGFNlAtyV+ngy0diBfu537m4Z04Yybe9z2Zru5F
 5BW+N9PFE/o8d2F3gLIidXuN1maIgWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1658818821;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kCwlbbBL86DtlNFUHUrfkFItlp6NQu8Ww61u6r4H+iY=;
 b=vlA4Kb16Omf2RoL/yGMkV9ADMevv5VAJGSRU9EWxqUelqedIPQbEJt0+RE3ifLuUgdVK33
 1JmdSzwsw7nR2/AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0DCE613A7C;
 Tue, 26 Jul 2022 07:00:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Zlk8AQWR32LcXQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 26 Jul 2022 07:00:21 +0000
Date: Tue, 26 Jul 2022 09:00:19 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Yt+RA5chfBh54kvI@pevik>
References: <20220722120501.28670-1-andrea.cervesato@suse.com>
 <20220722120501.28670-8-andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220722120501.28670-8-andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 7/7] Rename common.h into mqns.h for mqns suite
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  testcases/kernel/containers/mqns/{common.h => mqns.h} | 0

could you please also fix this checkpatch error (preferably as a separate patch):

mqns.h:37: ERROR: "foo* bar" should be "foo *bar"
mqns.h:96: WARNING: __func__ should be used instead of gcc specific __FUNCTION__

Checkpatch also reports wrong comment style, but I'd ignore it (complains for
*.h, it's ok for *.c):
mqns.h:1: WARNING: Improper SPDX comment style for 'mqns.h', please use '/*' instead

@Richie: not sure I might have asked before: it'd be great to have make target
also for header files, so that they are checked with make check. Now we have to
run checkpatch manually to check them.

Kind regards,
Petr

>  testcases/kernel/containers/mqns/mqns_01.c            | 2 +-
>  testcases/kernel/containers/mqns/mqns_02.c            | 2 +-
>  testcases/kernel/containers/mqns/mqns_03.c            | 2 +-
>  testcases/kernel/containers/mqns/mqns_04.c            | 2 +-
>  5 files changed, 4 insertions(+), 4 deletions(-)
>  rename testcases/kernel/containers/mqns/{common.h => mqns.h} (100%)
...

Patch itself it's obviously correct.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
