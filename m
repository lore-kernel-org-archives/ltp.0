Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A03C6FD1C
	for <ltp@archiver.kernel.org>; Fri, 24 Mar 2023 00:25:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 39D983CD349
	for <ltp@archiver.kernel.org>; Fri, 24 Mar 2023 01:25:22 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F7853CE2E7
 for <ltp@lists.linux.it>; Fri, 24 Mar 2023 01:24:50 +0100 (CET)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com
 [IPv6:2607:f8b0:4864:20::649])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B548C140053C
 for <ltp@lists.linux.it>; Fri, 24 Mar 2023 01:24:49 +0100 (CET)
Received: by mail-pl1-x649.google.com with SMTP id
 d2-20020a170902cec200b001a1e8390831so249582plg.5
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 17:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20210112; t=1679617488;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Tetz773QhDFSbXijMu+8e89BLyLkE2x3msPixKxSDuY=;
 b=klUu2Qct0ISG3fbMivocfVv1+lN9AkHCXR/LRXXMQGln4A1t5zQQgqhkARWyxXFvs+
 2NygCAxn+xyYbp6sGPyqa5ZLBJ2LxufxebzlV8oh71NW8LmJL7ML2Ku52gC2CMBestHQ
 PkaXcm3mynlentDpWlZI8xtDg1zkU3AzjYWMHAMFmo5NRF3P2rdCXApeN43fvLsvVcL4
 wsY4bMlI4Ss87Qxv9nAbll+IDLSGCOAn6YspX6MlezAHrJPbyPKOV6iwsU8MWLjxKCku
 HcTMgWiqg2Wz6gMyXBp4Hgz4GciIgGCq+EKpfX3xb/aBwOttG2j6p1Kw3Eh6pZ/Eq5p2
 APIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679617488;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tetz773QhDFSbXijMu+8e89BLyLkE2x3msPixKxSDuY=;
 b=PP4UHv8utKk78niHL254jBIuoqIWMwYap9djVEdeGYxOBLRC5Z8dp4il1JiVhOrjvL
 sJ4SgAEVEhUBOQKy5UH0g4GmwUgOh0aX+H7RcR0fbEl0bVWr3FV55db+rpgX2y2A7YWv
 laydVocIiclnxCisnJBd6pq2raZN1UovhxAMMkrlsSqkbgjfxzZiIFlWyJdSQGYOweRn
 ONQHBWt9VndE+pmHFPzbTO0eU85imSN+ub7QI4TiQccyl3AQcr+TW6tQV+8quP55x4tQ
 XzHmeIOV79xsjnJaQ8nln43rmVots8BSW5lTvtWog0ZjW2/aN1+Bxfb65ySSdUFlEhdn
 yVMw==
X-Gm-Message-State: AAQBX9dt6r5623kmtExkazEFT3Xb0qAV056IPGj2Wz3JsFClN+PsiKPq
 gfFNnHyfy1pqsdFUMsEykG0EuHZblF4QKHEbW9S7llT1u5i4aPFV/7ZJLa9wGnOl3zXrXwq67A1
 PinV80M70KXlfCl7W3BbB5rgC4uDOf9JaEAjNWJhjVWfWncj8/GJXyTCx
X-Google-Smtp-Source: AKy350Yxx+aUMUPf8xYCZTEV5ZlCZFzqG4TiGzb1Yb3E1Ci/BQSwFgLsfHTprNF8/ImhZ7s65Kfn9/xTVYw=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:1a46:b0:625:c7de:48c1 with SMTP id
 h6-20020a056a001a4600b00625c7de48c1mr651156pfv.4.1679617487918; Thu, 23 Mar
 2023 17:24:47 -0700 (PDT)
Date: Fri, 24 Mar 2023 00:24:39 +0000
In-Reply-To: <20230324002441.987778-1-edliaw@google.com>
Mime-Version: 1.0
References: <20230324002441.987778-1-edliaw@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230324002441.987778-3-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/4] set_dev_loop_path: Change return value to zero
 on success
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

set_dev_loop_path was returning 1 on success and 0 on error, which is
inconsistent with the other functions in this file.  Change it to 0 on
success and 1 on error.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 lib/tst_device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index 5d057570c..2c83fb764 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -69,10 +69,10 @@ static int set_dev_loop_path(int dev, char *path, size_t path_len)
 		snprintf(path, path_len, dev_loop_variants[i], dev);
 
 		if (stat(path, &st) == 0 && S_ISBLK(st.st_mode))
-			return 1;
+			return 0;
 	}
 
-	return 0;
+	return 1;
 }
 
 int tst_find_free_loopdev(char *path, size_t path_len)
@@ -116,7 +116,7 @@ int tst_find_free_loopdev(char *path, size_t path_len)
 	 */
 	for (i = 0; i < 256; i++) {
 
-		if (!set_dev_loop_path(i, buf, sizeof(buf)))
+		if (set_dev_loop_path(i, buf, sizeof(buf)))
 			continue;
 
 		dev_fd = open(buf, O_RDONLY);
-- 
2.40.0.348.gf938b09366-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
