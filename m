Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89249C433F5
	for <ltp@archiver.kernel.org>; Thu,  6 Oct 2022 18:43:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A416B3CAD3F
	for <ltp@archiver.kernel.org>; Thu,  6 Oct 2022 20:43:32 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7A483CAE21
 for <ltp@lists.linux.it>; Thu,  6 Oct 2022 20:42:41 +0200 (CEST)
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com
 [IPv6:2607:f8b0:4864:20::104a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 58578601201
 for <ltp@lists.linux.it>; Thu,  6 Oct 2022 20:42:41 +0200 (CEST)
Received: by mail-pj1-x104a.google.com with SMTP id
 o11-20020a17090aac0b00b0020625062cbaso3370372pjq.2
 for <ltp@lists.linux.it>; Thu, 06 Oct 2022 11:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=lzbtN5IJ5KoF+wGT2IvqHAYOyvrIRJJRFXr05hAHiVw=;
 b=tO9MYFtZuDaQrmcIKRZPZLbJFHfxClWPmSGpzt3XRCQ+8sMd65+6uFhG9b6lS38Jnw
 iTKPUb85u1Vo0YfOQY/gwc6QfVdVPc1Smk5q9M1gCBgaLScsuAOhtFufGbNXOpObsAzn
 5+byF2TbkywNZpJ5LRP3A2VV6OnCOrbV9jAcA+gtVRoJR1RM9iKC9VK2gV7+wNYrierB
 vl+h3VfX5de3i+5v0BAyxqEWi2QN5J7iB0sBsYAPN9Ywgi5+bZyQTDw+AP99xUASO+HV
 5j9n17gWu0FXybXNEXmtnjNBNE3DbQu/aWFcUivSTgwycCfJhVdaWXIaBfS1hTWDWikb
 1uug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lzbtN5IJ5KoF+wGT2IvqHAYOyvrIRJJRFXr05hAHiVw=;
 b=X4KZaNEbzmRpCJgdM23PcgPUzY6xf1NcfRtnl0aJ4SvAXZKkYbhP/yZPhYbtv/Bgrb
 VtR0JOpdT3nLCXzUAbS6XXcABJCMSy0lQmYFk0YpIeE0y3lkfbGsY0bLA8mKcCemlRk/
 0uJT9tXhcnJyBmswM2yG19aH7fctsGeQn8sKudRP85kZ/11pvCboDP5+IFR9tzMnD5E9
 f49LBZXfs5ec71eICUCPF1BzlMS5S0aLoQJpuvjcHvugC0bbJcJZ4v7RpEXKdWeJLh36
 s5jIuPmx3+IulLp43JSNSXv8E+oLlTeKPj7QJ87jV2LXEqwvMRryOPZ4U50cNwEEx8/7
 4Nlg==
X-Gm-Message-State: ACrzQf2n+xjN4G9HwxzcU8Yvxm1rjLnA0dkIOdhFHOIJENp+K+lVBjWa
 rLAj2Ynks48UguooePLcAnkNVRgrGMRh4XEWS/75UwAdjWegVzYUxzmYjE2lc4oYL2sr760jV7E
 gQnjLKCWxha4Oi2ECeojsC/zwdaMkkyYHRGfg9i4zuH4oXPkp8KWVatpI
X-Google-Smtp-Source: AMsMyM6zrCqJwjG3Pd8bNhmRSLKCS/zbovOtee9Bkrcr+hlep4iOX0CS8ZjM/ETqWMyqg4pAtk3M6bz5nlA=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:cd06:b0:203:ae0e:6a21 with SMTP id
 d6-20020a17090acd0600b00203ae0e6a21mr445328pju.0.1665081759214; Thu, 06 Oct
 2022 11:42:39 -0700 (PDT)
Date: Thu,  6 Oct 2022 18:42:28 +0000
In-Reply-To: <20221006184228.3281392-1-edliaw@google.com>
Mime-Version: 1.0
References: <20221006184228.3281392-1-edliaw@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221006184228.3281392-5-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 4/4] mmapstress01: use max_runtime
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

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 .../kernel/mem/mmapstress/mmapstress01.c      | 24 +++++--------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/testcases/kernel/mem/mmapstress/mmapstress01.c b/testcases/kernel/mem/mmapstress/mmapstress01.c
index 9a18587cf..83d3f387d 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress01.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress01.c
@@ -48,7 +48,6 @@ static unsigned int initrand(void);
 static char *debug;
 static char *do_sync;
 static char *do_offset;
-static char *opt_alarmtime;
 static char *opt_filesize;
 static char *opt_nprocs;
 static char *opt_sparseoffset;
@@ -57,7 +56,6 @@ static char *randloops;
 static int fd;
 static int finished;
 static int nprocs = 20;
-static float alarmtime;
 static long long filesize = 4096;
 static long long sparseoffset;
 static size_t pagesize;
@@ -77,7 +75,6 @@ static struct tst_option options[] = {
 	 "When non-zero, causes the sparse area to be left before the data, "
 	 "so that the actual initial filesize is sparseoffset + filesize "
 	 "(default 0)"},
-	{"t:", &opt_alarmtime, "Number of minutes to run (default 0)"},
 	{},
 };
 
@@ -105,18 +102,10 @@ static void setup(void)
 		tst_brk(TBROK, "invalid number of mapping children '%s'",
 			opt_nprocs);
 
-	if (tst_parse_float(opt_alarmtime, &alarmtime, 0, FLT_MAX / 60))
-		tst_brk(TBROK, "invalid minutes to run '%s'", opt_alarmtime);
-
 	if (debug) {
 		tst_res(TINFO, "creating file <%s> with %lld bytes, pattern %d",
 			TEST_FILE, filesize, pattern);
-		if (alarmtime)
-			tst_res(TINFO, "running for %f minutes", alarmtime);
-		else
-			tst_res(TINFO, "running with no time limit");
 	}
-	alarmtime *= 60;
 }
 
 static void cleanup(void)
@@ -312,8 +301,7 @@ static void run(void)
 	pattern = seed & 0xff;
 
 	/*
-	 *  Plan for death by signal.  User may have specified
-	 *  a time limit, in which set an alarm and catch SIGALRM.
+	 *  Plan for death by signal or alarm.
 	 *  Also catch and cleanup with SIGINT.
 	 */
 	sa.sa_handler = sighandler;
@@ -323,10 +311,9 @@ static void run(void)
 	SAFE_SIGACTION(SIGQUIT, &sa, 0);
 	SAFE_SIGACTION(SIGTERM, &sa, 0);
 
-	if (alarmtime) {
-		SAFE_SIGACTION(SIGALRM, &sa, 0);
-		(void)alarm(alarmtime);
-	}
+	SAFE_SIGACTION(SIGALRM, &sa, 0);
+	alarm(tst_remaining_runtime());
+
 	fd = SAFE_OPEN(TEST_FILE, O_CREAT | O_TRUNC | O_RDWR, 0664);
 
 	buf = SAFE_MALLOC(pagesize);
@@ -415,7 +402,7 @@ static void run(void)
 	SAFE_SIGEMPTYSET(&set_mask);
 	SAFE_SIGADDSET(&set_mask, SIGALRM);
 	SAFE_SIGPROCMASK(SIG_BLOCK, &set_mask, NULL);
-	(void)alarm(0);
+	alarm(0);
 
 	/*
 	 *  Finished!  Check the file for sanity.
@@ -429,6 +416,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.options = options,
 	.cleanup = cleanup,
+	.max_runtime = 12,
 	.needs_tmpdir = 1,
 	.forks_child = 1,
 };
-- 
2.38.0.rc1.362.ged0d419d3c-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
