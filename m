Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64670C5DF71
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 08:36:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E4683E56BC
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 10:36:03 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D583C3E1762
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 08:14:48 +0200 (CEST)
Received: from mail-dl1-x1235.google.com (mail-dl1-x1235.google.com
 [IPv6:2607:f8b0:4864:20::1235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 39A741001585
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 08:14:48 +0200 (CEST)
Received: by mail-dl1-x1235.google.com with SMTP id
 a92af1059eb24-137dd3af345so1957514c88.0
 for <ltp@lists.linux.it>; Mon, 01 Jun 2026 23:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780380886; x=1780985686; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=cwXTFTHjSuYaeIMpWvjf1HK1P/44HW025XcBnNZfVJc=;
 b=hch848jqL7Tb31BR1/RUNqNXR+zHEvDtvUsCNara4IgHeLyrDhEwpXt6BcaZ5ypy25
 ZHdaJHcSOYqbX8s6JoO/Y/ZTrO8wLbvKJa/Bi67jIy3YDrpSUVw7E1dQWwrTNONoz+ra
 zKBOKun4YzNOHv/qcIsdGLKimawMB071u93qCBmtcn3oUtwMlP7GBF38TTCYREJaPd+E
 0I5/p5vkawCStfY8L2VvYqj0pM8Reyj538639MbTPieOkFROmKQzKNfaX9E7jGjQWxdF
 UhTubPHQzRjnB9swRzk8y4iEdLlj/+asBFHFGXInumCQOTMbB9DthzEKmeH9RsR8T2jC
 1Jlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780380886; x=1780985686;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cwXTFTHjSuYaeIMpWvjf1HK1P/44HW025XcBnNZfVJc=;
 b=WRLzQRj1YXJvzoult2a34UIvDQPBfCOEwW6q2n6YaVOzZCHu+vhcPBPOW+0ejKRFuR
 PHau+qWecCAmLyVz7EjimxEzMlTg5IyG/zh9w9mRrTJcwMHVzrlVMveo6tDtDOXW7V2V
 FwAIzl2y3uDLoJualF031dbX/Ah5fuoZzbsE5lwSdqUFodYZT7Q3C2OVDoTtRR5ZPdk2
 NCkgV8vv63cHvP3ooUC2LKkmveXn/WIZWaRUT/9Gt2Cy8WMpycQTVxswpPMLQRqfZ20z
 AJR56xL1uksmWgaAn3/6bNyMYqQ3mCcUNaYWbZ3gUUALGxoJxckx1W7NHRGFreX1BnPt
 CocQ==
X-Gm-Message-State: AOJu0YweCQkBFHOJDn0S0G8JIg7egqSNwhI7/MtA+dDU7cvK+6Bti1tg
 Zxjh0hLSdhhqPhq30f9I07ghLXMygxkJ7MluzgYEPz+mgaglOLnGbePJiCQyzQ==
X-Gm-Gg: Acq92OG+EIHBvdCrttIlzoBmmSQ0aEAePBeEfuTsFX14ywxEMFVBhAAhO2P2tA9ZC18
 D/Z4+yN6kFkN1MzakqhD92JfiFunEay6BPuzxaLrYsTQ3bYL+CoLwnjW0JgcbIfcMJvXnrojAqh
 jP+s/nY4ZL8nbdgH18fANMWQnn38+kbugE/M2Ink6kCXGUJROvrlzLPj1TBKrtXL+GXGsFlq1Jx
 I88wgnUvv/dGuwx5HXE8r8NM96mAnVGK9U/XlPd9BZFEEkgHE9HPlXyDSSHNQQkvfd+Eq3u0HVd
 dDrzqkkn+ya2F+sAKa58fsC/3pxajKM0tpJgg1oHSgDLqDhPaTAC9JqsPMRVdl3MX1VW5kS870D
 C3Q7nL+Gq0IYMIvN6KMHanS04liYtPSqf7BoFpBmV3WLonvizwTC+eIVtT7c4Ry9EwTI8et+qhy
 qmN2nVIlDNNJcvHO49sOumn8ZizNrZT58dxMCDyjIkchAj+fJYc5A=
X-Received: by 2002:a05:7300:3252:b0:307:288b:c05c with SMTP id
 5a478bee46e88-307288bd6f7mr2915126eec.16.1780380886363; 
 Mon, 01 Jun 2026 23:14:46 -0700 (PDT)
Received: from localhost.localdomain ([91.246.176.15])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ee0dd8e1sm15026903eec.21.2026.06.01.23.14.45
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 23:14:46 -0700 (PDT)
From: XiaoLei Wu <wxl18715129466@gmail.com>
To: ltp@lists.linux.it
Date: Tue,  2 Jun 2026 14:14:41 +0800
Message-ID: <20260602061441.718227-1-wxl18715129466@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 02 Jun 2026 10:35:48 +0200
Subject: [LTP] [PATCH] syscalls/unlink09: report unsupported inode flags as
 TCONF
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

If FS_IOC_GETFLAGS fails with ENOTTY, the filesystem does not support
inode flags. This is an unsupported test configuration rather than a
broken test setup, so report TCONF instead of TBROK.

Signed-off-by: XiaoLei Wu <wxl18715129466@gmail.com>
---
 testcases/kernel/syscalls/unlink/unlink09.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/unlink/unlink09.c b/testcases/kernel/syscalls/unlink/unlink09.c
index 10d4e8a..c9f6041 100644
--- a/testcases/kernel/syscalls/unlink/unlink09.c
+++ b/testcases/kernel/syscalls/unlink/unlink09.c
@@ -63,7 +63,7 @@ static void setup(void)
 	if (TST_RET == -1 && TST_ERR == ENOTTY) {
 		SAFE_CLOSE(fd_immutable);
 
-		tst_brk(TBROK, "Inode attributes not supported by '%s'",
+		tst_brk(TCONF, "Inode attributes not supported by '%s'",
 			tst_device->fs_type);
 	}
 
-- 
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
