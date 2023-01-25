Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC13C27C76
	for <ltp@archiver.kernel.org>; Wed, 25 Jan 2023 22:27:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9473D3CC761
	for <ltp@archiver.kernel.org>; Wed, 25 Jan 2023 23:27:18 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 471E43CC753
 for <ltp@lists.linux.it>; Wed, 25 Jan 2023 23:27:08 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5895510006CD
 for <ltp@lists.linux.it>; Wed, 25 Jan 2023 23:27:07 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6F16C21CD7;
 Wed, 25 Jan 2023 22:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1674685627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KSvJP4m8FE1Lee36KZQu3HS0DNslsqw/ccxTaJ9t1dQ=;
 b=Mr+90ucWVmBJqWvsY0zjvUnFLIOkdBeg8taL/YnAWlwRUZ4rTnJaAS/7Zg6Oslq8Op8ltd
 iFKiF4Qo7cJqWAv/wMoGC7C8i8a26Ycxq6ydGUEeGRUxU4bkB8SE8AZz/5Kow25+QaWRn+
 TJ2qmVY6tB7yXAqULMWLhbMJnM6q+Pc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1674685627;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KSvJP4m8FE1Lee36KZQu3HS0DNslsqw/ccxTaJ9t1dQ=;
 b=bfQD8/aEh5Ziy249PVml35pVrif9bgBMdqD8PIfWqFNaTF53yJuSah+JtAeOhLgKpM22Mo
 7LGke43VhIj2isCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 395941339E;
 Wed, 25 Jan 2023 22:27:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4PV8DLus0WPoNgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 25 Jan 2023 22:27:07 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 25 Jan 2023 23:27:02 +0100
Message-Id: <20230125222703.19943-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125222703.19943-1-pvorel@suse.cz>
References: <20230125222703.19943-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] hugemmap15: Compile with -O
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

-O0 originally used causes warning on gcc 12:

In file included from /usr/include/bits/libc-header-start.h:33,
                 from /usr/include/stdio.h:27,
                 from hugemmap15.c:22:
/usr/include/features.h:412:4: warning: #warning _FORTIFY_SOURCE requires compiling with optimization (-O) [-Wcpp]
  412 | #  warning _FORTIFY_SOURCE requires compiling with optimization (-O)

Fixes: 15625f6185 ("Hugetlb: Migrating libhugetlbfs icache-hygiene")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/mem/hugetlb/hugemmap/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/Makefile b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
index 6f10807cde..503a35f7f1 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/Makefile
+++ b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
@@ -8,5 +8,5 @@ include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
-hugemmap15: CFLAGS+=-O0
+hugemmap15: CFLAGS+=-O
 hugemmap06: CFLAGS+=-pthread
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
