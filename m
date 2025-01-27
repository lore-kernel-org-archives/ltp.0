Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A481C0218A
	for <ltp@archiver.kernel.org>; Mon, 27 Jan 2025 14:08:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B95083C0558
	for <ltp@archiver.kernel.org>; Mon, 27 Jan 2025 15:08:46 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD27D3C0558
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 15:08:28 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 552791BD353B
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 15:08:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F1ADF1F392
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 14:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737986908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=niSJq3ZUc5eRi3dBFEQ2KuMUkKy4JKWNS28sr9KQTUo=;
 b=f1B7j6ciBySi6Y2g/ty4cHjyfM1BUaZ1++lzTkqlGDKX/3zIfKv+vlsRUTn7qlyETGpxFq
 XzA8/s66aPOOLcDaLu5NQDJIsNaN7/muZMjwsWZM/qbC75SORmJ+fNknqjhiVtN8CprnSx
 dv3KL5I+uxzY2B5AvT8OxExXE+vJ49k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737986908;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=niSJq3ZUc5eRi3dBFEQ2KuMUkKy4JKWNS28sr9KQTUo=;
 b=4fm28L+k9kpyzujpXW9VT93ZTpQCzQBoTQdLpvA39WfgQgXFCtVdgbLTuwZJvFp6wtzAzI
 KdIrdpwPSyssNUCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=b0Nlpdvm;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2gqpWJxv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737986907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=niSJq3ZUc5eRi3dBFEQ2KuMUkKy4JKWNS28sr9KQTUo=;
 b=b0Nlpdvmss8qX/lgb4c7VfqqdXN1097Mm2BXWBfWNJnHCGcLuQLzt99LPoV0lnQdE9SpRV
 jRI66D5/NjkfeJtm3Te2hiEcbaOLMijFhKAJfg/f7jx7vLpXVmOSnqQdUYp8av7RBVRLCs
 AN2QjMCWKCWt3xhOVvQPLNbKoco6nOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737986907;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=niSJq3ZUc5eRi3dBFEQ2KuMUkKy4JKWNS28sr9KQTUo=;
 b=2gqpWJxv7AlPufWulVvMh2p7Y++x22vTAFHiacu15c1dTLff7nVgLUxi90vTyH0OApIpMV
 SLsDH8V0Cz/bTUAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDC88137DB
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 14:08:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GFVdMFuTl2dfZQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 14:08:27 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 27 Jan 2025 15:08:23 +0100
MIME-Version: 1.0
Message-Id: <20250127-xattrat-v1-5-c3ee31e2543b@suse.com>
References: <20250127-xattrat-v1-0-c3ee31e2543b@suse.com>
In-Reply-To: <20250127-xattrat-v1-0-c3ee31e2543b@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737986906; l=2098;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=26GGfSH4sjhq1XApOLJsKHDmb10Ivm1A51B9dGvRoR8=;
 b=At/IxD24Ttj9fjy/PTbTWwcGD1w05ta3J6vQraMyglHiejrJNhgLF3ff3imEEp2WxI2uA0xpn
 1LRzIMOJrXsBRH4zevHTNYd1/15d9YdCXmOj7mV/E74flNEgBPlCbPW
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: F1ADF1F392
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/8] setxattr03: add setxattrat variant
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/setxattr/setxattr03.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/setxattr/setxattr03.c b/testcases/kernel/syscalls/setxattr/setxattr03.c
index 52cec078877580ab17385dfaaad77ec0ed7ec563..92f12c31c7858fade8fd535923bde7c887484b7c 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr03.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr03.c
@@ -32,6 +32,8 @@
 #include "lapi/fs.h"
 
 #include "tst_test.h"
+#include "lapi/syscalls.h"
+#include "lapi/xattr.h"
 
 #if defined HAVE_SYS_XATTR_H
 #define XATTR_TEST_KEY "user.testkey"
@@ -78,11 +80,24 @@ static struct test_case tc[] = {
 
 static int immu_fd;
 static int append_fd;
+static int tmpdir_fd = -1;
 
 static void verify_setxattr(unsigned int i)
 {
-	TEST(setxattr(tc[i].fname, tc[i].key, tc[i].value, tc[i].size,
-			tc[i].flags));
+	if (tst_variant) {
+		struct xattr_args args = {
+			.value = tc[i].value,
+			.size = tc[i].size,
+			.flags = tc[i].flags,
+		};
+
+		TEST(tst_syscall(__NR_setxattrat,
+			tmpdir_fd, tc[i].fname, AT_SYMLINK_NOFOLLOW,
+			tc[i].key, &args, sizeof(args)));
+	} else {
+		TEST(setxattr(tc[i].fname, tc[i].key, tc[i].value, tc[i].size,
+				tc[i].flags));
+	}
 
 	if (!TST_RET) {
 		tst_res(TFAIL, "%s succeeded unexpectedly", tc[i].desc);
@@ -145,10 +160,15 @@ static void setup(void)
 	if (set_append_on(append_fd))
 		tst_brk(TBROK | TERRNO, "Set %s append-only failed",
 			APPEND_FILE);
+
+	tmpdir_fd = SAFE_OPEN(tst_tmpdir_path(), O_DIRECTORY);
 }
 
 static void cleanup(void)
 {
+	if (tmpdir_fd != -1)
+		SAFE_CLOSE(tmpdir_fd);
+
 	if ((immu_fd > 0) && set_immutable_off(immu_fd))
 		tst_res(TWARN | TERRNO, "Unset %s immutable failed",
 			 IMMU_FILE);
@@ -169,6 +189,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test = verify_setxattr,
 	.tcnt = ARRAY_SIZE(tc),
+	.test_variants = 2,
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 };

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
