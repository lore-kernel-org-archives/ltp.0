Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF46C433F5
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 20:41:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 597773CA74D
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 22:41:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 01F1C3CA76A
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 22:40:38 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 375571A0027B
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 22:40:37 +0200 (CEST)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3492C3F336
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 20:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1651178437;
 bh=k15+L1rhs3IYHcDqpGu3UdSTWGxclDijeTWgLa6rj8I=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=idXHsbHtSFBnoPUzqwgp+9lH7Zjm4diT71EWbDqzItryEoSeq9hkGEQPGVNO+iHIu
 cz5MJacpyZaKR23cF4P1pLQRY2vRbggh5uViBZqa8sFUQCFJ/B9BOkW0dgvpzrVOtM
 NkNCU3+3ciDEM3tJ95SElxYc9JmC/ZrDJKNDM6szf+4p4kKrmFOgZAm2ajtWD7Cktl
 S7tqWjHP55mjFNH2U31xXn+MHwSOhDToZ4B44tkHqbevuDK1i0Fk4B+JnbfdZOXN6u
 0d17XjPj6pOYv4wKlFK74gxmRqinqiko3x88yqhF0ft/5WeM6iy2h25XfXYZVNZwJB
 rZU8U7hHvo6PQ==
Received: by mail-pl1-f199.google.com with SMTP id
 u18-20020a170902e21200b0015e5e660618so1862642plb.5
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 13:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=k15+L1rhs3IYHcDqpGu3UdSTWGxclDijeTWgLa6rj8I=;
 b=QAgETm8K8WJpGLQor+kKKrJpheMiddOhQHbJtGpsiDGjouboLm9QgilN2XN1esRIAO
 Aug8UCw/dydmF33gNa6N8HcPRo4FFDHCgzDnCzzaALyvzor0pyvncrT/kxQHvLrSUw4U
 DTKQX5j/7bUxi/iG5V9yh86gSG9VFUp15OyoHQXRx/FIL9SxStVvDezYyydMjGclnRnW
 aJ1TkqNou0dg1pZ1KuXIYXEUAru5NkYEe6qt52Lxz54lSRysgJMqcpCyj6TtIX1gCkHB
 gLn1J+PRwktTtTwjS0TjIcv4GTMT3D1Zk52nooAY8/nTNPJNzjTAlLY0BWzsEIz9/DXO
 wzMg==
X-Gm-Message-State: AOAM530V74+EKtXLcZO9vuQ3j9jMOAVaSGwVNEZm9G1+HWAeVe4FW6pk
 RO2i+mIkRuPq8wU+s0B8NF80FEh0BQz17MH+VfkbtpthtG+/kxE6K5pd4nelX8DQ1ewRi47L18T
 j/IRjM649YzsY+lSOh9WCe1HysRLO
X-Received: by 2002:a05:6a00:174a:b0:50d:44ca:4b with SMTP id
 j10-20020a056a00174a00b0050d44ca004bmr20930597pfc.0.1651178435041; 
 Thu, 28 Apr 2022 13:40:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUU+u1vIw3PTOLk3Ee7P+zkUlXk2HZ6GdN/lIY0RwQS4I/LHAnWnbDdTcaGKVtOyhmr4HLMw==
X-Received: by 2002:a05:6a00:174a:b0:50d:44ca:4b with SMTP id
 j10-20020a056a00174a00b0050d44ca004bmr20930578pfc.0.1651178434771; 
 Thu, 28 Apr 2022 13:40:34 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101]) by smtp.gmail.com with ESMTPSA id
 f63-20020a62db42000000b0050d35bcdbc0sm659027pfg.181.2022.04.28.13.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Apr 2022 13:40:34 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Thu, 28 Apr 2022 13:39:29 -0700
Message-Id: <4aeef9742f059e0c2f4c0941790829a82299f715.1651176646.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 04/19] API/cgroup: Add CTRL_NAME_MAX define
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

Add a define for max controller name that will be useful for parsing
controller names from strings and helps avoid having unexplained numbers
in the codebase.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
 lib/tst_cgroup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index b8632cdf3..2d4e4a2fe 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -197,6 +197,7 @@ static const struct cgroup_file io_ctrl_files[] = {
 	{ }
 };
 
+#define CTRL_NAME_MAX 31
 /* Lookup tree for item names. */
 static struct cgroup_ctrl controllers[] = {
 	[0] = { "cgroup", cgroup_ctrl_files, 0, NULL, 0 },
@@ -967,7 +968,7 @@ static const struct cgroup_file *cgroup_file_find(const char *const file,
 {
 	const struct cgroup_file *cfile;
 	const struct cgroup_ctrl *ctrl;
-	char ctrl_name[32];
+	char ctrl_name[CTRL_NAME_MAX + 1];
 	const char *const sep = strchr(file_name, '.');
 	size_t len;
 
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
