Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85A7ECAAD8
	for <ltp@archiver.kernel.org>; Wed, 21 Sep 2022 11:22:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 185643CAC61
	for <ltp@archiver.kernel.org>; Wed, 21 Sep 2022 13:22:36 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D2883C93AF
 for <ltp@lists.linux.it>; Wed, 21 Sep 2022 13:22:25 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 10CC760006A
 for <ltp@lists.linux.it>; Wed, 21 Sep 2022 13:22:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 487411F747;
 Wed, 21 Sep 2022 11:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663759344;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nsVS+uKdbIA2rs98+x0gCRE45F7ZBfgvbkLRQXOjMao=;
 b=XkMhRGkwl9qvpQdl0CyYSvAl1dt0FRrWETsP8jKUyvBSNzLJKkIOZd4v7uRi5hzU6SXXL5
 uCMmGyiLce4OEuh/mnV4OD1D379L5qPJDBrgqWBecjauyjjXGD44kevPn88ifT2AjzJYww
 JzaBe8wm3EmfJuttXPzFDBP3sUSBXac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663759344;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nsVS+uKdbIA2rs98+x0gCRE45F7ZBfgvbkLRQXOjMao=;
 b=coZJEfvR4cOn5Y+A3zrCJbrYjCgc/54xqCGMufqKYAwzT+kvRd7F4aE3Y96o0aXmaz5hpH
 anU0jIxLqh3h39AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 21E7713A89;
 Wed, 21 Sep 2022 11:22:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KNvYBvDzKmNofgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 21 Sep 2022 11:22:24 +0000
Date: Wed, 21 Sep 2022 13:22:22 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yyrz7jFTo168rjzl@pevik>
References: <20220906054612.9790-1-pvorel@suse.cz> <YySDWP9I46TDIgEK@yuki>
 <YyTIvPWfkkEoUflB@pevik> <YygfGEU8YRftJ1fj@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YygfGEU8YRftJ1fj@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] checkpatch: Ignore warnings irrelevant in
 userspace
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

> Hi!
> > FYI the error is from fanotify.h (kind of lapi file for fanotify:
> <
> > #ifndef __kernel_fsid_t
> > typedef struct {
> > 	int	val[2];
> > } lapi_fsid_t;
> > #define __kernel_fsid_t lapi_fsid_t
> > #endif /* __kernel_fsid_t */

> > which we added in b8aebc835 ("fanotify: Fix missing __kernel_fsid_t definition")
> > "Instead of including <asm/posix_types.h> where it's defined we just
> > define the missing bit." (fix for musl).

> I'm aware of that, and while typedef is mostly wrong there are a few
> places where it's required.

> > But if you prefer to keep this check, I'm ok to merge it without it.

> > The long term solution could be to add variable to Makefile to pass extra
> > parameters, e.g.:
> > check_fanotify.h: CHECKPATCH_IGNORE += NEW_TYPEDEFS

> Case by case decisions like this for typedef sounds better to me.
+1 (TODO after the release).
Thanks for your time!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
