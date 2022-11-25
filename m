Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E7CC4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 15:35:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E4A43CC8FD
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 16:35:16 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A6ECA3CC8ED
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 16:34:55 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DA3A9600F11
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 16:34:54 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BFBB121B01
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 15:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669390493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3JQ5JAbz/kUYifZo7WDKx+/yPWUvowj85HoUXf1qczc=;
 b=Ng0OAtapRXuOjmbdAQ1x7S98/PB6GLxtvpe8T8g2/YvbVIXAHhbd4WqQkLOvnzmBa4Femi
 jnixvmv66oIAplCtm54itP9DAvtmMniJ33z5n32fgm14K3vDoYqD655w/JGtdTnAyBShv/
 Q6fguXa//W9NNJd7ljB0Qa4Op8h3YIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669390493;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3JQ5JAbz/kUYifZo7WDKx+/yPWUvowj85HoUXf1qczc=;
 b=Lji8YE0mgnQBsM1zP1yKyuj2pRQzTm6NnKuaSJ40u7xI3R/uI2qrJq5RfzGGDHoT4FptZ2
 y1offI6CGkCJ/DDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF06013A08
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 15:34:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8vXXKZ3ggGNUDgAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 15:34:53 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 25 Nov 2022 16:34:52 +0100
Message-Id: <20221125153453.19323-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] Implement tst_setup_netns() helper function
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

Namespace setup boilerplate for network tests is getting more complicated
with the need to check or modify some sysfiles. Move it into LTP library.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Here is the promised .save_restore follow-up patchset which fixes network
namespace setup without root privileges. Since the exact same boilerplate
code is repeated in multiple tests, I've decided to introduce a helper
function to simplify test setup.

 include/tst_net.h | 16 ++++++++++++++++
 lib/tst_net.c     | 23 +++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/tst_net.h b/include/tst_net.h
index daefdd9d9..9d8b842dd 100644
--- a/include/tst_net.h
+++ b/include/tst_net.h
@@ -32,4 +32,20 @@ void safe_getaddrinfo(const char *file, const int lineno, const char *src_addr,
 					  const char *port, const struct addrinfo *hints,
 					  struct addrinfo **addr_info);
 
+/*
+ * Create new network namespace for netdevice/socket tests. A test which calls
+ * tst_setup_netns() must declare the following entries in its struct tst_test:
+ *
+ * .needs_kconfigs = (const char *[]) {
+ *	"CONFIG_USER_NS=y",
+ *	"CONFIG_NET_NS=y",
+ *	NULL
+ * },
+ * .save_restore = (const struct tst_path_val[]) {
+ *	{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
+ *	{}
+ * },
+ */
+void tst_setup_netns(void);
+
 #endif /* TST_NET_H_ */
diff --git a/lib/tst_net.c b/lib/tst_net.c
index de343bb39..61fc0ea76 100644
--- a/lib/tst_net.c
+++ b/lib/tst_net.c
@@ -8,11 +8,13 @@
 #include <netdb.h>
 #include <string.h>
 #include <stdlib.h>
+#include <unistd.h>
 
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
 #include "tst_net.h"
 #include "tst_private.h"
+#include "lapi/namespaces_constants.h"
 
 void tst_print_svar(const char *name, const char *val)
 {
@@ -220,3 +222,24 @@ void safe_getaddrinfo(const char *file, const int lineno, const char *src_addr,
 	if (!*addr_info)
 		tst_brk_(file, lineno, TBROK, "failed to get the address");
 }
+
+void tst_setup_netns(void)
+{
+	int real_uid = getuid();
+	int real_gid = getgid();
+	int nscount = 1;
+
+	if (!access("/proc/sys/user/max_user_namespaces", F_OK)) {
+		SAFE_FILE_SCANF("/proc/sys/user/max_user_namespaces", "%d",
+			&nscount);
+	}
+
+	if (!nscount)
+		tst_brk(TCONF, "User namespaces are disabled");
+
+	SAFE_UNSHARE(CLONE_NEWUSER);
+	SAFE_UNSHARE(CLONE_NEWNET);
+	SAFE_FILE_PRINTF("/proc/self/setgroups", "deny");
+	SAFE_FILE_PRINTF("/proc/self/uid_map", "0 %d 1", real_uid);
+	SAFE_FILE_PRINTF("/proc/self/gid_map", "0 %d 1", real_gid);
+}
-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
