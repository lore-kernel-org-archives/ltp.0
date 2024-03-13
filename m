Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D88C54E66
	for <ltp@archiver.kernel.org>; Wed, 13 Mar 2024 23:50:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3AAB73D05FE
	for <ltp@archiver.kernel.org>; Thu, 14 Mar 2024 00:50:51 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E064A3C7FFE
 for <ltp@lists.linux.it>; Thu, 14 Mar 2024 00:50:35 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=canonical.com (client-ip=185.125.188.120;
 helo=smtp-relay-canonical-0.canonical.com;
 envelope-from=po-hsu.lin@canonical.com; receiver=lists.linux.it)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A0E8D1A00E62
 for <ltp@lists.linux.it>; Thu, 14 Mar 2024 00:50:34 +0100 (CET)
Received: from Phocidae.conference (1.general.phlin.uk.vpn [10.172.194.38])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 379FF40EE7
 for <ltp@lists.linux.it>; Wed, 13 Mar 2024 23:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1710373833;
 bh=IR3ie2RZmvmr0mWP269rp4krI8AR0I4Y1st7Pm01yUU=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=o32ilPfhlltC041z1a6OpofNJ/sp0nI6wfvhpIsjJBzI94IeP+wZfYQT9YDzuOrxx
 N8NkukjyQGd76RBQcCUJW5BInETkCJKMwLHenAppEHdEk550d3bnjDlvWNXyFX3SK1
 GCNq57RBg8xcMeX7lp3Wvupe51R9FJvAlJ6XLmLkHeNZJ41g/aIrRkwegDbFbQXiPl
 s5eKotMUWJ0lXAcJIvCFt5QDY+TBLE9EdqDQ3Eh9z6VlWjuBbo0GM5ASU5Y/1Cr6YI
 DWxYh7vlDpAo7rkIsWAPKMEh5XovkNEyXSDky1J+RI1aLBx8U87QhQ0f7MB/8B4o8X
 gJXi6l0B3vqsw==
From: Po-Hsu Lin <po-hsu.lin@canonical.com>
To: ltp@lists.linux.it
Date: Thu, 14 Mar 2024 07:50:11 +0800
Message-Id: <20240313235011.1157132-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] scenario_groups/default: remove connectors test
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

The connectors test has been merged into kernel_misc with commit
9b642d89c0 ("runtest: Merge runtest/connectors to kernel_misc").

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 scenario_groups/default | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scenario_groups/default b/scenario_groups/default
index f17b2061a..ec77d8fb8 100644
--- a/scenario_groups/default
+++ b/scenario_groups/default
@@ -16,7 +16,6 @@ controllers
 filecaps
 cap_bounds
 fcntl-locktests
-connectors
 power_management_tests
 hugetlb
 commands
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
