Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E135F606A32F
	for <ltp@archiver.kernel.org>; Mon,  2 Nov 2026 02:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=aHa62Qhj;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Ip5+4nO/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1793586237; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=IAYf+mj/gg46YfJfVsORmHZCnXAsxU1Cph3v9EtxMfg=;
 b=aHa62QhjJVHafjMo+2lTcuqv6PRpN16WDQFbdDcaK9TmBesvyYtlszmbKUi2msa0lzI71
 QqfMvKF5B2dPWdsDxdOHmNR/KYtkl4/p5RIV2gLiaS76Bx/cW1TMAM/80itZ0KWTiUo/eHN
 BS3Rod1gs/QlX0r2qt1qo/xepDEbsQ4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 74AF83E5B8C
	for <ltp@archiver.kernel.org>; Mon,  2 Nov 2026 03:23:57 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7483D3E05A4
 for <ltp@lists.linux.it>; Mon,  2 Nov 2026 03:22:58 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1A5F51000655
 for <ltp@lists.linux.it>; Mon,  2 Nov 2026 03:22:58 +0100 (CET)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48df8fe8513so2069814f8f.0
 for <ltp@lists.linux.it>; Sun, 01 Nov 2026 18:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1793586177; x=1794190977; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g9Krrc+f644VJ05eUhn8xOMQhTDxaqnO7KrZdUFPxcA=;
 b=Ip5+4nO/FQyfgB9CXa2MHZxypoV6Re1Gj4sr8NfcR8Rpj9It+4AOIJFdmpZiMJvIG3
 pwJs2q1XyGXuVW6fG3KeBU/YFypqpnVKE94ktGQae8Bl4NiyU3Xh4LXNo6ZnkvZ/2rVq
 Gh2n1NrmDPZz82mD9TPgg2xE1EmzKz+z0wOm/peR7p6wKECdnoNPZzc6euDj1CTjpZyw
 tBw87tNNRQiyh9FofbzlhbPEHzVXoZTS3/JrPxeRJYYzOyVDmvMiePsHL4p9fWPg6bzQ
 FFSVcRGgqxOdpwIilcRBKA8is1iyISkMC8+9sgzer3OCfnbHt4Kglsie8XAM3pZVZRz3
 3fcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793586177; x=1794190977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=g9Krrc+f644VJ05eUhn8xOMQhTDxaqnO7KrZdUFPxcA=;
 b=JwAr0taiKpYsn5JrQ7CR6Or0i5+VSVu530X3+MMrs9s+FrbW3+fYPH6lOnRJulFEUT
 RkRoFdDkb0yirquHByjm0Y1HwZfyLo3Wdb4Jye1ZndvH2L8NdNjROfIZNfsSJZOfaKj4
 TpYM8CqPIc+5vg2a0MhAr7Y/3pJ081XdEnX9sp0N1EQZyLgRUpybS+rNoLd3SP5C4BOA
 EGhKUrmH1kfG8850JVblqe/9C3+noVnFMPYcc7wlxylc+5Od6wzII+NIluTi3CtYf6if
 91K+XZotHdCiwumszZTQzCOXm1pgI2ds2ocm+Wbt8iDFO2Ll3zM+3RVAOfjlvOwXjysv
 NFKw==
X-Gm-Message-State: APuU4Z9ZEh22eH0qSjl0eB2M2kjbsZt12hcVTcA4BpqxKtR1i/o8yWt6
 bpYKWeGPHkqE5pX6jaM661zxTXFHWV/Io8Kdw3hw+aDEpVtpDUGXSLzTn5F6/d80Pl9gV++mfos
 mk5c=
X-Gm-Gg: AYBFou2DLqSlmPmfJFWLiSiCw1G/EXPduMpCmbEuImdVq66H9gi9FXOH0AaSFbh3TBz
 +19iPlc7uyC4J/ZKcFz8QeKsJrOAxT9H/eQyX7nBHjuPMkspVvWhZ0UI6DI0BraeLC1Ydu+OiJc
 rWYOZvMDfCKJlj8gcJPA2PY3Gi07RZ31TnG2tmU48NfpOJIUerzUfTBZ22mlNhBEAkIJWvd2wCd
 pimY8Ghg3Y1CGpD3Oly8N67vgeOYDU1vqEa9dHuIum1VeysIHRaIA4DUaaalsXTTKfGnDzEpbT9
 La6lWCxJifcycuiB1FW+0GW71/Dg12w3+3I2lYnwXkHgrh357fze/Zijbkf4k8l0Tq9j5CExINF
 Q6Vl0qraLzdFj08DwipCAQiKYIzYKE91ulGvcSHAPxtXkXMvnQwVPRsLu0E3W7h9QALD/wTDXAW
 BAdaIJOlTZJbekiPFYt0l5MXsvLQ+1oZs7FFtjgJuYUKnI7NSYcGk7uvryPeJprqQHksfOEvJbX
 XbCkKKwcRQhLKBAfqc2IPVPamLjeeaJ3nrS478RTXET0sMxKGhIwzcRhM6lyUkswYN31LGrZrCQ
 dy/qRoIz07UF52WbXAsUKyHivVmDHANeePf5TULdxYuvRxQ+lnAnpj3YA5vqKl/BUuth+I2ZDA=
 =
X-Received: by 2002:a5d:5e90:0:b0:48e:d88:55e2 with SMTP id
 ffacd0b85a97d-48e6e518c08mr19974778f8f.42.1793586177536; 
 Sun, 01 Nov 2026 18:22:57 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-48e71ba2415sm17562376f8f.50.2026.11.01.18.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 18:22:57 -0800 (PST)
To: ltp@lists.linux.it
Date: Mon,  2 Nov 2026 02:22:40 +0000
Message-ID: <20261102022245.3922-3-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102022245.3922-1-wegao@suse.com>
References: <20261102022245.3922-1-wegao@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v18 2/3] newlib_tests: Add tst_attach_loopdev test
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add a unit test in lib/newlib_tests/ to verify the newly added
tst_attach_loopdev() function.

The test covers:
- Concurrent allocation of multiple loop devices without collisions.
- Parallel worker stress testing to exercise the exponential backoff
  retry loop upon transient EBUSY conditions.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Wei Gao <wegao@suse.com>
---
v17->v18:
- New patch in v18.

 lib/newlib_tests/.gitignore           |   1 +
 lib/newlib_tests/runtest.sh           |   1 +
 lib/newlib_tests/tst_attach_loopdev.c | 133 ++++++++++++++++++++++++++
 3 files changed, 135 insertions(+)
 create mode 100644 lib/newlib_tests/tst_attach_loopdev.c

diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index 3a6e1643c..2d4b3d43f 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -11,6 +11,7 @@ test11
 test13
 test14
 test15
+tst_attach_loopdev
 tst_capability01
 tst_capability02
 tst_cgroup01
diff --git a/lib/newlib_tests/runtest.sh b/lib/newlib_tests/runtest.sh
index 71808ef8b..18b64c07a 100755
--- a/lib/newlib_tests/runtest.sh
+++ b/lib/newlib_tests/runtest.sh
@@ -16,6 +16,7 @@ test_zero_hugepage.sh
 test0[579]
 test1[59]
 test2[04]
+tst_attach_loopdev
 tst_bool_expr
 tst_capability02
 tst_checkpoint
diff --git a/lib/newlib_tests/tst_attach_loopdev.c b/lib/newlib_tests/tst_attach_loopdev.c
new file mode 100644
index 000000000..dbc711cb9
--- /dev/null
+++ b/lib/newlib_tests/tst_attach_loopdev.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 SUSE LLC <wegao@suse.com>
+ */
+
+/*\
+ * Unit test for tst_attach_loopdev().
+ *
+ * Verifies that:
+ * - Multiple backing files can be attached simultaneously to distinct
+ *   loop devices without collision.
+ * - Concurrent workers attaching and detaching loop devices in parallel
+ *   succeed without unhandled EBUSY race conditions.
+ */
+
+#include <sys/types.h>
+#include <unistd.h>
+#include <string.h>
+#include <stdlib.h>
+
+#include "tst_test.h"
+
+#define BACKING_FILE1  "test_loop1.img"
+#define BACKING_FILE2  "test_loop2.img"
+
+#define DEV_SIZE_MB    1
+#define NUM_WORKERS    4
+#define WORKER_LOOPS   5
+
+static char dev1[PATH_MAX];
+static char dev2[PATH_MAX];
+
+static void cleanup(void)
+{
+	if (dev1[0])
+		tst_detach_device(dev1);
+
+	if (dev2[0])
+		tst_detach_device(dev2);
+}
+
+static void setup(void)
+{
+	if (tst_prealloc_file(BACKING_FILE1, 1024 * 1024, DEV_SIZE_MB))
+		tst_brk(TBROK, "Failed to create %s", BACKING_FILE1);
+
+	if (tst_prealloc_file(BACKING_FILE2, 1024 * 1024, DEV_SIZE_MB))
+		tst_brk(TBROK, "Failed to create %s", BACKING_FILE2);
+}
+
+static void test_multiple_devices(void)
+{
+	if (tst_attach_loopdev(dev1, sizeof(dev1), BACKING_FILE1)) {
+		tst_res(TFAIL, "Failed to attach %s to dev1", BACKING_FILE1);
+		return;
+	}
+
+	if (tst_attach_loopdev(dev2, sizeof(dev2), BACKING_FILE2)) {
+		tst_res(TFAIL, "Failed to attach %s to dev2", BACKING_FILE2);
+		goto detach1;
+	}
+
+	if (!strcmp(dev1, dev2))
+		tst_res(TFAIL, "dev1 and dev2 assigned identical device: '%s'", dev1);
+	else
+		tst_res(TPASS, "Assigned distinct loop devices: '%s' and '%s'", dev1, dev2);
+
+	if (tst_detach_device(dev2)) {
+		tst_res(TFAIL, "Failed to detach dev2 '%s'", dev2);
+	} else {
+		tst_res(TPASS, "Detached dev2 '%s' successfully", dev2);
+		dev2[0] = '\0';
+	}
+
+detach1:
+	if (tst_detach_device(dev1)) {
+		tst_res(TFAIL, "Failed to detach dev1 '%s'", dev1);
+	} else {
+		tst_res(TPASS, "Detached dev1 '%s' successfully", dev1);
+		dev1[0] = '\0';
+	}
+}
+
+static void test_concurrent_contention(void)
+{
+	pid_t pids[NUM_WORKERS];
+	int i;
+
+	for (i = 0; i < NUM_WORKERS; i++) {
+		pids[i] = SAFE_FORK();
+		if (!pids[i]) {
+			char file[32];
+			char dev[PATH_MAX];
+			int j;
+
+			snprintf(file, sizeof(file), "worker_%d.img", i);
+			if (tst_prealloc_file(file, 1024 * 1024, DEV_SIZE_MB))
+				tst_brk(TBROK, "Worker %d failed to prealloc %s", i, file);
+
+			for (j = 0; j < WORKER_LOOPS; j++) {
+				dev[0] = '\0';
+				if (tst_attach_loopdev(dev, sizeof(dev), file))
+					tst_brk(TBROK, "Worker %d loop %d failed attach", i, j);
+
+				if (tst_detach_device(dev))
+					tst_brk(TBROK, "Worker %d loop %d failed detach", i, j);
+			}
+
+			exit(0);
+		}
+	}
+
+	for (i = 0; i < NUM_WORKERS; i++)
+		SAFE_WAITPID(pids[i], NULL, 0);
+
+	tst_res(TPASS, "All %d workers attached and detached loop devices concurrently",
+		NUM_WORKERS);
+}
+
+static void run(void)
+{
+	test_multiple_devices();
+	test_concurrent_contention();
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
