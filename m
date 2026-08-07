Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08339C5AD05
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 23:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786146604; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=j6EFcrxE3uajqvdpcj34g01j9lN+ueU2cio8lGfLorQ=;
 b=EeLzm5FexeQDHJK7N/z37G62QzVC0huPL3og3yq4Nn6+eS1AEYYVRGQXQeE9CXZZN+qYx
 5XL7DvhktOdLf2UqFZ0joP8jCfI66neGK2OBY8a84wW2ZybwdkXlzgR7VdilLmYY/SNXgqP
 Y8EFlJOFn0JKO100VP9hT+Rc/hwd2nw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2442F3E7038
	for <ltp@archiver.kernel.org>; Sat,  8 Aug 2026 01:50:04 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E027A3C782D
 for <ltp@lists.linux.it>; Sat,  8 Aug 2026 01:49:39 +0200 (CEST)
Received: from mail-pl1-x648.google.com (mail-pl1-x648.google.com
 [IPv6:2607:f8b0:4864:20::648])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3E862600D65
 for <ltp@lists.linux.it>; Sat,  8 Aug 2026 01:49:39 +0200 (CEST)
Received: by mail-pl1-x648.google.com with SMTP id
 d9443c01a7336-2cfca8558d2so1939295ad.2
 for <ltp@lists.linux.it>; Fri, 07 Aug 2026 16:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786146578; x=1786751378; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Oixs6Yi6Y7KsoKdyCYKVhHteSUjiwfvhPwuReg3rHPc=;
 b=enpL+eXvenHEaFG2D2fBZ5tO1KNRnHXgaa9uY6CzGY9Fcsq9AnvMP+wn5bGn5AQgYV
 MZLWFAhryk95mEnEMiwZvVNs0Q/wU/0SG0QQfQVghIH3pUVPs1OwPt4/EObaVvN4IHUj
 GtbBA3LQX5hTHHZ2nGXDTm6lJ5iuijQuryrpeM+ciapjNqMUzWcoF6u/QAwBwyO24pdJ
 btI6umyKYk3kd9swLZpFdlya7q9HSLyO6kGV1b/0fGtvnrSm+MBM7VMH1fK/wV1tFoz+
 6/TxX6D2leTpqIvNx1yHqeemhiCaDg24L7TOsOQBJ5eNgNiPJHFt2gmK5PzXH8IPgoOx
 owuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786146578; x=1786751378;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Oixs6Yi6Y7KsoKdyCYKVhHteSUjiwfvhPwuReg3rHPc=;
 b=F1UBia43ixW9vwX8VkDS8gzL5KP+P7+06YWBeRq5nYpQfBD8luUK/ZIuwpxt0PQD3N
 GJPVSsG9x0AtAp6EUL7VEUnYwDLuBG6S5yDq2LKYHTsHjTLOnzCd2CTXrUAVXd16J1t1
 nwmrRaIiDEt5JW7BruvyT7FnDau7KEuigNiaHxEp7wjEvO3izBkqI0RTDgMQxS+wg9ck
 xYZ6vZ/ndOMvAdDSUY6hf5/yHooSjmICnwZQZmE9hOC1S0HbEI9FkEcgI6tGYYZVAeOh
 iFSsWzxy+xNYV46Sef8BdyxIK+OZ5uNbTbwO8xaBjodFGYDW+JtlsJ0S+en+1Sw5UaYm
 4eXQ==
X-Gm-Message-State: AOJu0YwgnI3yv9T+Un+KCzhSu2lk2oAm4juqUUlMf09TKfbgBXAPxEXX
 eDDmPkV1qQGsZMddwKD7unAnSNPeOW/HLHAoHZUekuySfPFVxLzPSYXh8xR9JHhUN/d/dwSXHnl
 1qnFbdghbZyUb+iSAZWzE+YtadeECV6idsME881/GrYVU4y/Lglrq7VDrh8ZoXJ58cKGYcDlACP
 97NJevzPUaBYF8cJMM+W3Nro9MJw==
X-Received: from pjbcv18.prod.google.com ([2002:a17:90a:fd12:b0:38e:7f2c:2c4b])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:57cd:b0:380:21b7:e727
 with SMTP id 98e67ed59e1d1-392823c808fmr2943512a91.14.1786146577255; Fri, 07
 Aug 2026 16:49:37 -0700 (PDT)
Date: Fri,  7 Aug 2026 23:49:35 +0000
In-Reply-To: <20260807110541.8702-1-linuxtestproject.agent@gmail.com>
Mime-Version: 1.0
References: <20260807110541.8702-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260807234935.3248935-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6] lib: Use backoff polling to wait for loop device
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

On systems where loop device node creation is asynchronous (such as Android
containers or systems with slow udev startup), calling stat() or open()
immediately after LOOP_CTL_GET_FREE can transiently fail because the
device file (e.g. /dev/loopX) has not been fully populated in time.

Introduce an exponential-backoff retry loop in both
tst_find_free_loopdev() and tst_attach_device() by reusing the LTP native
TST_RETRY_FN_EXP_BACKOFF() macro (starting at 1us delay, doubling each try,
with a base timeout limit of 1 second that scales automatically with
LTP_TIMEOUT_MUL) to wait for the device node to be successfully populated.

This improves the robustness of loop device allocations on asynchronous
virtualized environments while minimizing unnecessary delays on responsive
systems.

Signed-off-by: Wake Liu <wakel@google.com>
---
v5 -> v6:
 - Correct timing descriptions in commit message to match the actual behavior of TST_RETRY_FN_EXP_BACKOFF() macro (1us initial delay, 1s base timeout).

v4 -> v5:
 - Declare tst_multiply_timeout() in tst_common.h to fix old API build failures in CI.

v3 -> v4:
 - Rebase onto the latest LTP HEAD.
 - Remove self-referencing Link in commit message.

v2 -> v3:
 - Reuse LTP native TST_RETRY_FN_EXP_BACKOFF() macro in tst_common.h to simplify code.

v1 -> v2:
 - Strictly clamp backoff delay to 100ms (prevent overflow exceeding cap).
 - Skip usleep on final loop iteration to avoid unnecessary idle delay.
 - Reduce max attempts to 30 (stat) and 15 (open) to bound worst-case timeout.

 include/tst_common.h |  2 ++
 lib/tst_device.c     | 13 +++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/tst_common.h b/include/tst_common.h
index e1f7c7907..d09edbbbe 100644
--- a/include/tst_common.h
+++ b/include/tst_common.h
@@ -26,6 +26,8 @@
 #define LTP_ALIGN(x, a)    __LTP_ALIGN_MASK(x, (typeof(x))(a) - 1)
 #define __LTP_ALIGN_MASK(x, mask)  (((x) + (mask)) & ~(mask))
 
+unsigned int tst_multiply_timeout(unsigned int timeout);
+
 /**
  * TST_RETRY_FUNC() - Repeatedly retry a function with an increasing delay.
  * @FUNC - The function which will be retried
diff --git a/lib/tst_device.c b/lib/tst_device.c
index 744173ffe..00304711b 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -82,7 +82,7 @@ static int set_dev_path(char *dev, char *path, size_t path_len)
 
 int tst_find_free_loopdev(char *path, size_t path_len)
 {
-	int ctl_fd, dev_fd, rc, i;
+	int ctl_fd, dev_fd, rc, i, path_set;
 	struct loop_info loopinfo;
 	char buf[PATH_MAX];
 
@@ -93,8 +93,13 @@ int tst_find_free_loopdev(char *path, size_t path_len)
 		rc = ioctl(ctl_fd, LOOP_CTL_GET_FREE);
 		close(ctl_fd);
 		if (rc >= 0) {
-			if (path && set_dev_loop_path(rc, path, path_len))
-				tst_brkm(TBROK, NULL, "Could not stat loop device %i", rc);
+			if (path) {
+				path_set = TST_RETRY_FN_EXP_BACKOFF(
+					set_dev_loop_path(rc, path, path_len),
+					TST_RETVAL_EQ0, 1);
+				if (path_set)
+					tst_brkm(TBROK, NULL, "Could not stat loop device %i", rc);
+			}
 			tst_resm(TINFO, "Found free device %d '%s'",
 				rc, path ?: "");
 			return rc;
@@ -161,7 +166,7 @@ int tst_attach_device(const char *dev, const char *file)
 			 LO_NAME_SIZE);
 	}
 
-	dev_fd = open(dev, O_RDWR);
+	dev_fd = TST_RETRY_FN_EXP_BACKOFF(open(dev, O_RDWR), TST_RETVAL_GE0, 1);
 	if (dev_fd < 0) {
 		tst_resm(TWARN | TERRNO, "open('%s', O_RDWR) failed", dev);
 		return 1;
-- 
2.55.0.654.g21b8a5bc05-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
