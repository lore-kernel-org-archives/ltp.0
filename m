Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9C5C77B7F
	for <ltp@archiver.kernel.org>; Fri,  5 May 2023 14:56:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D4C193CB73A
	for <ltp@archiver.kernel.org>; Fri,  5 May 2023 16:56:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 982EB3CB37F
 for <ltp@lists.linux.it>; Fri,  5 May 2023 16:56:28 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1723C200DAC
 for <ltp@lists.linux.it>; Fri,  5 May 2023 16:56:27 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F3B1E20091
 for <ltp@lists.linux.it>; Fri,  5 May 2023 14:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683298586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PHrW94uUtoT8ieHteAvIGnXqdicepY9HqmKmJz1b4sc=;
 b=BR5tHIrFRGF8nPuDjwu6so2nebFjWNPHSYpl91tKqLWCj1nOgUPZKIesYg/BGTtpqDH/C2
 3I8KA2sSxX5JpAZWn0/yL/2B7dSMaGA4wWReUhXNujQTWXk+vzSyesH0gakI0vAH7wMOc9
 KcvcEcqomOH0vZPrWt8UmKGHVG/1nAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683298586;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PHrW94uUtoT8ieHteAvIGnXqdicepY9HqmKmJz1b4sc=;
 b=uKaKyD/g1F4iesH6kZopmH4Pto0DZIYgnO1e19DHJxbjKGaGDZ0/Qf0dE/MCIEG1C/iVN2
 0ancmwncK3gxmrDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DAD0913513
 for <ltp@lists.linux.it>; Fri,  5 May 2023 14:56:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kPujNBoZVWTXAQAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 05 May 2023 14:56:26 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  5 May 2023 16:56:26 +0200
Message-Id: <20230505145626.2537-3-mdoucha@suse.cz>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230505145626.2537-1-mdoucha@suse.cz>
References: <20230505145626.2537-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] doc: Fix typo in max_runtime docs
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

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 doc/c-test-api.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index bd9ec72b9..dcb6e1ba8 100644
--- a/doc/c-test-api.txt
+++ b/doc/c-test-api.txt
@@ -102,7 +102,7 @@ that should cover the duration of test setup and cleanup plus some safety.
 Any test that runs for more than a second or two has to make sure to:
 
 - set the runtime either by setting the '.max_runtime' in tst_test or by
-  calling 'tst_set_runtime()' in the test setup
+  calling 'tst_set_max_runtime()' in the test setup
 
 - monitor remaning runtime by regular calls to 'tst_remaining_runtime()' and
   exit when runtime has been used up
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
