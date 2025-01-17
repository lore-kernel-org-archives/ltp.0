Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AE1C02183
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 13:56:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B974F3C7BCC
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 14:56:19 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 237C63C76E8
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 14:55:44 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7C2A51B621D9
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 14:55:43 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 38C292117E;
 Fri, 17 Jan 2025 13:55:42 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1692113A30;
 Fri, 17 Jan 2025 13:55:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IHLiA15himeydgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 17 Jan 2025 13:55:42 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 17 Jan 2025 14:55:39 +0100
Message-ID: <20250117135539.773036-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117135539.773036-1-pvorel@suse.cz>
References: <20250117135539.773036-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: 38C292117E
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] tst_net.sh: Add more doc
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Example usage:

# ping01.sh
ping01 1 TINFO: Running: ping01.sh -h
ping01 1 TINFO: Tested kernel: Linux ts 6.13.0-rc4-1.g4a5c6a6-default #1 SMP PREEMPT_DYNAMIC Sun Dec 22 22:11:35 UTC 2024 (4a5c6a6) x86_64 x86_64 x86_64 GNU/Linux
Usage: /opt/ltp/testcases/bin/ping01.sh [-6]

OPTIONS (network tests only)
----------------------------
-6      IPv6 tests

Environment Variables (network tests only)
------------------------------------------
TST_NET_RHOST_RUN_DEBUG=1
Print commands used by tst_rhost_run()

LTP_NET_FEATURES_IGNORE_PERFORMANCE_FAILURE=1
Ignore performance failure and test only the network functionality in tests
which use tst_netload_compare().

OPTIONS
-------
-h      Prints this help
-i n    Execute test n times

Environment Variables
---------------------
KCONFIG_PATH         Specify kernel config file
KCONFIG_SKIP_CHECK   Skip kernel config check if variable set (not set by default)
LTPROOT              Prefix for installed LTP (default: /opt/ltp)
LTP_COLORIZE_OUTPUT  Force colorized output behaviour (y/1 always, n/0: never)
LTP_DEV              Path to the block device to be used (for .needs_device)
LTP_DEV_FS_TYPE      Filesystem used for testing (default: ext2)
LTP_SINGLE_FS_TYPE   Testing only - specifies filesystem instead all supported (for TST_ALL_FILESYSTEMS=1)
LTP_TIMEOUT_MUL      Timeout multiplier (must be a number >=1, ceiled to int)
TMPDIR               Base directory for template directory (for .needs_tmpdir, default: /tmp)


 testcases/lib/tst_net.sh | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 9a8b8d7214..4f2336537b 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -42,10 +42,29 @@ tst_net_usage()
 	if [ -n "$TST_USAGE_CALLER" ]; then
 		$TST_USAGE_CALLER
 	else
-		echo "Usage: $0 [-6]"
-		echo "OPTIONS"
+	cat << EOF
+Usage: $0 [-6]
+
+OPTIONS (network tests only)
+----------------------------
+EOF
 	fi
-	echo "-6      IPv6 tests"
+
+	cat << EOF
+-6      IPv6 tests
+
+Environment Variables (network tests only)
+------------------------------------------
+TST_NET_RHOST_RUN_DEBUG=1
+Print commands used by tst_rhost_run()
+
+LTP_NET_FEATURES_IGNORE_PERFORMANCE_FAILURE=1
+Ignore performance failure and test only the network functionality in tests
+which use tst_netload_compare().
+
+OPTIONS
+-------
+EOF
 }
 
 tst_net_remote_tmpdir()
-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
