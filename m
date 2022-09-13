Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15EFCC54EE9
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 20:29:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 126AA3CABC2
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 22:29:09 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1CD93CABD8
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 22:28:58 +0200 (CEST)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com
 [IPv6:2607:f8b0:4864:20::64a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A6C2B140116F
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 22:28:57 +0200 (CEST)
Received: by mail-pl1-x64a.google.com with SMTP id
 d7-20020a170903230700b00177f6dd8472so8928677plh.6
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 13:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date; bh=dmKeMDTIitr+DJUedxSyu2JtHOSwvaWrNtPaamtMXYA=;
 b=FwwVQDs43P8z8L9K3jYC0Ye6jLFNt+ShQYFIyOoCXiNV4IjoaQbWD350wa7I6bQk8I
 5r21pXRp+UKM25lBhhqQX7rJb7xs2Uwe1eSV5aRlvwPi30yfT3tDtenPaGXrXZAcMZoB
 3xLFA0M1LQLM7Zo+QWpqLn3LWBDdB8Qkk+ySAKkAGzl7LyS4T/YdEy9sgasY0IivFsv7
 D3FnTqd2wJSg1/SDho3b5judtsXHGyHD7K7HaD7C4/EeYIuuilu5Nh1auZTW60sexhAw
 wEjX5mwucpXcsW+KFaqLn3pUFtB0zLhSBLJo+tIc8py7H+yygRDo6lpGZAVUH0KjRjRz
 6zlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date;
 bh=dmKeMDTIitr+DJUedxSyu2JtHOSwvaWrNtPaamtMXYA=;
 b=yiGgSG5KLK8Pa+xMKPxq3h+8fnkWTSiBXImXFRQIGvp17ydP2HXj+6Wq3vRNFqU+So
 vG23H2nebDg8Xph1XLAZGbf3XVd42ZFg0rlbJObMIuK/khiNFQ9A/h2uES5tZhQKp3SX
 JEG6aLPYJCPOWOvy6oIm781GGWp7bqEA6DIBXks8kJWdFMy5PcdDFnbuYjsH4MZlFtVi
 T2M7nwC511FtQhMcuIT6BEOzfYM5EAGdwScgiH6h0V4TPHubuMX9w8CeaHH0BHtaRVc9
 lvzDPX4ZhOXV58YEzl3fjRDPlnYeQKY3pb2KEi7/nns7laiOfO8rSn3LAgHEIX9rxJMt
 TDZg==
X-Gm-Message-State: ACgBeo0xeYQ8xWrLgeqDn+//6WrhQKJ+Esv6GUwgvbza1omm0gkcGQxA
 7axAEDiEgBgSBD2e6p0voTkHRFPcIZ8tKvsbhQHFToUsA9NOO7gHuX8H1E2iS6vgF39VTNwj+9e
 z6nhS8xbWPGAmefwnVKCmyl2f9KLo8etb9U+iRI2e2HfpNlouuLvGfHJN
X-Google-Smtp-Source: AA6agR7zLd2D1p3K2BCHQwdqnAHbx9Ih/eBdZKQkRQSHs5OfmbHoXdH6PxphErwKR+KeHBevG+GuuKBsD+A=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:b007:b0:1f1:d31e:4914 with SMTP id
 x7-20020a17090ab00700b001f1d31e4914mr1051423pjq.36.1663100936128; Tue, 13 Sep
 2022 13:28:56 -0700 (PDT)
Date: Tue, 13 Sep 2022 20:28:53 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220913202853.1808453-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] kvm: main returns int
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

---
I think the test framework expects main to return int, is this correct?
---

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 testcases/kernel/kvm/include/kvm_guest.h | 2 +-
 testcases/kernel/kvm/kvm_pagefault01.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/kvm/include/kvm_guest.h b/testcases/kernel/kvm/include/kvm_guest.h
index ec13c5845..4a4be3f39 100644
--- a/testcases/kernel/kvm/include/kvm_guest.h
+++ b/testcases/kernel/kvm/include/kvm_guest.h
@@ -15,7 +15,7 @@
 #undef TRERRNO
 
 #define TST_TEST_TCONF(message) \
-	void main(void) { tst_brk(TCONF, message); }
+	int main(void) { tst_brk(TCONF, message); }
 
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
 
diff --git a/testcases/kernel/kvm/kvm_pagefault01.c b/testcases/kernel/kvm/kvm_pagefault01.c
index e355fa448..dc92c7b66 100644
--- a/testcases/kernel/kvm/kvm_pagefault01.c
+++ b/testcases/kernel/kvm/kvm_pagefault01.c
@@ -45,7 +45,7 @@ int handle_page_fault(void *userdata, struct kvm_interrupt_frame *ifrm,
 	return 0;
 }
 
-void main(void)
+int main(void)
 {
 	uintptr_t tmp;
 	struct page_table_entry_pae *subpte, *pte = kvm_pagetable;
-- 
2.37.2.789.g6183377224-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
