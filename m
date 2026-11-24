Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E465606A32A
	for <ltp@archiver.kernel.org>; Tue, 24 Nov 2026 09:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WfhiwyAO
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E470C3E9163
	for <ltp@archiver.kernel.org>; Tue, 24 Nov 2026 10:07:17 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C5ED3E91C1
 for <ltp@lists.linux.it>; Tue, 24 Nov 2026 10:06:51 +0100 (CET)
Received: from mta1.migadu.com (out-26.mta1.migadu.com [95.215.58.26])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B8FF610007CC
 for <ltp@lists.linux.it>; Tue, 24 Nov 2026 10:06:50 +0100 (CET)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=zbXh/0gkpCzgQT87B/F5RYK2w93JDM0IqHnpcM/PBi0=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795511210; v=1; x=1796116010;
 b=WfhiwyAOs2Mee73zSBZ0gG9M9x7K0bQv+f/t8uCthBAeOOuIP8XJeOYPHjOcN7rKGjyDLA+Q
 oJFrHNVULlmJ/+9Nffu2jbieqf/eo6zuXX7gN7JEH+Kskc542mNIYyPZ+3dfdcDJx4Tk5DlfoQf
 Y7rxcEaQSDkyXY7OVMhtVfXs=
X-Envelope-To: ltp@lists.linux.it
Received: by mta12.migadu.com with ESMTPS id 7a866069d89509fb;
 Tue, 24 Nov 2026 09:06:50 +0000
X-Mizu-Trace-ID: 7a866069d89509fb
X-Migadu-Flow: FLOW_OUT
From: "Li Wang (Hieco)" <li.wang@linux.dev>
To: ltp@lists.linux.it
Date: Tue, 24 Nov 2026 17:06:31 +0800
Message-ID: <20261124090633.840656-2-li.wang@linux.dev>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124090633.840656-1-li.wang@linux.dev>
References: <20261124090633.840656-1-li.wang@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/3] build: Fix library prerequisites in
 testcases.mk
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Fix LTPLIBS_FILES to match the actual libltp<name>.a archive names and
only mark them .PHONY when MAKELEVEL == 0 so recursive leaf sub-makes
do not redundantly rebuild them in parallel.

Also make directory prerequisites order-only so directory mtime updates
do not trigger unnecessary archive rebuilds.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
Signed-off-by: Li Wang (Hieco) <li.wang@linux.dev>
Reviewed-by: Li Wang (Hieco) <li.wang@linux.dev>
---
 include/mk/testcases.mk         | 14 ++++++++------
 testcases/kernel/include/lib.mk |  4 ++--
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/mk/testcases.mk b/include/mk/testcases.mk
index 2609535ce..5960d7485 100644
--- a/include/mk/testcases.mk
+++ b/include/mk/testcases.mk
@@ -12,11 +12,11 @@ LIBLTP_DIR	:= $(abs_top_builddir)/lib
 
 LIBLTP		:= $(LIBLTP_DIR)/libltp.a
 
-$(APICMDS_DIR)/tst_kvercmp: $(APICMDS_DIR)
-	$(MAKE) -C "$^" -f "$(abs_top_srcdir)/tools/apicmds/Makefile" all
+$(APICMDS_DIR)/tst_kvercmp: | $(APICMDS_DIR)
+	$(MAKE) -C "$(APICMDS_DIR)" -f "$(abs_top_srcdir)/tools/apicmds/Makefile" all
 
-$(LIBLTP): $(LIBLTP_DIR)
-	$(MAKE) -C "$^" -f "$(abs_top_srcdir)/lib/Makefile" all
+$(LIBLTP): | $(LIBLTP_DIR)
+	$(MAKE) -C "$(LIBLTP_DIR)" -f "$(abs_top_srcdir)/lib/Makefile" all
 
 MAKE_DEPS	:= $(LIBLTP)
 
@@ -27,13 +27,15 @@ LDLIBS		+= -lltp
 ifdef LTPLIBS
 
 LTPLIBS_DIRS = $(addprefix $(abs_top_builddir)/libs/, $(LTPLIBS))
-LTPLIBS_FILES = $(addsuffix .a, $(addprefix $(abs_top_builddir)/libs/, $(foreach LIB,$(LTPLIBS),$(LIB)/lib$(LIB))))
+LTPLIBS_FILES = $(addsuffix .a, $(addprefix $(abs_top_builddir)/libs/, $(foreach LIB,$(LTPLIBS),$(LIB)/libltp$(LIB))))
 
 MAKE_DEPS += $(LTPLIBS_FILES)
 
+ifeq ($(MAKELEVEL),0)
 .PHONY: $(LTPLIBS_FILES)
+endif
 
-$(LTPLIBS_FILES): $(LTPLIBS_DIRS)
+$(LTPLIBS_FILES): | $(LTPLIBS_DIRS)
 
 $(LTPLIBS_FILES): %:
 ifdef VERBOSE
diff --git a/testcases/kernel/include/lib.mk b/testcases/kernel/include/lib.mk
index 40a09b77e..c1a0c6d52 100644
--- a/testcases/kernel/include/lib.mk
+++ b/testcases/kernel/include/lib.mk
@@ -29,8 +29,8 @@ LDFLAGS			+= -L$(LIBKERNTEST_DIR)
 $(LIBKERNTEST_DIR):
 	mkdir -p "$@"
 
-$(LIBKERNTEST): $(LIBKERNTEST_DIR)
-	$(MAKE) -C $^ -f "$(LIBKERNTEST_SRCDIR)/Makefile" all
+$(LIBKERNTEST): | $(LIBKERNTEST_DIR)
+	$(MAKE) -C "$(LIBKERNTEST_DIR)" -f "$(LIBKERNTEST_SRCDIR)/Makefile" all
 
 MAKE_DEPS		+= $(LIBKERNTEST)
 
-- 
2.56.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
