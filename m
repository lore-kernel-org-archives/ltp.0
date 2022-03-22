Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6273BC433EF
	for <ltp@archiver.kernel.org>; Tue, 22 Mar 2022 09:47:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 766733C8796
	for <ltp@archiver.kernel.org>; Tue, 22 Mar 2022 10:47:30 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 851223C72F7
 for <ltp@lists.linux.it>; Tue, 22 Mar 2022 10:47:10 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5C0B1600077
 for <ltp@lists.linux.it>; Tue, 22 Mar 2022 10:47:09 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A9717210F3;
 Tue, 22 Mar 2022 09:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647942428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CfJtlBjwggGwotvSKQjLBkLRcV3LvEdLvq4Qpy7u1wk=;
 b=aAlzh+OaCkuzYKKF72XDZKbYQ1mTQ34QgYvqf+JOLQ+c3a7qudnqNebubcaILHpa2vwyQT
 gvznW0liE8aloBUhFWbIwJlT0NoeWBYapCFbxbuAUA+CRNTQbBv9dHpixu2JmVaFLqmPBF
 w5UgMiYjxqL8H/yQvpZeMUJMscWN8vA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647942428;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CfJtlBjwggGwotvSKQjLBkLRcV3LvEdLvq4Qpy7u1wk=;
 b=gTnFcQ7c3tkK993Z0n1IDzBlui57qhiVqXrSiLjWkX+Oquqo84kXfxxXhEe8iBrrkTqi2l
 0XSJYmUO3A38ZxCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7CAB912FC5;
 Tue, 22 Mar 2022 09:47:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8N81HRybOWKUFQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 22 Mar 2022 09:47:08 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 22 Mar 2022 10:47:04 +0100
Message-Id: <20220322094704.16935-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322094704.16935-1-pvorel@suse.cz>
References: <20220322094704.16935-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] nfs01_open_files: Add SPDX, copyright
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/nfs/nfs_stress/nfs01_open_files.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/network/nfs/nfs_stress/nfs01_open_files.c b/testcases/network/nfs/nfs_stress/nfs01_open_files.c
index 0a4732859e..678d7a9ecf 100644
--- a/testcases/network/nfs/nfs_stress/nfs01_open_files.c
+++ b/testcases/network/nfs/nfs_stress/nfs01_open_files.c
@@ -1,3 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Linux Test Project, 2001-2022
+ */
+
 #include <stdio.h>
 #include <errno.h>
 #include <stdarg.h>
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
