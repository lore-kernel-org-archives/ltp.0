Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC58BC433EF
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 12:10:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 515DD3C7FC0
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 13:10:51 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 33FDC3C13DE
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 13:10:41 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A600320005C
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 13:10:40 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DB451212C0;
 Tue, 30 Nov 2021 12:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1638274239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IDzMjJ8lJ80BC4IwSlL+ylJ9QmrXfY7txNj42LU6f6o=;
 b=X1J2Kb1kYwV1pc+fHCEvOr3ggLl4kaIhcaWSnFhUy/ID5MfFPpFJsZMrvmTXfq4f4P9srA
 QA/iVqTKCsBoybE93Z+6/oY9CMRVidp3nhiJUnMfSnEWkUr6MqxIth9UcWd+eyzy4ATqp6
 VrvYz7k6YEWoz5wz4W5CQmcz4Vukixo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A07213C98;
 Tue, 30 Nov 2021 12:10:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SaQaHL8UpmGTbAAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Tue, 30 Nov 2021 12:10:39 +0000
To: ltp@lists.linux.it
Date: Tue, 30 Nov 2021 13:10:20 +0100
Message-Id: <20211130121022.14296-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] Create common.h utilities for aiodio testsuite
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

aiodio testsuite has multiple copy/paste inside the source code. For
this reason, common.h has been created for all aiodio tests.
dio_truncate is the first test based on LTP API and now it's using it.

Andrea Cervesato (2):
  Add common.h utilities for aiodio tests
  Use common.h in dio_truncate test

 testcases/kernel/io/ltp-aiodio/common.h       | 54 +++++++++++++++++++
 testcases/kernel/io/ltp-aiodio/dio_truncate.c | 48 ++---------------
 2 files changed, 58 insertions(+), 44 deletions(-)
 create mode 100644 testcases/kernel/io/ltp-aiodio/common.h

-- 
2.34.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
