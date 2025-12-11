Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE2AD41C04
	for <ltp@archiver.kernel.org>; Thu, 11 Dec 2025 08:13:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4941A3CF21C
	for <ltp@archiver.kernel.org>; Thu, 11 Dec 2025 09:13:00 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B69EC3C00B3
 for <ltp@lists.linux.it>; Thu, 11 Dec 2025 09:12:25 +0100 (CET)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0E59A60087F
 for <ltp@lists.linux.it>; Thu, 11 Dec 2025 09:12:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=e2
 3s4UY3Db581AbApK9/b/nHdRr5n//ErYKnNGa2Urs=; b=MB3hihDANgpV1ikIzQ
 afnbuB2NwyhPI/hzo/8ZIFa7JvLN8cmdMzhxdzHBAofDe/EAygtPWPKRBNeogGVc
 bXFTLyLLlug6kCYzMctwFFNn4n0gj6HQgSHOnbHNueROIv9u3v5uTYyyE4O1Ojk0
 i6425aik97F9uclVLFi66NJnY=
Received: from localhost (unknown [])
 by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id
 _____wAX13zkfDppHPUKBA--.1029S2; 
 Thu, 11 Dec 2025 16:12:21 +0800 (CST)
From: simplemessager@163.com
To: pvorel@suse.cz,
	ltp@lists.linux.it
Date: Thu, 11 Dec 2025 16:11:30 +0800
Message-ID: <20251211081205.342673-2-simplemessager@163.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251211081205.342673-1-simplemessager@163.com>
References: <20251209195328.GB24146@pevik>
 <20251211081205.342673-1-simplemessager@163.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wAX13zkfDppHPUKBA--.1029S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw1fWr1DXrWkXF1rJr1xAFb_yoWfJFcE93
 W2qr4S9ws8Wws7Wr1UAa4rXF1S9w18JFnYgrs3Ja4qkasYvanxCr95ZFyxJrW0k39Igwn0
 gas5XrWjgr43JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0No7tUUUUU==
X-Originating-IP: [36.111.64.84]
X-CM-SenderInfo: hvlp1z5hph22hdjh2qqrwthudrp/xtbC7wVB2Gk6fOWzHwAA3V
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] safe_keyctl: Skip with TCONF on EOPNOTSUPP
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
Reviewed-by: Petr Vorel <pvorel@suse.cz>
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
