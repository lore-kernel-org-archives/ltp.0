Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE02C7618E
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 00:30:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B70AC3CE4CF
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 02:30:02 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 954A23CE4D3
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 02:29:32 +0200 (CEST)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com
 [IPv6:2607:f8b0:4864:20::b4a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E2E4D1400BE2
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 02:29:31 +0200 (CEST)
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-b9a6eeea78cso1259405276.0
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 17:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1682555370; x=1685147370;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=VEFg6fcUhrfpnj5qs7qTFzI6HoajphnN/fBGZYFt+zo=;
 b=6RCH+4UuAXlbfD8xxmFnJ5e2beHuMGdu//4e9wVU48YE9dJjhy1B31pleYdg9mxFCd
 GtJJ1+Ug5bNcFUIn1gzp7W1ANA2i194ULC9eFHq1oHlB168bTXwQdp7HSYShCDH6f0i0
 hcDuTZLqhDXWEC9QoreivKRJtRyLctkUKtt/YKm5fbDoRVquRRayN2slVRCyULSlw1vN
 /lM9NN7nBYyt8LyrczMZViRmoTmcXQQDPYvtw4D/yvia35lFLDhtsCUI0rVb5f9M915g
 09Diia+3x3ziqUGABUKRSpAU2sAuiQG3azASSK1i+FWS1yfxk+oLrNPj0yI7PZHIdMoT
 gfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682555370; x=1685147370;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VEFg6fcUhrfpnj5qs7qTFzI6HoajphnN/fBGZYFt+zo=;
 b=AKhxeP6Pi5j9JEhiJuiKHjZZDKxKhAz1ANC6Ut2fP8RouaUp0O/ZDKkLvpEsKqb+h5
 G+plpiFdI4SR80hNkMm6ATvmNJnshb0tHGdbOt0gQAuP6Fc98NCmuo6xuk0ShLoUav7X
 PW07jOBZ5a10ZHtv4QxuS/BGF5M3Y0RG4HFz9899Yiob5Xk4i6WyyTpucPk9lXR04P6w
 GDb6T6ixC/QdkFqrSna7o2a6u64f3L0Ples6IElp7bJ+c+TIigJIiUWfJo93FMCP87qF
 SgX18Aj4XvpuAjx/3CZo+r1oG9zJxfwJNeuTybycTE4EoNz9ts7uW0q2gO2FidbbN+gJ
 e6dw==
X-Gm-Message-State: AC+VfDx+48rYICbjYmJps8jkWh39Ypg3VE1yw2R6S5eqDWO2WmEuNI5r
 jXQtExxI+j8ZfFZwLyBQlP55b/3RIJtH1GEvprLeeIci5f4V/qfZp5hqJuJp3HINSbI+QZ4hwgW
 eZ8KPQkslKPLELmj5FEe1kQ7HOznW3E7zMRTNK79wkrVUuzvPr7L7FWqA
X-Google-Smtp-Source: ACHHUZ4RHnWc+uszU1PNVkM7lDR7eMT8CQmKTO6yp234qVmeQtUOFwpQMiJsqiIG1nhQoPWtFwtVyCPqKSo=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a25:e70c:0:b0:b95:3e0b:45b8 with SMTP id
 e12-20020a25e70c000000b00b953e0b45b8mr96523ybh.2.1682555370563; Wed, 26 Apr
 2023 17:29:30 -0700 (PDT)
Date: Thu, 27 Apr 2023 00:29:05 +0000
In-Reply-To: <20230427002905.1354207-1-edliaw@google.com>
Mime-Version: 1.0
References: <20230427002905.1354207-1-edliaw@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230427002905.1354207-3-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 2/2] fcntl{34,
 36}: Use arch dependent types for my_flock64
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
Cc: kernel-team@android.com, rpalethorpe@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Android arm64, fcntl is not accepting the my_flock64 struct being
passed (fails with EINVAL).  This modifies the struct type to match the
flock64 definition in the kernel.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 testcases/kernel/syscalls/fcntl/fcntl_common.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl_common.h b/testcases/kernel/syscalls/fcntl/fcntl_common.h
index 485a31367..78ffcdc2d 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl_common.h
+++ b/testcases/kernel/syscalls/fcntl/fcntl_common.h
@@ -16,13 +16,13 @@
 
 #else
 struct my_flock64 {
-	int16_t l_type;
-	int16_t l_whence;
-	int64_t l_start;
-	int64_t l_len;
-	int32_t l_pid;
+	short l_type;
+	short l_whence;
+	off64_t l_start;
+	off64_t l_len;
+	pid_t l_pid;
 #if defined(__sparc__)
-	int16_t padding;
+	short padding;
 #endif
 };
 
-- 
2.40.1.495.gc816e09b53d-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
