Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54CEECA5FEC
	for <ltp@archiver.kernel.org>; Sun,  4 Oct 2026 21:16:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 001103E4D52
	for <ltp@archiver.kernel.org>; Sun,  4 Oct 2026 23:16:02 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B59A13E1C23
 for <ltp@lists.linux.it>; Sun,  4 Oct 2026 23:15:45 +0200 (CEST)
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 46979200072
 for <ltp@lists.linux.it>; Sun,  4 Oct 2026 23:15:45 +0200 (CEST)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-4a0280d4f56so6853075e9.2
 for <ltp@lists.linux.it>; Sun, 04 Oct 2026 14:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791148545; x=1791753345; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=01EXX1LPGOz3UsdPlkf6u31JnP+tO9kkLHS0g2ssrCs=;
 b=nldIWaUSU47okhH6xDXL9UsxTXRlQKqh8cWtLqpOYqUgMnnl7nCMWeLRgl4kPXYnCp
 uMHXWqzSIJTZ3ivhdu6cgajvMyKyzyZYp/NaqxU7dMKiTuhClSIGZmwErwm7RcWe1ijp
 AvVhcr42sCO4zbzTnFhdGoJ5EotJtSaChp48PlrVn3nE2oFq0m0hV88ke4WUwHf++JDy
 D7gwzFc/TLBkBXVpihSmk10HuinYP3lq2dVFWK6dzzDm84xwrz/hnR6K6USAQp1/ewgX
 NxDXR9A2mSrI+gSG5gFGU/f/+yHHN0yLReiw6lTDIffiQJyoVLS2F2iN4lbxefO8HOf9
 agSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791148545; x=1791753345;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=01EXX1LPGOz3UsdPlkf6u31JnP+tO9kkLHS0g2ssrCs=;
 b=lFcLsYj8qh6JzmqpZYduhHVA8CYqwhkxkTo+yHzx+ej5tn3wMWaLVfMX70gW/hs+mq
 l20bh207+9AUQwSFO+9wReL3CSj+KNNjTlRToQwP4Q0gGCDBFBUpK2OJ76Piu0BVVa5O
 VWcL87C87DUovFB5oE14b8Sl2gw2vWDRrukhDAFlVaWuXWGKLtagyP5MPOyiEHZDkP5z
 ltPzCkLIcNzyh6y3ImcDXTN67Hb/T5tLAxugZwToQdZiRHXwA/vDk6EureFIBTC33Nuh
 lEC/5NnvlRacDzP/7YrvzOAOAmINrBEPqXsoZM4gazPZMqqXfXgExcs52sj3lmTc4SUt
 L25Q==
X-Gm-Message-State: AFuF++kE854Wjv4P7P8domYUaAWff7IPQrSAK0R2MsPngTitclCFHzm7
 QBJSUvJ/JN75Ch3j3LV/nZWSFtjyP0zYglla77q356nr7ykDVt8jA/z/tKeZYek0OrM=
X-Gm-Gg: AYBFou0E7XmsVXZr1wI/ZKxh7gac2YssAQ28JDOeyGBhDaBwQOVMAA8pwWwlDp73bHa
 LYBmtyD6sfDuzyhdDYUleyzA8yyHapj0zh2PgwSf8UL7f3aHf2ZFTD1W0bId1udiV9wt89s4Egk
 4ct9MrCLf/eJWQT+X0bcerxjSnDxm8VlrAXhHS7DiXNpYtqltfpFMQjPGkPauspnsWVgM5iPOeh
 BwTSq0VZchFbSSRIIC5M12POoXjDWBc9kVOKC6GAYk1GbdPfRbprmVLJ817eMCwt0idimgmZrhB
 /q0u7+PjN9fiQLIk4fO/uw00tA3brhjTNPr0yt4ugcQG2zQ3hMQTqwj2xKL/4wFSv7Nzbhya5oD
 wnG7Ti9Y2W9lOw3BRbuSxBwqb4BYfXb6rTbQJ39pwqC0HXUQltLbdcw0OJUtDW8SENBj+RvEQjw
 bzekp5JbjM5jDKgPnROGoupOE4OIOtlPaZjGAAsHCgdlQd3YBq59xueHeUcWcVWeqqOAZ36kN+J
 rmVnD9rNcAp6txOrgv1AfSAXyPNI9Yo6aQo4q9aQ37vf+4FWjgxNFXY2vOsJtvCjwTDzBFbwhCh
 IpRFgFYWRavJkN/qv+FQAgA=
X-Received: by 2002:a05:600c:8b2a:b0:49f:fd2d:23c7 with SMTP id
 5b1f17b1804b1-4a0276ad704mr181421175e9.27.1791148544277; 
 Sun, 04 Oct 2026 14:15:44 -0700 (PDT)
Received: from pradeep-susarla-LTP.tail3351fa.ts.net
 (cmbg-20-b2-v4wan-174372-cust280.vm17.cable.virginm.net. [80.3.67.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a03950375dsm115151725e9.1.2026.10.04.14.15.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 14:15:43 -0700 (PDT)
From: Pradeep Susarla <pradeep.susarla@gmail.com>
To: ltp@lists.linux.it
Date: Sun,  4 Oct 2026 22:15:32 +0100
Message-ID: <20261004211535.7307-1-pradeep.susarla@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/3] hugetlb/numa: migrate test helpers to libs/
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
Cc: Li Wang <liwang@redhat.com>, Claude <noreply@anthropic.com>,
 pradeep.susarla@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Claude <noreply@anthropic.com>

This series moves the hugetlb test library and the numa cpuset helper
into the global libs/ location, following the tse_ naming scheme adopted
for the extended (non-core) libraries, and fixes an out-of-bounds write
found during review.

The remaining helpers from #1276 are left as follow-ups: numa_helper.c
still uses the legacy test API and should be rewritten before being
moved, and the placement of the single ksm_helper.c function is still
open.

Part of #1276

Changes in v3:
 - Split the two independent migrations into separate patches, as
   requested in review (hugetlb library vs write_node_cpusets()).
 - New patch 3/3: fix the out-of-bounds write in gather_node_cpus()
   when a node has no online CPUs, reported in review (pre-existing,
   predates the move).
 - Rebased onto current master; converted the newly added tests
   (hugemmap35, hugemmap36, hugemmap37, hugemmap38, hugemmap41) to the
   tse_hugetlb.h header.

Changes in v2:
 - Rebased onto the merged tse_ naming scheme (v1 still used tst_).
 - Fix the ksm02 link failure reported on v1: ksm02, ksm04, oom04 and
   oom05 now link -lltpnuma.
 - Use the standard LTPLIBS mechanism for the hugetlb tests instead of
   a hand-rolled Makefile.inc.
 - Size the per-CPU sysfs path buffer to avoid -Wformat-truncation.

Pradeep Susarla (3):
  hugetlb: Migrate test library to libs/
  numa: Move write_node_cpusets() into libs/numa
  numa: Fix out-of-bounds write in gather_node_cpus()

 .../lib/hugetlb.h => include/tse_hugetlb.h    | 11 ++--
 include/tse_numa.h                            | 13 ++++
 libs/hugetlb/Makefile                         | 11 ++++
 .../hugetlb.c => libs/hugetlb/tse_hugetlb.c   |  2 +-
 libs/numa/tse_numa.c                          | 58 +++++++++++++++++
 testcases/kernel/include/numa_helper.h        |  4 --
 testcases/kernel/lib/numa_cpuset.c            | 64 -------------------
 testcases/kernel/mem/hugetlb/Makefile         | 21 +-----
 testcases/kernel/mem/hugetlb/Makefile.inc     | 35 ----------
 .../kernel/mem/hugetlb/hugefallocate/Makefile |  4 +-
 .../hugetlb/hugefallocate/hugefallocate01.c   |  2 +-
 .../hugetlb/hugefallocate/hugefallocate02.c   |  2 +-
 .../kernel/mem/hugetlb/hugefork/Makefile      |  4 +-
 .../kernel/mem/hugetlb/hugefork/hugefork01.c  |  2 +-
 .../kernel/mem/hugetlb/hugefork/hugefork02.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/Makefile      |  4 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap01.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap02.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap04.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap05.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap06.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap07.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap08.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap09.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap10.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap11.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap12.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap13.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap14.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap15.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap16.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap17.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap18.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap19.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap20.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap21.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap22.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap23.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap24.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap25.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap26.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap27.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap28.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap29.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap30.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap31.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap32.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap34.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap35.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap36.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap37.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap38.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap41.c  |  2 +-
 .../kernel/mem/hugetlb/hugeshmat/Makefile     |  4 +-
 .../mem/hugetlb/hugeshmat/hugeshmat01.c       |  2 +-
 .../mem/hugetlb/hugeshmat/hugeshmat02.c       |  2 +-
 .../mem/hugetlb/hugeshmat/hugeshmat03.c       |  2 +-
 .../mem/hugetlb/hugeshmat/hugeshmat04.c       |  2 +-
 .../mem/hugetlb/hugeshmat/hugeshmat05.c       |  2 +-
 .../kernel/mem/hugetlb/hugeshmctl/Makefile    |  4 +-
 .../mem/hugetlb/hugeshmctl/hugeshmctl01.c     |  2 +-
 .../mem/hugetlb/hugeshmctl/hugeshmctl02.c     |  2 +-
 .../mem/hugetlb/hugeshmctl/hugeshmctl03.c     |  2 +-
 .../kernel/mem/hugetlb/hugeshmdt/Makefile     |  4 +-
 .../mem/hugetlb/hugeshmdt/hugeshmdt01.c       |  2 +-
 .../kernel/mem/hugetlb/hugeshmget/Makefile    |  4 +-
 .../mem/hugetlb/hugeshmget/hugeshmget01.c     |  2 +-
 .../mem/hugetlb/hugeshmget/hugeshmget02.c     |  2 +-
 .../mem/hugetlb/hugeshmget/hugeshmget03.c     |  2 +-
 .../mem/hugetlb/hugeshmget/hugeshmget05.c     |  2 +-
 .../mem/hugetlb/hugeshmget/hugeshmget06.c     |  2 +-
 testcases/kernel/mem/hugetlb/lib/Makefile     | 10 ---
 testcases/kernel/mem/ksm/Makefile             |  2 +
 testcases/kernel/mem/ksm/ksm_common.h         |  1 +
 testcases/kernel/mem/oom/Makefile             |  4 ++
 testcases/kernel/mem/oom/oom04.c              |  1 +
 testcases/kernel/mem/oom/oom05.c              |  1 +
 77 files changed, 175 insertions(+), 201 deletions(-)
 rename testcases/kernel/mem/hugetlb/lib/hugetlb.h => include/tse_hugetlb.h (87%)
 create mode 100644 libs/hugetlb/Makefile
 rename testcases/kernel/mem/hugetlb/lib/hugetlb.c => libs/hugetlb/tse_hugetlb.c (99%)
 delete mode 100644 testcases/kernel/lib/numa_cpuset.c
 delete mode 100644 testcases/kernel/mem/hugetlb/Makefile.inc
 delete mode 100644 testcases/kernel/mem/hugetlb/lib/Makefile

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
