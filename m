Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D280FC7EE36
	for <ltp@archiver.kernel.org>; Wed,  1 Mar 2023 15:31:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 338FF3CDDBB
	for <ltp@archiver.kernel.org>; Wed,  1 Mar 2023 16:31:44 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 970F33CDD56
 for <ltp@lists.linux.it>; Wed,  1 Mar 2023 16:30:28 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5389D1402FB7
 for <ltp@lists.linux.it>; Wed,  1 Mar 2023 16:30:23 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 877A41FE15;
 Wed,  1 Mar 2023 15:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1677684622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HywBZ/O6xCvlMaiY8FJTMz13DAUM1sNMyl1oAcgmEls=;
 b=a56cn+hjW6zl5w11YQ0g76AvjR5c7JldtYj/BQ409slj4zEvEhk6B0vCSnI8bSv0oRfmGX
 GOBNRkg8bcGxJBAH2KmzkaP7k9zp+a2ozj4VY+gO1XUsr12J/vTxPyz0GcsFSIibFml9Wz
 aAxMWXbqeHwx1xsN+t8vfkwNfpFyDtU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 62F3913A3E;
 Wed,  1 Mar 2023 15:30:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LHIkFo5v/2MjXgAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Wed, 01 Mar 2023 15:30:22 +0000
To: ltp@lists.linux.it
Date: Wed,  1 Mar 2023 16:28:12 +0100
Message-Id: <20230301152818.4427-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/6] Refactor mqns testing suite
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

Refactoring mqns testing suite and removing libclone dependency.

Andrea Cervesato (6):
  Refactor mqns_01 using new LTP API
  Refactor mqns_02 using new LTP API
  Refactor mqns_03 using new LTP API
  Refactor mqns_04 using new LTP API
  Remove deprecated header files from mqns suite
  Remove libclone dependency from mqns suite

 runtest/containers                            |  13 +-
 testcases/kernel/containers/mqns/Makefile     |  27 +-
 testcases/kernel/containers/mqns/mqns.h       |  11 -
 testcases/kernel/containers/mqns/mqns_01.c    | 180 +++-------
 testcases/kernel/containers/mqns/mqns_02.c    | 241 +++++--------
 testcases/kernel/containers/mqns/mqns_03.c    | 318 ++++++++----------
 testcases/kernel/containers/mqns/mqns_04.c    | 286 ++++++++--------
 .../kernel/containers/mqns/mqns_helper.h      |  53 ---
 8 files changed, 426 insertions(+), 703 deletions(-)
 delete mode 100644 testcases/kernel/containers/mqns/mqns.h
 delete mode 100644 testcases/kernel/containers/mqns/mqns_helper.h

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
