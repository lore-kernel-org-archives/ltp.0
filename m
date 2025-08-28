Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBCECA0FF6
	for <ltp@archiver.kernel.org>; Thu, 28 Aug 2025 22:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756421549; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=Ntd6J1HIEZqnwq9oN/7Rc8Dgrm6csY/Ui+HFc/R3914=;
 b=Gij2v4Ow+l9s3sBfh4q7B6uIPRMrJFQLNQsIlu6heNCMdKuaiDDY+wtvZ6aOzxKdJTVf5
 J3v5ZuVXVSfnshTSVm1HQw9gS2mx8PFsYt69R5i9r4e7SZPH+/66uD/f7fICp/bC9n2V8oW
 K/aWbWG1EvMV+c6wo9xuDonJZPVEoXc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF0403CD07F
	for <ltp@archiver.kernel.org>; Fri, 29 Aug 2025 00:52:28 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 44A613C4F42
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 00:52:08 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9B3591400205
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 00:52:07 +0200 (CEST)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-afe9358fe77so158700966b.1
 for <ltp@lists.linux.it>; Thu, 28 Aug 2025 15:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1756421527; x=1757026327; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wBHoxbdfXdwlqRVMnPIdi2Hm9QpQVro1IGxR6IllijM=;
 b=fx+e8ZD8vkQQXRkLm46/OCPadb/lG3Dpp57Sn458VQiTrYFfcvRyyjSLf+7V3GyZjC
 UpP+YAO7pS0KKvtRyR7xG0Voy8gMt7Up1HxFih7Uxgqye+z9AJXl/nysst1F+0S2XkLY
 +MILXHMoYCgg8Vc0XbLfo5x9o8zHIUtNdaT9PaofoerX/SnZfCuhYildoAlkf+JU/nmw
 3UG2poyi06daN12av6eQufCCecvpC7pjOO4IUhfuK9c2SRXqbqdsZIqQSxxYURcRVVfe
 ViEYUcfjOzR3pvX8taFMG53U2E/v/4GhN1a/6w8I81c63xV/oAJcyPaaILBly+kzNOLo
 CX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756421527; x=1757026327;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wBHoxbdfXdwlqRVMnPIdi2Hm9QpQVro1IGxR6IllijM=;
 b=KiIoszNNIG6j7uwmgeSilzr6eSYhM9fp4olARujea4Ekfc88kMJZRJVsI6obc+dknK
 TaOxy11aHOxOnHYBznULXUryKpK9r0rT5Z6NG/Xj393zS8n5KX38PZPBOMV1rRfzxg7G
 uacuDpR0imdCyx9Gx69yNqunZoeTUdBkySKhGA3UAjVwSnwpLNArhlJKvhC0yKN1FCWz
 vhJvysk0ZLcyCB/FV/nVGjzqHPFMNlCK8JMNvSeHrho9wlF2WEM31zP+51PrguTBG1Vj
 5hWO+VhW9JmmW6eexJa4NSZ+7It6EKkERRU0IQ/G9QuRlib3oZK3RiYiuEZ1sc5pFaoZ
 K1CA==
X-Gm-Message-State: AOJu0YzobpRzmPAi+nqzQtuyo6+oOjnb6+PDtdL1AC4jRR+j1aOf+shJ
 hxktncMTpHIxsHP45jmxtZtP8izi7r0oA1utaKUltiNWr/t3lzIUW9MxwBnHnvNGvLW0aWpJ6me
 gYX4=
X-Gm-Gg: ASbGncuEvELn89Ie05Q2/vCN9khPYOjzN2AkK4yxiZwv7lhMQneq7Th5hw0ILO7hVp/
 acK+coVBjgbaE6vEV/2vZ/G5a6+omi6NUL1mGZ0RWCnvHjov5ZhaSHb96FTn99WMLqwjjB6Nwqg
 yQ92KnvvlHrst6VD7n8sT6UQAhRR5tEuSSyPyjOsXgkLmozRZSJTPg5FWK8Nbi9mJoWrbBisKdK
 L22RPV+kLE491Xb+UGMbCNeZKvpO5kv4yJehDGCnzwTppFy8agc4XBcw1WnYXz0mzti7tcKBRhI
 p13c+fWj4poIlwERjv/CkjRq0BLRhcEh7mAsof2A+XX0vcPjx6df/tsk27uBlJwUGEefc+g+jIx
 +4WiXLdUEBqIH9s+Bfm9Ws0Bgd6tWJ0xUBVPFhnFNSNc=
X-Google-Smtp-Source: AGHT+IF+WhGd6rrcJL5zV2zoB9wf1P0ZvzudsxMnKPzZXuzS+VIsDfjG6QyOsrJsqFc45DuQX9pY8w==
X-Received: by 2002:a17:907:9805:b0:ae3:7b53:31bd with SMTP id
 a640c23a62f3a-afe2943d059mr2218820266b.28.1756421526732; 
 Thu, 28 Aug 2025 15:52:06 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-afefca0a8b1sm56375066b.33.2025.08.28.15.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 15:52:06 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 28 Aug 2025 22:51:54 +0000
Message-ID: <20250828225157.982-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] fsmount01: Add test if MOUNT_ATTR_* have expected
 effect on the mount
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

The fsmount01 test does not test if MOUNT_ATTR_* have expected effect
on the mount, e.g. if MOUNT_ATTR_RDONLY mounts the FS read only etc.

Fixes: #1170
Signed-off-by: Wei Gao <wegao@suse.com>
---
 include/tst_device.h                          |  1 +
 lib/tst_device.c                              |  2 +-
 testcases/kernel/syscalls/fsmount/fsmount01.c | 27 +++++++++++++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/include/tst_device.h b/include/tst_device.h
index e0627a24d..24b5201c5 100644
--- a/include/tst_device.h
+++ b/include/tst_device.h
@@ -35,6 +35,7 @@ int tst_umount(const char *path);
 int tst_is_mounted(const char *path);
 int tst_is_mounted_ro(const char *path);
 int tst_is_mounted_rw(const char *path);
+int tst_mount_has_opt(const char *path, const char *opt);
 int tst_is_mounted_at_tmpdir(const char *path);
 
 /*
diff --git a/lib/tst_device.c b/lib/tst_device.c
index 5b0498c03..2364df052 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -429,7 +429,7 @@ int tst_umount(const char *path)
 	return -1;
 }
 
-static int tst_mount_has_opt(const char *path, const char *opt)
+int tst_mount_has_opt(const char *path, const char *opt)
 {
 	char line[PATH_MAX];
 	char abspath[PATH_MAX];
diff --git a/testcases/kernel/syscalls/fsmount/fsmount01.c b/testcases/kernel/syscalls/fsmount/fsmount01.c
index 6dafe25a8..bf0f5f100 100644
--- a/testcases/kernel/syscalls/fsmount/fsmount01.c
+++ b/testcases/kernel/syscalls/fsmount/fsmount01.c
@@ -8,6 +8,7 @@
 
 #include "tst_test.h"
 #include "lapi/fsmount.h"
+#include "tst_safe_stdio.h"
 
 #define MNTPOINT	"mntpoint"
 
@@ -75,6 +76,32 @@ static void run(unsigned int n)
 	TEST(move_mount(mfd, "", AT_FDCWD, MNTPOINT, MOVE_MOUNT_F_EMPTY_PATH));
 	SAFE_CLOSE(mfd);
 
+	switch (tc->attrs) {
+	case MOUNT_ATTR_RDONLY:
+		TST_EXP_VAL(tst_is_mounted_ro(MNTPOINT), 1);
+		break;
+	case MOUNT_ATTR_NOSUID:
+		TST_EXP_VAL(tst_mount_has_opt(MNTPOINT, "nosuid"), 1);
+		break;
+	case MOUNT_ATTR_NODEV:
+		TST_EXP_VAL(tst_mount_has_opt(MNTPOINT, "nodev"), 1);
+		break;
+	case MOUNT_ATTR_NOEXEC:
+		TST_EXP_VAL(tst_mount_has_opt(MNTPOINT, "noexec"), 1);
+		break;
+	case MOUNT_ATTR_RELATIME:
+		TST_EXP_VAL(tst_mount_has_opt(MNTPOINT, "relatime"), 1);
+		break;
+	case MOUNT_ATTR_NOATIME:
+		TST_EXP_VAL(tst_mount_has_opt(MNTPOINT, "noatime"), 1);
+		break;
+	case MOUNT_ATTR_NODIRATIME:
+		TST_EXP_VAL(tst_mount_has_opt(MNTPOINT, "nodiratime"), 1);
+		break;
+	default:
+		break;
+	}
+
 	if (TST_RET == -1) {
 		tst_res(TFAIL | TTERRNO,
 			"move_mount() failed to attach to the mount point");
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
