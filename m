Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27867C433EF
	for <ltp@archiver.kernel.org>; Fri,  1 Apr 2022 22:01:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C5313CA304
	for <ltp@archiver.kernel.org>; Sat,  2 Apr 2022 00:01:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A274D3C9794
 for <ltp@lists.linux.it>; Sat,  2 Apr 2022 00:00:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BC4C2600C06
 for <ltp@lists.linux.it>; Sat,  2 Apr 2022 00:00:40 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 636841FD00;
 Fri,  1 Apr 2022 22:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1648850440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mUCW/xAAruP14iNx+RF6cvErxhW0QxXLMfhpteKY+74=;
 b=QvRrzme+zACk6vOAUS/rfkdiEyMmMbl9EeJtKrs1rAOwjVzzh7ahTV6s3wuK/o9J2hr28Z
 rAj5nlofRwgSmiaBxajafWdYiPHKkod2SWgmfBIgXxSgWzLcBiiVCsJhRE/8snmxyVhWd8
 iEJTEHAMNpKEIZFVrJvbFH5pzr8PHGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1648850440;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mUCW/xAAruP14iNx+RF6cvErxhW0QxXLMfhpteKY+74=;
 b=Ad1YgCaZFktVLZakdJGqvlz1Hgm0R01HP5Lx6nfnHDDEOHGymwgfaFzAujLXneRSlNhyIU
 EycU4FkrcBzq7dBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C03213A84;
 Fri,  1 Apr 2022 22:00:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EDekAAh2R2JMKwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 01 Apr 2022 22:00:40 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  1 Apr 2022 23:59:51 +0200
Message-Id: <20220401215951.13976-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220401215951.13976-1-pvorel@suse.cz>
References: <20220401215951.13976-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] doc: Update shell API examples
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/shell-test-api.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/shell-test-api.txt b/doc/shell-test-api.txt
index 4c16f36250..df5ebbdf0d 100644
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
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
