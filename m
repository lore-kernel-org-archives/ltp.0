Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A590BC6FD1D
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 12:11:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CBDDA3CE308
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 13:11:36 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B55C43CE2F4
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 13:11:17 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1542514001EE
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 13:11:16 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6CCAB339C9;
 Thu, 23 Mar 2023 12:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1679573476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CFaYcQB8v29cEa73Y9m8AAGFE17IPHxXihmMHbz8YkY=;
 b=gWfjWsJf+qJP8IY0kjKiFZBvN68/mxPNL2MvVLuAUXAa5XVxBNocwzu0XkChUuknEnpjOs
 e6X8gkZzkWWzFQQGaF/g6FfjViAyw2i6euYpGzs5wLF/rlMQVBTRUFuKNHe6WXZUP5rYJ6
 dCBCLGOSNJfwyyptxWEGStLR3YMBQLw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A9086132C2;
 Thu, 23 Mar 2023 12:11:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6K/DNeBBHGRyKwAAMHmgww
 (envelope-from <wegao@suse.com>); Thu, 23 Mar 2023 12:11:12 +0000
To: ltp@lists.linux.it
Date: Thu, 23 Mar 2023 08:10:26 -0400
Message-Id: <20230323121026.28710-3-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230323121026.28710-1-wegao@suse.com>
References: <20230314093725.3814-1-wegao@suse.com>
 <20230323121026.28710-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 2/2] madvise11: Check if module is loadable before
 rmmod
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Following fail msg will popup if we try to rmmod buildin module:
rmmod: ERROR: Module hwpoison_inject is builtin

So need add extra check.

Signed-off-by: Wei Gao <wegao@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/madvise/madvise11.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise11.c b/testcases/kernel/syscalls/madvise/madvise11.c
index 7e291d571..4d99d5289 100644
--- a/testcases/kernel/syscalls/madvise/madvise11.c
+++ b/testcases/kernel/syscalls/madvise/madvise11.c
@@ -300,7 +300,7 @@ static int open_unpoison_pfn(void)
 	struct mntent *mnt;
 	FILE *mntf;
 
-	if (!find_in_file("/proc/modules", HW_MODULE))
+	if (!find_in_file("/proc/modules", HW_MODULE) && tst_check_builtin_driver(HW_MODULE))
 		hwpoison_probe = 1;
 
 	/* probe hwpoison only if it isn't already there */
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
