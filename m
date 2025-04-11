Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C757BC36010
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 11:44:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 57B573CB5CA
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 13:44:17 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C851F3CB5C2
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 13:43:47 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BF91C200AEF
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 13:43:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 02E771F750;
 Fri, 11 Apr 2025 11:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744371822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FA0wd1RNyismqe9o4v42gDUWzgbwj6YbasP/D24hDqo=;
 b=vCE9i/NhCkjSGOHkkV2Hoxgt+ZfRb5divyryXbmo32jPmIu0GfianWLKDkYMnQXFhrHVHy
 AAGeLjU8OoGWGoLfyOO6yMJD+j7edz7olJfwxtRH+Sko2Bn9Zv1NUOoEMEnpSP8WKDSh2g
 HGn4JU2ws0PU+Q+9T2gl5lfUcw/AUiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744371822;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FA0wd1RNyismqe9o4v42gDUWzgbwj6YbasP/D24hDqo=;
 b=bCg9SAr776lc5wW4coeUhmzPndTXquPgQksRiUwVVZbdooqVMKK8OY/F5sqFA8oj5vjmMA
 zcuaQaxcIub8KiBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744371822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FA0wd1RNyismqe9o4v42gDUWzgbwj6YbasP/D24hDqo=;
 b=vCE9i/NhCkjSGOHkkV2Hoxgt+ZfRb5divyryXbmo32jPmIu0GfianWLKDkYMnQXFhrHVHy
 AAGeLjU8OoGWGoLfyOO6yMJD+j7edz7olJfwxtRH+Sko2Bn9Zv1NUOoEMEnpSP8WKDSh2g
 HGn4JU2ws0PU+Q+9T2gl5lfUcw/AUiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744371822;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FA0wd1RNyismqe9o4v42gDUWzgbwj6YbasP/D24hDqo=;
 b=bCg9SAr776lc5wW4coeUhmzPndTXquPgQksRiUwVVZbdooqVMKK8OY/F5sqFA8oj5vjmMA
 zcuaQaxcIub8KiBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C120013A67;
 Fri, 11 Apr 2025 11:43:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iENhLW0A+WcmVAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 11 Apr 2025 11:43:41 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri, 11 Apr 2025 13:43:22 +0200
Message-ID: <20250411114326.526-3-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411114326.526-1-andrea.cervesato@suse.de>
References: <20250411114326.526-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 2/4] ci: add patchwork communication script
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

Add a script to communicate with patchwork. Available commands are:

- state: change patch-series state
- check: send a tests report to patchwork
- verify: will print a list of new patch-series which has not been
  tested in the past hour (by default)

The script can be configured defining:

- PATCHWORK_URL: patchwork url to communicate with
- PATCHWORK_TOKEN: patchwork authentication token
- PATCHWORK_SINCE: timespan in seconds where we want to fetch
  patch-series

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 ci/tools/patchwork.sh | 197 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 197 insertions(+)
 create mode 100755 ci/tools/patchwork.sh

diff --git a/ci/tools/patchwork.sh b/ci/tools/patchwork.sh
new file mode 100755
index 000000000..d43b7fd61
--- /dev/null
+++ b/ci/tools/patchwork.sh
@@ -0,0 +1,197 @@
+#!/bin/sh -ex
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Shell script that can be used to communicate with Patchwork via REST API.
+# It has been mainly created for CI purposes, but it can be used in the shell
+# by satisfing minimum requirements.
+#
+# Copyright (c) 2025 Andrea Cervesato <andrea.cervesato@suse.com>
+
+command_exists() {
+        command -v $1 >/dev/null 2>&1
+
+        if [ $? -ne 0 ]; then
+                echo "'$1' must be present in the system"
+                exit 1
+        fi
+}
+
+command_exists "curl"
+command_exists "jq"
+
+if [ -z "$PATCHWORK_URL" ]; then
+        PATCHWORK_URL="https://patchwork.ozlabs.org"
+fi
+
+if [ -z "$PATCHWORK_SINCE" ]; then
+        PATCHWORK_SINCE=3600
+fi
+
+fetch_series() {
+        local current_time=$(date +%s)
+        local since_time=$(expr $current_time - $PATCHWORK_SINCE)
+        local date=$(date -u -d @$since_time +"%Y-%m-%dT%H:%M:%SZ")
+
+        curl -k -G "$PATCHWORK_URL/api/events/" \
+                --data "category=series-completed" \
+                --data "project=ltp" \
+                --data "state=new" \
+                --data "since=$date" \
+                --data "archive=no" |
+                jq -r '.[] | "\(.payload.series.id):\(.payload.series.mbox)"'
+
+        if [ $? -ne 0 ]; then
+                exit 1
+        fi
+}
+
+get_patches() {
+        local series_id="$1"
+
+        curl -k -G "$PATCHWORK_URL/api/patches/" \
+                --data "project=ltp" \
+                --data "series=$series_id" |
+                jq -r '.[] | "\(.id)"'
+
+        if [ $? -ne 0 ]; then
+                exit 1
+        fi
+}
+
+verify_token_exists() {
+        if [ -z "$PATCHWORK_TOKEN" ]; then
+                echo "For this feature you need \$PATCHWORK_TOKEN"
+                exit 1
+        fi
+}
+
+set_patch_state() {
+        local patch_id="$1"
+        local state="$2"
+
+        verify_token_exists
+
+        curl -k -X PATCH \
+                -H "Authorization: Token $PATCHWORK_TOKEN" \
+                -F "state=$state" \
+                "$PATCHWORK_URL/api/patches/$patch_id/"
+
+        if [ $? -ne 0 ]; then
+                exit 1
+        fi
+}
+
+set_series_state() {
+        local series_id="$1"
+        local state="$2"
+
+        get_patches "$series_id" | while IFS= read -r patch_id; do
+                if [ -n "$patch_id" ]; then
+                        set_patch_state "$patch_id" "$state"
+                fi
+        done
+}
+
+get_checks() {
+        local patch_id="$1"
+
+        curl -k -G "$PATCHWORK_URL/api/patches/$patch_id/checks/" |
+                jq -r '.[] | "\(.id)"'
+
+        if [ $? -ne 0 ]; then
+                exit 1
+        fi
+}
+
+already_tested() {
+        local series_id="$1"
+
+        get_patches "$series_id" | while IFS= read -r patch_id; do
+                if [ ! -n "$patch_id" ]; then
+                        continue
+                fi
+
+                get_checks "$patch_id" | while IFS= read -r check_id; do
+                        if [ -n "$check_id" ]; then
+                                echo "$check_id"
+                                return
+                        fi
+                done
+        done
+}
+
+verify_new_patches() {
+        local output="series_ids.txt"
+
+        echo -n '' >"$output"
+
+        fetch_series | while IFS=: read -r series_id series_mbox; do
+                if [ ! -n "$series_id" ]; then
+                        continue
+                fi
+
+                tested=$(already_tested "$series_id")
+                if [ -n "$tested" ]; then
+                        continue
+                fi
+
+                echo "$series_id|$series_mbox" >>"$output"
+        done
+
+        cat "$output"
+}
+
+send_results() {
+        local series_id="$1"
+        local target_url="$2"
+
+        verify_token_exists
+
+        local context=$(echo "$3" | sed 's/:/_/g; s/\//-/g; s/\./-/g')
+        if [ -n "$CC" ]; then
+                context="${context}_${CC}"
+        fi
+
+        if [ -n "$ARCH" ]; then
+                context="${context}_${ARCH}"
+        fi
+
+        local result="$4"
+        if [ "$result" = "cancelled" ]; then
+                return
+        fi
+
+        local state="fail"
+        if [ "$result" = "success" ]; then
+                state="success"
+        fi
+
+        get_patches "$series_id" | while IFS= read -r patch_id; do
+                if [ -n "$patch_id" ]; then
+                        curl -k -X POST \
+                                -H "Authorization: Token $PATCHWORK_TOKEN" \
+                                -F "state=$state" \
+                                -F "context=$context" \
+                                -F "target_url=$target_url" \
+                                -F "description=$result" \
+                                "$PATCHWORK_URL/api/patches/$patch_id/checks/"
+
+                        if [ $? -ne 0 ]; then
+                                exit 1
+                        fi
+                fi
+        done
+}
+
+run="$1"
+
+if [ -z "$run" -o "$run" = "state" ]; then
+        set_series_state "$2" "$3"
+elif [ -z "$run" -o "$run" = "check" ]; then
+        send_results "$2" "$3" "$4" "$5"
+elif [ -z "$run" -o "$run" = "verify" ]; then
+        verify_new_patches
+else
+        echo "Available commands: state, check, verify"
+        exit 1
+fi
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
