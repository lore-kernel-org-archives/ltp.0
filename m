Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 043E2C531D0
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 06:35:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 189583E4B97
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 08:35:17 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B23C83E4F01
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 05:29:39 +0200 (CEST)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2ED866006E5
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 05:29:35 +0200 (CEST)
X-UUID: dd417d468bc611f1aa26b74ffac11d73-20260730
X-CTIC-Tags: HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME,
 HR_CTE_8B
 HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
 HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
 HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
 HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
 SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:df9d2ea4-67d9-47ce-b162-14797e72a192, IP:10,
 URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:5
X-CID-INFO: VERSION:1.3.12, REQID:df9d2ea4-67d9-47ce-b162-14797e72a192, IP:10,
 UR
 L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:5
X-CID-META: VersionHash:e7bac3a, CLOUDID:38ffa45f8fcdf6c792d497fcdfa28a85,
 BulkI
 D:260730112930GIQ6BU59,BulkQuantity:0,Recheck:0,SF:10|66|78|102|127|850|86
 5|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,Q
 S:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,
 ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: dd417d468bc611f1aa26b74ffac11d73-20260730
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
 (envelope-from <sunshaojie@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1906867797; Thu, 30 Jul 2026 11:29:25 +0800
From: Shaojie Sun <sunshaojie@kylinos.cn>
To: ltp@lists.linux.it
Date: Thu, 30 Jul 2026 11:28:47 +0800
Message-Id: <20260730032850.775128-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 30 Jul 2026 08:34:47 +0200
Subject: [LTP] [PATCH 0/3] Add CPU cgroup v2 tests ported from kselftest
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

Shaojie Sun (3):
  tst_cgroup: add cpu.stat and cpu.weight to cgroup file table
  cgroup: add CPU cgroup v2 tests ported from kselftest
  runtest/controllers: add CPU cgroup v2 test entries

 lib/tst_cgroup.c                              |   2 +
 runtest/controllers                           |   5 +
 testcases/kernel/controllers/cpu/.gitignore   |   5 +
 testcases/kernel/controllers/cpu/Makefile     |   9 +
 .../kernel/controllers/cpu/cgroup_cpu01.c     |  65 ++++
 .../kernel/controllers/cpu/cgroup_cpu02.c     | 104 ++++++
 .../kernel/controllers/cpu/cgroup_cpu03.c     | 116 ++++++
 .../kernel/controllers/cpu/cgroup_cpu04.c     | 346 ++++++++++++++++++
 .../kernel/controllers/cpu/cgroup_cpu05.c     | 175 +++++++++
 .../controllers/cpu/cgroup_cpu_common.h       | 130 +++++++
 10 files changed, 957 insertions(+)
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
