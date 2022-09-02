Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851E1C38145
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 13:37:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F8FF3CA8F9
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 15:37:36 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2FCC33CA844
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 15:37:16 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 460F81A01140
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 15:37:15 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A96D234693;
 Fri,  2 Sep 2022 13:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662125835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hW7d3upaQySdl4aJB3QpPDhybiZkidY6+3cVMy6YGpg=;
 b=zfPhpclHRu6v/boZFfugx+fN9sQd2PxVVVvr23rIb49VvsBvPImqPUYepbl6aDK0FTe+9L
 pTLLpmqp5PwuRKj+sPmm9WchcpcSSfSIJbJG5F3Pn8ncNc+UqP/zOiNxMLAeMYCyMYf6Kd
 vZ5T8f6chfYGiTgBjErCwmryUuOWpjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662125835;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hW7d3upaQySdl4aJB3QpPDhybiZkidY6+3cVMy6YGpg=;
 b=YLGEGmr01JgSjkwg+DTYD5WjTuR2zMUjIfaAuYsrfCb+wS2x8cySRAc2QPpQnD4/cPYEnq
 J/I+L+FtFCiswTDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 61EB11330E;
 Fri,  2 Sep 2022 13:37:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gAeUFgsHEmObBgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 02 Sep 2022 13:37:15 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  2 Sep 2022 15:37:02 +0200
Message-Id: <20220902133710.1785-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220902133710.1785-1-pvorel@suse.cz>
References: <20220902133710.1785-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/9] shell: Print mount command in tst_mount()
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_test.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index f884a278d..7c97b69fe 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -293,9 +293,11 @@ tst_mount()
 		mnt_opt="-t $TST_FS_TYPE"
 		mnt_err=" $TST_FS_TYPE type"
 	fi
+	local cmd="mount $mnt_opt $TST_DEVICE $TST_MNTPOINT $TST_MNT_PARAMS"
 
 	ROD_SILENT mkdir -p $TST_MNTPOINT
-	mount $mnt_opt $TST_DEVICE $TST_MNTPOINT $TST_MNT_PARAMS
+	tst_res TINFO "Mounting device: $cmd"
+	$cmd
 	local ret=$?
 
 	if [ $ret -eq 32 ]; then
-- 
2.37.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
