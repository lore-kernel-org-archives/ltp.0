Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C59C55162
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 03:14:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7FE733E91C4
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 05:14:40 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 158103E91BE
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 05:14:09 +0200 (CEST)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A56ED20009C
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 05:14:06 +0200 (CEST)
X-UUID: decc98868c8d11f1aa26b74ffac11d73-20260731
X-CTIC-Tags: HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME,
 HR_CTE_8B
 HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
 HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
 HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
 HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
 SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
 CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
 GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-O-RULE: Release_Ham
X-CID-RULE: NOTI_GNA5D1EA
X-CID-O-INFO: VERSION:1.3.12, REQID:65c31438-6a8e-4a12-b34e-617b446dbae7, IP:10,
 URL:0,TC:0,Content:-25,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,AC
 TION:release,TS:-40
X-CID-INFO: VERSION:1.3.12, REQID:65c31438-6a8e-4a12-b34e-617b446dbae7, IP:10,
 UR
 L:0,TC:0,Content:-25,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:NOTI_GNA5D1EA,AC
 TION:release,TS:-40
X-CID-META: VersionHash:e7bac3a, CLOUDID:8ae6d2712b7722388fb81af537c53573,
 BulkI
 D:260731111400O3L16FC2,BulkQuantity:0,Recheck:0,SF:10|66|78|81|82|102|127|
 850|865|898,TC:nil,Content:0|15|50,EDM:2,IP:-2,URL:0,File:nil,RT:nil,Bulk:
 nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,B
 RE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: decc98868c8d11f1aa26b74ffac11d73-20260731
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
 (envelope-from <sunshaojie@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1584503470; Fri, 31 Jul 2026 11:13:58 +0800
From: Shaojie Sun <sunshaojie@kylinos.cn>
To: ltp@lists.linux.it
Date: Fri, 31 Jul 2026 11:13:40 +0800
Message-Id: <20260731031343.1298712-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260730122521.1218460-2-sunshaojie@kylinos.cn>
References: <20260730122521.1218460-2-sunshaojie@kylinos.cn>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/3] Add CPU cgroup v2 tests ported from kselftest
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
Content-Type: multipart/mixed; boundary="===============1999574326=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1999574326==
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

This series ports the CPU cgroup v2 tests from the kernel selftests
(tools/testing/selftests/cgroup/test_cpu.c) to LTP, including tests
for subtree control, cpu.stat, nice, weight, and cpu.max.

The LTP tree already contains kselftest conversions for memcg
(memcontrol01-04), ported by Richard Palethorpe. This series follows
the same pattern to complete the CPU cgroup coverage.

Regarding the concern about kselftest conversion: the CPU cgroup
interfaces tested here (cpu.stat, cpu.weight, cpu.max) are stable
kernel ABIs that change very rarely. LTP's cgroup infrastructure
provides advantages over the raw kselftest helpers — automatic v1/v2
detection, safe file operations with proper error handling, automatic
cleanup, and integration with the LTP test result framework. Bringing
these tests into LTP also gives them broader CI coverage, as many
distributions run LTP but not kselftest.

Richard Palethorpe is listed in the copyright because the test
structure and common helper (cgroup_cpu_common.h) are modeled after
his memcontrol kselftest conversions (memcontrol01-04). The CPU
cgroup tests themselves were written by the patch author.

Patch 1 adds the necessary cgroup file entries (cpu.stat, cpu.weight)
to the LTP cgroup library.
Patch 2 adds the test source files and build infrastructure.
Patch 3 registers the new tests in runtest/controllers.

v3:
- Removed unnecessary braces around single-statement if blocks in
  cleanup() functions in cgroup_cpu02.c and cgroup_cpu03.c
- Added blank lines after declarations in test functions in
  cgroup_cpu02.c and cgroup_cpu03.c

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


--===============1999574326==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1999574326==--
