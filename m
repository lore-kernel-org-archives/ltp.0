Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761F2C433EF
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 13:28:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D04613C928D
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 15:28:05 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E25D3C9266
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 15:27:44 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 994CC6002C4
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 15:27:44 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id o8so14704827wro.3
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 06:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AMbHAsfg5InTeTYpQcp91/RcpYe8eE9b78r04KXwY1Q=;
 b=nhFwBxC+92Pyg/Oi41R+3cQfWZrm189VXKTQTvZR0+gBNrdhnnvS5mufoApv81EYb4
 ywtLfv2NC50qF3v/qHQxZIEYwVqh0uxQjb0+Sy4Muieqad/5243aEK5Ht4Xe7wHrIS/2
 j9NhBG8Fdwer66vEH/1579MW8f4TGwD/aGMJVvc/AWY8PzfQRPGvvQ5ss14lNYYxID8U
 JL8Uf8x58IVYnNLyxAzFYaEvheqO+N+K6pXqehezIJ/Pdic8yA5NdMJald3Apbjtd52E
 SmE52QiIPalRa0Vd73r+g7tAQ2MmwZVNK7p267BzogvSDCeyju46AlElwygvbypIT6JM
 lVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AMbHAsfg5InTeTYpQcp91/RcpYe8eE9b78r04KXwY1Q=;
 b=T7XAhIuY4bB0hTKAz70/9v1CDOfZ2YDRRYxI08/XN6kvxvU95aXUd6IvWJ1+FoSJzx
 kvQ2wQWoPh2UnV5675YQLPvU5HKA4OhZa/BAh5uPknEVN+IEYrCV5l9rkSgwbiGSU3DB
 Ne94a8a0la8bXAREVBV0XZzdPnuYXwZ8sw15zbBLn49hwJ3jdD8M81bIvSvRDmfDDaoN
 9o8Q6FXcvh8Jh6T5joUUHNOoATpvYXXTAI2ea4jPhoNftr0A59XZTa3f9EEMt5PalWTF
 DAKpzkWcflOtzdVOZU3L9PTwq+sqq4XHV+FBODjNNktNhvM0rY9Tkt63KQvOVbJ98kS4
 /Rhg==
X-Gm-Message-State: AJIora+QLZsUbbYNOf1PWmJxbOIOtdsplkzVcXV2Uch+ZwJAwUEShBvz
 ldLJ1IZk1zTjaAZ787LxABvts4Fh+LKM1w==
X-Google-Smtp-Source: AGRyM1tW4q5+mSIUXaHnVA5Diuh5aYtSN6AOhc+eemk4eu9UMBE9bR/uqt+RYv29v4WC/WUlOrO41w==
X-Received: by 2002:a05:6000:1887:b0:218:5d15:9a95 with SMTP id
 a7-20020a056000188700b002185d159a95mr23046956wri.1.1655731664091; 
 Mon, 20 Jun 2022 06:27:44 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local
 (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a5d4f85000000b0021b862ad439sm9086556wru.9.2022.06.20.06.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jun 2022 06:27:43 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 20 Jun 2022 16:27:34 +0300
Message-Id: <20220620132737.2015073-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620132737.2015073-1-amir73il@gmail.com>
References: <20220620132737.2015073-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/4] syscalls/fanotify09: Cleanup open event fds on
 error
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
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Avoid breaking out of test, without closing all fds of events in buffer
to avoid failure to unmount fs on cleanup.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify09.c     | 45 ++++++++++---------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify09.c b/testcases/kernel/syscalls/fanotify/fanotify09.c
index fea374689..60ffcb81b 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify09.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify09.c
@@ -238,6 +238,15 @@ static void verify_event(int group, struct fanotify_event_metadata *event,
 		SAFE_CLOSE(event->fd);
 }
 
+static void close_event_fds(struct fanotify_event_metadata *event, int buflen)
+{
+	/* Close all file descriptors of read events */
+	for (; FAN_EVENT_OK(event, buflen); FAN_EVENT_NEXT(event, buflen)) {
+		if (event->fd != FAN_NOFD)
+			SAFE_CLOSE(event->fd);
+	}
+}
+
 static void test_fanotify(unsigned int n)
 {
 	int ret, dirfd;
@@ -262,8 +271,7 @@ static void test_fanotify(unsigned int n)
 	 * generate FAN_CLOSE_NOWRITE event on a child, subdir or "."
 	 */
 	dirfd = SAFE_OPEN(tc->close_nowrite, O_RDONLY);
-	if (dirfd >= 0)
-		SAFE_CLOSE(dirfd);
+	SAFE_CLOSE(dirfd);
 
 	/*
 	 * First verify the first group got the file MODIFY event and got just
@@ -278,15 +286,17 @@ static void test_fanotify(unsigned int n)
 				"reading fanotify events failed");
 		}
 	}
+	event = (struct fanotify_event_metadata *)event_buf;
 	if (ret < tc->nevents * (int)FAN_EVENT_METADATA_LEN) {
-		tst_brk(TBROK,
+		tst_res(TFAIL,
 			"short read when reading fanotify events (%d < %d)",
 			ret, tc->nevents * (int)FAN_EVENT_METADATA_LEN);
 	}
-	event = (struct fanotify_event_metadata *)event_buf;
-	verify_event(0, event, FAN_MODIFY, tc->report_name ? fname : "");
-	event = FAN_EVENT_NEXT(event, ret);
-	if (tc->nevents > 1) {
+	if (FAN_EVENT_OK(event, ret)) {
+		verify_event(0, event, FAN_MODIFY, tc->report_name ? fname : "");
+		event = FAN_EVENT_NEXT(event, ret);
+	}
+	if (tc->nevents > 1 && FAN_EVENT_OK(event, ret)) {
 		verify_event(0, event, FAN_CLOSE_NOWRITE,
 			     tc->report_name ? (tc->ondir ? "." : tc->close_nowrite) : "");
 		event = FAN_EVENT_NEXT(event, ret);
@@ -296,11 +306,7 @@ static void test_fanotify(unsigned int n)
 			"first group got more than %d events (%d bytes)",
 			tc->nevents, ret);
 	}
-	/* Close all file descriptors of read events */
-	for (; FAN_EVENT_OK(event, ret); FAN_EVENT_NEXT(event, ret)) {
-		if (event->fd != FAN_NOFD)
-			SAFE_CLOSE(event->fd);
-	}
+	close_event_fds(event, ret);
 
 	/*
 	 * Then verify the rest of the groups did not get the MODIFY event and
@@ -318,15 +324,14 @@ static void test_fanotify(unsigned int n)
 			verify_event(i, event, expect, "");
 			event = FAN_EVENT_NEXT(event, ret);
 
-			for (; FAN_EVENT_OK(event, ret); FAN_EVENT_NEXT(event, ret)) {
-				if (event->fd != FAN_NOFD)
-					SAFE_CLOSE(event->fd);
-			}
+			close_event_fds(event, ret);
 			continue;
 		}
 
-		if (ret == 0)
-			tst_brk(TBROK, "zero length read from fanotify fd");
+		if (ret == 0) {
+			tst_res(TFAIL, "group %d zero length read from fanotify fd", i);
+			continue;
+		}
 
 		if (errno != EAGAIN) {
 			tst_brk(TBROK | TERRNO,
@@ -360,8 +365,8 @@ static void cleanup(void)
 
 	SAFE_CHDIR("../");
 
-	if (mount_created && tst_umount(MOUNT_NAME) < 0)
-		tst_brk(TBROK | TERRNO, "umount failed");
+	if (mount_created)
+		SAFE_UMOUNT(MOUNT_NAME);
 }
 
 static struct tst_test test = {
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
