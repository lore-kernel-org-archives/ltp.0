Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20F9C43458
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 16:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783958898; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=l4LT6AdprLgF+GJo2GmAC+ie4/VXlOR9LoNJEP0aEuQ=;
 b=YjyA55uiKFVAgG14PlxmiSllNaEC2vG069t53Ub14yNzSWc2kTwqkyYGSyhm+KjURsZ3x
 8R4nUBiczuhHRcSDAd1S740fe6wMJb2niDZaR992FLoWt6UdB6T7ZaXvDOnTzDIV4GpJbKc
 RApWWOaJvwIuiDi402gm7YmfKGqKy5I=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 33FFF3E969D
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 18:08:18 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4AFFC3CC91F
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 18:07:58 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 640331000612
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 18:07:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783958875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MDSqoZ6JBtOoWaEsHfWb6sx0IGphrK4V2tG6t/hyN+I=;
 b=Vfd+YRjiHL94/9K6niMyEl3bSoGbCkiu7zrmtW1WJbXRZUllHLztILsXKs+cX+TTyWPkY+
 XqXb4urv8/LihSqOxtV/qHtnZ/zGa9yUdcOqGw8jMgVvDGL7ilGT4Wxf/FZMUOn+6m8mbR
 X76R1+ltVnC75nez2tF2dnlk64dOwSs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-Vfe9l3tFMjW3ClIEO94IAw-1; Mon, 13 Jul 2026 12:07:54 -0400
X-MC-Unique: Vfe9l3tFMjW3ClIEO94IAw-1
X-Mimecast-MFC-AGG-ID: Vfe9l3tFMjW3ClIEO94IAw_1783958873
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92aea0d801dso5798785a.1
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 09:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783958873; x=1784563673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MDSqoZ6JBtOoWaEsHfWb6sx0IGphrK4V2tG6t/hyN+I=;
 b=m1FpcYsjH75jpqFVgTxLW2bd7hTfQ+3AbcGitnaB0SU8XMnLnSS42PjW/RqPisdv5d
 F/C17733qhaLx/5GR1komNzh1SEJywAVZpiJY1Nuo1fHfIgAOkZ5PixnfuTEgLoz92z0
 uoiTtY/3v6iCaKmaW5yBDHL2vvLp9RLBCr9VmOT5MIBQQhjdLNC7vIzFBtTYm9Xw7CD6
 HWjSYCThcnlzPZMqnI1r70dPJQOjh8L4d/tmx1wxQxNPdg7OTG+jJR4zomnn47A/Cqcu
 07xZubh7SWfzT/oZ4IT82Rvrs0PZYPBCASa9p12f0NpbPRZ7bNDVVVPoGn1wvCPJp3Jn
 6avQ==
X-Gm-Message-State: AOJu0YzGUJd9Dckj9cfUnlnQYFIyKIwUw1PnEAlqrIvBCDGcUajkPBin
 R68kaWmKD1oYmd4wrYZTzlcbAVhm/NNrxYUhUTLWwaWLIxK7D8icKg+wSxM630Tge1cJY2G5nQp
 1jXEAuMK+Vb0Ggg1YmwaykkrMEv7I8tgwOT+vNWCtPF/fBTzaFR8F0F737Rug4jNaXiLDiXBEIo
 RozoymZlitdoHpH5zL2Rc5ROr/IejYU2xXClz8
X-Gm-Gg: AfdE7cmDsgxtl3vgoh5nabPbKRyWcWoyXydDb4+KltfoI8eR3Re5uxQxS1utGGfwwPh
 AZhguzcjywd+62ycds2LOHyrE5fnPU+DETitvsgFv5hf5sRwMo+IHhR2wJXSk+55StbToP+0XlU
 uZKzvpTNAbqLhd9gXxWI0Nh+IyspJXzeSUWGBZgUAWUmBJvcuIfKrTfemCFNlaCFCr//bew1LL0
 famErAkKtr0TpbdniPd5K11phi8kdAxiT36YxXZ954wqF6Ux/on5nhlUgcPAS36VosReZgss4Vs
 hXpceC73t2shkKpS7OPcfLiIvWfQBF0RFqB4L7ruXAoHAJLt5gu6s1QkKauJzX91butPjk563lD
 15+lAnX/b1FveKkZ3bvJ8CWfY0+sNZ7XdEhPY
X-Received: by 2002:a05:620a:488c:b0:910:bb22:d426 with SMTP id
 af79cd13be357-92ef2b70b9emr1077580485a.33.1783958869086; 
 Mon, 13 Jul 2026 09:07:49 -0700 (PDT)
X-Received: by 2002:a05:620a:488c:b0:910:bb22:d426 with SMTP id
 af79cd13be357-92ef2b70b9emr1077565985a.33.1783958867782; 
 Mon, 13 Jul 2026 09:07:47 -0700 (PDT)
Received: from sbertram-thinkpadp1gen5.bos.com ([67.189.222.97])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92ee5cfdf6fsm1185142385a.24.2026.07.13.09.07.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 09:07:47 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 13 Jul 2026 12:07:20 -0400
Message-ID: <20260713160725.1158208-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710143155.588390-1-sbertram@redhat.com>
References: <20260710143155.588390-1-sbertram@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: N950flqkVHYwJeJgBGpVV9NcDZwlo5Y4Qm8PolY0n2w_1783958873
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] pipe13: Scale child reap window with
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

The failure before would happen, when using 4 paralell workers
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
