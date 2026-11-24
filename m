Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093D0606A321
	for <ltp@archiver.kernel.org>; Tue, 24 Nov 2026 09:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=N976Q0bb
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE7E53E9167
	for <ltp@archiver.kernel.org>; Tue, 24 Nov 2026 10:07:03 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E488A3C9D7E
 for <ltp@lists.linux.it>; Tue, 24 Nov 2026 10:06:48 +0100 (CET)
Received: from mta0.migadu.com (out-226.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::e2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BB0EF200161
 for <ltp@lists.linux.it>; Tue, 24 Nov 2026 10:06:47 +0100 (CET)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=Lz4CWZuIMPRHV2attBT4giUCYF//E4BfIGrsjiO5Wpg=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795511206; v=1; x=1796116006;
 b=N976Q0bbJDyj/l6Jb0F9BWBPxT3qAsybtn4TXhG45wDlYSEf5bA+3yi16dkUZiHDyck+LMx0
 k7lOdQf6z5B+FWIOM54bOaI6xbucp4Z9yjc9sOmbOa9dFdrFKb8i0pvisIRAlhNFi7vtte1QUAy
 cgCAumjauXewnx0FKjT+c5xw=
X-Envelope-To: ltp@lists.linux.it
Received: by mta12.migadu.com with ESMTPS id 308a4adc125f0a85;
 Tue, 24 Nov 2026 09:06:46 +0000
X-Mizu-Trace-ID: 308a4adc125f0a85
X-Migadu-Flow: FLOW_OUT
From: "Li Wang (Hieco)" <li.wang@linux.dev>
To: ltp@lists.linux.it
Date: Tue, 24 Nov 2026 17:06:30 +0800
Message-ID: <20261124090633.840656-1-li.wang@linux.dev>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/3] Speedup LTP compile time by ~20% on
 multi-machine
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The following results show how this optimization moves compile times
really far from what we have now. With a single threaded build, LTP
would take approximately 12 minutes to compile. With a multi-threaded
build on 16 CPUs, this drops down to ~46 seconds.

time make -j16

Executed in   45.96 secs    fish           external
   usr time  519.11 secs    0.24 millis  519.11 secs
   sys time  167.13 secs    1.08 millis  167.13 secs

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v4:
- Mark library targets .PHONY so library source changes are rebuilt
- Also build libkerntest.a when make is run from testcases/
- Remove the old $(LIBLTP) rule from testcases.mk (overriding recipe warning)
- Refactoring the patchset in clean code
- Link to v3: https://lore.kernel.org/all/20261021-build_system_optimize-v3-0-71a3c4c6f937@suse.com/

Changes in v3:
- added libs-all ordering to avoid races
- Link to v2: https://lore.kernel.org/20261020-build_system_optimize-v2-0-b527ac7cf835@suse.com

Changes in v2:
- fix build race condition
- Link to v1: https://lore.kernel.org/20261020-build_system_optimize-v1-1-744f9fa88908@suse.com

Andrea Cervesato (2):
  build: Fix library prerequisites in testcases.mk
  build: Build shared libraries once when make runs in testcases/

Li Wang (Hieco) (1):
  build: Recurse into trunk subdirectories in parallel

 Makefile                            |  2 ++
 include/mk/generic_leaf_target.inc  |  2 ++
 include/mk/generic_lib_deps.inc     | 34 ++++++++++++++++++++++++
 include/mk/generic_trunk_target.inc | 40 ++++++++++++++++++++++++-----
 include/mk/testcases.mk             | 15 +++++------
 testcases/kernel/Makefile           |  6 +++++
 testcases/kernel/include/lib.mk     |  6 +++--
 testcases/network/rpc/Makefile      |  5 ++++
 8 files changed, 93 insertions(+), 17 deletions(-)
 create mode 100644 include/mk/generic_lib_deps.inc

-- 
2.56.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
