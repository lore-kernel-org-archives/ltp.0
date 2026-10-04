Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B989CA5FE6
	for <ltp@archiver.kernel.org>; Sun,  4 Oct 2026 14:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791124519; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=WtDk0Btta7OeF40Fp5vMe+j0+0hiPL5Ni2RmORhnKOA=;
 b=P97Okr3tRAg0BGWgzQh5n87/gzi0tAg2l00y/M0sj2BgLOoUYxmJgfBLNdoE8rE327mXt
 NvyEqAxBn8dtFhNFxy8fH6Wy9rdBn2OHfdYqbYu7CRdxRwrjaFgsZe8CuLdGEXm8GTmE2fG
 80hGEYVsFqc4lxMgyLPlu6B57Rq/o/o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 49E833E4E5C
	for <ltp@archiver.kernel.org>; Sun,  4 Oct 2026 16:35:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3953A3E4D60
 for <ltp@lists.linux.it>; Sun,  4 Oct 2026 16:34:40 +0200 (CEST)
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E831A1A002E1
 for <ltp@lists.linux.it>; Sun,  4 Oct 2026 16:34:39 +0200 (CEST)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e66390995so6374155e9.2
 for <ltp@lists.linux.it>; Sun, 04 Oct 2026 07:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1791124479; x=1791729279; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7jXmAQSmANoZcJxIdH8wqQvbUnzDgaibiV6P59gGhUQ=;
 b=PaL6OUwsbWTxb3cLhhl5r9L5OT1DM9ZeOpvXEB/S/N41OYI/PusY7tYb1r7ypqh3Yg
 dWXuiJZGsgI2wnN9WA5G8RAFNOGh/CyZJceOXecxGFp72coZlVXAW6P9lH4a0gOOuadZ
 FCT/Pbm8ng4qZq8rRjuWMdaulsMZwWRHqsQBUlqE0I62GrBRaWFHYZ9kxEkyplGSfH0U
 DjVXff0SimjwSrAK1RoRDWo7oxawCldHaxNC5AoKbglIBWFLfWxwl0t0Kgl4baKkxdbb
 VE3UfViVTprWEcJvwJF2KxfIGOTRYOMHBbRJ9/eZU8PkCYhRb1C1XOlh0AWFwzCSDfoE
 B8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791124479; x=1791729279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7jXmAQSmANoZcJxIdH8wqQvbUnzDgaibiV6P59gGhUQ=;
 b=jlpF3gPXLPWbJT48JVjqCThqdW+2g9Qp5xkrmp/1ORwAHWBujaXkdsKIcFQ2st/JJX
 EOHEc3MFvXA+DTVoPAVdc1J4Oe7V7lnfVX84TWpQCL/z8LckvDu+/EV5jTTgyLFDA9zs
 MdjvX5Fj+//6WYovJcMOVeJ7usdve0fs0prvJyyWBiX+lJTBOirYhTm2nXUZ0gTpmROR
 iZVRNd83ZNYJAJMEimXnqXM4VhH053Sa2hIysr6oDDVMCzwLxXrR0QlW0Tg/ioEVaFtn
 vykvxqDHBLXaHxerThb3540wtyWO6qkS3lGOQ18vBKREbDCm1fnfiGatAGXqFd1hb0iq
 L4/g==
X-Gm-Message-State: AFuF++kH2JN5z4SV9ItRdlvBF4FDEctI9nuV+PCRaDVZdB0YwIkao48W
 xx6UF9TehYLtES4G2MWbGKDPTDT/MczOtFDf4HOvotQHVZPSZUpMJMLh3oB8K9VfGegDiZ5nYNv
 zmGs=
X-Gm-Gg: AYBFou21lVB6rNfiM4aj2rBMpe+FWYVev2VP4p/ntxwP+H9ZSoiqZCnuw5yqmA5VT+T
 ZWKWptvGXC2NB+ze8DeJf4b++qBAWyc0O121mUxRGcWwhLgWvzj4KEAU3OcTHiYt23HS51/OZB9
 rcnx0i6ApzqLdez1jUji5O3Np1bjw8qTy8rZHkxjuXd2pHCzddkZVeb8Kx3SG9x1vSZEegoNyhY
 5eLvctYgIQZwAzA7GHfGacCDBreBdbZyMXNXHlDyYdLvWuXZC4yWrMMSgD5fWyDOGJehJr7zvPy
 sOk0/sepoPYcSbN5eJLfx+J7rR0WSJ9maPkfmT/oyinvYsUoSOYT4jQcMQPPOnu+TyEJXURxqeP
 LfeVBLmbqNLd5k0O3ap3WRtFAwwtlgG3m47z7vf2XGc6gblKRkOe8Z/t8AXOXXOjxFPJe3/xm0+
 K1ZMLHNkx1gzOGoufv5eu1ndGg5Efm1GLKZEiJ61+3H66c4UDdrc4tsqQWHt15dvQ9vCKaRclCl
 CAeyVbAKIOcWzfKE9PESlfvcHrf9IosOuPZceWXJUg=
X-Received: by 2002:a05:600c:8715:b0:49c:fc6c:be08 with SMTP id
 5b1f17b1804b1-4a0276b1af1mr144967205e9.31.1791124479354; 
 Sun, 04 Oct 2026 07:34:39 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-48b380facfesm20046230f8f.23.2026.10.04.07.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 07:34:39 -0700 (PDT)
To: ltp@lists.linux.it
Date: Sun,  4 Oct 2026 14:33:26 +0000
Message-ID: <20261004143332.25978-2-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261004143332.25978-1-wegao@suse.com>
References: <20261004143332.25978-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/2] memcontrol: Add helpers to set and restore
 parent memory knobs
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

In cgroup v2, memory protection (memory.min and memory.low) is hierarchical
and evaluated top-down. The effective protection of descendant cgroups is
bounded by their parent and ancestor protection values. When LTP runs, the
test sandbox cgroups (tst_cg and its parent ltp) default to 0, which causes
background reclaim (such as kswapd under node-level memory pressure) to
reclaim memory from descendants regardless of local protection settings.

Add set_parent_memory_knob() and restore_parent_memory_knob() to
memcontrol_common.h to allow memcg tests to configure protection on both
Level 2 (tst_cg) and Level 1 (the shared ltp directory). The original values
are read and preserved before modification, and restored upon cleanup.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 .../controllers/memcg/memcontrol_common.h     | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/testcases/kernel/controllers/memcg/memcontrol_common.h b/testcases/kernel/controllers/memcg/memcontrol_common.h
index 495f924a0..e4b12aff3 100644
--- a/testcases/kernel/controllers/memcg/memcontrol_common.h
+++ b/testcases/kernel/controllers/memcg/memcontrol_common.h
@@ -10,10 +10,56 @@
 #include <stdio.h>
 
 #include "tst_test.h"
+#include "tst_safe_file_at.h"
 
 #define TMPDIR "mntdir"
 #define MB(x) (x << 20)
 
+static char orig_tst_val[64];
+static char orig_ltp_val[64];
+
+static inline void set_parent_memory_knob(const char *knob, const char *val)
+{
+	int tst_fd = tst_cg_group_unified_dir_fd(tst_cg);
+	int ltp_fd;
+
+	if (tst_fd < 0)
+		return;
+
+	ltp_fd = SAFE_OPENAT(tst_fd, "..", O_DIRECTORY | O_RDONLY);
+
+	/* 1. Read and save original values */
+	SAFE_CG_READ(tst_cg, knob, orig_tst_val, sizeof(orig_tst_val));
+	SAFE_FILE_READAT(ltp_fd, knob, orig_ltp_val, sizeof(orig_ltp_val));
+
+	/* 2. Apply new values to Level 2 (tst_cg) and Level 1 (ltp) */
+	SAFE_CG_PRINT(tst_cg, knob, val);
+	SAFE_FILE_PRINTFAT(ltp_fd, knob, "%s\n", val);
+
+	SAFE_CLOSE(ltp_fd);
+}
+
+static inline void restore_parent_memory_knob(const char *knob)
+{
+	int tst_fd, ltp_fd;
+
+	if (!orig_tst_val[0])
+		return;
+
+	tst_fd = tst_cg_group_unified_dir_fd(tst_cg);
+	if (tst_fd < 0)
+		return;
+
+	ltp_fd = SAFE_OPENAT(tst_fd, "..", O_DIRECTORY | O_RDONLY);
+
+	/* Restore original values */
+	SAFE_CG_PRINT(tst_cg, knob, orig_tst_val);
+	SAFE_FILE_PRINTFAT(ltp_fd, knob, "%s", orig_ltp_val);
+
+	SAFE_CLOSE(ltp_fd);
+	orig_tst_val[0] = '\0';
+}
+
 /*
  * Checks if two given values differ by less than err% of their
  * sum. An extra percent is added for every doubling of the page size
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
