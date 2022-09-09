Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A5AECAAD3
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 14:19:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 310FE3CAA0B
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 16:19:41 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BCB393CAA10
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 16:18:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DEC1D200FEE
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 16:18:46 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5566221F3F;
 Fri,  9 Sep 2022 14:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662733125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VhzZHOFaji3bmpn4xAcyi2YRAYB8ORCaXrvafyfj9xo=;
 b=cj+D4RbPdcRUCxbC1W2sGbr9Cyb34DUEMnen2fK+FGufpRDCy/tnqjhk0vjr9Ykm8L+GF1
 IydOkJth2/3c0tW+3doV3//SaE5ls4OVz0V0O5xUdVY4Ff7F3imGOTdBeTOlJpiuDYZTG9
 vXHjyZSFCWVJqiqXJ8LaZEGWqbwOSV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662733125;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VhzZHOFaji3bmpn4xAcyi2YRAYB8ORCaXrvafyfj9xo=;
 b=KLsRRW6WDjnfYJvUWikUi4gYtDWOrgL29005y4yuYl+QKL1Z98EeGWGEtyUqn/0h47JoUf
 bQp1xjuLxXqApLDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C41AB13A93;
 Fri,  9 Sep 2022 14:18:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iLy1LURLG2NmWAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 09 Sep 2022 14:18:44 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  9 Sep 2022 16:18:31 +0200
Message-Id: <20220909141840.18327-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220909141840.18327-1-pvorel@suse.cz>
References: <20220909141840.18327-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 01/10] shell: Print mount command in tst_mount()
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

Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
The same as in v4

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
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
