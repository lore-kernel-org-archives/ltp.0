Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73EFCCD1288
	for <ltp@archiver.kernel.org>; Sat, 30 Mar 2024 18:09:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D4D83C6EEE
	for <ltp@archiver.kernel.org>; Sat, 30 Mar 2024 19:09:11 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 65F1B3C6DAE
 for <ltp@lists.linux.it>; Sat, 30 Mar 2024 19:08:42 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 69126600801
 for <ltp@lists.linux.it>; Sat, 30 Mar 2024 19:08:39 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C556437D50;
 Sat, 30 Mar 2024 18:08:37 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A097713A9B;
 Sat, 30 Mar 2024 18:08:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 6IcMJCVVCGZXfwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Sat, 30 Mar 2024 18:08:37 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Sat, 30 Mar 2024 19:08:18 +0100
Message-ID: <20240330180818.246499-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240330180818.246499-1-pvorel@suse.cz>
References: <20240330180818.246499-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: C556437D50
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] network/README: Document ping dependencies
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
 testcases/network/README.md | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/testcases/network/README.md b/testcases/network/README.md
index e1b1296d6..0b64df01e 100644
--- a/testcases/network/README.md
+++ b/testcases/network/README.md
@@ -88,6 +88,13 @@ Tests which use `tst_netload_compare()` test also performance. They can fail on
 overloaded SUT.  To ignore performance failure and test only the network functionality,
 set `LTP_NET_FEATURES_IGNORE_PERFORMANCE_FAILURE=1` environment variable.
 
+## Dependencies
+
+Some network tests which use `tst_ping()` function require `ping` with `-I` support,
+which is not supported by `ping` from [inetutils](https://www.gnu.org/software/inetutils/).
+Use `ping` from [iputils](https://github.com/iputils/iputils/) or from [BusyBox](https://busybox.net/)
+(configured with `CONFIG_FEATURE_IPV6=y` `CONFIG_FEATURE_FANCY_PING=y`).
+
 ## Debugging
 Both single and two host configurations support debugging via
 `TST_NET_RHOST_RUN_DEBUG=1` environment variable.
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
