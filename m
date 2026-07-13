Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26058C43458
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 17:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783962122; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=0p5BlpniPliXixThefbOigV6/x9J+SBVduCl+KJG6iE=;
 b=eu8+J2p1htWf3RiE8y98lPqj3AweD1Pk6abFKO1U9FPjz/MaA6vZ/wjxhR7sXUVEAJnTs
 3lQn58v/iiid/XSCdq+QTEkmrEQos2k6NGAHlun7CaRvsG2dNuXHgbo25yOCc0360Ukok65
 d5xTiRh2FYxtElPFTmy5T3HPkosaUyM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 959873E969A
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 19:02:02 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C44AC3E22C2
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 19:01:43 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BF302200043
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 19:01:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783962100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jywFCJq1bJnHyjwgWhFQv0+CM9K7H3yv1ojzjD06594=;
 b=E4lOeWLLq5KUYz/8JuKnaS6re0rzZLfpgkmAN1nyL+fKhgCFexLMOoRCpeC8B0l9CI1W8V
 hAToP0aywlrX+L4cILKPBXWHbIozxl+BRrOGLAN/MM0Hxdckk+aPUvnvNBlbxmDK2v5N3u
 HuVT2OXtVD5JcJ68wShOb0zpk0kt+CY=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-lRz8WF3hO4mIWGYsU5To5A-1; Mon, 13 Jul 2026 13:01:39 -0400
X-MC-Unique: lRz8WF3hO4mIWGYsU5To5A-1
X-Mimecast-MFC-AGG-ID: lRz8WF3hO4mIWGYsU5To5A_1783962099
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-81e6bb29581so120384037b3.2
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 10:01:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783962099; x=1784566899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jywFCJq1bJnHyjwgWhFQv0+CM9K7H3yv1ojzjD06594=;
 b=MwTX/PoR+vzGBr5WwV/UrsLRIxWgw+IZ9s39edhry308xF7c4srRg06AbohsKfDqa+
 y55GqFqpoCQtNphI/Ri5dNdfOoy0BGvWuk/iFtflDF2FuLk9PcVib56NPSEHuqtNTHBm
 QvrzHUAm0dyF9Qqq82uTjqYVaSuLWZfsaNlxRpjIU73hCpImC1Y7OM3w4CE4wEROwOD3
 vxyc+XOVIGXrKq4Tnmj02IPk22lwgsvjWlClN7WsGG7oHVWm0BPizPMueK7SG70s3O5l
 4LvXDWyxHitj5hlv3VB7jrp+DoYsmwe9UXOKRcx1yZ/3LUiBiaf2dBsuCcfWpSuODwJZ
 UEvw==
X-Gm-Message-State: AOJu0Yw0lVeuUTS99/sZHOQ6gr4kxXXhkMeyuQbqLsSvxnUx27PLdgzq
 azatAZjQn2MiR48w9SHtaWIhG5Dlogn7hZHnfwDIx8L2WmOQuV7UIe1zkRvdO0BjahvfyKRoHS2
 mcK6X3BC8OiLovNUt9AZsyAepdIiUi7/OGvt1d58yRoTabCLRaNPZA6xpKoFEJx6qoX7F1IG5sT
 Wv9Isw1PdUTlOstu6dOEEPIBBQkcOiNFd9dNDo
X-Gm-Gg: AfdE7cmCBjPE9ZYiz3Y2YUNURqp2qj/wO7dKdNUzqXy9vwDj9IfUp7kCpsOfQ/5j06O
 0hiB0yEMZPIlhgFpd8mdnHvH6ALWSUALMeRomKas1HfENRTTo/2X9IjqTZI44WoH16PhHGRClTq
 giG2JTOQkai+MVsT7A1KAs1ABl4Pb8JKrWbVFGOxsC8VVNjEtGsCBZfzh4ck4V7vX0j8LIUG5LY
 Ff1eXOJuMaS7+MGaDVFnDcAEcpaOThTzpaHYuikEwpdgvP5KoN49g1TkTq48bpn71tlrXLZYA4y
 Rsg16jZYEjgWwcqEIJY8jtCYeiZVvsAK1ImGHUIMjLo4xAWh9jq1iYEQIXD6IfY0yb4YsoZGCyq
 v7BD9HQgviPLJ9PS3ampE5HJh+9QF1OV3ZqO0
X-Received: by 2002:a05:690c:710a:b0:81c:eca8:b31f with SMTP id
 00721157ae682-81e9013e27amr69944017b3.39.1783962098726; 
 Mon, 13 Jul 2026 10:01:38 -0700 (PDT)
X-Received: by 2002:a05:690c:710a:b0:81c:eca8:b31f with SMTP id
 00721157ae682-81e9013e27amr69942407b3.39.1783962096984; 
 Mon, 13 Jul 2026 10:01:36 -0700 (PDT)
Received: from sbertram-thinkpadp1gen5.bos.com ([67.189.222.97])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92ee5d61facsm1124033285a.42.2026.07.13.10.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 10:01:36 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 13 Jul 2026 13:01:28 -0400
Message-ID: <20260713170129.1177772-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710143155.588390-1-sbertram@redhat.com>
References: <20260710143155.588390-1-sbertram@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AziDR-yATn1vonqIgP5cR2lfH_lmwgVCYp1_vg2Rwyg_1783962099
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] pipe13: Scale child reap window with
 LTP_TIMEOUT_MUL
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
From: Stephen Bertram via ltp <ltp@lists.linux.it>
Reply-To: Stephen Bertram <sbertram@redhat.com>
Cc: Stephen Bertram <sbertram@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The post-close wait used a fixed 1000000 us cap on exponential backoff.
Scale that cap with tst_multiply_timeout() so debug
kernels and LTP_TIMEOUT_MUL apply, fixing failures under parallel
Kirk workers without changing default behavior on non-debug systems.

Before (only with case 100):

pipe13.c:50: TINFO: Creating 100 child processes
pipe13.c:81: TINFO: pid 435007 still sleeps
...
pipe13.c:81: TINFO: pid 435300 still sleeps
pipe13.c:89: TFAIL: Closed pipe didn't wake up everyone
The list varied but sometimes up to 20 would remained asleep.

Test is passing after using TST_RETRY_FN_EXP_BACKOFF() so timeout
scaling follows the standard LTP path (tst_multiply_timeout, debug
kconfig, LTP_TIMEOUT_MUL).

The failure before would happen, when using 4 parallel workers
on a debug kernel, about 1 to 2 times when iterated 5 times.
Tested on aarch64 debug+PREEMPT_RT: kirk -w 4 pipe13 -i 100, 400 runs,
0 fail.

Signed-off-by: Stephen Bertram <sbertram@redhat.com>
---
 testcases/kernel/syscalls/pipe/pipe13.c | 44 +++++++++++++++----------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/syscalls/pipe/pipe13.c b/testcases/kernel/syscalls/pipe/pipe13.c
index 5d76e1f00..7f7685a2c 100644
--- a/testcases/kernel/syscalls/pipe/pipe13.c
+++ b/testcases/kernel/syscalls/pipe/pipe13.c
@@ -26,6 +26,28 @@ static unsigned int tcases[] = {
 };
 
 static int fds[2];
+static unsigned int reap_child_num;
+static unsigned int reap_count;
+static int *reap_pids;
+
+static int reap_children_once(void)
+{
+	unsigned int i;
+	int ret;
+
+	while ((ret = waitpid(-1, NULL, WNOHANG)) > 0) {
+		reap_count++;
+		for (i = 0; i < reap_child_num; i++) {
+			if (reap_pids[i] == ret)
+				reap_pids[i] = 0;
+		}
+	}
+	if (ret < 0 && errno != ECHILD)
+		tst_brk(TBROK | TERRNO, "waitpid()");
+	return reap_count;
+}
+
+#define ALL_CHILDREN_REAPED(cnt) ((unsigned int)(cnt) >= reap_child_num)
 
 static void do_child(unsigned int i)
 {
@@ -41,8 +63,7 @@ static void do_child(unsigned int i)
 
 static void verify_pipe(unsigned int n)
 {
-	int ret;
-	unsigned int i, cnt = 0, sleep_us = 1, fail = 0;
+	unsigned int i, fail = 0;
 	unsigned int child_num = tcases[n];
 	int pid[child_num];
 
@@ -60,21 +81,10 @@ static void verify_pipe(unsigned int n)
 	SAFE_CLOSE(fds[0]);
 	SAFE_CLOSE(fds[1]);
 
-	while (cnt < child_num && sleep_us < 1000000) {
-		ret = waitpid(-1, NULL, WNOHANG);
-		if (ret < 0)
-			tst_brk(TBROK | TERRNO, "waitpid()");
-		if (ret > 0) {
-			cnt++;
-			for (i = 0; i < child_num; i++) {
-				if (pid[i] == ret)
-					pid[i] = 0;
-			}
-			continue;
-		}
-		usleep(sleep_us);
-		sleep_us *= 2;
-	}
+	reap_child_num = child_num;
+	reap_count = 0;
+	reap_pids = pid;
+	TST_RETRY_FN_EXP_BACKOFF(reap_children_once(), ALL_CHILDREN_REAPED, 1);
 
 	for (i = 0; i < child_num; i++) {
 		if (pid[i]) {
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
