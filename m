Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DCAC433F5
	for <ltp@archiver.kernel.org>; Thu, 30 Dec 2021 10:38:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 04E163C55A0
	for <ltp@archiver.kernel.org>; Thu, 30 Dec 2021 11:38:29 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C14133C2604
 for <ltp@lists.linux.it>; Thu, 30 Dec 2021 11:37:38 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F0AFC1A00A27
 for <ltp@lists.linux.it>; Thu, 30 Dec 2021 11:37:37 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 508BD2113A;
 Thu, 30 Dec 2021 10:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1640860657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dk/0oGnFnTla1g+nF7QYRFaksOlhKSzXmnoIi7xJPtg=;
 b=Wfv+pbTbDaDVj2clpZv6jf9fgfb5fcYggHL7/HIyzs8CWVYJ87ZYTcKI1t3l6tZOoJLMAv
 OTibjbvPyiVwxWbetXTqQioUu3aV1RU49rv1VBa07GMUJfCJRAU9jBkmcqeIomgeXIYi2H
 Q0GO5EcuWa9sqNPFUog5no34FGZOCTk=
Received: from g78.suse.de (rpalethorpe.udp.ovpn1.nue.suse.de [10.163.24.42])
 by relay2.suse.de (Postfix) with ESMTP id 0DEF2A3B87;
 Thu, 30 Dec 2021 10:37:37 +0000 (UTC)
To: ltp@lists.linux.it
Date: Thu, 30 Dec 2021 10:37:15 +0000
Message-Id: <20211230103718.369-2-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211230103718.369-1-rpalethorpe@suse.com>
References: <20211220131043.18894-1-rpalethorpe@suse.com>
 <20211230103718.369-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/5] API/cgroup: Add memory.stat
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_cgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index c78f28112..2ef599d9e 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -153,6 +153,7 @@ static const struct cgroup_file cgroup_ctrl_files[] = {
 static const struct cgroup_file memory_ctrl_files[] = {
 	{ "memory.current", "memory.usage_in_bytes", CTRL_MEMORY },
 	{ "memory.max", "memory.limit_in_bytes", CTRL_MEMORY },
+	{ "memory.stat", "memory.stat", CTRL_MEMORY },
 	{ "memory.swappiness", "memory.swappiness", CTRL_MEMORY },
 	{ "memory.swap.current", "memory.memsw.usage_in_bytes", CTRL_MEMORY },
 	{ "memory.swap.max", "memory.memsw.limit_in_bytes", CTRL_MEMORY },
-- 
2.34.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
