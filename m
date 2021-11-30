Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D32FEC433FE
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 10:42:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E63FB3C6751
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 11:42:29 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 967453C4E59
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 11:42:20 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 20DCA100126C
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 11:42:19 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2E53D212B5
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 10:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638268939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KEOvI0xhOX44oKPsagGg060rAh5yRj7j6RnlYFVJtE4=;
 b=L6+vXZuVCyD6oTzABQ2Q08mycxibabN7CbgLYiCLNDZMSWa4uR8jlrfnUozZ+VuSz04xCr
 6EsggC78aZsPmgT5Nx/1Vb9vIZj9Ec/v998Oj/01i/jaiq0Hw2v/8nqdX4j1CIlQel47oK
 1C81aAdquaE+uY1IVtFnaNLP4cmekQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638268939;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KEOvI0xhOX44oKPsagGg060rAh5yRj7j6RnlYFVJtE4=;
 b=ZznXjrORwLM1lBZgpKCfHXNSk0Ao2GlnUKOG0LjNNUZdtUxHi4X14kuVEItBRq1n5ojpsr
 rcTQDd+k0XwnCJAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B12113C44
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 10:42:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7VhmBQsApmFyPQAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 10:42:19 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 30 Nov 2021 11:43:30 +0100
Message-Id: <20211130104330.32679-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] scripts/checkpatch.pl: Replace kstrto with tst_parse_
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

Since there is no kstrto*() family of functions in LTP we do have
tst_parse_*() instead.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 87572b2f4..8c74d07b4 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6891,7 +6891,7 @@ sub process {
 				if ($count == 1 &&
 				    $format =~ /^"\%(?i:ll[udxi]|[udxi]ll|ll|[hl]h?[udxi]|[udxi][hl]h?|[hl]h?|[udxi])"$/) {
 					WARN("SSCANF_TO_KSTRTO",
-					     "Prefer kstrto<type> to single variable sscanf\n" . "$here\n$stat_real\n");
+					     "Prefer tst_parse_<type> to single variable sscanf\n" . "$here\n$stat_real\n");
 				}
 			}
 		}
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
