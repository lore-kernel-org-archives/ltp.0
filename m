Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAAFC433EF
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 23:19:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 02F453CA3CF
	for <ltp@archiver.kernel.org>; Sat,  5 Mar 2022 00:19:31 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 52AB33CA40E
 for <ltp@lists.linux.it>; Sat,  5 Mar 2022 00:18:41 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DBA106011F6
 for <ltp@lists.linux.it>; Sat,  5 Mar 2022 00:18:40 +0100 (CET)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CDF7C3F615
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 23:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1646435916;
 bh=7FLhQWfaTyAc6FEReU9cSn3eSEM5kpFVpfybQQdVxaE=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=Jd5pINk9giOr4bFBmRBJ13qYl8c8Rgw31VUcvEYmoDOdYlMcxTs9lQ4ehAdAlAwuA
 YwVjP1O/9eq8IzBkYtzJ0cnaKRLpsCAbhH77+E1WEGBXXZNf0hL1kcdSB9yxvR9aZb
 Rwd3YpQQVoe3VRGC47EBGC9NboppnFlVPKRN8xu0/6uHSOV0ieC5cmfA/Uf2jfLUER
 5uAFSxPeINOMv6FOIozvlIJm23Mq+Gi/boHm4ITjRkG/mAbziLsB37t7LuV3z8Kh6C
 sGJOzJ2SwU04zHpahLX/luc2xs2IEGBMa2OPVRHWexywyePjkpd9nvX6CZ0LN8o3fq
 XoV60HkXNIGIw==
Received: by mail-pf1-f200.google.com with SMTP id
 w68-20020a62dd47000000b004f6aa5e4824so2697156pff.4
 for <ltp@lists.linux.it>; Fri, 04 Mar 2022 15:18:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7FLhQWfaTyAc6FEReU9cSn3eSEM5kpFVpfybQQdVxaE=;
 b=N6eoj7/TDOJ3VcoWXtnWllU1cRDzvMafatXNdQAiXYksEx9ze2o3ZNdIL5DtLZYZ88
 U1YifilfKV10n5pCPIjLC/3G09kMHZPhpcTzgJ+frA+ES+1hltEvsW9T2P/LLJLzbPBH
 GpkOV6EbCdVXHBsdut6f+GSlbexiQB8e2bRfj924vnaGPDPdtQfm2qgG8u/psPqL+5+t
 nSmFfDTKUmwalZ/+/TAwbTxk0Hog6z0UduCQUY/gnMnVqlqXyMKwGTSaElXzZkjNQjCn
 rg/AF9S00u6ClzLROMfVMMONF3rfmxypxtlXyP2LMQBLKaIV6j4UfzRb2jRHTeZ6Na2l
 XOmg==
X-Gm-Message-State: AOAM530vd4Qddz2yChXePwrSVX2/C/o4aN0EOg58LY3aJktRDGRwKDbW
 +b6qMNsLeUtFA8/beWlCZt34zmJUEvGXCGCjSd11jXpqdYZyYqJYVbssxZCKfiFwvVCZReMvPEb
 40FsPKWXW4PcVQRy50nBYDik8SwDB
X-Received: by 2002:a05:6a00:140f:b0:4e0:6995:9c48 with SMTP id
 l15-20020a056a00140f00b004e069959c48mr781197pfu.59.1646435913840; 
 Fri, 04 Mar 2022 15:18:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwlUJA7/1fcVnTK24tT93lz36ZFDPkLhA6EtXeAitQvnT4foJ/qzYzdeY38kFGN+1VIqD8kEA==
X-Received: by 2002:a05:6a00:140f:b0:4e0:6995:9c48 with SMTP id
 l15-20020a056a00140f00b004e069959c48mr781185pfu.59.1646435913561; 
 Fri, 04 Mar 2022 15:18:33 -0800 (PST)
Received: from luke-ubuntu.. (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101]) by smtp.gmail.com with ESMTPSA id
 h14-20020a63384e000000b00366ba5335e7sm5335760pgn.72.2022.03.04.15.18.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Mar 2022 15:18:32 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Fri,  4 Mar 2022 15:18:13 -0800
Message-Id: <ca52734dc2309252ed5bf2abd5f030693697403f.1646434670.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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

 lib/tst_cgroup.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 66e7a81d9..8f95064b3 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -354,6 +354,19 @@ static struct cgroup_ctrl *cgroup_find_ctrl(const char *const ctrl_name)
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
