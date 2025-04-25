Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6FB9C369C2
	for <ltp@archiver.kernel.org>; Fri, 25 Apr 2025 15:31:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 072A43CB931
	for <ltp@archiver.kernel.org>; Fri, 25 Apr 2025 17:31:07 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2590F3CB6D4
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 17:30:50 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6FF1C600542
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 17:30:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6C80A1F399;
 Fri, 25 Apr 2025 15:30:49 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 441A113A79;
 Fri, 25 Apr 2025 15:30:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uN7rDqmqC2gSdAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 25 Apr 2025 15:30:49 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 25 Apr 2025 17:30:42 +0200
Message-ID: <20250425153046.63853-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425153046.63853-1-pvorel@suse.cz>
References: <20250425153046.63853-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: 6C80A1F399
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/4] ci: patchwork.sh: Add check for number of
 parameters
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

Checking user input is always good to avoid unexpected results
(e.g. setting patchwork state without a description).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Minor cleanup before modifying the file.

 ci/tools/patchwork.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/ci/tools/patchwork.sh b/ci/tools/patchwork.sh
index 83ef0bb220..fe6c049aca 100755
--- a/ci/tools/patchwork.sh
+++ b/ci/tools/patchwork.sh
@@ -76,6 +76,11 @@ set_patch_state() {
 }
 
 set_series_state() {
+        if [ $# -ne 2 ]; then
+            echo "'state' command expects 2 parameters ($#)"
+            exit 1
+        fi
+
         local series_id="$1"
         local state="$2"
 
@@ -131,6 +136,11 @@ verify_new_patches() {
 }
 
 send_results() {
+        if [ $# -ne 4 ]; then
+            echo "'check' command expects 4 parameters ($#)"
+            exit 1
+        fi
+
         local series_id="$1"
         local target_url="$2"
 
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
