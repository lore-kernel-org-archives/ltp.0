Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B98CC433F5
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 10:00:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A0CC03C917E
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 11:00:44 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 36E293C222E
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 11:00:16 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D1E0B600A35
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 11:00:15 +0100 (CET)
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 644D63F206
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 10:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1641376815;
 bh=RTFbNipgdG8NMqem9If32sllkfJmCkVV7cNLLtff69E=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=jf20TrGGA1B96cp1s4LmxaLO+huMHJwRjI0iSm4CynANTQ1Yxg6Ar9xY0B8SdHDhP
 dU8LFNKUXnPS1B6NiyL157meu1PCTNDe4amZK+hkiI5d4YtiEefxFe23HcZhzJwYiw
 C5ucz2A64z5d2anczM7Uu4Dlp3T0qWuPvUqFMxU+6M0gHKc2SNrNNb78Of4r8oCl9O
 vVXPdUDlMIOs/BEdq4S5xEPYYGvDNDf5yfBbKEaJ0zOThVOBU1xRVn1lwEszYUjqxg
 ev+GlhCye/7gsZZICl6uefhB2/1hjqXpgbfQjExm3o8XqFo7kHghLyvsa80qM0UIK3
 xRmQLMX7thfmg==
Received: by mail-lf1-f69.google.com with SMTP id
 h7-20020ac24da7000000b0042521f16f1fso9170107lfe.21
 for <ltp@lists.linux.it>; Wed, 05 Jan 2022 02:00:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RTFbNipgdG8NMqem9If32sllkfJmCkVV7cNLLtff69E=;
 b=o/wSwxzF9HuF3LTtL3Zg3xXUeKfoBVb+KZOheHFQdriha2T1WZ0+ZdMta2jrKkQW72
 EwMnEQGhh51X8C4FGCmlGCZHyHMVKRynpSl8TdKU1IPn8EvhOIT4/beBNZJG8DZGxcrO
 gzb6k90gV2WmrVwccKo34FMOVHvThi/+Ncft/CkPsuACYd3Ycsrx/UgvvaF1Y34Xe1Zf
 smuOFAj1X1Z3W4+OOQ6AsG6fqW/i/FErKtrQvmzag26jgXyl+JDFwpesv2cg8XvsCSNK
 Kwqw0gkBMzC30NJgIZlwkmIlJ+eEOF/2X9edAS1P9zvXiQel5UBNRmmSmj/Xrhcb47by
 6OVA==
X-Gm-Message-State: AOAM533qi0qKGGT0HkzSgSYRjNspV73ugeFb672lWaSHFYLLT7aRT43T
 ToMgmcFY1XIyfG5r3TjuOi7oPuXYg6l4sIzIoWhNVjcyVu1R5qdSaEHNQnZZR4Zcd/kk1QhctmC
 ryfVQphutU/Dti1GYfp4hPOzlZglP
X-Received: by 2002:ac2:51bc:: with SMTP id f28mr45534448lfk.222.1641376814630; 
 Wed, 05 Jan 2022 02:00:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyaD7EjYwBmnjvmf6uEpsyuQnY9tFoUbVsK8gjbzusf3mVtBGAyhzx4ynX0wiXNhrczcPtRgg==
X-Received: by 2002:ac2:51bc:: with SMTP id f28mr45534435lfk.222.1641376814374; 
 Wed, 05 Jan 2022 02:00:14 -0800 (PST)
Received: from lukenow-XPS-13-9380.home (159-205-75-251.adsl.inetia.pl.
 [159.205.75.251])
 by smtp.gmail.com with ESMTPSA id z25sm4152527lfq.20.2022.01.05.02.00.13
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jan 2022 02:00:14 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it
Date: Wed,  5 Jan 2022 02:00:04 -0800
Message-Id: <0884af8684346aa8996345516f36a4826cc9d852.1641376050.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1641376050.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1641376050.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/6] API/cgroup: Add option for specific pid to
 tst_cgroup_opts
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

Add an option that would allow to create a test directory with a
specified pid, as opposed to the calling processes pid.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
 include/tst_cgroup.h | 3 +++
 lib/tst_cgroup.c     | 6 +++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
index 632050e86..cfcc189ee 100644
--- a/include/tst_cgroup.h
+++ b/include/tst_cgroup.h
@@ -98,6 +98,9 @@ struct tst_cgroup_opts {
 	 * only indicates that we should mount V1 controllers if
 	 * nothing is present. By default we try to mount V2 first. */
 	int only_mount_v1:1;
+	/* Pass in a specific pid to create and identify the test
+	 * directory as opposed to the default pid of the calling process. */
+	int test_pid;
 };
 
 /* A Control Group in LTP's aggregated hierarchy */
diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index b06ae6ab7..1cec3e722 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -713,7 +713,11 @@ mkdirs:
 
 	cgroup_dir_mk(&root->ltp_dir, cgroup_ltp_drain_dir, &root->drain_dir);
 
-	sprintf(cgroup_test_dir, "test-%d", getpid());
+	if (options->test_pid)
+		sprintf(cgroup_test_dir, "test-%d", options->test_pid);
+	else
+		sprintf(cgroup_test_dir, "test-%d", getpid());
+
 	cgroup_dir_mk(&root->ltp_dir, cgroup_test_dir, &root->test_dir);
 }
 
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
