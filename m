Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223AB606A321
	for <ltp@archiver.kernel.org>; Fri, 13 Nov 2026 04:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=fylxyKqD;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Z1TD7/it
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794543138; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=x3zxUTBJEYRAHe/Eyo5pJrHN0ElHnycanW2ym+ubf5k=;
 b=fylxyKqDUW8Qyu9AsfhUnu4yc7r9Bu1nDw04PSADQqTUD1BLkfM/UBT4lfU2uGIyDfyeO
 UXDoIQiu6adap2BJ/Vwhrg7Ci6jW9GkB5cC3Snlw5Y+lON4G2fehaOHfNlxHrkpa/4YC7U9
 z1pOrm/UIDkiSBYbUVS3STMLM72fHZQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 965513EB519
	for <ltp@archiver.kernel.org>; Fri, 13 Nov 2026 05:12:18 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 714353EACB7
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 05:11:41 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 371CF600A6F
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 05:11:41 +0100 (CET)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so6618885e9.2
 for <ltp@lists.linux.it>; Thu, 12 Nov 2026 20:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1794543101; x=1795147901; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xcp1inGwV4gTyzIddvNb+bxhK4f0OOwYoJO6+BXO8xo=;
 b=Z1TD7/itXIAxokg7Vb/iu68b46lf/8z33jbILonQZ+mGmmNVywGcuVWbT7TeFdlC6F
 QjRRgPEwU6v+cb7i4p5q5ISF57fxn0KmD5vfJQJCFFeFnvDcE6xhMEcQgbiafiNXmVEa
 FjuJzLmLRRrbJVt43Z+L6yaDYQahbRcyH7phf8zueSlf1qsOlpeBfl+6cOJ5piNf623s
 wmY+kOvJ4OjBC3i+o4YC8B8PYLdfHSzr5EjSpb7VvYEGzYINfjjaBfB4Ce1PJy+qG2TX
 FJciV7mzMKanQ3nMkWPYQRQSc0/FM/ohNxPQtMlNjyExYBe6x7i81NPha+CQ+ar5KAac
 ljQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794543101; x=1795147901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Xcp1inGwV4gTyzIddvNb+bxhK4f0OOwYoJO6+BXO8xo=;
 b=ipv6ML98qcQBxPKGqr8TXL77usIsjcD+Hmf59FYnCLQgvTGYlc+W+DuNiX7PQDhboS
 r7IPLcgTWKgJlQiRsqD06Tw3BvYof+GwUEW1rbeilRqXF090I6Ngt1naeAcQtx8x2LXS
 g/MD0PstuB4wW8xEP6zs8ZyXWIdMVxVU+Y37DPQr8Z0hoEW1DWorZIFchvR/XAbAKhKq
 yo+GI3bEGd3PX+wmG5fUXUQOQvldD80p3h9whvOqbcV+wD1rva30SSQPf4aWf96SC7Bx
 GCvACPm3NFy0+WWtwjYJrsTmqYeBSzxBqJX+RHZS5VMyUbWBZoevEz2ToCnP73wG0A8s
 eLHA==
X-Gm-Message-State: APuU4Z/nY5yd2zggV6G/5loEXCuoEP5njsLFobmXOpmZXmp9vp9SgglM
 qxXwGjrvJCc9pDzmN6jYRGUkAsT+8zUcGtKqZkLqICWXF9xckyS7FCMc8ErPbeDHTZWxw0iY/lO
 VagBMPg==
X-Gm-Gg: AYBFou1zKINIPD+Ol32D4q44MN5FhEzWng1O6xGvikqe4JDYJDMoDg2Fkjw4BMVR58O
 OL3liXcWTsigPgHkWnu3kqjKqW8eeyzsdQvtj3yD5PTlqn+brcQcYeSaPQPURMwEBzkWxmoCNiY
 GnIGjI/kFFqvPJlJj6vy746qp1Qr1lHmQsfx7vxFPV76kVSVfT7jPsI0s+5wFBsN/4a/6ckGJuQ
 xOjNc/rx75baeF2xtIB3diWefVNklcYVfmuQnWEcaOCCtfnaZLXaZDUGH6zsJW6MsPpVEGGNchr
 hZsKtKElBA08F+PL9hdd4DZVX5xnKEUHKfb7GbDFpAcg6kULok/9WnKLmzf4di6rknbGSMuzhk5
 eKy5CquyqOwEDbrJsX4w7PX/7lxCTnQ4Lw0/XKmX+QK1ehWShf+GJKy/dBb47HSYilPM3K398AR
 Sa82mQnsvH2S5ysQQH5ZN4FlMBgK7THOFdIt2VSpWas8sJLHNHNiO6phfqb0gwSp0wQ21WXkbHF
 WJuOVh0/nlot0O5uEnN/H6ex8c6d8j1dClbSXOIV5/JdVdku4SHyoHOhBTyHtKLmE1kO7nT8Igo
 lEgI8hqHKIntSFqRCnwRY/oqtZEP5R2b08GwUN5DE/r1aLEwntQbhbsGCSoGEnCI/X6QodfS9Nx
 OOfJty9T78gSAtW3hE/BLdMhydRo2ZdfrZQ==
X-Received: by 2002:a05:6000:1884:b0:498:42e3:3f6f with SMTP id
 ffacd0b85a97d-49c6d63fa5amr3296517f8f.5.1794543100592; 
 Thu, 12 Nov 2026 20:11:40 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-49c5ff2cd05sm2460918f8f.31.2026.11.12.20.11.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 20:11:40 -0800 (PST)
To: ltp@lists.linux.it
Date: Fri, 13 Nov 2026 04:11:30 +0000
Message-ID: <20261113041136.17102-2-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113041136.17102-1-wegao@suse.com>
References: <20261113041136.17102-1-wegao@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/4] lib: Add tst_bind_to_current_cpu() helper
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

Add tst_bind_to_cpu() and tst_bind_to_current_cpu() to the core LTP
CPU library (include/tst_cpu.h, lib/tst_cpu.c). This allows tests to
pin the test process to a specific or current CPU, which is useful
for avoiding multi-CPU migration artifacts and per-CPU charge/counter
batching variations.

Also add a fallback definition for sched_getcpu() in include/lapi/sched.h
via getcpu() for older C libraries without sched_getcpu().

Signed-off-by: Wei Gao <wegao@suse.com>
---
 include/lapi/sched.h | 10 ++++++++++
 include/tst_cpu.h    | 11 +++++++++++
 lib/tst_cpu.c        | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/include/lapi/sched.h b/include/lapi/sched.h
index 4fa6e7c5f..ea828664c 100644
--- a/include/lapi/sched.h
+++ b/include/lapi/sched.h
@@ -115,6 +115,16 @@ static inline int getcpu(unsigned *cpu, unsigned *node)
 }
 #endif
 
+#ifndef HAVE_SCHED_GETCPU
+static inline int sched_getcpu(void)
+{
+	unsigned int cpu;
+	int ret = getcpu(&cpu, NULL);
+
+	return ret == 0 ? (int)cpu : ret;
+}
+#endif
+
 #ifndef SCHED_DEADLINE
 # define SCHED_DEADLINE	6
 #endif
diff --git a/include/tst_cpu.h b/include/tst_cpu.h
index 340d0f3c7..7c6089379 100644
--- a/include/tst_cpu.h
+++ b/include/tst_cpu.h
@@ -36,4 +36,15 @@ const char *tst_cpu_vendor(void);
 
 int tst_is_virt(int virt_type);
 
+/**
+ * tst_bind_to_cpu() - Pin calling process to the specified CPU.
+ * @cpu: CPU index to bind to.
+ */
+void tst_bind_to_cpu(int cpu);
+
+/**
+ * tst_bind_to_current_cpu() - Pin calling process to the current CPU.
+ */
+void tst_bind_to_current_cpu(void);
+
 #endif	/* TST_CPU_H__ */
diff --git a/lib/tst_cpu.c b/lib/tst_cpu.c
index 241bd3347..2f0e2f8ee 100644
--- a/lib/tst_cpu.c
+++ b/lib/tst_cpu.c
@@ -22,6 +22,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include "test.h"
+#include "lapi/sched.h"
 #include "tso_safe_macros.h"
 #include "tso_safe_file_ops.h"
 #include "tso_safe_stdio.h"
@@ -139,3 +140,36 @@ const char *tst_cpu_vendor(void)
 
 	return cpu_vendor;
 }
+
+void tst_bind_to_cpu(int cpu)
+{
+	size_t mask_size;
+	cpu_set_t *mask;
+
+	tst_resm(TINFO, "Binding test process to CPU %d", cpu);
+
+	mask = CPU_ALLOC(cpu + 1);
+	if (!mask)
+		tst_brkm(TBROK | TERRNO, NULL, "CPU_ALLOC() failed");
+
+	mask_size = CPU_ALLOC_SIZE(cpu + 1);
+	CPU_ZERO_S(mask_size, mask);
+	CPU_SET_S(cpu, mask_size, mask);
+
+	if (sched_setaffinity(0, mask_size, mask) < 0) {
+		CPU_FREE(mask);
+		tst_brkm(TBROK | TERRNO, NULL, "sched_setaffinity() failed");
+	}
+
+	CPU_FREE(mask);
+}
+
+void tst_bind_to_current_cpu(void)
+{
+	int cpu = sched_getcpu();
+
+	if (cpu < 0)
+		tst_brkm(TBROK | TERRNO, NULL, "sched_getcpu() failed");
+
+	tst_bind_to_cpu(cpu);
+}
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
