Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2AEAC02183
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 12:25:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2891D3C7C2B
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 13:25:24 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7BA773C088F
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 13:25:05 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8A62F1022FAF
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 13:25:05 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9AF531F37C
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 12:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737116704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=EzyqG31Vohs3kCiewdHMq8Z7PxChqmVhZrqycX3k0WE=;
 b=D912YuyqfSKZ5YRb4Yb+zCll5gIbVRQ3bEPuG/ZNnTwiaM/yT0vJBUdPecq5x6X5NRSrll
 SDUWrrybA2PIzGTP0C+GLd9CviEzZHEZctUBXVc771KclfJBo3giIIXrzR5X22GXMblVW2
 59S06h8YtfI2rkjO+UQtMmuelSC1ZXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737116704;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=EzyqG31Vohs3kCiewdHMq8Z7PxChqmVhZrqycX3k0WE=;
 b=ObU5BMlRkwWJrXDSIzV1N5mYxeR7tcn6LNQNLe+SHhJUtReO+nEofjjNijk9Dbm2SOcPcL
 WkdHI1kj6JImdRDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=J4tdbVia;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WlI3Xcni
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737116703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=EzyqG31Vohs3kCiewdHMq8Z7PxChqmVhZrqycX3k0WE=;
 b=J4tdbViaCpEHs09hgsG71aFy6/nWbbd+3LSZ1fKARFtrYCCckDUXm5ckUOfUNrqRyPCmEL
 Zyb+oO/vbxybofDBFEWI0ghIojBh4z7f7VPf7fwy3g+lIxN2F5PHGI6MRJc8HeyZgAdKUF
 TErBzEREnsxX4TCmKzGqmt78URtQGhM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737116703;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=EzyqG31Vohs3kCiewdHMq8Z7PxChqmVhZrqycX3k0WE=;
 b=WlI3XcninApNzWAAeRohDL5bfzSwXFL6TNqBXlvcIfuwAo+6Ow+VRs1drCejGYDwksYt6M
 VmI9Ok2P5YiyTsAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A6C5139CB
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 12:25:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id L+eqHx9MimcGSgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 12:25:03 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 17 Jan 2025 13:24:54 +0100
Message-ID: <20250117122455.7989-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: 9AF531F37C
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:email, suse.cz:dkim, suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] testcases/lib: Fix tst_ns_* helpers
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

Replaces SAFE_CLONE() with tst_clone() in the tst_ns_* helpers.

The reason for the replacement is that SAFE_CLONE() uses
TST_RETRY_FUNC() which calls tst_multiply_timeout(). The problem with
that is that the tst_multiply_timeout() is a test library function that
started to print TINFO messages recently and that we rely on parsing the
output from the tst_ns_* helpers.

The reason SAFE_CLONE() started to call TST_RETRY_FUNC() is that in the
case that we create new namespaces with the clone call, we may end up
creating them faster than kernel can clean them up which is described in:

commit 7d882081a5613f44a12fc6b1c44267d4df0857a4
Author: Petr Vorel <pvorel@suse.cz>
Date:   Mon Mar 28 22:46:43 2022 +0200

    lib: Retry safe_clone() on ENOSPC

This combined with the newly introduced changes in the test library that
check for kernel debugging options that may need to adjust default
timeouts:

commit 893ca0abe7e82851ff0e5d93c09b1098f2eff121
Author: Li Wang <liwang@redhat.com>
Date:   Sun Dec 22 15:22:49 2024 +0800

    lib: multiply the timeout if detect slow kconfigs

which adds tst_has_slow_kconfig() into the tst_multiply_timeout() causes
the TINFO messages to be printed.

The reason why we can safely replace the SAFE_CLONE() with tst_clone()
here is that we are not creating new namspaces in the tst_ns_* helpers,
but rather than that cloning a new process to be executed inside of the
namespace, hence we do not need to retry on ENOSPC.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/lib/tst_ns_create.c | 15 ++++++---------
 testcases/lib/tst_ns_exec.c   | 15 ++++++---------
 2 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/testcases/lib/tst_ns_create.c b/testcases/lib/tst_ns_create.c
index ce3707a60..bd7633b0b 100644
--- a/testcases/lib/tst_ns_create.c
+++ b/testcases/lib/tst_ns_create.c
@@ -23,12 +23,6 @@
 #include "tst_test.h"
 #include "tst_ns_common.h"
 
-extern struct tst_test *tst_test;
-
-static struct tst_test test = {
-	.forks_child = 1, /* Needed by SAFE_CLONE */
-};
-
 static void print_help(void)
 {
 	int i;
@@ -66,8 +60,6 @@ int main(int argc, char *argv[])
 		return 1;
 	}
 
-	tst_test = &test;
-
 	while ((token = strsep(&argv[1], ","))) {
 		struct param *p = get_param(token);
 
@@ -80,7 +72,12 @@ int main(int argc, char *argv[])
 		args.flags |= p->flag;
 	}
 
-	pid = SAFE_CLONE(&args);
+	pid = tst_clone(&args);
+	if (pid < 0) {
+		printf("clone() failed");
+		return 1;
+	}
+
 	if (!pid) {
 		child_fn();
 		return 0;
diff --git a/testcases/lib/tst_ns_exec.c b/testcases/lib/tst_ns_exec.c
index 6a8e39339..5d34e9ad5 100644
--- a/testcases/lib/tst_ns_exec.c
+++ b/testcases/lib/tst_ns_exec.c
@@ -20,12 +20,6 @@
 #include "tst_test.h"
 #include "tst_ns_common.h"
 
-extern struct tst_test *tst_test;
-
-static struct tst_test test = {
-	.forks_child = 1, /* Needed by SAFE_CLONE */
-};
-
 static int ns_fd[NS_TOTAL];
 static int ns_fds;
 
@@ -71,8 +65,6 @@ int main(int argc, char *argv[])
 	int i, status, pid;
 	char *token;
 
-	tst_test = &test;
-
 	if (argc < 4) {
 		print_help();
 		return 1;
@@ -100,7 +92,12 @@ int main(int argc, char *argv[])
 	for (i = 0; i < ns_fds; i++)
 		SAFE_SETNS(ns_fd[i], 0);
 
-	pid = SAFE_CLONE(&args);
+	pid = tst_clone(&args);
+	if (pid < 0) {
+		printf("clone() failed");
+		return 1;
+	}
+
 	if (!pid)
 		SAFE_EXECVP(argv[3], argv+3);
 
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
