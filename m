Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C785C433F5
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 23:19:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 683753C5698
	for <ltp@archiver.kernel.org>; Sat,  5 Mar 2022 00:19:21 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D05CD3CA402
 for <ltp@lists.linux.it>; Sat,  5 Mar 2022 00:18:39 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 613FA140004B
 for <ltp@lists.linux.it>; Sat,  5 Mar 2022 00:18:39 +0100 (CET)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C73B83F5FC
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 23:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1646435918;
 bh=V/zNYW19fsArbDmTo8kwJPdxMzW2RO0slPhpgjqfsWw=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=kchaFFtvlIWA7fS38tfiHyYYatAfd1uhxkafNCso0tq8imFUuRvS+4AQCqVF90YRZ
 FPLndUHviGYbPCdhbxbnpDitsNXYIDAfSjcAb9R8mlZfNgoxq39U+4aAJCMdzw8eg6
 XD6TnnF9d2R4HYRFa/RR0dOvPQZAAIk/UcnmRfwV/clqhwyq0kFZ9Z0yTm3DICtQL8
 XxZmEDX3/hQT6gGmitjbaINcnd5g1HkjvxPQqX57sgXKOIvrKyqScrppRYQ+0FaBrx
 10CKBhMYP6RMk9SLB9JNfOgVinsluUaS1IJoRF/i8f+Ij7E0GKvMg+YNg5gj8ZXFVU
 d8OC+HzQ8qGHQ==
Received: by mail-pl1-f199.google.com with SMTP id
 j3-20020a170902da8300b0014fdd4e979cso5342968plx.17
 for <ltp@lists.linux.it>; Fri, 04 Mar 2022 15:18:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=V/zNYW19fsArbDmTo8kwJPdxMzW2RO0slPhpgjqfsWw=;
 b=GoU4sUl6BBIR0wwNmzGG8Zk3VibOlyRe0ylZ0X5jo99E1r/EweNA67GmUnwOR+9a7B
 I3Qm5qjesxGtfuzL/GHBuGqEtqxdT5qYG7MSW4Ubl+2Y7YiqEEL8JHcFth+3tyXrALmn
 4Iw4FQXjownOz9igWf1XwE9UPUxK9s7bZJ5xu2Th4LEfXWETX7D3AXpEcLqdSv5ZngpM
 0gK/zO/yEtaus8/tteEuXGrbNIMeALQochdaOUzQqwVNOaRHVF+/k86la9HA4Iql6YKp
 upOz+ollWmVRM6YGI4vKd31FpJDP8YnPx7YHX1DrWaPIXWKm/08LXWZ4apKsrUSOK0Q8
 yWjg==
X-Gm-Message-State: AOAM533uY879O7OsgTsnImA9/zvfVRL6qRGYbgY3L4glvJ3WxEGqGMhD
 hp9pImdD0GUv8MvIef9cfocX78viTbtDlnrdKELakkaAUW6agUQcGSs2XIB5k4nhjfXWTJ3vu1y
 tQdTzS6H/+h4EZqpn9XiPQL+KZ8lX
X-Received: by 2002:a05:6a00:13aa:b0:4f1:1e5f:1c39 with SMTP id
 t42-20020a056a0013aa00b004f11e5f1c39mr818533pfg.24.1646435916612; 
 Fri, 04 Mar 2022 15:18:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxsNQa8HDuPJ2IC0uztIE14DRJeVHQjya9uXYB+LswnRzGg17z/xRxjPPLDcrPJnKECXDin7Q==
X-Received: by 2002:a05:6a00:13aa:b0:4f1:1e5f:1c39 with SMTP id
 t42-20020a056a0013aa00b004f11e5f1c39mr818513pfg.24.1646435916328; 
 Fri, 04 Mar 2022 15:18:36 -0800 (PST)
Received: from luke-ubuntu.. (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101]) by smtp.gmail.com with ESMTPSA id
 h14-20020a63384e000000b00366ba5335e7sm5335760pgn.72.2022.03.04.15.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Mar 2022 15:18:35 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Fri,  4 Mar 2022 15:18:15 -0800
Message-Id: <4384f778b2664a0ceb561c0b3eac7be42e7cd269.1646434670.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 05/16] API/cgroup: Add more controllers to
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

 lib/tst_cgroup.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 90d91d94e..4e14a2895 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -83,8 +83,19 @@ enum cgroup_ctrl_indx {
 	CTRL_MEMORY = 1,
 	CTRL_CPU,
 	CTRL_CPUSET,
+	CTRL_IO,
+	CTRL_PIDS,
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
@@ -191,6 +202,52 @@ static const struct cgroup_file cpuset_ctrl_files[] = {
 	{ }
 };
 
+static const struct cgroup_file pids_ctrl_files[] = {
+	{ "pids.max", "pids.max", CTRL_PIDS },
+	{ "pids.current", "pids.current", CTRL_PIDS },
+	{ }
+};
+
+static const struct cgroup_file io_ctrl_files[] = {
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
 /* Lookup tree for item names. */
 static struct cgroup_ctrl controllers[] = {
 	[0] = { "cgroup", cgroup_ctrl_files, 0, NULL, 0 },
@@ -203,6 +260,39 @@ static struct cgroup_ctrl controllers[] = {
 	[CTRL_CPUSET] = {
 		"cpuset", cpuset_ctrl_files, CTRL_CPUSET, NULL, 0
 	},
+	[CTRL_PIDS] = {
+		"pids", pids_ctrl_files, CTRL_PIDS, NULL, 0
+	},
+	[CTRL_IO] = {
+		"io", io_ctrl_files, CTRL_IO, NULL, 0
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
