Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42F1ECAAD3
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 12:59:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A52193CAC42
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 14:59:26 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F08F3C972D
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 14:59:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3432F2009DE
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 14:59:14 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9AD9C337B3;
 Thu, 15 Sep 2022 12:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663246754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YauYJRUCSxBoldNxq+cyFsr0d4jOawksRvS9U8n1Ad4=;
 b=jP6Tq7/fOdv4/SGOBlyAoCswQvDAcM1K8/U82o4sBnwXBLxhxOq8GWqAb/wdIttvuwD07E
 3lxRc8uuIZNs8lgmMXvmRT2HOVgeo4llWhtlH3skV18YFMFyjQ0O83lNxObMk1m6aABSQ6
 mkg+QMkDK+6/aJU9l/Owvao7ZeOgbuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663246754;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YauYJRUCSxBoldNxq+cyFsr0d4jOawksRvS9U8n1Ad4=;
 b=Bzg6IPW5uHYmavkNyJbVkYLnweupB+ZhV6edB4XNS1svnSVG9Ru4/3Rv+i3M38oR5t9BNY
 /GDKU3Oc9t8uqgCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8173713A49;
 Thu, 15 Sep 2022 12:59:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id G0QCHqIhI2MMUgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 15 Sep 2022 12:59:14 +0000
Date: Thu, 15 Sep 2022 15:01:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: zhaogongyi <zhaogongyi@huawei.com>
Message-ID: <YyMiFyceqHPWq5ug@yuki>
References: <aa31518506504f3d9504629c1341d2e4@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aa31518506504f3d9504629c1341d2e4@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: Add checking of setup params in kernel
 command line
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> In linux kernel, there are many setup params configured throng command line, for example, PSI is not enabled by default,
> We need to set psi=1 in command line to enable it.
> 
> As far as I know, there is no testcase referenced setup param now. it can be considered as a possible use in future.

We do not add anything to the test library that is not going to be used
immediatelly.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
