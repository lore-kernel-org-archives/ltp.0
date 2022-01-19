Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A533C433F5
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 14:46:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 72DFA3C950B
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 15:46:03 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C80DC3C96AB
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 15:44:32 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9E8302009A8
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 15:44:31 +0100 (CET)
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E073A40028
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 14:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1642603466;
 bh=dpZe6gEk9WXPX7b7K0dmIy+DbnFSpmmvu4H1UKo1jz8=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=k4d1OoD/ua5YtZd/Hw3CHwj0X8XOY/MOshtxV4GvfNebTUk7+CYOPioKHdtq486TB
 z4UQ/f7NLnFLN+trKat5lAfvESWEHWbW5n+iqNdr+6r5jc6UrXjlBpnqmKFX3QlbQX
 T+/qMZmr603pWb52FgwxpWa2tWXnXf22eunhlRAO8I981iuTRagHe6UgDxhbvXTe0V
 cL+hPTf3RjjP0418/vBhv9meAqOYtRqOH+3q352gOUxwGw/OQ8Z3TI2sI8UtfEjrts
 lcabWNN23HKDPgTLCHgJ76Nq1gfoY8wpS+DCFbWyisuoMMx7+nouVpLtZIiw0IFHTf
 mbbpKZ2tHF7Xg==
Received: by mail-lf1-f72.google.com with SMTP id
 k11-20020a0565123d8b00b00432719f58dbso1722005lfv.22
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 06:44:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dpZe6gEk9WXPX7b7K0dmIy+DbnFSpmmvu4H1UKo1jz8=;
 b=mmNIilRtPCbhguVmoRuh9CQAld2+5YGeJlZ5ZlQ4GDPgUVequ1GZj9TmBX5IIPRYEj
 noSpOzKAsU0vuaHFySTNjcuvLtU/TwWXvSM+EixIc9wroJm/yWZLVb7TQl468AKWqLDL
 KPPdAUhy8136AACLo5x5dzs5Yz+SW0+tv0Qjav83v+AAD512dqkGAil8JIJFL1/dyNu1
 96x/kmh34Ni87lG1Vvjfq4XTDWoL+VRj+r4DkK/XgVb6J+uYEN10vZzwZix5H+TA6l3T
 rbEkmPY7p1urycoj12YDfF3p2cCTZo7dfxemjmuyJ7XMOSUZ2fhs2Ex4UsG59QSI410K
 A1FQ==
X-Gm-Message-State: AOAM533q9QOWXKp43eCEfKX85/y99fri6UvyhC+uvNj0U45AYImqvKv5
 sX3fhKBFep7UKwqp38vulVEhw5Nbg2x17+2KRvG5amwy2TWNvrVFhcVavHwxXdUwHfmbOcUnyXd
 ZyqM+edEUnBOZwvrDI/qCDbvCWPjo
X-Received: by 2002:a05:6512:151c:: with SMTP id
 bq28mr23828922lfb.544.1642603465878; 
 Wed, 19 Jan 2022 06:44:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy0R1n+DMbWkN4cqEfqVCWI1cQiaQeYAkGLHBPLYKkU33vNiPbDBouApAD90IdnV6xDzZrnCw==
X-Received: by 2002:a05:6512:151c:: with SMTP id
 bq28mr23828906lfb.544.1642603465646; 
 Wed, 19 Jan 2022 06:44:25 -0800 (PST)
Received: from lukenow-XPS-13-9380.. (d83-110.icpnet.pl. [77.65.83.110])
 by smtp.gmail.com with ESMTPSA id bt18sm2036843lfb.50.2022.01.19.06.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jan 2022 06:44:25 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Wed, 19 Jan 2022 06:44:07 -0800
Message-Id: <b000b664ed74dc8e52c7afe0061471c7f8e20d10.1642601554.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 05/16] API/cgroup: Add more controllers to tst_cgroup
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

Add more controllers so that they can be mounted and used using the
cgroup C api.

Most of the controllers used in controllers tests are added and a
reasonable working set of the controller control files that I came
across are added as well.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
 lib/tst_cgroup.c | 153 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 152 insertions(+), 1 deletion(-)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index df541d26a..3d56a3364 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -84,8 +84,20 @@ enum cgroup_ctrl_indx {
 	CTRL_MEMORY = 1,
 	CTRL_CPU,
 	CTRL_CPUSET,
+	CTRL_IO,
+	CTRL_PIDS,
+	CTRL_RDMA,
+	CTRL_HUGETLB,
+	CTRL_CPUACCT,
+	CTRL_DEVICES,
+	CTRL_FREEZER,
+	CTRL_NETCLS,
+	CTRL_NETPRIO,
+	CTRL_BLKIO,
+	CTRL_MISC,
+	CTRL_PERFEVENT
 };
-#define CTRLS_MAX CTRL_CPUSET
+#define CTRLS_MAX CTRL_PERFEVENT
 
 /* At most we can have one cgroup V1 tree for each controller and one
  * (empty) v2 tree.
@@ -181,6 +193,109 @@ static const struct cgroup_file cpuset_ctrl_files[] = {
 	{ }
 };
 
+static const struct cgroup_file io_ctrl_files[] = {
+	{ "io.state", NULL, CTRL_IO },
+	{ "io.cost.qos", NULL, CTRL_IO },
+	{ "io.cost.model", NULL, CTRL_IO },
+	{ "io.weight", NULL, CTRL_IO },
+	{ "io.max", NULL, CTRL_IO },
+	{ "io.pressure", NULL, CTRL_IO },
+	{ }
+};
+
+static const struct cgroup_file pids_ctrl_files[] = {
+	{ "pids.max", "pids.max", CTRL_PIDS },
+	{ "pids.current", "pids.current", CTRL_PIDS },
+	{ }
+};
+
+static const struct cgroup_file rdma_ctrl_files[] = {
+	{ "rdma.max", "rdma.max", CTRL_RDMA },
+	{ "rdma.current", "rdma.current", CTRL_RDMA },
+	{ }
+};
+
+#define HUGETLB_ENTRY(SIZE) \
+	{ "hugetlb.SIZE.max", "hugetlb.SIZE.limit_in_bytes", CTRL_HUGETLB }, \
+	{ "hugetlb.SIZE.current", "hugetlb.SIZE.usage_in_bytes", CTRL_HUGETLB }, \
+	{ "hugetlb.SIZE.rsvd.max", "hugetlb.SIZE.rsvd.limit_in_bytes", CTRL_HUGETLB }, \
+	{ "hugetlb.SIZE.rsvd.curent", "hugetlb.SIZE.rsvd.usage_in_bytes", CTRL_HUGETLB }, \
+	{ "hugetlb.SIZE.rsvd.max_usage_in_bytes", "hugetlb.SIZE.rsvd.max_usage_in_bytes", CTRL_HUGETLB }, \
+	{ "hugetlb.SIZE.max_usage_in_bytes", "hugetlb.SIZE.max_usage_in_bytes", CTRL_HUGETLB }, \
+	{ "hugetlb.SIZE.events", NULL, CTRL_HUGETLB }, \
+	{ "hugetlb.SIZE.events.local", NULL, CTRL_HUGETLB }, \
+	{ "hugetlb.SIZE.failcnt", "hugetlb.SIZE.failcnt", CTRL_HUGETLB }, \
+	{ "hugetlb.SIZE.rsvd.failcnt", "hugetlb.SIZE.rsvd.failcnt", CTRL_HUGETLB },
+
+// TODO Add rest of hugetlb entries or find better way to reference files
+static const struct cgroup_file hugetlb_ctrl_files[] = {
+	HUGETLB_ENTRY(2MB)
+	HUGETLB_ENTRY(1GB)
+	{ }
+};
+
+static const struct cgroup_file cpuacct_ctrl_files[] = {
+	{ "cpuacct.state", "cpuacct.state", CTRL_CPUACCT },
+	{ "cpuacct.usage", "cpuacct.usage", CTRL_CPUACCT },
+	{ "cpuacct.usage_all", "cpuacct.usage_all", CTRL_CPUACCT },
+	{ "cpuacct.usage_percpu", "cpuacct.usage_percpu", CTRL_CPUACCT },
+	{ "cpuacct.usage_percpu_sys", "cpuacct.usage_percpu_sys", CTRL_CPUACCT },
+	{ "cpuacct.usage_percpu_user", "cpuacct.usage_percpu_user", CTRL_CPUACCT },
+	{ "cpuacct.usage_sys", "cpuacct.usage_sys", CTRL_CPUACCT },
+	{ "cpuacct.usage_user", "cpuacct.usage_user", CTRL_CPUACCT },
+	{ }
+};
+
+static const struct cgroup_file devices_ctrl_files[] = {
+	{ "devices.allow", "devices.allow", CTRL_DEVICES },
+	{ "devices.deny", "devices.deny", CTRL_DEVICES },
+	{ "devices.list", "devices.list", CTRL_DEVICES },
+	{ }
+};
+
+static const struct cgroup_file freezer_ctrl_files[] = {
+	{ "freezer.parent_freezing", "freezer.parent_freezing", CTRL_FREEZER },
+	{ "freezer.self_freezing", "freezer.self_freezing", CTRL_FREEZER },
+	{ "freezer.parent_state", "freezer.parent_state", CTRL_FREEZER },
+	{ }
+};
+
+static const struct cgroup_file netcls_ctrl_files[] = {
+	{ "net_cls.classid", "net_cls.classid", CTRL_NETCLS },
+	{ }
+};
+
+static const struct cgroup_file netprio_ctrl_files[] = {
+	{ "net_prio.ifpriomap", "net_prio.ifpriomap", CTRL_NETPRIO },
+	{ "net_prio.prioidx", "net_prio.prioidx", CTRL_NETPRIO },
+	{ }
+};
+
+static const struct cgroup_file blkio_ctrl_files[] = {
+	{ "blkio.reset_stats", "blkio.reset_stats", CTRL_BLKIO },
+	{ "blkio.throttle.io_service_bytes", "blkio.io_service_bytes", CTRL_BLKIO },
+	{ "blkio.throttle.io_service_bytes_recursive", "blkio.throttle.io_service_bytes_recursive", CTRL_BLKIO },
+	{ "blkio.throttle.io_serviced", "blkio.throttle.io_serviced", CTRL_BLKIO },
+	{ "blkio.throttle.io_serviced_recursive", "blkio.throttle.io_serviced_recursive", CTRL_BLKIO },
+	{ "blkio.throttle.read_bps_device", "blkio.throttle.read_bps_device", CTRL_BLKIO },
+	{ "blkio.throttle.read_iops_device", "blkio.throttle.read_iops_device", CTRL_BLKIO },
+	{ "blkio.throttle.write_bps_device", "blkio.throttle.write_bps_device", CTRL_BLKIO },
+	{ "blkio.throttle.write_iops_device", "blkio.throttle.write_iops_device", CTRL_BLKIO },
+	{ }
+};
+
+static const struct cgroup_file misc_ctrl_files[] = {
+	{ "misc.capacity", "misc.capacity", CTRL_MISC },
+	{ "misc.current", "misc.current", CTRL_MISC },
+	{ "misc.max", "misc.max", CTRL_MISC },
+	{ "misc.events", "misc.events", CTRL_MISC },
+	{ }
+};
+
+static const struct cgroup_file perf_event_ctrl_files[] = {
+	{ }
+};
+
 /* Lookup tree for item names. */
 static struct cgroup_ctrl controllers[] = {
 	[0] = { "cgroup", cgroup_ctrl_files, 0, NULL, 0 },
@@ -193,6 +308,42 @@ static struct cgroup_ctrl controllers[] = {
 	[CTRL_CPUSET] = {
 		"cpuset", cpuset_ctrl_files, CTRL_CPUSET, NULL, 0
 	},
+	[CTRL_IO] = {
+		"io", io_ctrl_files, CTRL_IO, NULL, 0
+	},
+	[CTRL_PIDS] = {
+		"pids", pids_ctrl_files, CTRL_PIDS, NULL, 0
+	},
+	[CTRL_RDMA] = {
+		"rdma", rdma_ctrl_files, CTRL_RDMA, NULL, 0
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
 	{ }
 };
 
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
