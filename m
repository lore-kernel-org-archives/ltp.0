Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F92C433EF
	for <ltp@archiver.kernel.org>; Tue, 22 Mar 2022 16:51:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 88D3B3C9239
	for <ltp@archiver.kernel.org>; Tue, 22 Mar 2022 17:51:00 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE6643C2A5B
 for <ltp@lists.linux.it>; Tue, 22 Mar 2022 17:50:48 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C5AFC600668
 for <ltp@lists.linux.it>; Tue, 22 Mar 2022 17:50:47 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BE47A210E2;
 Tue, 22 Mar 2022 16:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647967846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8BpyoKwik69z1TZ28/92g/DixB4I4FeLc4x9yEYDiWY=;
 b=jCG4jIaMFzdrOAyvIAaZ9iqRqIESjD7zA70t8nT4E+Lq+JxO7CRv9EOhaVsiH5KvWerdWr
 EsGbZdDIb/A9U+vXKZcYskUCu45fMofdnLrch9c6GeAfum3jb0gjyh7eqQXp9ro6xxUBNe
 fl51I/kCIpPyKHBV+MtW66rI6jWtrGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647967846;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8BpyoKwik69z1TZ28/92g/DixB4I4FeLc4x9yEYDiWY=;
 b=X5w4SrmZ2O4u3c4L+OqultuFSCSCtgxERITpCH6uQ/p1f3T6kT9saHY8kvoZu/dYTRWFOn
 aoIIkImKOKU+oeBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7FC5F13419;
 Tue, 22 Mar 2022 16:50:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +/aZHWb+OWIidQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 22 Mar 2022 16:50:46 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 22 Mar 2022 17:50:42 +0100
Message-Id: <20220322165042.20658-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] smoketest: Add df01.sh
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

To test 1) pure tst_test.sh usage (other shell tests are network tests)
2) loop device usage from shell

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
NOTE: based on previous change (not yet merged, nor reviewed):

smoketest: Add macsec02.sh
https://patchwork.ozlabs.org/project/ltp/patch/20220310104457.764-1-pvorel@suse.cz/

 runtest/smoketest | 1 +
 1 file changed, 1 insertion(+)

diff --git a/runtest/smoketest b/runtest/smoketest
index b7c539640b..99bb31697e 100644
--- a/runtest/smoketest
+++ b/runtest/smoketest
@@ -12,6 +12,7 @@ stat04 symlink01 -T stat04
 utime01A symlink01 -T utime01
 rename01A symlink01 -T rename01
 splice02 splice02 -s 20
+df01_ext4_sh df01.sh -f ext4
 shell_test01 echo "SUCCESS" | shell_pipe01.sh
 ping01 ping01.sh
 ping602 ping02.sh -6
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
