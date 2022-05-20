Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA8AC433EF
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 12:43:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4DBB43CAAF7
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 14:43:32 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B4043CA948
 for <ltp@lists.linux.it>; Fri, 20 May 2022 14:43:21 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9B8D91A01167
 for <ltp@lists.linux.it>; Fri, 20 May 2022 14:43:20 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E33F61FA2F;
 Fri, 20 May 2022 12:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1653050599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mRTVb9Kr6+nr8D+igYSxCDY7NKpBKTfHprPyv+JJ7A8=;
 b=wVmHhRWwWBpZfI2ewf3oO9KwUdCqlLW/yhJXYZR3Wj7fN1v2vBie5w0jOqdQXQvjPyVYwa
 JTvCjzmjgA4eyUJxbq9IXeS+FPerJ7hLVzEzaXl0xun7iOvoggfUTrUXR5KN0LLuo0hjXt
 YyzFwlv1aWweQenlCqBNV57i7JolWqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1653050599;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mRTVb9Kr6+nr8D+igYSxCDY7NKpBKTfHprPyv+JJ7A8=;
 b=DUwd32i7sPePxMFzDEjRxHcrZvHau2PPYaZBmjDgbqDTsLk/LtwE9buQ2gQjzphA31/kQm
 r8iuiEhj/O0yk0CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A5F513AF4;
 Fri, 20 May 2022 12:43:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id shTLHueMh2JETgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 20 May 2022 12:43:19 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 20 May 2022 14:43:11 +0200
Message-Id: <20220520124314.20251-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] Check for -i0
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
Cc: Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

NOTE: this should be merged after Cyril's runtime patch
(will need to get rebased).

Kind regards,
Petr

Petr Vorel (3):
  tst_test.sh: Allow -i0
  tst_test: Check for -i >= 0
  doc/maintainer: Check also -i0

 doc/maintainer-patch-review-checklist.txt | 1 +
 lib/tst_test.c                            | 2 ++
 testcases/lib/tst_test.sh                 | 4 ++--
 3 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
