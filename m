Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C83C433EF
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 14:04:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C3EC3C9B69
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 15:04:04 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 93F6E3C9880
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 15:03:45 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EC4AB1400978
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 15:03:44 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 5B4AB210FB;
 Tue,  8 Feb 2022 14:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1644329024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B4BA2QvozvsR/j53K2ibkFO7Z/Cb8rK2G9cIIk9kfiA=;
 b=mBs7y3jWsJzpk6x0s3W35Vw+Y3qm7EZtCuwteD8tRMuB54cGdkolVD5oev6a+FDAhWfPx6
 IZyjsNfzjh/1N4sM5Ly9pqFLufAWgQz54+GdjHmBys6UVBAcuUhDF0HZxOPlb0UA50ypWJ
 aPZfkw0fcB3yex//GpB7O7u8lMYZ4RQ=
Received: from g78.suse.de (unknown [10.163.24.138])
 by relay2.suse.de (Postfix) with ESMTP id 224ABA3B98;
 Tue,  8 Feb 2022 14:03:44 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue,  8 Feb 2022 14:03:20 +0000
Message-Id: <20220208140322.6842-2-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208140322.6842-1-rpalethorpe@suse.com>
References: <20220208140322.6842-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] API/cgroup: Add memory.{events, low}
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
 lib/tst_cgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 93d374c56..4d326c730 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -159,6 +159,8 @@ static const struct cgroup_file cgroup_ctrl_files[] = {
 
 static const struct cgroup_file memory_ctrl_files[] = {
 	{ "memory.current", "memory.usage_in_bytes", CTRL_MEMORY },
+	{ "memory.events", NULL, CTRL_MEMORY },
+	{ "memory.low", NULL, CTRL_MEMORY },
 	{ "memory.min", NULL, CTRL_MEMORY },
 	{ "memory.max", "memory.limit_in_bytes", CTRL_MEMORY },
 	{ "memory.stat", "memory.stat", CTRL_MEMORY },
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
