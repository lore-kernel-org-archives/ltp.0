Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D74ED3B7EA
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 12:30:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5DB573D0281
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 13:30:32 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 799AE3D0228
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 13:29:58 +0100 (CET)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 57F552009D3
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 13:29:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=yF
 NuYg/d4x209LljSc3rswSIPT6b4XJuFuLmZIe1FQA=; b=MNhgYKtlwHoWmsPlyy
 jYqdPoib8Z7Vty5N+H9M2MQfE0WjdHU0oonqnvcdPIkuPcg1DVHlI5OW1cbwtWOt
 xYiYWDKhUnFgMIVbX8RflsiHx90EK1lKcUPhsN9Wa7GhQS/jCDOPl8Gf5AKv6J1A
 xb1WTxQBob1GXQFRrCQjeeqt4=
Received: from localhost (unknown [])
 by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id
 _____wD3P0hBFjhpCXoWAw--.5772S2; 
 Tue, 09 Dec 2025 20:29:53 +0800 (CST)
From: simplemessager@163.com
To: badmailer@163.com,
	ltp@lists.linux.it
Date: Tue,  9 Dec 2025 20:29:18 +0800
Message-ID: <20251209122937.212641-2-simplemessager@163.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251209122937.212641-1-simplemessager@163.com>
References: <20251208150542.704006-1-pvorel@suse.cz>
 <20251209122937.212641-1-simplemessager@163.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wD3P0hBFjhpCXoWAw--.5772S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw1fWr1DXrWkXF1rJr1xAFb_yoW3ZwbEk3
 W7Xr4S9w4UWws7Wr1UAa4rXF1a9w18GFnYgrs3Ja4qkasYvanxC3s5ZFyxArW8K39Igwn0
 qas8XrWUKr43GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0uMKtUUUUU==
X-Originating-IP: [36.111.64.84]
X-CM-SenderInfo: hvlp1z5hph22hdjh2qqrwthudrp/xtbC8AH9lWk4FkHslwAA3k
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] safe_keyctl: Skip with TCONF on EOPNOTSUPP
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

From: Petr Vorel <pvorel@suse.cz>

errno EOPNOTSUPP is likely a configuration issue, skip testing
with TCONF.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Mingyu Li <limy83@chinatelecom.cn>
---
 include/lapi/keyctl.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/lapi/keyctl.h b/include/lapi/keyctl.h
index e08b8f132..eac9e2609 100644
--- a/include/lapi/keyctl.h
+++ b/include/lapi/keyctl.h
@@ -212,7 +212,8 @@ static inline long safe_keyctl(const char *file, const int lineno,
 
 	rval = keyctl(cmd, arg2, arg3, arg4, arg5);
 	if (rval == -1) {
-		tst_brk_(file, lineno, TBROK | TERRNO,
+		tst_brk_(file, lineno,
+			errno == EOPNOTSUPP ? TCONF : TBROK | TERRNO,
 			"keyctl(%d, %lu, %lu, %lu, %lu)",
 			cmd, arg2, arg3, arg4, arg5);
 	}
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
