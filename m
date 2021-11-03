Return-Path: <SRS0=7iMP=PW=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D8EC433FE
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 10:02:59 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04D79610E8
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 10:02:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 04D79610E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 968F33C72C8
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 11:02:55 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 50D2A3C0956
 for <ltp@lists.linux.it>; Wed,  3 Nov 2021 11:02:44 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4B449140138B
 for <ltp@lists.linux.it>; Wed,  3 Nov 2021 11:02:43 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 7913F1F782;
 Wed,  3 Nov 2021 10:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1635933763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=s4r4C6y0YVKv1S2A3cwjIkvCookL8uiOqUMaNDm233o=;
 b=acAj5g1QpDRui1UVBJzO8atpMMzXzf5V8TQosxp08kgBHx2Si7AnHULBE/lqeZLrdNiuK9
 ENo7K5/p2pLmFCQIDzZSrfyfp3Ea3nDKmsRkiFZWCyTUpNg5b8xkFXaKRYWrbB0OhSFovG
 NRyi8SxgpSzV/yQT8rlyKxFPd62YCjE=
Received: from localhost.suse.de (unknown [10.163.30.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 4966D2C154;
 Wed,  3 Nov 2021 10:02:43 +0000 (UTC)
To: ltp@lists.linux.it
Date: Wed,  3 Nov 2021 12:02:35 +0200
Message-Id: <20211103100235.22007-1-bogdan.lezhepekov@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] netns_netlink: Ensure tuntap is enabled in kernel
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

---
 testcases/kernel/containers/netns/netns_netlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/containers/netns/netns_netlink.c b/testcases/kernel/containers/netns/netns_netlink.c
index ddd8ce910..f9ae255f5 100644
--- a/testcases/kernel/containers/netns/netns_netlink.c
+++ b/testcases/kernel/containers/netns/netns_netlink.c
@@ -120,6 +120,7 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_NET_NS=y",
+		"CONFIG_TUN=y",
 		NULL
 	},
 };
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
