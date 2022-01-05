Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D73AC433EF
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 10:00:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AC1393C9235
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 11:00:25 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5CBA93C222E
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 11:00:15 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E8E201A00E05
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 11:00:14 +0100 (CET)
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7D6A13F225
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 10:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1641376814;
 bh=x6HHrFlMrJ8CJ7ujsVswADiWR9Tes2WA/9a5JYo9nuU=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=nVQXuXykT9/3Fm8PmWjGNBP+KbY2kPmbWKK9vj7IojWNDmfmHK04UNf/DaPtyyjiN
 5UFN8aFE4ntCNjUweYsWcQk0yYoRO7/urtyObmhEMSUBS6adK8waP33Li81VjCS/jf
 Exq3ymBsxFWv4LAQ0S0ppYZoHDHsSNAuVR7vxRp99F1xlRlsOL9XoPwUJTUU83QCrd
 ZWqQlYyMulj5f/7GvRh4zAyO7htwynfEYBS3+V9iaV+1VQy3l6ktJ0glSgw0LeIQGv
 r1QkAWgWbcQ8eplL2HH+8ItawnDfJqCCn0jcgSwKUNZG2mY3yj5NcjxmIn6YPv8+PU
 AnV/YfZbC6YCQ==
Received: by mail-lj1-f199.google.com with SMTP id
 g20-20020a2eb5d4000000b0022e0a6d890dso5234782ljn.15
 for <ltp@lists.linux.it>; Wed, 05 Jan 2022 02:00:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=x6HHrFlMrJ8CJ7ujsVswADiWR9Tes2WA/9a5JYo9nuU=;
 b=H/DYuEA2gwojuztBS5cpNZF1aaFMHwDOWEK5WPN8OqH0oUx1tBmyYEPN83rwr8VX68
 CJz5OGEHlrp434hJg9Y6S2IAOZ1DNH0lwc2/njrIhDEJx70BZKVnUtxXToX0plFgrOd4
 w6hLKJnVdiptEzDdiTxXiP40sBUq+KWeexCpK7a55YkF+XbSC1hG02sabJBZ/QQh4QXm
 jx6Y3vIfLP40YI6fmCRFn+8YGKGrajQxFFc5XXJUYKNC2ohvPc6IeuPEDZZZR41GMH3O
 N2NxN187m1e9JxR3ea+nj7UQutjNlqlUM/rGbxM/ISCfvHijzQWDT2XN51n/+AIxif8y
 jPeQ==
X-Gm-Message-State: AOAM532FVS2OBLULNyvm9ZV0yyTSVp6UWdsGS55bapqYAOQZtCDtMcwH
 BeuNZ4mNwIKHlxnhTcE08TAvd/Rnq13ozdvXqMUgNud6rizwFBW7NY2UDZe2yWxuzMH8tFRvW1v
 AvIuuPhoi3eVo+UlmsU00I7XFSskL
X-Received: by 2002:a2e:bd88:: with SMTP id o8mr15455304ljq.134.1641376813265; 
 Wed, 05 Jan 2022 02:00:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyGFQuli00GO5OtsS1ZTz5o3JWyCU1h4ox2xDnWbAuft1uGDIbkmS2B1pUUifB22zgE6MCJRA==
X-Received: by 2002:a2e:bd88:: with SMTP id o8mr15455289ljq.134.1641376813009; 
 Wed, 05 Jan 2022 02:00:13 -0800 (PST)
Received: from lukenow-XPS-13-9380.home (159-205-75-251.adsl.inetia.pl.
 [159.205.75.251])
 by smtp.gmail.com with ESMTPSA id z25sm4152527lfq.20.2022.01.05.02.00.11
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jan 2022 02:00:12 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it
Date: Wed,  5 Jan 2022 02:00:03 -0800
Message-Id: <f69cdd6ec3cffc8d2bd5990feb131eb6be73a33e.1641376050.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1641376050.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1641376050.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/6] API/cgroup: Add cgroup_find_root helper function
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
 lib/tst_cgroup.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 166d0f97e..b06ae6ab7 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -365,6 +365,19 @@ static struct cgroup_ctrl *cgroup_find_ctrl(const char *const ctrl_name)
 	return ctrl;
 }
 
+static struct cgroup_root *cgroup_find_root(const char *const mnt_path)
+{
+	struct cgroup_root *root = roots;
+
+	while (root->ver && strcmp(root->mnt_path, mnt_path))
+		root++;
+
+	if (!root->ver)
+		root = NULL;
+
+	return root;
+}
+
 /* Determine if a mounted cgroup hierarchy is unique and record it if so.
  *
  * For CGroups V2 this is very simple as there is only one
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
