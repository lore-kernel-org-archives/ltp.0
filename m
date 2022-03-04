Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF25C433F5
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 23:18:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C2A8B3CA3C6
	for <ltp@archiver.kernel.org>; Sat,  5 Mar 2022 00:18:45 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CBCAE3C9628
 for <ltp@lists.linux.it>; Sat,  5 Mar 2022 00:18:35 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 017C96011FB
 for <ltp@lists.linux.it>; Sat,  5 Mar 2022 00:18:34 +0100 (CET)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4CBE83F5FB
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 23:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1646435914;
 bh=geF/D2xcIfwYgA/pIy4Ytdw3WZjQiTCT8Ker9tmcYbQ=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=hTrYno+K7kdGmKBPgRmjRgD7EciCjOsldx1RrWvnbYz4tVrXtEKMMrWw3T8li82xW
 4AmJ23sXzgAXNZUSnSYr6dRIahmWlRwTrAqx3ZsZif3kPpddF2V4nUd8U6nN0CDaY+
 HOHDB8eVYb2lUGMP/xz6g+YJs8DBRXKoXoLNpWSEhRv1h8JQIQ6dts5YI3utWq3eJT
 aRqhYCphxnPOu7TtBt/Z8ZMmfr2DgPzNbbnASNLllJ+KCQU9b4q8Sk361pzF4UWU8h
 Dum9MP0f26iQj51pF4ewn0J+LuCjk+GRTpiEgnL0zPZ20jQTS+ohYEdtwNqHBhS4xb
 qD2U0bEP6zgbA==
Received: by mail-pl1-f200.google.com with SMTP id
 w13-20020a1709027b8d00b0014fb4f012d3so5343997pll.12
 for <ltp@lists.linux.it>; Fri, 04 Mar 2022 15:18:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=geF/D2xcIfwYgA/pIy4Ytdw3WZjQiTCT8Ker9tmcYbQ=;
 b=79h3cZCTiKmca+IkLTqTeJVyUxZ76wTEa4LCUfyEO7ucL9o8/hT+AYHEDMvRnJN9bS
 klghibyK+S+tUiBLozRlKs6lH1nM4GBLd+WX+WL5gZP/oL8KCWr/Bq7JNiBke0jX0rDL
 p0cCna1CJHMdF4+DPrBPH3f10GIwUySJCrGM4YS0AJ0YFtDycHXM/fQBmcZ4S/Q3Reqf
 XPsqAf7UuL2KnxqL7Wq4XBAgZHOk9IdkocHqHMWpBvRH5lTL+TRrSRm+OQPtJ2AFzAuD
 ETLtz7HmZq/0JaQSRu24uVTGIA2GRO7dfDiu4kgdxL6hoOEbAOviP1Rtd4U9YQGWyOiF
 PY5A==
X-Gm-Message-State: AOAM5327rRoJQF6yxNyqXNnk/Kq68p6A7g8tDlDiiamusUvQoK4YdPkO
 36pjI6seRS+E63J4ZhFSS4IvVsjgGsFVtCY6rr9zYOUSkBl9y+EbiPxXGTbst1so+cv9MXXfMGg
 5+xtL0dvNL/2EFRqvn2YKy3GJJiFv
X-Received: by 2002:a05:6a00:1310:b0:4ca:cc46:20c7 with SMTP id
 j16-20020a056a00131000b004cacc4620c7mr810678pfu.44.1646435912514; 
 Fri, 04 Mar 2022 15:18:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzuDYLAA44W66Zkc6ptJiz+VLX8hM2S3+CU7Gavv4Zg4EJgo77H2AcpkhLN5Tv30Dai8jp+Kw==
X-Received: by 2002:a05:6a00:1310:b0:4ca:cc46:20c7 with SMTP id
 j16-20020a056a00131000b004cacc4620c7mr810661pfu.44.1646435912223; 
 Fri, 04 Mar 2022 15:18:32 -0800 (PST)
Received: from luke-ubuntu.. (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101]) by smtp.gmail.com with ESMTPSA id
 h14-20020a63384e000000b00366ba5335e7sm5335760pgn.72.2022.03.04.15.18.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Mar 2022 15:18:31 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Fri,  4 Mar 2022 15:18:12 -0800
Message-Id: <3f0ce0cd15392f011b3adfdd2bb568f0dd05ea81.1646434670.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 02/16] API/cgroup: Add option for specific pid to
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
index 6ba3727f3..87e55f4df 100644
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
index 68f3609cf..66e7a81d9 100644
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
