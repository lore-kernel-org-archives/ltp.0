Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B66C433F5
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 20:41:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5035C3CA79B
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 22:41:26 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C35683CA75E
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 22:40:37 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 27068100094A
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 22:40:37 +0200 (CEST)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9C14F3F21D
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 20:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1651178436;
 bh=GNpu6hlPNyBNSlFYZzZ7dXbXyZsY4gK2qu+4GrfLT7c=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=m9eILu4uIvitVSiCFcGqtCd/ovHeQZbNn/U9l5jVHYhcdvyqf9AysdPFxf95z17dW
 nlL1tE6N2O1Pj4pCit8WiKAPAI9T/uFkQetUCWkQEhTy/zkrNVjuefuT0ISMTvCJvY
 zLOJJAc3MRo4DmkLZtquc16nSIFBgtKfbTRdD8Pf6gZBBEyenJyOFuT2VPZUGczfnY
 te7dfTmupCZvpTYbHXCruJDFwYrG/G+N4SxQYmIPAmgt+ZSyWzWSDsG1cRDaKjrjJd
 eSJVBwRZenqED6cstKoM9ST3mg8nznwDjlJ7i0GSXkltADuFi4QT2BeQ3Obhy2Hr9u
 Gndl2tifFRl0A==
Received: by mail-pj1-f70.google.com with SMTP id
 o16-20020a17090ab89000b001d84104fc2cso4103573pjr.1
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 13:40:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GNpu6hlPNyBNSlFYZzZ7dXbXyZsY4gK2qu+4GrfLT7c=;
 b=DGeXECPGrHzJ0cWgkDIzCS8jFaT07puq8OtC4eOzXOV5Vxf0cWj7pJ8ZgcliTQW+9q
 2J29sbLWpPfHLe7DpKRrFvjFQ80vxbHTSa2T/UaulE2ScIqXx22B0U+3emi4eJfFEEW/
 YKd0bdturAVKc4MmTS6LAUBJ3WfQytow1AaKf9nIVxRhDjMRAOXXlg+LMoffwFyjF9FY
 7So3KRMCy0RF6piRx1bBBYPn6epiIDUBS+qu8irTGocrP+vN/gnbhHKnN0LacSiofAg4
 Z/eUuqwIhKMWiIo57vYx0WoILsVGbJSM2QWwGEUMcym3f48JMgcJAOtF1PjphSekQDWe
 AVJw==
X-Gm-Message-State: AOAM530sXEgi19OR6cjV5SwLW5Hwjs58E2hh9pVqLKbzifFME+VAEISN
 3FvvRcTuIo6UsH6wwJOzt5tfHigsz3LZDBRofituhyFEAGmJsn+RxZKKivhwSK2/v1q6xdtaFhE
 x1Pd0yopPA8Nf3C0ZGx7xK1k6xMey
X-Received: by 2002:a05:6a00:140f:b0:4e0:6995:9c48 with SMTP id
 l15-20020a056a00140f00b004e069959c48mr36286703pfu.59.1651178433825; 
 Thu, 28 Apr 2022 13:40:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVsVorpg6UwCRnh0NlHYeMK/TlGXsDrt9rKjgyJHzKK97HDnZwX0CMWipz5nHk06rf6wQLlg==
X-Received: by 2002:a05:6a00:140f:b0:4e0:6995:9c48 with SMTP id
 l15-20020a056a00140f00b004e069959c48mr36286685pfu.59.1651178433533; 
 Thu, 28 Apr 2022 13:40:33 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101]) by smtp.gmail.com with ESMTPSA id
 f63-20020a62db42000000b0050d35bcdbc0sm659027pfg.181.2022.04.28.13.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Apr 2022 13:40:32 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Thu, 28 Apr 2022 13:39:28 -0700
Message-Id: <964c70e902068685fad0bac4745ba1919994acb9.1651176646.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 03/19] API/cgroup: Add cgroup_find_root helper
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

 lib/tst_cgroup.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index a3416f4df..b8632cdf3 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -363,6 +363,19 @@ static struct cgroup_ctrl *cgroup_find_ctrl(const char *const ctrl_name)
 	return NULL;
 }
 
+static struct cgroup_root *cgroup_find_root(const char *const mnt_path)
+{
+	struct cgroup_root *root;
+
+	for_each_root(root) {
+		if (!strcmp(root->mnt_path, mnt_path))
+			return root;
+	}
+
+	return NULL;
+}
+
+
 /* Determine if a mounted cgroup hierarchy is unique and record it if so.
  *
  * For CGroups V2 this is very simple as there is only one
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
