Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A527CA5FA5
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 02:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1790648645; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=wqw1pU+ePmokhhhztFIQUyoZ61a/if2kXAdxpkleLCo=;
 b=dKUPEuxfmfT+GnD8LCqSJWFXXt+hJEaWQNZlCSGbfWZ1Y6nkqrH5jsZfJqbxJtAF3ZUiq
 g/RBU0CPiyfJ+fKGQdFEOwhLZ+FPnTodbLhcxiNVqVRKcTCdcfBxnCAro27DrqxsksTkL1M
 8nDM0gwc8FpL8WnVdwRK8qF5ehiJ8zw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C2863DDCA8
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 04:24:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 774DF3CF2EB
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 04:23:44 +0200 (CEST)
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AD51F1000A01
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 04:23:43 +0200 (CEST)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e8185e037so20320985e9.3
 for <ltp@lists.linux.it>; Mon, 28 Sep 2026 19:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1790648623; x=1791253423; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+x7FDfJrpYsp2BFRmXF9Z3ZwGyt6LAKGvdBYZOE/oUc=;
 b=b0D1IhO1qb30YqkAfHYZz6dKvtB+gr2GZ9+9q2j7Lw8NZuLV9WokqtjUx87Z+GBWtX
 XiHEpHSX1cQmoiV6V3/m6U5R+ZfuSsLI21BWU6JpICfy4zKeiNjnWyCkVP5Oi+GSNGDJ
 ieBZuwiA7A8uyosseeFuysCkdmdtiGzY6Cq/i6BDhyjUXcVhBEXvAogglagQLEo4q1mF
 mWHL1uAR4K7TXtD54EOaV2b8OFHZ9Xb7vIPT1YElE6QlQuHDJNBq5mmjJze1w/X/sEHy
 xiFSJkfUOU4NiQGyGFx7aW1MH9fHdN3ya7Iy8b8gm2b+BOL/sgUJEWX8i1O2we3u3I4n
 rAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790648623; x=1791253423;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+x7FDfJrpYsp2BFRmXF9Z3ZwGyt6LAKGvdBYZOE/oUc=;
 b=gpK5W+2ce3I0LbTqA9sUDchCXYBJquhFuW7n9P+AHhPWcWZ0EWmgVofm8Y4oI0LlN6
 WsAtUaRCzilQlomAIENNqA2YDF7Ype4We1hQJSlRvi2Llqc9RTFtR/lICnvmTDibp29x
 wS+LDlokGt5qv/+XpwHQoXpw4bXT/QVm8yunUOah/NQ1R3zKwaIlqUWuHwa5Y/VrSnUQ
 ITLum+xz7V3Uh4vc91jFCLuaRpHbEkRfcVwdTt9YkU+7TtzFtMZazKsleelxw2+nE15f
 EaKYmj7yR1dCCj4AoOeFOBU6W00tTEXZ6y2VZILeHW1/MgnDXRG+9+LIiEipXDvDWDd0
 BcNw==
X-Gm-Message-State: AFuF++kvRIt6RUlbBR+uyQqagkqhQ0a4wIhOC/0Rb7VSBXWyj8cKtFsE
 TtL6k20sAWqXvraczacKROEUKCC5LI5r5n+BNmkKldCohKGhuv+pfLrd4XFZo60DJ2Sfl/+vMIi
 z9gs=
X-Gm-Gg: AYBFou0kInOFi1ixdVQ/0qRZ5YMW9Mkada47pFQ2HMhyINjcQBmrYrPaRraxx0FW2A1
 ++rRyLjjeWAbKDYmiaDAhYonAuPEGhgofRacXKI3R21BdMcS3sHuIWIZyQBsmNYQQ/XS+sjgBqr
 Ugq5J8uMpiyfJXqhUeYLVfThZ0gVXYbV0rbf00ombRs7S0EBPRpMFXfXUo+7QL2dnlJv+2n6m3a
 ywPqs6X+OiiRdNW154qdxgDs0EYzXGLKk/z4wlJYk+s2F1TXEXRJy6swV+vSDQlK78H0UKnXQrZ
 ADacwyZFHsqbTFz1TtqirCnW3bXHwMFxiHz21BQ9M+jnYpQHRuUWTX2Hi6+P0FMgM8llRH/FWvx
 2yoICMVa4rAcrkHQL8OwHvF/bmqY1Nl+26fy2z/vMY1g2T+dIINqLtV0AYYRQnSirFK6y+nkohq
 CHrwabwcIVuThfzVUy2vfbEW1aYGOLlN6FNGRwjVuFzpX0usrCX1R3ad4THJrZssW4gQBqyMJBj
 QmzoGtf0kBR3NxfpTfPbPpLvBRe1Uho9MU4jOZc7iU=
X-Received: by 2002:a05:600c:3b92:b0:49c:fea3:8633 with SMTP id
 5b1f17b1804b1-49ff06ed9b6mr224951605e9.24.1790648622966; 
 Mon, 28 Sep 2026 19:23:42 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4a00d0e9f9bsm39883145e9.10.2026.09.28.19.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 19:23:42 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 29 Sep 2026 02:23:32 +0000
Message-ID: <20260929022340.524-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] memcontrol03: Bind to single CPU on systems with
 64KB pagesize
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
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On multi-CPU systems with 64KB page size (e.g. ppc64le), memcontrol03
intermittently fails with over-reclaim of protected pagecache under
trunk_B:

  memcontrol03.c:104: TINFO: Child 142113 in trunk_G: Allocating anon: 150994944
  memcontrol03.c:121: TPASS: Child 142113 exited
  memcontrol03.c:214: TPASS: Expect: (A/B memory.current=54394880) ~= 52428800
  ...
  memcontrol03.c:104: TINFO: Child 142114 in trunk_G: Allocating anon: 174063616
  memcontrol03.c:116: TPASS: Child 142114 killed by OOM
  memcontrol03.c:230: TFAIL: Expect: (A/B memory.current=43319296) ~= 52428800

In the kernel, per-CPU charge batching (MEMCG_CHARGE_BATCH = 64 pages)
caches up to 64 * 64KB = 4MB per CPU in memcg_stock. On a multi-CPU
system, allocating memory across CPUs allows cached stock charges to
accumulate in ancestor trunk_A (up to 4MB * nr_cpus, e.g. 16MB on a
4-CPU machine). Because trunk_A has memory.max = 200M, this extra stock
pressure forces the reclaimer to evict pagecache in trunk_B down to
~35-43MB instead of the expected ~50MB. Simply enlarging the tolerance
rate further is not good idea.

Bind the test process to a single CPU in setup() when page size is
>= 64KB. This confines stock batching to a single CPU, preventing
multi-CPU stock inflation and ensuring reproducible reclaim behavior.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 .../kernel/controllers/memcg/memcontrol03.c    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/testcases/kernel/controllers/memcg/memcontrol03.c b/testcases/kernel/controllers/memcg/memcontrol03.c
index 96224c4ee..6007d5588 100644
--- a/testcases/kernel/controllers/memcg/memcontrol03.c
+++ b/testcases/kernel/controllers/memcg/memcontrol03.c
@@ -235,6 +235,23 @@ static void test_memcg_min(void)
 	SAFE_UNLINK(TMPDIR"/tmpfile");
 }
 
+static void setup(void)
+{
+	if (getpagesize() >= 64 * 1024) {
+		cpu_set_t mask;
+		int cpu = sched_getcpu();
+
+		if (cpu < 0)
+			tst_brk(TBROK | TERRNO, "sched_getcpu() failed");
+
+		tst_res(TINFO, "Page size >= 64KB, binding to CPU %d", cpu);
+		CPU_ZERO(&mask);
+		CPU_SET(cpu, &mask);
+		if (sched_setaffinity(0, sizeof(mask), &mask))
+			tst_brk(TBROK | TERRNO, "sched_setaffinity() failed");
+	}
+}
+
 static void cleanup(void)
 {
 	cleanup_sub_groups();
@@ -243,6 +260,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = test_memcg_min,
 	.mount_device = 1,
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
