Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67ACFC433EF
	for <ltp@archiver.kernel.org>; Mon, 28 Feb 2022 13:34:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C80D13CA262
	for <ltp@archiver.kernel.org>; Mon, 28 Feb 2022 14:34:11 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B48303C9ED2
 for <ltp@lists.linux.it>; Mon, 28 Feb 2022 14:33:01 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 33EEC600C30
 for <ltp@lists.linux.it>; Mon, 28 Feb 2022 14:33:01 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CE6AD1F8A4;
 Mon, 28 Feb 2022 13:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1646055180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W2EVAAATpdwiOm9lBKLfQh8wLJPawPrc5VqApkuahc8=;
 b=Sj0AQglZgYLQqU3HjIVv23qTPPROXEyju5Q+CxC7wijH7lDBPJs84HG/tqm2z+VVZc96Lk
 GQw3cTuK5ITuHQX0gKMzUxcnZkumpy/Z4lVFrEuxvbDO/oZOapOGCY42DlvGPHtGzdnlBU
 pFpQSeYiULEviwq36k1qkNGfE0G2+LY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1646055180;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W2EVAAATpdwiOm9lBKLfQh8wLJPawPrc5VqApkuahc8=;
 b=1/TNG5KqKNZvYZfi8jvMjwCouseo/s5CLj9mPMHIlqaEd0ixoOY3Kp3+sdT6jFI5JLlOSs
 O+pRyPWme3E++VDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9CBE513C29;
 Mon, 28 Feb 2022 13:33:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mKWoIwzPHGKhRQAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Mon, 28 Feb 2022 13:33:00 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Mon, 28 Feb 2022 14:32:56 +0100
Message-Id: <20220228133256.12763-7-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220228133256.12763-1-andrea.cervesato@suse.de>
References: <20220228133256.12763-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 6/6] Removed libclone usage from mountns testing
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
