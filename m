Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EB0C54EBE
	for <ltp@archiver.kernel.org>; Tue, 10 Jan 2023 08:47:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 277A93CCB18
	for <ltp@archiver.kernel.org>; Tue, 10 Jan 2023 09:47:40 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A2A173CB576
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 09:47:31 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9A3BD600197
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 09:47:29 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E3D274E2CE;
 Tue, 10 Jan 2023 08:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1673340448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fTqm2OUUDyacHHhpniO7+KdY48UceMSuGKEthSMrK1k=;
 b=HC4D24aQM0MVohssDayCBuEGZezNm9N2vogsLTN2Wm00T3WP6XKhzc03X4aIaA2/we+iyi
 kcIJ7940dKAziWW3Is05i+SGNr8+oOD/8W/HXjHVV5vkzrsI5D/qwFm7FbUN/j7qMSR6q3
 u2MUrTpaP2wE5juILE2cq7YZxvhZEEE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1673340448;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fTqm2OUUDyacHHhpniO7+KdY48UceMSuGKEthSMrK1k=;
 b=6zwKFeHlhKVydXFZ4+5imkXBRJ3F04rfvBagOKt0xe19d2upaCACgFP6gY3pZvnh6HVniM
 gKOcT7OwcleUE7DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8CB1913338;
 Tue, 10 Jan 2023 08:47:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AymyHiAmvWPHHAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 10 Jan 2023 08:47:28 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 10 Jan 2023 09:47:24 +0100
Message-Id: <20230110084724.19728-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] github: Improve pull request template
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

* Signed-off-by
* code style
* links to wiki (API, maintainer checklist, ...)
* wrap text in html comments (instructions will not be visible)

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .github/pull_request_template.md | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/.github/pull_request_template.md b/.github/pull_request_template.md
index 477f49c6bc..1082bcdd88 100644
--- a/.github/pull_request_template.md
+++ b/.github/pull_request_template.md
@@ -1,8 +1,22 @@
 [ type description here; PLEASE REMOVE THIS LINE AND THE LINES BELOW BEFORE SUBMITTING THIS PULL REQUEST ]
 
-Although we *occasionally* also accept GitHub pull requests, the *preferred* way is sending patches to our mailing list: https://lore.kernel.org/ltp/
-
+<!--
+* Although we *occasionally* also accept GitHub pull requests, the *preferred* way is sending patches to our mailing list: https://lore.kernel.org/ltp/
 There is an example how to use it: https://github.com/linux-test-project/ltp/wiki/C-Test-Case-Tutorial#7-submitting-the-test-for-review (using git format-patch and git send-email).
-
 LTP mailing list is archived at: https://lore.kernel.org/ltp/.
 We also have a patchwork instance: https://patchwork.ozlabs.org/project/ltp/list/.
+
+* Commits should be signed: Signed-off-by: Your Name <me@example.org>, see
+https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
+
+* New code should follow Linux kernel coding style, see
+https://www.kernel.org/doc/html/latest/process/coding-style.html.
+You can run 'make check' or 'make check-foo' in the folder with modified code to check style and common errors.
+
+* For more tips check
+https://github.com/linux-test-project/ltp/wiki/Maintainer-Patch-Review-Checklist
+https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines
+https://github.com/linux-test-project/ltp/wiki/C-Test-API
+https://github.com/linux-test-project/ltp/wiki/Shell-Test-API
+https://github.com/linux-test-project/ltp/wiki/C-Test-Case-Tutorial
+-->
-- 
2.39.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
