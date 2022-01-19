Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A85AC433F5
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 14:45:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 773EE3C96A1
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 15:45:29 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A6383C968A
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 15:44:28 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 59D9B1000A34
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 15:44:28 +0100 (CET)
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B212B40052
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 14:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1642603467;
 bh=/Vw4FtZv7rZdel8McqPYt01snLmMy2g7BPQQr0k8upY=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=m1PaeFcY9frqoNzbEOMnQ9hnYsYGBMzfIH6Rswyio/UAufSh/+WLmpitgVtgbb9Ig
 tUwWLo5zyQBTrfuiwq5c6SF+NppqXPuTY5LHb6Ya8sdhZki1BIb9y9vu9gIw7bgmPq
 ywUMM1N+gtIssQ3QjBxhvzHh3VickyltHGT/x77U/U4caeyTWoIlBidRlfCWSK5oHp
 pViG8BkNTlHP/aIuAsusB60UGbMlhJnL8Rj6erphQQjCxTwEnRkqFz2W/gUmC3Iocl
 fRejB4sjPeBtUSyohQVIzO5NtiYC4/gPqKuluYocK/0xx9pmd4oBh+4MBiKyHmMVYZ
 ILs7Lu57nQlvg==
Received: by mail-lf1-f71.google.com with SMTP id
 r15-20020ac24d0f000000b00433881e147dso454066lfi.18
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 06:44:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/Vw4FtZv7rZdel8McqPYt01snLmMy2g7BPQQr0k8upY=;
 b=CWisyCkixZs734X+B7vj8vAHeo1IG3S/nFGIqRTu2eLrGttu+WahLEv9RLSB0145Y0
 mJAWwdG7rF2JtMhH7Iz/glACzm83dbc1VOF0M7+CI0mxHF+qTMF+gWbsucGr3ORJ2UuZ
 eLHIpubFVhfdHo2p9RdSKBnP/0FwkPXdx/VZr1nKMlAby4W4urm0vroFaBUHZYj5VLlq
 ARU5ZQzg2NH4EV9cuurawXZx4+44FJXIG0ma9eHNolfHxAk/c8RzntFfs7et+oPMDwAe
 YVMVUQF1xodfj/j3vTsE5H/VnhuYTEAU7ieZDIkxzYpiAjnow9f3mJlDCN0JypksQoxI
 fCmg==
X-Gm-Message-State: AOAM531R+5QuFSYKO+9V/9H+oVL98Vj5ThZPhA/TIUkel7zlGl/vphYM
 Ot3du9+QnKp0ji3O0fRaNWZmiDu8Fta5bJMRhYnRM+Z2tl7BzcMPDS7U+LWchL2w74qPEBVh/+N
 wojwn6bn2cu1sKM9R5TiyLzzBQuMu
X-Received: by 2002:a19:6555:: with SMTP id c21mr28880090lfj.206.1642603466870; 
 Wed, 19 Jan 2022 06:44:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9xplJ8OzAXEh/bj3FKIbNUTXBos38Au1cXIZVLIjqKd4iH5vIZ8hhigWmrbsak+D0+LdE6g==
X-Received: by 2002:a19:6555:: with SMTP id c21mr28880074lfj.206.1642603466716; 
 Wed, 19 Jan 2022 06:44:26 -0800 (PST)
Received: from lukenow-XPS-13-9380.. (d83-110.icpnet.pl. [77.65.83.110])
 by smtp.gmail.com with ESMTPSA id bt18sm2036843lfb.50.2022.01.19.06.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jan 2022 06:44:26 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Wed, 19 Jan 2022 06:44:08 -0800
Message-Id: <2a49929d166ac88d4c7900c5961be77cbd601fa4.1642601554.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 06/16] API/cgroup: Change to TWARN when v2 controllers
 change
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

When the v1 blkio controller is mounted it unmounts the v2 io controller
effectively bringing the amount of cgroupv2 controllers down and
triggering the tst_brk. Because this is exected behaivor it should be
changed to TWARN in case there is something funny still going on and
should be logged.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
 lib/tst_cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 3d56a3364..c53b88ed2 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -677,7 +677,7 @@ static void cgroup_root_scan(const char *const mnt_type,
 		goto discard;
 
 	if (root->ctrl_field)
-		tst_brk(TBROK, "Available V2 controllers are changing between scans?");
+		tst_res(TWARN, "Available V2 controllers are changing between scans?");
 
 	root->ver = TST_CGROUP_V2;
 
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
