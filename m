Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2FACCA489
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 20:53:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E590E3C9D51
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 22:53:37 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C01A03C98C8
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 22:53:12 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4E55C1400747
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 22:53:12 +0200 (CEST)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D22753F130
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 20:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1658436791;
 bh=qgkDtVZEDygqU5hkpxSWgUsPA5NbQrbNYZVCn3Eo78w=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=ICkNAyFAIBWZJDoZhVZqmowLNuY7BahgsH9hkfQIizFai8XOYz9X9ywJa+K3NHq/x
 osvWbrwQro2PdgopzGu3/l3rCm7c3vtJoIj+YBmKKHlX/M9KJt11U9ldY9hziRjFU3
 NlbIhowLOTXxyRQVzTQA7mTaZdf9QnwsunnUsS7B9SrRWNDZixKMQuKk1HerR8aMRG
 kCJoy3kxCchGyqlPlHoyPDXZWcj92odkBnrV0f1YnwXPzFtLplihFhZKBkVQmvyx8f
 S+YykVjnjN7xxIfnnjbwmi74I1miFdAqDuaFg0nuk1EFcVgG+cIyY2rQ2nN3NMbyKc
 PssXOMYGRdwOA==
Received: by mail-pl1-f200.google.com with SMTP id
 j2-20020a170902da8200b0016d2f218d52so1662317plx.17
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 13:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qgkDtVZEDygqU5hkpxSWgUsPA5NbQrbNYZVCn3Eo78w=;
 b=dwTlK+jW4zGoMuWmNJHcPgEuliO9m/hcjHZLjsiBWgmkRZLADm/6G38OXRFM52chZX
 vT6wCex9WOH50O8Fmkk32ujA2QtdGEKMguQsgZ3VfMQnCegiz2QfZ+1TapnJ7GsCUfrq
 x8emNdVzdVAqe0436RDv28JEgmDaFXjpjUe0wMj1ociqDBWW5JVMYjnzLMl+LL/xfQj2
 O4t3+I68xziwY4Gr0vqWNWmFCdoVaiumt/LT3WzyIef+VASk6nK9lQK9g0MZC9gYWOph
 8Vevgzz4lfGh/C1P4ObVqb1LWGZUPcjYwpyZ7RweZEQx6dnetYfgj2Vzy3PP71orgOYh
 E4uw==
X-Gm-Message-State: AJIora/ZKdSZ2td3OkY7ILHAy0ky1wm52cr68Ti8uSRZeygzibOCSjJE
 xlwSl30fsbfAnOLDPmvilLsZkJPm0eTims1C1bRJlJsNbAg87igbOfWm8LXwug4gSFzjuRdtmsE
 78QX7o/n9HLOw2EnvwiNl+Ydu4J9h
X-Received: by 2002:a63:f907:0:b0:411:cbe3:bb41 with SMTP id
 h7-20020a63f907000000b00411cbe3bb41mr208379pgi.268.1658436790292; 
 Thu, 21 Jul 2022 13:53:10 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u+qtH8nxFLTAJtbfXDx8vEVEuAmDq1YC9cmi9tv7VqrBi9O+U1K2p/OfvRaNzquEOXsPA5gw==
X-Received: by 2002:a63:f907:0:b0:411:cbe3:bb41 with SMTP id
 h7-20020a63f907000000b00411cbe3bb41mr208345pgi.268.1658436789779; 
 Thu, 21 Jul 2022 13:53:09 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-75-80-146-43.san.res.rr.com.
 [75.80.146.43]) by smtp.gmail.com with ESMTPSA id
 c6-20020a656746000000b0041a4d5e7e5fsm1916364pgu.47.2022.07.21.13.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jul 2022 13:53:09 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it, rpalethorpe@suse.de, liwang@redhat.com, pvorel@suse.cz,
 chrubis@suse.cz
Date: Thu, 21 Jul 2022 13:52:12 -0700
Message-Id: <c74cdfacc845f8dbbdb4c2c4cd74d98fe6b5e483.1658433280.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 02/18] API/cgroup: Add option for specific pid to
 tst_cg_opts
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
 include/tst_cgroup.h | 4 ++++
 lib/tst_cgroup.c     | 6 +++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
index 7ebc2a624..aa70dc27a 100644
--- a/include/tst_cgroup.h
+++ b/include/tst_cgroup.h
@@ -97,6 +97,10 @@ struct tst_cg_opts {
 	 * version. Defautls to zero to accept any version.
 	 */
 	enum tst_cg_ver needs_ver;
+	/* Pass in a specific pid to create and identify the test
+	 * directory as opposed to the default pid of the calling process.
+	 */
+	int test_pid;
 };
 
 /* A Control Group in LTP's aggregated hierarchy */
diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index c56a7c6b9..d757c832f 100644
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
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
