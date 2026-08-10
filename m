Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F181C5AE5D
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 04:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786335482; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=V7sXBz7Fj7FpDO5ARuSeZaSaovyTnvJnH2CqigWL49U=;
 b=U2yGXKKBnUqZ5mps2qzGkjqK0YkfyEi3Yo1wNJkUWP+66oRmfRJSr3lWX0rmoTP4hxjKA
 zOsDZEsN1eRunnEweUdVAYCALbI1ARAAdU0xg4uFbF1YHE5iip86Bu1i85nLWJDe4ZeLkbV
 48c4pBPBHb0otZnWyHy/7hnkUjL2usQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5AD1D3CB53A
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 06:18:02 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA5223CB2DE
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 06:17:42 +0200 (CEST)
Received: from mail-pj1-x1045.google.com (mail-pj1-x1045.google.com
 [IPv6:2607:f8b0:4864:20::1045])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2E82A140005A
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 06:17:42 +0200 (CEST)
Received: by mail-pj1-x1045.google.com with SMTP id
 98e67ed59e1d1-38e475f83a2so2579416a91.1
 for <ltp@lists.linux.it>; Sun, 09 Aug 2026 21:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786335460; x=1786940260; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jHEtr/XcorZvhMaHmZRmSvGcW+rEgHaR3rSUkWztmnM=;
 b=qct0rr2KmWtKP5GrJGB1NTbxtIdFaS6yzj1pDv9Q8qppIWjJFidyRqof8XsY+og3xR
 RzrHXO07k4A+Mi64o14jbQDrHTea9Il0KwWN3mpgROxMN9u3epc8O9R0Wc33Olc0i09E
 V6I0Vy0dW2IVPfcgQxWbi/PHqYS9DiYLB2jQTuHcOzDuSLPu2Na03g69OMPbxIII+ojA
 UJ9I1J4FLh5w/3vQUvkHN0igyYfGTn6eXb5UrU6OmFJ8/wj1Osc0B8XsFUhswXZh7mbL
 ROYgu0Tlf45Dr5iczDVGhuYtu4r608EkGuqpmlRjlQ9Q4DUA1aUYvs4ScnTsM9YHp/M1
 RfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786335460; x=1786940260;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jHEtr/XcorZvhMaHmZRmSvGcW+rEgHaR3rSUkWztmnM=;
 b=qIPORpBoqrZT6yCDskvWARAJfxxGjzaoQ4ucllSsqbOTp0p2MkCCyX0k47zQcPfRn2
 cZVC22RrhNLm7Fxfj4KhMIb3Pm/fVFA7c6Jk6AglTGpVCSBp2rCd3gDPtyKKJPk31O96
 wWBdwT3EAQy7Wsc4c2IW+eKq9ceGBtVrfvPCAwhfjFS+s720b9l3MsA4VkT2JS/2U9ml
 I9WzsXftysETgrSu7VbTPEr8iAMV6YWelQ4evWs59+DTSmfqYUTHnD8tDRziJqyUrcl2
 BN4Ky0bNE7h3WeHJ9f3db8mzDderLO3bFLhWe5pY8iVmncsYgQfDlwOknEmN2CtKztYZ
 kqzA==
X-Gm-Message-State: AOJu0YzO6QYc5xEyeeaXRZViuDSPDpISqal4ZtVf5SJvT5jGz07Bgth1
 sOkQd+zlTiMc242CTeTFmgUz7ULiaAvPCrodZ2MTtZy6Vg6bYgTLctjL6RsyiwiDFt2GYvn+gEu
 Fu6hXoFlmt5o1PSWGPTZCNX86M8N3qknBWaOY+jeBLLVzj1/KahQBvdbMe+ffHz5LIAfrWJd4Wt
 /X7LV1WZwOAyKGCpbrqgFGZzWW6g==
X-Received: from pjbqb1.prod.google.com ([2002:a17:90b:2801:b0:38e:4ba3:1d9d])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:41:b0:37f:ed7e:7e42
 with SMTP id 98e67ed59e1d1-3903c5bd850mr41330702a91.14.1786335460347; Sun, 09
 Aug 2026 21:17:40 -0700 (PDT)
Date: Mon, 10 Aug 2026 04:17:38 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260810041738.1714971-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] controllers/cpuacct: Dynamically adjust cpuacct_task
 execution time
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
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: Wake Liu <wakel@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The test helper cpuacct_task currently runs for 10ms (virtual time)
before exiting. On some systems (e.g. fast virtual machines or under
heavy load), this short duration can lead to 0 usage being recorded in
cpuacct.usage cgroup file due to timing resolution or scheduling delay,
especially when running small configurations like cpuacct_1_1.

However, unconditionally increasing the duration for all runs (e.g. to
100ms) would cause large stress tests like cpuacct_100_100 (which runs
10,000 tasks) to timeout on systems with few CPUs.

Resolve this by:
1. Modifying cpuacct_task to accept an optional duration argument.
2. Modifying cpuacct.sh to calculate the duration dynamically based on
   nbprocess, ensuring each subgroup gets at least 100ms of aggregate
   CPU time, while clamping the per-process duration to a minimum of
   10ms to avoid timeouts in large stress tests.

Signed-off-by: Wake Liu <wakel@google.com>
---
 .../kernel/controllers/cpuacct/cpuacct.sh     |  7 ++++++-
 .../kernel/controllers/cpuacct/cpuacct_task.c | 20 ++++++++++++++++---
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/controllers/cpuacct/cpuacct.sh b/testcases/kernel/controllers/cpuacct/cpuacct.sh
index 97a395cd5..efabe6cab 100755
--- a/testcases/kernel/controllers/cpuacct/cpuacct.sh
+++ b/testcases/kernel/controllers/cpuacct/cpuacct.sh
@@ -139,10 +139,15 @@ do_test()
 {
 	tst_res TINFO "Creating $max subgroups each with $nbprocess processes"
 
+	local duration=$((100000 / nbprocess))
+	if [ $duration -lt 10000 ]; then
+		duration=10000
+	fi
+
 	# create and attach process to subgroups
 	for i in `seq 1 $max`; do
 		for j in `seq 1 $nbprocess`; do
-			cpuacct_task $testpath/subgroup_$i/tasks &
+			cpuacct_task $testpath/subgroup_$i/tasks $duration &
 			echo $! >> task_pids
 		done
 	done
diff --git a/testcases/kernel/controllers/cpuacct/cpuacct_task.c b/testcases/kernel/controllers/cpuacct/cpuacct_task.c
index 677d6d401..caeecf064 100644
--- a/testcases/kernel/controllers/cpuacct/cpuacct_task.c
+++ b/testcases/kernel/controllers/cpuacct/cpuacct_task.c
@@ -38,12 +38,21 @@ int main(int argc, char **argv)
 {
 	FILE *f;
 	struct sigaction sa;
+	int duration_us = 10000;
 
-	if (argc != 2) {
-		fprintf(stderr, "Usage: %s /cgroup/.../tasks\n", argv[0]);
+	if (argc < 2 || argc > 3) {
+		fprintf(stderr, "Usage: %s /cgroup/.../tasks [duration_us]\n", argv[0]);
 		return 1;
 	}
 
+	if (argc == 3) {
+		duration_us = atoi(argv[2]);
+		if (duration_us <= 0) {
+			fprintf(stderr, "Invalid duration: %s\n", argv[2]);
+			return 1;
+		}
+	}
+
 	f = fopen(argv[1], "a");
 	if (!f) {
 		perror("fopen failed");
@@ -62,7 +71,12 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
-	struct itimerval it = {.it_value = {.tv_sec = 0, .tv_usec = 10000}};
+	struct itimerval it = {
+		.it_value = {
+			.tv_sec = duration_us / 1000000,
+			.tv_usec = duration_us % 1000000
+		}
+	};
 
 	setitimer(ITIMER_VIRTUAL, &it, NULL);
 	for (;;);
-- 
2.55.0.654.g21b8a5bc05-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
