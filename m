Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9710C021A0
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 09:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739783588; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=rpeHA/c6FOtAeHYtpwWXDQGKXmUC69y6VtwI7zBQ47U=;
 b=MneiLLAOkHTagXpVcv1dnpRAz/qCH94kPFtXyVwv//n2Ywjq/Yg3RAZea3E8KeyAGMj3S
 DGX5ChbBgZwrMZoWS6JCuIBn6w6oI6tpshg83msfHfGXHXtr0UtPE783o8Ouuj7C2TJVhvn
 6IkUgURNk5aeKNZxKl8agPkUS/AbJGE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F01A3C9BBE
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 10:13:08 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1FACC3C9BA3
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 10:12:47 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.48;
 helo=esa2.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com
 [207.54.90.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 442AC633C45
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 10:12:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1739783565; x=1771319565;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NoaLDdoI8o1EyB4ImmFfpzSRWBCraYtwnPLTSFMXIGc=;
 b=t3PKjSp0ILPEi9h52jKyJlwhJxBSZUOB664kW87MAzOfdhIgPJxAOfGr
 HwUcEHmfxLQARDslD2LGbCvb+6TUto5tpWJ6A+WmCuRvxX/ZhutwS8Sam
 1Y0PXMGUwBu/grkBoJoPGzUBr+5VkjMCLj0EJLW2cPzx66DBc4Vz70C+2
 CVS3YcEpMc07WkbforhLujtG+kTgezxEFKAyXIj3KsL52rq8MAztOpW61
 9XWpOFgVoZbVXPT1XWdTX+W39tYm+lxyqBum3t8e9rWEzadeZlu94wLj9
 w88VRBCzA30MFVkai89SvlqMb2Nc/xygFx40GzYTK9R2wP5Y77VVFBiBt A==;
X-CSE-ConnectionGUID: NJ5uBeuCSMmLJIchFSZgHQ==
X-CSE-MsgGUID: 721CykgISnGSr9rfmhDh1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="190250629"
X-IronPort-AV: E=Sophos;i="6.13,292,1732546800"; d="scan'208";a="190250629"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
 by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 18:12:42 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 5378DD500F
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 18:12:40 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 12DF8CFB96
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 18:12:40 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id A31EE1A000B;
 Mon, 17 Feb 2025 17:12:38 +0800 (CST)
To: ltp@lists.linux.it
Date: Mon, 17 Feb 2025 17:11:44 +0800
Message-ID: <20250217091144.827361-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250210084310.357516-1-maxj.fnst@fujitsu.com>
References: <20250210084310.357516-1-maxj.fnst@fujitsu.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] fsync03: Convert docs to docparse
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
From: Ma Xinjian via ltp <ltp@lists.linux.it>
Reply-To: Ma Xinjian <maxj.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
---
 testcases/kernel/syscalls/fsync/fsync03.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/fsync/fsync03.c b/testcases/kernel/syscalls/fsync/fsync03.c
index d32c4a3e7..d8c321b85 100644
--- a/testcases/kernel/syscalls/fsync/fsync03.c
+++ b/testcases/kernel/syscalls/fsync/fsync03.c
@@ -4,14 +4,13 @@
  *   Copyright (c) 2019 SUSE LLC <mdoucha@suse.cz>
  */
 
-/*
- * Test Description:
- *  Testcase to check that fsync(2) sets errno correctly.
- *  1. Call fsync() on a pipe(fd), and expect EINVAL.
- *  2. Call fsync() on a socket(fd), and expect EINVAL.
- *  3. Call fsync() on a closed fd, and test for EBADF.
- *  4. Call fsync() on an invalid fd, and test for EBADF.
- *  5. Call fsync() on a fifo(fd), and expect EINVAL.
+/*\
+ * Verify that fsync(2) sets errno to:
+ * 1. EINVAL if calling fsync() on a pipe(fd).
+ * 2. EINVAL if calling fsync() on a socket(fd).
+ * 3. EBADF if calling fsync() on a closed fd.
+ * 4. EBADF if calling fsync() on an invalid fd.
+ * 5. EINVAL if calling fsync() on a fifo(fd).
  */
 
 #include <unistd.h>
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
