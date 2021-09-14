Return-Path: <SRS0=690a=OE=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE5DC433F5
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 08:14:21 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E4FB604AC
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 08:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7E4FB604AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 87D303C9246
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 10:14:17 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C54EF3C05AE
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 10:14:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 379A81401202
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 10:14:07 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2B1B6220C9;
 Tue, 14 Sep 2021 08:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631607247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=s02qYm3z0BXjWGUwIU+Yocyx+My8FD9pMGl8OTpkgzA=;
 b=wirHJzJGUztGHUKZKqlgqQBCiVclUVmdqrHkvulrSnt+dUy5pvNG5nSfmrISzgvkEDOTZY
 hxzooW+qg+js5PSoG1ZHJ0vnCJCbl81S2rDlm6SBjU8UJXHPkrdp3S9knb033Ota6cjqkN
 NubQOQktBd0DswDiPY1K0k8lp5gfGlo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631607247;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=s02qYm3z0BXjWGUwIU+Yocyx+My8FD9pMGl8OTpkgzA=;
 b=ngcnSnun36wtqHgBgzvQpI27pMlJloTGg8rSQF2ZslKYy6BR0QxRr5hoGOv8bUTClOoGSU
 s30AXBMlKfsQqtDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F09A313E55;
 Tue, 14 Sep 2021 08:14:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id DnA4OM5ZQGGUGwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 14 Sep 2021 08:14:06 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 14 Sep 2021 10:14:02 +0200
Message-ID: <20210914081402.5931-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] ima_tpm.sh: Check TCONF in ima_boot_aggregate
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
Message-ID: <20210914081402.-TNarYgBW_nJSykKirsEkkjm4zIjbTZUWvp4Pso0mbg@z>

This fixes false positive when compiling LTP without openssl headers on
system with TPM 1.2 without evmctl (or old version):

ima_tpm 1 TINFO: verify boot aggregate
ima_tpm 1 TINFO: using command: ima_boot_aggregate -f /sys/kernel/security/tpm0/binary_bios_measurements
tst_test.c:881: TCONF: libcrypto and openssl development packages required
ima_tpm 1 TFAIL: failed to get boot aggregate

For fixing we need to run TCONF in shell, because TCONF from C is not
propagated to shell:
tst_test.c:948: TCONF: libcrypto and openssl development packages required
ima_tpm 1 TCONF: ima_boot_aggregate -f /sys/kernel/security/tpm0/binary_bios_measurements returned TCONF

Fixes: 0f86f185a ("ima_tpm.sh: Fix calculating boot aggregate")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/security/integrity/ima/tests/ima_tpm.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
index 71083efd8..59df20cc1 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
@@ -208,7 +208,15 @@ test1_hw_tpm()
 			return
 		fi
 		tst_check_cmds ima_boot_aggregate || return
+
 		cmd="ima_boot_aggregate -f $tpm_bios"
+
+		# TCONF: libcrypto and openssl development packages required
+		$cmd
+		if [ $? -eq 32 ]; then
+			tst_res TCONF "$cmd returned TCONF"
+			return
+		fi
 	fi
 	tst_res TINFO "using command: $cmd"
 
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
