Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092C4C433EF
	for <ltp@archiver.kernel.org>; Thu,  3 Feb 2022 10:18:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 735193C9A68
	for <ltp@archiver.kernel.org>; Thu,  3 Feb 2022 11:18:29 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1FA573C06C4
 for <ltp@lists.linux.it>; Thu,  3 Feb 2022 11:18:17 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BDE7114004FD
 for <ltp@lists.linux.it>; Thu,  3 Feb 2022 11:18:16 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id DC19E210F1;
 Thu,  3 Feb 2022 10:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1643883495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZPNrkI7/eEMyoe1WdPh/vILTkYI4XhE03TK70ppB1K8=;
 b=hj1y6ria5thaDRD5QXJUq3ly1wHh6RK0WSjLQ3A6f49XZDbtljc9mha4UI1MRb79qf2OYw
 7s/DpzzwvIp9GMikgIKIfKPLLuS3q4LGh8JRP9XITvYgCoGQqNM7zxqwqt1Mt5CUJHMiWZ
 jEGHphxhFLRupGDZ27W+6fvgPZKEHHI=
Received: from g78.suse.de (rpalethorpe.udp.ovpn1.nue.suse.de [10.163.24.138])
 by relay2.suse.de (Postfix) with ESMTP id 8D611A3B87;
 Thu,  3 Feb 2022 10:18:15 +0000 (UTC)
To: ltp@lists.linux.it
Date: Thu,  3 Feb 2022 10:18:03 +0000
Message-Id: <20220203101803.10204-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <YfPiW998P4/j7RWi@pevik>
References: <YfPiW998P4/j7RWi@pevik>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Create policy for testing unstable kernel features
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

It's not clear if anything more than this is required for now.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---

 doc/test-writing-guidelines.txt | 10 ++++++++++
 runtest/staging                 |  1 +
 2 files changed, 11 insertions(+)
 create mode 100644 runtest/staging

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 1fa751ed5..8ca014d45 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -334,3 +334,13 @@ It's easier to maintain a '.gitignore' file per directory with tests, rather
 than having single file in the project root directory. This way, we don't have
 to update all the gitignore files when moving directories, and they get deleted
 automatically when a directory with tests is removed.
+
+7 Testing pre-release kernel features
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Tests for features not yet in a mainline kernel release are accepted. However
+they must only be added to the +staging+ runtest file. Once a feature is part
+of the stable kernel ABI the associated test must be moved out of staging.
+
+This is primarily to help test kernel RCs by avoiding the need to download
+separate LTP patchsets.
diff --git a/runtest/staging b/runtest/staging
new file mode 100644
index 000000000..ef1cdea15
--- /dev/null
+++ b/runtest/staging
@@ -0,0 +1 @@
+# Tests for features that are not yet in the stable kernel ABI
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
