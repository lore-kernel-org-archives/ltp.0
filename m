Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33655C00140
	for <ltp@archiver.kernel.org>; Mon,  8 Aug 2022 10:11:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 691E73C9586
	for <ltp@archiver.kernel.org>; Mon,  8 Aug 2022 12:11:20 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 235A03C91FE
 for <ltp@lists.linux.it>; Mon,  8 Aug 2022 12:10:27 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B6257680E3A
 for <ltp@lists.linux.it>; Mon,  8 Aug 2022 12:10:26 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F301D37623;
 Mon,  8 Aug 2022 10:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659953424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uf756QkCH+vRzd4rb/Pc65IPEPyCAdxOKCL5Jpahn84=;
 b=Z1yJdyT/PmgBasvTzx72oVgi8LiTKp+G5TYiCoKDFKDmzZzxYT0gnjoGlbEvUln08mEVDy
 G6nrBnQwcWyOW6iXLIPQk7yIMqyFhd8SDouXt707mVgADcwToJQwZ1MqqkN0+uVz/j47ZG
 eAqDMRr7IZbG8gANsxELgIqYlLtQu0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659953424;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uf756QkCH+vRzd4rb/Pc65IPEPyCAdxOKCL5Jpahn84=;
 b=tR+o79t99orIk9A6FUFuD2J0Ev2ly7+GctDE2UioswH/9VjLd/RnhWGGoMRB1SLIw5jIfO
 unvb181+l8dQkbCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE8ED13A7C;
 Mon,  8 Aug 2022 10:10:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eFNDLRDh8GKkAgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 08 Aug 2022 10:10:24 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  8 Aug 2022 12:10:17 +0200
Message-Id: <20220808101019.29892-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808101019.29892-1-pvorel@suse.cz>
References: <20220808101019.29892-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/4] tst_ansi_color.sh: Allow to run with set -e
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

set -e (or #!/bin/sh -e or set -o errexit) quits on any non-zero exit
code, harden tst_res TINFO to be able to be used on scripts with it.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_ansi_color.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/lib/tst_ansi_color.sh b/testcases/lib/tst_ansi_color.sh
index 703df1eb8..4b2255448 100644
--- a/testcases/lib/tst_ansi_color.sh
+++ b/testcases/lib/tst_ansi_color.sh
@@ -32,8 +32,9 @@ tst_color_enabled()
 
 tst_print_colored()
 {
-	tst_color_enabled
-	local color=$?
+	local color=0
+
+	tst_color_enabled || color=$?
 
 	[ "$color" = "1" ] && tst_flag2color "$1"
 	printf "$2"
-- 
2.37.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
