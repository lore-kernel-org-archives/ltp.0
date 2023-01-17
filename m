Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E107DC6379F
	for <ltp@archiver.kernel.org>; Tue, 17 Jan 2023 04:02:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E2793CDABD
	for <ltp@archiver.kernel.org>; Tue, 17 Jan 2023 05:02:02 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E5E93CBBAF
 for <ltp@lists.linux.it>; Tue, 17 Jan 2023 05:01:51 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6391A1A0066B
 for <ltp@lists.linux.it>; Tue, 17 Jan 2023 05:01:50 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6BA4067EE6;
 Tue, 17 Jan 2023 04:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1673928110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+KeNKtz943/jdBI2n87eMOysZKVIvceWJDltIyhOEXg=;
 b=YvQZ+DvreNs4d7fuSBlLgSVj1TXelaeaFOQI65+PjmR7xMwc9r3Jvi/p0xlk2Dss9PvGuX
 N1MrfUwHRhAJPiko5zeEbkKKzce5UYddzdK7oJbdEZtJHc9RFkH3LGOd4riL8UaBeE466I
 2MFVSSsveJ6NFa7Zfz+08UlR6Rl++eY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A745413926;
 Tue, 17 Jan 2023 04:01:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CXTJH60dxmMeYAAAMHmgww
 (envelope-from <wegao@suse.com>); Tue, 17 Jan 2023 04:01:49 +0000
To: ltp@lists.linux.it
Date: Mon, 16 Jan 2023 23:01:32 -0500
Message-Id: <20230117040132.5245-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] tst_net.sh: Add more tst_require_cmds check
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

More strict check for ns_xxx etc will help avoid following issue:
https://github.com/linux-test-project/ltp/issues/991

Signed-off-by: Wei Gao <wegao@suse.com>
Suggested-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index ceb45c98d..ec915ad74 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -205,6 +205,7 @@ tst_rhost_run()
 	sh_cmd="$pre_cmd $cmd $post_cmd"
 
 	if [ -n "${TST_USE_NETNS:-}" ]; then
+		tst_require_cmds ip ns_create ns_exec ns_ifmove
 		use="NETNS"
 		rcmd="$LTP_NETNS sh -c"
 	else
@@ -1006,6 +1007,7 @@ IPV6_RHOST="${IPV6_RHOST:-fd00:1:1:1::1/64}"
 # tst_net_iface_prefix -h
 # tst_net_vars -h
 if [ -z "$_tst_net_parse_variables" ]; then
+	tst_require_cmds tst_net_ip_prefix
 	eval $(tst_net_ip_prefix $IPV4_LHOST || echo "exit $?")
 	eval $(tst_net_ip_prefix -r $IPV4_RHOST || echo "exit $?")
 
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
