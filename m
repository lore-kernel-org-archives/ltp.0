Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1F2EB64D7
	for <ltp@archiver.kernel.org>; Wed, 28 Jun 2023 08:19:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A1803CC31E
	for <ltp@archiver.kernel.org>; Wed, 28 Jun 2023 10:18:59 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD6283C99BA
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 10:18:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DAF416002C8
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 10:18:36 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 042771F8C3;
 Wed, 28 Jun 2023 08:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687940315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7O+9UlhVyGqLF8eZbsN9Gf5jaeC0R5CmHccTKNDY5Yo=;
 b=Ut9xUBdRWpRr6T8lZIpojwR094b6SI2HBQdrrAoEN7zBtGAkdOienPoKasJkYC79Ci4Eks
 6yD0syeXPkqXLlR4cVDtY0ZDr4NtgNrrNVH04ZRNOqMVsyQScHeH/WdnfYiuNavwL99UUX
 6M1ykmz1YjwJnR8R0szCwewoEqMqIgA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687940315;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7O+9UlhVyGqLF8eZbsN9Gf5jaeC0R5CmHccTKNDY5Yo=;
 b=VFyghLOCzLH+Y3MnKGmYA7DWwI18x79zhChDYo3NlSD2wHoYaMnNNoKumW9iRHb4iBi8n0
 lx+xi7BG5UiJ90BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B80D7138E8;
 Wed, 28 Jun 2023 08:18:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aWzZKdrsm2QhVAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 28 Jun 2023 08:18:34 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 28 Jun 2023 10:18:28 +0200
Message-Id: <20230628081831.123189-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] Fix O_DIRECT definition for various archs
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
Cc: NeilBrown <neilb@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

this work is based on Neil's report.

I'm not sure if better would be  if the fallback O_DIRECT definition
would be removed everywhere and tests just define _GNU_SOURCE (no
library code is using O_DIRECT atm).

But the problem was found when we during some debugging use lapi/fcntl.h
inside of the library (where we don't want to set _GNU_SOURCE, otherwise
all C based LTP tests would be _GNU_SOURCE).

Kind regards,
Petr

Petr Vorel (3):
  lapi/fcntl.h: Fix O_DIRECT definition for various archs
  fsstress/global.h: Include lapi/fcntl.h
  ltpscsi/scsimain.c: Remove O_DIRECT fallback definition

 include/lapi/fcntl.h                        | 11 ++++++++++-
 testcases/kernel/fs/fsstress/global.h       |  2 +-
 testcases/kernel/fs/scsi/ltpscsi/scsimain.c |  5 +----
 3 files changed, 12 insertions(+), 6 deletions(-)

-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
