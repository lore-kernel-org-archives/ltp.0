Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405B6ECAAD3
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 08:47:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 656EF3CA9FC
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 10:47:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E67B63C8CC0
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 10:47:28 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 66A901A003C0
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 10:47:27 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 705501F8D7
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 08:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662713247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=Vc7h5hXOphEcedq/uYckH4cP6f813E+Uoq7nsataaFE=;
 b=WGxExJM+OSQEcnT2GwtZ+uoNGh60kAznjnWkE+9XTU80FOcA9hx8Ld+JTNyxPJBjg01mRf
 bZnBkMAUi9PUg/sfl6mo7St+fpB3y7/neSiJVGtxPA1JRUfwZYP/w6FlkkSgIvaYTIHY7J
 Iw/2srorJXqjBSzDGFd9wHdKIWzxeJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662713247;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=Vc7h5hXOphEcedq/uYckH4cP6f813E+Uoq7nsataaFE=;
 b=ZE4Tg2JuYg3fCHH6JniXuOldnPtryLeoxH2naNMPetKDGapM9Yfe4WiWohcJOPcCPaCTDV
 QQO5aPLKdgoFRwDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5B707139D5
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 08:47:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Kdi0FZ/9GmOsTwAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 09 Sep 2022 08:47:27 +0000
Date: Fri, 9 Sep 2022 10:49:22 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: LTP List <ltp@lists.linux.it>
Message-ID: <Yxr+EpKTnKQbKXTb@yuki>
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] September LTP release
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
It's time to start working on LTP September relelase.

First of all I'm thinking of increasing the bus factor for LTP so if
there is anyone who wants to drive the release process instead of me
please sign up ASAP. I will of course review patches and help with the
release, but it would nice if someone else tried to do all the little
things for release as sending emails, deciding what should go to release
after freeze, preparing release notes, uploading tarballs on github,
etc.

And in order not to delay things further, please start pointing out
patches that should go in before the release. I guess Martin runtime
fixes should go in. Anything else?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
