Return-Path: <SRS0=cJ4o=OK=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F27FC433EF
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 13:42:51 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 555C760F21
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 13:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 555C760F21
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7CC9F3C8760
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 15:42:48 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B58FB3C19F3
 for <ltp@lists.linux.it>; Mon, 20 Sep 2021 15:42:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id ACFFC1A010F4
 for <ltp@lists.linux.it>; Mon, 20 Sep 2021 15:42:38 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C001F22081;
 Mon, 20 Sep 2021 13:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1632145357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=DHb2PBl39GmNXd/rzr5N/JGEJYlwMec8v+tMQkDg58k=;
 b=zI550s8Hs5WJjUjaXgxafMTMZCftqdgcsJdIYrT9rdoM1nDbzq5bXCYFO4RpA7gsvx1t55
 3BHi5teiLkovvMEUIcIl6I/XmHV08vWPxHsfo77WwBYNnY5/KHiJzbhIbOh20Lc71sGAZF
 2ECMx2TTX1hbE4R0cm4uhfYCgO2Q+tw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1632145357;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=DHb2PBl39GmNXd/rzr5N/JGEJYlwMec8v+tMQkDg58k=;
 b=iHE6sTsdB7NCvRBNZORU55eChE3Djq0JcDQaALiUnZStytGOKjkiJmvcTZPLAdAA4DRU5F
 booUkTChalNKPTBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9135513A71;
 Mon, 20 Sep 2021 13:42:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id W3GzIc2PSGGNXgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 20 Sep 2021 13:42:37 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 20 Sep 2021 15:42:29 +0200
Message-Id: <20210920134229.28014-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] cpuacct.sh: Fix tst_get_free_pids failure
 detection
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

local tasksmax=$(tst_get_free_pids) is successful, even
tst_get_free_pids fails. Assignment needs to be separated from
declaration to get tst_get_free_pids exit code. Similar fix to
87a82a62c ("lib/tst_test.sh: fix ROD_SILENT command return status check")

It fixes error:
tst_pid.c:79: TINFO: Cannot read session user limits from '/sys/fs/cgroup/user.slice/user-0.slice/pids.max'
tst_pid.c:83: TBROK: Expected 1 conversions got 0 FILE '/sys/fs/cgroup/pids/user.slice/user-0.slice/pids.max'
/opt/ltp/testcases/bin/cpuacct.sh: line 77: [: -le: unary operator expected

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/controllers/cpuacct/cpuacct.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/controllers/cpuacct/cpuacct.sh b/testcases/kernel/controllers/cpuacct/cpuacct.sh
index 3002d0a8a..ca881988f 100755
--- a/testcases/kernel/controllers/cpuacct/cpuacct.sh
+++ b/testcases/kernel/controllers/cpuacct/cpuacct.sh
@@ -71,8 +71,10 @@ check_free_memory()
 check_limits()
 {
 	local tasksneeded=$((max * nbprocess))
-	local tasksmax=$(tst_get_free_pids)
-	test $? -eq 0 || return 0
+	local tasksmax
+
+	tasksmax=$(tst_get_free_pids)
+	[ $? -eq 0 ] || return 0
 
 	if [ $tasksmax -le $tasksneeded ]; then
 		tst_brk TCONF "limit of tasks is too low (approximate need $tasksneeded, limit $tasksmax)"
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
