Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D49AC54EBC
	for <ltp@archiver.kernel.org>; Thu, 12 Jan 2023 04:02:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA8483CCAF5
	for <ltp@archiver.kernel.org>; Thu, 12 Jan 2023 05:02:07 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D3B1C3CCABE
 for <ltp@lists.linux.it>; Thu, 12 Jan 2023 05:01:53 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 57290100092C
 for <ltp@lists.linux.it>; Thu, 12 Jan 2023 05:01:52 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B08293F1CE;
 Thu, 12 Jan 2023 04:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1673496110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NNF2pPSxW7xVGIyqpC53GX9T7UF9L7gV4qBIkEEZkt8=;
 b=PmAt7//H5sMfCiy5TGjcz65yMNe+A5lJU6ey1p70a6M2yOOnTYeaaIElUAE7nF3zVM8YaD
 iAshUFPeKD6ukIeU5PWa6EnQ2sjPBfuai0sv5pysLy/IEvHxa/WQoTSvr0myD5JV9JkWek
 KeCGqKOqfjJ7g1Nvz8CLwCOa2aMTukA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C3BEB13585;
 Thu, 12 Jan 2023 04:01:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id nc8rIi2Gv2OwAwAAMHmgww
 (envelope-from <wegao@suse.com>); Thu, 12 Jan 2023 04:01:49 +0000
To: ltp@lists.linux.it
Date: Wed, 11 Jan 2023 12:09:00 -0500
Message-ID: <20230106113126.5304-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] Add PATH to tst_rhost_run.sh
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
From: WEI GAO via ltp <ltp@lists.linux.it>
Reply-To: WEI GAO <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20230111170900.IFLULMgVFLaxGJaSTfmbw5dG4BeBmndlQEPTDN4igOw@z>

From: coolgw <wegao@suse.com>

When run single test case use command such as:
LTP_SHELL_API_TESTS=shell/net/tst_rhost_run.sh make test-shell
Error msg such as "ns_create: command not found" will popup, so
need update PATH before call ns_create etc..

More important:
1) LTP shell API tests depend on properly compiled LTP.
Therefore this is just a workaround to make visible that some tool is missing.

2) I wonder if there is way to properly fix this dependency in make.
I guess test-shell target should depend on (at least): ns_create ns_exec
ns_ifmove.

Signed-off-by: WEI GAO <wegao@suse.com>
---
v3 -> v4: update base Vorel's latest comments, remove unrelated change
V2 -> V3: move path to test case itself 
V1 -> V2: add tst_require_cmds for init_ltp_netspace()

 lib/newlib_tests/shell/net/tst_rhost_run.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/newlib_tests/shell/net/tst_rhost_run.sh b/lib/newlib_tests/shell/net/tst_rhost_run.sh
index 773b8dd33..951551514 100755
--- a/lib/newlib_tests/shell/net/tst_rhost_run.sh
+++ b/lib/newlib_tests/shell/net/tst_rhost_run.sh
@@ -3,7 +3,8 @@
 # Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
 
 TST_TESTFUNC=do_test
-PATH="$(dirname $0)/../../../../testcases/lib/:$PATH"
+root="$(dirname $0)/../../../../"
+PATH="$root/testcases/lib/:$root/testcases/kernel/containers/share/:$PATH"
 
 export TST_NET_RHOST_RUN_DEBUG=1
 
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
