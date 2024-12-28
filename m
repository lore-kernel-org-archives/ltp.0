Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C18FBE77188
	for <ltp@archiver.kernel.org>; Sat, 28 Dec 2024 11:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1735386287; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=Jr4WsE2Te3jYHvBIyJcRa5jxokWPwkSzoLNG5bjckJ0=;
 b=Opmq7Ph+h9r7otHRPHJCD7716m0XepyRbCX7t7oqk/Np3O6k28Jr60zIUpvu51t/jmg0g
 +JWpEiBEHIzTUeuLyGyoEVlt5IgRSzgqqmARtIBJy+a8/jybyvFL0B2AsVUfXzqG2GaNpzr
 5nteZ+0U1Gn5z53Dgd3xt8U9XEA7xzM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 784513E4D93
	for <ltp@archiver.kernel.org>; Sat, 28 Dec 2024 12:44:47 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 92BC93E4D79
 for <ltp@lists.linux.it>; Sat, 28 Dec 2024 12:44:26 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 36ECE14010C7
 for <ltp@lists.linux.it>; Sat, 28 Dec 2024 12:44:25 +0100 (CET)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aa68b513abcso1508411366b.0
 for <ltp@lists.linux.it>; Sat, 28 Dec 2024 03:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1735386264; x=1735991064; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lH5LTH/kLj+cW4t0FokBs1IPrHyjEs+pFRtsAN/ppxw=;
 b=PepyPnFM0C9usWJ4/5TUKtI93qK4lo93FaJvqla8O1aHKobzxQY84PT+TTWcUsBmgb
 zLgIIze0DVgwyR9OcykCtL0MbTPq3q4pxwr+B9QZCXjh+2nZoHwJREVFGpusztEgNH/v
 pnU0PRKTVK4+2nuhHXR85vMawN/RS3xVtCzZpTkNhGTsS2IclEiNPAy9v3tNuxkPb8A4
 XeW+PapBGZQrewK+6k/ssP83BxOoD4G0PX6Ozxm08a2PB6srA9sme1i60U7jR0JUnZKH
 PZaRD38+7Be2nZnomA4Hz5d2T6sNBff6BoeBrsVKFV+op3FFtuXDRiWWxewVS69vUqJn
 tjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735386264; x=1735991064;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lH5LTH/kLj+cW4t0FokBs1IPrHyjEs+pFRtsAN/ppxw=;
 b=JP1LIPeJ3Wv2FzPVxMsk1mn+IU2jtaZdNkU/K3bFFXX1UD2UvIfXiDmLDr4SwYRR/G
 CDMg2gi0jcBIkXdeC0CmzUTNmVmfwuqbACXmEEVthGcr9VOiYHhI+hihuNGAA1/LyEU/
 9V+9oADl0h+rTj95Ke2A02UkUVWRzBZbV6Mc+JDKi2QmJWSK0rPYtCfmyCLxgs6Fdb/j
 0qYrwGIZvRHkdggM2bpqgTOuyL76mTYWALA1YKgNISHW+uyM0tH5tuIts6dRVVUJPkwg
 nTsybxtpYK1NyfvmQQKQ6bGjOETIWsR3YG/4IGbUsnXb3EVaokemFZz8JL9rzYLxdAK1
 iSBw==
X-Gm-Message-State: AOJu0YyDG7JVMVP0UeED1waPfHf/3NRxgF/OxWsz1iABr5z6BdWZ9IFu
 6ZZZZbnogZYg2oAdF9PqKaAOwY1ChhOwA2q+eEGcf8Cohk6fPShz7b31/duXiqpQf3wrFQ9c8h0
 =
X-Gm-Gg: ASbGncv/MYRbCLNiImMXm8g81IEu7ddV29C3WKHwObCs9ubCi6aojiqoKPXjBnkqfOK
 odUrCMWnzOQsH0j37CRufymjNYDboqjdSiL+aj12mfdXJMkZsTCVzQGmugnsyXFlmcEF9tj/XgB
 G16y1UHa3dShZ7+kPplcwP32IuzUj2G7G3KsXDoWSNUZVZfmzXnSKKemgZct8EM/kqG5irocYEj
 JWL0FmG6Ymj2LEFGpnKcLDnqZWmAQ8Gc9sFNba/+NlNsw==
X-Google-Smtp-Source: AGHT+IEQv2O1j02D5JpihIEjwZ4p2wj6Cq5H4XgtRDwSR30l9TZCGZJ/T2bWYiFX4Quld77N/8X5hw==
X-Received: by 2002:a17:907:2d1e:b0:aa6:bcc2:4da1 with SMTP id
 a640c23a62f3a-aac2874a98amr2656332766b.7.1735386263830; 
 Sat, 28 Dec 2024 03:44:23 -0800 (PST)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0eae4369sm1238674866b.87.2024.12.28.03.44.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2024 03:44:23 -0800 (PST)
To: ltp@lists.linux.it
Date: Sat, 28 Dec 2024 06:44:16 -0500
Message-Id: <20241228114416.12653-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] fcntl40.c: Test fcntl using F_CREATED_QUERY
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

Signed-off-by: Wei Gao <wegao@suse.com>
---
 include/lapi/fcntl.h                       |  8 ++++
 runtest/syscalls                           |  2 +
 testcases/kernel/syscalls/fcntl/.gitignore |  2 +
 testcases/kernel/syscalls/fcntl/fcntl40.c  | 52 ++++++++++++++++++++++
 4 files changed, 64 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fcntl/fcntl40.c

diff --git a/include/lapi/fcntl.h b/include/lapi/fcntl.h
index 761331798..7c0502488 100644
--- a/include/lapi/fcntl.h
+++ b/include/lapi/fcntl.h
@@ -154,6 +154,14 @@
 # define RENAME_WHITEOUT		(1 << 2)
 #endif
 
+#ifndef F_LINUX_SPECIFIC_BASE
+#define F_LINUX_SPECIFIC_BASE 1024
+#endif
+
+#ifndef F_CREATED_QUERY
+#define F_CREATED_QUERY (F_LINUX_SPECIFIC_BASE + 4)
+#endif
+
 /* splice, vmsplice, tee */
 
 #ifndef SPLICE_F_NONBLOCK
diff --git a/runtest/syscalls b/runtest/syscalls
index ded035ee8..43e493eb1 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -363,6 +363,8 @@ fcntl38 fcntl38
 fcntl38_64 fcntl38_64
 fcntl39 fcntl39
 fcntl39_64 fcntl39_64
+fcntl40 fcntl40
+fcntl40_64 fcntl40_64
 
 fdatasync01 fdatasync01
 fdatasync02 fdatasync02
diff --git a/testcases/kernel/syscalls/fcntl/.gitignore b/testcases/kernel/syscalls/fcntl/.gitignore
index e60176973..e3486ee45 100644
--- a/testcases/kernel/syscalls/fcntl/.gitignore
+++ b/testcases/kernel/syscalls/fcntl/.gitignore
@@ -72,3 +72,5 @@
 /fcntl38_64
 /fcntl39
 /fcntl39_64
+/fcntl40
+/fcntl40_64
diff --git a/testcases/kernel/syscalls/fcntl/fcntl40.c b/testcases/kernel/syscalls/fcntl/fcntl40.c
new file mode 100644
index 000000000..ef03becef
--- /dev/null
+++ b/testcases/kernel/syscalls/fcntl/fcntl40.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Basic test for fcntl using F_CREATED_QUERY.
+ *
+ * It is based on the following kernel commit:
+ * commit d0fe8920cbe42547798fd806f078eeaaba05df18
+ * Author: Christian Brauner brauner@kernel.org
+ * Date: Wed Jul 24 15:15:36 2024 +0200
+ */
+
+#include "lapi/fcntl.h"
+#include "tst_test.h"
+
+static void verify_fcntl(void)
+{
+	for (int i = 0; i < 101; i++) {
+		int fd;
+		char path[PATH_MAX];
+
+		fd = SAFE_OPEN("/dev/null", O_RDONLY | O_CLOEXEC);
+
+		/* We didn't create "/dev/null". */
+		TST_EXP_EQ_LI(fcntl(fd, F_CREATED_QUERY, 0), 0);
+		close(fd);
+
+		sprintf(path, "aaaa_%d", i);
+		fd = SAFE_OPEN(path, O_CREAT | O_RDONLY | O_CLOEXEC, 0600);
+
+		/* We created "aaaa_%d". */
+		TST_EXP_EQ_LI(fcntl(fd, F_CREATED_QUERY, 0), 1);
+		close(fd);
+
+		fd = SAFE_OPEN(path, O_RDONLY | O_CLOEXEC);
+
+		/* We're opening it again, so no positive creation check. */
+		TST_EXP_EQ_LI(fcntl(fd, F_CREATED_QUERY, 0), 0);
+		close(fd);
+		unlink(path);
+	}
+}
+
+static struct tst_test test = {
+	.test_all = verify_fcntl,
+	.needs_tmpdir = 1,
+	.min_kver = "6.12",
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
