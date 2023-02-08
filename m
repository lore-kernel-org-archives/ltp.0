Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6404C05027
	for <ltp@archiver.kernel.org>; Wed,  8 Feb 2023 09:23:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DFB4F3CC165
	for <ltp@archiver.kernel.org>; Wed,  8 Feb 2023 10:23:42 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B04A3CB0FC
 for <ltp@lists.linux.it>; Wed,  8 Feb 2023 10:23:33 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8A79D1000A48
 for <ltp@lists.linux.it>; Wed,  8 Feb 2023 10:23:31 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 725252095A;
 Wed,  8 Feb 2023 09:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1675848211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1fuzk111ftg8M3AUYlRn7uaFcntH+RXMf4RscS037KY=;
 b=xixT4SIFv6j/ddRxwYdST5wPB0ew86TSvOy3zqtKYqP4yFwRMvjE/6W8E+5go13E1OWhB+
 UmYJT/7RQ/Q5g48zGP9vHiultRwiWUdrAXYCKCAeJs9NFVmLuUKCPCsgqBlrcjuTI8dqt8
 GVS/bW42hQWa7x+okJBmLSwWDaDti+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1675848211;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1fuzk111ftg8M3AUYlRn7uaFcntH+RXMf4RscS037KY=;
 b=1YO1QHuYnayTDV+kQvyEqcZr/9sK0hv/e3YMUKjONUVFq2pwZbIoubgpAog/khcnh1QKfY
 BUpw7Nt5oS0se1Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D5F613A1F;
 Wed,  8 Feb 2023 09:23:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id l1IfDRNq42NYFgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 08 Feb 2023 09:23:31 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  8 Feb 2023 10:23:27 +0100
Message-Id: <20230208092327.28914-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] testscripts/network.sh: Don't load tst_net.sh
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

This should not be needed any more for neither new API and legacy tests
since 04021637f4 ("tst_test.sh: Cleanup getopts usage")

This fixes wrong info when tests are run with network.sh:
    ping01 1 TINFO: using not default LTP netns: 'ns_exec 18242 net,mnt'

because we don't use any custom netns. In case loading is really needed,
we'd need to revert 0da2c285a1.

Fixes: 0da2c285a1 ("tst_net.sh: Remove unneeded $TST_INIT_NETNS variable")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testscripts/network.sh | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/testscripts/network.sh b/testscripts/network.sh
index 15a4cc1c71..afe9c7a977 100755
--- a/testscripts/network.sh
+++ b/testscripts/network.sh
@@ -86,13 +86,6 @@ if [ "$OPTIND" -eq 1 ]; then
 fi
 shift $(($OPTIND - 1))
 
-TST_NO_DEFAULT_RUN=1
-. tst_net.sh
-
-# Reset variables.
-# Don't break the tests which are using 'testcases/lib/cmdlib.sh'
-unset TST_ID TST_LIB_LOADED TST_NO_DEFAULT_RUN
-
 rm -f $CMDFILE
 
 for t in $TEST_CASES; do
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
