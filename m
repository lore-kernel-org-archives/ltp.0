Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0665AC369B1
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 09:04:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7676C3CB955
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 11:04:19 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2DEE23CB420
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 11:04:01 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6D1081400B8E
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 11:04:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BB09C1F445;
 Wed, 16 Apr 2025 09:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744794239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kSSZDs/io7oy8HANTXiB0Z/0WJpnIO6hO0ojd+ED5x8=;
 b=m63qOTWUn5OQ9UotfZQtXLcmXQnnka1A47KpRpcsYRsM7alqRPp4IN+thKSYIdmdi1E5pZ
 jCDN27NVjgGxFsPazNLMVDAxqkw9EA1fc5Twqs55N+Nwo6Vfb8ZbMD+/gKyF2yTUSpaDf0
 Q5tZ2mGLj37+vCJ7v9ECzV6QQ+05GUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744794239;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kSSZDs/io7oy8HANTXiB0Z/0WJpnIO6hO0ojd+ED5x8=;
 b=7K6CkCr289oGoY3OHTRwKwJv9dAvptvZN5PE2ugLmgFOzbZ2jQ5AUFlTipTIWmXGpxE05o
 eEVLlWTJCe2lbJDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744794239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kSSZDs/io7oy8HANTXiB0Z/0WJpnIO6hO0ojd+ED5x8=;
 b=m63qOTWUn5OQ9UotfZQtXLcmXQnnka1A47KpRpcsYRsM7alqRPp4IN+thKSYIdmdi1E5pZ
 jCDN27NVjgGxFsPazNLMVDAxqkw9EA1fc5Twqs55N+Nwo6Vfb8ZbMD+/gKyF2yTUSpaDf0
 Q5tZ2mGLj37+vCJ7v9ECzV6QQ+05GUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744794239;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kSSZDs/io7oy8HANTXiB0Z/0WJpnIO6hO0ojd+ED5x8=;
 b=7K6CkCr289oGoY3OHTRwKwJv9dAvptvZN5PE2ugLmgFOzbZ2jQ5AUFlTipTIWmXGpxE05o
 eEVLlWTJCe2lbJDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90A9713976;
 Wed, 16 Apr 2025 09:03:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QHOjIX9y/2foagAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 16 Apr 2025 09:03:59 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 16 Apr 2025 11:03:59 +0200
MIME-Version: 1.0
Message-Id: <20250416-patchwork_ci-v8-2-503a29526f0a@suse.com>
References: <20250416-patchwork_ci-v8-0-503a29526f0a@suse.com>
In-Reply-To: <20250416-patchwork_ci-v8-0-503a29526f0a@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744794239; l=6029;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=p2H7j0PNe5ryOG5YLvVlbH28d13ezyunKbhlTD205VA=;
 b=03dv+ACW0XktGQaKibzIYeyOGm5LSvs3CxEIwZxOtbDybCqoL7iezxwOqUdTTLuCxbtnMeHgd
 dbX5x1yHo+IA5Xr0ki9z7rHoMeFtMNFtVYdzcUfbRn307OyVj0ubUJ8
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 2/4] ci: add patchwork communication script
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

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 ci/tools/patchwork.sh | 179 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 179 insertions(+)

diff --git a/ci/tools/patchwork.sh b/ci/tools/patchwork.sh
new file mode 100755
index 0000000000000000000000000000000000000000..25d65a2a77d193d5150ba6537b0c6e90e54b7fb5
--- /dev/null
+++ b/ci/tools/patchwork.sh
@@ -0,0 +1,179 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Shell script to communicate with Patchwork via REST API.
+# It has been mainly created for CI purposes, but it can be used in the shell
+# by satisfying minimum requirements.
+#
+# Copyright (c) 2025 Andrea Cervesato <andrea.cervesato@suse.com>
+
+PATCHWORK_URL="${PATCHWORK_URL:-https://patchwork.ozlabs.org}"
+PATCHWORK_SINCE="${PATCHWORK_SINCE:-3600}"
+
+command_exists() {
+        local cmd
+
+        for cmd in "$@"; do
+                if ! command -v "$cmd" >/dev/null 2>&1; then
+                        echo "'$1' must be present in the system" >&2
+                        exit 1
+                fi
+        done
+}
+
+command_exists "curl" "jq"
+
+fetch_series() {
+        local current_time=$(date +%s)
+        local since_time=$(expr $current_time - $PATCHWORK_SINCE)
+        local date=$(date -u -d @$since_time +"%Y-%m-%dT%H:%M:%SZ")
+        local stdout
+
+        stdout=$(curl -k -G "$PATCHWORK_URL/api/events/" \
+                --data "category=series-completed" \
+                --data "project=ltp" \
+                --data "state=new" \
+                --data "since=$date" \
+                --data "archive=no")
+
+        [ $? -eq 0 ] || exit 1
+
+        echo "$stdout" | jq -r '.[] | "\(.payload.series.id) \(.payload.series.mbox)"'
+}
+
+get_patches() {
+        local series_id="$1"
+        local stdout
+
+        stdout="$(curl -k -G $PATCHWORK_URL/api/patches/ \
+                --data project=ltp \
+                --data series=$series_id)"
+
+        [ $? -eq 0 ] || exit 1
+
+        echo "$stdout" | jq -r '.[] | "\(.id)"'
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
+        [ $? -eq 0 ] || exit 1
+}
+
+set_series_state() {
+        local series_id="$1"
+        local state="$2"
+
+        get_patches "$series_id" | while read -r patch_id; do
+                if [ "$patch_id" ]; then
+                        set_patch_state "$patch_id" "$state"
+                fi
+        done
+}
+
+get_checks() {
+        local patch_id="$1"
+        local stdout
+
+        stdout="$(curl -k -G $PATCHWORK_URL/api/patches/$patch_id/checks/)"
+
+        [ $? -eq 0 ] || exit 1
+
+        echo "$stdout" | jq -r '.[] | "\(.id)"'
+}
+
+already_tested() {
+        local series_id="$1"
+
+        get_patches "$series_id" | while read -r patch_id; do
+                [ "$patch_id" ] || continue
+
+                get_checks "$patch_id" | while read -r check_id; do
+                        if [ -n "$check_id" ]; then
+                                echo "$check_id"
+                                return
+                        fi
+                done
+        done
+}
+
+verify_new_patches() {
+        local tmp=$(mktemp -d)
+        local output="$tmp/series_ids.txt"
+
+        touch "$output"
+
+        fetch_series | while read -r series_id series_mbox; do
+                [ "$series_id" ] || continue
+
+                tested=$(already_tested "$series_id")
+                [ "$tested" ] && continue
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
+
+        [ "$CC" ] && context="${context}_${CC}"
+        [ "$ARCH" ] && context="${context}_${ARCH}"
+
+        local result="$4"
+        [ "$result" = "cancelled" ] && return
+
+        local state="fail"
+        [ "$result" = "success" ] && state="success"
+
+        get_patches "$series_id" | while read -r patch_id; do
+                [ "$patch_id" ] || continue
+
+                curl -k -X POST \
+                        -H "Authorization: Token $PATCHWORK_TOKEN" \
+                        -F "state=$state" \
+                        -F "context=$context" \
+                        -F "target_url=$target_url" \
+                        -F "description=$result" \
+                        "$PATCHWORK_URL/api/patches/$patch_id/checks/"
+
+                [ $? -eq 0 ] && exit 1
+        done
+}
+
+case "$1" in
+state)
+        set_series_state "$2" "$3"
+        ;;
+check)
+        send_results "$2" "$3" "$4" "$5"
+        ;;
+verify)
+        verify_new_patches
+        ;;
+*)
+        echo "Available commands: state, check, verify" >&2
+        exit 1
+        ;;
+esac

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
