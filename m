Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37623C25B75
	for <ltp@archiver.kernel.org>; Wed, 29 May 2024 11:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1716983938; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Zs+iKkHM2wwbxgruYuArBQD6MSnuL3CW4bsfscEwsWs=;
 b=Rt56P5Sr6qc0oPPpdhgAzSkhxgxghgB1O1N8EPGgQDqi6253ekRZNHnikmvGioFLeRY1X
 NRtm/a4Y9kzS9ncLWcKw1cnu8dnCV/F/LI40D/lQFdF3ZpY3zCqQ1sC8ucdkOrPPJ5SRxgA
 B1MXkYJa/Dp8lLExZ5leXY2D78OHDrw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 91C493D068A
	for <ltp@archiver.kernel.org>; Wed, 29 May 2024 13:58:58 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1FFF83CFFFA
 for <ltp@lists.linux.it>; Wed, 29 May 2024 13:58:38 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2D704603460
 for <ltp@lists.linux.it>; Wed, 29 May 2024 13:58:37 +0200 (CEST)
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-52ab1d7243fso1061198e87.1
 for <ltp@lists.linux.it>; Wed, 29 May 2024 04:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1716983916; x=1717588716; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ooFtJEbdO2BR0XBadVf7lDt4zSP7nUDRBSl3Kc6Oc+k=;
 b=CO+Ij+bDGm2ZWg3p4IgtNDk39/eLC/HMMc2cHNT7iXjeLKDFLJZwOWDbBW4ZdsfxO6
 UURArDGaxiL905J3sZ4zwQHwO8vpf/y7Wk1k4FrNSAdrU0UvHhPn+zcV1RzL2V5/t89W
 uZS8nQQdCm4fouJvMaT0QRT+Ci/np1K98clRcZQhFdLadjOTnOCsa0etOVIaZqhQ3CTy
 teUAu5Rj3SnKejF5/bIyrs05Lm4D8khcswxf2NHHPzsQcgukMZM/YcB3UMHREQoCsW7n
 2bUxUUWMDu7oBUMmAqO4Cc81cOkACDmyhWirjqcTFJBOle/XQEaWj8khuiHMSykkzTBo
 1YQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716983916; x=1717588716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ooFtJEbdO2BR0XBadVf7lDt4zSP7nUDRBSl3Kc6Oc+k=;
 b=RtuQ37Be2qH1Z0YjkpdOTkiRMDU2YN2bCbdzMO0Tk3U4sIvm4kw5/fP+LG709+m3zB
 5EyUvJ37Pvo3WXh9G8hJzbSlCiMQtOqS3eYL6D7h/dKsKFyIBV0+S91c7s8J1bIzYu6M
 Diy0wGC92vWTkiyQuE+NhBw6Xk5/lo0ABFCqaHZkIOr99s5M5QHipJt9+lQYA0JMSI5y
 PsWqlU/uuwEsiDEbhWIwyCsOWHJsEv7wveNWL4kBoFkJPZzCyOL3ubt9LJBXjZhS28EL
 J6TYpWAvSmzVD/8oBTJjeOCzB73IFG9LqS3yLrwVAuEZ1FP+RD6FjMoenGa55XD+HYDQ
 tcKQ==
X-Gm-Message-State: AOJu0Yxww1EBw0Y4abpLZKH+h4Q4iuacjQt1ByuCsojvwbo8YlVMRUbl
 jSV86pnvDvET85+NXO4vgTvOle27af0YAjZiwcXQgoFuR0t/yyiEUcAdwN6Fut6bciplO2ku3GA
 =
X-Google-Smtp-Source: AGHT+IHr8+0nKfkaasIXHmyy98nrvVwIvd/9wIETjSSup7eDF/Iw/ZpGSzzkpRziON2StHOYRvRTog==
X-Received: by 2002:a05:6512:12ca:b0:52a:f9bf:737b with SMTP id
 2adb3069b0e04-52af9bf75bcmr1325084e87.27.1716983916051; 
 Wed, 29 May 2024 04:58:36 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a633c6b289bsm183798866b.29.2024.05.29.04.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 04:58:35 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 29 May 2024 07:58:28 -0400
Message-Id: <20240529115828.28396-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240524085617.32303-1-wegao@suse.com>
References: <20240524085617.32303-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] chmod09.c: Block mode changes of symlinks
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
 runtest/syscalls                           |  1 +
 testcases/kernel/syscalls/chmod/.gitignore |  1 +
 testcases/kernel/syscalls/chmod/chmod09.c  | 67 ++++++++++++++++++++++
 3 files changed, 69 insertions(+)
 create mode 100644 testcases/kernel/syscalls/chmod/chmod09.c

diff --git a/runtest/syscalls b/runtest/syscalls
index fe9ad0895..c8a7b3ecb 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -70,6 +70,7 @@ chmod03 chmod03
 chmod05 chmod05
 chmod06 chmod06
 chmod07 chmod07
+chmod09 chmod09
 
 chown01 chown01
 chown01_16 chown01_16
diff --git a/testcases/kernel/syscalls/chmod/.gitignore b/testcases/kernel/syscalls/chmod/.gitignore
index 27ddfce16..10249b089 100644
--- a/testcases/kernel/syscalls/chmod/.gitignore
+++ b/testcases/kernel/syscalls/chmod/.gitignore
@@ -3,3 +3,4 @@
 /chmod05
 /chmod06
 /chmod07
+/chmod09
diff --git a/testcases/kernel/syscalls/chmod/chmod09.c b/testcases/kernel/syscalls/chmod/chmod09.c
new file mode 100644
index 000000000..368a1d635
--- /dev/null
+++ b/testcases/kernel/syscalls/chmod/chmod09.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Test for kernel commit
+ * 5d1f903f75a8 ("attr: block mode changes of symlinks")
+ */
+
+#include "lapi/fcntl.h"
+#include "tst_test.h"
+
+#define MODE 0644
+#define TESTFILE "testfile"
+#define TESTFILE_SYMLINK "testfile_symlink"
+
+static void run(void)
+{
+	struct stat stat_file, stat_sym;
+	int mode = 0;
+	char fd_path[100];
+
+	int fd = SAFE_OPEN(TESTFILE_SYMLINK, O_PATH | O_NOFOLLOW);
+
+	sprintf(fd_path, "/proc/self/fd/%d", fd);
+
+	TST_EXP_FAIL(chmod(fd_path, mode), ENOTSUP, "chmod(%s, %04o)",
+			TESTFILE_SYMLINK, mode);
+
+	SAFE_STAT(TESTFILE, &stat_file);
+	SAFE_LSTAT(TESTFILE_SYMLINK, &stat_sym);
+
+	stat_file.st_mode &= ~S_IFREG;
+	stat_sym.st_mode &= ~S_IFLNK;
+
+	TST_EXP_EXPR(stat_file.st_mode != (unsigned int)mode,
+			"stat(%s) mode=%04o", TESTFILE, stat_file.st_mode);
+
+	TST_EXP_EXPR(stat_sym.st_mode != (unsigned int)mode,
+			"stat(%s) mode=%04o", TESTFILE, stat_sym.st_mode);
+
+	SAFE_CLOSE(fd);
+}
+
+static void setup(void)
+{
+	SAFE_TOUCH(TESTFILE, MODE, NULL);
+	SAFE_SYMLINK(TESTFILE, TESTFILE_SYMLINK);
+}
+
+static void cleanup(void)
+{
+	remove(TESTFILE);
+	remove(TESTFILE_SYMLINK);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+	.min_kver = "6.6",
+	.mntpoint = "mntpoint",
+	.all_filesystems = 1
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
