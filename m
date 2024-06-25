Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B92EC2BBCA
	for <ltp@archiver.kernel.org>; Tue, 25 Jun 2024 23:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1719359762; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=DLcqG5NGqEDrX5fUcWgM8i+ircYkPp6oCUPI11KXQJc=;
 b=LzfnQAHD+9478zyUkRaHKZJqas85OMVUKzeXFoM70rEXZMKtCTvypqds49YDcxZqLiELB
 4I8hKtgDEBCmAAFFogUBzpZ3ktGrU+rZH6rSSwz5W3/NyDnHh2YBwGkj9OPDb9rpOiBp5gf
 kphMmU/18owL0orE9EhRpKVLD5+3jSs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E63853D1197
	for <ltp@archiver.kernel.org>; Wed, 26 Jun 2024 01:56:02 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 283E73D1141
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 01:53:07 +0200 (CEST)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com
 [IPv6:2607:f8b0:4864:20::44a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 989C3208188
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 01:53:06 +0200 (CEST)
Received: by mail-pf1-x44a.google.com with SMTP id
 d2e1a72fcca58-706645f6ef3so5436766b3a.0
 for <ltp@lists.linux.it>; Tue, 25 Jun 2024 16:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719359585; x=1719964385; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=n08fHnAR3SdcuUTo8d/rWTb5o0Cgqg/50Gn4XFRGS34=;
 b=q1QulyW7QjJOPVgmUshbqg/QwAorL0ChdPUFryU4uK3P1XgcvpFEV5bRNgXA2Udt9C
 dZuyZH8ue4DaOosJZks3WT7So89iweOGqvDqASNUUl0+N3YqScAluFLRFDPnSb4BVdSN
 IBvqH+fCEctLdW17pcA7zzd8KG9JJrjY60LF+y6QFJJSf6Dn37UUIZlnYTgy+A+igywp
 Ik6hrtSpUZD2Rp2t/HpcRZW2jPdD7wTm3lBIf52arYGq93XInUpQR0ZE1PkyJfu6PU/I
 yOs/lGdjeKIr9jA7vjj70p26spRStT8o6EbAdRlTCNUmBpwP4SA/Fx14Ttn+4Dx0i9Ix
 baYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719359585; x=1719964385;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n08fHnAR3SdcuUTo8d/rWTb5o0Cgqg/50Gn4XFRGS34=;
 b=W9TR1ee8R1WK4K7qTFASKiUwI4RT2ydSxcsJlcFqg5Q7c/AwTBZue7ct3xPRf9iL0o
 q9iXBrzVHxt+wx+vN5W2qqzoNN8FfM9sQ1yUCjB6TiN8JE05lN/vr6ZR7kTilPgdLlKf
 EwsSVj0QIo97z1JblEdM8ObNwA+MGerkGI2jU5rEDPoM7LhFWsyDj/S3f0ciU17QWfaC
 WoFDIpIx7eb102zJG620as2S9JS4hakwj2ziR+K9PVwb4DnVAQKlk2TRzBcFFcoTy2Xx
 Rt7Sv5TYrYktAlOU12mpgU4ZVWKQnt8HDuf0+zpaos3Tg+dMxFyQGDhZbO+tj9faeroI
 zYYg==
X-Gm-Message-State: AOJu0YxH2x8HkNQykZuaOlaiNodHgJ1pKrZyra+nHU4ZuDLMpgqBPKgj
 L3r8lYd3E5j5brTiLGrV7JD6dRFR4/jsefH45j16qPCmSRR2woWBDFYiW6u9lqj4J/hr+HLsMsy
 Y8UGFE9UgOBsui7chv1YAHpKZJmfSZdvm9OQ28eKBdh1Xaj8B1VnF7fZTNCjfyxf69tvWheTvL/
 xZGqYLsmPNR0Rtnv2TiRXoobfZJGAmCyc=
X-Google-Smtp-Source: AGHT+IEjFHmbNA3gkoVR/ojMYDMZbK9dGOs1LfYwnsvnrX1NBmgqzmoCRNOwFEAACz0zCMIGnZAAjanK+PHg
X-Received: from jstultz-noogler2.c.googlers.com
 ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6a00:420b:b0:706:5e9c:96d2 with SMTP
 id d2e1a72fcca58-70674374177mr149605b3a.0.1719359584741; Tue, 25 Jun 2024
 16:53:04 -0700 (PDT)
Date: Tue, 25 Jun 2024 16:52:35 -0700
In-Reply-To: <20240625235245.2106313-1-jstultz@google.com>
Mime-Version: 1.0
References: <20240625235245.2106313-1-jstultz@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240625235245.2106313-7-jstultz@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 6/6] sched_football: Add trace_marker messages if
 we're tracing
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
From: John Stultz via ltp <ltp@lists.linux.it>
Reply-To: John Stultz <jstultz@google.com>
Cc: kernel-team@android.com, John Stultz <jstultz@google.com>,
 Darren Hart <darren@os.amperecomputing.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

To further help with tracing, add trace_marker messages so we
can see exactly when the game starts and ends in the tracelog.

Cc: kernel-team@android.com
Cc: Cyril Hrubis <chrubis@suse.cz>
Cc: Darren Hart <darren@os.amperecomputing.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
v2:
* Pulled trace marker writing out into librttest helper functions
  as suggested by Cyril
---
 .../func/sched_football/sched_football.c      |  5 +++
 testcases/realtime/include/librttest.h        | 13 ++++++++
 testcases/realtime/lib/librttest.c            | 32 +++++++++++++++++++
 3 files changed, 50 insertions(+)

diff --git a/testcases/realtime/func/sched_football/sched_football.c b/testcases/realtime/func/sched_football/sched_football.c
index 40496cc22..b6ae692af 100644
--- a/testcases/realtime/func/sched_football/sched_football.c
+++ b/testcases/realtime/func/sched_football/sched_football.c
@@ -66,6 +66,7 @@
 #include <pthread.h>
 #include <sched.h>
 #include <errno.h>
+#include <fcntl.h>
 #include <sys/syscall.h>
 #include <unistd.h>
 #include <sys/prctl.h>
@@ -171,17 +172,21 @@ int referee(int game_length)
 	prctl(PR_SET_NAME, "referee", 0, 0, 0);
 	printf("Game On (%d seconds)!\n", game_length);
 
+	/* open trace marker early to avoid latency with the first message */
+	trace_marker_prep();
 	gettimeofday(&start, NULL);
 	now = start;
 
 	/* Start the game! */
 	tst_atomic_store(0, &the_ball);
+	atrace_marker_write("sched_football", "Game_started!");
 
 	/* Watch the game */
 	while ((now.tv_sec - start.tv_sec) < game_length) {
 		sleep(1);
 		gettimeofday(&now, NULL);
 	}
+	atrace_marker_write("sched_football", "Game_Over!");
 	final_ball = tst_atomic_load(&the_ball);
 	/* Blow the whistle */
 	printf("Game Over!\n");
diff --git a/testcases/realtime/include/librttest.h b/testcases/realtime/include/librttest.h
index 8733479e7..0a1bb0540 100644
--- a/testcases/realtime/include/librttest.h
+++ b/testcases/realtime/include/librttest.h
@@ -342,4 +342,17 @@ void latency_trace_stop(void);
  */
 void latency_trace_print(void);
 
+/* trace_marker_prep: open trace_marker file (optional)
+ */
+void trace_marker_prep(void);
+
+/* trace_marker_write: write buf to trace_marker.
+ * Will open trace_marker file if not already open
+ */
+int trace_marker_write(char *buf, int len);
+
+/* atrace_marker_write: write atrace format message to trace_marker
+ */
+int atrace_marker_write(char *tag, char *msg);
+
 #endif /* LIBRTTEST_H */
diff --git a/testcases/realtime/lib/librttest.c b/testcases/realtime/lib/librttest.c
index eaa623b72..191c667a1 100644
--- a/testcases/realtime/lib/librttest.c
+++ b/testcases/realtime/lib/librttest.c
@@ -732,3 +732,35 @@ void latency_trace_print(void)
 {
 	read_and_print("/proc/latency_trace", STDOUT_FILENO);
 }
+
+static int trace_marker_fd = -1;
+
+void trace_marker_prep(void)
+{
+	if (trace_marker_fd != -1)
+		return;
+	trace_marker_fd = open("/sys/kernel/tracing/trace_marker", O_RDWR, 0);
+}
+
+int trace_marker_write(char *buf, int len)
+{
+	if (trace_marker_fd == -1)
+		trace_marker_prep();
+
+	if (trace_marker_fd < 0)
+		return -1;
+
+	return write(trace_marker_fd, buf, len);
+}
+
+#define TRACE_BUF_LEN 256
+static char trace_buf[TRACE_BUF_LEN];
+
+int atrace_marker_write(char *tag, char *msg)
+{
+	/* Uses atrace format perfetto can visualize */
+	snprintf(trace_buf, TRACE_BUF_LEN, "I|%i|%s: %s\n", getpid(), tag, msg);
+	return trace_marker_write(trace_buf,
+				  strnlen(trace_buf, TRACE_BUF_LEN));
+}
+
-- 
2.45.2.741.gdbec12cfda-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
