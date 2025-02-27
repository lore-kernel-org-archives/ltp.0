Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4236C19F32
	for <ltp@archiver.kernel.org>; Thu, 27 Feb 2025 18:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740679495; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=5j7SzRmTD6BgARaPfZKD93YDfgPnhusRBGsHupU4vLY=;
 b=A5nUEdUmjHV3lb3QSwnuKP861EeXGLhI85qN3pgnzpGFZ7A7KRdE4EjCfYSRcgSevjb01
 X0XA9SoZX60Q3czFrIekjxFHxsg6tdA1ahMBFAD+USrcawVey3DVsCAXL+W9VhMaOVy8KuS
 zDhfLyLRftesuFNoUwvYkbSKDvIU8t8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 560C53C9E30
	for <ltp@archiver.kernel.org>; Thu, 27 Feb 2025 19:04:55 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E0A063C280D
 for <ltp@lists.linux.it>; Thu, 27 Feb 2025 19:04:34 +0100 (CET)
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com
 [IPv6:2607:f8b0:4864:20::1049])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5199C20A6BF
 for <ltp@lists.linux.it>; Thu, 27 Feb 2025 19:04:34 +0100 (CET)
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-2fe9527c041so2839471a91.0
 for <ltp@lists.linux.it>; Thu, 27 Feb 2025 10:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1740679472; x=1741284272; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=H1u941e04YqteTk7r7ik4JcKR8v8QXUlEnMPqzWSp7I=;
 b=4qZoy/1YA9jN0nR0ldvf579fVv+IqEawusAP+Yv/7qPTrqloCvG+ed0nW5klXLmW/v
 60yQZBOj/zGMxhKws7NF9MKhRbEdzPcM3bFdJCsOHSrh5VQg9WE7nflUc7/KiqekBw3/
 bASjRJe/PMFi46hvr0cFRLDnUg/J26i0vutgnmgerfL3hklZla+uyHWz/W0SUAjAUDbG
 wB2NWVoW0EtwyT36VwKY7bB0oNvZVXymrQ8Zp1bH9b0B0/j6de9nSIgwfZNsBbVWv1vM
 nOZlPYtEQXDrmJoEE1G0SSk2kQWbWxCJ9kvShokY9vS14+jb8WBkPoS6EXAwOiGLMyS9
 OBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740679472; x=1741284272;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H1u941e04YqteTk7r7ik4JcKR8v8QXUlEnMPqzWSp7I=;
 b=Xy037bjrQ5LU0L9DzbJYxjJp5J6hLNcKKpKFEMT2Z2ACWIUIqDx4lgTwIeTGQ3kL/O
 UFLYO06z0VzYBFH6PdTUHYZH1HB6HjktBxoOyelEnRAOZMXxY6GfKpPaq3fgyMHpF522
 6q/Mbow95Ef0+GBs94J9otMuRQeSTHvSRJMQFFy44ceu3IRpkQbBN/jvJND0420OdADM
 oj7uEbJo6c8m7vhIs+RtPyz+SFEikunqdhdvR6n1VhCfwyR1JBVKexP/ORzHTKjhLdWm
 KISlFD6ko2hlnau/Ac70kBYnzjnaq1vbmzLWv4ygw8Htciqv5GsuFQfk8HyFQ5CrCOu0
 4mlg==
X-Gm-Message-State: AOJu0YzhEgG0u/sFR5YeKLGQy73944Bi+hskyYVByQdNR3MhKtehSm/p
 cvqnPqSU0FDoOH+Smx63pwLM3BwlOHHd8/ObzACslBaskB4DwEmCNiNnpwQBf+0vx5JBh6L/+4Q
 oHDye6Yrpb6kn9tCPk/XPjVNg8/QN6QJ2xOSKpVEpIduS/Syf/3pfziy7l4/urv8aXlXArop8Z1
 QSZmdRMP38uWViKzxEBueshc/DnGI=
X-Google-Smtp-Source: AGHT+IGCy11mg0EzZXEeBI9Lwjtrvu1kwWF1vYBP+Sl6vb2c8kL+7TjUv19EYCY7w8iqyKPhuTjCavQw+ic=
X-Received: from pjbso11.prod.google.com ([2002:a17:90b:1f8b:b0:2fc:2959:b397])
 (user=edliaw job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1b06:b0:2ee:bc7b:9237
 with SMTP id 98e67ed59e1d1-2febabc8023mr353295a91.27.1740679472618; Thu, 27
 Feb 2025 10:04:32 -0800 (PST)
Date: Thu, 27 Feb 2025 18:04:28 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227180428.354639-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] setrlimit01.c: use a more reliable segfault
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

When compiled for Android, strcpying to the null pointer was being
optimized away as unreachable, so the segfault wasn't being thrown.  Use
raise to throw the segfault instead of ub, since the test just needs the
signal.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 testcases/kernel/syscalls/setrlimit/setrlimit01.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit01.c b/testcases/kernel/syscalls/setrlimit/setrlimit01.c
index 188d310b2..d00153533 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit01.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit01.c
@@ -33,6 +33,7 @@
 #include <sys/wait.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <signal.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include "test.h"
@@ -256,8 +257,7 @@ static void test4(void)
 		tst_brkm(TBROK, cleanup, "fork() failed");
 
 	if (pid == 0) {		/* child */
-		char *testbuf = NULL;
-		strcpy(testbuf, "abcd");
+		raise(SIGSEGV);
 		exit(0);
 	}
 	wait(&status);
-- 
2.48.1.711.g2feabab25a-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
