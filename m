Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D61C021AA
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 07:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739951185; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=aMWnmnwtmK0qTVrSF1odLLr7beJWLweFWSp9NctsnaM=;
 b=G16f4MaYBNAjAEBZj+FT0oSjOZf0MgRFp0zlhLNdpIe4/5XPPTMWTYogqm0AVM4Bay0WF
 lCoeY64ICJGQ5aO0OkDKq1tswAtW3Y3RL6WOkMnZcIFF3lz5KKyTia99Ot2ZY8ccGTgqNBq
 lwpLSxJQxM/PNKugWtyJRGJxmkz5774=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2D0F3C29D4
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 08:46:25 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E68123C0503
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 08:46:03 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.36.223;
 helo=esa9.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com
 [139.138.36.223])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 779FF1427B99
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 08:46:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1739951162; x=1771487162;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=esZPmusrgzxDTdM9NdQxUIO/adm39bJRFqKQUxV7N6A=;
 b=PeSCjHrvITOpSTNUhpjR+2VCoI8vskNGJEbVD5CQFYELOoUuVteOjAUz
 Gc1E0Of3F7S+68J1GZ9ya+EplBL/O5baqt9yjJL59l0NCEAjYCBDs/xhk
 bvUaXfnKxE16dC1HklliGwWHEFT4N189fr3fnOS8Bx38vRwGPz2+sb62r
 KtbneOFeAE3BkEiox8hugBbeJK9OjNv1GYaSEjyvlvaj608sfFCzXNVyG
 em4gGSBqzvbQSuFwqlwZQP9Aee6scVpoGfVuO1jmbG+zsU/YET89iuMS7
 JJazbl9+RMoMKG7hNk3m8ddHRA1Me46wfRMKTmyaeSXRMajvtIBfxVRFB A==;
X-CSE-ConnectionGUID: RFT1S3nzRdqI9Uu1wf9Vtg==
X-CSE-MsgGUID: CQRh5tpJQ9eDKfP74RDveQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="178865949"
X-IronPort-AV: E=Sophos;i="6.13,298,1732546800"; d="scan'208";a="178865949"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
 by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 16:45:59 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id D15F9D4F41
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 16:45:56 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 93F7AF31A1
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 16:45:56 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id D3C3E1A0003;
 Wed, 19 Feb 2025 15:45:55 +0800 (CST)
To: ltp@lists.linux.it,
	andrea.cervesato@suse.com
Date: Wed, 19 Feb 2025 15:45:50 +0800
Message-ID: <20250219074550.1034113-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] fsync03: Convert docs to RST format
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
 testcases/kernel/syscalls/fsync/fsync03.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/fsync/fsync03.c b/testcases/kernel/syscalls/fsync/fsync03.c
index d32c4a3e7..93913df9f 100644
--- a/testcases/kernel/syscalls/fsync/fsync03.c
+++ b/testcases/kernel/syscalls/fsync/fsync03.c
@@ -4,14 +4,14 @@
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
+ *
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
