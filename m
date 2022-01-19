Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89DEC433F5
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 14:44:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 446A63C96B8
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 15:44:39 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F35863C90E7
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 15:44:26 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3467A600657
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 15:44:25 +0100 (CET)
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C180A3FFD0
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 14:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1642603463;
 bh=uzsgK/nBWpjLp4bZpaf2ck5HQw5gRGEi1KwLNDsqFPg=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=M8h5hwgC3YTvR3sfrBH+67QRRAH2mY3bNVHh054RQM0WCz249wGX4Eqtem0TjwYVR
 rN3bZR27XvZU6TUh1UmozZXsC+7zKLwop/4LmHFK8mKXcgPR+/f/Zon4ITUjcxLNJj
 jmUMxy4u77tAU658U2LoSum7sDEo/npiP7EVOmkPKmEKPBuHIwNi1PFzFKA8obIR/s
 922gxi5jK3mDOh9DMW2ZHU8KRrxjwhE1d940VvT0WV4niuP2cNWKyLpnyiajHUQjqB
 pwhS4IxEu2HdSCzVIEFZ62C0cT8ERK9w5EoTvLfhIexnNjmGJ9JJCcjjpTkg1SI4/R
 r1tqlucj7QWFA==
Received: by mail-lf1-f72.google.com with SMTP id
 x14-20020ac259ce000000b0042ca28e7200so1741575lfn.9
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 06:44:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uzsgK/nBWpjLp4bZpaf2ck5HQw5gRGEi1KwLNDsqFPg=;
 b=HFvmVp0A5TdMWnrpctOVJoVLWVqiUHWtPiitkWQu1uHnJa3PaKvxLeQzwMffKA/RWz
 03K9G7WZni4vwQudyhRROfW4NytfaqrpwConEhCU6yCrB62O+cu2jtB3qti3EO+UpCqH
 QBeKfvrkrdfuShvlp2j4/uxl6JF04Uhp27qHpscQgqi4XL0vShOzdTO07gAcbdOQFfeP
 dghxSITxDNAF8dZAEGjf5TwHd5bd4PlCesWsSaIu4uAhRugdY8Z/KCyVR6M3xfA/iE3R
 UkrR1j9huMcgiscutJyTJxYgV0J1SyjixBDFmSLSytheZ2u5zVCDfPWbNT32QpEsN6JN
 I0PQ==
X-Gm-Message-State: AOAM5315QWaOTpUg4QRW9Q8MXkuMhtcYu80VPW2cDbLvq3AoA9dlwBk4
 dTeUKCQsQygyl4DQkssyZJusxfuFuvcw2vxK2Rtq68gJxLpLmINbncegHsE2X2e8IW5G+ESMT14
 Pyc7yeCLPv37h1GsthoN/Px4SzZRs
X-Received: by 2002:a05:6512:3f1b:: with SMTP id
 y27mr26418920lfa.237.1642603463104; 
 Wed, 19 Jan 2022 06:44:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxexZZVoR38vteVnnDXwdoGfNdOkLyYnTger96ySZ2P+APVYsMPDgOZbMmOnpJTYH2wTVF9JQ==
X-Received: by 2002:a05:6512:3f1b:: with SMTP id
 y27mr26418908lfa.237.1642603462933; 
 Wed, 19 Jan 2022 06:44:22 -0800 (PST)
Received: from lukenow-XPS-13-9380.. (d83-110.icpnet.pl. [77.65.83.110])
 by smtp.gmail.com with ESMTPSA id bt18sm2036843lfb.50.2022.01.19.06.44.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jan 2022 06:44:22 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Wed, 19 Jan 2022 06:44:04 -0800
Message-Id: <1658144ea5bf1ee0c6373b5470f611a6f0fb41af.1642601554.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 02/16] API/cgroup: Add option for specific pid to
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
index 5190d8794..7c309edbd 100644
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
index 704e64030..8b8619b36 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -698,7 +698,11 @@ mkdirs:
 
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
