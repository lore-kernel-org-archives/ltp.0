Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B70C4167B
	for <ltp@archiver.kernel.org>; Sat,  2 Dec 2023 03:26:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0EB7E3CF611
	for <ltp@archiver.kernel.org>; Sat,  2 Dec 2023 04:26:20 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 445EF3CCEE9
 for <ltp@lists.linux.it>; Sat,  2 Dec 2023 04:26:10 +0100 (CET)
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com
 [52.119.213.156])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4041F60157E
 for <ltp@lists.linux.it>; Sat,  2 Dec 2023 04:26:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1701487569; x=1733023569;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=L0mq/lUkYkbQxE2zBOE/j4OHkoZqgBTmOLgfFFGdhi0=;
 b=bU1w4d1gs01gbYTlpTB7hLaTqy8mfIERf3q4lhKi5qq3KmTibuO+D9rM
 qUYyU8jKu+Dpj1tDk8LvIOTQ5tkY3kLPNPhVx2rndfdKf9PxTwHptXjzQ
 aBLfcTtdtPYx6ccBYKVX6yOPoWtAoluurxnkmI54f1Z5VrqqxO0Jo5WMZ Q=;
X-IronPort-AV: E=Sophos;i="6.04,243,1695686400"; d="scan'208";a="619399512"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com) ([10.43.8.6])
 by smtp-border-fw-52005.iad7.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 03:26:07 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev
 (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
 by email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com (Postfix)
 with ESMTPS id A3E458048A; Sat,  2 Dec 2023 03:26:06 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:53208]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.8:2525] with
 esmtp (Farcaster)
 id 44a38810-eadc-463a-9c7e-5aff27f29a25; Sat, 2 Dec 2023 03:26:06 +0000 (UTC)
X-Farcaster-Flow-ID: 44a38810-eadc-463a-9c7e-5aff27f29a25
Received: from EX19D028UWA002.ant.amazon.com (10.13.138.248) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Sat, 2 Dec 2023 03:26:05 +0000
Received: from u3e8e27f4765f5f.ant.amazon.com (10.187.171.41) by
 EX19D028UWA002.ant.amazon.com (10.13.138.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 2 Dec 2023 03:26:05 +0000
To: <ltp@lists.linux.it>
Date: Fri, 1 Dec 2023 19:25:52 -0800
Message-ID: <20231202032552.1142294-1-mengcc@amazon.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.187.171.41]
X-ClientProxiedBy: EX19D044UWB001.ant.amazon.com (10.13.139.171) To
 EX19D028UWA002.ant.amazon.com (10.13.138.248)
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] rwtest: Remove df symlink check
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
From: Mengchi Cheng via ltp <ltp@lists.linux.it>
Reply-To: Mengchi Cheng <mengcc@amazon.com>
Cc: Mengchi Cheng <mengcc@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

busybox has -P option since 2008. df symlink works fine with
directory options in later versions. The check is not necessary.

Signed-off-by: Mengchi Cheng <mengcc@amazon.com>
---
 testcases/kernel/fs/doio/rwtest | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/testcases/kernel/fs/doio/rwtest b/testcases/kernel/fs/doio/rwtest
index 6725e1426..f15ce17e6 100644
--- a/testcases/kernel/fs/doio/rwtest
+++ b/testcases/kernel/fs/doio/rwtest
@@ -327,12 +327,6 @@ do
 		then
 			blks=${szblks[$n]}
 		else
-			# If df is a symlink (to busybox) then do not pass the $dir and $dfOpts
-			# parameters because they don't work as expected
-                        if test -h $(which df)
-                           then
-                               dir=""; dfOpts="";
-                        fi
 
 			blks=$(df $dfOpts $dir |
 			(while read fs blks used avail cap mountpoint
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
