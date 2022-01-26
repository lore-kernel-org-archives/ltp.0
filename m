Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65346C3526D
	for <ltp@archiver.kernel.org>; Wed, 26 Jan 2022 14:52:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D49A83C9670
	for <ltp@archiver.kernel.org>; Wed, 26 Jan 2022 15:52:05 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AEFA33C9536
 for <ltp@lists.linux.it>; Wed, 26 Jan 2022 15:51:47 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D613E6000F2
 for <ltp@lists.linux.it>; Wed, 26 Jan 2022 15:51:46 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2E7F91F3BA;
 Wed, 26 Jan 2022 14:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643208706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p0eDjWjGHr8gR4alMa+SstsVYdi5gfrDqKKatFd3MpA=;
 b=Ey+tqqYlZqE0bebsNzo+tIjpNKqoO1ioai9u7GsIyOELRueHEwYZs3dun8ssDMbbzk8neM
 N6g7tsBbehLqcTP/OoFVhjZqtaGsUW8nsWFMKVXfhNnXHXs81cUCitKrP5G7ULjqimk8Dw
 gKjQVPhCqcQ3ezSNiDEcpgLZMBAQ7tI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643208706;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p0eDjWjGHr8gR4alMa+SstsVYdi5gfrDqKKatFd3MpA=;
 b=WsMLkp2P1fPbyphMTA3PuB/fS8xlVP9J8SYDiDmoFVaz3eHqkEHbLovyk5NzI6B3Ibh5M1
 Hy50TSJSb9D4FEBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0DD9213A67;
 Wed, 26 Jan 2022 14:51:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CMa3AQJg8WHLCwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 26 Jan 2022 14:51:46 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 26 Jan 2022 15:51:40 +0100
Message-Id: <20220126145141.13825-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220126145141.13825-1-pvorel@suse.cz>
References: <20220126145141.13825-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] tst_test.sh: Print environment variables in help
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

to sync with C API.

Unlike C API environment variables are printed at the top,
because we expect custom $TST_USAGE function prints part of the usage
itself (but not all tests do).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_test.sh | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 30614974c3..a7fd7b19c6 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -448,12 +448,30 @@ tst_usage()
 	if [ -n "$TST_USAGE" ]; then
 		$TST_USAGE
 	else
-		echo "usage: $0"
-		echo "OPTIONS"
+		cat << EOF
+usage: $0
+
+Options
+-------
+EOF
 	fi
 
 	echo "-h      Prints this help"
 	echo "-i n    Execute test n times"
+
+		cat << EOF
+
+Environment Variables
+---------------------
+KCONFIG_PATH         Specify kernel config file
+KCONFIG_SKIP_CHECK   Skip kernel config check if variable set (not set by default)
+LTPROOT              Prefix for installed LTP (default: /opt/ltp)
+LTP_COLORIZE_OUTPUT  Force colorized output behaviour (y/1 always, n/0: never)
+LTP_DEV              Path to the block device to be used (for .needs_device)
+LTP_DEV_FS_TYPE      Filesystem used for testing (default: ext2)
+LTP_TIMEOUT_MUL      Timeout multiplier (must be a number >=1, ceiled to int)
+TMPDIR               Base directory for template directory (for .needs_tmpdir, default: /tmp)
+EOF
 }
 
 _tst_resstr()
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
