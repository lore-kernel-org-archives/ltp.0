Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD4CC00140
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 09:51:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B140D3C87EF
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 11:51:23 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 489893C87EF
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 11:51:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6CC701A006A0
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 11:51:12 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 902283ED3B;
 Thu, 18 Aug 2022 09:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660816271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=izmoBcXZCzoW+ZBOVabeEeedzEn73APgAMt0TLEhuyI=;
 b=yDTNtwzYlIIjPi7c1iVUpoVI2MyUsFqClvSt+JBa0duT6tSLC2PaYa9ZViYywW4EMI5KFG
 x/C/+U6ahzFceEU9vMPumXSYy/Y88fhdSAodnk6A6RekxGKk4TINgynTSany89e+3J2Kfp
 8Je4mm7YIxVF04RjH97I5QIzo306kTM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660816271;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=izmoBcXZCzoW+ZBOVabeEeedzEn73APgAMt0TLEhuyI=;
 b=Oi4CbHmUUC1IhkMVDqDVw1o3Ys86B+4oCvNpO8EX8FrglSXyelgEpyRjX2mCrOE03rT+kk
 ToV0Au3NBN56wLAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A26D139B7;
 Thu, 18 Aug 2022 09:51:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6mhjHI8L/mIlBQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 18 Aug 2022 09:51:11 +0000
Date: Thu, 18 Aug 2022 11:53:08 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Yv4MBF79PnJKJbwm@yuki>
References: <20220817204015.31420-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220817204015.31420-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] API: Allow to use xfs filesystems < 300 MB
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
Cc: linux-xfs@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
 automated-testing@yoctoproject.org, ltp@lists.linux.it,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
I'm starting to wonder if we should start tracking minimal FS size per
filesystem since btrfs and xfs will likely to continue to grow and with
that we will end up disabling the whole fs related testing on embedded
boards with a little disk space. If we tracked that per filesystem we
would be able to skip a subset of filesystems when there is not enough
space. The downside is obviously that we would have to add a bit more
complexity to the test library.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
