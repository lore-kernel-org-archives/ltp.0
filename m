Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05430C7EE2A
	for <ltp@archiver.kernel.org>; Tue,  9 May 2023 09:15:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 462F23CD721
	for <ltp@archiver.kernel.org>; Tue,  9 May 2023 11:15:10 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB3573C0238
 for <ltp@lists.linux.it>; Tue,  9 May 2023 11:15:01 +0200 (CEST)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CE27E10007C8
 for <ltp@lists.linux.it>; Tue,  9 May 2023 11:15:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1683623700; i=@fujitsu.com;
 bh=l30O1QwijtNJvzOYFLvAfa9gmNypq7F5WmsyeaMtcSk=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
 b=QuEBT4ko3ks0KJ+4gZSSAhYrsi730eBMp1hZDW7RK0S+kwc43TNIf5bIj+PfcZF1/
 zYrjIlddPVPfK8c09YsQRfH5tPrS/oFVVRbO2YXoWoSGzTw6gpcYu0g5cuenuNvSIb
 fVPNiiIkAtDg/AME2hP1YTeN1ujzNFQ/jgxj82U9NTz/l5g27sxlQsiSZ2ShkSs2yX
 +Vh7GwAazO0mI9yis6lPZGcn0rZeKNLta/xPD4Gpl/yCZdxxbqv3xIGDWI4DECYF1p
 CeENGwnK/ZunIy8JgW5EZHatiExwUKy1zDaRumF6y8nIyjwMlrqZEzhBqhhEh+mPNl
 egWavdKH5zBDA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRWlGSWpSXmKPExsViZ8ORpCvMH5V
 i8PCvgsXaPX+YLVZ838HowOSxaVUnm8e+3+tYA5iiWDPzkvIrElgz1u7oZC5YxFlxY3oTcwPj
 Q/YuRi4OIYGNjBIflz1hgXCmMUlMnXCItYuRk4NNQFPiWecCZhBbREBM4vqGV2BxZgFbiZfHt
 zKC2MICFhJz+xaAxVkEVCUuPp8MZvMKeEr8n/4erFdCQEFiykMIm1PAS2Ju2wswWwio5k3XJF
 aIGjWJq+c2MU9g5FnAyLCK0bQ4tagstUjXRC+pKDM9oyQ3MTNHL7FKN1EvtVS3PLW4RNdIL7G
 8WC+1uFivuDI3OSdFLy+1ZBMjMExSipU6djBe3/lX7xCjJAeTkihv177IFCG+pPyUyozE4oz4
 otKc1OJDjDIcHEoSvA94olKEBItS01Mr0jJzgCELk5bg4FES4T3BApTmLS5IzC3OTIdInWJUl
 BLnLecFSgiAJDJK8+DaYHFyiVFWSpiXkYGBQYinILUoN7MEVf4VozgHo5Iw70SQKTyZeSVw01
 8BLWYCWux/ORxkcUkiQkqqgalLndP+Be9uJpWiXV3zRYJ7tbuYf6zdd4x/XV7IGZWvYnM2pBj
 uPFl3xvqa0peFYQuKa0MOi7OW/JOqqVds6FJrEIp0TSmb8vuc/Kl7uyTUPwre5Cie0sqRLCUa
 LRxUfrzAVt5b7+HPZdXhjx/+DQ47KnLKt7LOOPxi8At9zxcTpkW68pbcefrrjpPoD5EZPf/2F
 Oa41jE/l7VrcFcyOuxsc2L6tEu2fH8qv3uf5tdOOKv+Zv+Z5fu3KB5TEVXgyI7wuMWw9kNC5h
 GG4MlWJdNvOh2/yL5v+8OVT04kFr58teRpb8M6vpe3WHQOaRzzWCis+TLxfnB19xSPU/+vq2y
 WvDR7hUq3ezBDe+zKRCWW4oxEQy3mouJEAKc7QvEOAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-8.tower-548.messagelabs.com!1683623699!42629!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.105.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 2940 invoked from network); 9 May 2023 09:14:59 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
 by server-8.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 9 May 2023 09:14:59 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 4386D1B1;
 Tue,  9 May 2023 10:14:59 +0100 (BST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 474A37B;
 Tue,  9 May 2023 10:14:58 +0100 (BST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Tue,  9 May 2023 17:14:04 +0800
Message-Id: <1683623648-22778-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1683623648-22778-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1683623648-22778-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 3/7] lapi/stat.h: Simplify definition
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/lapi/stat.h | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/include/lapi/stat.h b/include/lapi/stat.h
index 6ed4b6637..e247c2159 100644
--- a/include/lapi/stat.h
+++ b/include/lapi/stat.h
@@ -11,6 +11,8 @@
 #include <stdint.h>
 #include <unistd.h>
 #include "lapi/syscalls.h"
+#include <sys/stat.h>
+
 /*
  * Timestamp structure for the timestamps in struct statx.
  *
@@ -21,9 +23,7 @@
  *
  * __reserved is held in case we need a yet finer resolution.
  */
-#if defined(HAVE_STRUCT_STATX_TIMESTAMP)
-#include <sys/stat.h>
-#else
+#ifndef HAVE_STRUCT_STATX_TIMESTAMP
 struct statx_timestamp {
 	int64_t tv_sec;
 	uint32_t tv_nsec;
@@ -67,9 +67,7 @@ struct statx_timestamp {
  * will have values installed for compatibility purposes so that stat() and
  * co. can be emulated in userspace.
  */
-#if defined(HAVE_STRUCT_STATX)
-#include <sys/stat.h>
-#else
+#ifndef HAVE_STRUCT_STATX
 struct statx {
 	/* 0x00 */
 	uint32_t	stx_mask;
@@ -106,8 +104,7 @@ struct statx {
 };
 #endif
 
-#if !defined(HAVE_STATX)
-
+#ifndef HAVE_STATX
 /*
  * statx: wrapper function of statx
  *
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
