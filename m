Return-Path: <SRS0=CJzs=O2=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB52AC433F5
	for <ltp@archiver.kernel.org>; Wed,  6 Oct 2021 10:31:31 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89D7C61177
	for <ltp@archiver.kernel.org>; Wed,  6 Oct 2021 10:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 89D7C61177
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE8453C7F5B
	for <ltp@archiver.kernel.org>; Wed,  6 Oct 2021 12:31:28 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C92A3C6646
 for <ltp@lists.linux.it>; Wed,  6 Oct 2021 12:31:08 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F1DA31400F3B
 for <ltp@lists.linux.it>; Wed,  6 Oct 2021 12:31:07 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 942592036B;
 Wed,  6 Oct 2021 10:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1633516267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mAyH2CJtRCU4xqE/aaGcE/R2zsO563hWfAIpryl4syc=;
 b=hrVAoC3lOIJq4E1CvdSkFPzfRX0Namn90jkVzugIqeiJNkt5yYVCzHj3RungHW1PWxa817
 RXt3fJKxUI9ewXzf2uKvFEFP6L4JIh7fs9P/xOT/2gkl2VSfZ5EDhHEkMfos4CDnIL1mln
 Z/8STleHgC3fgZzGkvBGtd1dsSWCKV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1633516267;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mAyH2CJtRCU4xqE/aaGcE/R2zsO563hWfAIpryl4syc=;
 b=qq+RELZbPbkyGAf160A8Gjgd3ORKNLnPovVv7wbnzfMOkFu/oPM4PMSnEJ4Mvgg12w3pHm
 TB3WDIH1aohFW9Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5BA8F13E19;
 Wed,  6 Oct 2021 10:31:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cLu6FOt6XWF/dAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 06 Oct 2021 10:31:07 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  6 Oct 2021 12:30:58 +0200
Message-Id: <20211006103059.9617-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006103059.9617-1-pvorel@suse.cz>
References: <20211006103059.9617-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 2/3] IMA: Move ima_check to ima_setup.sh
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
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Alex Henrie <alexh@vpitech.com>

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Alex Henrie <alexh@vpitech.com>
[ pvorel: add test_file parameter to ima_check(), keep $TEST_FILE in
ima_measurements.sh ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../integrity/ima/tests/ima_measurements.sh   | 31 ++-----------------
 .../security/integrity/ima/tests/ima_setup.sh | 28 +++++++++++++++++
 2 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
index ef8577d30..a83c416de 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
@@ -21,33 +21,6 @@ setup()
 	[ -f "$IMA_POLICY" ] || tst_res TINFO "not using default policy"
 }
 
-ima_check()
-{
-	local algorithm digest expected_digest line tmp
-
-	# need to read file to get updated $ASCII_MEASUREMENTS
-	cat $TEST_FILE > /dev/null
-
-	line="$(grep $TEST_FILE $ASCII_MEASUREMENTS | tail -1)"
-
-	if tmp=$(get_algorithm_digest "$line"); then
-		algorithm=$(echo "$tmp" | cut -d'|' -f1)
-		digest=$(echo "$tmp" | cut -d'|' -f2)
-	else
-		tst_res TBROK "failed to get algorithm/digest for '$TEST_FILE': $tmp"
-	fi
-
-	tst_res TINFO "computing digest for $algorithm algorithm"
-	expected_digest="$(compute_digest $algorithm $TEST_FILE)" || \
-		tst_brk TCONF "cannot compute digest for $algorithm algorithm"
-
-	if [ "$digest" = "$expected_digest" ]; then
-		tst_res TPASS "correct digest found"
-	else
-		tst_res TFAIL "digest not found"
-	fi
-}
-
 check_iversion_support()
 {
 	local device mount fs
@@ -83,7 +56,7 @@ test1()
 {
 	tst_res TINFO "verify adding record to the IMA measurement list"
 	ROD echo "$(date) this is a test file" \> $TEST_FILE
-	ima_check
+	ima_check $TEST_FILE
 }
 
 test2()
@@ -92,7 +65,7 @@ test2()
 	tst_res TINFO "verify updating record in the IMA measurement list"
 	check_iversion_support || return
 	ROD echo "$(date) modified file" \> $TEST_FILE
-	ima_check
+	ima_check $TEST_FILE
 }
 
 test3()
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 9c25d634d..af7f3a5f5 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -279,6 +279,34 @@ get_algorithm_digest()
 	echo "$algorithm|$digest"
 }
 
+ima_check()
+{
+	local test_file="$1"
+	local algorithm digest expected_digest line tmp
+
+	# need to read file to get updated $ASCII_MEASUREMENTS
+	cat $test_file > /dev/null
+
+	line="$(grep $test_file $ASCII_MEASUREMENTS | tail -1)"
+
+	if tmp=$(get_algorithm_digest "$line"); then
+		algorithm=$(echo "$tmp" | cut -d'|' -f1)
+		digest=$(echo "$tmp" | cut -d'|' -f2)
+	else
+		tst_res TBROK "failed to get algorithm/digest for '$test_file': $tmp"
+	fi
+
+	tst_res TINFO "computing digest for $algorithm algorithm"
+	expected_digest="$(compute_digest $algorithm $test_file)" || \
+		tst_brk TCONF "cannot compute digest for $algorithm algorithm"
+
+	if [ "$digest" = "$expected_digest" ]; then
+		tst_res TPASS "correct digest found"
+	else
+		tst_res TFAIL "digest not found"
+	fi
+}
+
 # check_evmctl REQUIRED_TPM_VERSION
 # return: 0: evmctl is new enough, 1: version older than required (or version < v0.9)
 check_evmctl()
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
