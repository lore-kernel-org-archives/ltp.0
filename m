Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC4CC87FCB
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 02:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753929320; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=guJ9Xs4GUgXOzgzRayFp4YKBiZsCWZ+WZtaZ93J8te8=;
 b=Z7ISEGj6mXWnJIbxxHhWtirJnRqn+bFAsKPuPT/PmE/i1NF4cBDCWoW1Jwp60imHRXLUG
 rlJOvG/lGkHIE/r2yvbAl+EcypTiRaS47rROFbF34TJWVnsUF/AU/7lBqrRM9Q3mj+7AoB/
 i4odnBS9P6VtSLlLE/tl1cF95TeIDH4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BBFBC3CB0C4
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 04:35:20 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 89C923C2593
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 04:34:58 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AACC0600878
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 04:34:57 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3b783d851e6so414112f8f.0
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 19:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753929297; x=1754534097; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SAYNZLYeH9YMnvUWLcdP0Q6o5Rt4aJqFABg+bIxrA8A=;
 b=Eni3Zb9w5AsvSJV7gSyaTnxXSF2QP/OpkxdO1zFj7pTy0MmR9KO0ARI5b7xmv/Z0gb
 40ScBQAwN65F8rePpgYnq4kAoSucablBi7j4wqnZqMNlaKVzM+7VH4zUL39ScevX/ybT
 CApVmJJGYCMWeUpMIM89W4kYM3VVyoAFIQzy5o/nN/LQasvgnGycUgYrd3ZV9zhtrcLZ
 2SGZjdIqMEop1aZyNskxuJfTH3lohLrHFfPMe1pK7Bq96jaSxXUv62aL4W+Qfzu/n8I3
 5BVX3IQx27xrNzQzfQ9EitGPpIpaPNFejG+IaajcU6v/ph7dNBM6GgB+ke7sDsO0tU+b
 q/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753929297; x=1754534097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SAYNZLYeH9YMnvUWLcdP0Q6o5Rt4aJqFABg+bIxrA8A=;
 b=FMHs4gLvjaFw4EkCK6Bk2MC+tug/xzsedERm2n8hXD2hxmmF4HK5YOlyTjzP1TBQNQ
 z2dhdRK01c1y+P07zEQeZ+P/rLXMpa18tmTVqOfe3NnRHN7LVefvL0xwJIgiBfPceRac
 IHR4V3t4Xx2iTNIoywBSIqGBI0sTUdq2/1R39w58wg1dX5Jr6EEN9jVBsOnA03wuOhHW
 otHvF7EjSePoeDKsb/H//2q19hDaNJRKUWc9YEavfl8387uqfJtFpXb5w/mGNNwtc8oZ
 dmS9slSxzqIHtOyxHbT15yGt1Dg8V+QDC0vfoD8F+B0DG+S56X/7wFUOE7u4xq3wjrzO
 uUsA==
X-Gm-Message-State: AOJu0YwmdcbM/l4ShSa6lmAOHDJl3Ci/E4eOCDdalGSKo5ex4IutpvqN
 l0w6Eb3vWNj5L3Wz5BMRTDWwgTybou8CjYPNDg0jZG5RqWs+vDYjgDgnThbluIol+Mi7RBtREjE
 xsfg=
X-Gm-Gg: ASbGncu1vlHn2j4Ve0DlaVBVznhxcO/pTmcJm5X8pCJ1eNB5Nv6+MjckhXztliQLMwN
 KlgikIo+phtb6eo4xKnbGE32yNbYMYghpL5WuBATUkzVnNmnn2yMrqvj6dpG4nnIgkmmFtcorVu
 bA7I+eVB2bHQfN+JB8LI/DfnnvPjfPSofcgiq4lzo6U6YUzpV1u+UcJEt/as7Xd3/vnb9hZAhg5
 eah//SP2SqvfAH1rFCWrDwCuZTD5BTtkJNvbXq5xlT0eB7UPpNTNlx3J1tmk1RdXdep/W8k11ce
 M+utQG46lZmAoEhAI8aS1wWmR2fshb9wnwi5dvPFa6jeJQZ5i1WDK/5ttVYJDe/J/XkkX+KXB4r
 mDD8jZY9/n5M=
X-Google-Smtp-Source: AGHT+IGdcoGZi7qPzhV4ON6hMU55h1bsDLsQls51Zr/e0X++WJOO7lZPsRsdg21kDA7dDXoMJlizJw==
X-Received: by 2002:a05:6000:40e0:b0:3a4:f038:af76 with SMTP id
 ffacd0b85a97d-3b79501d7d5mr4806607f8f.53.1753929296940; 
 Wed, 30 Jul 2025 19:34:56 -0700 (PDT)
Received: from localhost ([202.127.77.110])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-b422dc7cfe9sm158051a12.17.2025.07.30.19.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 19:34:56 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 31 Jul 2025 10:33:46 -0400
Message-ID: <20250731143358.1035685-1-wegao@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250728212752.774436-1-wegao@suse.com>
References: <20250728212752.774436-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] mount08.c: Check EACCES error when test under
 selinux enabled in enforce mode
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

Test case expected ENOENT but get EACCES when selinux enabled in enforce mode.
This patch add check errno under selinux.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/mount/mount08.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/mount/mount08.c b/testcases/kernel/syscalls/mount/mount08.c
index e2824ac55..d965094a1 100644
--- a/testcases/kernel/syscalls/mount/mount08.c
+++ b/testcases/kernel/syscalls/mount/mount08.c
@@ -16,6 +16,8 @@
 #define FOO MNTPOINT "/foo"
 #define BAR MNTPOINT "/bar"
 
+static int exp_errno = ENOENT;
+
 static void run(void)
 {
 	char path[PATH_MAX];
@@ -31,7 +33,7 @@ static void run(void)
 
 	TST_EXP_FAIL(
 		mount(BAR, path, "", MS_BIND, 0),
-		ENOENT,
+		exp_errno,
 		"mount(%s)", path
 	);
 
@@ -41,6 +43,9 @@ static void run(void)
 
 static void setup(void)
 {
+	if (tst_selinux_enforcing())
+		exp_errno = EACCES;
+
 	SAFE_TOUCH(FOO, 0777, NULL);
 	SAFE_TOUCH(BAR, 0777, NULL);
 }
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
