Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85BCC36010
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 08:03:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A89C3CB5A3
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 10:03:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0EED53CB5B6
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 10:02:57 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B4D0A600A8C
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 10:02:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 70AF31F457;
 Fri, 11 Apr 2025 08:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744358562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OSQh2NUiahLj3o8vEDNzHxzdcOdYHDwUSaoILjULHT8=;
 b=wQ+2LCNd7gCzl2KqkC2iKYDLg31M/KSwKbso3ifxq97dNaLaDtrUEN5hqF6JpMyyiHCAku
 cxsRhx41+nxGfWZWkk2+JDJ8JJBj3jXfhQ59uDMubmKfbXyKvdcgo3dhgFyR2L71b7urhI
 08OOETZApVqpnH9yNuzsF/u63BELoDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744358562;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OSQh2NUiahLj3o8vEDNzHxzdcOdYHDwUSaoILjULHT8=;
 b=BeC/pIH2ktkDyqJZfKKoEl8ylT/qkqwbI2/nqgE5Y6AGkogbZ3mkIhZRzSOOdJ2MEVdytK
 RpA6U8wwBOxVD+CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744358562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OSQh2NUiahLj3o8vEDNzHxzdcOdYHDwUSaoILjULHT8=;
 b=wQ+2LCNd7gCzl2KqkC2iKYDLg31M/KSwKbso3ifxq97dNaLaDtrUEN5hqF6JpMyyiHCAku
 cxsRhx41+nxGfWZWkk2+JDJ8JJBj3jXfhQ59uDMubmKfbXyKvdcgo3dhgFyR2L71b7urhI
 08OOETZApVqpnH9yNuzsF/u63BELoDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744358562;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OSQh2NUiahLj3o8vEDNzHxzdcOdYHDwUSaoILjULHT8=;
 b=BeC/pIH2ktkDyqJZfKKoEl8ylT/qkqwbI2/nqgE5Y6AGkogbZ3mkIhZRzSOOdJ2MEVdytK
 RpA6U8wwBOxVD+CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5217513A7A;
 Fri, 11 Apr 2025 08:02:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EIJqEqLM+GeKDAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 11 Apr 2025 08:02:42 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 11 Apr 2025 10:01:57 +0200
MIME-Version: 1.0
Message-Id: <20250411-patchwork_ci-v4-2-7f3c5ba298a1@suse.com>
References: <20250411-patchwork_ci-v4-0-7f3c5ba298a1@suse.com>
In-Reply-To: <20250411-patchwork_ci-v4-0-7f3c5ba298a1@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744358561; l=6270;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=hlVYL2qg9DqVMgegGf8BGfJvqGauaB1wyu5HisTr6KI=;
 b=l8DgkF5COcMJ6vxpPT2hHD6Ch1YC695mHqi3AZw7FbOLoU58j1njJWZRnIygk0GrRqIHo1gOj
 Ko2HbwFz3B0DCNWkc1306RgdbzBILLNhQEdoe2Q3tgWe4yP/mg2drpE
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/4] ci: add patchwork-ci script
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

- verify: will print a list of new patch-series which has not been
  tested in the past hour (by default)
- apply: apply a patch-series to the current git branch using git-am
- check: send a tests report to patchwork

The script can be configured defining:

- PATCHWORK_URL: patchwork url to communicate with
- PATCHWORK_SINCE: timespan in seconds where we want to fetch
  patch-series

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 ci/patchwork-ci.sh | 184 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 184 insertions(+)

diff --git a/ci/patchwork-ci.sh b/ci/patchwork-ci.sh
new file mode 100755
index 0000000000000000000000000000000000000000..7c62b2f5b7e67cb0951f0b1492b519297e750eba
--- /dev/null
+++ b/ci/patchwork-ci.sh
@@ -0,0 +1,184 @@
+#!/bin/sh -ex
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2025 Andrea Cervesato <andrea.cervesato@suse.com>
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
+set_patch_state() {
+        local patch_id="$1"
+        local state="$2"
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
+        local output="output.txt"
+
+        touch "$output"
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
+apply_series() {
+        local series_id="$1"
+        local series_mbox="$2"
+
+        git config --global user.name 'GitHub CI'
+        git config --global user.email 'patchwork.tester@example.org'
+        git config --global --add safe.directory $GITHUB_WORKSPACE
+
+        curl -k "$series_mbox" | git am
+
+        # we set patch state after applying it, so
+        # the next triggering won't take patch into account
+        set_series_state "$series_id" "needs-review-ack"
+}
+
+send_results() {
+        local series_id="$1"
+        local target_url="$2"
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
+if [ -z "$run" -o "$run" = "verify" ]; then
+        verify_new_patches
+elif [ -z "$run" -o "$run" = "apply" ]; then
+        apply_series "$2" "$3"
+elif [ -z "$run" -o "$run" = "check" ]; then
+        send_results "$2" "$3" "$4" "$5"
+else
+        echo "Available commands: apply, check, verify"
+        exit 1
+fi

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
