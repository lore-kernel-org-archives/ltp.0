Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344FAC531CB
	for <ltp@archiver.kernel.org>; Thu, 23 Jul 2026 09:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784800032; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=OAAGxK6obM1oG0GEpABr31lyJS2C9EmzaatjDN2Lkv0=;
 b=Sl5fEfDzeEOn8YnpUYVarvOQFeNLTl3MonHykqix1OAEUlSpvAJ5ypTOWkgjwZzNxTRWA
 Yxlk5YZO2EpyBHDMGXT6wKBpUiN6xg057dSekmd6LdAY0yYQd7SQIUySsolEK7aK/s649nA
 EmKEeaIWSaShDziyMpjx1F+VGGdEJtw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D96B3C7757
	for <ltp@archiver.kernel.org>; Thu, 23 Jul 2026 11:47:12 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E9ED3C7757
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 11:46:50 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3DAF71A00905
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 11:46:50 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-47c2b362ee2so363765f8f.1
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 02:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784800009; x=1785404809; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7QgnxQ/Gl9mE8Vzf+ln/gvkHQ5BrpwCa9MKV+vFVeNk=;
 b=Cm0U4d73kbHTtpS6nY6f0HBSIAxcrwFhO1ldxT4FrwQXP5IoRSetx1MO5IpnH0YIBv
 EWKX9+wNZXD2wwz/Fzb0u+IU3pZgNQm4NTFlhHk2U8QZGi7ieos12anVlbwCeN+PCaEq
 c7FGQXO/cf4fuAfN7fc72JS+2PNmLvxH7ste2kxmuBkfoHpsqAZvutRR65FvXrUhhApA
 e6w7KkeDbgxSDGJvNTEjvYTmG/mIGH7sP2+ONplTAu4vXbKPc1cSX3B/+KgSxKIla1Vk
 NhCYWo/mki3vXeBbzPQyMmTC6h7YWsueRIh4iAqW7M9lZcPLf4I8gE1KLGAHxLPG7C14
 YHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784800009; x=1785404809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7QgnxQ/Gl9mE8Vzf+ln/gvkHQ5BrpwCa9MKV+vFVeNk=;
 b=oBV0KgrPZBOw22Gds97sQMi/8zM8XswZ5kF1+Oq8znpA5n9INzEbAN5RFU74nuPQXz
 +JRF/KzyQZ47MZrMMzB4bfCY6qHcDCwDZXZZx3tEcf/zP6HbpkPuf+MCgvz0VeVZoVne
 Tu7fejSrTHjS3LA6vwLq1CFEaiO6CyVTqlGRYZsVQgnBwT7B75TLQ5zo8nMDMOrlV9i1
 10iqKg4sCOZcPvanShWzpH5ScN7Me3pIUQpj2NIGNUzh4d3TkOlrYSwEEVN8mE2dzSbF
 fOJXh2/1kYgZGRAM7P/zaiz6y7j9tmsb9lcecxpUWH7MVktNRThOspb85gvnuSCqSKFR
 Q7Wg==
X-Gm-Message-State: AOJu0Yw0bt41NnJRAkE9S3I8zA/FHjlTQX/xXnL4Wu9TlU141qZJJZsj
 ifG2QWVy9hjEGjdOoQdA2c3SbbqmZd93hdYIe4K2ve2zEvX+xgD4yD/GnfVTVjvAxl25gsgauQD
 jTA0=
X-Gm-Gg: AR+sD105RjalwR1i7vK1t3TsbUrOPG4K/+PX49eA4gFesUPAFdjFV6HeFIUn1IE80l9
 +ia5ULkdr2EVP2wQM7QkynwZzh96bpaXvZ+DpxO5ixsKKtpPfXRNUn5+U4rNdOnJe4F2q1Zxrmz
 WfOM1dwbMzHyWlTuBx5X/vc1GFcWIYhm0JNqbGnMXZAGmdD51lGSTi3gdridQu5JsPwlE4KCScK
 c3Hm3Rhbz/rmJ9k9QjrVq3mPOwmRPOrBcL0ajo71xdCNXjnLOvmqBatMJbqi6KEw60dahPFECeO
 7Xq+nvXo0gb41pMKBbi7N2bHD4vgTtX5xbYWOz3eE15h8aQPjDQVO7cJhuwD8AlS3dHdZ8uAEXP
 jbkIsjr0sWNBQL6qsn0FXHnNl2YaGCUcYnYWwepDrFDKvi6VTDfUKMp/i6xRcsKv8AQ==
X-Received: by 2002:a05:6000:2f87:b0:47f:8487:a686 with SMTP id
 ffacd0b85a97d-47f8d72c248mr2757967f8f.23.1784800009514; 
 Thu, 23 Jul 2026 02:46:49 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-47f8635c8d7sm12577301f8f.21.2026.07.23.02.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 02:46:49 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 23 Jul 2026 09:46:21 +0000
Message-ID: <20260723094647.5051-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723075319.4920-1-wegao@suse.com>
References: <20260723075319.4920-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] madvise09: Scale cgroup memory/swap limits
 dynamically with page size
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On systems with 64KB page size (such as ppc64le), the mapped footprint
of PAGES (128) is 128 * 64KB = 8MB. Since the cgroup MEM_LIMIT was
hardcoded to 8MB, there was zero headroom left for the parent's process
overhead, resulting in OOM when trying to fork the memory pressure
process.

This caused the test to enter an infinite "Both children killed,
retrying..." loop.

Fix this by scaling mem_limit and swap_limit dynamically based on the
system page size at runtime, and update the swap pre-check and doc
comments to match.

Signed-off-by: Wei Gao <wegao@suse.com>
---
Changes v1 -> v2:
- Update doc comment to reflect page-size based limit calculation.
- Guard tst_available_swap() check with swap_accounting_enabled to avoid unnecessary TCONF when swap accounting is off.

 testcases/kernel/syscalls/madvise/madvise09.c | 30 ++++++++++++-------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise09.c b/testcases/kernel/syscalls/madvise/madvise09.c
index 5453f9411..620805370 100644
--- a/testcases/kernel/syscalls/madvise/madvise09.c
+++ b/testcases/kernel/syscalls/madvise/madvise09.c
@@ -17,11 +17,11 @@
  * o Write to some of the madvised pages again, these must not be freed
  *
  * o Set memory limits
- *   - memory.max = 8MB
- *   - memory.swap.max = 16MB
+ *   - memory.max = 16 * PAGES * page_size (8MB on 4KB page size)
+ *   - memory.swap.max = 2 * memory.max (16MB on 4KB page size)
  *
  *   The reason for doubling the memory.max is to have safe margin
- *   for forking the memory hungy child etc. And the reason to setting
+ *   for forking the memory hungry child etc. And the reason to setting
  *   memory.swap.max to twice of that is to give the system chance
  *   to try to free some memory before cgroup OOM kicks in and kills
  *   the memory hungry child.
@@ -54,8 +54,10 @@ static int swap_accounting_enabled;
 #define TOUCHED_PAGE1 0
 #define TOUCHED_PAGE2 10
 
-#define MEM_LIMIT (8 * 1024 * 1024)
-#define SWAP_LIMIT (2 * MEM_LIMIT)
+#define BASE_SWAP_LIMIT (16 * 1024 * 1024)
+
+static long long mem_limit;
+static long long swap_limit;
 
 static void memory_pressure_child(void)
 {
@@ -176,12 +178,12 @@ static void child(void)
 	ptr[TOUCHED_PAGE1 * page_size] = 'b';
 	ptr[TOUCHED_PAGE2 * page_size] = 'b';
 
-	SAFE_CG_PRINTF(tst_cg, "memory.max", "%d", MEM_LIMIT);
-	tst_res(TINFO, "Setting memory.max to %d bytes", MEM_LIMIT);
+	SAFE_CG_PRINTF(tst_cg, "memory.max", "%lld", mem_limit);
+	tst_res(TINFO, "Setting memory.max to %lld bytes", mem_limit);
 
 	if (swap_accounting_enabled) {
-		SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%d", SWAP_LIMIT);
-		tst_res(TINFO, "Setting memory.swap.max to %d bytes", SWAP_LIMIT);
+		SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%lld", swap_limit);
+		tst_res(TINFO, "Setting memory.swap.max to %lld bytes", swap_limit);
 	} else {
 		tst_res(TINFO, "memory.swap.max is unavailable, running without SWAP_LIMIT");
 	}
@@ -284,6 +286,14 @@ static void setup(void)
 		tst_res(TINFO, "Swap accounting is disabled");
 
 	page_size = getpagesize();
+
+	mem_limit = 16 * PAGES * page_size;
+	swap_limit = 2 * mem_limit;
+
+	if (swap_accounting_enabled && (tst_available_swap() < swap_limit / 1024)) {
+		tst_brk(TCONF, "System needs at least %lldMB free swap to run this test",
+			swap_limit / TST_MB);
+	}
 }
 
 static struct tst_test test = {
@@ -291,6 +301,6 @@ static struct tst_test test = {
 	.test_all = run,
 	.needs_root = 1,
 	.forks_child = 1,
-	.min_swap_avail = SWAP_LIMIT / TST_MB,
+	.min_swap_avail = BASE_SWAP_LIMIT / TST_MB,
 	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
 };
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
