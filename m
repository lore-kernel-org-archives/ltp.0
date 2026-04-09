Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13046EA3C23
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 11:11:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB94A3E159F
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 13:11:48 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4456C3C9F03
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 13:11:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 95E4F200B31
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 13:11:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2896F5BD1E;
 Thu,  9 Apr 2026 11:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775733087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=y7YuFboBQN7EiCxw6Isnyaahzjztub5WSJnB+KFW/Sw=;
 b=ySG6dj9sVHhdFiiR7Jaj1o6iHyDChOj6pKKozRfO7g+29fC9bqAWEYo+MToT+NO2kBsFxe
 bp5NvO3cHOk4BCtbLnTl3rAM3/x/e365saKFjUoVBcf7vPDBZ2m8fNe7xYikKIGfYT3Otv
 h8X9Df65ZhbMC8dzRFxEyOvXT9koMWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775733087;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=y7YuFboBQN7EiCxw6Isnyaahzjztub5WSJnB+KFW/Sw=;
 b=gJdK2aVOESeRtoYLh5zB5Mnjbl2QjDXzj+zu+RuxPa2V3LR97JlOQ48JF8SNI9bCi9aDxG
 P7LYz/4dM8LztIDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775733087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=y7YuFboBQN7EiCxw6Isnyaahzjztub5WSJnB+KFW/Sw=;
 b=ySG6dj9sVHhdFiiR7Jaj1o6iHyDChOj6pKKozRfO7g+29fC9bqAWEYo+MToT+NO2kBsFxe
 bp5NvO3cHOk4BCtbLnTl3rAM3/x/e365saKFjUoVBcf7vPDBZ2m8fNe7xYikKIGfYT3Otv
 h8X9Df65ZhbMC8dzRFxEyOvXT9koMWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775733087;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=y7YuFboBQN7EiCxw6Isnyaahzjztub5WSJnB+KFW/Sw=;
 b=gJdK2aVOESeRtoYLh5zB5Mnjbl2QjDXzj+zu+RuxPa2V3LR97JlOQ48JF8SNI9bCi9aDxG
 P7LYz/4dM8LztIDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF3224A0B3;
 Thu,  9 Apr 2026 11:11:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fWOfOF6J12kGOAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 09 Apr 2026 11:11:26 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 09 Apr 2026 13:11:24 +0200
MIME-Version: 1.0
Message-Id: <20260409-fix_ci_checks-v1-1-bd1c9a25d3f2@suse.com>
X-B4-Tracking: v=1; b=H4sIAFuJ12kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEwNL3bTMivjkzPjkjNTk7GJdy5QkAwsLAxBOVgLqKShKBSoAmxcdW1s
 LAEBV2GlfAAAA
X-Change-ID: 20260409-fix_ci_checks-9db08800880c
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775733086; l=2586;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=wcz3M7pbqN6+6Ha22eLP37lZC9aPiQa4SX+V5jJ3pzs=;
 b=QdsmXvibdVqiK8U2mE/C8VcCGJlLJhHC5N7iheqMWGW3fDiQc5m8B0ueox83jHX38S7wUCVN5
 iewDODvEPjjDl6n7cHxwn4PkUgPrumMiVAFplqNk5PXlvpO+Oi6sH19
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.988]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] patchwork: Filter checks by CI prefix to avoid
 skipping untested series
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Other CI systems adding checks to patches caused this CI to skip
series it hadn't tested yet. Prefix check contexts with a configurable
PATCHWORK_CI_PREFIX and filter by it in already_tested().

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
After adding copilot review we have a problem to run CI due to the
build scripts. We need to verify that _only_ build checks were not
added.
---
 ci/tools/patchwork.sh | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/ci/tools/patchwork.sh b/ci/tools/patchwork.sh
index 3e18ee9480c443837bc4269a408fc3151d76b165..affa7f2a0a6bb69079308ad6ada4bd6e7f296c26 100755
--- a/ci/tools/patchwork.sh
+++ b/ci/tools/patchwork.sh
@@ -9,6 +9,7 @@
 
 PATCHWORK_URL="${PATCHWORK_URL:-https://patchwork.ozlabs.org}"
 PATCHWORK_SINCE="${PATCHWORK_SINCE:-3600}"
+PATCHWORK_CI_PREFIX="${PATCHWORK_CI_PREFIX:-github-build}"
 
 command_exists() {
         local cmd
@@ -93,13 +94,20 @@ set_series_state() {
 
 get_checks() {
         local patch_id="$1"
+        local prefix="$2"
         local stdout
 
         stdout="$(curl -k -G $PATCHWORK_URL/api/patches/$patch_id/checks/)"
 
         [ $? -eq 0 ] || exit 1
 
-        echo "$stdout" | jq -r '.[] | "\(.id)"'
+        if [ -n "$prefix" ]; then
+                echo "$stdout" | jq -r \
+                        --arg pfx "$prefix" \
+                        '.[] | select(.context | startswith($pfx)) | "\(.id)"'
+        else
+                echo "$stdout" | jq -r '.[] | "\(.id)"'
+        fi
 }
 
 already_tested() {
@@ -108,7 +116,7 @@ already_tested() {
         get_patches "$series_id" | while read -r patch_id; do
                 [ "$patch_id" ] || continue
 
-                get_checks "$patch_id" | while read -r check_id; do
+                get_checks "$patch_id" "$PATCHWORK_CI_PREFIX" | while read -r check_id; do
                         if [ -n "$check_id" ]; then
                                 echo "$check_id"
                                 return
@@ -146,7 +154,7 @@ send_results() {
 
         verify_token_exists
 
-        local context=$(echo "$3" | sed 's/:/_/g; s/\//-/g; s/\./-/g')
+        local context="$PATCHWORK_CI_PREFIX/$(echo "$3" | sed 's/:/_/g; s/\//-/g; s/\./-/g')"
 
         [ "$CC" ] && context="${context}_${CC}"
         [ "$ARCH" ] && context="${context}_${ARCH}"

---
base-commit: 3a4bf67d82eae0febb5462077fb43937e875e46e
change-id: 20260409-fix_ci_checks-9db08800880c

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
