Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E38F3C433FE
	for <ltp@archiver.kernel.org>; Fri, 30 Sep 2022 09:27:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E0A63CA55F
	for <ltp@archiver.kernel.org>; Fri, 30 Sep 2022 11:27:58 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 44B6B3C0726
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 11:27:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 84C53600C6F
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 11:27:46 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 65BA11F8CE;
 Fri, 30 Sep 2022 09:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1664530066;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RWUMqq+SUQGpx8v7CPIdpmNwd+SLj5U/EFgjb7p/Wd8=;
 b=kFgFxbpa4qxmFwtkgpkJN2RWRaK4s3nfd68wIujkfxtQq3bndIo2zxdyuqpvUuCfMpLxO/
 Cd8evnIdV1y+KWYGI2Lee+9Vk2s3gvcUNWWSKCnr52m0ZUL/HG7IpWU2+TWn/ujVFim9ZR
 ZK7semtmH7p8cQ9hNw1/MpSitFpM8cg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1664530066;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RWUMqq+SUQGpx8v7CPIdpmNwd+SLj5U/EFgjb7p/Wd8=;
 b=K85/5ecgtgtmUpHNrCpmwYgO+mkOwtaUwjPTI5kGn9tWoBoFKTqQBPpsomjtd8LQ7+uUKM
 yd8lxBdapCyHBPCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 30E9313677;
 Fri, 30 Sep 2022 09:27:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TNrjCJK2NmNGXQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 30 Sep 2022 09:27:46 +0000
Date: Fri, 30 Sep 2022 11:27:43 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yza2jwpow0uhaLHu@pevik>
References: <20220930091208.5688-1-pvorel@suse.cz>
 <Yza1B8t2LOueCVUC@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yza1B8t2LOueCVUC@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] zram01.sh: Fix minimal size for XFS on
 kernel 5.19
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

> Hi!
> Looks good to me. Please make sure that this gets tested fairly before
> pushing.
+1. I've tested it on Tumbleweed, kernel 6.0.0-rc7-1.g74aafe0-default,
mkfs.xfs 5.19.0.

> Also Li if you can please double check since we are very late in the
> release process.
+1
I can merge it tonight, or wait for Li on next week.

Thanks for your review!

Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
