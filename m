Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB0DC54798
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 00:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708646772; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=srACDHIFwQzYhalElPfOR3pGXcmJ9o7w54V0ABCQkxw=;
 b=ZaTUslntyp5FUVJ/eZkdhM3Fw60cZigMXaJGUgqcKbxputMDLA5qpxw8FvgUyE73totfM
 JJM0nArGIfy2ryG8crB1ygWbe2f+E+1YgHfdF5ZtnxESTk97+v7AzWIAfFg2nif3t6MuTRI
 C2zav9DvKUuERg4WSWff6tQeSdVku3M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B8B443D0796
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 01:06:12 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 167CC3CD103
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 01:05:50 +0100 (CET)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com
 [IPv6:2607:f8b0:4864:20::64a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7B88B6024FB
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 01:05:50 +0100 (CET)
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-1dc6b4fb04eso498905ad.0
 for <ltp@lists.linux.it>; Thu, 22 Feb 2024 16:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1708646749; x=1709251549; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=yI0QjN1VXutNsPh/Ncgjzpz0W1fiHHVcDVE+jlgMG4o=;
 b=agNh7X/9r6OGSRsamuNCRgJSVmAgQ7lmP/NDFe55HFGbjozTmMCr41Jm7p2aDkyGhs
 lwe4lbyyF3XIKZU28Z+b9hoiHsc+Vo0shU9N9FFPs7aEoWqYxzk2J/CaXKpt4XckXzQg
 487Wq3BJubEhoq2Dial7lL4LJkRn7w5Ihs4Rw5D452yNNwqC7QmqYgZuYhF/cs6LIDSQ
 EsXXNqxxYqNVUgvm6v7AQoAOWqXHA5WZkT8Afb9KqyiSRrvrzKdH4gw7tJTtUvHpNfCa
 wzqNrDM1ECp2iAgDAgiP4Q2pyyig8VmKcH1XAoeBcpgatgXM9AKjPyZLYTxyZhC9TC6+
 3Y8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708646749; x=1709251549;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yI0QjN1VXutNsPh/Ncgjzpz0W1fiHHVcDVE+jlgMG4o=;
 b=nsnAOdt3rDDVqOGQJ1X+nj1iEBWAnZX/++GQmxXRXUdC92jlUPSNUMZKU1vdBRVeOi
 0ErfSHeyFPL6NBZACKgjsNmXkb0Tv5g5eNEvn12EH6+B2C2PbE9/tnHSRe3s+dSIj2uX
 iTGW/fPVST1IXX/ZiMlPfFHt1gTHXKYOjGNF+eajOWlXB8AD2oUF6ro634QWRN6Nwlsj
 GXkTgz8Tu8J7VUPqti+ngHbpMrIp/EoNBIt0CAJXGl7+sQLS0yQG9c/mRltibqkWhp/I
 7B8u5GEdpC+mv7DJZj68GYzIvL9n7eFE3U4L7nQLooIJe1a7wSl7JevFpmdDxL+f8eZp
 uVOA==
X-Gm-Message-State: AOJu0YyV5QqgoM/MzC4ORohbBK62MJGDHpqpOkaLXkawY6ouX6YLF/4A
 h0NTfhqW9mUYqK6x8Qfm9rTTR88ivlQnV9l8s8zbyg39uVK7HQLkr/aI1y5EJggfBkWswBPxW8D
 K8InhkG4ZdxkZLUixUb7J84kOMemY871WAb01OIwDEHdZnGZidWppSS044qBHGxpMiTGXtiQYRe
 fPxIKLeN6Zlf/L+7mjjrqBOtzqIsk=
X-Google-Smtp-Source: AGHT+IE1iZyEi9txPs2/kEfAavNH0mUSd/fxmYmbbeo8RmM2ssSugaNUoHN3u9Tfr+9ptuKT5JksuHMhW7I=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:d08a:b0:1db:d811:7323 with SMTP id
 v10-20020a170902d08a00b001dbd8117323mr880plv.7.1708646748370; Thu, 22 Feb
 2024 16:05:48 -0800 (PST)
Date: Fri, 23 Feb 2024 00:05:43 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240223000543.1135129-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tst_fd: Use raw syscall for fanotify_init
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

Some systems do not provide sys/fanotify.h, such as Android.  We can use
the raw syscall for open_fanotify to avoid importing the header file.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 lib/tst_fd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/tst_fd.c b/lib/tst_fd.c
index b3d43a7c3..6538a098c 100644
--- a/lib/tst_fd.c
+++ b/lib/tst_fd.c
@@ -10,9 +10,9 @@
 #include <sys/eventfd.h>
 #include <sys/signalfd.h>
 #include <sys/timerfd.h>
-#include <sys/fanotify.h>
 #include <sys/inotify.h>
 #include <linux/perf_event.h>
+#include <linux/fanotify.h>
 
 #include "tst_test.h"
 #include "tst_safe_macros.h"
@@ -146,7 +146,7 @@ static void open_pidfd(struct tst_fd *fd)
 
 static void open_fanotify(struct tst_fd *fd)
 {
-	fd->fd = fanotify_init(FAN_CLASS_NOTIF, O_RDONLY);
+	fd->fd = syscall(__NR_fanotify_init, FAN_CLASS_NOTIF, O_RDONLY);
 	if (fd->fd < 0) {
 		tst_res(TCONF | TERRNO,
 			"Skipping %s", tst_fd_desc(fd));
-- 
2.44.0.rc0.258.g7320e95886-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
