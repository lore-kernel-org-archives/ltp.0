Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78994C3DA49
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 08:24:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 152A23D1F1E
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 10:24:47 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3FB9B3D1C9C
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 10:23:59 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5DF8C204B56
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 10:23:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 585BC1FB9F;
 Fri,  2 Aug 2024 08:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722587038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zxWZFOjbCyUuRtM5H3v5kv50BX36Tm/VO7gZJXz9OlE=;
 b=ilJ5fokd4ebJxH+8P+g83U74EOUqcghwZAlYtXhRjN03OjCKRSwCOF1ZGSTwkXh99fEoUW
 W5yqqh9wUfI/V3WjKm4dN17LRl+FFA0SNmpbpxK3cvXiGPOeWKa41U6LU5PUKCjvgeUwt6
 E3Rb35xGChMTuZifOS9zIQOBGoTD+uI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722587038;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zxWZFOjbCyUuRtM5H3v5kv50BX36Tm/VO7gZJXz9OlE=;
 b=AT37ASWtrZdxIqymyfztcewz42+v8ZHPZf4PM1m8mded4Vb7e7r2lwiDBH7RCm+DTLy+3x
 8iFe7LbSsSMGyoBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722587038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zxWZFOjbCyUuRtM5H3v5kv50BX36Tm/VO7gZJXz9OlE=;
 b=ilJ5fokd4ebJxH+8P+g83U74EOUqcghwZAlYtXhRjN03OjCKRSwCOF1ZGSTwkXh99fEoUW
 W5yqqh9wUfI/V3WjKm4dN17LRl+FFA0SNmpbpxK3cvXiGPOeWKa41U6LU5PUKCjvgeUwt6
 E3Rb35xGChMTuZifOS9zIQOBGoTD+uI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722587038;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zxWZFOjbCyUuRtM5H3v5kv50BX36Tm/VO7gZJXz9OlE=;
 b=AT37ASWtrZdxIqymyfztcewz42+v8ZHPZf4PM1m8mded4Vb7e7r2lwiDBH7RCm+DTLy+3x
 8iFe7LbSsSMGyoBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30AEC13999;
 Fri,  2 Aug 2024 08:23:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kAxBCZ6XrGaaFgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 02 Aug 2024 08:23:58 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 02 Aug 2024 10:23:50 +0200
MIME-Version: 1.0
Message-Id: <20240802-fchmodat2-v5-5-bff2ec1a4f06@suse.com>
References: <20240802-fchmodat2-v5-0-bff2ec1a4f06@suse.com>
In-Reply-To: <20240802-fchmodat2-v5-0-bff2ec1a4f06@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2700;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=wXJZ7rIxV9q31q/zWQi6OG9wH/Ihfs0JWHkpJvovaAg=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmrJebQq3XKbcDJ1qpuFAjPJoA7EYd/F9r95iA7
 hjFayrwE2KJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZqyXmwAKCRDLzBqyILPm
 RsQUDACIos3bK2ZOdOofoit+4uHMdTsFXQ870x3CSGO8BpLBV5+3QQ7bkQx4LAMM2zawkPF2VXF
 qP3GWvZ3cWcxA9Y0nx5BpJS7ejgGQxKzJVUvuFIwKRGFaAn1SbB++kD3PKtM/42luLVXKNrAhHW
 9iUKVlXSpieylXK6fiwjuWS19pS+oJMxdg66DlLT3PcxZbmawsYKRg2Hu9RvO371lr8w5xHZ3+Y
 vvN/C41A/9GbpCZupFyHZRrbsPYAXHxL/S5T40uVPkfAoCZ87XjYM0umirMTH4xe7gS8muTnmK2
 fPhUOk9V7GPYk9hGgW9/kHZuUQTwR/Vb3PirJNSi009onaIXEwEP2pzsbRlsDFurdQgYOlUAOLY
 g2cABhDWn2QM0mFCHlc+vbGLBE+Uah7Wl6Hs1GlK04oaEWkGDTUQypSbM+nvSAyhPmAJ+jSqWry
 e9iyFbI4LraUF9IdopaFFXooeopH1+G1d+Mb1lT74B8Dm6bzWA2JIhW2Gmldxlq6eRr38=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.10 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 5/5] Add fchmodat2_02 test
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

This test verifies that fchmodat2() syscall properly raises errors with
invalid arguments.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                   |  1 +
 testcases/kernel/syscalls/fchmodat2/.gitignore     |  1 +
 testcases/kernel/syscalls/fchmodat2/fchmodat2_02.c | 68 ++++++++++++++++++++++
 3 files changed, 70 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 50298d01e..7292e5ae7 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -271,6 +271,7 @@ fchmodat01 fchmodat01
 fchmodat02 fchmodat02
 
 fchmodat2_01 fchmodat2_01
+fchmodat2_02 fchmodat2_02
 
 fchown01 fchown01
 fchown01_16 fchown01_16
diff --git a/testcases/kernel/syscalls/fchmodat2/.gitignore b/testcases/kernel/syscalls/fchmodat2/.gitignore
index 47d5e2427..9f713198c 100644
--- a/testcases/kernel/syscalls/fchmodat2/.gitignore
+++ b/testcases/kernel/syscalls/fchmodat2/.gitignore
@@ -1 +1,2 @@
 fchmodat2_01
+fchmodat2_02
diff --git a/testcases/kernel/syscalls/fchmodat2/fchmodat2_02.c b/testcases/kernel/syscalls/fchmodat2/fchmodat2_02.c
new file mode 100644
index 000000000..f8497d8a8
--- /dev/null
+++ b/testcases/kernel/syscalls/fchmodat2/fchmodat2_02.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that fchmodat2() syscall properly raises errors with
+ * invalid values.
+ */
+
+#include "tst_test.h"
+#include "lapi/fcntl.h"
+#include "lapi/syscalls.h"
+#include "tst_tmpdir.h"
+
+#define FILENAME "file.bin"
+
+static char *tmpdir;
+static int fd;
+static int fd_invalid = -1;
+
+static struct tcase {
+	int *fd;
+	char *fname;
+	int mode;
+	int flag;
+	int exp_errno;
+	char *msg;
+} tcases[] = {
+	{&fd_invalid, FILENAME, 0777, 0, EBADF, "bad file descriptor"},
+	{&fd, "doesnt_exist.txt", 0777, 0, ENOENT, "unexisting file"},
+	{&fd, FILENAME, 0777, -1, EINVAL, "invalid flags"},
+};
+
+static void run(unsigned int i)
+{
+	struct tcase *tc = &tcases[i];
+
+	TST_EXP_FAIL(tst_syscall(__NR_fchmodat2,
+		*tc->fd, tc->fname, tc->mode, tc->flag),
+		tc->exp_errno,
+		"Test %s", tc->msg);
+}
+
+static void setup(void)
+{
+	tmpdir = tst_tmpdir_path();
+
+	SAFE_TOUCH(FILENAME, 0640, NULL);
+	fd = SAFE_OPEN(tmpdir, O_PATH | O_DIRECTORY, 0640);
+}
+
+static void cleanup(void)
+{
+	if (fd != -1)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+};
+

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
