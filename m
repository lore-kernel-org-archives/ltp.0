Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B9CC3DA7D
	for <ltp@archiver.kernel.org>; Tue,  3 Jan 2023 17:51:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 005AF3CCEAA
	for <ltp@archiver.kernel.org>; Tue,  3 Jan 2023 18:51:44 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C30AD3CCED0
 for <ltp@lists.linux.it>; Tue,  3 Jan 2023 18:51:07 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 28379600294
 for <ltp@lists.linux.it>; Tue,  3 Jan 2023 18:51:07 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CAD5133E2C;
 Tue,  3 Jan 2023 17:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1672768266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CrWCENAOqWHYFpC0QeTj9Hhae1Jq0bvWCJC2qvoEjRo=;
 b=WGgJ9fWV4KYX53kH5NHj5SFFv9Q8OzI/GqsGHgD9FTnrF5YIFdqYkkpVqQrv1X8fbG2dnC
 rWBxKfMWm17cMqZjHyBZSIpEtpbyDWw+b3wxVC4r76jg8YNNyxaclyZpXRIi60qc/kwB1L
 HKuoLIbxxJVL3zfuOjvyfytsPGtdeZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1672768266;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CrWCENAOqWHYFpC0QeTj9Hhae1Jq0bvWCJC2qvoEjRo=;
 b=BTyCICtzCbVqCJPY+Egfcf6187NM3Wk6blpdnjyJwcQ8zTWuFY8XWcdNgT62ChtW3N4DNd
 hcHSvFsG4J3kBmAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5FF4E1390C;
 Tue,  3 Jan 2023 17:51:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mGKlFAprtGOHNgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 03 Jan 2023 17:51:06 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 Jan 2023 18:50:59 +0100
Message-Id: <20230103175059.16328-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103175059.16328-1-pvorel@suse.cz>
References: <20230103175059.16328-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] doc/API: Link to minimal supported kernel version
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/c-test-api.txt     | 3 +++
 doc/shell-test-api.txt | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index a3ee9cab47..a7dd59dac5 100644
--- a/doc/c-test-api.txt
+++ b/doc/c-test-api.txt
@@ -603,6 +603,9 @@ if (tst_kvercmp2(4, 4, 27, kvers) < 0)
 WARNING: The shell 'tst_kvercmp' maps the result into unsigned integer - the
          process exit value.
 
+NOTE: See also LTP
+      https://github.com/linux-test-project/ltp/wiki/Supported-kernel,-libc,-toolchain-versions#13-minimal-supported-kernel-version[minimal supported kernel version].
+
 1.7 Fork()-ing
 ~~~~~~~~~~~~~~
 
diff --git a/doc/shell-test-api.txt b/doc/shell-test-api.txt
index b1e6c1b1dd..e5c9186605 100644
--- a/doc/shell-test-api.txt
+++ b/doc/shell-test-api.txt
@@ -693,6 +693,9 @@ prefixed by distribution which when matched take precedence, e.g. '6.1 RHEL9:5.1
 For more info see 'tst_kvercmp()' and 'tst_kvercmp2()' in
 https://github.com/linux-test-project/ltp/wiki/C-Test-API#16-runtime-kernel-version-detection[C Test API].
 
+NOTE: See also LTP
+      https://github.com/linux-test-project/ltp/wiki/Supported-kernel,-libc,-toolchain-versions#13-minimal-supported-kernel-version[minimal supported kernel version].
+
 tst_fs_has_free
 +++++++++++++++
 
-- 
2.39.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
