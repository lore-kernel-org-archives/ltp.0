Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF9FECAAD3
	for <ltp@archiver.kernel.org>; Thu,  1 Sep 2022 20:33:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF97B3CA843
	for <ltp@archiver.kernel.org>; Thu,  1 Sep 2022 22:33:22 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 717573CA708
 for <ltp@lists.linux.it>; Thu,  1 Sep 2022 22:33:13 +0200 (CEST)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com
 [IPv6:2607:f8b0:4864:20::44a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C4435601163
 for <ltp@lists.linux.it>; Thu,  1 Sep 2022 22:33:12 +0200 (CEST)
Received: by mail-pf1-x44a.google.com with SMTP id
 cg5-20020a056a00290500b0053511889856so8185849pfb.18
 for <ltp@lists.linux.it>; Thu, 01 Sep 2022 13:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date; bh=onQOlvv9/6dT/QXag0qt3U0vE+1pes8n9yESSO9FH2A=;
 b=TsG6DfWfSIilkuYxuqrJWBzDWW2zWnQE+oiopkACzajZjAlTpUJNN7trozTc4LzKae
 x2+Z10PIyfqJCJRc3U/yHyeP8BA5vOcDzlCHa6Sk6jn2j1OEkPHwxBNi4ePOqFakvkNt
 cB4X7xy+LXtwq2lgPVNOugeE99PedtKjwhVLx+kg7VyuYdqvGwNBSFhOPY4s9v3A+lLs
 ZX26AOEzApMSDhNebEHS4ub8wYKCz64OUutUKkC42k3Q+hcw+WqtbSeEtyCz8l9gbiBX
 oxFKVRbaQcaOh7ljm9xE+iL9phx5ei0XmOPQdCI+rmG8EyH46AhtmJRRhl0cPVGecdAE
 8tzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date;
 bh=onQOlvv9/6dT/QXag0qt3U0vE+1pes8n9yESSO9FH2A=;
 b=UyAmvHNr/IRrbL6FTqI1whqbaCteoSspSJULwANvSCSPgv/uXfKBwllzHNWfkirTQv
 miKENeNcPfsj2ImPa41rvaKlBuoLR+K6KzeA45H6TJ5dlFdN3lMQcgRUy+WZAUdI5j5I
 WukMd6RONGSiUTh6vN5AGvPo/f/LSnZcFnYxUI1woaCXPF6+yVU0g4W4DiAd0KVMSkX5
 h0KeuiYoA6eaTVwyhuOcLJLOeuN5fHwtDdM7RSTECS4tCxT5KV/xI79psdbppoWHgkxy
 d5YPrtlN21FZaS3Z10/5t4VpLvv+QRAGvzlQRM/g2kUUdqdruJqT4B+NuaIgmA1wjYxl
 Sc/Q==
X-Gm-Message-State: ACgBeo1X66y5mgU259h6lu6CAhKFC+GGh61C1EXtqM655lIPKXayD4/B
 LXtYkA1qRgQh/QUfwCdvJPCE1TNR8nLLnuTWviWxJXoWKyrNfijAdyRVt77uZVf2o7RmsWtrfq6
 zlv/7luc9+CcU12m4i/hTvylk3IbrILyQBUXSH0ajY1X+cT6O2X54qT57
X-Google-Smtp-Source: AA6agR4Uz76WyDj0U8SSxrOipYYCnRqyjWV/C1yqCJzND2/y8N2H//Hae3J3TD4S0wYu5oQ0ychMlIcyrOs=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:d486:b0:16f:15a1:6da3 with SMTP id
 c6-20020a170902d48600b0016f15a16da3mr32717446plg.134.1662064390883; Thu, 01
 Sep 2022 13:33:10 -0700 (PDT)
Date: Thu,  1 Sep 2022 20:33:06 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220901203306.28623-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] lapi/name_to_handle.h: fix include
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

Import tst_test.h before lapi/syscalls.h so that the compiler defines
the correct symbols to use.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 include/lapi/name_to_handle_at.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/lapi/name_to_handle_at.h b/include/lapi/name_to_handle_at.h
index bdc59b549..7c76438ec 100644
--- a/include/lapi/name_to_handle_at.h
+++ b/include/lapi/name_to_handle_at.h
@@ -9,10 +9,10 @@
 
 #include <sys/syscall.h>
 #include "config.h"
+#include "tst_test.h"
 #include "lapi/syscalls.h"
 #include "lapi/fcntl.h"
 #include "tst_buffers.h"
-#include "tst_test.h"
 
 #ifndef HAVE_NAME_TO_HANDLE_AT
 static inline int name_to_handle_at(int dfd, const char *pathname,
-- 
2.37.2.789.g6183377224-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
