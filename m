Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D35C88E53
	for <ltp@archiver.kernel.org>; Tue, 15 Sep 2026 11:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1789472275; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=lMpE54xlGBrDy3u48a4ldmH4b4FCyvzU1TtRW+vZze4=;
 b=UvcIGgjHT7ET6A2FqsLyRgXqZteoshOxiMRBk3OQzAKqXDUuWFpx2gUFFBTQmn8yVS7Nu
 4CQwEyFBFnEnwvsdcViI/TDFW1xN1QLng64GONJEX/Q5oNuJskVw/cxAkidcI+dBmfNIMbQ
 lfugAiDMNtw++KuGjNYoiNewogOznoE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3AB953E8CAC
	for <ltp@archiver.kernel.org>; Tue, 15 Sep 2026 13:37:55 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE28D3E8C9C
 for <ltp@lists.linux.it>; Tue, 15 Sep 2026 13:37:35 +0200 (CEST)
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E9E32100094C
 for <ltp@lists.linux.it>; Tue, 15 Sep 2026 13:37:34 +0200 (CEST)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e7d2bb404so3595825e9.1
 for <ltp@lists.linux.it>; Tue, 15 Sep 2026 04:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1789472254; x=1790077054; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ux8CwU6mdh7cYE8MeqcY/myx+URJpsn/7tXwIF3Y3gc=;
 b=VPVnxJ2+5x2+VG0k4AyauBKvl0p6bfskOJQ3oqx3KL+L7QtP1w0tUEA150qFoo8BYh
 11SquHCLUb5P+cPzVH8GIvbirKO+9tK7hQta0BRcvpTJI4nOOxr7Lirwr+GTriMfd9SU
 2Rh3wUDOFQyf/abNolbZwHwUR/4rGUKfbvlfUSTajS1DETgLQ5jX3GuJkKw/BDzSPINQ
 1LNRKSxoxvoRWFMU1g3fszfo5+g3Ws/Eq1tMV2J8GW98mczzOf0JFKZ3iiDSSLonvrFL
 3s0MT+7ncQdrdckXN7FOr9J7R7WydeVTOjQGPhoaT5RU8zbSIcJrj8sqOseR+HhBjH8n
 HmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789472254; x=1790077054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ux8CwU6mdh7cYE8MeqcY/myx+URJpsn/7tXwIF3Y3gc=;
 b=SbGbjPnC5kZV2xF+TEeFD4OgeUM3ezKAFoHWg9+ydRroUmSxqK7DiFK18JUqT3uarQ
 oybYvd6Aw9RIK3ARGyu4ft24JzWH4c1dIwmQrg70SR6JXcNWQ8OkDqxJKYDF2qe4LVub
 Yd9nOocH4vUamR3XUVWHP3N2hkFuyvFISTChxxP8J2gOeJS9xq8HZ+6bqarNuVj2yIB/
 sODx1sF34ke0jGUIgWa82yNNnJe/km2ldPrGzxMZv+1hlNnRAcJOd3kD/vYF7QeM2ybG
 Cs3qwg7rYq9oZt0u9snR8FS6IKx6bvxDAVM3pgLlr20+3LmjpdEyMLFB0H9kD5E652GD
 59tA==
X-Gm-Message-State: AFuF++mOO4AUkhei79EgRrOJ4oNmcSapS9PRzMKt5CphpNrdZZUtaDi/
 rqdd1+iITgNDjEoq8E5pu1/T4mTE971ZR14uvPiLxF7fRQyJx67Q8BCMHIlNNK3eHWA93RMaaZy
 kNoU2dac=
X-Gm-Gg: AYBFou0Hpmy5fUVi5LHyV+G2HCWgVG+WR9WzuV2IdFBAWXGSLBbVZ8MkyQrHRKNG1a5
 PL/oWL4SIbsnRE3F6BlKIvR1m9+YH9NFZvW39lgoHhHSHZcVg4ZCiQWFJZ5AFu4zEFRilWaq6RE
 TtKiyjcq5cHjxCuxwpY3FhMPU6YRMRs/SCvYN6N1ZcFxSE91cVHYkl+3tVvWQrZeK6f2ESm4LWs
 iipv3xosnFSZl/Nb9fQkk46VA2mDUELV73/qIpsF3gYmWN6vGBEgrVB9SCintAUkdrCJFLWYGfv
 rvs+b5kTSWJB0TZaLefK+BNu8PWH5eUaO169d/1v9Can8Bqv6QKR/CqLw6pPykQ8xX7BhoTA/Hy
 pgVfzIRPB3qGExMaSoOKIWHv6k+YkjzVXQndEroIdhi3GwJuk3VojrWO0IXY7mgyl4nLqMdePqy
 JIswSh2OfvrFVKzbe4WUOeCIsAnGiI45cBcHSO1/DWaufNYpnOXgQHPjF3
X-Received: by 2002:a7b:c8c4:0:b0:49e:6865:904e with SMTP id
 5b1f17b1804b1-49e7d749568mr30314435e9.12.1789472254183; 
 Tue, 15 Sep 2026 04:37:34 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e8311c21csm2151495e9.2.2026.09.15.04.37.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 04:37:33 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 15 Sep 2026 13:37:31 +0200
Message-ID: <20260915113733.47046-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <aqkjv-oIgNgHYROA@yuki.lan>
References: <aqkjv-oIgNgHYROA@yuki.lan>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] uevents: introduce wait_for_uevents_unordered()
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
the test shouldn't depend on, but other callers rely on
wait_for_uevents() enforcing order between related events, so add a
separate wait_for_uevents_unordered() instead of relaxing it there:
it tracks still-unmatched events and matches incoming uevents against
any of them regardless of position.

wait_for_uevents_unordered() also leaves fd open so it can be called
more than once on the same socket, keeping independent lifecycle
phases ordered: uevent02 matches all add events before looking for the
remove events.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8e63c9e6179a

Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 testcases/kernel/uevents/uevent.h   | 54 ++++++++++++++++++++++++++++-
 testcases/kernel/uevents/uevent02.c | 29 ++++++++++------
 2 files changed, 71 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/uevents/uevent.h b/testcases/kernel/uevents/uevent.h
index 1ad092d5ea39..dee63d20f0af 100644
--- a/testcases/kernel/uevents/uevent.h
+++ b/testcases/kernel/uevents/uevent.h
@@ -6,6 +6,8 @@
 #ifndef UEVENT_H__
 #define UEVENT_H__
 
+#include <stdint.h>
+#include <string.h>
 #include "tst_netlink.h"
 
 /*
@@ -119,7 +121,7 @@ static inline int open_uevent_netlink(void)
 
 /*
  * Reads events from uevent netlink socket until all expected events passed in
- * the uevent array are matched.
+ * the uevent array are matched, in the exact order they are listed.
  */
 static inline void wait_for_uevents(int fd, const struct uevent_desc *const uevents[])
 {
@@ -146,6 +148,56 @@ static inline void wait_for_uevents(int fd, const struct uevent_desc *const ueve
 	}
 }
 
+/*
+ * Reads events from uevent netlink socket until all expected events passed in
+ * the uevent array are matched. Unlike wait_for_uevents(), events do not have
+ * to arrive in the order they are listed in the uevents array, since the kernel
+ * is free to reorder unrelated uevents, e.g. commit 8e63c9e6179a ("net: Defer
+ * netdev KOBJ_ADD uevent until the device is published") changed the order in
+ * which a network interface and its queues announce themselves.
+ *
+ * Does not close fd; the caller owns the socket and can call this more
+ * than once on it to keep independent lifecycle phases ordered, e.g.
+ * matching all "add" events before looking for "remove" events.
+ */
+static inline void wait_for_uevents_unordered(int fd, const struct uevent_desc *const uevents[])
+{
+	int i, cnt = 0, remaining;
+
+	while (uevents[cnt])
+		cnt++;
+
+	uint8_t matched[cnt];
+
+	memset(matched, 0, sizeof(matched));
+
+	remaining = cnt;
+
+	while (remaining) {
+		int len;
+		char buf[4096];
+
+		len = recv(fd, &buf, sizeof(buf), 0);
+
+		if (len == 0)
+			continue;
+
+		print_uevent(buf, len);
+
+		for (i = 0; i < cnt; i++) {
+			if (matched[i])
+				continue;
+
+			if (uevent_match(buf, len, uevents[i])) {
+				tst_res(TPASS, "Got expected UEVENT");
+				matched[i] = 1;
+				remaining--;
+				break;
+			}
+		}
+	}
+}
+
 /*
  * Waits 5 seconds for a child to exit, kills the child after a timeout.
  */
diff --git a/testcases/kernel/uevents/uevent02.c b/testcases/kernel/uevents/uevent02.c
index 1135f55a87db..f3d2ebc87a74 100644
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
+		wait_for_uevents_unordered(fd, add_uevents);
+		wait_for_uevents_unordered(fd, rem_uevents);
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
