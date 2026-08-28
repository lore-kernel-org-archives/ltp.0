Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F36C61DBD
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 15:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787930815; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=i41/4Vxmjnhhc81GB5TKj4D36tAsJirMkTYyoz8gGg0=;
 b=Tdfw/8TFH/k131JVxvI6YExGKRv+AHmFauYVOgyVo3poZkpqrTcusZOJ3iNaM4lnl+FjX
 r+ULBVf5h2pLMJHIYa0aWR5kMqeWWgGvD3R1Sjq8aHQXzzYwX76EMyMSmeqWsNzS347uiVo
 GZsjRiDMHFhkyV04GUOgu0s29fxfEQc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CAE823E9A63
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 17:26:55 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A67E63E5E02
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 17:26:34 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 231981000364
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 17:26:34 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-499b2981a7bso11783675e9.3
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 08:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787930793; x=1788535593; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=onNWlpQi8lOFYaoRvJrb5C1w1e54kxisKKQO8A/f62Q=;
 b=TVErrnTFacI5ZskYYIafTAR41h02NnAX3ygkuBFW1HlvdVqK8UHYW8Uhi8l57CTzDc
 MfSvF/nquERSh4iuaBnoKwTy4fvdtTjvG7gtcPvRC4fH56ekNb7uZO/4H9o8wFQ6p4bU
 kx+dtiFu+BMRcOlDFy1mRr7nq0bXyJdL8w7VGtgHSNr4T2VnCdZ0tNPaTYIxUUz4tTEY
 +g7CNG/qp8q4/Pht4vNuQg5lO89VllyePCi52zBfT2IdaMnXNur7p1fxMB3ccp1lyeob
 mDWgkoLDm9P2fhj7FhJNPwPnLAGXC0EiiH+wKCp+HFE1wx7WhXjJUv+EOTRTdKbUgpsy
 d8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787930793; x=1788535593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=onNWlpQi8lOFYaoRvJrb5C1w1e54kxisKKQO8A/f62Q=;
 b=R4mbPW/k0CS/UUEs+hEAVreWFb3PAXh2jilccGeXESM8rKIDrac7mrLHpehkm7+Jwp
 brGgGQqYtvd61YGxtHFs2QPR37IdUUsV5GaYBc2iWLQW/KewK2LWZVMoioT3YsE/P5aC
 MxP80/Mao7c+gAh+oQh5QuWj/KEHRpNo0IA5vJNghZ8/Vfw1E6E3Aso8Lm6YVa8CBb1/
 8QVqyUMSiK6xLxxmHN3xqejGpe93Ute5llzebg+iv+b1TNNTkrvNhUZqkTjtz8RXRT+6
 owF+broUOlE2KEZ2+JcKComwIeLhwjNpX7AG3J9ncNmk3BGqqf89LjiXnEzVWDtF+ndC
 TOfA==
X-Gm-Message-State: AFuF++k254r2UanP6lbZH3dEufNtL3LA/qXNT4RTzSBhKOTGrkVV+QVM
 B2L6erfp1kB+CJE/wjETteksqYCodBFqWl0CGi/XWIoH4TKZI8nIMQq6Fq6YK3cttny+CkU262c
 YqXi7B+4=
X-Gm-Gg: AR+sD136cWY/Gf2QRaZvDWk64++sB+dk1uCNTOUr5pQR0qkmfOlR6I51gTBh53IB8nY
 v29KU2be0x8eRuDSNtMsFpebxyobfU1jqT+nVzkg1JWPr9mEqTmJEITS3CqhqTsw3xeaBXKvCJq
 KEqg+9BYFKDXgGHCMF37Ry0oYNMmtxoJhXdQQryY7b/5f6KtQmgsabLT0XbkR4XFl5cZKIs5aJ5
 N8cIiqyBotKrFB3TRFBlpWXGHngDtp4jFhEn7VCMBz0sNKeGmYHZEgpbRTu1dH0nQ/IRR9JUQ22
 G6j1MSVqBTb6CjL1AF89tU6ocg90AtV5AJg9DIqDXTkJgjVgxJlaWiNAVIqhkRq+oC8DGNTiReY
 25bANXQ+0fs4048YDLHIykDrDHWQP0AjJOmtWiw+lPcLXFVWqDEEj3j27nYcTlThNdeUi3Vz/V9
 XGLlY4yklUHF7x3n6syl8Q6WzXB/foqnw27tHERoxNaQowUw==
X-Received: by 2002:a05:600c:3baa:b0:499:a685:c10 with SMTP id
 5b1f17b1804b1-49b91c27495mr127056575e9.4.1787930793471; 
 Fri, 28 Aug 2026 08:26:33 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b95013d06sm82204715e9.12.2026.08.28.08.26.32
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 08:26:32 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 28 Aug 2026 17:26:30 +0200
Message-ID: <20260828152631.254653-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825173613.8867-1-linuxtestproject.agent@gmail.com>
References: <20260825173613.8867-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] uevent02: Make wait_for_uevents() order-independent
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
 testcases/kernel/uevents/uevent02.c | 28 +++++++++++++--------
 2 files changed, 48 insertions(+), 19 deletions(-)

diff --git a/testcases/kernel/uevents/uevent.h b/testcases/kernel/uevents/uevent.h
index 1ad092d5ea39..f7e7c671e499 100644
--- a/testcases/kernel/uevents/uevent.h
+++ b/testcases/kernel/uevents/uevent.h
@@ -117,15 +117,34 @@ static inline int open_uevent_netlink(void)
 	return fd;
 }
 
+#define UEVENT_MAX_PENDING 16
+
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
+	const struct uevent_desc *pending[UEVENT_MAX_PENDING];
+	int i, cnt = 0, remaining;
+
+	while (uevents[cnt]) {
+		if (cnt >= UEVENT_MAX_PENDING)
+			tst_brk(TBROK, "Too many expected uevents, increase UEVENT_MAX_PENDING");
+		pending[cnt] = uevents[cnt];
+		cnt++;
+	}
+	remaining = cnt;
 
-	while (1) {
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
+			if (!pending[i])
+				continue;
+
+			if (uevent_match(buf, len, pending[i])) {
+				tst_res(TPASS, "Got expected UEVENT");
+				pending[i] = NULL;
+				remaining--;
+				break;
 			}
 		}
 	}
diff --git a/testcases/kernel/uevents/uevent02.c b/testcases/kernel/uevents/uevent02.c
index 1135f55a87db..26c0dbd10547 100644
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
@@ -88,7 +89,8 @@ static struct uevent_desc rem = {
 		"INTERFACE=ltp-tun0",
 	}
 };
-static const struct uevent_desc *uevents[MAX_UEVENTS];
+static const struct uevent_desc *add_uevents[MAX_ADD_UEVENTS];
+static const struct uevent_desc *rem_uevents[MAX_REM_UEVENTS];
 
 static void generate_tun_uevents(void)
 {
@@ -114,7 +116,9 @@ static void verify_uevent(void)
 	if (!pid) {
 		fd = open_uevent_netlink();
 		TST_CHECKPOINT_WAKE(0);
-		wait_for_uevents(fd, uevents);
+		wait_for_uevents(fd, add_uevents);
+		wait_for_uevents(fd, rem_uevents);
+		close(fd);
 		exit(0);
 	}
 
@@ -128,19 +132,21 @@ static void verify_uevent(void)
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
