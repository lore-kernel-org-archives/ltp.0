Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B883CC433F5
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 14:44:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 51C2C3C96B1
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 15:44:49 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 08DB43C913B
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 15:44:26 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 46C931000A2D
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 15:44:26 +0100 (CET)
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5B08140028
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 14:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1642603465;
 bh=iKNJ/Ae8Qtdfu7eh7q4PylhHe4QzjY4G+M6e5I+bHsc=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=sUaqT+oIc7I5JyT8hSavDbgU0CkuD0SUm4DvnOi929V0H/UR0OZveWRb2w+b2FJGC
 xtD98Ppn6h+n7oy5lVYMaF08UhSCUbfF7SNSH5Qb+0XPrh3yNL+vHWHQKOpySmN+i7
 AFRj78bvfadPTCAkKqUyNNUlNWQofEWEHWhfq2rIxe3T9WWNGfup+gqmRdn0aOsoeo
 UH3+GxHznmxKCuMNAVK4l8VOqI0XUbarvSGt9ic2AtPA29WHfRsESqPensfrrxBpRP
 0Qy3E3B5a3Z1tI4F/7Td8ViR38S38vdiEYdZ8/DIY0BjmOGufo1ptsZowUpUUrsGqC
 Wmj3yTlyWvWUg==
Received: by mail-lf1-f70.google.com with SMTP id
 q14-20020ac246ee000000b0042c02909ed4so1715393lfo.19
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 06:44:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iKNJ/Ae8Qtdfu7eh7q4PylhHe4QzjY4G+M6e5I+bHsc=;
 b=04WEDWTeQWyd7yS61x249uZEwUXcLN7CTSC+/PyAFYS6LF3QdjZwP8Y/6VTUPCa7s3
 81j2iraX2pwsWhce8uXkMpUJ9E9qaBbBhJFhHUA+5X4qjPuXMEW88pr7fRs1FNkmqb2b
 irVG4GojvTsVc5sTpySFU/GLLDpDy6Q2sNcPNx0ekvZcGOELcyxcYT8LdVXjRzFrqFCs
 ucXy6y5MLSaCnp5tQxqibubnbfGLNYKtXtt9tLgh02Ym8Spt1ibGeUT8F2WY088pwnUm
 q5FL4wyrWVJGCsknC7FZTQXe8Lq0EqEyrIG0p7fmzD4CdGT+gn506nvMW6+QBpRdfOws
 DfpQ==
X-Gm-Message-State: AOAM530aknY0ZKsnP6voKOV8NlHgPLAVDYwHRbozXkCJNWCyzPALb5QL
 v1EQDgxh4oaJlKyxgWhRDdom55U/YBmgcjPTjmC0gmtBUU5DOXCmh+ghb6ItGbIq3hJn1tCwzbz
 jMvNiK0S+eC0ONfWSViiVxrFrwNux
X-Received: by 2002:a05:6512:33d1:: with SMTP id
 d17mr26445827lfg.455.1642603464130; 
 Wed, 19 Jan 2022 06:44:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxhLiBKQnL/rBOQ5pVMPEwFi7UU0mjKEgULixHGcT4f5ZejK7Ys+fFe1VVbo409kDjSBWqSbA==
X-Received: by 2002:a05:6512:33d1:: with SMTP id
 d17mr26445811lfg.455.1642603463950; 
 Wed, 19 Jan 2022 06:44:23 -0800 (PST)
Received: from lukenow-XPS-13-9380.. (d83-110.icpnet.pl. [77.65.83.110])
 by smtp.gmail.com with ESMTPSA id bt18sm2036843lfb.50.2022.01.19.06.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jan 2022 06:44:23 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Wed, 19 Jan 2022 06:44:05 -0800
Message-Id: <a2dcecaff944aaefaf651268d60380343a49afe1.1642601554.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 03/16] API/cgroup: Add cgroup_find_root helper
 function
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

Add a helper function similar to cgroup_find_ctrl to make matching paths
to roots more convenient.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
v2: Use the for_each_root() macro to properly loop over v1 roots

 lib/tst_cgroup.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 8b8619b36..7a406c9db 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -363,6 +363,18 @@ static struct cgroup_ctrl *cgroup_find_ctrl(const char *const ctrl_name)
 	return ctrl;
 }
 
+static struct cgroup_root *cgroup_find_root(const char *const mnt_path)
+{
+	struct cgroup_root *root;
+
+	for_each_root(root) {
+		if (!strcmp(root->mnt_path, mnt_path))
+				return root;
+	}
+
+	return NULL;
+}
+
 /* Determine if a mounted cgroup hierarchy is unique and record it if so.
  *
  * For CGroups V2 this is very simple as there is only one
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
