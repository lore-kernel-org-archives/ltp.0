Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F6C8C00140
	for <ltp@archiver.kernel.org>; Mon,  8 Aug 2022 11:38:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F6E43C9539
	for <ltp@archiver.kernel.org>; Mon,  8 Aug 2022 13:38:12 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C5DF3C91F1
 for <ltp@lists.linux.it>; Mon,  8 Aug 2022 13:38:02 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DFF776006E6
 for <ltp@lists.linux.it>; Mon,  8 Aug 2022 13:38:01 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 45BD220B66;
 Mon,  8 Aug 2022 11:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659958681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m2B6QpTyz9udmWdGc6xYWYdMsbdBOhN81v/twKgGsos=;
 b=mhmu2/58Zcxu+HF8vx7cGYkehqnCNyGAZSS+peEkIFsoYRNAFRdF1O31UReIWbuB0Rc6jZ
 1ui0xtwnR58KPT2JlsKjwmP3sZqLDDj2KFYT/s6BHCmb3q/5dxGhabmE1ee18hEWMyMqXI
 8XHOJmZZofYD0++aZiCzP+VsiOdiMYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659958681;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m2B6QpTyz9udmWdGc6xYWYdMsbdBOhN81v/twKgGsos=;
 b=WOqI7NmamqGE8X0JpaGgVvkP9l4PSJrAXtJj1R5qapjzhX9WxGLdC7x5AgAR6h08x6Zy2q
 1563kQCNDbEfZGDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1199513AB3;
 Mon,  8 Aug 2022 11:38:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YO6aApn18GJ0LgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 08 Aug 2022 11:38:01 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  8 Aug 2022 13:37:53 +0200
Message-Id: <20220808113756.11582-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808113756.11582-1-pvorel@suse.cz>
References: <20220808113756.11582-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/4] tst_test.sh: runtest.sh: Remove unused code
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

This code is in tst_print_colored() (probably forgotten to remove code
from tst_test.sh in a7f613372 when moved to tst_print_colored during
development; later copy wrong code in d132084bc into runtest.sh).

Fixes: a7f613372 ("Colorize test type in the output")
Fixes: d132084bc ("lib: Add script for running tests")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/newlib_tests/runtest.sh | 3 ---
 testcases/lib/tst_test.sh   | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/lib/newlib_tests/runtest.sh b/lib/newlib_tests/runtest.sh
index f136bcb88..e78b556c5 100755
--- a/lib/newlib_tests/runtest.sh
+++ b/lib/newlib_tests/runtest.sh
@@ -48,9 +48,6 @@ runtest_res()
 	local res="$1"
 	shift
 
-	tst_color_enabled
-	local color=$?
-
 	printf "runtest " >&2
 	tst_print_colored $res "$res: " >&2
 	echo "$@" >&2
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index a35fa2e7b..356af0106 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -112,9 +112,6 @@ tst_res()
 	local res=$1
 	shift
 
-	tst_color_enabled
-	local color=$?
-
 	_tst_inc_res "$res"
 
 	printf "$TST_ID $TST_COUNT " >&2
-- 
2.37.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
