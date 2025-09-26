Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB381CAC5B5
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 02:54:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF2623CE09A
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 04:54:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F94B3CD9F8
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 04:54:18 +0200 (CEST)
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch
 [109.224.244.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DB076600716
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 04:54:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=naotchy.com;
 s=protonmail; t=1758855255; x=1759114455;
 bh=0PL/WLz4gt0ipZMuSG2jphy3dofSLA86w1lkbnKc8oM=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=I999kfWhcLPzk9DWG4d0VaYGUVvqJc6WLqxFyCE34PrRRLYiq0ZH0t5WhC2NzM0vP
 AdB+KjclC593oJ/GdT0P9l+13h4UMHBBInhjyqwWWmodqVpRuLuDweFCTi9WnxYvn5
 3xPP5HBSyX5d5SulUZw/ZKKeRrhuHemqSUtvBPdo4tU/2LZIqz+1oyC0N/HEkm72kI
 PPaMGWQDIaO/ESTn5hXPoMGYXcfuovttch42orFIWD43tZe4UvAv6E+C05PuPk22g1
 opr5/O5/O12kT1LAJk/P2IF4OvWF5JYYCg7KwgOrJSc453MEykm/Xu422MvXoceA9Y
 ezBNCUhl7wn+Q==
Date: Fri, 26 Sep 2025 02:54:08 +0000
To: ltp@lists.linux.it
From: Jack Morgan <jmorgan@naotchy.com>
Message-ID: <20250926025318.612308-1-jmorgan@naotchy.com>
Feedback-ID: 96944049:user:proton
X-Pm-Message-ID: fdf90428354cbf070037a6e3ec0ac86f6eb0e2df
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] configure.ac: Add check for STATMOUNT_MNT_NS_ID
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

mnt_ns_id was removed from struct statmount in newer kernels.
This check determines whether the headers have this field or not.

Signed-off-by: Jack Morgan <jmorgan@naotchy.com>
---
 configure.ac | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configure.ac b/configure.ac
index d4dd13033..0480f46ca 100644
--- a/configure.ac
+++ b/configure.ac
@@ -264,6 +264,8 @@ AC_CHECK_TYPES([struct cachestat],,,[#include <sys/mman.h>])
 # Defined in <linux/mount.h>, but include/lapi/mount.h includes <sys/mount.h> */
 AC_CHECK_TYPES([struct mnt_id_req],,,[#include <sys/mount.h>])
 AC_CHECK_TYPES([struct statmount],,,[#include <sys/mount.h>])
+AC_CHECK_MEMBERS([struct statmount.mnt_ns_id],,,[#include <unistd.h>
+#include <linux/mount.h>])
 
 AC_CHECK_TYPES([struct pidfd_info],,,[#include <sys/pidfd.h>])
 AC_CHECK_TYPES([struct file_attr],,,[#include <linux/fs.h>])
-- 
2.51.0



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
