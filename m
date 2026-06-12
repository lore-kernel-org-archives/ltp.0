Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BBBCD98CE
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 09:58:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E503D3E5290
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 11:58:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A79913C0848
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 11:58:39 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5217D60096F
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 11:58:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 940E075DEF;
 Fri, 12 Jun 2026 09:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781258317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mF2lLysFNINUwjT6bNmvO6D0Xsw6K6lAvvDmmRF5keI=;
 b=Yh2bbbjh69M5j8CcTCE+QorViXaLdfDDCRFjo7mCbDVYnKcwzwu92zN+GUR/9FzL6ZQVk9
 sYu1CwTFEZPRvuOlLSXV2gSCKYUtrm0hsy+6LLn4eqZY/w/6wBUCI9QP3yCow2WiaVwFeX
 BWOIt2xmgWG2H4tawCnQCQA0YI70Qjo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781258317;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mF2lLysFNINUwjT6bNmvO6D0Xsw6K6lAvvDmmRF5keI=;
 b=P9MuWVoExaDcOqircqRuBvr7HBQgO35cPWR6I/qoaGOdEpUVaDElbdkqa6Cvv1CYujPymA
 viS0E+5K73H/8JBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781258317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mF2lLysFNINUwjT6bNmvO6D0Xsw6K6lAvvDmmRF5keI=;
 b=Yh2bbbjh69M5j8CcTCE+QorViXaLdfDDCRFjo7mCbDVYnKcwzwu92zN+GUR/9FzL6ZQVk9
 sYu1CwTFEZPRvuOlLSXV2gSCKYUtrm0hsy+6LLn4eqZY/w/6wBUCI9QP3yCow2WiaVwFeX
 BWOIt2xmgWG2H4tawCnQCQA0YI70Qjo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781258317;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mF2lLysFNINUwjT6bNmvO6D0Xsw6K6lAvvDmmRF5keI=;
 b=P9MuWVoExaDcOqircqRuBvr7HBQgO35cPWR6I/qoaGOdEpUVaDElbdkqa6Cvv1CYujPymA
 viS0E+5K73H/8JBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A221779A7;
 Fri, 12 Jun 2026 09:58:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id asNdGE3YK2qRHQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 12 Jun 2026 09:58:37 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 12 Jun 2026 11:58:26 +0200
MIME-Version: 1.0
Message-Id: <20260612-fix_clone11_min_kver-v2-1-90cfb4b687fb@suse.com>
X-B4-Tracking: v=1; b=H4sIAEHYK2oC/4WNUQrCMBBEr1L220g3hkr98h5SShO3dtEmJatBK
 bm7sRfw8w0zb1YQikwCp2qFSImFgy+gdxW4afA3UnwtDLrWTd0gqpHfvXsET4j9zL6/J4rq0Bo
 3mrZ12h2hTJdIpbdpL13hieUZ4md7SfhL/wgTKlS6MaMdtK3RmrO8hPYuzNDlnL8km5nVtwAAA
 A==
X-Change-ID: 20260611-fix_clone11_min_kver-394cf499c2c7
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781258317; l=2342;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=nwXOKaz/rmZvZtMOpF1k+C/DPqBhLIiZINyZiH0zOUo=;
 b=Dx3cFWtYSa1240VeujTb29jIiOPPpS9OokJimgjv7LAJVp8ITKAQggqcdwozm2KWLuYm2ShS6
 vhzkMZJ4u9RCJvsOKRPLsVtsNih/edNUUIZMlUTJ/Kvl8Y65tLhoCYx
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] clone11: skip CLONE_NEWCGROUP on kernels < 4.6
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

CLONE_NEWCGROUP was added in kernel v4.6. On older kernels such as
v4.4, the flag is unknown and clone() returns EINVAL instead of the
expected EPERM, causing a spurious test failure.

Add a per-test-case minimum kernel version check so that the
CLONE_NEWCGROUP case reports TCONF on kernels older than 4.6.

Reviewed-by: Avinesh Kumar <avinesh.kumar@suse.com>
Reviewed-by: Wei Gao <wegao@suse.com>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v2:
- follow madvise02 pattern to recognize if test needs to be skipped
- Link to v1: https://lore.kernel.org/r/20260611-fix_clone11_min_kver-v1-1-264fba2b01b4@suse.com
---
 testcases/kernel/syscalls/clone/clone11.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/testcases/kernel/syscalls/clone/clone11.c b/testcases/kernel/syscalls/clone/clone11.c
index 028da778158de6867a71ac3974f9c2263481d3a3..98b36c8ec2ea51d9333fcd899cb1908e2839d851 100644
--- a/testcases/kernel/syscalls/clone/clone11.c
+++ b/testcases/kernel/syscalls/clone/clone11.c
@@ -21,6 +21,7 @@ static int *child_pid;
 static struct tcase {
 	uint64_t flags;
 	const char *sflags;
+	int skip;
 } tcases[] = {
 	{ DESC(CLONE_NEWPID) },
 	{ DESC(CLONE_NEWCGROUP) },
@@ -36,10 +37,33 @@ static int child_fn(void *arg LTP_ATTRIBUTE_UNUSED)
 	_exit(0);
 }
 
+static void tcases_filter(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(tcases); i++) {
+		struct tcase *tc = &tcases[i];
+
+		switch (tc->flags) {
+		case CLONE_NEWCGROUP:
+			if (tst_kvercmp(4, 6, 0) < 0)
+				tc->skip = 1;
+			break;
+		default:
+			break;
+		}
+	}
+}
+
 static void run(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
 
+	if (tc->skip) {
+		tst_res(TCONF, "%s is not supported", tc->sflags);
+		return;
+	}
+
 	TST_EXP_FAIL(ltp_clone(tc->flags, child_fn, NULL, CHILD_STACK_SIZE, child_stack),
 		EPERM, "clone(%s) should fail with EPERM",
 		tc->sflags);
@@ -51,6 +75,8 @@ static void setup(void)
 			PROT_READ | PROT_WRITE,
 			MAP_SHARED | MAP_ANONYMOUS,
 			-1, 0);
+
+	tcases_filter();
 }
 
 static void cleanup(void)

---
base-commit: a3fda1dc1ce7da882a592a4877da7f214e468650
change-id: 20260611-fix_clone11_min_kver-394cf499c2c7

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
