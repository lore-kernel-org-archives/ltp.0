Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCAFE7717F
	for <ltp@archiver.kernel.org>; Fri, 13 Dec 2024 22:21:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 147C13EB887
	for <ltp@archiver.kernel.org>; Fri, 13 Dec 2024 23:21:48 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E5203E9757
 for <ltp@lists.linux.it>; Fri, 13 Dec 2024 23:20:21 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8CAA8141098A
 for <ltp@lists.linux.it>; Fri, 13 Dec 2024 23:20:20 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 931722117F;
 Fri, 13 Dec 2024 22:20:18 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FCED13AD7;
 Fri, 13 Dec 2024 22:20:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4N1EFiKzXGf5QQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 13 Dec 2024 22:20:18 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 13 Dec 2024 23:20:11 +0100
Message-ID: <20241213222014.1580991-6-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213222014.1580991-1-pvorel@suse.cz>
References: <20241213222014.1580991-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: 931722117F
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 5/8] ima_kexec.sh: Move checking policy if readable
 to ima_setup.sh
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

It will be reused.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/security/integrity/ima/tests/ima_kexec.sh   |  8 ++------
 .../kernel/security/integrity/ima/tests/ima_setup.sh   | 10 ++++++++++
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
index 3446bc24bf..df8658655d 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
@@ -47,10 +47,7 @@ setup()
 		tst_brk TCONF "kernel image not found, specify path in \$IMA_KEXEC_IMAGE"
 	fi
 
-	if check_policy_readable; then
-		require_ima_policy_content "$REQUIRED_POLICY"
-		policy_readable=1
-	fi
+	require_ima_policy_content_if_readable "$REQUIRED_POLICY"
 }
 
 kexec_failure_hint()
@@ -97,8 +94,7 @@ kexec_test()
 
 	ROD kexec -su
 	if ! measure "$cmdline"; then
-		if [ "$policy_readable" != 1 ]; then
-			tst_res TWARN "policy not readable, it might not contain required policy '$REQUIRED_POLICY'"
+		if ! check_policy_readable; then
 			res=TBROK
 		fi
 		tst_brk $res "unable to find a correct measurement"
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index e958dd3334..9a05a31c31 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -101,6 +101,16 @@ check_ima_policy_content()
 	fi
 }
 
+require_ima_policy_content_if_readable()
+{
+	local pattern="$1"
+	local grep_params="${2--q}"
+
+	if ! check_ima_policy_content "$pattern" "$grep_params"; then
+		tst_brk TCONF "IMA policy does not specify '$pattern'"
+	fi
+}
+
 require_ima_policy_content()
 {
 	local pattern="$1"
-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
