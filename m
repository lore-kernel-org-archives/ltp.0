Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE8ACD5BC9
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 19:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779735715; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=XtFGAt5tZ9AU5SoaO+spXUoHyWmty1lFOXH6+ZPufFc=;
 b=AdbqRWDBt63bJ2HQwSgx1gaYW4FtPqA93BqXNmpN1gxr/h3kFQkYEPjTEwMgqlfDrwIQE
 iXpZF1+F2f4siU3uIXxNkoI7e3LjJAsNOsEQ+nxV6MDADahMNlTritRx4QmiAtK2ym5he2m
 ZblYxWeW+aCiBEGhHMzz02XwivgabF8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8DC383E5294
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 21:01:55 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 13C6C3D56E0
 for <ltp@lists.linux.it>; Mon, 25 May 2026 21:01:31 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6D42C10007C1
 for <ltp@lists.linux.it>; Mon, 25 May 2026 21:01:30 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49039a8851fso42268835e9.2
 for <ltp@lists.linux.it>; Mon, 25 May 2026 12:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1779735690; x=1780340490; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=DLZK6hTSc028rfmsOy0YUeReTlFPEvYNNfr2kMj7KXU=;
 b=U+eI1yegjQCN3QS0zjDHHr0mQOoVuKX1zSUfeolQP1idsaAWsDMFACeMdLBFQBR6X9
 mVQFEdWmps+PfIC2vTcKKYiTyTu+XoiJG1l2WbbA1pbOoSeWTzDvITDhkKjLLTleLY4r
 DRQpPPI2qPIdpPXM4gr6yZF4yo2HXMQwCLkd5/ITqaScszYYcu/nRZVIcF9Gutnvv9V2
 qwIWIDyZNzuhc1YYCFUppi3IdT1vq6HiAXEO7j6JqoeO8ME0Y1BV1aESzyuTrpw8FDzC
 e9KwoFQwamPJN+X37mbp//wYdUpr1o8yujGDMVFGDZVervQngSbOB4vHxbvPjWO4fbBY
 z0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779735690; x=1780340490;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DLZK6hTSc028rfmsOy0YUeReTlFPEvYNNfr2kMj7KXU=;
 b=OC5zEAtQiIcPDD9kiYECDXFXpSF8sfxfGU9/F4XpvetfpIDtmu6Y/qQiGE33Ed7n0H
 MEf/9DtHg/ANDdCAEnmFb/HjkTmhj9Y0STleyNCXAVjf/bLJioeNGkx9sa2CKbeTGmQh
 mScS60DB5e8FukjEQdpLkvj07UKl32G+m1PKMcwDKEGriWEW4pAUy186UjoTh1O1JOjM
 KWMqwDmMV1mR2HkUjU0iOaoVa+z8qBhjZW/31vJp4zEQtSDgLPJqdW0mfYQ0qL593Rl2
 tYuW3FyjneEsaYTKqZO7SG7kaZaCy1Oea5M0KrGxYhAnkzQvym4fI8g3J57c2NBL0gLZ
 CjwA==
X-Gm-Message-State: AOJu0Yw8Q9cYT2AjWABSjOX/7ZmOj4zRrXYexHQSi+mEQ56hHCX0UdXh
 KDoP7r6vcddx+HyXp1lKDnDgxVgWLs9Yoyy6TmwuaSlo/nvl2KgfTDY9eiDjgFmMhE+MB7A3HAM
 i/cw0kgo=
X-Gm-Gg: Acq92OFLmVeaaplDVWrk7xTji9ujLFQT6zerpfHeWpMLuS6MYdSAZ1WCEqU7AFOEO2k
 U/BPxkhWlAdHSiSF3g0+9YtFqY8+ainG9lJYYMvBO4j9elW4a4NC+95w38j9zwN6/AyR4byRtPs
 mU0Dcxm/d6VYRKx0ho/1/aJpxgX47HcMTmmA/sIsjGxeMG34ehs7LCozpjPVqTZ5pKXemk/onVN
 +TyvXFyBmHKke2R3ouyNBLizjAh+ev0TzzUQMviErN1lkbmUZYJa1PJItG6IyyeP0mXotYcSCB3
 dWEGTF+ET0/9zNURpdkDvXjxWAcQd9GUw8d9Cnu5lyreaGLTQBkt+119uqMtSx2C23xGoj5mnzC
 qnTipyjDGhAy5UQGLzgR06ZjQCgfoyl5lAQ/5h4/Q5iKxxynVf3B9aI66I4P0LQWCsco0cz16SU
 bjez724M4WUg==
X-Received: by 2002:a05:600c:a30d:b0:48e:5d91:cfe3 with SMTP id
 5b1f17b1804b1-490424ac7bcmr191509725e9.1.1779735689694; 
 Mon, 25 May 2026 12:01:29 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6c9f598sm29873391f8f.6.2026.05.25.12.01.28
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 12:01:28 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 25 May 2026 21:01:23 +0200
Message-ID: <20260525190127.397779-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] zram01: Specify filesystem type explicitly in mount
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

util-linux 2.42 converts "ntfs" to "ntfs3" during auto-detection,
causing mount failures on systems with CONFIG_NTFS3_FS disabled
even when ntfs-3g is available.

tst_supported_fs_types.c:141: TINFO: FUSE does support ntfs
tst_supported_fs_types.c:67: TINFO: mkfs.ntfs does exist
tst_supported_fs_types.c:137: TINFO: Filesystem ntfs3 is not supported
...
...
zram01 6 TINFO: mount /dev/zram7
mount: /tmp/LTP_zram01.YG3YHQhMER/zram7: unknown filesystem type 'ntfs3'.
       dmesg(1) may have more information after failed mount system call.
zram01 6 TBROK: mount /dev/zram7 zram7 failed

Fix by specifying -t option with the filesystem type that LTP
verified as supported, avoiding auto-detection.

Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 testcases/kernel/device-drivers/zram/zram01.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
index 793f6603c..4b7f2a753 100755
--- a/testcases/kernel/device-drivers/zram/zram01.sh
+++ b/testcases/kernel/device-drivers/zram/zram01.sh
@@ -94,13 +94,15 @@ zram_makefs()
 
 zram_mount()
 {
-	local i
+	local i=$dev_start
+	local fs
 
-	for i in $(seq $dev_start $dev_end); do
-		tst_res TINFO "mount /dev/zram$i"
+	for fs in $zram_filesystems; do
+		tst_res TINFO "mount /dev/zram$i ($fs)"
 		mkdir zram$i
-		ROD mount /dev/zram$i zram$i
+		ROD mount -t "$fs" /dev/zram$i zram$i
 		dev_mounted=$i
+		i=$((i + 1))
 	done
 
 	tst_res TPASS "mount of zram device(s) succeeded"
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
