Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A6DC433EF
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 13:30:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5DF883C9345
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 14:30:05 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A11B13C91EA
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 14:29:54 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1883E60122E
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 14:29:53 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5FA7821112;
 Tue, 15 Mar 2022 13:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647350993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YxtYJbPHTcJQMjmUaz0GCQ0CD1pbFYwPADgvDt/0NbU=;
 b=1x95SjEPJPBNVkIY89XYbSZN+XdCo13EXDcHGPaY1MJa/vFHl6Q1LaUr5DQve7k/o+IUeo
 KPkULm5rSE3tJGxPLgEIz7+aqENTPbE1rrRHTvEBWp2SDoH2OoV0uK66cdnj2ZM5Ugk3/j
 3QugXf2A5b8Ic+BWmJQIQOVg4pkbhJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647350993;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YxtYJbPHTcJQMjmUaz0GCQ0CD1pbFYwPADgvDt/0NbU=;
 b=x4gFbU0tQ96Sq3TyeEd2kVUvvDT9Q7UMjziXuiPox+s7Ct2syjoWX2IrUG2nnxp/76pDG1
 8FKr/AKT1vUKYNAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 23BA913B4E;
 Tue, 15 Mar 2022 13:29:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id q8qyBtGUMGIYbQAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Tue, 15 Mar 2022 13:29:53 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Tue, 15 Mar 2022 14:29:51 +0100
Message-Id: <20220315132951.26787-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220315122351.8556-2-andrea.cervesato@suse.de>
References: <20220315122351.8556-2-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] Remove libclone from userns test suite
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
---
This patch goes after [PATCH v2 8/8] Rewrite userns08.c using new LTP API

 testcases/kernel/containers/userns/Makefile | 23 ++++-----------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/testcases/kernel/containers/userns/Makefile b/testcases/kernel/containers/userns/Makefile
index 80681096d..c1f10de20 100644
--- a/testcases/kernel/containers/userns/Makefile
+++ b/testcases/kernel/containers/userns/Makefile
@@ -1,26 +1,11 @@
-###############################################################################
-#                                                                            ##
-# Copyright (c) Huawei Technologies Co., Ltd., 2015                          ##
-#                                                                            ##
-# This program is free software;  you can redistribute it and#or modify      ##
-# it under the terms of the GNU General Public License as published by       ##
-# the Free Software Foundation; either version 2 of the License, or          ##
-# (at your option) any later version.                                        ##
-#                                                                            ##
-# This program is distributed in the hope that it will be useful, but        ##
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-# for more details.                                                          ##
-#                                                                            ##
-# You should have received a copy of the GNU General Public License          ##
-# along with this program.                                                   ##
-###############################################################################
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Huawei Technologies Co., Ltd., 2015
+# Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
 
 top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
-include $(abs_srcdir)/../Makefile.inc
 
-LDLIBS			:= -lclone $(LDLIBS) $(CAP_LIBS)
+LDLIBS  := $(CAP_LIBS) $(LDLIBS)
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
