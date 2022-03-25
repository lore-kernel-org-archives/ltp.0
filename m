Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C53C433EF
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 09:37:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE5EE3C54E4
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 10:37:48 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5BCF73C0595
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 10:36:31 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9BE58200DC9
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 10:36:30 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4DF4D210FD;
 Fri, 25 Mar 2022 09:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1648200990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bV1bPdjdiU5V7L8xVkjhNHqRNcqiEx8b05/Ma4Ju76U=;
 b=eCebDj0ZTqQo6PB4suhHs8VsTffcawEz0Xa6WLQAMhmcnZ4cHQq0jZp2wLKXwUHyyxM7XD
 P+ESyqkAMTVj3e8THeUGNaWdG26njavdC9Z3xVk+MOY8hdf9ChmoREXLreX/3jnCnBTz/7
 8LFLRFB6ARd9z9GraDUGP3Jy3yAslTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1648200990;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bV1bPdjdiU5V7L8xVkjhNHqRNcqiEx8b05/Ma4Ju76U=;
 b=D5P5BCK8uI5rylS7goyHdzwg1sDbhQpPfmnpiUqES2GLyBXPHRaTITuTl8/S5eAgBM+4pE
 AVVcdD3RqAao0eAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 226BA132E9;
 Fri, 25 Mar 2022 09:36:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WFoWBR6NPWI1BQAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Fri, 25 Mar 2022 09:36:30 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri, 25 Mar 2022 10:36:25 +0100
Message-Id: <20220325093626.11114-9-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325093626.11114-1-andrea.cervesato@suse.de>
References: <20220325093626.11114-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 8/9] Remove libclone dependency from userns suite
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
