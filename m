Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A166BE7F153
	for <ltp@archiver.kernel.org>; Fri, 29 Sep 2023 10:28:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 967473CE124
	for <ltp@archiver.kernel.org>; Fri, 29 Sep 2023 12:28:01 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C889C3C9943
 for <ltp@lists.linux.it>; Fri, 29 Sep 2023 12:27:50 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 65CA560283E
 for <ltp@lists.linux.it>; Fri, 29 Sep 2023 12:27:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 987CD218E9;
 Fri, 29 Sep 2023 10:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695983268;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SSM2CUNa/Ilu7nDhX/B4+EnQYiLOFqVThu4qsuv5N14=;
 b=Cigw90SiOosqBvwwuH5jwKBbtcNFtdUb1w3UHTY3QHbKFLEL6w/WYXDbv6kYGMKXVzwoa1
 x7cpsD1tDlTYOjbvGG5dYWTZvIDNBoA5AhgCYvG2eIn/QTnq6FqhZ0SjRhT8wlaFWH3Wg7
 xzkLVduXeVBcs8+hKuOf6W89jkehoKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695983268;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SSM2CUNa/Ilu7nDhX/B4+EnQYiLOFqVThu4qsuv5N14=;
 b=ofDiPoEpTr1d4bfBisoGYaY0NLXzQS3MPzdqviFZ5ArkZKKEKkYAABrtVFHrUQedq1FHSU
 qCWCTTimWqLDzcAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4C0E31390A;
 Fri, 29 Sep 2023 10:27:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BbNxEKSmFmXpJgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 29 Sep 2023 10:27:48 +0000
Date: Fri, 29 Sep 2023 12:27:46 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it, linux-kernel@vger.kernel.org,
 libc-alpha@sourceware.org, lwn@lwn.net, akpm@linux-foundation.org,
 torvalds@linux-foundation.org, Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230929102746.GA370555@pevik>
References: <20230929095144.GD364346@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230929095144.GD364346@pevik>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] The Linux Test Project has been released for SEPTEMBER
 2023
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

...
> The latest version of the test-suite contains 3000+ tests for the Linux
> and can be downloaded at:

> https://github.com/linux-test-project/ltp/releases/tag/YYYYMMDD

https://github.com/linux-test-project/ltp/releases/tag/20230929

I'm sorry for the noise.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
