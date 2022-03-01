Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899FBC433F5
	for <ltp@archiver.kernel.org>; Tue,  1 Mar 2022 09:16:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 123B23CA2EE
	for <ltp@archiver.kernel.org>; Tue,  1 Mar 2022 10:16:39 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 83F863CA2EC
 for <ltp@lists.linux.it>; Tue,  1 Mar 2022 10:15:24 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 166DD1400BC9
 for <ltp@lists.linux.it>; Tue,  1 Mar 2022 10:15:24 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B2F9F1F3A8;
 Tue,  1 Mar 2022 09:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1646126123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W2EVAAATpdwiOm9lBKLfQh8wLJPawPrc5VqApkuahc8=;
 b=uXDlvqHY9hksjFswBRThIWApiWyu3fO9BkciCc+9H9XZ04mjmmeDYBRqMrQ219jYNyfJ/Q
 P3J2yVjxlzywFXClI2ESPs+eFP/byeGsAOOEB3B4S4hSlGNwkNkCHYsEdezI69G3BgNH57
 CZeflZXvYmLgljZcqNJqvFoPVQeTJLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1646126123;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W2EVAAATpdwiOm9lBKLfQh8wLJPawPrc5VqApkuahc8=;
 b=WTrMeXudfaGCZlaMW4HSTzbM1eyQBqW5Fnjn3LwWIA0Vn2bkzSLSX3PKR9yvh8tILscC0v
 PzcqhPFYx/M5JCAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4851413B08;
 Tue,  1 Mar 2022 09:15:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wBegCivkHWJ3VwAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Tue, 01 Mar 2022 09:15:23 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Tue,  1 Mar 2022 10:15:17 +0100
Message-Id: <20220301091517.11142-7-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220301091517.11142-1-andrea.cervesato@suse.de>
References: <20220301091517.11142-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 6/6] Removed libclone usage from mountns testing
 suite
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
 testcases/kernel/containers/mountns/Makefile | 21 +++-----------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/testcases/kernel/containers/mountns/Makefile b/testcases/kernel/containers/mountns/Makefile
index bd42bf41b..16284f4d5 100644
--- a/testcases/kernel/containers/mountns/Makefile
+++ b/testcases/kernel/containers/mountns/Makefile
@@ -1,23 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2014 Red Hat, Inc.
-#
-# This program is free software: you can redistribute it and/or modify
-# it under the terms of version 2 the GNU General Public License as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program.  If not, see <http://www.gnu.org/licenses/>.
-##############################################################################
+# Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
 
-top_srcdir              ?= ../../../..
+top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
-include $(abs_srcdir)/../Makefile.inc
-
-LDLIBS                  := -lclone $(LDLIBS)
-
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
