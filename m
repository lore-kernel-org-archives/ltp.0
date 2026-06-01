Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF22ECD5BD1
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 15:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780326869; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=I4DuEkli4UNfo3muVa/WQWMevNxrP4VTx459xjxJUsg=;
 b=B5YFeGqTtduEhYflgWviXj5dACSV6pDQq1M4SHs+/iuh5y8isWLvuwc8XiOyck56GI8DM
 p22NtUcf1Pplg7Rkkd0X8Y80GbSAPVwyUO/OBxmCNvnnn38NqVzB3OuCRIeYuEn7lIhMC0x
 Jm/KLCFkRxrtiyc4kmDCEWHvHQEQK1I=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C78D23E1A83
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 17:14:29 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6DF173E1A83
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 17:14:08 +0200 (CEST)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com
 [IPv6:2607:f8b0:4864:20::44a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2789160093B
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 17:14:08 +0200 (CEST)
Received: by mail-pf1-x44a.google.com with SMTP id
 d2e1a72fcca58-84235f9b91fso1303787b3a.2
 for <ltp@lists.linux.it>; Mon, 01 Jun 2026 08:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1780326846; x=1780931646; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=2VyBJFDK9aRmjVtwvcoNNnYAhBwXyx69Mk2EypbqtGA=;
 b=SK3VGHCweg1mE/aPfaZlsW0eFnMRc9FAEdObe/eOkppXME7MFXdw0BAYJH/xl5aPYw
 KVPkaLyKa1wR9ohMi2tp1p4YJ2n+zTnkOSLp+hdGxJp1kKgDC+H1FA3Y7jBmRg+4hfU6
 Oo8zkfb9GLddULKM7ORnAkjNFG3+RhT210dJqs8QhxQPMiaGi8ZY2fARUE7xc+22GBIp
 WNkeTvY2wcfLKDD4zA+by5BXZQ1T5IzUikac3W7Z1R1wY5HkuE2+Gx9FFsNbYwzq42Zo
 0UjTgPAiLW627RqLpRLctEXf6nNOCG56ZgGq7/72s/yD+xQX/NnFN/TFjM/CTNHUtmiq
 R8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780326846; x=1780931646;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2VyBJFDK9aRmjVtwvcoNNnYAhBwXyx69Mk2EypbqtGA=;
 b=sneiJm/bgjyo7wlGm5K/V7M6FzDAIYxyO84Grzd2pqyv06LbaPIE2AytOjIHGuKLLb
 NmqOw1yBH0gGoyCJ2cqIXoeYOH8HDP6xbzahRi9eDH8ht8OTJHlXWlpzJar6aT7/1+ro
 co7UO+VFEI4y4bLPgRcfvB7G3dLLUjea/tpPB9iDjINNH2rbzIcl2saHOz2fm+KPQ7bV
 ZAtHbK5rYFYqR9WT426fveaSzKTJnQCtU8BTaaJoh4R75uGMchG/CKvE9WgTDHoE0uPS
 NjKfC70znPRioQJhJIAFLLDdH9b+kHexKA8wd09Wx4cjSMYNZOl6xZDv/yVA3h4eNilt
 WoqQ==
X-Gm-Message-State: AOJu0Yxku66XW1L/Av1/cTIFistbDToHNusDWWuNTYIx/oJRezftB8iE
 rcfsdn4MYr/HH3cejfzRhaqFQxTX9Dr0/2vywEsQH4Zcm7cP5lISmLsPp5DPFnfkc7Xco6uuN8c
 DvY/tf7cJAEWvCnQmgdN6NiCUrVB3hbuCBA0k7J3SyHCONAJ7wurw8oHuJcaBRW/CKhdFGK+yCG
 xRdVrcjXTXSN7Bl9XwHyvNUa/gitZAiQPE21ATxhRj/2igofQ=
X-Received: from pfaz21.prod.google.com ([2002:aa7:91d5:0:b0:836:6e32:7280])
 (user=chihsheng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:889:b0:83a:b344:826a with SMTP id
 d2e1a72fcca58-842254368efmr10594649b3a.26.1780326845846; 
 Mon, 01 Jun 2026 08:14:05 -0700 (PDT)
Date: Mon,  1 Jun 2026 15:14:00 +0000
In-Reply-To: <20260601101302.3858362-1-chihsheng@google.com>
Mime-Version: 1.0
References: <20260601101302.3858362-1-chihsheng@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260601151400.4024541-1-chihsheng@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/xattr: Add runtime probe for socket xattr
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
 .../kernel/syscalls/fsetxattr/fsetxattr02.c   | 27 +++++++++++++++++++
 .../kernel/syscalls/setxattr/setxattr02.c     | 15 +++++++++++
 2 files changed, 42 insertions(+)

diff --git a/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c b/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
index 2a48b7da7..985204480 100644
--- a/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
+++ b/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
@@ -209,6 +209,7 @@ static void verify_fsetxattr(unsigned int i)
 static void setup(void)
 {
 	size_t i = 0;
+	int socket_idx = -1;
 	struct sockaddr_un sun;
 
 	dev_t dev = makedev(1, 3);
@@ -245,6 +246,32 @@ static void setup(void)
 	}
 
 	socket_xattr_supported = tst_kvercmp(7, 1, 0) >= 0;
+
+	/*
+	 * Commit dc0876b9846d "xattr: support extended attributes on sockets"
+	 * merged in 7.1.0 mainline, but might be backported.
+	 * Try to set xattr on socket to detect support.
+	 */
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
+				SAFE_FREMOVEXATTR(tc[socket_idx].fd, tc[socket_idx].key);
+			}
+		}
+	}
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/setxattr/setxattr02.c b/testcases/kernel/syscalls/setxattr/setxattr02.c
index 994ab655d..d85eb7246 100644
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
