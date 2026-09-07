Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA2C0C79FA0
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 19:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788810286; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=QGPrBu1fM1XCLnomKD3cfI66kdHG3bngncgHS60n7mU=;
 b=WLXSRlGNt0tqq6I3gJij8IE4XqL5fb43rnpCdtSuU0s+xsPyVdRF0V9vrloAHXogmVoyd
 okfxsPqvLtzz+VGP9fRPJjUZ1sIuVLNgMMdZVAfhjw83pvMD721jApMQK7LSf+tHyUPR+VJ
 aFnHfHK5RaItZa7QZT+paUitI6PGQsQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F5433E951F
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 21:44:46 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 51B963D0360
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 21:44:26 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6DED51000643
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 21:44:25 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49b8ce9b733so31154815e9.1
 for <ltp@lists.linux.it>; Mon, 07 Sep 2026 12:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788810265; x=1789415065; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ltLsTzTUcoBEnQMkqOsxJlcbRVA1A+brbl+BnBzSqk0=;
 b=KLRTPY2mZe8dqpaI45xFg9bWkCmrmeyHosDMBft65BX1WAe+8RzvI/Hu1fxR8fXtn6
 L8fI7gTsjHvUeVo2PLoZp1g5V/RLlclj7NNFvcVOnHnA3/Nvi4TI6OJvJyHb79B/4qNj
 9jibLYYqKYIlunAjtO87dyBabrdf+ntkNAIw+1JvDZvMrcAe7FXn5ENZhHJtcHRN516Q
 a0gtCw8cac+Iq70NSmQDa4fwM/Im3/9bf7uTNf85MakkvZWrP4H8KCw4kVqqTW5j6zjI
 RKQjmjTNY2C7MgXBwgR0FV+WNkQ1LpvRDFvi9iLF0Hi1b4xlwAuha0YeXb6i3A1X84ou
 dOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788810265; x=1789415065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ltLsTzTUcoBEnQMkqOsxJlcbRVA1A+brbl+BnBzSqk0=;
 b=A5vqwlCi0a5G0qSaYT19AioNktwrLRPDY7meChdxz0ebW42FFb8P3LeY86VsjTUuox
 eyEJxl3envTfadbyv3s/wvZ51nO/CX+oBVKMmBVnBfpB3QepPMnfJSIPjFk1Mp1YXtWS
 ge9TGbejyXV/WwTEX5FbAH3OWRNxAtjkqPgByg/nQfthjo8WAST6AOG+ANSJRgRR85Z4
 xsWYVYxcRK5HciD47Qp9Qqic8QtZOKgZrWSDxrWhxalWL17vBBRPGvTrSXRicvCxVcLx
 vwrripLZ5FL0uwnxRiPqVMLUUsA+FxTKcKw1sLmkdfh1yeLTclFefQPJZV1nNQKi0cPF
 +JLw==
X-Gm-Message-State: AFuF++mzbw7wPdKpEVzHn+O8Bbybgk6KIXd9ghKWy9nIjWAU/uviG36M
 uGas9bm1H78OqIOdLMhyvUQMg4Q28h6IyAb74aqBCiKK4W6s8VCMZXl7cYtcmZ0CirHfl5XkmpF
 Wd4gz9UQ=
X-Gm-Gg: AYBFou3VY/OArCwBSYBShb6yZr4ZvIq2EHQeDV0yAuXwXlxUgpF2mCDS2YGtO6F8Xft
 6OdYjUso8ApQfszrojPMdVDIyl7OFiQooyvCy61inOoJ7BmZgPvnBQdkdXLiPJYIXXWU7U3SHsA
 fj+LPcJ9uM7zPT4gCGGUS6cd0+DcYUWHLqDWX0htvsBuQVhibBS2uZtRrynsI+zbu+apXns1NJz
 ZrXhLs6tJ8GqNAkvUyNtTPxyHsA4vlio6anZMoQd/Y5cyM4GAklc4aWtfTu+tcUxu8kNxzkjhoB
 lp6ouPU1b1tHswbc3oT/omSplQn3wg+NRTgNb1NJHg00t0nadN0MS7oxcrKrkl4YU3JrPTMrUR3
 lGYkGVfbpP71fobwFALH49wCGwtdz/4TCyKSWCVei3YAjrUOGUHDoGKZY6FvdQmwjuBqyVaGZuW
 7zxNHEgyB1Kq9O4eJyEMasyhKNfJBf/qarhpF7XsX3DpYP9Q==
X-Received: by 2002:a05:600c:3544:b0:49c:f5c0:aa79 with SMTP id
 5b1f17b1804b1-49cf8244bd0mr253707815e9.9.1788810264583; 
 Mon, 07 Sep 2026 12:44:24 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee6024a8sm434737705e9.6.2026.09.07.12.44.23
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 12:44:23 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon,  7 Sep 2026 21:44:21 +0200
Message-ID: <20260907194422.414746-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <apmHTcCUhxRMdcVg@yuki.lan>
References: <apmHTcCUhxRMdcVg@yuki.lan>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] uevent02: Make wait_for_uevents() order-independent
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Avinesh Kumar <avinesh.kumar@suse.com>

Commit 8e63c9e6179a ("net: Defer netdev KOBJ_ADD uevent until the
device is published")[0] moved a network interface's "add" uevent to
after its queue kobjects are created, flipping the uevent order for
tun device creation from:

    add(net), add(rx queue), add(tx queue)
to:
    add(rx queue), add(tx queue), add(net)

wait_for_uevents() matches events strictly in array order, so on
kernels with the new order "add(net)" is still awaited after its queue
events have already been consumed off the socket, and uevent02 hangs
until it times out and fails.

The relative order of these uevents is a kernel implementation detail
the test shouldn't depend on. Track still-unmatched events in a
pending set and match incoming uevents against any of them regardless
of position.

wait_for_uevents() leaves fd open so it can be called more than once on
the same socket, keeping independent lifecycle phases ordered: uevent02
matches all add events before looking for the remove events.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8e63c9e6179a

Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 testcases/kernel/uevents/uevent.h   | 39 +++++++++++++++++++++++------
 testcases/kernel/uevents/uevent02.c | 29 +++++++++++++--------
 2 files changed, 49 insertions(+), 19 deletions(-)

diff --git a/testcases/kernel/uevents/uevent.h b/testcases/kernel/uevents/uevent.h
index 1ad092d5ea39..495c1254ff10 100644
--- a/testcases/kernel/uevents/uevent.h
+++ b/testcases/kernel/uevents/uevent.h
@@ -6,6 +6,8 @@
 #ifndef UEVENT_H__
 #define UEVENT_H__
 
+#include <stdint.h>
+#include <string.h>
 #include "tst_netlink.h"
 
 /*
@@ -119,13 +121,30 @@ static inline int open_uevent_netlink(void)
 
 /*
  * Reads events from uevent netlink socket until all expected events passed in
- * the uevent array are matched.
+ * the uevent array are matched. Events do not have to arrive in the order
+ * they are listed in the uevents array, since the kernel is free to reorder
+ * unrelated uevents, e.g. commit 8e63c9e6179a ("net: Defer netdev KOBJ_ADD
+ * uevent until the device is published") changed the order in which a
+ * network interface and its queues announce themselves.
+ *
+ * Does not close fd; the caller owns the socket and can call this more
+ * than once on it to keep independent lifecycle phases ordered, e.g.
+ * matching all "add" events before looking for "remove" events.
  */
 static inline void wait_for_uevents(int fd, const struct uevent_desc *const uevents[])
 {
-	int i = 0;
+	int i, cnt = 0, remaining;
+
+	while (uevents[cnt])
+		cnt++;
+
+	uint8_t matched[cnt];
+
+	memset(matched, 0, sizeof(matched));
 
-	while (1) {
+	remaining = cnt;
+
+	while (remaining) {
 		int len;
 		char buf[4096];
 
@@ -136,11 +155,15 @@ static inline void wait_for_uevents(int fd, const struct uevent_desc *const ueve
 
 		print_uevent(buf, len);
 
-		if (uevent_match(buf, len, uevents[i])) {
-			tst_res(TPASS, "Got expected UEVENT");
-			if (!uevents[++i]) {
-				close(fd);
-				return;
+		for (i = 0; i < cnt; i++) {
+			if (matched[i])
+				continue;
+
+			if (uevent_match(buf, len, uevents[i])) {
+				tst_res(TPASS, "Got expected UEVENT");
+				matched[i] = 1;
+				remaining--;
+				break;
 			}
 		}
 	}
diff --git a/testcases/kernel/uevents/uevent02.c b/testcases/kernel/uevents/uevent02.c
index 1135f55a87db..a48239d2a40e 100644
--- a/testcases/kernel/uevents/uevent02.c
+++ b/testcases/kernel/uevents/uevent02.c
@@ -25,7 +25,8 @@
 #include "uevent.h"
 
 #define TUN_PATH "/dev/net/tun"
-#define MAX_UEVENTS 7
+#define MAX_ADD_UEVENTS 4
+#define MAX_REM_UEVENTS 4
 
 static struct uevent_desc add = {
 	.msg = "add@/devices/virtual/net/ltp-tun0",
@@ -88,7 +89,9 @@ static struct uevent_desc rem = {
 		"INTERFACE=ltp-tun0",
 	}
 };
-static const struct uevent_desc *uevents[MAX_UEVENTS];
+
+static const struct uevent_desc *add_uevents[MAX_ADD_UEVENTS];
+static const struct uevent_desc *rem_uevents[MAX_REM_UEVENTS];
 
 static void generate_tun_uevents(void)
 {
@@ -114,7 +117,9 @@ static void verify_uevent(void)
 	if (!pid) {
 		fd = open_uevent_netlink();
 		TST_CHECKPOINT_WAKE(0);
-		wait_for_uevents(fd, uevents);
+		wait_for_uevents(fd, add_uevents);
+		wait_for_uevents(fd, rem_uevents);
+		close(fd);
 		exit(0);
 	}
 
@@ -128,19 +133,21 @@ static void verify_uevent(void)
 static void setup(void)
 {
 	struct tst_kconfig_var kconfig = TST_KCONFIG_INIT("CONFIG_RPS");
-	int i = 0;
+	int i = 0, j = 0;
 
 	tst_kconfig_read(&kconfig, 1);
 
-	uevents[i++] = &add;
+	add_uevents[i++] = &add;
 	if (kconfig.choice == 'y')
-		uevents[i++] = &add_rx;
-	uevents[i++] = &add_tx;
+		add_uevents[i++] = &add_rx;
+	add_uevents[i++] = &add_tx;
+	add_uevents[i++] = NULL;
+
 	if (kconfig.choice == 'y')
-		uevents[i++] = &rem_rx;
-	uevents[i++] = &rem_tx;
-	uevents[i++] = &rem;
-	uevents[i++] = NULL;
+		rem_uevents[j++] = &rem_rx;
+	rem_uevents[j++] = &rem_tx;
+	rem_uevents[j++] = &rem;
+	rem_uevents[j++] = NULL;
 }
 
 static struct tst_test test = {
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
