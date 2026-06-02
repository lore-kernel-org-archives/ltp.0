Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDDE1C5DF71
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 08:36:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F94B3E30C3
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 10:36:18 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E51F3D07B4
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 08:41:24 +0200 (CEST)
Received: from mail-dl1-x1231.google.com (mail-dl1-x1231.google.com
 [IPv6:2607:f8b0:4864:20::1231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4CB5D10007EF
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 08:41:23 +0200 (CEST)
Received: by mail-dl1-x1231.google.com with SMTP id
 a92af1059eb24-137e75bcb5eso2465676c88.1
 for <ltp@lists.linux.it>; Mon, 01 Jun 2026 23:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780382482; x=1780987282; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=zfO2OTfOXyTjtsYx6r1MJnJB5NQZLCMDADZFRPE+bcQ=;
 b=DV7nngvXL8+ul7UYivNqiO1l6vBUw9tBMtI19LgOEB3qjetWLazEYnlekYS04wgs+i
 w2ehMteDZ1HDyfccW2taxeh7dO9qbJFZCAWx0swv1yX85KXzVHYbbfenCZB1BZ5r0XUG
 9Fs+vrIi2GUIeECJtVbaP4oIPc0xaISFUVSdpID6K54gkdw1PCRTIhjxkyMUHPEZww8O
 yYtbMWvzoadlgQRPagOTvGyzB7/ZmUhfn9gvQQ3Rr37EzWIeUcDA7bjCaWpWbytdbxzF
 tpTrg9NSk3blo8ARSJx2HtB2eFlTX7hSa4p8lJnpemdNqhuf81+7B2KsQjIqyFpiuIJe
 xVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780382482; x=1780987282;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zfO2OTfOXyTjtsYx6r1MJnJB5NQZLCMDADZFRPE+bcQ=;
 b=LFKBLzktgwWLCu3XCrUmdqDw6bYHlvDOCRbqcuIC/4IRIh4x/olJPDA9m/qs2SMc7O
 EAsIuhtLZX32dx9rTUeQvWb8WNawytouEaOKGZpGq7ptT9twPsMIj00dvURHsZAO2+hm
 kR5PA1JAbBlFvyQmBd3GFtf4RIuoDYV/+YMc7eJkTJM0C/wxFFeqcRrv78vkn+nYwXDq
 csyB07JHfFfPveTrURDXsJmF2TMMEkHW8qR6DYHAcb35ErU9JV7eIdGv3R9yHUzk0cEE
 W6ttCuFlAV0oUqOf22wCIehCWDyVK/qMbfLF92AS+FASH01rZZflsmXuocxZ5bwV1rDK
 /7AQ==
X-Gm-Message-State: AOJu0Yy8uHzjzxT6OsTDkomtCbcdjSWWUFVSnjwHcB6SHFyaL2m/Sbw2
 bfSOEG6Xk/Cii8PQOwv8qq6r4TztpiFasVk2rZWwfR8l6gdmp+WbPkQeoMlHhw==
X-Gm-Gg: Acq92OHTnHAltszoQ92bmEqPlGlPuYwlObrFlsb9WIVZhogTdTl5QDTvyHCqskx50KR
 UetzW2nOYG2x+YBKRqyQ0VU5KebSqzNIm0TW84/vqiOkzv75mEn1IyagzpsfEx3NkM6yo0KBVBM
 lpMusWqKmNosQ92vq59ujWnm4Y1Y8HR5nttYmgPyRqU1+05v54OIMr8ZrKqItquoUdNSRaeZh0/
 zqbP5IAsdTSAq/zJKieSuw/fyhy60d+NzUXCvLjCvI6JxEUAoMkoYmL0H7gbBE7xWax7pL4XM+w
 MumOb+P5OZovHr0egzNO/5aU1zhxYnVDpAAJJRgod2A6CgjKLjrsG4+Nj1WwogAwKiMDi0Vlxbh
 PZhCbG3rJ7qYjzT38f1+dDSP5NucEuT/SCTgEzuqie+TGHGF5R9UW3ALxPyTKYbQnPFNJXAlAH1
 KchoR2YKvC8js58txTQwmuxj9FAExqJkimggO5kCrE191SpIt3dx8=
X-Received: by 2002:a05:7022:b99:b0:127:33e0:ea44 with SMTP id
 a92af1059eb24-137d4284c55mr6606220c88.29.1780382481597; 
 Mon, 01 Jun 2026 23:41:21 -0700 (PDT)
Received: from localhost.localdomain ([91.246.176.15])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed30a012sm11379072eec.10.2026.06.01.23.41.19
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 23:41:21 -0700 (PDT)
From: XiaoLei Wu <wxl18715129466@gmail.com>
To: ltp@lists.linux.it
Date: Tue,  2 Jun 2026 14:41:15 +0800
Message-ID: <20260602064115.718468-1-wxl18715129466@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 02 Jun 2026 10:35:48 +0200
Subject: [LTP] [PATCH] lapi/fcntl.h: fix O_PATH fallback on alpha
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Alpha uses 040000000 for O_PATH while most architectures use
010000000. Match the alpha UAPI value when O_PATH is not provided by
system headers.

Using the generic fallback value on alpha makes tests pass the wrong
open(2) flag value to the kernel, so file descriptors are not opened
with O_PATH semantics.

Signed-off-by: XiaoLei Wu <wxl18715129466@gmail.com>
---
 include/lapi/fcntl.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/lapi/fcntl.h b/include/lapi/fcntl.h
index 55a5e8b..6a9ef11 100644
--- a/include/lapi/fcntl.h
+++ b/include/lapi/fcntl.h
@@ -137,6 +137,8 @@
 #ifndef O_PATH
 # ifdef __sparc__
 #  define O_PATH 0x1000000
+# elif defined(__alpha__)
+#  define O_PATH 040000000
 # else
 #  define O_PATH 010000000
 # endif
-- 
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
