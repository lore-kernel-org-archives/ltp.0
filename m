Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF521D7831E
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 13:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1733146403; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=wjD75wpXVZz98h8BSNE08BM8+eA8lYfclSHTbA2YslM=;
 b=CKeEoAxwKifPh5fxoZIcCISwkj9jOHU1IKXQQ4PTPFvHv5xGHQz46245t+I0HsvwizJoz
 BHaETX7/41YM8XQQiY/eDaW8eE1mSf8VGW0xRPii1fXhB9TUvKJJB52kcwjaNyfOqAUThJ5
 e+MMJwVAVEodhdXXMfIU7T7K4flV/VY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 599BE3DD464
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 14:33:23 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D99813DC5B7
 for <ltp@lists.linux.it>; Sun,  1 Dec 2024 10:36:16 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3;
 helo=nyc.source.kernel.org; envelope-from=zlang@kernel.org;
 receiver=lists.linux.it)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 44DD1600FDE
 for <ltp@lists.linux.it>; Sun,  1 Dec 2024 10:36:16 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id C661AA40A24;
 Sun,  1 Dec 2024 09:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85FDC4CECF;
 Sun,  1 Dec 2024 09:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733045775;
 bh=V/oXOD9GbNSan96odxreYJIhYatuukOGYYeIiyfKbhk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=r/JAXunzkbNKtJdGNBL6BqAoAETre/av319LAREQ9a9f5oHEoUWHPr1kw0k5mCz4A
 21g+7z5JAPu5UrN3HNWi2gZSK9n681O8PaBIP4zLQfF9QoFZqJYBGGdQyF2fVfsjBP
 V5FGRukVQr7kcirrdg3oSUAg1rgD2v8g7C1yNwGpvY0xZE0/B1gDm+YjtdOHn+GTNX
 1Moj7snxOEW9buiVoiE3nn6No/v1yVpgxGTozLJB1QESpu+4uoaBIlIMshniDvujzp
 VzCGKuJpnYkT+Wif/JHuPUoWVsi7/vOaWGy4yYFPC/6pRp/tQ/VF91VByd2LKP7sAN
 RGJtyrshrY0gg==
To: ltp@lists.linux.it
Date: Sun,  1 Dec 2024 17:36:06 +0800
Message-ID: <20241201093606.68993-4-zlang@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241201093606.68993-1-zlang@kernel.org>
References: <20241201093606.68993-1-zlang@kernel.org>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 02 Dec 2024 14:31:52 +0100
Subject: [LTP] [PATCH 3/3] stat04+lstat03: skip test on btrfs
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
From: Zorro Lang via ltp <ltp@lists.linux.it>
Reply-To: Zorro Lang <zlang@kernel.org>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The "-b" option for mkfs.btrfs isn't a blocksize option, it does
"specify the size of each device as seen by the filesystem" for
btrfs. There's not an blocksize mkfs option for btrfs, so skip this
test.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---
 testcases/kernel/syscalls/lstat/lstat03.c | 2 ++
 testcases/kernel/syscalls/stat/stat04.c   | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/lstat/lstat03.c b/testcases/kernel/syscalls/lstat/lstat03.c
index 675fb56f4..f7346893d 100644
--- a/testcases/kernel/syscalls/lstat/lstat03.c
+++ b/testcases/kernel/syscalls/lstat/lstat03.c
@@ -57,6 +57,8 @@ static void setup(void)
 
 	if (strcmp(tst_device->fs_type, "xfs") == 0)
 		snprintf(opt_bsize, sizeof(opt_bsize), "size=%i", pagesize);
+	else if (strcmp(tst_device->fs_type, "btrfs") == 0)
+		tst_brk(TCONF, "btrfs is not supported");
 	else
 		snprintf(opt_bsize, sizeof(opt_bsize), "%i", pagesize);
 	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
diff --git a/testcases/kernel/syscalls/stat/stat04.c b/testcases/kernel/syscalls/stat/stat04.c
index 2a17cc7d7..3c4f1a6b4 100644
--- a/testcases/kernel/syscalls/stat/stat04.c
+++ b/testcases/kernel/syscalls/stat/stat04.c
@@ -59,6 +59,8 @@ static void setup(void)
 
 	if (strcmp(tst_device->fs_type, "xfs") == 0)
 		snprintf(opt_bsize, sizeof(opt_bsize), "size=%i", pagesize);
+	else if (strcmp(tst_device->fs_type, "btrfs") == 0)
+		tst_brk(TCONF, "btrfs is not supported");
 	else
 		snprintf(opt_bsize, sizeof(opt_bsize), "%i", pagesize);
 	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
