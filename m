Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C60E7C6FA82
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 07:58:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 111313CAD59
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 09:58:28 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 515BB3C93AF
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 09:58:18 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A7FFC602351
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 09:58:17 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E242E1F88E;
 Thu, 22 Sep 2022 07:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663833496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iQvDh5Z2kdxTML6NOi/ouM87A44yqYCSTM4grpd0orE=;
 b=ypHBiQMu0I8JFq1NoIFQgBWBF3/CBlyMYaJ6n7578nM2IqILWLb/LD7X/9YZlaA5cwAo58
 CQFYE3GM0DKjve6ryFoiG2vowOjRRyi46j94N0sFGHqQv41dpYAh78R0JUq0kqxUwyBhir
 IWDE3/Bbpxp+N4nh9MzNvq2Y/zJJPoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663833496;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iQvDh5Z2kdxTML6NOi/ouM87A44yqYCSTM4grpd0orE=;
 b=sJ6m867kOQ5I5CgkXKuVCR7FaATGYwpnFsudUgMBFrWkVX4XvrD6izEomk1XHDbXQ+I2/q
 kSXoZeR/A7Yoc1DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CE4B013AA5;
 Thu, 22 Sep 2022 07:58:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ovlhMZgVLGNtVgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 22 Sep 2022 07:58:16 +0000
Date: Thu, 22 Sep 2022 10:00:14 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Message-ID: <YywWDjPOfxunE6fC@yuki>
References: <1663143142-2283-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YyG61JHO7iDAfJ1N@yuki>
 <bd50a9da-0b32-2318-31ec-67a78155cc25@fujitsu.com>
 <12eff5a1-bf6b-59bf-bfca-7a1d4f3ca009@fujitsu.com>
 <YysX7FVAHO6HkLLZ@yuki>
 <20220921154025.kek7drx67sx2mpub@wittgenstein>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220921154025.kek7drx67sx2mpub@wittgenstein>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/3] syscalls/creat09: Add umask test condition
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
> > Is there any in-flight patch for v6.0 that fixes this for XFS?
> 
> You're looking for
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=426b4ca2d6a5ab51f6b6175d06e4f8ddea434cdf

That's the missing piece!

I've added this patch to the test tags and pushed, thanks everyone.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
