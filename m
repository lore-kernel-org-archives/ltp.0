Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DF9C4167B
	for <ltp@archiver.kernel.org>; Mon,  4 Dec 2023 18:48:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C92D3CFB5D
	for <ltp@archiver.kernel.org>; Mon,  4 Dec 2023 19:48:44 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 41A733CC7B1
 for <ltp@lists.linux.it>; Mon,  4 Dec 2023 19:48:34 +0100 (CET)
Received: from 66-220-144-179.mail-mxout.facebook.com
 (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5B8901401216
 for <ltp@lists.linux.it>; Mon,  4 Dec 2023 19:48:33 +0100 (CET)
Received: by devbig1114.prn1.facebook.com (Postfix, from userid 425415)
 id 0AF39105A5B32; Mon,  4 Dec 2023 10:48:20 -0800 (PST)
From: Stefan Roesch <shr@devkernel.io>
To: kernel-team@fb.com
Date: Mon,  4 Dec 2023 10:48:15 -0800
Message-Id: <20231204184817.3570465-1-shr@devkernel.io>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] KSM: support smart-scan feature
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
Cc: linux-mm@kvack.org, david@redhat.com, oliver.sang@intel.com,
 shr@devkernel.io, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This patch series makes two changes:
- Disable the smart-scan feature for ksm01 - ksm04
  This is necessary to make sure that the volatile metrics have the
  expected counts.
- Add a new test for the smart-scan feature
  The new test verifies that the smart-scan feature skips pages when it has
  been enabled for a VMA.

Versions:
- V3:
  - Disable smart scan for ksm05 and ksm06
  - add ksm07 to runtest/mm
  - change documentation format in header of ksm07.c
  - Move function create_memory_for_smartscan() to ksm07.c
  - Rename create_memory_for_smartscan() to create_memory()
  
- V2:
  - Disable smart_scan in the test setup structure
  - Remove the changes in create_same_memory()
  - Add the new testcase ksm07 for the smart scan test
  

Stefan Roesch (2):
  mem: disable KSM smart scan for ksm tests
  add ksm test for smart-scan feature

 runtest/mm                       |   1 +
 testcases/kernel/mem/.gitignore  |   1 +
 testcases/kernel/mem/ksm/ksm01.c |   2 +
 testcases/kernel/mem/ksm/ksm02.c |   2 +
 testcases/kernel/mem/ksm/ksm03.c |   2 +
 testcases/kernel/mem/ksm/ksm04.c |   2 +
 testcases/kernel/mem/ksm/ksm05.c |   2 +
 testcases/kernel/mem/ksm/ksm06.c |   2 +
 testcases/kernel/mem/ksm/ksm07.c | 131 +++++++++++++++++++++++++++++++
 9 files changed, 145 insertions(+)
 create mode 100644 testcases/kernel/mem/ksm/ksm07.c


base-commit: 8c89ef3d451087ed6e18750bd5eedd10e5ab3d2e
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
