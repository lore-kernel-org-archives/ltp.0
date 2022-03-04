Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF01BC433EF
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 23:20:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 21B503CA3EF
	for <ltp@archiver.kernel.org>; Sat,  5 Mar 2022 00:20:53 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3CDC33CA3B8
 for <ltp@lists.linux.it>; Sat,  5 Mar 2022 00:18:49 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CF601601F4D
 for <ltp@lists.linux.it>; Sat,  5 Mar 2022 00:18:48 +0100 (CET)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5D05B3F615
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 23:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1646435924;
 bh=/YHHYWI8lMSudNxCW6WMyGhG66DqP/6FS/r7mTAgnWA=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=KDN9sxXcP+W9WYK0Ry53lISirYX7zceI8/1uEKiNN7soAQRMmvGYFuD01fuPU84Xc
 0a2qT3oZEVlP4vLmjVMmQLe0N2VqDRC3Wj05eeArgepEGhrbFC9/+1C2WdrPmKLpee
 eUOjJVy39msGQQDQEtunp4If5jnXDTfGm+CHYXkhDN6Nar18JfZ8ehDjamiTPaAge7
 EopLR/Mjg2DWR7awvmkf1NKXlb2INo+v2ZuIW3DSpT7NPXopt8cyX7c1OY9XzM+kcl
 hpvX6w6bSjFEriOVWhQzZJioRiZC4/pX5IATCUNY5IGuX3oHu+njx4UNDDeqXSwtSs
 0YUFVrSuwPnkg==
Received: by mail-pj1-f70.google.com with SMTP id
 t10-20020a17090a5d8a00b001bed9556134so8142304pji.5
 for <ltp@lists.linux.it>; Fri, 04 Mar 2022 15:18:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/YHHYWI8lMSudNxCW6WMyGhG66DqP/6FS/r7mTAgnWA=;
 b=d7juApNloGxa59W/QtNcBXhViOVYKTdD0lBw1hcxtp4NtjNkasasifPPluU+pY9U/8
 /GEK3pA4Z88INJrz4N57zd47RCP2nFOUVUF2XcP+JvXJ4XPEc+bLKxwYegMpbHX0J+tm
 dfNVZ8fDq1i1fFWOdIGGhWBtQsfZ3bl2wxTa81AE/4jLmEOdyW+KlOg+19FOK1zT7WSA
 NpkjF686bbFo9zZUYEjr8MNjGceRWtndfR70sB9gDmpGAXcW65LNcnVp60+nbj4XtEJ3
 QcOJdg8Nbmf2vOjhw7DdVP5DJShGEYWTrbD6OURklp9oOEd9yZsP+fkMC2nRHHmtuhvq
 2V9Q==
X-Gm-Message-State: AOAM531MkG10/JVV609mMZ9a1OTq0plCVzHdeRdn5F5X4hGwIYqdvN2t
 Ud+exKNtEezW11IEdEjGB5byjuxYTzj//iOMWLQ/4CQ3PYI0HgMC5cRguUlU1HGc1Enyoj/yGyu
 1jkDhfANPrXGHmdioMIWSkA5EjB6C
X-Received: by 2002:a62:8f87:0:b0:4cc:3f6:ca52 with SMTP id
 n129-20020a628f87000000b004cc03f6ca52mr942703pfd.79.1646435917927; 
 Fri, 04 Mar 2022 15:18:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw3kUpGdOPKxPJxZc/nujDjnLoz2k9IsTmzzKtX34FPS7UvGKErUg6CSdl8HE568cZqtyjC+A==
X-Received: by 2002:a62:8f87:0:b0:4cc:3f6:ca52 with SMTP id
 n129-20020a628f87000000b004cc03f6ca52mr942678pfd.79.1646435917667; 
 Fri, 04 Mar 2022 15:18:37 -0800 (PST)
Received: from luke-ubuntu.. (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101]) by smtp.gmail.com with ESMTPSA id
 h14-20020a63384e000000b00366ba5335e7sm5335760pgn.72.2022.03.04.15.18.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Mar 2022 15:18:36 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Fri,  4 Mar 2022 15:18:16 -0800
Message-Id: <031d9481edff991fc3c38da3699364b0f42ae63f.1646434670.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 06/16] API/cgroup: refuse to mount blkio when io
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
index 4e14a2895..52cbf680b 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -691,6 +691,11 @@ static void cgroup_mount_v1(struct cgroup_ctrl *const ctrl)
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
