Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82711C43334
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 20:54:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF9B93C9C35
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 22:54:11 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 95EA03C9D26
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 22:53:14 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 048F92009DB
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 22:53:13 +0200 (CEST)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 25C783F128
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 20:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1658436793;
 bh=HxmiFfbYO7OYNUZcBY7QFfMhvcbwJEhrv3wehiM/XDI=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=IxxTJaQXPl25w5jnfoa72Ts+Ff8rf2Q2MoaMPks8MOonEvwgw9foXhAcwRGt52+CL
 mijaD1drZGV/zhP9t3xB75fhc42J+DYNvt+SEMR19ijsmywCFV385O/3yY776lZNmK
 rrjFizS6bj/DncITk3oNAZWNBSijPqR/563RmsiZ+XFQNxBk1QkYiet+Ha2ESwJtXa
 Udlqi/VhBhJyPJeEG3KJR/lzm5R+VYZv8lHxfrc/ByLqjkZW1D7VnocKP+/Tleqf88
 E2QyHL4nUVszzFlaoadX1z71PPtuMGR5LkVjUZYaMduIbze/4mD7f3CnyApXrrJb6B
 hLvmnH5Gb1Kcw==
Received: by mail-pg1-f197.google.com with SMTP id
 66-20020a630645000000b0041a63d6c638so1354560pgg.2
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 13:53:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HxmiFfbYO7OYNUZcBY7QFfMhvcbwJEhrv3wehiM/XDI=;
 b=SapPyBiU5QN7Gy85AUuTqn1YhFJNrOeGKCA/NDCK0HPLe+D6Bk8INb6ZrIFY4EF6Iu
 +nQKJWJN6JlhTA6RTydncJzs2HNCxoodAQeQHFOOuDM4HGRjBV/g6GHPMV9NrJlJP7MO
 cxLVbE6gxKMVqlqUp27qylM8h1xvR40LXrRWMjFCCQbBsv1TKtsn3IcRjBImYm2kp+zN
 V8akpoTYFIq2CAXCy9gXcixunQ+epAHM9Jgcb36Jz9j+pxeSr3PS9p7X9Os0AUvYSJQG
 +QBu+APYtNPVl0w3RsnCuY6FuDvCMMT2KTxSMcviGA8atgso7I+X5JsKK5uZFOy+OA5S
 MReQ==
X-Gm-Message-State: AJIora//+RAMtmB9wAwOZ3x72GJ9XlEbSBqTF35htCF+07V072rZvpo6
 +AQ8q278v9k95Hv9ku78N5XRBS0j2xTC7ujO1zKTLLwxQoYXGcgVsEuifSZWjUUWVj5iN1JsK3p
 lO2JRHYOSE6YTGcsChBQFzBRlo1Lk
X-Received: by 2002:a17:903:2284:b0:16c:500f:b791 with SMTP id
 b4-20020a170903228400b0016c500fb791mr313623plh.78.1658436792388; 
 Thu, 21 Jul 2022 13:53:12 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vmK2rCxBe/1gcDCLgeVBfNY6yCUaTRvumE3+asYjvbn+uLJahtwyEeb9VRKdYTyir1exGqAw==
X-Received: by 2002:a17:903:2284:b0:16c:500f:b791 with SMTP id
 b4-20020a170903228400b0016c500fb791mr313607plh.78.1658436792090; 
 Thu, 21 Jul 2022 13:53:12 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-75-80-146-43.san.res.rr.com.
 [75.80.146.43]) by smtp.gmail.com with ESMTPSA id
 c6-20020a656746000000b0041a4d5e7e5fsm1916364pgu.47.2022.07.21.13.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jul 2022 13:53:11 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it, rpalethorpe@suse.de, liwang@redhat.com, pvorel@suse.cz,
 chrubis@suse.cz
Date: Thu, 21 Jul 2022 13:52:14 -0700
Message-Id: <46af6d78ec4a1f6d0eb12da5d578b200f12e4281.1658433280.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 04/18] API/cgroup: Add CTRL_NAME_MAX define
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

Add a define for max controller name that will be useful for parsing
controller names from strings and helps avoid having unexplained numbers
in the codebase.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
 lib/tst_cgroup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 677a6f318..e9652703f 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -196,6 +196,7 @@ static const struct cgroup_file io_ctrl_files[] = {
 	{ }
 };
 
+#define CTRL_NAME_MAX 31
 /* Lookup tree for item names. */
 static struct cgroup_ctrl controllers[] = {
 	[0] = { "cgroup", cgroup_ctrl_files, 0, NULL, 0 },
@@ -966,7 +967,7 @@ static const struct cgroup_file *cgroup_file_find(const char *const file,
 {
 	const struct cgroup_file *cfile;
 	const struct cgroup_ctrl *ctrl;
-	char ctrl_name[32];
+	char ctrl_name[CTRL_NAME_MAX + 1];
 	const char *const sep = strchr(file_name, '.');
 	size_t len;
 
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
