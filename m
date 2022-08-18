Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDACFC00140
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 17:50:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A40933CA226
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 19:50:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 87F123C91F0
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 19:50:40 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CC1861A00240
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 19:50:38 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 39F375C1E8;
 Thu, 18 Aug 2022 17:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660845038;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gHM25fZBwmj6bzHbM91eQapoo5chKeBLyrw/koie0/4=;
 b=ZgZBkeVP6iq4CW6x0RDeEXUQhYSKM+t4MwLni+YTIAt5sv00cxU/MnAUhaPj/hhlMCiahK
 zpJoTMRNw+myEHA7kRYEuz1KJT59ic1FTX67O7kWSM/sP7lT5hs5x0AZmxCZgNQktv84Y2
 DMEq7ShmQWWiYc2JKf/HyylFCVu5W4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660845038;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gHM25fZBwmj6bzHbM91eQapoo5chKeBLyrw/koie0/4=;
 b=gCjx+qFyirKvVTJ1y3yKpN4SHMvE08o8gKh+8qAK1hyYmrF3rdlNnJ/mjsvjPN/k42/Z/i
 RsNlqb3STCX24kBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 097DA133B5;
 Thu, 18 Aug 2022 17:50:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XPRlAO57/mKkSwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 18 Aug 2022 17:50:38 +0000
Date: Thu, 18 Aug 2022 19:50:36 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <Yv577JegQzPlqFuo@pevik>
References: <20220818171724.9182-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220818171724.9182-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] bpf_prog0[5-7]: Run with
 kernel.unprivileged_bpf_disabled = 0
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

> To avoid forcing users to run this setup to avoid TCONF:

> tst_capability.c:29: TINFO: Dropping CAP_BPF(39)
> bpf_common.c:39: TCONF: Hint: check also /proc/sys/kernel/unprivileged_bpf_disabled
> bpf_common.c:41: TCONF: bpf() requires CAP_SYS_ADMIN or CAP_BPF on this system: EPERM (1)

If accepted, maybe I should also remove from bpf_map_create():
tst_res(TCONF, "Hint: check also /proc/sys/kernel/unprivileged_bpf_disabled");

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
