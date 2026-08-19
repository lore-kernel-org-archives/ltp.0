Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B08C2C5DF85
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 09:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787131955; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=IBf5CLqiwC2w5gcMyWqg/FNQ8CZRygxNI76AdByL3QQ=;
 b=DT2YxMw9BjweVVpJdOLd6XVAFJbc4gz+wTr5jCr1cn9Hxyh05JWXx4OY6wFnMlin/Wpo9
 0xFh4gEcWe0/xA6K9brdMY2sPHZdbgYvGjdqreltnn9eXln9CF3+evAsuuorQ9n5wHCp70K
 X3fp1aL/l3vlicpfXF+xLZOJDL7TveQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 911B73CD56B
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 11:32:35 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 69DE83CB329
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 11:32:15 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C7D8C200AC3
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 11:32:14 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4815bce4652so483597f8f.1
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 02:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787131934; x=1787736734; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QThABqAEPKLPsUEsYS0ZUVwh2kkGPgKlyeCeOr9EPM4=;
 b=R30dfyMV93qFRnF3F0tCmvYDg0emCqMF8gf0fZHPkCGwRAHqF3dVOaa8OU/paAkEu5
 mJ0JBSL+CFQfnoiGh3v584B6BtmdUaL2I46/nXXltc++77aH6JxHrTCJMqFIN6v8pusi
 3vZxhTWVJwTRGBSCO8bNqA2YHtr9LCGI2GGeoTASZd2mW1NObeIXfpTzTUKbPFyN3D2F
 gjisrJwaitwtBONRkOTs8fYcDGxp89kpDRSJC6htp+hgGR2HSw7cB2Evs0jlGjH6e1Si
 pqYb8qTwfxmtmZ6D7IqsYAIl3I3wLppSqz9Hg/DkkbfU85Xy+zs5ABg6yXfw1e9FGqVk
 B7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787131934; x=1787736734;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QThABqAEPKLPsUEsYS0ZUVwh2kkGPgKlyeCeOr9EPM4=;
 b=cSbi8YK5djaW8HkjnPR2LVvrMVRzteI/7a2nkBwYMacZOhDOpoH7oSZyp4ZYzTew7j
 j+MI112WTzJjPOA8XB2jxdK68/KKJSOu7pj1yP/kuyEpJdi7RAYFpHlcrlAfMi9hGiSJ
 3k29iHD+WOGSeOAZZZ23qZQ0lIOI9+qS3w6PCH80BC+lnUg5px4e1gUpyWNj5IfjmOHn
 63x9YGGVyMR9VpuCvFs73zhNPrSHjl5DBRe6cgdAEBsW+SKYZ1wupFZ6jWUhGlPXKqkA
 f2LXXaZqGtkTsPuS18iwAZvOr/j8CnNf65+4w2mYbrezW2fD056qXOm8NXxW2i0gI4l9
 oTsA==
X-Gm-Message-State: AOJu0YzbeyMQ2ZhLo0Dj0/0AaKqEr2LKzITrN6Qtb04U/Us3wjF5ddIJ
 Y4MBMiT7s6KJS6D5Hd8TqhwkjfIMVNkzRow1Y+MdV26tm2GHtMZZ7oqGbr4P9z1WbQzu9l7hkV+
 EUrGbA0E=
X-Gm-Gg: AR+sD11mIfvde8yEBIxqoMpQVWSLts5/BAtBeHSkersxzFwFMLH4X6mq4hD5qxnczpW
 DUFd2Ev0xWcYWc8CNoCZN1uOQPhVPj1+C8Izd08VNt6G3uyUTaURcobYEzcK1fqtEVJWkUnhAD/
 kfTmcA+6tpXWbbb2KZ/zTAjKN2RUyXL98BkWqfMiejP9SvKYYI9XKGH2EB1U5KXbvzNPypIvXf1
 dwhfxo8eO02Uny2nVD3O+YnWESpBdSqRWMQUdmmJERm0+Ax0O8MF2Uzm74MJaffAfybv9nfbRw+
 fiJhiyTBmj71kfdtt7FHhVNEbKzgZ4B4Gdc519+vqjqqHC7ZMZk9lehv5JSn+RpCZvI7ySRYhem
 yTlOTufC5U9XkE2437IKfGdXHINyvtoaE1+995yVpPivt/PtgpDu4nJf7rtYvcoa/CO6F+uGR+u
 FOhiTCdGt/gk+v3hKUe0D/IUhLIXPOgL3IJK4hs97suddwYA==
X-Received: by 2002:a05:600c:37c6:b0:499:858f:2653 with SMTP id
 5b1f17b1804b1-499aa14b457mr60241595e9.2.1787131934032; 
 Wed, 19 Aug 2026 02:32:14 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9dffa59sm66674245e9.3.2026.08.19.02.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 02:32:12 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 19 Aug 2026 11:31:59 +0200
Message-ID: <20260819093210.24342-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] openposix: timer_*/speculative: Skip untestable
 optional behavior on Linux
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Avinesh Kumar <avinesh.kumar@suse.com>

timer_delete/speculative/5-{1,2}, timer_getoverrun/speculative/6-{1,2,3},
timer_gettime/speculative/6-{1,2,3}, and timer_settime/speculative/12-{1,2,3}
all test EINVAL for an invalid timerid, which POSIX Issue 6/TC2 made
optional rather than required.[0][1]
Linux does not implement this optional behavior, so skip it there with
PTS_UNSUPPORTED and leave the test intact for implementations that do.

[0] https://pubs.opengroup.org/onlinepubs/9799919799/functions/timer_getoverrun.html
[1] https://pubs.opengroup.org/onlinepubs/9799919799/functions/timer_delete.html

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 .../conformance/interfaces/timer_delete/speculative/5-1.c    | 5 +++++
 .../conformance/interfaces/timer_delete/speculative/5-2.c    | 5 +++++
 .../interfaces/timer_getoverrun/speculative/6-1.c            | 5 +++++
 .../interfaces/timer_getoverrun/speculative/6-2.c            | 5 +++++
 .../interfaces/timer_getoverrun/speculative/6-3.c            | 5 +++++
 .../conformance/interfaces/timer_gettime/speculative/6-1.c   | 5 +++++
 .../conformance/interfaces/timer_gettime/speculative/6-2.c   | 5 +++++
 .../conformance/interfaces/timer_gettime/speculative/6-3.c   | 5 +++++
 .../conformance/interfaces/timer_settime/speculative/12-1.c  | 5 +++++
 .../conformance/interfaces/timer_settime/speculative/12-2.c  | 5 +++++
 .../conformance/interfaces/timer_settime/speculative/12-3.c  | 5 +++++
 11 files changed, 55 insertions(+)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c
index 912cf5800e6f..7c776236d31d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c
@@ -19,6 +19,10 @@
 
 int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 {
+#ifdef __linux__
+	printf("Linux does not implement this optional behavior\n");
+	return PTS_UNSUPPORTED;
+#else
 	timer_t tid;
 	int tval = BOGUSTIMERID;
 	tid = (timer_t) & tval;
@@ -37,4 +41,5 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 
 	printf("timer_delete() did not return -1\n");
 	return PTS_PASS;
+#endif
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-2.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-2.c
index 74eeb46793b2..63574bfd58f7 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-2.c
@@ -34,6 +34,10 @@ static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 
 int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 {
+#ifdef __linux__
+	printf("Linux does not implement this optional behavior\n");
+	return PTS_UNSUPPORTED;
+#else
 	struct sigevent ev;
 	struct sigaction act;
 	timer_t tid;
@@ -91,4 +95,5 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 
 	printf("fcn did not return -1\n");
 	return PTS_PASS;
+#endif
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-1.c
index 6e18560e5084..31c8a4df3d17 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-1.c
@@ -19,6 +19,10 @@
 
 int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 {
+#ifdef __linux__
+	printf("Linux does not implement this optional behavior\n");
+	return PTS_UNSUPPORTED;
+#else
 	timer_t tid;
 	int tval = BOGUSTID;
 	tid = (timer_t) & tval;
@@ -36,4 +40,5 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 
 	printf("fcn did not return -1\n");
 	return PTS_PASS;
+#endif
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-2.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-2.c
index 2d7f3967ced1..3004b1eb80ba 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-2.c
@@ -26,6 +26,10 @@
 
 int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 {
+#ifdef __linux__
+	printf("Linux does not implement this optional behavior\n");
+	return PTS_UNSUPPORTED;
+#else
 	struct sigevent ev;
 	timer_t tid;
 
@@ -55,4 +59,5 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 
 	printf("fcn did not return -1\n");
 	return PTS_PASS;
+#endif
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-3.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-3.c
index 933a31dcd3e7..bd443e7629aa 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-3.c
@@ -23,6 +23,10 @@
 
 int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 {
+#ifdef __linux__
+	printf("Linux does not implement this optional behavior\n");
+	return PTS_UNSUPPORTED;
+#else
 	struct sigevent ev;
 	timer_t tid;
 
@@ -47,4 +51,5 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 
 	printf("fcn did not return -1\n");
 	return PTS_PASS;
+#endif
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c
index d09c2f70901d..82a2f0b508dd 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c
@@ -19,6 +19,10 @@
 
 int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 {
+#ifdef __linux__
+	printf("Linux does not implement this optional behavior\n");
+	return PTS_UNSUPPORTED;
+#else
 	timer_t tid;
 	struct itimerspec its;
 	int tval = BOGUSTID;
@@ -35,4 +39,5 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 	}
 	printf("fcn did not return -1\n");
 	return PTS_PASS;
+#endif
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-2.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-2.c
index 88a8d221914b..df103dd78b9d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-2.c
@@ -21,6 +21,10 @@
 
 int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 {
+#ifdef __linux__
+	printf("Linux does not implement this optional behavior\n");
+	return PTS_UNSUPPORTED;
+#else
 	struct sigevent ev;
 	timer_t tid;
 	struct itimerspec its;
@@ -45,4 +49,5 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 	}
 	printf("fcn did not return -1\n");
 	return PTS_PASS;
+#endif
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-3.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-3.c
index ef7c37f5eb99..4b901e0d4329 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-3.c
@@ -21,6 +21,10 @@
 
 int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 {
+#ifdef __linux__
+	printf("Linux does not implement this optional behavior\n");
+	return PTS_UNSUPPORTED;
+#else
 	struct sigevent ev;
 	timer_t tid;
 	struct itimerspec its;
@@ -49,4 +53,5 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 	}
 	printf("fcn did not return -1\n");
 	return PTS_PASS;
+#endif
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-1.c
index 5d4e1dda30ba..e20766ba5838 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-1.c
@@ -18,6 +18,10 @@
 
 int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 {
+#ifdef __linux__
+	printf("Linux does not implement this optional behavior\n");
+	return PTS_UNSUPPORTED;
+#else
 	timer_t tid;
 	struct itimerspec its;
 	int tval = BOGUSTID;
@@ -39,4 +43,5 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 	}
 	printf("fcn did not return -1\n");
 	return PTS_PASS;
+#endif
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-2.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-2.c
index 3b6901c25dc7..83c7aa10c7ce 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-2.c
@@ -25,6 +25,10 @@
 
 int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 {
+#ifdef __linux__
+	printf("Linux does not implement this optional behavior\n");
+	return PTS_UNSUPPORTED;
+#else
 	struct sigevent ev;
 	timer_t tid;
 	struct itimerspec its;
@@ -54,4 +58,5 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 	}
 	printf("fcn did not return -1\n");
 	return PTS_PASS;
+#endif
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-3.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-3.c
index 04ceb2745af3..c4c469410874 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-3.c
@@ -23,6 +23,10 @@
 
 int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 {
+#ifdef __linux__
+	printf("Linux does not implement this optional behavior\n");
+	return PTS_UNSUPPORTED;
+#else
 	struct sigevent ev;
 	timer_t tid;
 	struct itimerspec its;
@@ -56,4 +60,5 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 	}
 	printf("fcn did not return -1\n");
 	return PTS_PASS;
+#endif
 }
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
