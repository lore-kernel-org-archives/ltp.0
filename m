Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362C7CD5BD1
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 16:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780332842; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=+x3xRDhhsGMx9edttPSrw3yru47rGPYiYxyhXM5uTfI=;
 b=TKbb1+SZX61Gn5SmFCfvTFmvbCsRydooQnoVGHLcgNtC7R8PPDepb/vkoeFIylOauJEOZ
 zVsLfvfS1yIDmKtY9ZuoUe7LjRBLs0J/o/3C8EYvl8rbE/ahYZYMPpwQaH83Ep3HOwm4m/a
 pN1ktwHHWcuO7ibh0L5AIZ4YnBH+R/M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B42103E7250
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 18:54:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2FD283E1739
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 18:53:43 +0200 (CEST)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com
 [IPv6:2607:f8b0:4864:20::44a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8876C1A008B1
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 18:53:42 +0200 (CEST)
Received: by mail-pf1-x44a.google.com with SMTP id
 d2e1a72fcca58-8423770d72dso2428636b3a.3
 for <ltp@lists.linux.it>; Mon, 01 Jun 2026 09:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1780332820; x=1780937620; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=qjesdXJqJleHk23+juoVt0uid+hVLhVuBjxYZeHGyXY=;
 b=K900MRa+4W5WjP8QgmDAZsZS2AnOVqyKgkKiFVdNHJFu0aYjiIaCdLpBz4EHe/4e9T
 +wvvCBF/atITM/yHOPgNtTkd4iAcjqtV7C/AKNMxhKUXM/gzcKBQtZS/lIdNl+L6XOj2
 aqDVVKEmNEU77yryjYYiV6vGs+EY6xuktSi7XPMKzq0BpBYd1Lxhje8gvrJ7CvNet6m5
 tdWzO+6wBo0MQV9VeFdarM4ibjtEYeDUJ0/P9DJ6DR+1VgzJKHWJv6dv2R+7Seu9asAm
 2nYTOWh4gRO6fa+BvYLCAelg0a3Lsiba3iq4CwWw83C43e/adHAVrOT2wyVGU4Pn2ysp
 E5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780332820; x=1780937620;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qjesdXJqJleHk23+juoVt0uid+hVLhVuBjxYZeHGyXY=;
 b=V6DHD7wgWZw+cpVk1Z9+GWT52i+uIkpjHQxyq7SL+9U5wwr7i+xd5MB8YRHa+ct0Xp
 VjkLSTFjCQo8qvus6Ljbp9ZHCIwwFOeRN0+UbL6ZC1tdseNatGNFBUQsGF5diQoDryom
 5USFpP+iYFDkS+wcYbDSRyHf8VNNTkBUdwgQB3vq7500hxvqx1DgUXaauV5RlsBOWqvc
 KNaXpDitqkaslV+vm2D4YzhkVLkHwsaPEHM/d9jd9qO9dEw676PeRfRULwYSl84zkknU
 cN00aU4KHGCOgIvRah+aYIs+JrjWVF7ME/cOlthJ6StNvHnXAeV2050CCIQ6LmHmpmvM
 M0+A==
X-Gm-Message-State: AOJu0Yx/VdVdnJhf8HpAM65ABhIPC5J0d+31SN5aJ9ROOBTsyy2zyDSV
 Z/4p/OAeah0yB+ETbnqXXHLtWFtaECo6DeyBXzWuh9WOD7e3bkcTYQKCtgg3BJt+HjC1mOc2pgZ
 ZsHGg9pVedNiofm/HoplnDyjUxkQO9RS7p71rQGl1QHfmvE4gd+semI4i0ey+OUf3BkuxNCfdJa
 yPmmxiLRzdR4Xnovu8LDP9xVlUZIoFfJ5q1sO5oLDK1ZZLAHU=
X-Received: from pfbby6.prod.google.com ([2002:a05:6a00:4006:b0:83e:d99d:7c4b])
 (user=chihsheng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:440c:b0:841:dc7e:5876 with SMTP id
 d2e1a72fcca58-842256df467mr11399615b3a.44.1780332820159; 
 Mon, 01 Jun 2026 09:53:40 -0700 (PDT)
Date: Mon,  1 Jun 2026 16:53:31 +0000
In-Reply-To: <20260601101302.3858362-1-chihsheng@google.com>
Mime-Version: 1.0
References: <20260601101302.3858362-1-chihsheng@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260601165331.4077251-1-chihsheng@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] syscalls/xattr: Add runtime probe for socket xattr
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
sockets") was merged in v7.1. Currently, setxattr02 and fsetxattr02
strictly expect EPERM for sockets on kernels < 7.1.

However, downstream kernels (e.g., Android mainline branches) often
backport this feature to older kernel versions (such as 7.0). On
these kernels, the strict version check causes a false positive failure:
"passed unexpectedly".

This patch introduces a runtime probe in setup() for both tests to
detect if older kernels have the backported feature. If the xattr
syscalls succeed on a socket during setup, we assume the patch is
present and adjust the expected result to pass.

Signed-off-by: Darren Chang <chihsheng@google.com>
---
 .../kernel/syscalls/fsetxattr/fsetxattr02.c   | 26 +++++++++++++++++++
 .../kernel/syscalls/setxattr/setxattr02.c     | 14 ++++++++++
 2 files changed, 40 insertions(+)

diff --git a/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c b/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
index 2a48b7da7..1b4f8e819 100644
--- a/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
+++ b/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
@@ -209,6 +209,7 @@ static void verify_fsetxattr(unsigned int i)
 static void setup(void)
 {
 	size_t i = 0;
+	int socket_idx = -1;
 	struct sockaddr_un sun;
 
 	dev_t dev = makedev(1, 3);
@@ -245,6 +246,31 @@ static void setup(void)
 	}
 
 	socket_xattr_supported = tst_kvercmp(7, 1, 0) >= 0;
+
+	/*
+	 * Commit dc0876b9846d "xattr: support extended attributes on sockets"
+	 * merged in 7.1 mainline, but might be backported.
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
index 994ab655d..167e068cf 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr02.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr02.c
@@ -196,6 +196,20 @@ static void setup(void)
 	SAFE_MKNOD(SOCK, S_IFSOCK | 0777, 0);
 
 	socket_xattr_supported = tst_kvercmp(7, 1, 0) >= 0;
+
+	/*
+	 * Commit dc0876b9846d "xattr: support extended attributes on sockets"
+	 * merged in 7.1 mainline, but might be backported.
+	 * Try to set xattr on socket to detect support.
+	 */
+	if (!socket_xattr_supported) {
+		if (setxattr(SOCK, XATTR_TEST_KEY, XATTR_TEST_VALUE,
+			     XATTR_TEST_VALUE_SIZE, XATTR_CREATE) == 0) {
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
