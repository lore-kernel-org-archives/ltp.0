Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801BBCD54AB
	for <ltp@archiver.kernel.org>; Tue, 19 Sep 2023 09:25:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EEE363CE452
	for <ltp@archiver.kernel.org>; Tue, 19 Sep 2023 11:25:57 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C6933C9956
 for <ltp@lists.linux.it>; Tue, 19 Sep 2023 11:25:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 37CF6100B79C
 for <ltp@lists.linux.it>; Tue, 19 Sep 2023 11:25:46 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8DC502296A;
 Tue, 19 Sep 2023 09:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695115546;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yYHArx+tI5e0IZFu7wSsw8q4LgD7Cc/GR80E7RAXqi4=;
 b=O70xl44yE85sJhEEEiwufOJPoC8aXhqGfTOJyVUxJORuy4pX0VK3fFQd2R8kpBcTsvxioq
 HRMR+zF5qWyoooOya/D0RCnks2Jf4kJZz3aJeZVA6DOXEhhtryzeQhvw+d7zMIbxtVmNSb
 IpuN8tngwQaFtGGMkd2yk4/Q5Snz6pQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695115546;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yYHArx+tI5e0IZFu7wSsw8q4LgD7Cc/GR80E7RAXqi4=;
 b=58ymgml3q1w1myGg6GIU0KeUQq16L55IyTpXQM/kY+wPG11oMjMhyjBWrW1/WYVg/seJFK
 JeOEpNAJ2T1jahBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 585D2134F3;
 Tue, 19 Sep 2023 09:25:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9+oEFBppCWU8KgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 19 Sep 2023 09:25:46 +0000
Date: Tue, 19 Sep 2023 11:25:44 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <20230919092544.GA166424@pevik>
References: <20230919091723.9278-1-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230919091723.9278-1-rpalethorpe@suse.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PUSHED] zram01.sh: Workaround division by 0 on vfat on
 ppc64le
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

Hi Richie,

> Repeatedly read /sys/block/zram*/mm_stat for 1 sec. This should fix bug
> on ppc64le on stable kernels, where mem_used_total is often 0.

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> Reviewed-by: Li Wang <liwang@redhat.com>
> Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

> [rpalethorpe: s/loop/check/ suggested by Li]
> ---

> rpalethorpe:
>         This may not fix the problem, but it can rule out a simple race
>         condition.

thanks a lot for finishing the effort!
I was waiting for Cyril to have his ack.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
