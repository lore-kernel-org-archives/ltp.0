Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE6AC369C2
	for <ltp@archiver.kernel.org>; Fri, 25 Apr 2025 15:32:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B52D63CB96D
	for <ltp@archiver.kernel.org>; Fri, 25 Apr 2025 17:32:02 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8EFEA3CB915
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 17:30:59 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E4F6D100035A
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 17:30:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9AFFF1F44E;
 Fri, 25 Apr 2025 15:30:49 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72E451388F;
 Fri, 25 Apr 2025 15:30:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0H3xGqmqC2gSdAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 25 Apr 2025 15:30:49 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 25 Apr 2025 17:30:43 +0200
Message-ID: <20250425153046.63853-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425153046.63853-1-pvorel@suse.cz>
References: <20250425153046.63853-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: 9AFFF1F44E
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/4] ci: patchwork.sh: Add optional 5th parameter
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

Allows to set a specific description (as 5th parameter),
fallback to result (4th parameter).

This is a preparation for a next commit.

Also, while at it, document possible result states.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 ci/tools/patchwork.sh | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/ci/tools/patchwork.sh b/ci/tools/patchwork.sh
index fe6c049aca..3e18ee9480 100755
--- a/ci/tools/patchwork.sh
+++ b/ci/tools/patchwork.sh
@@ -136,8 +136,8 @@ verify_new_patches() {
 }
 
 send_results() {
-        if [ $# -ne 4 ]; then
-            echo "'check' command expects 4 parameters ($#)"
+        if [ $# -ne 4 -a $# -ne 5 ]; then
+            echo "'check' command expects 4 or 5 parameters ($#)"
             exit 1
         fi
 
@@ -154,8 +154,16 @@ send_results() {
         local result="$4"
         [ "$result" = "cancelled" ] && return
 
+        local description="${5:-$result}"
+
         local state="fail"
-        [ "$result" = "success" ] && state="success"
+
+        # patchwork REST API allowed states: pending, success, warning, fail.
+        # https://github.com/getpatchwork/patchwork/blob/main/docs/api/schemas/v1.2/patchwork.yaml#L708
+        # https://patchwork.readthedocs.io/en/latest/api/rest/schemas/v1.2/#get--api-1.2-patches-patch_id-checks
+        case "$result" in
+            success|pending) state=$result;;
+        esac
 
         get_patches "$series_id" | while read -r patch_id; do
                 [ "$patch_id" ] || continue
@@ -165,7 +173,7 @@ send_results() {
                         -F "state=$state" \
                         -F "context=$context" \
                         -F "target_url=$target_url" \
-                        -F "description=$result" \
+                        -F "description=$description" \
                         "$PATCHWORK_URL/api/patches/$patch_id/checks/"
 
                 [ $? -eq 0 ] || exit 1
@@ -177,7 +185,7 @@ state)
         set_series_state "$2" "$3"
         ;;
 check)
-        send_results "$2" "$3" "$4" "$5"
+        send_results "$2" "$3" "$4" "$5" "$6"
         ;;
 verify)
         verify_new_patches
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
