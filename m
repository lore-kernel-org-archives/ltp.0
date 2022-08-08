Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2C2C25B06
	for <ltp@archiver.kernel.org>; Mon,  8 Aug 2022 07:15:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5BA883C9483
	for <ltp@archiver.kernel.org>; Mon,  8 Aug 2022 09:15:17 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 04DC03C712D
 for <ltp@lists.linux.it>; Mon,  8 Aug 2022 09:14:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BF7461A003FD
 for <ltp@lists.linux.it>; Mon,  8 Aug 2022 09:14:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 09C4734D77;
 Mon,  8 Aug 2022 07:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659942885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kf0n4ATOm9GTIC32uKn9BaN65qksN99kGsYGVisXXhs=;
 b=TAVXF2LjOBJRgH3A0XO+KgqO6C9ujEINgsz+DNVZ99ubnxTgBrm3hcJINcshVgpA9PfuAV
 LF5rVoEh8v2elQJdUiRorQ9hXJxWYzQrLNA6eCcfPZpgD5ih1gJB+X0xoXuCYjB169htEF
 rKaoAWGZjjRqF/gewinSkIelNY1Y45Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659942885;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kf0n4ATOm9GTIC32uKn9BaN65qksN99kGsYGVisXXhs=;
 b=Y14LJxZF4si2vHqggJ7q28cDjfUkipHYwRxSezoGA1ufagdiJvHAPCQMGJ3PHVhNDDWaj9
 5s9sDJ36FRIjbFDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C721713A7C;
 Mon,  8 Aug 2022 07:14:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kGDMLuS38GLMLgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 08 Aug 2022 07:14:44 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  8 Aug 2022 09:14:38 +0200
Message-Id: <20220808071439.741-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808071439.741-1-pvorel@suse.cz>
References: <20220808071439.741-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] github: pull_request_template.md
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
Cc: Petr Vorel <pevik@users.noreply.github.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Petr Vorel <pevik@users.noreply.github.com>

Create pull request template to inform people that we prefer patches to
our mailing list. We have this info in README.md, but even experienced,
who send patches with git send-email to other projects overlook this
info and open github pull requests.

While at it, add links to the test case tutorial, lore and patchwork.

Template does not support any formatting, therefore using plain links.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
NOTE: you can test it if you fork from my fork:
https://github.com/pevik/ltp

 .github/pull_request_template.md | 6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 .github/pull_request_template.md

diff --git a/.github/pull_request_template.md b/.github/pull_request_template.md
new file mode 100644
index 000000000..68c8a6499
--- /dev/null
+++ b/.github/pull_request_template.md
@@ -0,0 +1,6 @@
+Although we *occasionally* also accept GitHub pull requests, the *preferred* way is sending patches to our mailing list: https://lore.kernel.org/ltp/
+
+There is an example how to use it: https://github.com/linux-test-project/ltp/wiki/C-Test-Case-Tutorial#7-submitting-the-test-for-review (using git format-patch and git send-email).
+
+LTP mailing list is archived: https://lore.kernel.org/ltp/.
+We also have a patchwork instance: https://patchwork.ozlabs.org/project/ltp/list/.
-- 
2.37.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
