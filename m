Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A61C433F5
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 06:57:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D8D1B3CA69E
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 08:57:13 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC5D33C8C8C
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 08:57:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 806DC600D32
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 08:57:02 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 97D631F37B;
 Thu, 28 Apr 2022 06:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651129021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Jcl8SB+oJuWgBYKVVYrRq+xmmDBxRL9OMYUdbXcUHEs=;
 b=sGI0EsmNdqZDe8LufzA2myhAmDu6YWajgyZZqVYPXEGT24c0IS4y4m8mfqHa5OKbBmCbu0
 Ds3BdsGsV5vUsvU5Ng3LKg1kh3v5LLlntJ25Ubf3XQs8Tjfc4y76S/DtjFmxiyyGD9dgzf
 COou6hn/AW4xsL+mtqIQ7xeAliuNJyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651129021;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Jcl8SB+oJuWgBYKVVYrRq+xmmDBxRL9OMYUdbXcUHEs=;
 b=KxBQWEUZC1GYEXq+aJ1F2jqRFbeayvU5rk4GECirlhC2Z9PYEkADdUp3EjwUMcSSG1zcbP
 +EYQiJY/mgnTn2AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 53E6113A8C;
 Thu, 28 Apr 2022 06:57:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BaTEEr06amLOWgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 28 Apr 2022 06:57:01 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 28 Apr 2022 08:56:57 +0200
Message-Id: <20220428065657.32046-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 5/5] busy_poll: Move TST_{SETUP,
 CLEANUP} to the tests
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

Although having variables in both busy_poll_lib.sh and the tests which
are using it isn't optimal, hooking up callbacks on the reverse end of
include is even worse code.

Suggested-by: Martin Doucha <mdoucha@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Follow-up of "v3 shell: Cleanup getopts usage" patchset [1],
replacing first commit.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/list/?series=297175

 testcases/network/busy_poll/busy_poll01.sh   | 3 +++
 testcases/network/busy_poll/busy_poll02.sh   | 3 +++
 testcases/network/busy_poll/busy_poll03.sh   | 2 ++
 testcases/network/busy_poll/busy_poll_lib.sh | 3 +--
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/testcases/network/busy_poll/busy_poll01.sh b/testcases/network/busy_poll/busy_poll01.sh
index 65f4db3fe..1f7097771 100755
--- a/testcases/network/busy_poll/busy_poll01.sh
+++ b/testcases/network/busy_poll/busy_poll01.sh
@@ -4,6 +4,9 @@
 #
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
+TST_SETUP="setup"
+TST_CLEANUP="cleanup"
+
 cleanup()
 {
 	[ -n "$busy_read_old" ] && \
diff --git a/testcases/network/busy_poll/busy_poll02.sh b/testcases/network/busy_poll/busy_poll02.sh
index ebae4d2f5..634bbd6bd 100755
--- a/testcases/network/busy_poll/busy_poll02.sh
+++ b/testcases/network/busy_poll/busy_poll02.sh
@@ -4,6 +4,9 @@
 #
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
+TST_SETUP="setup"
+TST_CLEANUP="cleanup"
+
 cleanup()
 {
 	[ -n "$busy_poll_old" ] && \
diff --git a/testcases/network/busy_poll/busy_poll03.sh b/testcases/network/busy_poll/busy_poll03.sh
index 04d5978f7..b2e1c0a7a 100755
--- a/testcases/network/busy_poll/busy_poll03.sh
+++ b/testcases/network/busy_poll/busy_poll03.sh
@@ -4,6 +4,8 @@
 #
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
+TST_SETUP="setup"
+TST_CLEANUP="cleanup"
 TST_TEST_DATA="udp udp_lite"
 
 cleanup()
diff --git a/testcases/network/busy_poll/busy_poll_lib.sh b/testcases/network/busy_poll/busy_poll_lib.sh
index de61d3fcd..446ae3d65 100755
--- a/testcases/network/busy_poll/busy_poll_lib.sh
+++ b/testcases/network/busy_poll/busy_poll_lib.sh
@@ -1,10 +1,9 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Linux Test Project, 2016-2022
 # Copyright (c) 2016-2018 Oracle and/or its affiliates. All Rights Reserved.
 
-TST_SETUP="setup"
 TST_TESTFUNC="test"
-TST_CLEANUP="cleanup"
 TST_MIN_KVER="3.11"
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_ROOT=1
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
