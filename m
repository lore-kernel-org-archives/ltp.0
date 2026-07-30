Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEFD0C55165
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 12:26:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF2953E569E
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 14:26:05 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4427C3E2D30
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 14:25:48 +0200 (CEST)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5A4F820090C
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 14:25:44 +0200 (CEST)
X-UUID: c363f19c8c1111f1aa26b74ffac11d73-20260730
X-CTIC-Tags: HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME,
 HR_CTE_8B
 HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
 HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
 HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
 HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
 SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
 CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
 GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:d3cd81e2-2898-4a5d-a454-897673ab43fd, IP:10,
 URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
 ON:release,TS:-15
X-CID-INFO: VERSION:1.3.12, REQID:d3cd81e2-2898-4a5d-a454-897673ab43fd, IP:10,
 UR
 L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-15
X-CID-META: VersionHash:e7bac3a, CLOUDID:ddd9044977b77b62f5e6f25acf47f23c,
 BulkI
 D:2607302025390296YKS5,BulkQuantity:0,Recheck:0,SF:10|66|78|102|127|850|86
 5|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,Q
 S:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,
 ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c363f19c8c1111f1aa26b74ffac11d73-20260730
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
 (envelope-from <sunshaojie@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1239527028; Thu, 30 Jul 2026 20:25:34 +0800
From: Shaojie Sun <sunshaojie@kylinos.cn>
To: ltp@lists.linux.it
Date: Thu, 30 Jul 2026 20:25:18 +0800
Message-Id: <20260730122521.1218460-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/3] Add CPU cgroup v2 tests ported from kselftest
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This series ports the CPU cgroup v2 tests from the kernel selftests
(tools/testing/selftests/cgroup/test_cpu.c) to LTP, including tests
for subtree control, cpu.stat, nice, weight, and cpu.max.

Patch 1 adds the necessary cgroup file entries (cpu.stat, cpu.weight)
to the LTP cgroup library.
Patch 2 adds the test source files and build infrastructure.
Patch 3 registers the new tests in runtest/controllers.

v2:
- Changed hog_cpus_timed() to use tst_brk() instead of returning -1
- Removed unused status variables, use NULL for SAFE_WAITPID
- Added copyright lines for the author in new files
- Fixed doc block formatting: use :kselftest: references and blank
  lines before bullet lists for reST rendering
- Removed redundant .needs_cgroup_nsdelegate = 0 initializers
- Removed unused USEC_PER_SEC from cgroup_cpu04.c
- Removed unnecessary drain writes in cleanup paths
- Replaced literal .tcnt values with ARRAY_SIZE(test_list) and
  function pointer tables
- Removed .timeout = 30 default value from cgroup_cpu05.c
- Added errno = 0 before nice() call in cgroup_cpu03.c
- Added .needs_kconfigs check for CONFIG_CFS_BANDWIDTH=y in
  cgroup_cpu05.c
- Added .needs_root = 1 to cgroup_cpu02.c for consistency
- Changed doc comment from /*\ to /* in cgroup_cpu_common.h
  since it is a helper header, not a test

Shaojie Sun (3):
  tst_cgroup: add cpu.stat and cpu.weight to cgroup file table
  cgroup: add CPU cgroup v2 tests ported from kselftest
  runtest/controllers: add CPU cgroup v2 test entries

 lib/tst_cgroup.c                              |   2 +
 runtest/controllers                           |   5 +
 testcases/kernel/controllers/cpu/.gitignore   |   5 +
 testcases/kernel/controllers/cpu/Makefile     |   9 +
 .../kernel/controllers/cpu/cgroup_cpu01.c     |  64 ++++
 .../kernel/controllers/cpu/cgroup_cpu02.c     | 103 ++++++
 .../kernel/controllers/cpu/cgroup_cpu03.c     | 115 ++++++
 .../kernel/controllers/cpu/cgroup_cpu04.c     | 332 ++++++++++++++++++
 .../kernel/controllers/cpu/cgroup_cpu05.c     | 176 ++++++++++
 .../controllers/cpu/cgroup_cpu_common.h       | 131 +++++++
 10 files changed, 942 insertions(+)
 create mode 100644 testcases/kernel/controllers/cpu/.gitignore
 create mode 100644 testcases/kernel/controllers/cpu/Makefile
 create mode 100644 testcases/kernel/controllers/cpu/cgroup_cpu01.c
 create mode 100644 testcases/kernel/controllers/cpu/cgroup_cpu02.c
 create mode 100644 testcases/kernel/controllers/cpu/cgroup_cpu03.c
 create mode 100644 testcases/kernel/controllers/cpu/cgroup_cpu04.c
 create mode 100644 testcases/kernel/controllers/cpu/cgroup_cpu05.c
 create mode 100644 testcases/kernel/controllers/cpu/cgroup_cpu_common.h

-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
