Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1588C4332F
	for <ltp@archiver.kernel.org>; Tue, 31 Oct 2023 16:09:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 065573CE9E9
	for <ltp@archiver.kernel.org>; Tue, 31 Oct 2023 17:09:49 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8EC413CE9F4
 for <ltp@lists.linux.it>; Tue, 31 Oct 2023 17:09:26 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2B0A4600211
 for <ltp@lists.linux.it>; Tue, 31 Oct 2023 17:09:25 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 02C7221A9D;
 Tue, 31 Oct 2023 16:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698768565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=pTIAkH9KuFyBEbDkv9zPtH2VIV8fIDRi1fgutLW9AUQ=;
 b=d+TCdRyudlP+X3Zafhl9EgPwwxP3jbt1fuyQna2J+HbAPtiT3tTika7spay/GW60E0ikWv
 VRcgERO6/WN8j6MV5FM+5ea4RWC90Z5kLkjXzXKjBg0nk5e9FNMS4O+Ef7vXWx2kGDMY9g
 3lACvVsFzSly8hcAT67MIWtBXwejHUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698768565;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=pTIAkH9KuFyBEbDkv9zPtH2VIV8fIDRi1fgutLW9AUQ=;
 b=o++uV7MhL+Xft9WotaxV2Ve5N5mU0tupbTqaUfEHTgundajyKB2plks4aK0uYaq+Um2JgT
 QQnT900NzALqMKAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD79F138EF;
 Tue, 31 Oct 2023 16:09:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1wkGMLQmQWUmSgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 31 Oct 2023 16:09:24 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 31 Oct 2023 17:09:17 +0100
Message-ID: <20231031160918.17845-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] tst_test.sh: Print test command + params
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

To be more obvious what is being run
(test names in runtest files aren't always obvious).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_test.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index b5b38f524..95ebdda9d 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -898,6 +898,8 @@ if [ -z "$TST_NO_DEFAULT_RUN" ]; then
 
 	TST_ARGS="$@"
 
+	tst_res TINFO "Running: $(basename $0) $TST_ARGS"
+
 	OPTIND=1
 
 	while getopts ":hi:$TST_OPTS" _tst_name $TST_ARGS; do
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
