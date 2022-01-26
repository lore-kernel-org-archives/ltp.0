Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D4BC28CF5
	for <ltp@archiver.kernel.org>; Wed, 26 Jan 2022 18:12:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 86EB83C9710
	for <ltp@archiver.kernel.org>; Wed, 26 Jan 2022 19:12:47 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F0CEA3C96C0
 for <ltp@lists.linux.it>; Wed, 26 Jan 2022 19:12:17 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D211A1400218
 for <ltp@lists.linux.it>; Wed, 26 Jan 2022 19:12:16 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3C8661F3BA;
 Wed, 26 Jan 2022 18:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643220736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5XuqF4ewwiUyjmDGw4eVkacLyMRMP1nYHG1NnCP0Zp8=;
 b=dPKju7+kAudnxmxx/bnxAA/Xhm1PnE1/aicGPrGjJzijsCVupkXnUiIpNTdEmwIORB4eBe
 4wHcoJiI8SLjnzNnHo+Fm25qXhRZTzaWZzXAPLcpIEk4JchFmUccT9GmQkjC9Tx/bieE05
 hb3MIwWTVro+19Pnjt97aNMUdcOTD9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643220736;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5XuqF4ewwiUyjmDGw4eVkacLyMRMP1nYHG1NnCP0Zp8=;
 b=VSDsgOZ1AkQYdEL+NFLmGML/ag5L8m93zN6YtP+h0PXJyraqC38y9m5Xf6JgcTdqfrDzN3
 n9grlkaH/ijVZICg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1511413E30;
 Wed, 26 Jan 2022 18:12:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sNFmAwCP8WGbcQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 26 Jan 2022 18:12:16 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 26 Jan 2022 19:12:07 +0100
Message-Id: <20220126181210.24897-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220126181210.24897-1-pvorel@suse.cz>
References: <20220126181210.24897-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/5] tst_test.sh: tst_mkfs(): Add support for extra
 opts
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

Allow to pass options after device name
(to sync with C API).

NOTE: not adding it to legacy shell API (thus no need to change
test_robind.sh).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_test.sh | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index eb3bf0df12..4707613158 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -343,9 +343,8 @@ tst_mkfs()
 	[ -z "$fs_type" ] && fs_type="$TST_DEFAULT_FS_TYPE"
 
 	local device=${2:-$TST_DEVICE}
-	[ $# -ge 1 ] && shift
-	[ $# -ge 1 ] && shift
-	local fs_opts="$@"
+	local fs_opts="$3"
+	local extra_opts="$4"
 
 	if [ -z "$device" ]; then
 		tst_brk TBROK "No device specified"
@@ -353,8 +352,8 @@ tst_mkfs()
 
 	tst_require_cmds mkfs.$fs_type
 
-	tst_res TINFO "Formatting $device with $fs_type extra opts='$fs_opts'"
-	ROD_SILENT mkfs.$fs_type $fs_opts $device
+	tst_res TINFO "Formatting $device with $fs_type opts='$fs_opts' extra opts='$extra_opts'"
+	ROD_SILENT mkfs.$fs_type $fs_opts $device $extra_opts
 }
 
 # Detect whether running under hypervisor: Microsoft Hyper-V
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
