Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7BE1C433EF
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 10:37:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C00A23C8CB3
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 11:37:08 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A42023C1351
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 11:36:59 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A819B600747
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 11:36:58 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 169FD212B5;
 Tue, 14 Dec 2021 10:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1639478218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=shAg4pHd9bj0Jg9EiTn6M8Xj03sM3sbpCyFv2gVX90I=;
 b=u/G6m+eLdtO+clbXdG8mKaQ1A0JgV/PRD5sjsyL3S+H0ufnfwumxL1rxk1MZvD0Rh7Wc9V
 ibAr/r5zEcFUZXUSG6p4WKQIvvHqdo6FdUwJGtfOzVlucqx15nwXvMudxlxlW/dz50v6oO
 rUgh7Bwosn5d6jRSLfQtb6ZHbxhAnpk=
Received: from g78.suse.de (unknown [10.163.24.42])
 by relay2.suse.de (Postfix) with ESMTP id D6C47A3B83;
 Tue, 14 Dec 2021 10:36:57 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 14 Dec 2021 10:36:42 +0000
Message-Id: <20211214103645.16148-2-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211214103645.16148-1-rpalethorpe@suse.com>
References: <20211214103645.16148-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/5] API/cgroup: Remove typedef
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

Angers make check and is not helpful anymore.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 lib/tst_cgroup.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 2dcfbc8ff..d9d74faa8 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -141,10 +141,7 @@ struct tst_cgroup_group {
 /* Always use first item for unified hierarchy */
 static struct cgroup_root roots[ROOTS_MAX + 1];
 
-/* Lookup tree for item names. */
-typedef struct cgroup_file files_t[];
-
-static const files_t cgroup_ctrl_files = {
+static const struct cgroup_file cgroup_ctrl_files[] = {
 	/* procs exists on V1, however it was read-only until kernel v3.0. */
 	{ "cgroup.procs", "tasks", 0 },
 	{ "cgroup.subtree_control", NULL, 0 },
@@ -152,7 +149,7 @@ static const files_t cgroup_ctrl_files = {
 	{ }
 };
 
-static const files_t memory_ctrl_files = {
+static const struct cgroup_file memory_ctrl_files[] = {
 	{ "memory.current", "memory.usage_in_bytes", CTRL_MEMORY },
 	{ "memory.max", "memory.limit_in_bytes", CTRL_MEMORY },
 	{ "memory.swappiness", "memory.swappiness", CTRL_MEMORY },
@@ -163,7 +160,7 @@ static const files_t memory_ctrl_files = {
 	{ }
 };
 
-static const files_t cpu_ctrl_files = {
+static const struct cgroup_file cpu_ctrl_files[] = {
 	/* The V1 quota and period files were combined in the V2 max
 	 * file. The quota is in the first column and if we just print
 	 * a single value to the file, it will be treated as the
@@ -175,13 +172,14 @@ static const files_t cpu_ctrl_files = {
 	{ }
 };
 
-static const files_t cpuset_ctrl_files = {
+static const struct cgroup_file cpuset_ctrl_files[] = {
 	{ "cpuset.cpus", "cpuset.cpus", CTRL_CPUSET },
 	{ "cpuset.mems", "cpuset.mems", CTRL_CPUSET },
 	{ "cpuset.memory_migrate", "cpuset.memory_migrate", CTRL_CPUSET },
 	{ }
 };
 
+/* Lookup tree for item names. */
 static struct cgroup_ctrl controllers[] = {
 	[0] = { "cgroup", cgroup_ctrl_files, 0, NULL, 0 },
 	[CTRL_MEMORY] = {
-- 
2.34.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
