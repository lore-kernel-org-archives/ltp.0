Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6B3C4332F
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 13:38:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD6F93C9E9D
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 14:38:26 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F0D73C9D8E
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 14:38:17 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 73B091A01228
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 14:38:16 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 82AB61F399;
 Thu, 10 Feb 2022 13:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1644500295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CsGrN0HIngRpaMwf7pph6XGhUp0+yfAz7eD5AUDjUa0=;
 b=PcR4lwmPuoa3Qiz9BtVFC04empPO/ifkPOy8x1sWoCYCEoSPxvnTbj2sw9AXbNs0yBjg0X
 ua8buMxr5vttsrdOXvUkgYRNBC5jTWGr5wf0VMbXUWT1lB/CYoPrRKtjRvRAtVtsCgeT3l
 Js6dxVpsv4HQxtNaUsBsA7Ps4drmyu0=
Received: from localhost.suse.de (unknown [10.163.30.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 51DBBA3B89;
 Thu, 10 Feb 2022 13:38:15 +0000 (UTC)
To: ltp@lists.linux.it
Date: Thu, 10 Feb 2022 15:38:12 +0200
Message-Id: <20220210133812.13368-1-bogdan.lezhepekov@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] mem/swapping01: Make sure swap is supported by
 kernel
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
From: Bogdan Lezhepekov via ltp <ltp@lists.linux.it>
Reply-To: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Previous version caused false positive result
on machines support no swap in kernel.

Signed-off-by: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
---
 testcases/kernel/mem/swapping/swapping01.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
index 1a494bf69..3b4f0a61a 100644
--- a/testcases/kernel/mem/swapping/swapping01.c
+++ b/testcases/kernel/mem/swapping/swapping01.c
@@ -155,11 +155,18 @@ static void check_swapping(void)
 	SAFE_WAITPID(pid, &status, 0);
 }
 
+static void setup(void)
+{
+	if (access("/proc/swaps", F_OK))
+		tst_brk(TCONF, "swap not supported by kernel");
+}
+
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
 	.min_mem_avail = 10,
 	.test_all = test_swapping,
+	.setup = setup,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "50a15981a1fa"},
 		{}
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
