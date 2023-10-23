Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFE5C001E0
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 16:03:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 56CBC3CF501
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 18:02:58 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C2943CCDE8
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 18:02:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9F5251A0BC47
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 18:02:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 807AD1FE25;
 Mon, 23 Oct 2023 16:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698076964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pg2ItAt0qEJA0U2ONAI8YMNd7UlOO0I65GHvaeED0CI=;
 b=czEtxkq5bewD//PtHjpEXKtog/bDmOoIj6OuyrCqBEVnA3oL8qAc7qqpPT7vBuFPUheo/p
 LWaB9rwK4c9K0oxZmwatFEAlC4KtJIyavWlaYQWin04qoPOKJlkP11kyilQAp3nBeC5Yie
 KfbnAJC75iFL6NqaSBnJdNEyM2mwE2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698076964;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pg2ItAt0qEJA0U2ONAI8YMNd7UlOO0I65GHvaeED0CI=;
 b=otaPWMs7SkgQZh0MbhTSxV4e0VSgT+uS1PMg/BDVIas4y39lJnh8DjM73Q30n3BMyfLEki
 JPfCVtzr1lNDTxAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5BDFE132FD;
 Mon, 23 Oct 2023 16:02:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sI/dFCSZNmVhJAAAMHmgww
 (envelope-from <mkittler@suse.de>); Mon, 23 Oct 2023 16:02:44 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Mon, 23 Oct 2023 18:02:37 +0200
Message-ID: <20231023160242.3605-1-mkittler@suse.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.14 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-1.04)[87.54%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 0/5] Improve ioctl02.c
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

I implemented the changes that were requested in the last review.
So I amended patch 1 and added patch 5.

I'm not sure how to write generic code in C (in C++ I would just
use templates). So I duplicated the functions that access the
members of the structs termio and termios to test both. Turning
these functions into huge multi-line macros would likely be the
worse choice.

Marius Kittler (5):
  Refactor ioctl02.c to use the new test API
  Make checks for termio flags more strict
  Remove disabled code in ioctl02.c
  Use termios instead of legacy struct in ioctl02.c
  Extend ioctl02 to test termio and termios

 testcases/kernel/syscalls/ioctl/ioctl02.c | 542 +++++++++-------------
 1 file changed, 214 insertions(+), 328 deletions(-)

-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
