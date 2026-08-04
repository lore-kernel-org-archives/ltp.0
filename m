Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EB7C55182
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 01:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785808771; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=DXioI2WuqpA+0m6wPONU/xTniqX5pr3vhx78/BDDGWA=;
 b=iaopxdeQOQs1nvEAJ/FsQwMhWSuhrMqh95wMfcghp4ycx40XAdQvSSY5jMia5ThKqbcLw
 lgaRDdYS3bc2/XqtWVyN3F+FZkWI9Rb/pet/+QXpM0GOS7LUrGs3v0cu7U9s11cUiS8qJcG
 jTywgJaVhPWuM232soleo56DcGbIGdY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 70B063E7211
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 03:59:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 469513E2C19
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 03:59:10 +0200 (CEST)
Received: from mail-pj1-x1048.google.com (mail-pj1-x1048.google.com
 [IPv6:2607:f8b0:4864:20::1048])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BC64D60094E
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 03:59:09 +0200 (CEST)
Received: by mail-pj1-x1048.google.com with SMTP id
 98e67ed59e1d1-38dd87656d3so5532984a91.2
 for <ltp@lists.linux.it>; Mon, 03 Aug 2026 18:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785808748; x=1786413548; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qfYd3JYsDvGUeWNdf+rKvJWu6m5Khzp+1P6pLMgrniw=;
 b=aGgoY9xmgElH78Oy7B6efhOzBQN2dV2LQyHwjZShDzC+3rCHmexxj7rdhkRvfm0Y8H
 7BjZkC6YUhT6rrPCO3k63gOdXz5IW+g/EgOhJHt9eAiEaEmtixU+X2LAFl+VW0pMtosG
 1/eeS51GuQaWTAO+XKWBfNJt0CS8uO0k5wuYGB5llrhMEGaOEIzFOKZ+9PHVfh/3HtkS
 HzqjGarM7vFBY+NAzPdXdJegYgpbQST/xy85ysqdTZPh603KIUpUOgIU0EBmg5QOCpwC
 tYP8iuR4DFQMwL5z5tAlxz2gJV/XUZ/PVBDoFH2WArenq9Ptn1/LG/uGCX/9nL7oJ11v
 VtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785808748; x=1786413548;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qfYd3JYsDvGUeWNdf+rKvJWu6m5Khzp+1P6pLMgrniw=;
 b=H57g2ns01QQqP63LszgdFUmiz+Ez9uuJX/FDVQ7BSZu+m6OnbD/aSq5DfTiwK0kGXY
 OShZcOzugxskm9QpoHmVURyA+3KjXsTOTmTjwwhTKOz+JtKrMqGuR8Va3lC69llgCHL/
 QTYThKfwLlxP7xx1Uxs5huNnF3rGVTYt6UjEQwCpurGFo4rZkbAFZde0DaDssxxt8e0A
 942lQ/5CGfGUkYFWovrhEp/l3Awmrh6oI6wql2o3E2x7/L4GpoVOrgUbleJwAVEo6VOY
 furAyEvy1y96hbT6WOekALBt+YkRQ4bldZdpvYRJJTgXHB0Y1HbENPBZFo4oOvQd02Wc
 df2A==
X-Gm-Message-State: AOJu0Yx4kYPZcIaeyjrJFTbKfdBvjoUOixthteBxoO8v58LKZb4ok64R
 W2UrfV+UWcAh6teU1jlaUVyrU4RlyF8XoZsHMlVeCdka8Y6nrpm6foLhv+VBW//iqcb40gur9tw
 KQb4KRXsmnAxNEHBh91CDRhuf8Q9z3KIGrzE/u0UuNSodMQn5cs6svrQpGDw9qYMXkyXVPga2mg
 OsT8VsDFg09Fma1lmNYs9NCZWhJA==
X-Received: from pjbmp4.prod.google.com ([2002:a17:90b:1904:b0:384:f6e1:ff81])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2dca:b0:38e:9045:bac0
 with SMTP id 98e67ed59e1d1-38fbc408af7mr11924790a91.5.1785808747624; Mon, 03
 Aug 2026 18:59:07 -0700 (PDT)
Date: Tue,  4 Aug 2026 01:59:05 +0000
In-Reply-To: <20260803152754.3991113-1-wakel@google.com>
Mime-Version: 1.0
References: <20260803152754.3991113-1-wakel@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804015905.74573-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] lib: Use backoff polling to wait for loop device
 nodes
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
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: wakel@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Wake Liu via ltp <ltp@lists.linux.it>

On systems where loop device node creation is asynchronous (such as Android
containers or systems with slow udev startup), calling stat() or open()
immediately after LOOP_CTL_GET_FREE can transiently fail because the
device file (e.g. /dev/loopX) has not been fully populated in time.

Introduce an exponential-backoff retry loop in both
tst_find_free_loopdev() and tst_attach_device() (starting at 1ms delay,
doubling each try, capped at 100ms) to wait for the device node to be
successfully populated.

This improves the robustness of loop device allocations on asynchronous
virtualized environments while minimizing unnecessary delays on responsive
systems.

Link: https://lore.kernel.org/ltp/20260803152754.3991113-1-wakel@google.com/
Signed-off-by: Wake Liu <wakel@google.com>
---
v1 -> v2:
 - Strictly clamp backoff delay to 100ms (prevent overflow exceeding cap).
 - Skip usleep on final loop iteration to avoid unnecessary idle delay.
 - Reduce max attempts to 30 (stat) and 15 (open) to bound worst-case timeout.

 lib/tst_device.c | 32 +++++++++++++++++++++++++++-----

diff --git a/lib/tst_device.c b/lib/tst_device.c
index 744173ffef..19e1a8a25c 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -82,7 +82,7 @@ static int set_dev_loop_path(int rc, char *path, size_t path_len)
 
 int tst_find_free_loopdev(char *path, size_t path_len)
 {
-	int ctl_fd, dev_fd, rc, i;
+	int ctl_fd, dev_fd, rc, i, path_set;
 	struct loop_info loopinfo;
 	char buf[PATH_MAX];
 
@@ -94,8 +94,18 @@ int tst_find_free_loopdev(char *path, size_t path_len)
 		if (rc >= 0) {
 			if (path) {
-				if (set_dev_loop_path(rc, path, path_len))
-					tst_brkm(TBROK, NULL, "Could not stat loop device %i", rc);
+				unsigned int usec = 1000; /* start with 1ms */
+
+				for (i = 0; i < 30; i++) {
+					path_set = set_dev_loop_path(rc, path, path_len);
+					if (!path_set)
+						break;
+					if (i < 29) {
+						usleep(usec);
+						usec = usec * 2 < 100000 ? usec * 2 : 100000;
+					}
+				}
+				if (path_set)
+					tst_brkm(TBROK, NULL, "Could not stat loop device %i", rc);
 			}
 			tst_resm(TINFO, "Found free device %d '%s'",
 				rc, path ?: "");
@@ -166,9 +176,8 @@ int tst_find_free_loopdev(char *path, size_t path_len)
 
 int tst_attach_device(const char *dev, const char *file)
 {
-	int dev_fd, file_fd;
-	struct loop_info loopinfo;
-	int attach_tries = 20;
+	int dev_fd, file_fd, i;
+	struct loop_info loopinfo;
 	unsigned int usec = 1000; /* start with 1ms */
 
 	if (strlen(file) >= LO_NAME_SIZE) {
@@ -175,13 +184,14 @@ int tst_attach_device(const char *dev, const char *file)
 			 LO_NAME_SIZE);
 	}
 
-	while (attach_tries--) {
+	for (i = 0; i < 15; i++) {
 		dev_fd = open(dev, O_RDWR);
 		if (dev_fd >= 0)
 			break;
-		usleep(usec);
-		if (usec < 100000) /* cap backoff at 100ms */
-			usec *= 2;
+		if (i < 14) {
+			usleep(usec);
+			usec = usec * 2 < 100000 ? usec * 2 : 100000;
+		}
 	}
 	if (dev_fd < 0) {
 		tst_resm(TWARN | TERRNO, "open('%s', O_RDWR) failed", dev);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
