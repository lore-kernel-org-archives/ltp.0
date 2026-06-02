Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594ADC5DF71
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 08:36:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D8C9E3E1F0F
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 10:36:32 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 763653D07B4
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 08:44:49 +0200 (CEST)
Received: from mail-dy1-x132e.google.com (mail-dy1-x132e.google.com
 [IPv6:2607:f8b0:4864:20::132e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 216FC204736
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 08:44:49 +0200 (CEST)
Received: by mail-dy1-x132e.google.com with SMTP id
 5a478bee46e88-304ddfcf72cso4970277eec.0
 for <ltp@lists.linux.it>; Mon, 01 Jun 2026 23:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780382687; x=1780987487; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=cwXTFTHjSuYaeIMpWvjf1HK1P/44HW025XcBnNZfVJc=;
 b=FJnuEMCH3KSIFJUsQzFPu95yFWay8k+R2dE4uhrnjzn/kBLKxlcIjZx2zbD9FGcCWT
 LyCZQi5gjTLcf1BQrjgrY6RPuVqkBIBzO72WT+gk25+aICNW+wLsWCEfxuVfO6Bhnog/
 mwnRP/N4JrKUanomcYZBoPZsJnqrpa62mZfOjj7qhk7u8Weds58e0SZJ2loELYbB1Osu
 qsHRDrK0oWiU88C9S1jrvJgdUiTo0PE8fJcNpIKFa73gSYZ+0wlI4HTL9qm0fPtJfWNt
 +II0fgYCqEATcXG80YpDpJB/7aZvD/7fqp63l+umabhSNMnOGJ9Kd2UXXg9Azw6/ro3v
 iWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780382687; x=1780987487;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cwXTFTHjSuYaeIMpWvjf1HK1P/44HW025XcBnNZfVJc=;
 b=itwJggXeqocIxsVfcNkFF8Pbs7MYGpqkK4cYlzW5CDqVBZTSQ3e6jzeOdkdmzzlx8/
 82SuHoR9MTY4OcE2jMTh3DfvBOOLxK2x1+B7XE4lapsIKf2CNl9hOmp7bca0fM2Gen8C
 ZTbFzHn80frvQH+yZFwjva1boWa7Ct+L8kvTrg5QpEydMZQVF8zdy5uYn+lxWv1cHsdH
 dOQx2XPZiX7hm6gxJcNUV4Y5evpd/uDFosvnjbsV+ixfPp6Fvf1+84wFMU5WotkAIhMX
 vb8khx5s2b0KzdGzFWX5evLuIr+EjPjqqmHhCPO3heBaRSWJhR8e7910kXe+aSiyMESp
 klLA==
X-Gm-Message-State: AOJu0Yx4JfCW0Eg4P4WF3n2ZDS07whYUuxqo43DbmesMvDzqROPqKyuX
 e4sc5uBSdboI8DgqKQASYGHcEq+t5WrqejLFmWfHWIzKfNTSwvD3TItlIRlMLw==
X-Gm-Gg: Acq92OFxJL7yvKi9CgoFDxkDOk+254u8xzvmcNr3ikhJgH6bsFx7PmPW/47x9YTV1gu
 hljPczkiLrOfAm6z9ffMo4r0DK4VGYoJRAqwiAMXTrhTAOPBRPLv4hg3wUkwA++01yzg31cfvMk
 ANpovrJZ7HfYFc5ojE8dpyyLvRPDL7VYc3MLI/UUziNILMjbsCdkd1nenvjQssPv3wWoUld2zRg
 E90B55a/VPJPSSnNneVnPk4WbLjvNf1EPhMk+M3UntteBIiS3NgycJnzEmXVe1pgsHIKT5QaWRs
 FOt1drMn3jpMePblJQaXnVpxfJw+eD0L5HXXxC7sMG73EMki5gDBMVhY756rMbqtcYckwFOrSmc
 KJlYNcUO80sFrVX68tujeJvDT53WiRdh8GLfdmVxtKD8R15bgSmyGLbBcwVYo+qMSJkY0cAiwaw
 2xvVy8T4ankqrFAqnfugMzsRNk3xh90BYeHAbeGN/k2uFVIHizej4=
X-Received: by 2002:a05:693c:2c86:b0:304:2eb0:2726 with SMTP id
 5a478bee46e88-304fa658e52mr6345164eec.25.1780382687364; 
 Mon, 01 Jun 2026 23:44:47 -0700 (PDT)
Received: from localhost.localdomain ([91.246.176.15])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5a9d27sm10743380eec.25.2026.06.01.23.44.45
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 23:44:47 -0700 (PDT)
From: XiaoLei Wu <wxl18715129466@gmail.com>
To: ltp@lists.linux.it
Date: Tue,  2 Jun 2026 14:44:42 +0800
Message-ID: <20260602064442.718507-1-wxl18715129466@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
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
