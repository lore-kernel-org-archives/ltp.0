Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC1FC433F5
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 11:00:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53FCF3C6D8F
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 12:00:58 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F24DC3C1BAE
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 11:59:23 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8D3BF600E39
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 11:59:23 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 287E21F381;
 Thu, 10 Mar 2022 10:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1646909963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YgZZfRuNwaWkyXn1kXDvw+UKSPHvnW0AhEgQf13kXZA=;
 b=MXxnXXYFs1xW3Q+IRc1kGOsZkqzk9myEHWIHaouzOWLgY71KPSk4PP+sTAfJnIOZm0YBzO
 g947Z6wLD1HHwiHox6lOXs0BVyrxPXC45mX1J2dUAYLepp2kI7TfSWIbWJ5XUlrUrMY60o
 oPJCfxDPj3TjZRMKlQ6IjjuzfIdk4nA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1646909963;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YgZZfRuNwaWkyXn1kXDvw+UKSPHvnW0AhEgQf13kXZA=;
 b=FjGoNdZO4U9AFY0Gj2tw9W04/lDAkaJBahLRyceddi3d2cd1FCSzsaYyXgvJjcL7lIS5+d
 nrIh1cA+3YULlXDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 02E5213FA5;
 Thu, 10 Mar 2022 10:59:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eDBjOgraKWK8fgAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Thu, 10 Mar 2022 10:59:22 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu, 10 Mar 2022 11:59:15 +0100
Message-Id: <20220310105916.7960-10-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310105916.7960-1-andrea.cervesato@suse.de>
References: <20220310105916.7960-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 09/10] Remove libclone dependency from sysvipc
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
 testcases/kernel/containers/sysvipc/Makefile | 26 +++-----------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/testcases/kernel/containers/sysvipc/Makefile b/testcases/kernel/containers/sysvipc/Makefile
index 00b537f6a..426fe5292 100644
--- a/testcases/kernel/containers/sysvipc/Makefile
+++ b/testcases/kernel/containers/sysvipc/Makefile
@@ -1,28 +1,8 @@
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2007                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-################################################################################
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2007
+# Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
 
 top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
-include $(abs_srcdir)/../Makefile.inc
-
-LDLIBS			:= -lclone $(LDLIBS)
-
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
