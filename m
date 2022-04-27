Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B493C433EF
	for <ltp@archiver.kernel.org>; Wed, 27 Apr 2022 12:50:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DAEB43CA5B0
	for <ltp@archiver.kernel.org>; Wed, 27 Apr 2022 14:50:52 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B2553C0677
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 14:50:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CACA1600810
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 14:50:08 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7AF591F750;
 Wed, 27 Apr 2022 12:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651063808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yQ9SJ+Qf3Qw6pwrpKPny9eMlMH0dKOxxJ4iB69WyJxk=;
 b=KPZWKwnlNSd8wccU2moYe9MU06VHcZy9iHxYgS2W59e1Nt5hYXq/yDGnTk8U8HLWH+UQIp
 g2lwO7VLgdVVWjlqMQiuunPPqiR2XseMxvTYsZJqT7TLvXfMSn8HAHi2kmwhAQ931PFe62
 BWfR50vc6GGbt5UC+heU0IAovQl67EY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651063808;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yQ9SJ+Qf3Qw6pwrpKPny9eMlMH0dKOxxJ4iB69WyJxk=;
 b=m/7NOcHlhwqNhfI7ltP/QhApP/JKsVJS+awgxFYrIa6cU/QkfGq7CAGabVI6zCt3qNDdnX
 QXELFtBqbgJY2sAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 43F2013AED;
 Wed, 27 Apr 2022 12:50:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8PhwDwA8aWK5RgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 27 Apr 2022 12:50:08 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 27 Apr 2022 14:50:03 +0200
Message-Id: <20220427125003.20815-6-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220427125003.20815-1-pvorel@suse.cz>
References: <20220427125003.20815-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 5/5] doc: Update shell API examples
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

Reviewed-by: Martin Doucha <mdoucha@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
changes v2->v3:
* remove last sentence from docs

 doc/library-api-writing-guidelines.txt | 4 ++--
 doc/shell-test-api.txt                 | 8 ++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/doc/library-api-writing-guidelines.txt b/doc/library-api-writing-guidelines.txt
index 08468f2fc..3b8c1d97d 100644
--- a/doc/library-api-writing-guidelines.txt
+++ b/doc/library-api-writing-guidelines.txt
@@ -78,7 +78,7 @@ shell library.
 -------------------------------------------------------------------------------
 # ipsec_lib.sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-TST_SETUP=${TST_SETUP:-ipsec_lib_setup}
-. tst_test.sh
+TST_SETUP="${TST_SETUP:-ipsec_lib_setup}"
 ...
+. tst_test.sh
 -------------------------------------------------------------------------------
diff --git a/doc/shell-test-api.txt b/doc/shell-test-api.txt
index 4c16f3625..df5ebbdf0 100644
--- a/doc/shell-test-api.txt
+++ b/doc/shell-test-api.txt
@@ -40,6 +40,7 @@ do_test()
 	fi
 }
 
+. tst_test.sh
 tst_run
 -------------------------------------------------------------------------------
 
@@ -90,6 +91,7 @@ test2()
 	tst_res TPASS "Test $1 passed"
 }
 
+. tst_test.sh
 tst_run
 # output:
 # foo 1 TPASS: Test 1 passed
@@ -118,6 +120,7 @@ do_test()
 	esac
 }
 
+. tst_test.sh
 tst_run
 # output:
 # foo 1 TPASS: Test 1 passed
@@ -145,6 +148,7 @@ do_test()
 	tst_res TPASS "Test $1 passed with data '$2'"
 }
 
+. tst_test.sh
 tst_run
 # output:
 # foo 1 TPASS: Test 1 passed with data 'foo'
@@ -174,6 +178,7 @@ do_test()
 	esac
 }
 
+. tst_test.sh
 tst_run
 # output:
 # foo 1 TPASS: Test 1 passed with data 'foo'
@@ -278,6 +283,7 @@ do_test()
 	...
 }
 
+. tst_test.sh
 tst_run
 -------------------------------------------------------------------------------
 
@@ -337,6 +343,7 @@ do_test()
 	...
 }
 
+. tst_test.sh
 tst_run
 -------------------------------------------------------------------------------
 
@@ -379,6 +386,7 @@ do_test()
 	...
 }
 
+. tst_test.sh
 tst_run
 -------------------------------------------------------------------------------
 
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
