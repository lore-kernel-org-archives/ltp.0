Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30213C433EF
	for <ltp@archiver.kernel.org>; Thu, 17 Mar 2022 14:02:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 195E83C941F
	for <ltp@archiver.kernel.org>; Thu, 17 Mar 2022 15:02:02 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9814A3C93E3
 for <ltp@lists.linux.it>; Thu, 17 Mar 2022 15:01:51 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F3AD41000F53
 for <ltp@lists.linux.it>; Thu, 17 Mar 2022 15:01:50 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 03418210ED;
 Thu, 17 Mar 2022 14:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647525710;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LPads4QhgG40QSxsFN8HYluTWzAgqIQFBLxxFittpuU=;
 b=1IDcDye2GhMw+2YKSkouZqXAlSDDs0APeeFncCuJ4qP2Om9b34HwiIIay+b8K0RHzld2q0
 BKBXNdC8ImNzsOwusy6nnt9wdYfoGs4ouHBN9qJnTChVKCU+TLi3WAp+8SAsQXBurgxToK
 zIBHMzeLF7NHFWICHAnPxSUyHOuSKoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647525710;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LPads4QhgG40QSxsFN8HYluTWzAgqIQFBLxxFittpuU=;
 b=uusS/kL2wBuNL14A+YT2a8QIucgoa0K697EcVpUEFa/jgiaQ3WuWBxG0HeGiXbFAXT1X0D
 vP5mDcXoILHiEHAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CBC1F13BAD;
 Thu, 17 Mar 2022 14:01:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id An3HL00/M2LwIQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 17 Mar 2022 14:01:49 +0000
Date: Thu, 17 Mar 2022 15:01:47 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YjM/S/DdU1lhhhgI@pevik>
References: <1647401546-2898-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1647401546-2898-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1647401546-2898-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] syscalls/quotactl: Remove
 tst_require_quota_support
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
Cc: ltp@lists.linux.it, martin.doucha@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Since we have check quota support on ext4/xfs by using needs_drivers or
> needs_kconfigs, we don't need this api any more.

nit: maybe also mention it effectively reverts 4aab31e4c7 and ed1885e0e2?
And that 57d05ce21f (the commit which made these checks redundant)?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
