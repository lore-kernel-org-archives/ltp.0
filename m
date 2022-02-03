Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C83C433F5
	for <ltp@archiver.kernel.org>; Thu,  3 Feb 2022 08:19:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B2A83C8F8A
	for <ltp@archiver.kernel.org>; Thu,  3 Feb 2022 09:19:45 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 160F63C8F8A
 for <ltp@lists.linux.it>; Thu,  3 Feb 2022 09:19:14 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 930071000CE0
 for <ltp@lists.linux.it>; Thu,  3 Feb 2022 09:19:14 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 0E7751F3A5;
 Thu,  3 Feb 2022 08:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1643876354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8SAG8HBXpsbufWgzHVjZDhIxNLatnQJ2OJj3o9pL1uU=;
 b=JwVWvMgWIU6pijWCu5WAFK0RqqH72+80vt8c47K8dMM4dNiA2epHYBYCClnZWgSNxWXXmr
 dfPlaAQdjv2t3VjofaxKwcEpHbqmrVodY7h5WsvQqI80oFnZm1WgPSEUZSccNel8IKKdmt
 EIsl691kU2WxPm79x9ODMUCX1PNGwt8=
Received: from g78.suse.de (unknown [10.163.24.138])
 by relay2.suse.de (Postfix) with ESMTP id C8F96A3B81;
 Thu,  3 Feb 2022 08:19:13 +0000 (UTC)
To: ltp@lists.linux.it
Date: Thu,  3 Feb 2022 08:18:17 +0000
Message-Id: <20220203081820.29521-4-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220203081820.29521-1-rpalethorpe@suse.com>
References: <20220203081820.29521-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/5] API/cgroup: Add memory.min
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
 lib/tst_cgroup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index e694d353b..d9cd6aa8e 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -160,6 +160,7 @@ static const struct cgroup_file cgroup_ctrl_files[] = {
 
 static const struct cgroup_file memory_ctrl_files[] = {
 	{ "memory.current", "memory.usage_in_bytes", CTRL_MEMORY },
+	{ "memory.min", NULL, CTRL_MEMORY },
 	{ "memory.max", "memory.limit_in_bytes", CTRL_MEMORY },
 	{ "memory.stat", "memory.stat", CTRL_MEMORY },
 	{ "memory.swappiness", "memory.swappiness", CTRL_MEMORY },
@@ -896,7 +897,7 @@ tst_cgroup_group_mk(const struct tst_cgroup_group *const parent,
 
 	for_each_dir(parent, 0, dir) {
 		new_dir = SAFE_MALLOC(sizeof(*new_dir));
-		cgroup_dir_mk(*dir, group_name, new_dir);
+		cgroup_dir_mk(*dir, cg->group_name, new_dir);
 		cgroup_group_add_dir(parent, cg, new_dir);
 	}
 
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
