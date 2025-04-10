Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 104D5C369A2
	for <ltp@archiver.kernel.org>; Thu, 10 Apr 2025 18:21:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D67F3CB3FA
	for <ltp@archiver.kernel.org>; Thu, 10 Apr 2025 20:21:52 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ECC703CB355
 for <ltp@lists.linux.it>; Thu, 10 Apr 2025 20:21:16 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0A3B51000450
 for <ltp@lists.linux.it>; Thu, 10 Apr 2025 20:21:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8736521166;
 Thu, 10 Apr 2025 18:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744309274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BU9IkawT6q9XwOV/lSydEUq4QVLLawKeM2Xc0HHj0es=;
 b=i2XXTeBidPwbPl0qrCAgTLwYWhdxksRAoQ45Tgn/hu2f3BgQ7e1+CI1RwaSyhP0rGMnXIJ
 m5ulru2BHSsuzh9uf0q5OyrmpAF7imIgszaQLKk7FStRdHmZbVpAeRYm+9cvJHUiUdWDnO
 TC2sCSw1x4ZC2scgMiotkWC+As+7Nqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744309274;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BU9IkawT6q9XwOV/lSydEUq4QVLLawKeM2Xc0HHj0es=;
 b=Yjxd78IIp8a08nvE0xapxV0awezwDPq4P2HzzxK6cxpZKM2tM3ne1Yagy2JYCom1VDQDju
 XCE0LHjOvgmMNRAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=i2XXTeBi;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Yjxd78II
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744309274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BU9IkawT6q9XwOV/lSydEUq4QVLLawKeM2Xc0HHj0es=;
 b=i2XXTeBidPwbPl0qrCAgTLwYWhdxksRAoQ45Tgn/hu2f3BgQ7e1+CI1RwaSyhP0rGMnXIJ
 m5ulru2BHSsuzh9uf0q5OyrmpAF7imIgszaQLKk7FStRdHmZbVpAeRYm+9cvJHUiUdWDnO
 TC2sCSw1x4ZC2scgMiotkWC+As+7Nqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744309274;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BU9IkawT6q9XwOV/lSydEUq4QVLLawKeM2Xc0HHj0es=;
 b=Yjxd78IIp8a08nvE0xapxV0awezwDPq4P2HzzxK6cxpZKM2tM3ne1Yagy2JYCom1VDQDju
 XCE0LHjOvgmMNRAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3464B132D8;
 Thu, 10 Apr 2025 18:21:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yLGsBhoM+GfPQwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 10 Apr 2025 18:21:14 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 10 Apr 2025 20:21:11 +0200
MIME-Version: 1.0
Message-Id: <20250410-patchwork_ci-v2-2-288f4be835ff@suse.com>
References: <20250410-patchwork_ci-v2-0-288f4be835ff@suse.com>
In-Reply-To: <20250410-patchwork_ci-v2-0-288f4be835ff@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744309273; l=5879;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=ro8UyfRtU0Evzp4aACJhTQse4WKSQuDwJ0hNP20SkDc=;
 b=nAiRshCHyMYia5CpZdLFXvY5VsEqYwmzopWEJR8oVefIrgJgjOwhygJNFmN0tXcEWGJGETnpL
 I0cSb77hRDMBNLZFfjQr7jK9zSIdLX9BSo1RWXLsnbqMKMvVcZfQUVR
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 8736521166
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/4] ci: add patchwork-ci script
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
 ci/patchwork-ci.sh | 164 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/ci/patchwork-ci.sh b/ci/patchwork-ci.sh
new file mode 100755
index 0000000000000000000000000000000000000000..f363055578c831f9426564cd8530348a8f9f76e2
--- /dev/null
+++ b/ci/patchwork-ci.sh
@@ -0,0 +1,164 @@
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
+}
+
+get_patches() {
+        local series_id="$1"
+
+        curl -k -G "$PATCHWORK_URL/api/patches/" \
+                --data "project=ltp" \
+                --data "series=$series_id" |
+                jq -r '.[] | "\(.id)"'
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
+                echo -n "$series_id:$series_mbox;" >>"$output"
+        done
+
+        if [ -e "$output" ]; then
+                cat "$output"
+        fi
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
+        local context=$(echo "$3" | sed 's/:/_/g; s/\//_/g')
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
