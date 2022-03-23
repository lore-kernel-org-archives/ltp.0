Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4371BC433F5
	for <ltp@archiver.kernel.org>; Wed, 23 Mar 2022 19:05:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE0C33C97C5
	for <ltp@archiver.kernel.org>; Wed, 23 Mar 2022 20:05:38 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 12B243C1A87
 for <ltp@lists.linux.it>; Wed, 23 Mar 2022 20:04:39 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7BDCA601115
 for <ltp@lists.linux.it>; Wed, 23 Mar 2022 20:04:39 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1245E210FB;
 Wed, 23 Mar 2022 19:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1648062279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jyO6hJoH+/z+NirgC16wKzQJ1kWV5w4ZBtwz/2X1ITc=;
 b=DNWk2LimrgfXeFouztbFPyayheUqWRfIbMgs56o9oEHlGOs8fWJIhBEd3t4k6kOhWIRDBi
 DMO2TYQQY8Iw88fVpa8EkkQC2JieJYeqaYN4d3VI+4aLG7iqb/LBgFnASfsGXHFUE05+Ur
 eX/rXyz0gsYeUegjMiZpMCRX1zL9sSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1648062279;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jyO6hJoH+/z+NirgC16wKzQJ1kWV5w4ZBtwz/2X1ITc=;
 b=0Sq7LOeyPlPiAw4a9PE/uDHx70Uf/3pTuDC4ZSYLknp2xyeJ+IImykOFYuczNpTcgc8oph
 wQo/7QFQh0MhSwAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA7B413302;
 Wed, 23 Mar 2022 19:04:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wD2SLkZvO2KQRwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 23 Mar 2022 19:04:38 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 23 Mar 2022 20:04:32 +0100
Message-Id: <20220323190433.18821-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323190433.18821-1-pvorel@suse.cz>
References: <20220323190433.18821-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/4] tst_test.sh: Improve pattern for allowed variables
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

to allow using '... $TST_FOO'

i.e. without filtering '
EXPECT_PASS "grep '$TST_MNTPOINT $TST_FS_TYPE' /proc/mounts"
would produce warning:
tst_mount_device 1 TWARN: Reserved variable TST_FS_TYPE' used!
because sed filters it as: FS_TYPE'

Will be needed for next commit.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index e411ee9192..0d289eb097 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -621,7 +621,7 @@ tst_run()
 	local _tst_name
 
 	if [ -n "$TST_TEST_PATH" ]; then
-		for _tst_i in $(grep '^[^#]*\bTST_' "$TST_TEST_PATH" | sed 's/.*TST_//; s/[="} \t\/:`].*//'); do
+		for _tst_i in $(grep '^[^#]*\bTST_' "$TST_TEST_PATH" | sed 's/.*TST_//; s/[="} \t\/:`'"'"'].*//'); do
 			case "$_tst_i" in
 			DISABLE_APPARMOR|DISABLE_SELINUX);;
 			SETUP|CLEANUP|TESTFUNC|ID|CNT|MIN_KVER);;
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
