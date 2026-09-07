Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21702C79F9E
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 12:27:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7DA8A3E93AE
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 14:27:40 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 762703C6135
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 14:27:24 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C0EE51400B87
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 14:27:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8CADE1F456;
 Mon,  7 Sep 2026 12:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788784038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jyAI0FW6N3D3ESkiJh25l6BYBzyYJ9jJqS2U+nsqxlc=;
 b=2FTP1njCTGhNeAddW5hAS9FAV+s4IuFlqYIhqvCbEmKS4xzdDhIOeMG+Uz/miWAQaB2cWq
 +6ildXLv35dpC058IbviZDLrR4aS0Fd5kWoh6zqNZq4svqfTMKz/0PeBMvJYakQjJ8wVuo
 Kfi4tShmS0BXZ5xZGlM36hAnmCNvPzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788784038;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jyAI0FW6N3D3ESkiJh25l6BYBzyYJ9jJqS2U+nsqxlc=;
 b=gph2ICICe0OWpxFXCGD3immOjZqnBSjYNFygDldH+zMJ27UUoFyrBhdEmV4D4D92ivD7Bn
 FMRDP0Y5TPhELQCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HYSmCL4T;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PW6YwnPK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788784034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jyAI0FW6N3D3ESkiJh25l6BYBzyYJ9jJqS2U+nsqxlc=;
 b=HYSmCL4TMa4S/Lz0vper5WSqLm9ZpwheawJvNB4kzw1aVNf3NlCOH5wltbozkM6ayKD4Bo
 b2m6K2GQKpyO8ar7+ELue2JyN3E6GLcOI1S+H4BkVN8d3HKAqVApS+LLuEbIxo2dc3KZeo
 aMQ7s8CN+nvD/Ft6tsCouFUe//PzZog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788784034;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jyAI0FW6N3D3ESkiJh25l6BYBzyYJ9jJqS2U+nsqxlc=;
 b=PW6YwnPK3jGgFJ29Dw8ueboFlYJPEZIIh6CS8HCQpJS31tN2gLPBYE3YOZARSqgNs0LU5u
 Yxdiak7ZwIRa2mDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E3441339B;
 Mon,  7 Sep 2026 12:27:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HzxXFaKtnmoqLQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 07 Sep 2026 12:27:14 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 07 Sep 2026 14:27:06 +0200
MIME-Version: 1.0
Message-Id: <20260907-ci_patchwork_apply-v1-1-95d71dbacc5e@suse.com>
X-B4-Tracking: v=1; b=H4sIAJmtnmoC/yXMTQqDMBBA4avIrA2MEVLjVUQkjWMdFQ2JPy3i3
 Rvb5bd474RAnilAmZzgaefAyxyRpQnY3swvEtxGg0SpUONDWG6cWW1/LH5sjHPTR2hsSWmJeVc
 oiKHz1PH7N63qv8P2HMiu9wmu6wvuQHamdgAAAA==
X-Change-ID: 20260907-ci_patchwork_apply-90de69203f86
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788784034; l=7060;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=TSjaYaj6eaNu7J+KV/ji/M0NqxAUlYURHXrzAu4Fh0U=;
 b=w94WqZRlPmccdDpqm2VG4xf5UFAvQW6LZdog/h43v5Lz9F/pMEHwFE4PR2hpFAyJw77JJDLz+
 Wt6OuCmG7H+Df433cFWZDO8HzvepquwqPqIO0KG3WZ/de4M/jIV21iv
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8CADE1F456
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] ci: apply Patchwork series via REST API
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

Patchwork on kernel.org requires authentication to download mbox files
from the web interface, causing anonymous curl downloads in CI to fail
with HTTP 302 redirects to the login page.

Add an 'apply' command to ci/tools/patchwork.sh that retrieves patches
via the public REST API and applies them using git am. Update workflows
to use this command instead of curling the mbox URL directly.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Patchwork instances on kernel.org require authentication to download mbox
files from the web interface, returning HTTP 302 redirects to the login
page for anonymous requests. This breaks the CI workflows when trying to
download and apply patch series using the web mbox URL.

This series adds an 'apply' subcommand to ci/tools/patchwork.sh that
retrieves the individual patches using the public REST API and applies
them via git am, and updates the CI workflows to use this command.
---
 .github/workflows/ci-docker-build.yml |  6 +--
 .github/workflows/ci-sphinx-doc.yml   |  6 +--
 ci/tools/patchwork.sh                 | 69 ++++++++++++++++++++++++++++++++++-
 3 files changed, 74 insertions(+), 7 deletions(-)

diff --git a/.github/workflows/ci-docker-build.yml b/.github/workflows/ci-docker-build.yml
index ec002d316..b117547d8 100644
--- a/.github/workflows/ci-docker-build.yml
+++ b/.github/workflows/ci-docker-build.yml
@@ -146,7 +146,7 @@ jobs:
       run: $CC --version
 
     - name: Apply Patchwork series
-      if: inputs.SERIES_ID != '' && inputs.SERIES_MBOX != ''
+      if: inputs.SERIES_ID != ''
       env:
         PATCHWORK_TOKEN: ${{ secrets.PATCHWORK_TOKEN }}
       run: |
@@ -155,7 +155,7 @@ jobs:
         git config --global --add safe.directory "$GITHUB_WORKSPACE"
 
         git checkout -b review_patch_series_"${{ inputs.SERIES_ID }}"
-        curl -k -L --retry 3 --max-redirs 1 --location-trusted "${{ inputs.SERIES_MBOX }}" | git am
+        ./ci/tools/patchwork.sh apply "${{ inputs.SERIES_ID }}"
 
         ./ci/tools/patchwork.sh state "${{ inputs.SERIES_ID }}" "needs-ack"
 
@@ -199,7 +199,7 @@ jobs:
         ./build.sh -r install -o ${TREE:-in} $INSTALL_OPT
 
     - name: Send results to Patchwork
-      if: always() && inputs.SERIES_ID != '' && inputs.SERIES_MBOX != ''
+      if: always() && inputs.SERIES_ID != ''
       env:
         PATCHWORK_TOKEN: ${{ secrets.PATCHWORK_TOKEN }}
       run: |
diff --git a/.github/workflows/ci-sphinx-doc.yml b/.github/workflows/ci-sphinx-doc.yml
index beb378392..ffa5cb926 100644
--- a/.github/workflows/ci-sphinx-doc.yml
+++ b/.github/workflows/ci-sphinx-doc.yml
@@ -35,7 +35,7 @@ jobs:
           sudo apt install autoconf make python3-virtualenv
 
       - name: Apply Patchwork series
-        if: inputs.SERIES_ID != '' && inputs.SERIES_MBOX != ''
+        if: inputs.SERIES_ID != ''
         env:
           PATCHWORK_TOKEN: ${{ secrets.PATCHWORK_TOKEN }}
         run: |
@@ -44,7 +44,7 @@ jobs:
           git config --global --add safe.directory "$GITHUB_WORKSPACE"
 
           git checkout -b review_patch_series_"${{ inputs.SERIES_ID }}"
-          curl -k -L --retry 3 --max-redirs 1 --location-trusted "${{ inputs.SERIES_MBOX }}" | git am
+          ./ci/tools/patchwork.sh apply "${{ inputs.SERIES_ID }}"
 
           ./ci/tools/patchwork.sh state "${{ inputs.SERIES_ID }}" "needs-ack"
 
@@ -53,7 +53,7 @@ jobs:
           make autotools && ./configure
 
       - name: Send results to Patchwork
-        if: always() && inputs.SERIES_ID != '' && inputs.SERIES_MBOX != ''
+        if: always() && inputs.SERIES_ID != ''
         env:
           PATCHWORK_TOKEN: ${{ secrets.PATCHWORK_TOKEN }}
         run: |
diff --git a/ci/tools/patchwork.sh b/ci/tools/patchwork.sh
index 4e61eb7f3..8d930007b 100755
--- a/ci/tools/patchwork.sh
+++ b/ci/tools/patchwork.sh
@@ -202,7 +202,74 @@ send_results() {
         done
 }
 
+apply_series() {
+        if [ $# -ne 1 ]; then
+                echo "'apply' command expects 1 parameter ($#)" >&2
+                exit 1
+        fi
+
+        local series_id="$1"
+        local stdout
+        local patch_ids
+
+        stdout="$(curl -f -k -s --retry 3 "$PATCHWORK_URL/api/1.2/series/$series_id/")"
+        if [ $? -ne 0 ] || [ -z "$stdout" ]; then
+                echo "Failed to fetch series $series_id from $PATCHWORK_URL" >&2
+                exit 1
+        fi
+
+        patch_ids="$(echo "$stdout" | jq -r '.patches[].id')"
+        if [ -z "$patch_ids" ]; then
+                echo "No patches found for series $series_id" >&2
+                exit 1
+        fi
+
+        local tmp_dir
+        tmp_dir="$(mktemp -d)"
+        trap 'rm -rf "$tmp_dir"' EXIT
+
+        local count=0
+        for patch_id in $patch_ids; do
+                local patch_json
+                patch_json="$(curl -f -k -s --retry 3 "$PATCHWORK_URL/api/1.2/patches/$patch_id/")"
+                if [ $? -ne 0 ] || [ -z "$patch_json" ]; then
+                        echo "Failed to fetch patch $patch_id from $PATCHWORK_URL" >&2
+                        exit 1
+                fi
+
+                count=$((count + 1))
+                local patch_file
+                patch_file="$(printf "%s/%04d-%s.patch" "$tmp_dir" "$count" "$patch_id")"
+
+                echo "$patch_json" | jq -r '
+                        "From " + (.headers["Message-Id"] // .msgid // "patchwork") + " Mon Sep 07 00:00:00 2026",
+                        "From: " + (.headers.From // ((.submitter.name // "Unknown") + " <" + (.submitter.email // "unknown@example.com") + ">")),
+                        "Date: " + (.headers.Date // .date // ""),
+                        "Subject: " + (.headers.Subject // .name // "No subject"),
+                        "Message-Id: " + (.headers["Message-Id"] // .msgid // ""),
+                        "MIME-Version: 1.0",
+                        "Content-Type: text/plain; charset=UTF-8",
+                        "Content-Transfer-Encoding: 8bit",
+                        "",
+                        .content,
+                        "",
+                        .diff,
+                        ""
+                ' > "$patch_file"
+        done
+
+        git am --3way "$tmp_dir"/*.patch
+        local ret=$?
+        if [ $ret -ne 0 ]; then
+                git am --abort 2>/dev/null || true
+                exit $ret
+        fi
+}
+
 case "$1" in
+apply)
+        apply_series "$2"
+        ;;
 state)
         set_series_state "$2" "$3"
         ;;
@@ -213,7 +280,7 @@ verify)
         verify_new_patches
         ;;
 *)
-        echo "Available commands: state, check, verify" >&2
+        echo "Available commands: apply, state, check, verify" >&2
         exit 1
         ;;
 esac

---
base-commit: 463b33ad464b6840d0a1df5d41939e50d55d542c
change-id: 20260907-ci_patchwork_apply-90de69203f86

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
