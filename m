Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419FBC5AC82
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 08:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786350634; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=/y6snLaqrzv1CUC3n2/YWh0BJ6kYM0F7gC7GcB9b8UY=;
 b=mmvx25sv/8ktbCx0g1FOsKzSjUuCyWWFAYUEplSevLJ8oTuMHTFW66zkeG1EFhj2skYF9
 bkTJw+Va3zBGPdXp7okIb5gToajB/ijvs07Jg3VMJZQUVqklBWqXCXVHLpQAMT9nXF8yrUY
 GZguXJkzDrpMUAHuvU33ZfelUvF3z8M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 606E73CE2BE
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 10:30:34 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 196363CD5FB
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 10:30:13 +0200 (CEST)
Received: from mail-pf1-x445.google.com (mail-pf1-x445.google.com
 [IPv6:2607:f8b0:4864:20::445])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 75D2E1400178
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 10:30:13 +0200 (CEST)
Received: by mail-pf1-x445.google.com with SMTP id
 d2e1a72fcca58-84e375d9736so2304737b3a.2
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 01:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786350612; x=1786955412; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wJQWDfMHmvETtN5XPJWE7wG1FSbO+rJ73edFskNtooE=;
 b=t62wdgEfDFy+62b/sSqRLm9sJR8Y6eTfQ2R/xgI/bJHVVz9lDuxtT85YwVUG5XQM/c
 w5NoUTAUWgXRHTkb/PaPFhsC2VenR1ijUP52IfV72iTs7f90PFafROAl0a7j92RuWDPX
 2YpAhNKXuxBtTHQ/JysKYU4l27341jSfNuwaP2hjAyFBcZYvzU3uotulmL4nDUzcSF0m
 MDBIHDJRL4UK5KxvQ7X95sMMyE35xbRoo6fDL1OH4XWyB+CtEL9GFn01+Bl5Q2LL+x0h
 cEwhD67lef1m0jpWlyElejBJjUEwQoYYxI5qe239Im3UoThmmGKzmvVHQpbS7JSxsYcJ
 5QEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786350612; x=1786955412;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wJQWDfMHmvETtN5XPJWE7wG1FSbO+rJ73edFskNtooE=;
 b=qolnosyNFnbfi1dPc46k3okojxXDPp13y+cjzLhGJ4pLef3dQjXuqNsJzUunk6gYXG
 qfpS4bNtKuOrxqPx+qCRm2IwmELL+GtBSzA3f+9CPRvYWhZ/DBd0KT0OTa03fxi8RXNp
 OBdBz2GWaj5SVDl189nIeKYPlhBe97QFuqy4QKfma575zdFnz/b6ZBmzl8/15cDOtjk+
 SMKNbBt7NZNNOsNLM3XC/BVWPrQwDcPFsFWdTj84I9mvH84GCabkOxGLZrfIPSxwV2vY
 tte3avRi6+gOnMOZcz7zqDLCX2ov9ZSSdJSrkl6tVsdNwKcpBmLrRx1pwDJ36tQY3vfa
 QZZw==
X-Gm-Message-State: AOJu0YyQMa+WEbZTRF6nsOQXKP9cbjV2aWwP3OJv/MDts5iJgVFjcich
 ax4D8Fxec7Kpb7QtEJe+jQEeTt9oVPFhlk7Byxtn6kRKc4sbv0p0yjku7pFFiu2rD9gaagU/jom
 rCHMmKoq3tqthczlOxbCQMfb1QWeMqKDD4GhMKC2/b2SyN2nj6iSoO9aNW6W/rqHkQFwZMW5b0s
 0Ut8snqyXYtJ2C+eq37gevI30WeA==
X-Received: from pfbil10.prod.google.com ([2002:a05:6a00:8d4a:b0:84b:9a60:c9])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:bd0e:b0:847:8b0f:2508
 with SMTP id d2e1a72fcca58-84f2dfc8c37mr48255821b3a.13.1786350611377; Mon, 10
 Aug 2026 01:30:11 -0700 (PDT)
Date: Mon, 10 Aug 2026 08:30:09 +0000
In-Reply-To: <20260810041738.1714971-1-wakel@google.com>
Mime-Version: 1.0
References: <20260810041738.1714971-1-wakel@google.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260810083009.1846957-1-wakel@google.com>
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
2.55.0.654.g21b8a5bc05-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
