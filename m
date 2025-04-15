Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C785CC369AB
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 15:36:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E2CE23CB928
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 17:36:13 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8042C3CA59D
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 17:35:56 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0054C1000ECF
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 17:35:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 942321F387;
 Tue, 15 Apr 2025 15:35:53 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 84979139A1;
 Tue, 15 Apr 2025 15:35:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GE4yH9l8/mc9UgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 15 Apr 2025 15:35:53 +0000
Date: Tue, 15 Apr 2025 17:36:25 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Z_58-c488Qb3dkYn@yuki.lan>
References: <20250415-patchwork_ci-v6-0-81e6d4184af5@suse.com>
 <20250415-patchwork_ci-v6-2-81e6d4184af5@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250415-patchwork_ci-v6-2-81e6d4184af5@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: 942321F387
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 2/4] ci: add patchwork communication script
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  ci/tools/patchwork.sh | 169 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 169 insertions(+)
> 
> diff --git a/ci/tools/patchwork.sh b/ci/tools/patchwork.sh
> new file mode 100755
> index 0000000000000000000000000000000000000000..bef6998b6168714e0cfaef443a4573017440bb2d
> --- /dev/null
> +++ b/ci/tools/patchwork.sh
> @@ -0,0 +1,169 @@
> +#!/bin/sh -x
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Shell script to communicate with Patchwork via REST API.
> +# It has been mainly created for CI purposes, but it can be used in the shell
> +# by satisfying minimum requirements.
> +#
> +# Copyright (c) 2025 Andrea Cervesato <andrea.cervesato@suse.com>
> +
> +PATCHWORK_URL="${PATCHWORK_URL:-https://patchwork.ozlabs.org}"
> +PATCHWORK_SINCE="${PATCHWORK_SINCE:-3600}"
> +
> +command_exists() {
> +        for cmd in "$@"; do
> +                if ! command -v "$cmd" >/dev/null 2>&1; then
> +                        echo "'$1' must be present in the system" >&2
> +                        exit 1
> +                fi
> +        done
> +}
> +
> +command_exists "curl" "jq"
> +
> +fetch_series() {
> +        local current_time=$(date +%s)
> +        local since_time=$(expr $current_time - $PATCHWORK_SINCE)
> +        local date=$(date -u -d @$since_time +"%Y-%m-%dT%H:%M:%SZ")
> +
> +        curl -k -G "$PATCHWORK_URL/api/events/" \
> +                --data "category=series-completed" \
> +                --data "project=ltp" \
> +                --data "state=new" \
> +                --data "since=$date" \
> +                --data "archive=no" |
> +                jq -r '.[] | "\(.payload.series.id):\(.payload.series.mbox)"'
                                                      ^
We add ':' here and then we have to use IFS=':' to parse these values.
Wouldn't this work without the need to fiddle with IFS if we just added
space here instead?

If that worked we could get rid of all the IFS= assigments in the
script.

> +        [ $? -eq 0 ] || exit 1
> +}
> +
> +get_patches() {
> +        local series_id="$1"
> +
> +        curl -k -G "$PATCHWORK_URL/api/patches/" \
> +                --data "project=ltp" \
> +                --data "series=$series_id" |
> +                jq -r '.[] | "\(.id)"'
> +
> +        [ $? -eq 0 ] || exit 1
> +}
> +
> +verify_token_exists() {
> +        if [ -z "$PATCHWORK_TOKEN" ]; then
> +                echo "For this feature you need \$PATCHWORK_TOKEN"
> +                exit 1
> +        fi
> +}
> +
> +set_patch_state() {
> +        local patch_id="$1"
> +        local state="$2"
> +
> +        verify_token_exists
> +
> +        curl -k -X PATCH \
> +                -H "Authorization: Token $PATCHWORK_TOKEN" \
> +                -F "state=$state" \
> +                "$PATCHWORK_URL/api/patches/$patch_id/"
> +
> +        [ $? -eq 0 ] || exit 1
> +}
> +
> +set_series_state() {
> +        local series_id="$1"
> +        local state="$2"
> +
> +        get_patches "$series_id" | while IFS= read -r patch_id; do
> +                [ "$patch_id" ] && set_patch_state "$patch_id" "$state"
> +        done
> +}
> +
> +get_checks() {
> +        local patch_id="$1"
> +
> +        curl -k -G "$PATCHWORK_URL/api/patches/$patch_id/checks/" |
> +                jq -r '.[] | "\(.id)"'
> +
> +        [ $? -eq 0 ] || exit 1
> +}
> +
> +already_tested() {
> +        local series_id="$1"
> +
> +        get_patches "$series_id" | while IFS= read -r patch_id; do
> +                [ "$patch_id" ] || continue
> +
> +                get_checks "$patch_id" | while IFS= read -r check_id; do
> +                        if [ -n "$check_id" ]; then
> +                                echo "$check_id"
> +                                return
> +                        fi
> +                done
> +        done
> +}
> +
> +verify_new_patches() {
> +        local tmp=$(mktemp -d)
> +        local output="$tmp/series_ids.txt"
> +
> +        echo -n '' >"$output"
> +
> +        fetch_series | while IFS=: read -r series_id series_mbox; do
> +                [ "$series_id" ] || continue
> +
> +                tested=$(already_tested "$series_id")
> +                [ "$tested" ] && continue
> +
> +                echo "$series_id|$series_mbox" >>"$output"
> +        done
> +
> +        cat "$output"
> +}
> +
> +send_results() {
> +        local series_id="$1"
> +        local target_url="$2"
> +
> +        verify_token_exists
> +
> +        local context=$(echo "$3" | sed 's/:/_/g; s/\//-/g; s/\./-/g')
> +
> +        [ "$CC" ] && context="${context}_${CC}"
> +        [ "$ARCH" ] && context="${context}_${ARCH}"
> +
> +        local result="$4"
> +        [ "$result" == "cancelled" ] && return
> +
> +        local state="fail"
> +        [ "$result" == "success" ] && state="success"
> +
> +        get_patches "$series_id" | while IFS= read -r patch_id; do
> +                [ "$patch_id" ] || continue
> +
> +                curl -k -X POST \
> +                        -H "Authorization: Token $PATCHWORK_TOKEN" \
> +                        -F "state=$state" \
> +                        -F "context=$context" \
> +                        -F "target_url=$target_url" \
> +                        -F "description=$result" \
> +                        "$PATCHWORK_URL/api/patches/$patch_id/checks/"
> +
> +                [ $? -eq 0 ] && exit 1
> +        done
> +}
> +
> +case "$1" in
> +state)
> +        set_series_state "$2" "$3"
> +        ;;
> +check)
> +        send_results "$2" "$3" "$4" "$5"
> +        ;;
> +verify)
> +        verify_new_patches
> +        ;;
> +*)
> +        echo "Available commands: state, check, verify"

Possibly write this to stderr (&>2)?

> +        exit 1
> +        ;;
> +esac

Other than these:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
