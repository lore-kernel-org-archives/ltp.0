Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E9BE9A04A
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 14:16:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 703703D0763
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 15:16:34 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD7ED3D074C
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 15:16:00 +0100 (CET)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 219EE600479
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 15:16:00 +0100 (CET)
Received: by mail-pg1-x543.google.com with SMTP id
 41be03b00d2f7-c47ee987401so506830a12.1
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 06:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771510558; x=1772115358; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LmnTKqp518mHBRJV0XocbgkdVlJqSy0jovqoLDrJxj4=;
 b=emmdlohr3nEtBffhTJrcD6s0bnlFTk+a0FL16s3S2dAEX+6rIpeQIDlLp2MW35QEmc
 U2aHMHWHGYUi7UVDPw4+RX83zhjnhwNYw1D1f+xrcNqj2GrnkC0VzGa1oHeKUlLpiuf/
 6qzuaEtSmV86lz0STumHHL1Jh/iy++vgNNprRRy1B7rZ9R9UHP7y079hxyT8lsJgUz5i
 19ocJICGnnxOQQ/GQsON4sKPwff7irPnuSX/O0IC4ACLmZ6kIl19+aFzseuCRFGLOaTA
 ntSjmLubiWW0giJlgQDwUtkybgncO5z1TuhO04nlkn+xnPiFXbhvn2oD5EW1jDKMMhSc
 0cPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771510558; x=1772115358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LmnTKqp518mHBRJV0XocbgkdVlJqSy0jovqoLDrJxj4=;
 b=J3zVyyaSutI4uzLDcmpQNkm8/AtXg9b3qrihwDlaHYGsmiz68Bq0gxIwChOXr2B7E8
 reM8CPclDmklWCm5SoukaJ79NxA6DqLJjnDiug0HAIkwOOLnNrTiFroK6tg/aetxbmXZ
 O+OagWwghOnqI9rftVezG8G9+wyBbKURSAHHILhz3EQOl7IcCmnh/nKZMG58uKjFGBYN
 RG2pfViOe+6f6ZCLPNo2/z2/Pylqvko5lyMyAggGrbTn4Gj9d7O2XzS2vZE6uftXNfvI
 sNf318OFGZ2abYtK+egp23RwPR/DIb5ocoaj+HxlFORV6lMNx7OwiC4hAEX5GZ0wumOO
 6P2w==
X-Gm-Message-State: AOJu0YzasoQi4bBqGbTP6BCV8BH/+3EektaxnEGn0cvTxcB0cCZhGRbF
 YtXbW1OM0XItqMs2pqkbdCisbEzqq8LwB+Me0j1i2H+lFgyqpM+2VoYXOmFuIkOOcw==
X-Gm-Gg: AZuq6aKVE1f2OCs6bkr5X26uWXyJmOdHflYcpgGXkCYJ0cz+4TFLS4FRPcBzGF6Ctnp
 7vjyH8yoiroIij30UNkfhSCOu0t4EDrBK9kInN479b6gQ4HsS1dj+WpTfRNGOsANEn+yul7y5HE
 OAk3OhynSqET3AYl2Bde5DNymkvaG6J68SHjBNvfs60J+gk4teYTZvODjqa4jlxyZO4+HpNGwwZ
 v3iEaNnJlEGSOlgN6Ox9Q1fSfC2Tryd6yFFTUlVsAwtVMG0P3OyROgyTjhDlZ4yjSsR+qw3ziNB
 cvtHX5wTyKgB2PsI+zPfTF5A8ip/LbcnbrbznZCP24mvvKxQFlF/Yowa9qiIDeljEbFLccs4o2n
 LPBuGjmFSFhjqz1h1iAb092CldgyBaIPcGdPYtTv8+TmB6L648+9KCklLunA1ovRb+KBahw0WzM
 YVD73m3i4AKTbIGOWKgZcmrqYNNTCMc11dYRSelvERFw==
X-Received: by 2002:a17:90b:288f:b0:32e:2fa7:fe6b with SMTP id
 98e67ed59e1d1-3589855b763mr1549015a91.14.1771510557983; 
 Thu, 19 Feb 2026 06:15:57 -0800 (PST)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3589d80cc18sm298022a91.3.2026.02.19.06.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 06:15:57 -0800 (PST)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it,
	andrea.cervesato@suse.com
Date: Thu, 19 Feb 2026 23:15:18 +0900
Message-ID: <20260219141532.6513-2-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219141532.6513-1-always.starving0@gmail.com>
References: <DGIU5TUBY8DA.1O11NEVRMZTZK@suse.com>
 <20260219141532.6513-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] open: replace getdtablesize with getrlimit
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

The test currently uses getdtablesize() to determine the maximum
number of file descriptors for the process. This interface is
considered legacy and is not specified by POSIX.

Use getrlimit() instead, which provides a well-defined
and portable way to obtain the per-process file descriptor limit.

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 testcases/kernel/syscalls/open/open04.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/open/open04.c b/testcases/kernel/syscalls/open/open04.c
index 152bec2d4..9c5634ba9 100644
--- a/testcases/kernel/syscalls/open/open04.c
+++ b/testcases/kernel/syscalls/open/open04.c
@@ -11,6 +11,7 @@

 #include <stdio.h>
 #include <stdlib.h>
+#include <sys/resource.h>
 #include "tst_test.h"

 #define FNAME "open04"
@@ -23,8 +24,10 @@ static char fname[20];
 static void setup(void)
 {
 	int fd;
+	struct rlimit rlim;

-	fds_limit = getdtablesize();
+	SAFE_GETRLIMIT(RLIMIT_NOFILE, &rlim);
+	fds_limit = rlim.rlim_cur;
 	first = SAFE_OPEN(FNAME, O_RDWR | O_CREAT, 0777);

 	fds = SAFE_MALLOC(sizeof(int) * (fds_limit - first));
--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
