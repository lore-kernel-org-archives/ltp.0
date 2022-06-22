Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CA4C43334
	for <ltp@archiver.kernel.org>; Wed, 22 Jun 2022 07:01:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E75943C94F5
	for <ltp@archiver.kernel.org>; Wed, 22 Jun 2022 09:01:54 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 967873C9223
 for <ltp@lists.linux.it>; Wed, 22 Jun 2022 09:01:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 461011A00682
 for <ltp@lists.linux.it>; Wed, 22 Jun 2022 09:01:42 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 65EDB21C4B;
 Wed, 22 Jun 2022 07:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1655881301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9VYVKW/s6+vMYQvY57raqDo0OyGSeHJfcT4Pnq7vbfg=;
 b=jq/ZN7sEaNYBtp837G5r1Hkr7zartn+q354D2Oy6UL6WGmuhlFYLf3NX3w7U45I1zfvYU0
 FBcDWBZPeTREg5ywiErwU4PW84w4NuAC91GaOhMyaUdlevOrEpY0n33j+E74jsxKhCj7Ch
 d8cGeq/HNuFA1NWtf5f5yYn4Ga6aDAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1655881301;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9VYVKW/s6+vMYQvY57raqDo0OyGSeHJfcT4Pnq7vbfg=;
 b=FhiDNFMOuKGR8qobuo+shtl2/S7lA70TPw79IqdclzeF/TxxMcybQ7pWsIk+BWOXpFGaiQ
 ztNEMLNnXuyJlzDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 01306134A9;
 Wed, 22 Jun 2022 07:01:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id t3q8MVS+smKqWgAAMHmgww
 (envelope-from <akumar@suse.de>); Wed, 22 Jun 2022 07:01:40 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Wed, 22 Jun 2022 12:31:28 +0530
Message-Id: <20220622070137.24286-1-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/9] Simplify and convert some of rename tests to new
 LTP API
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

Rewriting some of rename tests using new LPT API and removing
rename02.c file as same testcase is covered in rename01.c.


Avinesh Kumar (9):
  Rewrite rename01.c using new LTP API
  Remove rename02.c
  Rewrite rename03.c using new LTP API
  Rewrite rename04.c using new LTP API
  Rewrite rename05.c using new LTP API
  Rewrite rename06.c using new LTP API
  Rewrite rename07.c using new LTP API
  Rewrite rename08.c using new LTP API
  Rewrite rename10.c using new LTP API

 runtest/syscalls                            |   1 -
 testcases/kernel/syscalls/rename/rename01.c | 252 ++++--------------
 testcases/kernel/syscalls/rename/rename02.c | 192 --------------
 testcases/kernel/syscalls/rename/rename03.c | 267 ++++----------------
 testcases/kernel/syscalls/rename/rename04.c | 201 +++------------
 testcases/kernel/syscalls/rename/rename05.c | 189 ++------------
 testcases/kernel/syscalls/rename/rename06.c | 182 ++-----------
 testcases/kernel/syscalls/rename/rename07.c | 166 ++----------
 testcases/kernel/syscalls/rename/rename08.c | 200 ++-------------
 testcases/kernel/syscalls/rename/rename10.c | 182 ++-----------
 10 files changed, 253 insertions(+), 1579 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/rename/rename02.c

-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
