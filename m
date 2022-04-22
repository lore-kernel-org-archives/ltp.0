Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E028EC433FE
	for <ltp@archiver.kernel.org>; Fri, 22 Apr 2022 14:42:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 27F823CA700
	for <ltp@archiver.kernel.org>; Fri, 22 Apr 2022 16:42:20 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE84A3C8765
 for <ltp@lists.linux.it>; Fri, 22 Apr 2022 16:41:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 11A53600A81
 for <ltp@lists.linux.it>; Fri, 22 Apr 2022 16:41:47 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 477F21F37F;
 Fri, 22 Apr 2022 14:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1650638507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Fz83nJPMPCC2r68ivaaEApdKA3NERHer8cHAyu5i8E=;
 b=2cfPM8qMVUOGOOjW6vxtRDgFOa1FXNZG8juUo95rx9asRt+/tOGpiFufzivkqtrTypz1YU
 2lCq50J8aoXijS1o3/3VfXRtt+N/7iVklKA8gx7leiOHhHgpZNB0yuWvjwpagYsJJbGhhk
 VquQw/d9EUOPiFveH1VQHweGK8nrPUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1650638507;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Fz83nJPMPCC2r68ivaaEApdKA3NERHer8cHAyu5i8E=;
 b=WCyYGYBOQ6xNfdvo12nhfYqBDCOHaesI0P74a5YVJtruSmQ5vLjCAOR37q4Jlhnrn0xEyu
 yJ562Kktu8yrFtDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E7EFE13AE1;
 Fri, 22 Apr 2022 14:41:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QCGMNaq+YmKUCwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 22 Apr 2022 14:41:46 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 22 Apr 2022 16:41:39 +0200
Message-Id: <20220422144141.16848-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220422144141.16848-1-pvorel@suse.cz>
References: <20220422144141.16848-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/4] doc: Update library API doc
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
Cc: Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

about conditional expansion for TST_{SETUP,CLEANUP}.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
* New in v2

 doc/library-api-writing-guidelines.txt | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/doc/library-api-writing-guidelines.txt b/doc/library-api-writing-guidelines.txt
index e75c838a15..9e926e9713 100644
--- a/doc/library-api-writing-guidelines.txt
+++ b/doc/library-api-writing-guidelines.txt
@@ -61,3 +61,23 @@ API source code is in 'tst_test.sh', 'tst_security.sh' and 'tst_net.sh'
 
 Changes in the shell API should not introduce uncommon dependencies
 (use basic commands installed everywhere by default).
+
+3.1 Shell libraries
+~~~~~~~~~~~~~~~~~~~
+
+Besides shell API libraries in 'testcases/lib' it's worth to put common code
+for particular tests into shell library. The filename should end '_lib.sh',
+they should load 'tst_test.sh' or 'tst_net.sh'.
+
+Shell libraries should have conditional expansion for 'TST_SETUP' or 'TST_CLEANUP',
+to avoid surprises when test specific setup/cleanup function is redefined by
+shell library.
+
+[source,sh]
+-------------------------------------------------------------------------------
+# ipsec_lib.sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+TST_SETUP=${TST_SETUP:-ipsec_lib_setup}
+. tst_test.sh
+...
+-------------------------------------------------------------------------------
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
