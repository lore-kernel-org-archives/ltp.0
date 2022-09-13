Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43FDC54EE9
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 20:29:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A1273CABE9
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 22:28:58 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2CADD3C94DB
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 22:28:48 +0200 (CEST)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com
 [IPv6:2607:f8b0:4864:20::549])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 732C61000954
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 22:28:48 +0200 (CEST)
Received: by mail-pg1-x549.google.com with SMTP id
 h5-20020a636c05000000b00429fa12cb65so6310375pgc.21
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 13:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date; bh=/wPJiMxThlF6nh0/KlglOdtzG0eIBw4hAcIWI097RXU=;
 b=YDqa92/UJ9uYyFkeD8Tj1+sMx/AV8/kWiU7DskzwG/EQNmT5ZdT/n1BG8jrdDLW7vQ
 tgzQOicKJ6yY6K4NYL+mu6+lIOO5xGOgR4hmbQJ341p14LP728ZqkVsV3O+y3QhujHSp
 0ddhtnVkR3q6BU7k4CpvZ4rYdtLHpNjN+6LqZS2O4uE+J6brHUPBWgPKOS9138a01db+
 Ayu7K8u6WDUW78N74Zt9ZXeYki56xId6l7gH+J0sk3So2uG8ei3YK1n342vS2ASsIvc7
 kSKLWM9h00oUnrAcZ3y2Vc5XBFpKlVIXLJvXNylLaHpS2M6j4BCOxAjK1Hcf9gugb/13
 B8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date;
 bh=/wPJiMxThlF6nh0/KlglOdtzG0eIBw4hAcIWI097RXU=;
 b=6hN1yz1zF8NcjtEfgG2qSOprnvZtq4kuO8tqbKKX304AoW9YCvIOT0thErnAfjakd0
 T0mQVQoEi0nDrmhwxXZK0WnD2EJ5rLTBih50Eh4hWD4WvtuOkLQlcSiMPIgbhcd9tcWr
 n2q0hej7njwnbYmFbDwYbDgDjaz5w5rA9lur3ZFaGt8Jn0uDG1HWScCtgDOiazLm8qNL
 FcmQedwM+jfcwgdDCRJz0FId9B0a3Im8T6zp1BUY5qIPMEz+UfSVb3OCL7tG6sptvkda
 POmpSAIpdyerfGqueGJQ40VUDK9gM+p7XlN6IJ5v79YUImoFDvymsNkoOAWyCtEuzaFn
 AhyQ==
X-Gm-Message-State: ACgBeo380Mv+FQu6waJ1EdidJrmpiNo+KeRXLma4v73tVhgJ95jMNDYX
 r+XsGQVzZPpUNW+BLQMebfq8WOMKoEOLykzTMhTrn85kqwnz6C4cos9Kv3WlDBnIdr0q0zRCnQe
 XZn4CyBQw9AiYQef7lEdOKL0rw3x7fvqDGoCcoq0Gttyp6ifff2l/tbhw
X-Google-Smtp-Source: AA6agR4C4OPI9EZrDEKT0/9hBvIYeh+qDFXTb45awRSIyFzumAKP8cIthGnRsf5O0EgsQ6EoCnzSN0eCD1A=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:168e:b0:53b:3f2c:3213 with SMTP id
 k14-20020a056a00168e00b0053b3f2c3213mr34295521pfc.56.1663100926409; Tue, 13
 Sep 2022 13:28:46 -0700 (PDT)
Date: Tue, 13 Sep 2022 20:28:39 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220913202839.1807979-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] minmax: fix type warnings
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

Several min/max comparisons are missing type conversions.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 lib/tst_memutils.c                               | 2 +-
 testcases/kernel/mem/mmapstress/mmapstress01.c   | 2 +-
 testcases/kernel/mem/mmapstress/mmapstress10.c   | 2 +-
 testcases/kernel/mem/tunable/overcommit_memory.c | 6 +++---
 testcases/kernel/syscalls/mprotect/mprotect02.c  | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
index 0d20bb17c..c6696437d 100644
--- a/lib/tst_memutils.c
+++ b/lib/tst_memutils.c
@@ -31,7 +31,7 @@ void tst_pollute_memory(size_t maxsize, int fillchar)
 
 	SAFE_SYSINFO(&info);
 	safety = MAX(4096 * SAFE_SYSCONF(_SC_PAGESIZE), 128L * 1024 * 1024);
-	safety = MAX(safety, min_free);
+	safety = MAX(safety, (size_t)min_free);
 	safety /= info.mem_unit;
 
 	if (info.freeswap > safety)
diff --git a/testcases/kernel/mem/mmapstress/mmapstress01.c b/testcases/kernel/mem/mmapstress/mmapstress01.c
index c16b50a6d..f425c223d 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress01.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress01.c
@@ -310,7 +310,7 @@ int main(int argc, char *argv[])
 		anyfail();
 	}
 	for (bytes_left = filesize; bytes_left; bytes_left -= c) {
-		write_cnt = MIN(pagesize, bytes_left);
+		write_cnt = MIN(pagesize, (int)bytes_left);
 		if ((c = write(fd, buf, write_cnt)) != write_cnt) {
 			if (c == -1) {
 				perror("write error");
diff --git a/testcases/kernel/mem/mmapstress/mmapstress10.c b/testcases/kernel/mem/mmapstress/mmapstress10.c
index 28b4f1e91..53f02c1f6 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress10.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress10.c
@@ -360,7 +360,7 @@ int main(int argc, char *argv[])
 	}
 
 	for (bytes_left = filesize; bytes_left; bytes_left -= c) {
-		write_cnt = MIN(pagesize, bytes_left);
+		write_cnt = MIN(pagesize, (int)bytes_left);
 		if ((c = write(fd, (char *)buf, write_cnt)) != write_cnt) {
 			if (c == -1) {
 				perror("write error");
diff --git a/testcases/kernel/mem/tunable/overcommit_memory.c b/testcases/kernel/mem/tunable/overcommit_memory.c
index 20151ebb0..7fe8fe14c 100644
--- a/testcases/kernel/mem/tunable/overcommit_memory.c
+++ b/testcases/kernel/mem/tunable/overcommit_memory.c
@@ -248,9 +248,9 @@ static void calculate_total_batch_size(void)
 	SAFE_SYSINFO(&info);
 
 	/* see linux source mm/mm_init.c mm_compute_batch() (This is in pages) */
-	long batch_size = MAX(ncpus * 2,
-	                      MAX(32,
-	                          MIN(INT32_MAX,
+	long batch_size = MAX(ncpus * 2L,
+	                      MAX(32L,
+	                          MIN((long)INT32_MAX,
 	                              (long)(info.totalram / pagesize) / ncpus / 256
 	                          )
 	                      )
diff --git a/testcases/kernel/syscalls/mprotect/mprotect02.c b/testcases/kernel/syscalls/mprotect/mprotect02.c
index de9b4ea00..da445d442 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect02.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect02.c
@@ -77,7 +77,7 @@ int main(int ac, char **av)
 
 		do {
 
-			bytes_to_write = MIN(strlen(buf), num_bytes);
+			bytes_to_write = MIN((unsigned int)strlen(buf), num_bytes);
 
 			num_bytes -=
 			    SAFE_WRITE(cleanup, 1, fd, buf, bytes_to_write);
-- 
2.37.2.789.g6183377224-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
