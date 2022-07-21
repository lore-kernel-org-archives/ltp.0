Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07A2C43334
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 20:54:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 165113C9EAD
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 22:54:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E3BE53C9FE8
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 22:53:18 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 57B2420004A
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 22:53:18 +0200 (CEST)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 83E9B3F11B
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 20:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1658436797;
 bh=UQxDurAcWgWPe+RVc6sKRjIvTkRFplU+0YSbJNkMGcM=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=Bw70LuFjyOv1Nkx54LfJGbTBiu9vS660UCUzHv2lMbCoIkBmC3wrbegXcxQq98eTH
 m3RymhkfirhplUiEJFuSkw2VGDQZ5PbRBlhuFYkNsSdeO68HEtibrtdGSInDX3BArZ
 WvuH7HTF6iFS6Atv8iV5BKvKQKdLkbY4IsXjHAgsEs+H/tKiEDapGQNTok0+xcNDwZ
 vekFNi54dMKEpIISFz0eT19LB9qMFJfNmSUEoe/qIsO4mdg8CgVjnZHrTWVtpA1Zgi
 2kCW8Tp1jNcdSHWOSMK85rpBWZdLdy3IOiMmspGz3+6XBUOG9DBijM5eE1XfvUYhya
 JUtxGf74dEKhw==
Received: by mail-pl1-f198.google.com with SMTP id
 b17-20020a170903229100b0016d3e892112so204718plh.6
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 13:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UQxDurAcWgWPe+RVc6sKRjIvTkRFplU+0YSbJNkMGcM=;
 b=RlXAJhpu7axfL32qgzvZIfHbumAYQa6wCJUzhTSs/UHO79vgTMcgDuUgNzaMw6MjPk
 RT5ysV06xlBUEgofPK1/bfeEccN1s/TVdmBzSI68r2BhV5KgtOYWQ6n4i/2tAU59zIo+
 L0EaeSzu4xVERy4bX12plfzQaTLrne8WFSQFzJpsQPXW6wZKB22HU3ODC8mFR631ojup
 TCAHUoD9EevbKvhZBhcVggefwvbddDaIA5dGKuIecDj9tUMVwXrpU8/ZAYpkjHmCr9DR
 KWwOvTQmOexzeR4ns+1F1m9uF69hl1w/kEpp8r4PbQ5Aj44pa4K1Yp+GQNfMuNas9Zqw
 /dQA==
X-Gm-Message-State: AJIora9+gwtNnLkGttHnnskS3EW/gwzn8g47cdDSccXm3RNU7MLQmLcO
 DBUa+vVLvt+xTNb5UALTnVJHdnzFFbgwGnGYfwDutlzgKfSp67wjzQOVJyV2p2GQlJ0O+diha9v
 KPKwlTmxHuXaq9syFs/0J/eNtHtPg
X-Received: by 2002:a17:902:a516:b0:16c:ef6f:fec7 with SMTP id
 s22-20020a170902a51600b0016cef6ffec7mr299443plq.140.1658436795788; 
 Thu, 21 Jul 2022 13:53:15 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vmz6RtmbO0ON8+nI3FrdndZPgj1QjuMmrPJizTibvmOmt9zudjfajsWALDY+BL1ND5gg1WAQ==
X-Received: by 2002:a17:902:a516:b0:16c:ef6f:fec7 with SMTP id
 s22-20020a170902a51600b0016cef6ffec7mr299417plq.140.1658436795514; 
 Thu, 21 Jul 2022 13:53:15 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-75-80-146-43.san.res.rr.com.
 [75.80.146.43]) by smtp.gmail.com with ESMTPSA id
 c6-20020a656746000000b0041a4d5e7e5fsm1916364pgu.47.2022.07.21.13.53.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jul 2022 13:53:15 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it, rpalethorpe@suse.de, liwang@redhat.com, pvorel@suse.cz,
 chrubis@suse.cz
Date: Thu, 21 Jul 2022 13:52:17 -0700
Message-Id: <abc86cfe7e289ec612cd4830820e52a072e44ab9.1658433280.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 07/18] API/cgroup: Add more controllers to
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
index 27e3f5f0d..16cb233a8 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -83,8 +83,19 @@ enum cgroup_ctrl_indx {
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
@@ -196,6 +207,52 @@ static const struct cgroup_file io_ctrl_files[] = {
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
@@ -212,6 +269,39 @@ static struct cgroup_ctrl controllers[] = {
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
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
