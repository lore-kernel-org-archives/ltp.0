Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FCAC433F5
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 20:42:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5FB433CA700
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 22:42:16 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC0F73C8972
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 22:40:43 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CC7C11400BCB
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 22:40:42 +0200 (CEST)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id ED3433F21C
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 20:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1651178441;
 bh=+cBISHOzPIH6Tu85KH/b1ERl/YWOTIYAou4++taoffM=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=tz7lpmB18128l0tfZBSORQXgh/OqSnT6NETmMzlWwW0iMElXG+6KDqAOewZC8zX7c
 ba5pDNZD3J7bEMlI8juoFiB+LuZt9I1vEtMNc65bK0Kwq0OGRWwv6Za1i4p/fP6Qw3
 qDb36dLI54RO6L/gggZ6vDVCK/wCXxeIHH3ExOdLvUtgUmiqAd99Ht1RpprXYUf7PV
 2rwJGiacsyiTVATjHo2nHlRsx9UfawD7sjWiKF6Ykf9OGdilkuQknADSpV9KOR9BWk
 8S0+G1Swbl19tlwTHh/mQn/OY1tRkxb1j/c0f+WJgF3n0HJgXlV95p8wjBJ/lYL6T7
 V2ItTI8YFUO/Q==
Received: by mail-pf1-f200.google.com with SMTP id
 d6-20020aa78e46000000b0050cfcce2fefso3257706pfr.18
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 13:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+cBISHOzPIH6Tu85KH/b1ERl/YWOTIYAou4++taoffM=;
 b=BkTlPkpURogq7rWwJd8L5/2oTXa9rdwnBTs6JCEvBWlJCh57z9Y1zppnBV9cvU1yGC
 gFvMEMs2jMwEL1bfPLWQIwQNc2DPJjwXdZhwaT+BWAQoDzPnEOAzwZZVTX0vNgdBz0pb
 NkzAVkBQ0I04xSXHNBfEh0rFCYLlcjrzkFtrDNLxP78X1EjFs4Tnb0aiVJBjouYAxWnL
 F1/rRvflsFtgCEpZuOQnzxR5OsMM+mbFQq4UUOJdCLuQo/LMe2o/aWZQr15pvymAPOXk
 cYCie5zZhDj+gD8RjVPTT+ZpG1mdqXNRY8gnS3LyXpYUkJCGwmF0meN+YjLOJtmLzsTs
 o4hg==
X-Gm-Message-State: AOAM531B+GoN8k0VRpKJ1V6DZ+OF271QKCmZJ2PZHag6RyCV/mVDlZQc
 +E7Dsim5SucMusqniTrmQoEaMaGoITevoyf/9TmB4GbVIFNG/bSAri8DgnkW2NDlijLHlHey7k5
 GTUvJ50oudc2cLIxHyFbAZToo2m/Q
X-Received: by 2002:a17:902:bf06:b0:14d:8c72:96c6 with SMTP id
 bi6-20020a170902bf0600b0014d8c7296c6mr35075010plb.156.1651178440159; 
 Thu, 28 Apr 2022 13:40:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyc3/xUwwnWUMX8yNgk4dszclKD2LCMJswcqCpaYvBCCRQ9VLRpXNd9A6AP8RcMMv8hZ1kA6g==
X-Received: by 2002:a17:902:bf06:b0:14d:8c72:96c6 with SMTP id
 bi6-20020a170902bf0600b0014d8c7296c6mr35074991plb.156.1651178439894; 
 Thu, 28 Apr 2022 13:40:39 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101]) by smtp.gmail.com with ESMTPSA id
 f63-20020a62db42000000b0050d35bcdbc0sm659027pfg.181.2022.04.28.13.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Apr 2022 13:40:39 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Thu, 28 Apr 2022 13:39:33 -0700
Message-Id: <81ac339d9c92668acabbdd396092bc4b67119872.1651176646.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 08/19] API/cgroup: refuse to mount blkio when io
 controller is mounted
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

Mounting the v1 blkio controller while v2 io controller is mounted
unmounts the io controller, triggering a tst_brk that the number of
controller has gone down.

Because these controllers don't seem to be compatible, tst_brk with
TCONF and report that we refused to mount the blkio controller while the
io controller is mounted.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
 lib/tst_cgroup.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 254f4aaca..6794046e2 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -717,6 +717,11 @@ static void cgroup_mount_v1(struct cgroup_ctrl *const ctrl)
 	char mnt_path[PATH_MAX];
 	int made_dir = 0;
 
+	if (ctrl->ctrl_indx == CTRL_BLKIO && controllers[CTRL_IO].ctrl_root) {
+		tst_brk(TCONF,
+			"IO controller found on V2 root, skipping blkio mount that would unmount IO controller");
+	}
+
 	sprintf(mnt_path, "%s%s", cgroup_mount_ltp_prefix, ctrl->ctrl_name);
 
 	if (!mkdir(mnt_path, 0777)) {
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
