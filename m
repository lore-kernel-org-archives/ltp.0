Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A429CD6E56
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 10:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780308866; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=e3soH7aEBQvHPtIJByllBRcCNbbnVWWHS7Tuy7vODEk=;
 b=m0AeWPq8CFhMXOvf/tm5nDZPGpiVHMns5pSV0SYXDX3BA4flKuheW6aoZsfVo7gutaZN0
 GgkIMxnMdPw6SkV0od+h0Nvc96V2U/ceVopx0LSuungr65m4uyNXSKbYiIrQ7LPxayagSk1
 p0UF1yyDLVmgZ7ejz33Jc0iSoW2XZB0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 551CF3C054A
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 12:14:26 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C9343E1A83
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 12:14:06 +0200 (CEST)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com
 [IPv6:2607:f8b0:4864:20::649])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 95B791000758
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 12:14:05 +0200 (CEST)
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-2c0c36f1cc0so23081115ad.3
 for <ltp@lists.linux.it>; Mon, 01 Jun 2026 03:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1780308844; x=1780913644; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Woy6ZKd2JlEC8Qk6r0oDOANcJRLUPRvx7QrkPt1u5SE=;
 b=cPe1WOn9SvXWk8jCQ03tCKg0RipCKFagWjVZZHySiamtYD0oIM7jV1lDEwBMTNmLzz
 NPL0l15m/RzMk7xDEuHwWBCCyl3GzxbXo/hdG7TBu80HKj2baK4MOkS5YNEkufVf8lNT
 KXKeQ+u+mB4JzztYEwoeV2nfsz/KLOeu+0/wak92Hzu4+/xqY+XoGmQm8qHlSEwE0/FW
 DDT1duOUnnL6Cu9JPSQnJvzFlOBA2kozoYrPtT9hlM8svzYU7/+Hrgpf/RbZmY5FlIT6
 bVQLkuWJGYVda2jr8ZpL+ChbHhlP7457Hm826FcL8wmW8nwQ0bVHbjOcfl3egSzuaDbb
 rwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780308844; x=1780913644;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Woy6ZKd2JlEC8Qk6r0oDOANcJRLUPRvx7QrkPt1u5SE=;
 b=nW0EsnuQHtmwP0Qx2UTbm3coPDJKe3BsmmPKMvSILFfm0hPKPACFh22mp0mzZpTHDC
 7WdBXPFvUTTCVRq7ycjHlxyHVb5/LlB4M68q+mvMavcAZ19Dpl/3VRqs6kRp/s64+Z/F
 Zvl6q1ywcNttQEpX/Md6nKl7sfKgmC0SGDppneONdNyu0xOF6m3Sw9XFJCtg2OJBWtWZ
 4Wm8gwzBG/LeKNp6OgWtz43MUO/qMRMrePPYKOk10wKcc9y1tuTORvMkrE87fkQ5muX1
 cTkmZsfJWciKUGpVS1RmYQ6lv321VuuDhSdPklObAJN3nxaCGiiS7nXOKKCMJUUjMro7
 HS3w==
X-Gm-Message-State: AOJu0Yz37Tus7TgIH5e956msrncdbB+6xMkbCfLZ/J3ELvEbq2HIRCYw
 M10zxkDs5Aua1R2gMOQmZYUpZDb+8bJyEWRbSFI6dgZ3WLuyDErGMZ9cd9L/UPEUFEk+GtoktJs
 ftrnDPv9EOInuUV1FvtWQNVC/m8tFbygaalf1tEsc1py2x6GUA0RLfUcXUh4utcP9w4nNmTsfvQ
 kPwJOfsa1rlaIU9JyhJ63SCBHbrSwlcGbgcX317t5bsJAdh4k=
X-Received: from plkk3.prod.google.com ([2002:a17:902:c403:b0:2bd:15bf:f9c7])
 (user=chihsheng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:8c8:b0:2bc:eea4:83c3 with SMTP id
 d9443c01a7336-2bf368334b0mr114326685ad.25.1780308843664; 
 Mon, 01 Jun 2026 03:14:03 -0700 (PDT)
Date: Mon,  1 Jun 2026 10:13:02 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260601101302.3858362-1-chihsheng@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/xattr: Add runtime probe for socket xattr
 backports
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
From: Darren Chang via ltp <ltp@lists.linux.it>
Reply-To: Darren Chang <chihsheng@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Upstream commit dc0876b9846d ("xattr: support extended attributes on
sockets") was merged in v7.1.0. Currently, setxattr02 and fsetxattr02
strictly expect EPERM for sockets on kernels < 7.1.0.

However, downstream kernels (e.g., Android mainline branches) often
backport this feature to older kernel versions (such as 7.0.0). On
these kernels, the strict version check causes a false positive failure:
"passed unexpectedly".

This patch introduces a runtime probe in setup() for both tests to
detect if older kernels have the backported feature. If the xattr
syscalls succeed on a socket during setup, we assume the patch is
present and adjust the expected result to pass.

Signed-off-by: Darren Chang <chihsheng@google.com>
---
 .../kernel/syscalls/fsetxattr/fsetxattr02.c   | 28 +++++++++++++++++++
 .../kernel/syscalls/setxattr/setxattr02.c     | 15 ++++++++++
 2 files changed, 43 insertions(+)

diff --git a/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c b/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
index 2a48b7da7..ddb1804c8 100644
--- a/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
+++ b/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
@@ -245,6 +245,34 @@ static void setup(void)
 	}
 
 	socket_xattr_supported = tst_kvercmp(7, 1, 0) >= 0;
+
+	/*
+	 * Probe for backports on older kernels.
+	 * If the version is < 7.1.0 but fsetxattr() succeeds, we assume the patch
+	 * has been backported.
+	 */
+    int socket_idx = -1;
+	if (!socket_xattr_supported) {
+		for (i = 0; i < ARRAY_SIZE(tc); i++) {
+			if (tc[i].issocket) {
+				socket_idx = i;
+				break;
+			}
+		}
+
+		if (socket_idx != -1) {
+			if (fsetxattr(tc[socket_idx].fd, tc[socket_idx].key,
+				      tc[socket_idx].value, tc[socket_idx].size,
+				      tc[socket_idx].flags) == 0) {
+				
+				tst_res(TINFO, "Socket xattr support detected (backport)");
+				socket_xattr_supported = true;
+				
+				/* Clean up the probed xattr to avoid interfering with the actual test */
+				SAFE_FREMOVEXATTR(tc[socket_idx].fd, tc[socket_idx].key);
+			}
+		}
+	}
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/setxattr/setxattr02.c b/testcases/kernel/syscalls/setxattr/setxattr02.c
index 994ab655d..94d1024e6 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr02.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr02.c
@@ -196,6 +196,21 @@ static void setup(void)
 	SAFE_MKNOD(SOCK, S_IFSOCK | 0777, 0);
 
 	socket_xattr_supported = tst_kvercmp(7, 1, 0) >= 0;
+
+	/*
+	 * Commit dc0876b9846d "xattr: support extended attributes on sockets"
+	 * merged in 7.1.0 mainline, but might be backported.
+	 * Try to set xattr on socket to detect support.
+	 */
+	if (!socket_xattr_supported) {
+		if (setxattr(SOCK, XATTR_TEST_KEY, XATTR_TEST_VALUE,
+			     XATTR_TEST_VALUE_SIZE, XATTR_CREATE) == 0) {
+			
+			tst_res(TINFO, "Socket xattr support detected (backport)");
+			socket_xattr_supported = true;
+			SAFE_REMOVEXATTR(SOCK, XATTR_TEST_KEY);
+		}
+	}
 }
 
 static struct tst_test test = {
-- 
2.54.0.1013.g208068f2d8-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
