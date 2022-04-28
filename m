Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B797C433F5
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 20:42:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E0DEC3CA763
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 22:42:04 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB96B3CA73D
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 22:40:41 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1ED001400BCB
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 22:40:41 +0200 (CEST)
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A7C533F21C
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 20:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1651178440;
 bh=uLKhbna3EfMpgumBSMyNq1OwnwGeQ2jYvSY2TbVrQFs=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=Oj6ag1ZTJOUu1B+QewIGIm4h3yThhx5MpflSp1aYrzXJB8OA1Ub9V4K+jHAy+vv3Q
 nr4t4/siszh6tn+u4DgckEJvjoveIu68WfoJ5w1FQyLREg37C5pPOp3XcOhDG8ugon
 QjN/6EWgL7Jbb8IHu3ciN8X/6mlLVYTxI2ncggnslxNl+VTT9svKbcdH6YOByExlr2
 pVkPZQcgZOuZ6mx+QtDNqRxElouO3/mrGNiHK/BFAvtYo71GUwvmonX1uoGq34LY9H
 D3bkpm60ZAxnAlDhyjP1FmWmgZp8Jck9LCtVoSrcWKGXd+EeUk1ruZrqv38tTrkgKL
 zUxt4zIzsgZ3w==
Received: by mail-pg1-f199.google.com with SMTP id
 x2-20020a63aa42000000b003aafe948eeeso2957204pgo.0
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 13:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uLKhbna3EfMpgumBSMyNq1OwnwGeQ2jYvSY2TbVrQFs=;
 b=DfUryTVrsEYqu2KflPHG7k5fm1B7YLUshsQJ24k0fIDxlUDmMi4HsoDBvJEAD/CpU3
 lf1AOA1MwogXyBP4fZETzsYe4WLgTYtIfvrIqsNPANy5URWwp0xi0dixUgSq7jejxPSP
 s51WLR1hT+soVYz98N/bioTU7C21ujujqxuQBDqh3TKZoccBR4rlcadpVjFl+F7QN4wa
 tIDLEk6Vr690DkE/7kVCPbYZNF+dHn40x/+7H89+fUND2CWAMPfzBp3pycCD1Q/6jzKz
 xuadxPOdkk/4rdwb06FJhfrAffW4W06B520MDkQqqTWgDJW5POGRPYXkl2ILiOii6DSw
 4bYQ==
X-Gm-Message-State: AOAM5306US37JCl0tAIikOM/StgRiLy2laeB+PTypMP2H3261XPIEp4r
 g8YlOhxG7mSIgDZG96NQfO7HhvB2ZxnCr/kIylAKngk5zQuAGRv1zlXD0IbwCdPcrtg94aSg85K
 9BuN0JIewzwhAqKq3YTInodRhUlHP
X-Received: by 2002:a17:90b:3a81:b0:1d9:54a0:9362 with SMTP id
 om1-20020a17090b3a8100b001d954a09362mr68110pjb.144.1651178438885; 
 Thu, 28 Apr 2022 13:40:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzu0cLOLprjspCHdacdwkqgu8ueqBRXzYxjd/Jy3lwxrDz2dD+Ho6GICDztO3st3Owj8HDpyQ==
X-Received: by 2002:a17:90b:3a81:b0:1d9:54a0:9362 with SMTP id
 om1-20020a17090b3a8100b001d954a09362mr68082pjb.144.1651178438595; 
 Thu, 28 Apr 2022 13:40:38 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101]) by smtp.gmail.com with ESMTPSA id
 f63-20020a62db42000000b0050d35bcdbc0sm659027pfg.181.2022.04.28.13.40.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Apr 2022 13:40:37 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Thu, 28 Apr 2022 13:39:32 -0700
Message-Id: <7b92172f2e12b4d72af5574570bada11927c57d2.1651176646.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 07/19] API/cgroup: Add more controllers to
 tst_cgroup
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

Add the rest of the controllers that are tested in LTP controller tests
so that they can be mounted using the cgroup api.

Control files should be added on an as needed basis.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
v2: remove rdma controller as that is not used in any LTP tests.
Remove control files that should be added on an as needed basis.
v3: Add debug controllers

 lib/tst_cgroup.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 55c57b20d..254f4aaca 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -84,8 +84,19 @@ enum cgroup_ctrl_indx {
 	CTRL_CPU,
 	CTRL_CPUSET,
 	CTRL_IO,
+	CTRL_PIDS,
+	CTRL_HUGETLB,
+	CTRL_CPUACCT,
+	CTRL_DEVICES,
+	CTRL_FREEZER,
+	CTRL_NETCLS,
+	CTRL_NETPRIO,
+	CTRL_BLKIO,
+	CTRL_MISC,
+	CTRL_PERFEVENT,
+	CTRL_DEBUG
 };
-#define CTRLS_MAX CTRL_CPUSET
+#define CTRLS_MAX CTRL_DEBUG
 
 /* At most we can have one cgroup V1 tree for each controller and one
  * (empty) v2 tree.
@@ -197,6 +208,52 @@ static const struct cgroup_file io_ctrl_files[] = {
 	{ }
 };
 
+static const struct cgroup_file pids_ctrl_files[] = {
+	{ "pids.max", "pids.max", CTRL_PIDS },
+	{ "pids.current", "pids.current", CTRL_PIDS },
+	{ }
+};
+
+static const struct cgroup_file hugetlb_ctrl_files[] = {
+	{ }
+};
+
+static const struct cgroup_file cpuacct_ctrl_files[] = {
+	{ }
+};
+
+static const struct cgroup_file devices_ctrl_files[] = {
+	{ }
+};
+
+static const struct cgroup_file freezer_ctrl_files[] = {
+	{ }
+};
+
+static const struct cgroup_file netcls_ctrl_files[] = {
+	{ }
+};
+
+static const struct cgroup_file netprio_ctrl_files[] = {
+	{ }
+};
+
+static const struct cgroup_file blkio_ctrl_files[] = {
+	{ }
+};
+
+static const struct cgroup_file misc_ctrl_files[] = {
+	{ }
+};
+
+static const struct cgroup_file perf_event_ctrl_files[] = {
+	{ }
+};
+
+static const struct cgroup_file debug_ctrl_files[] = {
+	{ }
+};
+
 #define CTRL_NAME_MAX 31
 /* Lookup tree for item names. */
 static struct cgroup_ctrl controllers[] = {
@@ -213,6 +270,39 @@ static struct cgroup_ctrl controllers[] = {
 	[CTRL_IO] = {
 		"io", io_ctrl_files, CTRL_IO, NULL, 0
 	},
+	[CTRL_PIDS] = {
+		"pids", pids_ctrl_files, CTRL_PIDS, NULL, 0
+	},
+	[CTRL_HUGETLB] = {
+		"hugetlb", hugetlb_ctrl_files, CTRL_HUGETLB, NULL, 0
+	},
+	[CTRL_CPUACCT] = {
+		"cpuacct", cpuacct_ctrl_files, CTRL_CPUACCT, NULL, 0
+	},
+	[CTRL_DEVICES] = {
+		"devices", devices_ctrl_files, CTRL_DEVICES, NULL, 0
+	},
+	[CTRL_FREEZER] = {
+		"freezer", freezer_ctrl_files, CTRL_FREEZER, NULL, 0
+	},
+	[CTRL_NETCLS] = {
+		"net_cls", netcls_ctrl_files, CTRL_NETCLS, NULL, 0
+	},
+	[CTRL_NETPRIO] = {
+		"net_prio", netprio_ctrl_files, CTRL_NETPRIO, NULL, 0
+	},
+	[CTRL_BLKIO] = {
+		"blkio", blkio_ctrl_files, CTRL_BLKIO, NULL, 0
+	},
+	[CTRL_MISC] = {
+		"misc", misc_ctrl_files, CTRL_MISC, NULL, 0
+	},
+	[CTRL_PERFEVENT] = {
+		"perf_event", perf_event_ctrl_files, CTRL_PERFEVENT, NULL, 0
+	},
+	[CTRL_DEBUG] = {
+		"debug", debug_ctrl_files, CTRL_DEBUG, NULL, 0
+	},
 	{ }
 };
 
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
