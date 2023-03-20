Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138DCC7618A
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 06:31:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 26C023CCC4E
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 07:31:10 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 77E9E3CA728
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 07:30:58 +0100 (CET)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EDFD91400278
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 07:30:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1679293855; i=@fujitsu.com;
 bh=tift1TjXbRsbeRgQ52sKA8rsQgi1e+eaQlIxaA82S10=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=b2mqVG76RXKJw/o/TfGw8+mP6goi1y2p9lFoQrSd200eEEDPTuF+D3T+VY/6MQOlg
 cn9rVR+vM+GjG07s9GzS0dPYSb3UJyzRANB9/GxO/gC7Dw9xd5laIviWaE0yJfchmy
 CZ5scsoQUHC/FODW1kaUCxfhk21jR6KCZyA7dlK5V74nj7Dxv1452KMQkxjkuTlEWb
 UlHFatt6Qi5EOug1SHUaISOV0Wo+4x+epptVvHOSHfqKqYSso8OIDBiW4+/3qW2DYr
 W+T8BaH/3ry0OZeEIV5vIwlWq/xivoBye2t4QxK9MiekS4K24P6g20gP3uE0SIkgX9
 EK0MytkHrqpGg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRWlGSWpSXmKPExsViZ8ORpDv/r3i
 KwezLIhYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8ak30vYCs4zV5zom8zewNjB3MXIxSEkcIpR
 Ys72GSwQzl4miS/bJkJl9jJKTJj3lLGLkZODTUBT4lnnAmYQW0RAQqKj4S07iM0soC6xfNIvJ
 hBbWMBQYu3E22D1LAKqEst2vGEFsXkFPCWevfvKAmJLCChITHn4nhkiLihxcuYTFog5EhIHX7
 xghqhRkmhrvcIKYVdINE4/xARhq0lcPbeJeQIj/ywk7bOQtC9gZFrFaFacWlSWWqRraKmXVJS
 ZnlGSm5iZo5dYpZuol1qqW55aXKJrqJdYXqyXWlysV1yZm5yTopeXWrKJERiOKcWsx3cwzur7
 q3eIUZKDSUmU9/gb8RQhvqT8lMqMxOKM+KLSnNTiQ4wyHBxKErxHfwHlBItS01Mr0jJzgLEBk
 5bg4FES4bX+BJTmLS5IzC3OTIdInWJUlBLn/f8bKCEAksgozYNrg8XjJUZZKWFeRgYGBiGegt
 Si3MwSVPlXjOIcjErCvB9BpvBk5pXATX8FtJgJaPH9SSIgi0sSEVJSDUxM7FE9kvP+OQhxugd
 eUGH5zyEmkLhx82eTP27tjbe7xN8dVDn55/mUgGubvrk4OKSddfP9Ki/2/6XjYjHWuD1fSjfP
 D1d1CO7QKFrueTfkmrnbj3usl117Lb/v0HyhYKAdypPisG2p9/nTtzuK+lmMyy08P376uv9F5
 vL8xkU7zqQVT5RdoaDcan20Jm8d98Ydc6YeP3jDgt3CZ5KvbsjMpAWunh3urUfbpXrfibiXbw
 /n660urRDbqSO4oerzpMuTc6vbZKqNCt9ff+S/Zo7tcyu+/YqBntNdP0isjNm7YJGDqKDOvIw
 M8V+/mqNKkhVKJD0Ol/+Qf1Wv3N7I9zHd/cQu9luq3Av1vQTeKLEUZyQaajEXFScCAIyTt69C
 AwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-12.tower-587.messagelabs.com!1679293855!468588!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 10048 invoked from network); 20 Mar 2023 06:30:55 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
 by server-12.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 20 Mar 2023 06:30:55 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id EB4AD1B2
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 06:30:54 +0000 (GMT)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121
 [10.183.43.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id E04B41AC
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 06:30:54 +0000 (GMT)
Received: from localhost.localdomain (10.167.215.131) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Mon, 20 Mar 2023 06:30:53 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 20 Mar 2023 14:30:19 +0800
Message-ID: <1679293822-19378-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.215.131]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/4] lapi/sem.h: Add SEMMSL macro
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

This macro is used to trigger semget EINVAL error.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/lapi/sem.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/lapi/sem.h b/include/lapi/sem.h
index 495afe937..ba559d2f1 100644
--- a/include/lapi/sem.h
+++ b/include/lapi/sem.h
@@ -24,4 +24,8 @@ union semun {
 # define SEM_STAT_ANY 20
 #endif
 
+#ifndef SEMMSL
+# define SEMMSL 32000
+#endif
+
 #endif /* LAPI_SEM_H__ */
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
