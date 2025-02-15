Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308BDC021A0
	for <ltp@archiver.kernel.org>; Sat, 15 Feb 2025 09:18:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 493803C9B55
	for <ltp@archiver.kernel.org>; Sat, 15 Feb 2025 10:18:03 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC4923C9B03
 for <ltp@lists.linux.it>; Sat, 15 Feb 2025 10:17:46 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 67F6D142F304
 for <ltp@lists.linux.it>; Sat, 15 Feb 2025 10:17:46 +0100 (CET)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5e0373c7f55so791387a12.0
 for <ltp@lists.linux.it>; Sat, 15 Feb 2025 01:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739611066; x=1740215866; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=D3AYJOxCvaJ6VLEimQMLfNW99jr14bZD6XS4mbqheD4=;
 b=IZoOZej/yCYLTJEv7NEdR7jpr2u0hSWI/8f/ZpTkDx9qm3bThsWiOLKT8xALoVS961
 7faZHtl+ExTnh1bWtyEGJpBid1AAe9dCIpVoWL2PjYCNgfGCcvSMFe/KTPl5wz9uTWWN
 L+bJ/eJL2/ne7WDTLTcHhQr0nSVbwKlGlIckRvhfOqTbHG6Z1Q0OAhqfjTp3e4qQWsXM
 uj23kI5RMJtzrHulTHMCedZVW59z3LVUXrbmM9AIQC2dKltSl6gVIRfbvu+LbbxMobs4
 CxctycWiq6hz2jOjgyo7xqyHxLt6dZxLA48jq/SxnwENxKRscRNwaQiZytxL4vLlvZ7/
 PGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739611066; x=1740215866;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D3AYJOxCvaJ6VLEimQMLfNW99jr14bZD6XS4mbqheD4=;
 b=IeFkvdwLFAUSuySZeZNQSKB0g5DxadcByppRCV/ykhYvIZLRdlTlJ9ZwSOoCJprOD3
 E/3aTyyRiMZv1YC7AtOQ+QYjJqaZQPakMQwUPTuuPj1Yo2huICFgEBbqeeCTscHu7rZ6
 nhdRlUPgTwGBbNfkIsFARXE/RIb/1smHnSVlMRU4EvpCKd6Rnu1Npah+eEkJtkoNPyqW
 TVF3/ix23RfObBrreul0lB3wI5UOOi0+VZGSAqtCRTRw6QgGu3Nn0lrADVEMZ2D8BpHk
 1tljQ+SuTaffOOjHKGqbgrzQopUq+K442/pMhKTZCsdgSsJiFAbTmijWoXasGLCqSquK
 Pc6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPzs7omKQGUOzMXl+5LBsQ5YLQQxs4POojO8wFko4F2x3+5Jqs0Qvf9K0rOG6J+vbdu3Y=@lists.linux.it
X-Gm-Message-State: AOJu0YwQ2ia97FC+bLK1usVX+/dVNKLMDVIMiS6GucBvwLHA22CDFSpH
 z/ZyfrGBR7jwmdOb4ubtWT7gu0oQjDmi2cULTHLLYQAAUHturDZE
X-Gm-Gg: ASbGncsWx8ha/mXlc1gKvzdb9OxwwyVPM27nb+DFkYYa5hMGe9Ke3HsM/N77R5TAvcJ
 PETR8wWaEQFxUgu7vQ5kCvDCkyVmZvx8Dpd/8nytwhwETTyC4QEOTSyskHfwA3Z8RAByyOJ9BOv
 EAZYLyy9NoN2F85Ifc15anfLmMG0loPTCF2qwEWtyPjZ5WywmCc7V7dXXuPihjrRuAYw4GXAdA5
 CTyNHJ+KJi7aoZy5ADAR4dmsczclDuxkCdXdfEH6o4LfIPpkZzXiD60SlZOTFwRn1G2Em+x8owG
 okTVzDjT/l5aMRL5qsXm0RiQoFpeAosbsXDVuDQdZ0b2T9fHZL52tdKCDstiMIz2R/l17mwn07n
 XCuCwYZv7YGVu
X-Google-Smtp-Source: AGHT+IF/r298bJNINoEsVf0K3qUkSdBXd4651MKKkDO9uqfcR7ueF8z5SZZh8CBxyfnjOIbZxOA18Q==
X-Received: by 2002:a17:907:9308:b0:aba:6378:5ba8 with SMTP id
 a640c23a62f3a-abb70e53d76mr172653566b.55.1739611065347; 
 Sat, 15 Feb 2025 01:17:45 -0800 (PST)
Received: from amir-ThinkPad-T480.arnhem.chello.nl
 (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aba53376953sm503661466b.101.2025.02.15.01.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 01:17:44 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Sat, 15 Feb 2025 10:17:41 +0100
Message-Id: <20250215091741.400782-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fanotify01: fix test failure when running with nfs
 TMPDIR
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it,
 Rhythm Mahajan <rhythm.m.mahajan@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

If TMPDIR does not support mount watches due to ENODEV, the failure
to watch multiple fs would be EXDEV and not ENODEV.

Reported-by: Rhythm Mahajan <rhythm.m.mahajan@oracle.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 testcases/kernel/syscalls/fanotify/fanotify01.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify01.c b/testcases/kernel/syscalls/fanotify/fanotify01.c
index c7e759166..38f5a0791 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify01.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
@@ -375,8 +375,9 @@ static void setup(void)
 	}
 
 	if (fanotify_flags_supported_on_fs(FAN_REPORT_FID, FAN_MARK_MOUNT, FAN_OPEN, ".")) {
-		inode_mark_fid_xdev = errno;
-		tst_res(TINFO, "TMPDIR does not support reporting events with fid from multi fs");
+		inode_mark_fid_xdev = (errno == ENODEV) ? EXDEV : errno;
+		tst_res(TINFO, "TMPDIR does not support reporting events with fid from multi fs"
+				" (errno = %d)", errno);
 	}
 }
 
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
