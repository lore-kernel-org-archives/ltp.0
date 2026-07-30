Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A201BC55160
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 13:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785418883; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=wp7D8pBljS2FpJVK6ljXHOrBQOEZbvqz9s+M2uvUAMU=;
 b=e+3O8i88f3L/0x9+Gfoug0rrRU5UFWwsmwp2vO2Xptv1C8s8l2+Si5BSK6gqrN+EpTnk0
 lgZv+cwF2WCSLgInsWLKY5T0X3hAeOjMFZiyaM5XLu4Ftry+OpvdnM/ISlvFR6VF1a2/esl
 AEZoA8WOExzz+iVkzIuSYhzW/G/hIrc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E7D983E7477
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 15:41:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E7413E1C9D
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 15:41:04 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B69E4600940
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 15:41:03 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4955158f26aso14347935e9.3
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 06:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785418863; x=1786023663; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZVa/4CXB2KndFOCKjEv5u4LX561ZqBHAiSTAfhfC2YM=;
 b=bWyPAA1HD+MYUetXokaEUeErcfV82zyPugt93wMQceX6qCdDp/JO2oG7kYENRzs5Ax
 ++O95ejYUb9HjyueNsErGm6QDvvxFqhdsXkrC2cozUAo2OmCeNQrMzO14vVJW0tJ4OEJ
 Y9OohjgZqI20c9B+tauabrWCmcWYuJwh4gaLUn1KBarAKIfCB8X9CR1KnrtdCzfMr+KS
 OSCtgf1ySBG7q57h8ZlmTlQT7jEwPinHb2DbvDK6bJAv/4AN4p1aWB1ISZRXGyhZWtX1
 t3LeEiWjDL9ohUa9uhvFb4tAY8oss/ktagK9krIC+NPRH2BdxliC+cJjH+ul+SduaW2V
 yDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785418863; x=1786023663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZVa/4CXB2KndFOCKjEv5u4LX561ZqBHAiSTAfhfC2YM=;
 b=o8enTbRUD4hgDkQ8D19Zo3RbK1ADrLx96VtcvYm3EoSdPxku2bbQP4wH/f4eASZaWW
 ZPvpRARSY9lpDSJk5jTN+sRjPW7JqPaUl8hXEUFpHysiKNmz8qtYDi6SY3cS2sD6Gu0w
 4oUwfwjpBfaqNY+rmBWNGr4ekYu19JpLUmHeI2bzc3Yts4gJc4uQVPyBM+Y8iCs9W592
 4xwxXYUczYHfivFGmjcUrZE029l4s+iu05KUMmHSiWzugcawU/YUMflvtatXtGyAmRcY
 M3xXgmhw4wGg0v7oVbd9k+JbSzaUc9jTo48Dviv9JO03YQuBIUuGcDopY+9KkF4jE+3U
 jpkQ==
X-Gm-Message-State: AOJu0Yy4+arMGUECCrFTWNCDJMDwzW8WQMB/yT/CQK9Wa2kIUTGP1rBr
 z/rOOAjkSBp7hFH7f9UgTODvgmL7+a4zdsEgUueI0DODU5smHWA2rbQgOjhbyMA5hAdm4wbtng2
 LIuJzUzM=
X-Gm-Gg: AR+sD10xOnXeZo8/IALEwOEawJdt2odLNuo1G62LMef8ma84t7LdblpIiIbb8WxRItJ
 HrodDKjNVZQB3VwdQZpIhuO26nPC5FQWxf44X7HQpRO6wCKSbcdIdX77HP/c2eZZ5j+Z5e+eG8r
 5wN5wFLUHTnzkyp61QaUoC/uHeEvIPIqfcBVYG8H6fKPhGqg9MpUF2+V8okUncZjQcWqEgjXrv/
 HFu0nIzX5bHuzk28CfCZlC098M/0PH2hQ+uC9ZCvUF0pp02JZHMVV93CrjzMBiNZRGMLH5rpno5
 cXY5r99ITsUPY/ZZvdYqn9SCy96MLEt0UjIIxN7YQMuQW6/Vs++vKRup0b0J1Vnf5B+zI5429x3
 5D0yGxBLJptupavBRDKRpTnSvqH5kEMpwlvvkXERrIrSlmElGXPvPlab5FSdEdtvYUA+7mUbjgJ
 fxmv7gca0rqgOiVS+bNUDFX7Du/36itieBlsgrw2vYLX8ZN+k=
X-Received: by 2002:a05:600c:63d3:b0:495:3aac:1098 with SMTP id
 5b1f17b1804b1-49800ebb91amr22480735e9.32.1785418863150; 
 Thu, 30 Jul 2026 06:41:03 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc892cdeasm6643413f8f.22.2026.07.30.06.41.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 06:41:02 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 30 Jul 2026 15:41:01 +0200
Message-ID: <20260730134102.132477-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730133804.131074-1-avinesh.kumar@suse.com>
References: <20260730133804.131074-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] inode01: increase dev_min_size to fit the peak
 usage in parallel scenario
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

From: Avinesh Kumar <avinesh.kumar@suse.com>

The parallel scenario keeps every worker's tree on the device at the same
time. On exfat each object costs a full cluster and mkfs.exfat defaults to
32K cluster size for a volume above 256M, causing ENOSPC on a 300M device.
Increase the dev_min_size to 512M.

tst_test.c:1985: TINFO: === Testing on exfat ===
tst_test.c:1291: TINFO: Formatting /dev/loop0 with exfat opts='' extra opts=''
tst_test.c:1303: TINFO: Mounting /dev/loop0 to /var/tmp/LTP_inoLqT9T5/mntpoint fstyp=exfat flags=0
inode01.c:241: TINFO: Testing single-process small tree (depth=3 fanout=4 repetitions=100 workers=1)
inode01.c:228: TPASS: Created and verified 28 objects in mntpoint/inode.5827
inode01.c:241: TINFO: Testing parallel larger trees (depth=6 fanout=6 repetitions=8 workers=5)
inode01.c:61: TBROK: write(3,0x7ffcea2c2370,73) failed: ENOSPC (28)
tst_test.c:478: TINFO: Child process reported TBROK killing the test
inode01.c:64: TBROK: mkdir(mntpoint/inode.5832/00001457/00001701/00001862/00001890/00001907/00001911, 0777) failed: ENOSPC (28)

Fixes: 8ea955383e00 ("inode: convert to new API and merge into a single test")
Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 testcases/kernel/fs/inode/inode01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/fs/inode/inode01.c b/testcases/kernel/fs/inode/inode01.c
index 219238553562..2816ad61ab38 100644
--- a/testcases/kernel/fs/inode/inode01.c
+++ b/testcases/kernel/fs/inode/inode01.c
@@ -256,7 +256,7 @@ static struct tst_test test = {
 	.mount_device = 1,
 	.all_filesystems = 1,
 	.needs_root = 1,
-	.dev_min_size = 300,
+	.dev_min_size = 512,
 	.forks_child = 1,
 	.needs_checkpoints = 1,
 	.timeout = 300,
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
