Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA81C5B56A
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 07:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786520678; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=wsrsbytDYfIjgNLVT2cL8w7az4JIexbf6qD2urgA5R0=;
 b=hJW01BJPD2sldh4Vax9hqUBOBFaqawhh7h/AnJXSYic5jN8EAXIwdX7NKUeJ/hL3bcigF
 gLC79q+Hi5GxLnDkutVPfyWhebJTPCPeJXy2H6ev5qhsIMFJnUoLWD31UOuSVn+PjfEy0vB
 un0I43/hESdKJEVSGYG5bx9feSNebnc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 54F8F3E27F4
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 09:44:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 20DE73CA2F1
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 09:44:17 +0200 (CEST)
Received: from mail-pl1-x646.google.com (mail-pl1-x646.google.com
 [IPv6:2607:f8b0:4864:20::646])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 38FB81A00649
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 09:44:17 +0200 (CEST)
Received: by mail-pl1-x646.google.com with SMTP id
 d9443c01a7336-2cc5faecf01so16263045ad.1
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 00:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786520655; x=1787125455; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Kgw6GfZfCb5Y+kUOKbRAnKR4y8EZJMO+Y5UccxrE4go=;
 b=fHdOLQ8eMLmzoSMEY9qod0QJfYwE2/3irKE9T3E0dtYRhYfy4tVC45EjEYBRkWv+Cv
 XQw6Suisz413VjenWEvpSt1kR/bn2r/nGCjqI2u+B8SOb2UD++FsYKXlpgjcvLb2Vt3h
 qsaxpJSjMFv+epeGRS5DoVkFePb64jnKIC5kGp6wh5g2aNFpzl6eDJTvdsc0uB8qaoKJ
 ZzxIC7yZjnbH978pncforFWlCuxEaSE0+OdS+VSEhwIxKUFyFYKRbOTGubf9AYFndkGG
 sCAXgZNtLjNd4cBz37JCEXLLK8GpTVOg+5l63d5algHK+tWMrROCghcUeyWclLVS5CSF
 7GIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786520655; x=1787125455;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Kgw6GfZfCb5Y+kUOKbRAnKR4y8EZJMO+Y5UccxrE4go=;
 b=ooLA3UPBkB4f0TA5PB25naxCgPYKPCHxmox+6nmhjUEDTHBpHnJM1KqEz3J8GqjuKs
 uLKUXTm8ysOmuU4ht1TWKnsBqJWj8PqJrkazQXXKLZhL6NZB+HyNmpOkgLt/tJZJgkoW
 9KLOwLDu2UYEtNuKZkFO0uQjs7hw7FwVVBBw6N13RudnGg2ICKI3h4KIiKuG/838vy+k
 X6IFJzt60RvSE5q3Mb+Zoff/YWejnB1Yi0MYZZlUrOmP+aiBd2gtMngEvHc6AE2Mmzfv
 Xjob1TbLnvJ6qB8/AuRA8KVFiO78cGcamnN3C+tjUVzGq9S6gamV7ZTM711pVWfyZE0K
 jeDg==
X-Gm-Message-State: AOJu0YxgCSwbS4R3k7NNBp9vXIWtHnakfD2Pq/oE6P5zZljZ8+MRLwcl
 1Rkcg1HQwKmzFSlf9hfnEyqCYoaSRbY5+Le2SQusnaZFfCAHzebHmb8rep+FsMahvgI1lzLA6mx
 ZVD5CI03R5BpBhXpIL+w4QP+oNFM6hAYYbqd9ViGUXZlCdpEMjd9yEUd25dbCxysCy94f5z7pZE
 k4qeRsNO9d8Xl5VmbTvZQZIsDLVg==
X-Received: from plog8.prod.google.com ([2002:a17:902:8688:b0:2cc:70c2:9d27])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ce01:b0:2c7:f4bd:91b5
 with SMTP id d9443c01a7336-2d345028a8amr43768545ad.0.1786520655078; Wed, 12
 Aug 2026 00:44:15 -0700 (PDT)
Date: Wed, 12 Aug 2026 07:44:13 +0000
In-Reply-To: <6a7af65a.24f60c78.2beb43.4fda@mx.google.com>
Mime-Version: 1.0
References: <6a7af65a.24f60c78.2beb43.4fda@mx.google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812074413.3159992-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] controllers/cpuacct: Dynamically adjust
 cpuacct_task execution time
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
3. Validating nsubgroup and nprocess arguments in cpuacct.sh setup() to
   ensure they are positive integers, avoiding division by zero or fatal
   arithmetic errors in shell.

Signed-off-by: Wake Liu <wakel@google.com>
---
 .../kernel/controllers/cpuacct/cpuacct.sh     | 17 +++++++++++++++-
 .../kernel/controllers/cpuacct/cpuacct_task.c | 20 ++++++++++++++++---
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/controllers/cpuacct/cpuacct.sh b/testcases/kernel/controllers/cpuacct/cpuacct.sh
index 97a395cd5..deb103a30 100755
--- a/testcases/kernel/controllers/cpuacct/cpuacct.sh
+++ b/testcases/kernel/controllers/cpuacct/cpuacct.sh
@@ -84,6 +84,16 @@ check_limits()
 
 setup()
 {
+	case "$max" in
+		""|*[!0-9]*) tst_brk TBROK "nsubgroup must be a positive integer" ;;
+		*) [ "$max" -gt 0 ] || tst_brk TBROK "nsubgroup must be a positive integer" ;;
+	esac
+
+	case "$nbprocess" in
+		""|*[!0-9]*) tst_brk TBROK "nprocess must be a positive integer" ;;
+		*) [ "$nbprocess" -gt 0 ] || tst_brk TBROK "nprocess must be a positive integer" ;;
+	esac
+
 	if ! grep -q -w cpuacct /proc/cgroups; then
 		tst_brk TCONF "cpuacct not supported on this system"
 	fi
@@ -139,10 +149,15 @@ do_test()
 {
 	tst_res TINFO "Creating $max subgroups each with $nbprocess processes"
 
+	local duration=$((100000 / nbprocess))
+	if [ "$duration" -lt 10000 ]; then
+		duration=10000
+	fi
+
 	# create and attach process to subgroups
 	for i in `seq 1 $max`; do
 		for j in `seq 1 $nbprocess`; do
-			cpuacct_task $testpath/subgroup_$i/tasks &
+			cpuacct_task "$testpath/subgroup_$i/tasks" "$duration" &
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
2.55.0.691.gc56d675ccc-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
