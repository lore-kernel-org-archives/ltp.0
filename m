Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF088606A327
	for <ltp@archiver.kernel.org>; Wed, 25 Nov 2026 21:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=AqsmP3fs
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 86B313E9149
	for <ltp@archiver.kernel.org>; Wed, 25 Nov 2026 22:10:05 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 02E393E9149
 for <ltp@lists.linux.it>; Wed, 25 Nov 2026 22:09:38 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9DCD0200A08
 for <ltp@lists.linux.it>; Wed, 25 Nov 2026 22:09:37 +0100 (CET)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6bae06f2b8aso476207a12.2
 for <ltp@lists.linux.it>; Wed, 25 Nov 2026 13:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795640977; x=1796245777; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NRS8KdXYJuDHVrPzLf7aY4PcloaxgF6xnlYDzZe4OnI=;
 b=AqsmP3fsTXrpSQZwgaFQ5kcC3rqTq4waO3nCGZ9DoBpwdMKRAe475MHO3/EW49+iDw
 oq3IdJk4Mp/M46noRnD1xv/CiWKak7+DMYea/g0KhvfigqkDWgwdLoah7plep90fSG5/
 yQpWDPEluSJcwHJsA+ACWxAVbk3d7huxwOmhZwgxR2vFoNsS18LyDEvEEGYXpYGnBxFe
 tCl1ZNuemcpf5ftWGRA6E4tnrG4q8WPi63/NGWiBN+InQ6VSsfnum5Me9XRK0IPGRk60
 c1QOpQeBKHVTfOxdZpfAxbXorQMRKBVza4x7N5aQ3P6W2pVj3f3b95g7j14f+UXR6mcS
 WN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795640977; x=1796245777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NRS8KdXYJuDHVrPzLf7aY4PcloaxgF6xnlYDzZe4OnI=;
 b=PbqX26BSBX9ygh+pznvfsXpETqxEKFzHs9E80pWqeokawIHQH1qhHRREctUFxvKtEk
 0CqG4cOMAB5pO6j3iVMt2lizlAtU1TOMK9/zn64bMcJQYhFXyehXlgwvryv5rKDAFRu5
 8pv1LrnQa/s8bcEJ2iEP8JOl+V4lRSnOnhVPoCwexf8hO9khazfnxkB3A60EKbX0978U
 DmO2RHSBPnJdjglBfpXgwUkX142UdAbPexzYC4aRiZldgHQtE4ALF5TFt3HqahUh44lb
 /dXLc+hYoDSV5cv2zlGWzLVw5kfdtvfP7CjFZOUDuFJul9Lung8dvjFsyO/d+f7tTIC8
 E6lw==
X-Gm-Message-State: APuU4Z8xlF4l5Kdlw3WHbatQmIyCdFJuadTtIWkuvPqGtQpa6RFeJfH+
 r3M5YVBMlYqgXv+bhcGDNIofIfsXJvjxNJFbulXjFQmKC+iRnMcjxs80oUhQ+Uq9ik/wp+n4UxX
 hp41o
X-Gm-Gg: AZFdTZcHBgoPlWqb0O1K8QuvYTa/lAuGZUKE0g1aTP1awrbLIB3ndZRNJIgfyyY8RMt
 XLFZGb0wDbFRBWdASAdPcdwRwLHrNkqiz+vSWgmCfE4Taq3Z3nHXGUvBH5weDy7RgCHdJIks2Yn
 PYZlOQEGF6tdWmYDEse1eqg+UuKrkH7s9hphb73x8AAMW5wRSXnLOu8A5WyVpGg/w2UA2U2DpP2
 D6UktdF5kXrY/GX7MRwdWoeJnluOttTUKnkb8A/7eLy0jQXkXspaXBV23x7zCtNc7B6LaO34ZUN
 D5e7Md3kbQHMnQWUK5s5Z2R8LvpbiLdQqVYlg0cq6cmEhqJB6eDj+X3hUSfrues598JGGM9/vNW
 j8Cgw080EZ6hbt7LYS8o4/goUyMN0mjCYH+4QPbTQoySkgTLugyq8YgFuUEGAfA/uktdYS0SWF/
 ccAvN2sov2eSj5+udg+duULb05Niyi3I10zdsLvYT69Fi/5ZjfLgpPRUWC6I84ZPU+I9E/XvLrq
 a2PZx4Z6y+ayLezeAjWSqwKFttX6bWXLXX7ze1f54a3xw+6u8jsAUTUTaElNBfyMKNILk6EXZKq
 N8KFfs3hhC9Gwy+Zgfdc1MgMygdcW7dIZ7rAcU/o4EvFvtRMSuP4xjOF7o+hWJUnweDHlKzcQRo
 2myBkJj4o5Q==
X-Received: by 2002:a05:6402:234b:b0:6ba:382a:57ba with SMTP id
 4fb4d7f45d1cf-6ba382a5c5emr16343305a12.2.1795640976953; 
 Wed, 25 Nov 2026 13:09:36 -0800 (PST)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba370fa8basm9196168a12.20.2026.11.25.13.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 13:09:36 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: ltp@lists.linux.it,
	pvorel@suse.cz
Date: Wed, 25 Nov 2026 22:09:30 +0100
Message-ID: <20261125210933.2913177-2-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125210933.2913177-1-anders.roxell@linaro.org>
References: <20261125210933.2913177-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/4] openposix: mqueues: Use one thread by default
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

multi_send_rev_1 and multi_send_rev_2 fail without the number of
threads as an argument. Only run-tests.sh passes it, from a .args file
that make install does not install.

Default to one thread like the .args files, and remove the unused
getopt.h include.

Suggested-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 .../stress/mqueues/multi_send_rev_1.c                     | 8 +++++---
 .../stress/mqueues/multi_send_rev_2.c                     | 8 +++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/testcases/open_posix_testsuite/stress/mqueues/multi_send_rev_1.c b/testcases/open_posix_testsuite/stress/mqueues/multi_send_rev_1.c
index 5003681f7bb4..fed92ae755e6 100644
--- a/testcases/open_posix_testsuite/stress/mqueues/multi_send_rev_1.c
+++ b/testcases/open_posix_testsuite/stress/mqueues/multi_send_rev_1.c
@@ -18,7 +18,6 @@
 #include <sys/wait.h>
 #include <sys/mman.h>
 #include <string.h>
-#include <getopt.h>
 #include <pthread.h>
 #include <limits.h>
 #include <mqueue.h>
@@ -28,6 +27,7 @@
 #define MSG_SIZE	128
 #define MAX_MSG		3
 #define Max_Threads	10
+#define DEFAULT_THREADS	1
 #define Name_Size	20
 
 typedef struct {
@@ -96,8 +96,10 @@ int test_main(int argc, char **argv)
 	printf("_POSIX_MESSAGE_PASSING is not defined \n");
 	return PTS_UNRESOLVED;
 #endif */
-	if ((2 != argc) || ((num = atoi(argv[1])) <= 0)) {
-		fprintf(stderr, "Usage: %s number_of_threads\n", argv[0]);
+	if (argc < 2) {
+		num = DEFAULT_THREADS;
+	} else if ((num = atoi(argv[1])) <= 0) {
+		fprintf(stderr, "Usage: %s [number_of_threads]\n", argv[0]);
 		return PTS_FAIL;
 	}
 	if (num > Max_Threads) {
diff --git a/testcases/open_posix_testsuite/stress/mqueues/multi_send_rev_2.c b/testcases/open_posix_testsuite/stress/mqueues/multi_send_rev_2.c
index 9fe44113f704..989273b2da83 100644
--- a/testcases/open_posix_testsuite/stress/mqueues/multi_send_rev_2.c
+++ b/testcases/open_posix_testsuite/stress/mqueues/multi_send_rev_2.c
@@ -18,7 +18,6 @@
 #include <sys/wait.h>
 #include <sys/mman.h>
 #include <string.h>
-#include <getopt.h>
 #include <pthread.h>
 #include <limits.h>
 #include <mqueue.h>
@@ -29,6 +28,7 @@
 #define MSG_SIZE	128
 #define MAX_MSG		5
 #define Max_Threads	100
+#define DEFAULT_THREADS	1
 
 static const char *s_msg_ptr[] =
     { "send_1 1", "send_1 2", "send_1 3", "send_1 4", "send_1 5" };
@@ -85,8 +85,10 @@ int test_main(int argc, char **argv)
 	printf("_POSIX_MESSAGE_PASSING is not defined \n");
 	return PTS_UNRESOLVED;
 #endif */
-	if ((2 != argc) || ((num = atoi(argv[1])) <= 0)) {
-		fprintf(stderr, "Usage: %s number_of_threads\n", argv[0]);
+	if (argc < 2) {
+		num = DEFAULT_THREADS;
+	} else if ((num = atoi(argv[1])) <= 0) {
+		fprintf(stderr, "Usage: %s [number_of_threads]\n", argv[0]);
 		return PTS_FAIL;
 	}
 	if (num > Max_Threads) {
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
