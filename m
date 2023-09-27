Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE1EE7F14E
	for <ltp@archiver.kernel.org>; Wed, 27 Sep 2023 13:04:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A22353CE189
	for <ltp@archiver.kernel.org>; Wed, 27 Sep 2023 15:04:57 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5834B3CAC37
 for <ltp@lists.linux.it>; Wed, 27 Sep 2023 15:04:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 035BA1400054
 for <ltp@lists.linux.it>; Wed, 27 Sep 2023 15:04:46 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 26B271F88F
 for <ltp@lists.linux.it>; Wed, 27 Sep 2023 13:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695819886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZGIMorTf0mT+dWd94GSUkglshDHjPnYfh/DFBx0BUSo=;
 b=u8HD2Zj0tQk9ENWIWuqzPbMN2anXIUh39SGs6piZVuiEkUTh6PE7g0QVryprnF5+pcJgBq
 fC7lNiKkI6a9YqeurNY1rkEK/oKrBbCG6E6ZJ0VRBSxvBQz9w335wScEoJvYQALXSbqpdp
 O8z4+W7ecVgTFlmzTZiGw9G2eNMy8Pg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695819886;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZGIMorTf0mT+dWd94GSUkglshDHjPnYfh/DFBx0BUSo=;
 b=3J5BP+6sUIVXDeYBa/TPzos4Kl5mfEP54XXGz5Zxa/Zogd5dbCgB3DFiCbSxs1OpMphJzn
 hdzUD3ZBPoDzOqBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1266B13479
 for <ltp@lists.linux.it>; Wed, 27 Sep 2023 13:04:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YNe0Am4oFGVnFAAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 27 Sep 2023 13:04:46 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 27 Sep 2023 15:05:29 +0200
Message-ID: <20230927130529.15183-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] metadata: fix default timeout value
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

It has been chnaged to 30 from 300.

Fixes: 0f72d519a95c ("Introduce a concept of max runtime")
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 metadata/parse.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/metadata/parse.sh b/metadata/parse.sh
index 1811665bf..69bf5db65 100755
--- a/metadata/parse.sh
+++ b/metadata/parse.sh
@@ -23,7 +23,7 @@ echo '  "scm_url_base": "https://github.com/linux-test-project/ltp/tree/master/"
 echo "  \"version\": \"$version\""
 echo ' },'
 echo ' "defaults": {'
-echo '  "timeout": 300'
+echo '  "timeout": 30'
 echo ' },'
 echo ' "tests": {'
 
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
