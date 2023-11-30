Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3B5C4167B
	for <ltp@archiver.kernel.org>; Thu, 30 Nov 2023 09:39:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 44C5A3CFC71
	for <ltp@archiver.kernel.org>; Thu, 30 Nov 2023 10:39:46 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A4843CD96A
 for <ltp@lists.linux.it>; Thu, 30 Nov 2023 01:40:35 +0100 (CET)
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com
 [99.78.197.217])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9258A602581
 for <ltp@lists.linux.it>; Thu, 30 Nov 2023 01:40:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1701304835; x=1732840835;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=UqhaqgkLrW2NgBDgBu5hgHFa+vlmEmI+urv03ESO8Kw=;
 b=STBMeUrrDpNWrN/s59FE3lH+2Cl8BIJ8MI9ZD0x0Ncot0GywnyoOx7q7
 AwlUNxvLG2fsQBLv/wRbMta8wJg1svSkkTA0sBu72UaUwrQnw0Cpn0gAy
 L+vpeJbOXgROhWM+pj0CyIbgAvwlNzB9//+5E1y4NsLZ6lBuG3IEKeySF s=;
X-IronPort-AV: E=Sophos;i="6.04,237,1695686400"; d="scan'208";a="255787810"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO
 email-inbound-relay-iad-1d-m6i4x-e651a362.us-east-1.amazon.com)
 ([10.25.36.214]) by smtp-border-fw-80006.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 00:40:32 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev
 (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
 by email-inbound-relay-iad-1d-m6i4x-e651a362.us-east-1.amazon.com (Postfix)
 with ESMTPS id 03E3C805E2; Thu, 30 Nov 2023 00:40:29 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:51807]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.224:2525]
 with esmtp (Farcaster)
 id 9f0297a9-080f-4a77-80df-c2ea1d52f372; Thu, 30 Nov 2023 00:40:28 +0000 (UTC)
X-Farcaster-Flow-ID: 9f0297a9-080f-4a77-80df-c2ea1d52f372
Received: from EX19D028UWA002.ant.amazon.com (10.13.138.248) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 30 Nov 2023 00:40:28 +0000
Received: from u3e8e27f4765f5f.ant.amazon.com.com (10.94.68.71) by
 EX19D028UWA002.ant.amazon.com (10.13.138.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 30 Nov 2023 00:40:28 +0000
To: <ltp@lists.linux.it>
Date: Wed, 29 Nov 2023 16:40:10 -0800
Message-ID: <20231130004010.488496-1-mengcc@amazon.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.94.68.71]
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D028UWA002.ant.amazon.com (10.13.138.248)
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 30 Nov 2023 10:39:37 +0100
Subject: [LTP] [PATCH v1] rwtest: Confirm df is a symlink to busybox
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
Cc: metan@ucw.cz, Mengchi Cheng <mengcc@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

/bin/df can be a symlink to coreutils. It returns correct info with dir
arguments.
Just checking if df is a symlink will include such cases. Need to make
sure it is linking to busybox before ignoring options.

Signed-off-by: Mengchi Cheng <mengcc@amazon.com>
---
 testcases/kernel/fs/doio/rwtest | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/fs/doio/rwtest b/testcases/kernel/fs/doio/rwtest
index 6725e1426..26659e9d3 100644
--- a/testcases/kernel/fs/doio/rwtest
+++ b/testcases/kernel/fs/doio/rwtest
@@ -329,10 +329,10 @@ do
 		else
 			# If df is a symlink (to busybox) then do not pass the $dir and $dfOpts
 			# parameters because they don't work as expected
-                        if test -h $(which df)
-                           then
-                               dir=""; dfOpts="";
-                        fi
+			if [[ "$(readlink -f "$(which df)")" == *"busybox"* ]]
+			then
+				dir=""; dfOpts="";
+			fi
 
 			blks=$(df $dfOpts $dir |
 			(while read fs blks used avail cap mountpoint
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
