Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E1BFC4332F
	for <ltp@archiver.kernel.org>; Tue, 23 Nov 2021 12:44:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A94303C8E0F
	for <ltp@archiver.kernel.org>; Tue, 23 Nov 2021 13:44:17 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 28CCF3C25EC
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 13:43:58 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 888A1201035
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 13:43:57 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 19E3521941;
 Tue, 23 Nov 2021 12:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1637671437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JkHiavZHfrfT9GLkF9HNW67pPaee44KSsm2PInGMSN8=;
 b=Nvp4UDwvpwBmKN3T8EvxBBr1u73KpaxpvtEieldMr2yV+MQcgxaKMRxjCd5uiBdhdYXfaw
 6qIuGIlqU8EPj9lpyBgjztAfwYXcl+bH/GcXACyuWyD02o9z+K8kfuBOamvEj/sBjcYRMP
 qrf1+7bSTouBfWmOUpJBH7mYEfheG2w=
Received: from g78.suse.de (unknown [10.163.24.38])
 by relay2.suse.de (Postfix) with ESMTP id DF97FA3B88;
 Tue, 23 Nov 2021 12:43:56 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 23 Nov 2021 12:43:47 +0000
Message-Id: <20211123124348.31073-3-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211123124348.31073-1-rpalethorpe@suse.com>
References: <20211123124348.31073-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] doc: Add LTP-003 and LTP-004 static and tst API
 prefix rules
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 doc/library-api-writing-guidelines.txt | 10 ++++++++++
 doc/rules.tsv                          |  2 ++
 doc/test-writing-guidelines.txt        |  8 ++++++++
 3 files changed, 20 insertions(+)

diff --git a/doc/library-api-writing-guidelines.txt b/doc/library-api-writing-guidelines.txt
index 2819d4177..c82053681 100644
--- a/doc/library-api-writing-guidelines.txt
+++ b/doc/library-api-writing-guidelines.txt
@@ -39,6 +39,16 @@ The macros which are clearly intended to update these variables. That
 is +TEST+ and those in 'tst_test_macros.h'. Are of course allowed to
 update these variables.
 
+2.3 LTP-003: Externally visible library symbols have the tst_ prefix
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Functions, types and variables in the public test API should have the
+tst_ prefix. With some exceptions for symbols already prefixed with
+safe_ or ltp_.
+
+Static (private) symbols should not have the prefix.
+
+
 3. Shell API
 ------------
 
diff --git a/doc/rules.tsv b/doc/rules.tsv
index d4081ce0f..2dfeca9f9 100644
--- a/doc/rules.tsv
+++ b/doc/rules.tsv
@@ -1,3 +1,5 @@
 ID	DESCRIPTION
 LTP-001	Library source files have tst_ prefix
 LTP-002	TST_RET and TST_ERR are never modified by test library functions
+LTP-003 Externally visible library symbols have the tst_ prefix
+LTP-004 Test executable symbols are marked static
diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index b87446d1b..98fdb4d8d 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -133,6 +133,14 @@ script from kernel git tree.
 NOTE: If `make check` does not report any problems, the code still may be wrong
       as all tools used for checking only look for common mistakes.
 
+2.1.1 LTP-004: Test executable symbols are marked static
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Test executables should not export symbols unecessarily. This means
+that all top-level variables and functions should be marked with the
+static keyword. The only visible symbols should be those included from
+shared object files.
+
 2.2 Shell coding style
 ^^^^^^^^^^^^^^^^^^^^^^
 
-- 
2.33.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
