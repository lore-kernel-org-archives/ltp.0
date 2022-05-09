Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA27C433EF
	for <ltp@archiver.kernel.org>; Mon,  9 May 2022 13:51:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 22F1C3CA972
	for <ltp@archiver.kernel.org>; Mon,  9 May 2022 15:51:35 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF6433CA788
 for <ltp@lists.linux.it>; Mon,  9 May 2022 15:51:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D31BE600147
 for <ltp@lists.linux.it>; Mon,  9 May 2022 15:51:23 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 213CC21B65;
 Mon,  9 May 2022 13:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652104283;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LyVbMy5wmmE3CynI7xiad5JqRUHNztPzEPDLLyfLDVk=;
 b=iCc+LnOzC7FpvlDw+CN0YUbcx47HCg0FSZkGS92NT+JvorcfXP8rUlDmrpdKLpLapDU+Jw
 HpraAR/pDrrwOEVV/dQjktYGTsJxRv0VjxZP2+Uvzh7n4K88ZiCZyJDdL0jlm+N+exZDhj
 yrOXhrR/8r7HtsiRoHOB3XW7eoENbe4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652104283;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LyVbMy5wmmE3CynI7xiad5JqRUHNztPzEPDLLyfLDVk=;
 b=UsYLyBt1uuf56zw+uR1mrtdMW9WmWbL49+Lfsp6D+elilteM4LMeAJVSJNrdrQYxuQKSx5
 f7+lwfjxBcV00nBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F385D13AA5;
 Mon,  9 May 2022 13:51:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jn4LOloceWKsbAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 09 May 2022 13:51:22 +0000
Date: Mon, 9 May 2022 15:51:21 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YnkcWZm/T0snqiSG@pevik>
References: <YnkOEruIKIwEeC3M@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YnkOEruIKIwEeC3M@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preparations
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

Hi Cyril,

> What else should be considered for the release?

Fixes (worth to merge before)
* if-mtu-change.sh: Fix using functions
https://patchwork.ozlabs.org/project/ltp/patch/20220509094322.10959-1-pvorel@suse.cz/

* Fix constant redefinition
https://patchwork.ozlabs.org/project/ltp/list/?series=298174

I'd also like to post rebased
* shell: Fixes for disabled IPv6
https://patchwork.ozlabs.org/project/ltp/list/?series=284532
* shell: Add $TST_MOUNT_DEVICE support
https://patchwork.ozlabs.org/project/ltp/list/?series=291724

Could we decide whether this fix is worth of merging?
* Fix tst_search_driver for x86-64 modules
https://patchwork.ozlabs.org/project/ltp/list/?series=290523

2 additions to runtest/smoketest
* smoketest: Add macsec02.sh
https://patchwork.ozlabs.org/project/ltp/patch/20220310104457.764-1-pvorel@suse.cz/
* smoketest: Add df01.sh
https://patchwork.ozlabs.org/project/ltp/patch/20220322165042.20658-1-pvorel@suse.cz/

I guess we can postpone switching to bionic after the release
* ci: Ubuntu xenial -> bionic
https://patchwork.ozlabs.org/project/ltp/patch/20220316150429.2873-1-pvorel@suse.cz/

also remove rup and rusers can be decided after the release (although it's not
working on my VMs and I don't think it's worth to fix them)
* Remove RPC rup and rusers tests
https://patchwork.ozlabs.org/project/ltp/list/?series=297407

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
