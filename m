Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D067C43334
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 20:54:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 371A63C9E93
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 22:54:01 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 72D2C3C9A5D
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 22:53:14 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 047EF20004A
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 22:53:13 +0200 (CEST)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EF7C03F11B
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 20:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1658436792;
 bh=P+imqzZRtIbo7EXhr+N6KiUT9ZmZo9StcJVTryUo8SU=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=JMeOtiSwrNZvL++WPuWo88WbHK22HcqvAOsoLzMaukOPD88dTADtgNPKeekFVYgOl
 5D8jIYr4LEYxI6uC+1Fcqm3AAtmiXtuiHpQQW4qCVl8QobYVhmmjCkDZsF8Tdv+P0v
 QBy6Kw6OzT9DmO3dnQiirqPLVCKoMjm14iFV2L2shgLc163lLvltFAnEZDPsX92hW9
 Gol+cCsQEAlZgPC5PBDMfAXYjCFJ4iwAobJNWfx1dmUJFRoWEDVHun80m6rf1JTcTw
 jHZnLLaCM00oMHtxhg9EWNt4KWt51R+pTx70WrOWZWK0kCuULjCLlMmsW4pYbQFTnj
 cIab8wPE1/vHg==
Received: by mail-pl1-f197.google.com with SMTP id
 i9-20020a170902cf0900b0016d1e277547so1674067plg.0
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 13:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=P+imqzZRtIbo7EXhr+N6KiUT9ZmZo9StcJVTryUo8SU=;
 b=UmnctNmfJCw+03iOMO1nXH7nlf/5MCAppyIFrI+wPDFQ62+t2K5ssGc5zI6w147r70
 jYegDycru0SEnHT85sv47uyD1MIHDEmB95V1VcbX6UZ2sb5Lx5ceDjVziD9HBSw01wgu
 VbsBu9NQUpnFI35BjPzMqC7/IV5sHRPyZ4Ttbdf/doXsIm2wdZzG+CIcaox5Zuq1vJ9d
 n5VbAGElv436hG43E+ofi3HPbEz4MYLd0NuP31i/PzfOia0im3JYSAmSTkUukG6XcKLC
 fqMDXiXuAk8UIGfmgoQYg9qbwm5RktLJmYpWTllKE7buek9tnn5h+uMfkIZN437YmBVx
 yP6A==
X-Gm-Message-State: AJIora8mi4NBQdslUiBvvQlt+UZuanE6/UuFuyTdWUhzkmHoEL/PDxWU
 KAckl+iPFkdedUEUPiHDTQvegwJcahnSvtZuWTsJLzFSmNIPpCyhHVhlmQFjpd4QXDU6o/iD4jl
 i6cZGKl2+i1z4T2oxTg/SCRFQb64f
X-Received: by 2002:a63:7c49:0:b0:40c:b3f9:18c5 with SMTP id
 l9-20020a637c49000000b0040cb3f918c5mr193664pgn.588.1658436791222; 
 Thu, 21 Jul 2022 13:53:11 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ve6BnF6UdNqMFU9pfOJg5pyqDIdJFJGXtjr6YGylPo/K+GWQMRGl1EFPPapsqAAwLcve745Q==
X-Received: by 2002:a63:7c49:0:b0:40c:b3f9:18c5 with SMTP id
 l9-20020a637c49000000b0040cb3f918c5mr193648pgn.588.1658436790945; 
 Thu, 21 Jul 2022 13:53:10 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-75-80-146-43.san.res.rr.com.
 [75.80.146.43]) by smtp.gmail.com with ESMTPSA id
 c6-20020a656746000000b0041a4d5e7e5fsm1916364pgu.47.2022.07.21.13.53.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jul 2022 13:53:10 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it, rpalethorpe@suse.de, liwang@redhat.com, pvorel@suse.cz,
 chrubis@suse.cz
Date: Thu, 21 Jul 2022 13:52:13 -0700
Message-Id: <3280b1912e28489c64abe5c16f3e4cf6866ff8e9.1658433280.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 03/18] API/cgroup: Add cgroup_find_root helper
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
index d757c832f..677a6f318 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -362,6 +362,19 @@ static struct cgroup_ctrl *cgroup_find_ctrl(const char *const ctrl_name)
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
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
