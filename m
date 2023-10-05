Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D11F2E92708
	for <ltp@archiver.kernel.org>; Thu,  5 Oct 2023 14:43:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 033733D012F
	for <ltp@archiver.kernel.org>; Thu,  5 Oct 2023 16:43:49 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 719A43CF7AF
 for <ltp@lists.linux.it>; Thu,  5 Oct 2023 16:43:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B54C7209A00
 for <ltp@lists.linux.it>; Thu,  5 Oct 2023 16:43:37 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0EEF41F88D;
 Thu,  5 Oct 2023 14:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696517017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0YzRtL9jUhwbi1Z6awGB89n/weeM4uGOwJU3YIs6dds=;
 b=UFj9g8zYZZ0wLjpeZYpUFMvS11Ok2HWAyqK5OVDTDfsSQv9a0F7VJIWsxLfsHqEHden+fe
 e9L5n8VXHEZE5P+E86FMu33gYYISt2+cjsd4ppmCdspaGudm2FniNTwf6ZfiLwoyVZO1uC
 MAvvFf1K2png3OFZ/QzZyw1qbIEHggo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696517017;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0YzRtL9jUhwbi1Z6awGB89n/weeM4uGOwJU3YIs6dds=;
 b=Snp2rZIORl//5Q/SUy3Z8UUYkDsngPlnTrXZNC7vZ66y0RG1bDlnrTW+1n8vBd4gDZYhmc
 +zlnWZUOilKTWNAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D9FDA139C2;
 Thu,  5 Oct 2023 14:43:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bcSeM5jLHmXGOAAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Thu, 05 Oct 2023 14:43:36 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu,  5 Oct 2023 16:43:33 +0200
Message-Id: <20231005144335.16509-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] Rewrite the gettid() testing suite
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Rewrite gettid01 and create a new gettid02 test in order to check all
gettid() basic functionalities, according with its manual.

Andrea Cervesato (2):
  Rewrite gettid01 test
  Add gettid02 test

 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/gettid/.gitignore |   1 +
 testcases/kernel/syscalls/gettid/Makefile   |   4 +-
 testcases/kernel/syscalls/gettid/gettid01.c | 105 ++++----------------
 testcases/kernel/syscalls/gettid/gettid02.c |  63 ++++++++++++
 5 files changed, 88 insertions(+), 86 deletions(-)
 create mode 100644 testcases/kernel/syscalls/gettid/gettid02.c

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
