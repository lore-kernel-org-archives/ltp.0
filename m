Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD186C83F17
	for <ltp@archiver.kernel.org>; Mon, 21 Jul 2025 02:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753064811; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=UecUw0OIe95nvoTfwqoA1GESa7d54vt5FcbNX1vI29w=;
 b=mhJuh90s9gs3EtRq/8b0EaBBewklAbAi0XSEOlQ+SzvzonR/ckFbo/d/1H2GvoTFlJ7hP
 BoNRTYEjnyXcbX3h7v7W0u98/eN5PeHiGiwnTHkbrhUGxqbEOc/JnX7EaWJI5aO0jMQzOZL
 UGEkcVCfy3QeLt5pODUvHP3/XWY3zAM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5CCD63CCB0E
	for <ltp@archiver.kernel.org>; Mon, 21 Jul 2025 04:26:51 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 723CA3CC5C0
 for <ltp@lists.linux.it>; Mon, 21 Jul 2025 04:26:29 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 73C942002C8
 for <ltp@lists.linux.it>; Mon, 21 Jul 2025 04:26:28 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a50956e5d3so2917132f8f.1
 for <ltp@lists.linux.it>; Sun, 20 Jul 2025 19:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753064788; x=1753669588; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TJZqcW8a8r4K53GNw8Xe8eykfM7Hn3e7jcr/eui/lw8=;
 b=fBbxAubboANmM7Qe4N4GnD6cL+5u3wXvsTs+5IjLtfUfE3DMN1w6qt2MwdJofBag7j
 GdCPZLUoAJSEaZm1u9lUNhorn8hvPTDsthpRC5wRquLV1+t7HCU/AdTIho00kqQZfgO0
 6oWJ86c2iCKrNJXYMr41RjWM1pbczpsPMMTJ2NP/ClRFHeKut+2jiN6Ew0MS9FUvrlx+
 kJFfwIav+xginfGFNiw3q/i+C2hPnOIPBxXXpM4s0dAAXviCf7auh2I3tPhTTOcdIPJ9
 3AGCigvdRc3+vk+cyNVMiVDAE57uSA6CCPKeqvf7JZrT7xuh+dzH7mkmYr14/X6oXI2Q
 HEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753064788; x=1753669588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TJZqcW8a8r4K53GNw8Xe8eykfM7Hn3e7jcr/eui/lw8=;
 b=KrYen5rcDPzE4r1ClxFtWJCRAHCcaS7TLDuNpGq0ztx2MhsAtinCbbUdXQC50tqckj
 BgyIfPyVfgNi+3aUb7YaEdXScBeiY8GlbSHAkwXt2xqM1eMTAzLHWjNyRdrFY0kyHDaP
 /nsDlJFgLSQtS2OYt/Cv+ep4gmXlpYllRj2w+rHzj9w93ERF/EL5/SPNtV5QIHnt8p01
 UGjufQo09syysO6NZFdRT7+w9IK580YxLRTjPxtrM4CnX6yjccWPS4e4qamkEHVQH8bJ
 e6TK9FBBCQ3HFCIkyV7/icx4crijAaiokzX0+ABEtebfef9D8DmfAe7EIUMb9DohwATe
 xmzA==
X-Gm-Message-State: AOJu0Yz7YubwjgKNsJY+FCtwCOupAKyhQZ1LLR5QZkQBPKsqBiABR2dv
 cOSYEGQ7lCE4yW1Wu0R2A/1ycaaQs7nwpUIlo1t9FW68Wy0bWuGvjQgHBlQ6nZerPRahRiC9P+S
 9zCs=
X-Gm-Gg: ASbGnctku+rWhrmFfVZ6kf6SF6EUjMq8Y/4SNKznZs22wF6UkdmZgTJe12Aka2JmilI
 KXv2u6eOa7pIyQ+qDqjs+BfVZi0wlop1B7I1IZpTRqq9x9JxGh6oPG4w2AEgSfO9pi+xhekLRCe
 O4mDmbmisxLPWBkY68IlNIz9EobNfoU4oNgXu9d/3eujRAU7VYGw+kEgLoWDF0PycP7pB0bNhB5
 62/ZvKNmrpNGm9qVeUH38OhbOOxBip9sFlQoSeI7GbdkXxCi9CCCc17IJjH/42ZlGNFFwSJJKap
 nb0PKR94VX+J/Uuh5BW+nVYjExIA3fX8k4v3hVME3y7SpF6uko4JPxaA8y87g9KpTOsMHZx7is6
 7gbM18Jr1mWk=
X-Google-Smtp-Source: AGHT+IG25IjARmOo0z9riT7lUYvwcVpcqExfsSQ9/krVtGCslyjRCW2Sj+iV8IayGGQAkNP3gJg5UQ==
X-Received: by 2002:a5d:5d85:0:b0:3a6:ec41:b9df with SMTP id
 ffacd0b85a97d-3b60dd82984mr14118541f8f.49.1753064787679; 
 Sun, 20 Jul 2025 19:26:27 -0700 (PDT)
Received: from localhost ([202.127.77.110])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-31cc3f161f8sm5078129a91.26.2025.07.20.19.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Jul 2025 19:26:27 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 21 Jul 2025 10:25:23 -0400
Message-ID: <20250721142531.2223584-1-wegao@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250716120600.2855395-1-wegao@suse.com>
References: <20250716120600.2855395-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] splice10.c: New splice tests involving memfd secret
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Linux commit cbe4134ea4bc ("fs: export anon_inode_make_secure_inode() and fix
secretmem LSM bypass") prevents any access to secret memory pages from other
kernel subsystems.

Splice operations involving memfd secret are checked within this case.

Discussed-on: https://lists.linux.it/pipermail/ltp/2025-July/044351.html
Reference: cbe4134ea4bc ("fs: export anon_inode_make_secure_inode() and fix secretmem LSM bypass")
Signed-off-by: Wei Gao <wegao@suse.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/splice/.gitignore |  1 +
 testcases/kernel/syscalls/splice/splice10.c | 72 +++++++++++++++++++++
 3 files changed, 74 insertions(+)
 create mode 100644 testcases/kernel/syscalls/splice/splice10.c

diff --git a/runtest/syscalls b/runtest/syscalls
index b4a387b28..d6da59bd2 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1585,6 +1585,7 @@ splice06 splice06
 splice07 splice07
 splice08 splice08
 splice09 splice09
+splice10 splice10
 
 tee01 tee01
 tee02 tee02
diff --git a/testcases/kernel/syscalls/splice/.gitignore b/testcases/kernel/syscalls/splice/.gitignore
index 96b1727a1..5e98981fe 100644
--- a/testcases/kernel/syscalls/splice/.gitignore
+++ b/testcases/kernel/syscalls/splice/.gitignore
@@ -7,3 +7,4 @@
 /splice07
 /splice08
 /splice09
+/splice10
diff --git a/testcases/kernel/syscalls/splice/splice10.c b/testcases/kernel/syscalls/splice/splice10.c
new file mode 100644
index 000000000..871899b3f
--- /dev/null
+++ b/testcases/kernel/syscalls/splice/splice10.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * Test if splice syscall prevents any access to secret memory pages from
+ * other kernel subsystems.
+ *
+ * Reference kernel commit:
+ * commit cbe4134ea4bc493239786220bd69cb8a13493190
+ * Author: Shivank Garg <shivankg@amd.com>
+ * Date:   Fri Jun 20 07:03:30 2025 +0000
+ *
+ *    fs: export anon_inode_make_secure_inode() and fix secretmem LSM bypass
+ */
+
+#define _GNU_SOURCE
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+
+static char *buf;
+static int fd = -1;
+static int pipefd[2] = {-1, -1};
+
+static void verify_splice(void)
+{
+	SAFE_WRITE(1, pipefd[1], buf, sizeof(buf));
+
+	TST_EXP_FAIL(splice(pipefd[0], NULL, fd, NULL, sizeof(buf), 0), EACCES);
+	TST_EXP_FAIL(splice(fd, NULL, pipefd[1], NULL, sizeof(buf), 0), EACCES);
+}
+
+static void setup(void)
+{
+	if (!tst_selinux_enforcing())
+		tst_brk(TCONF, "SELinux not running");
+
+	fd = syscall(__NR_memfd_secret, 0);
+	if (fd < 0) {
+		tst_brk(TCONF | TERRNO,
+			"Skipping __NR_memfd_secret check");
+	}
+
+	SAFE_PIPE(pipefd);
+}
+
+static void cleanup(void)
+{
+	for (int i = 0; i < 2; i++) {
+		if (pipefd[i] >= 0)
+			SAFE_CLOSE(pipefd[i]);
+	}
+
+	if (fd >= 0)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_splice,
+	.min_kver = "6.16",
+	.bufs = (struct tst_buffers []) {
+		{&buf, .size = 1024},
+		{}
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "cbe4134ea4b"},
+		{}
+	}
+};
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
