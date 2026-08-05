Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4FCC2A09B
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 02:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785898484; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=h8o+1idcnCVYUyhl+1wzr8Yf2HCVVvoBfL9a2zLHq4w=;
 b=iFyH+OkrQ0MCklJz5CYVxCWfIMlbfAno4ezcKWXkak6Fr+bYw5tC1zGFQPLSanCXa4YoF
 92rpW7gvfKYVygXheF2V+Znu99rE9/lsSx2UbBShqg+a0EFN9apxOSipMxSjJ8HlRBtYtUA
 Ej1ofFi7XNOX3uV9KdY0UtQmhmXE/EQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 648A33E5A26
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 04:54:44 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D2BB3E2D22
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 04:54:22 +0200 (CEST)
Received: from mail-pj1-x1047.google.com (mail-pj1-x1047.google.com
 [IPv6:2607:f8b0:4864:20::1047])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 800B110009DB
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 04:54:22 +0200 (CEST)
Received: by mail-pj1-x1047.google.com with SMTP id
 98e67ed59e1d1-3823dcc1647so627076a91.3
 for <ltp@lists.linux.it>; Tue, 04 Aug 2026 19:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785898461; x=1786503261; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=86mRcYRg7BhOtYZmnE0TLxBMbzx3CY/H/I0HCRtGyqU=;
 b=YZ9aFwrs1aOtKcn3eUXHCvHho1ig6yfkewMG+zdIHU681WbS49dsnB5ixaHH/NMsiY
 fsmzGMfzwau3Av7rzKaaRzBbLK3AmBlEvOP5lEgG4kolBT0KV5NtuxOm872qeza93Xmp
 /4rLNNS4gKPkyk/Q8Zf0PeDPVjrH+4uVFf7zMJREUY8j3MFH9En/b15imjnndykMJmEM
 6lf/1Xe6zYfFimRN6UFjnPC4OP+lsTstr/+CmI862akfWqJKuRggi10Z1Ib37mH8mql6
 sak5tIKKHnnR4E40lZPzGNW8bwnl2DjmOJuUFm/WUKhSQpCKkjZylC7Oc7cC+SZxBN6+
 Yngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785898461; x=1786503261;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=86mRcYRg7BhOtYZmnE0TLxBMbzx3CY/H/I0HCRtGyqU=;
 b=dp8gyGIeOulVLQJBy+RItJHSfnQcWLDwZgUv9AyTmCuEwi/GfpPGoNbhOC6TOYHQgV
 V0DTPljuLYXlfWAZRMWzhm8vyHgctkcDZZv916NWoUHixSMNBZt+was+wF+3ta7qmJFU
 5v2o94Yjt/oSdgxUhGB7CdK8KvNVLofWOaK2SjOClZeQxU6WfSLSonoVDhk5HA5E3uEu
 jWCzPiwvn2t9Hv+KOZMLm/gDDF/TYuObz20n+wGB4TMPiGjYLIs3VyofYOL0viVn2Ci6
 uUvdxHkNlBDKHXfFbVs9eLg606EaiLySfS4OwOgSKbsIZv82KWB7qPsa3ssv2IGahRhC
 FYDQ==
X-Gm-Message-State: AOJu0YyhjG4ZSo3pHNPYiQGRXqYnkvwE2Fmc6c/hqWba8JDu+OkVqqmQ
 8WZ8Uy2cUjBxcusLyz/18MKmm6wgNfuzkqMUqBZBt0pisqLagZZuHSIsArc3MlMhVeZXFf0+aBe
 j7n7jzNlCkwtW2bGiNQYaBX7yoivKISjc/DxeBXhAlpWw+JkhJcURZnHw1FwFjlIXOqu3pWIqyQ
 asCLoWQEeDm3VSGJj1ChhIt9RbRg==
X-Received: from pjbgk2.prod.google.com ([2002:a17:90b:1182:b0:38d:f086:96])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2f03:b0:381:a766:efc9
 with SMTP id 98e67ed59e1d1-3903c53404amr3892201a91.7.1785898460453; Tue, 04
 Aug 2026 19:54:20 -0700 (PDT)
Date: Wed,  5 Aug 2026 02:54:18 +0000
In-Reply-To: <anKexVXAkhsMGpZy@linux.dev>
Mime-Version: 1.0
References: <anKexVXAkhsMGpZy@linux.dev>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260805025418.1249003-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] lib: Use backoff polling to wait for loop device
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
tst_find_free_loopdev() and tst_attach_device() (starting at 1ms delay,
doubling each try, capped at 100ms) to wait for the device node to be
successfully populated.

This improves the robustness of loop device allocations on asynchronous
virtualized environments while minimizing unnecessary delays on responsive
systems.

Signed-off-by: Wake Liu <wakel@google.com>
---
v3 -> v4:
 - Rebase onto the latest LTP HEAD.
 - Remove self-referencing Link in commit message.

v2 -> v3:
 - Reuse LTP native TST_RETRY_FN_EXP_BACKOFF() macro in tst_common.h to simplify code.

v1 -> v2:
 - Strictly clamp backoff delay to 100ms (prevent overflow exceeding cap).
 - Skip usleep on final loop iteration to avoid unnecessary idle delay.
 - Reduce max attempts to 30 (stat) and 15 (open) to bound worst-case timeout.

 lib/tst_device.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

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
2.55.0.571.g244d577d93-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
