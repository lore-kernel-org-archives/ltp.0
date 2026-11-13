Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C49D606A31C
	for <ltp@archiver.kernel.org>; Fri, 13 Nov 2026 04:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=fRXsY9WZ;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=O4+iGGqF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794543196; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=KBrKOha3SoO1WEucF4Iz+qeKjSAwhtKy1w2dSXuk6Og=;
 b=fRXsY9WZKO8Yn9vE5nziRpdHm/YFXpuYO3UplqcBErEshV9BtfWPg9ZM/qmRWFcjhVvG4
 R4x1ydfkOMy/0MmQhISIEq5HsLmAH5p35Y+D5V5R++Zcw1LDscnoYcEAfhUqzYa441OjMlA
 Yi+yAT+6R2CEMc7Kjxqm08TeI/rfUmw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0DB33EBC66
	for <ltp@archiver.kernel.org>; Fri, 13 Nov 2026 05:13:16 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 642FE3EB52A
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 05:11:50 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 784961A0064E
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 05:11:44 +0100 (CET)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a60f9474c4so8160945e9.0
 for <ltp@lists.linux.it>; Thu, 12 Nov 2026 20:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1794543104; x=1795147904; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C0FxmcselojaFFSsSvWVqydtZlXinplP2VyH4V/dKkA=;
 b=O4+iGGqFCKqO54PQGjIV4I0Lt8xlOQt7YETMwBDo7Z9/EyhEFdOcjZp3GzsA+TGaBS
 5qWyzLnIyqqWpe286zzTNy43fgnXxnrGbErt1kaSyNL5o146cp8aAUq+lES/2McG4eTR
 crtjziubxfNYt65YWAMmAzTY7BmZQvuO0i0uW8y5IH7mnX07Zb9FbJotCG3t9nNoSLx/
 WvkFzFc1vwDs3hKvmHCGr3Oc1ie1BF6ZntHfgmfTuywmM50YsDQVIuO2ZmVVUJ43++QU
 SsCbNVcSz3nQnCdT2zQtP+I76EOtdAN58QpHjVcUWzMg5D2OVf9V64G7dOUN88uYcmRn
 TCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794543104; x=1795147904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=C0FxmcselojaFFSsSvWVqydtZlXinplP2VyH4V/dKkA=;
 b=DyEwl5YBAv5r/r/EW4GNAgtn3pJf9c19Jsy1Hf9oVzfgJpPaGTDUrzXljFj76kx/b8
 SLQno6DdTupYpHcT7PlLyfcaQ2J7Qard0cC0WPL+RcZpRUaAn5OIL6Gqbf4zywgV/vsx
 mxlA5x4d0ZbPmUK3c5HmCljjkfbkKr0P/uR8DE2HPcD4lbBzbMk9GP911aJnd8aY9B+C
 Zk01zixMFu6EHQf4us3H7ubLqyElq/q3mo40O56wYXfHJqZ0XxTIM4X9IHdJUeYZ5QIC
 L/lUR11NGlZL65vXTc8Kamz+L2gZBO8Us3l15vlv8dtHnmKXDRmSnFHUflItUeQWq16R
 +hLw==
X-Gm-Message-State: APuU4Z8VoEvFRqssCP0SGjdinQ0FSKHi6zipEXCgJIiftUJ+1QdSojy/
 FT13suO/TsCFx1jmuhv3Ch1j8Ly5/EImuzABcnw70AdlpS6pvmhR/iP7i4NA+dwTfV1Zv0cOS97
 qpA8Bzg==
X-Gm-Gg: AYBFou2OK/VbgSjarltHxAF/L7rZGa64DqQqSChQKJP00Xa83rtAMg6FT0jYqLDP3x8
 yA3HRv4C0r8gUVWJ5ILK2c8zFvL6QukPNhIqK8qrEsP1ehyzSr8Z9NHCSFX3apIese6HaowUM+v
 DdhLjHI20QA/hGCtdJQusuFw4rCzHpt9H3TZ/vvRQhXq9sa1WBuxEIc8XZbZ+P1qLXU4Cx1itFu
 xdt0ZBnrafgBr+Ni5T7bqxUlznw5M9jsqYMOyqIVxHWEtcnk2ZY5VnecNM3ktcKlR1TLJZRBMaT
 50mmgZM11SiRq3vjcJuyUM1cWz5eDQ9Q7VDSB3hp9HCFKZjB+ilioQkfBWn/U/llS8u/MzU067D
 hCFKXj8vg9MY5k8NH3MGYGa2VpzQPVGLiV919v9+W7kmIkI8rjV6D/hCe126zxCzeqgTM/dnHJu
 Aw0WWEKbOVCOMxxRiAlllIlp4qrmjVCdNi4Rd8UbW1FTELRy7nJUTgeo/tS+AdjQgdTQQYniEs8
 PvdofGDaclMe4rdph9I0e8oM+PbUnEyGnGpPPr4PKOgBUMEz3/A/PPLvuMlnUk3mPWlnCrB8jR2
 Xp3No/s3eDxG298mtkZS2h+6cJr1j2/JONCahRTZ2TmR805nzCDqhTqgSBZauS3LuVFv5T4FEYU
 SQXoBX2YmJ4YyL4aaJImvbGWdgMZ93e3NWvs=
X-Received: by 2002:a05:600c:6309:b0:4a2:5267:3cd4 with SMTP id
 5b1f17b1804b1-4bb559f3bb9mr24419115e9.3.1794543103654; 
 Thu, 12 Nov 2026 20:11:43 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4bb56f8d054sm11734565e9.3.2026.11.12.20.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 20:11:43 -0800 (PST)
To: ltp@lists.linux.it
Date: Fri, 13 Nov 2026 04:11:32 +0000
Message-ID: <20261113041136.17102-4-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113041136.17102-1-wegao@suse.com>
References: <20261113041136.17102-1-wegao@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/4] getrusage03: Use tst_bind_to_current_cpu()
 helper
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Replace the local duplicate pin_to_current_cpu() implementation
with the tst_bind_to_current_cpu() library helper.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 .../kernel/syscalls/getrusage/getrusage03.c   | 32 +------------------
 1 file changed, 1 insertion(+), 31 deletions(-)

diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.c b/testcases/kernel/syscalls/getrusage/getrusage03.c
index d4dca8070..090c46dfc 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage03.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage03.c
@@ -18,8 +18,6 @@
 #include <stdlib.h>
 
 #include "tst_test.h"
-#include "lapi/cpuset.h"
-#include "lapi/sched.h"
 #include "getrusage03.h"
 
 #define TESTBIN "getrusage03_child"
@@ -33,34 +31,6 @@ static const char *const resource[] = {
 	NULL,
 };
 
-/*
- * Pin the test to the CPU it runs on. Every forked or exec'd child inherits
- * the affinity, so only that CPU can hold RSS counter updates outside the
- * fast percpu_counter read.
- */
-static void pin_to_current_cpu(void)
-{
-	unsigned int cpu;
-	cpu_set_t *set;
-	size_t size;
-
-	if (getcpu(&cpu, NULL))
-		tst_brk(TBROK | TERRNO, "getcpu() failed");
-
-	set = CPU_ALLOC(cpu + 1);
-	if (!set)
-		tst_brk(TBROK | TERRNO, "CPU_ALLOC() failed");
-
-	size = CPU_ALLOC_SIZE(cpu + 1);
-	CPU_ZERO_S(size, set);
-	CPU_SET_S(cpu, size, set);
-	if (sched_setaffinity(0, size, set))
-		tst_brk(TBROK | TERRNO, "sched_setaffinity() failed");
-
-	CPU_FREE(set);
-	tst_res(TINFO, "Pinned to CPU %u", cpu);
-}
-
 /*
  * The pinned CPU can still hold up to one percpu_counter batch,
  * max(32, 2 * online CPUs) pages, outside the fast RSS read.
@@ -80,7 +50,7 @@ static void setup(void)
 	tst_res(TINFO, "%li online CPUs, lower RSS allowance %li KiB",
 		online_cpus, lower_allowance);
 
-	pin_to_current_cpu();
+	tst_bind_to_current_cpu();
 }
 
 static void check_maxrss(long actual, long expected, const char *name,
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
