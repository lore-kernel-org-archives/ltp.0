Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CAC1C46467
	for <ltp@archiver.kernel.org>; Tue,  3 Jan 2023 17:51:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 30B813CCED0
	for <ltp@archiver.kernel.org>; Tue,  3 Jan 2023 18:51:34 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 033F23CCEA0
 for <ltp@lists.linux.it>; Tue,  3 Jan 2023 18:51:06 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6FF15600152
 for <ltp@lists.linux.it>; Tue,  3 Jan 2023 18:51:06 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2DDEE33E37;
 Tue,  3 Jan 2023 17:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1672768266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JJlaXFj/Ljh55ongFewETwdgUdugigSQCCYcQcqzAZM=;
 b=JLamONUbhm4UexGYfdPpx/n3ndeFr44nbJ9Krh2th5OcOI/y4sO9cudiMK33anlHFR46TJ
 ro0aJTmRBlnoGb4KTWHu23Z6YH3uGcfUC+P/dNzruniIfwIiRykVY5leriDDo3lOKV7BO3
 c/31WVRKbTj06dPqxGOVN9u8dKWLMw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1672768266;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JJlaXFj/Ljh55ongFewETwdgUdugigSQCCYcQcqzAZM=;
 b=MrbWAHnzvekcW8gw40Npc8Lvwczpmmo+nm2yIaIwYvcxNlRD6npxreqDGkf5vSXEvBYFbD
 8P5VpsAZFOm1nACg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A9EF11390C;
 Tue,  3 Jan 2023 17:51:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wGWMIAlrtGOHNgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 03 Jan 2023 17:51:05 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 Jan 2023 18:50:58 +0100
Message-Id: <20230103175059.16328-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103175059.16328-1-pvorel@suse.cz>
References: <20230103175059.16328-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] doc/shell-test-api.txt: Improve tst_kvcmp doc
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

Add examples which use tst_kvercmp2() functionality + link to C API.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/shell-test-api.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/doc/shell-test-api.txt b/doc/shell-test-api.txt
index 6ad7ed6803..b1e6c1b1dd 100644
--- a/doc/shell-test-api.txt
+++ b/doc/shell-test-api.txt
@@ -665,6 +665,10 @@ fi
 if tst_kvcmp -gt 3.16 -a -lt 4.0.1; then
 	tst_brk TCONF "Kernel must be older than 3.16 or newer than 4.0.1"
 fi
+
+if tst_kvcmp -lt "6.1 RHEL9:5.14.0-191"; then
+	# code for kernel < 6.1 or RHEL9 kernel < 5.14.0-191
+fi
 -------------------------------------------------------------------------------
 
 [options="header"]
@@ -683,6 +687,12 @@ fi
 The format for kernel version has to either be with one dot e.g. '2.6' or with
 two dots e.g. '4.8.1'.
 
+Kernel version can also be followed by a space separated list of extra versions
+prefixed by distribution which when matched take precedence, e.g. '6.1 RHEL9:5.14.0-191'.
+
+For more info see 'tst_kvercmp()' and 'tst_kvercmp2()' in
+https://github.com/linux-test-project/ltp/wiki/C-Test-API#16-runtime-kernel-version-detection[C Test API].
+
 tst_fs_has_free
 +++++++++++++++
 
-- 
2.39.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
