Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE89C433EF
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 08:28:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C97423CA0EF
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 09:28:27 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB5733C9DE5
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 09:28:18 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B9D386010D2
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 09:28:17 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D579B219A0;
 Fri, 18 Feb 2022 08:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645172896;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p4djGDTHwKB76Nq7JZDG5qNxK2zlOZUsoAB9VNsRL3A=;
 b=dW+rstbuVYRwvMLL62J8IykIYObogSIu4zzHJlML5P5oGHcCiQ02AVwXRgTBmOjEOV5vKz
 Ns1V+qR/Zj45M3OxqLc4i35TAK+mlQHWM4C2fyNCipLFTZ/JZIncramHsRe2oHKAATDk9y
 JuzopHTgQ/uQBvApTGJJH00mLl4hWpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645172896;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p4djGDTHwKB76Nq7JZDG5qNxK2zlOZUsoAB9VNsRL3A=;
 b=2kU68fOJgUFA+N5/Uiy40gxXxTqejsgChi1bxrY9C0EVhTyGGtJwBpxygMgM2JJy4aWtX7
 a41tXz51EnH8IABw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0E3213C29;
 Fri, 18 Feb 2022 08:28:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wlFWKaBYD2KKTQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 18 Feb 2022 08:28:16 +0000
Date: Fri, 18 Feb 2022 09:28:14 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <Yg9YnujePndAfIC1@pevik>
References: <1645005868-2373-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1645005868-2373-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <Yg6ZgyD3R2PgL+HN@pevik> <620F00F6.9000108@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <620F00F6.9000108@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/5] lapi/kcmp.h: Replace GPL with
 SPDX-License-Identifier
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

> >>   int kcmp(int pid1, int pid2, int type, int fd1, int fd2)
> > $ make check-pidfd_getfd01
> > ../../../../include/lapi/kcmp.h:34:5: warning: Symbol 'kcmp' has no prototype or library ('tst_') prefix. Should it be static?

> > Could you please mark this as static inline?
> Of course, in fact, I have changed, but forgot to add it into the final 
> version.
+1

> > Not sure if this should be with the same commit as SPDX.
> IMO, I will add it into the same commit and mention that we also replace 
> GPL with SPDX. Title maybe changed into "lapi/kcmp.h: Simplify code ".
+1

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
