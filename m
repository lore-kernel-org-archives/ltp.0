Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF53AC369AB
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 13:48:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5152C3CB8C1
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 15:48:54 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 023D73CB874
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 15:48:35 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C5C7260070F
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 15:48:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 14B481F385;
 Tue, 15 Apr 2025 13:48:34 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E2A0139A1;
 Tue, 15 Apr 2025 13:48:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id acVdA7Jj/mfCLQAAD6G6ig
 (envelope-from <pvorel@suse.de>); Tue, 15 Apr 2025 13:48:34 +0000
MIME-Version: 1.0
Date: Tue, 15 Apr 2025 15:48:33 +0200
From: pvorel <pvorel@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.de>
In-Reply-To: <20250415-patchwork_ci-v6-2-81e6d4184af5@suse.com>
References: <20250415-patchwork_ci-v6-0-81e6d4184af5@suse.com>
 <20250415-patchwork_ci-v6-2-81e6d4184af5@suse.com>
User-Agent: Roundcube Webmail
Message-ID: <f7ad5026615f4b00ae033a649fa15b26@suse.de>
X-Sender: pvorel@suse.de
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: 14B481F385
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

TL;DR:
With fixed == and curl pipe redirect, you may add:
Reviewed-by: Petr Vorel <pvorel@suse.cz>

More info below.

> ---
>  ci/tools/patchwork.sh | 169 
> ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 169 insertions(+)
> 
> diff --git a/ci/tools/patchwork.sh b/ci/tools/patchwork.sh
> new file mode 100755
> index
> 0000000000000000000000000000000000000000..bef6998b6168714e0cfaef443a4573017440bb2d
> --- /dev/null
> +++ b/ci/tools/patchwork.sh
> @@ -0,0 +1,169 @@
> +#!/bin/sh -x
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Shell script to communicate with Patchwork via REST API.
> +# It has been mainly created for CI purposes, but it can be used in 
> the shell
> +# by satisfying minimum requirements.
> +#
> +# Copyright (c) 2025 Andrea Cervesato <andrea.cervesato@suse.com>
> +
> +PATCHWORK_URL="${PATCHWORK_URL:-https://patchwork.ozlabs.org}"
> +PATCHWORK_SINCE="${PATCHWORK_SINCE:-3600}"
> +
> +command_exists() {
Can you please add before merge?
local cmd

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
> +                jq -r '.[] | 
> "\(.payload.series.id):\(.payload.series.mbox)"'
> +
> +        [ $? -eq 0 ] || exit 1

FYI $? holds exit code of the last member of pipe, 'jq -r ...' in this 
case.
I guess you'd prefer to check curl exit code, right?

You have 2 options:
1) Redirect curl with '-o log', and call jq after $? evaluation.
2) Depend on bash and use ${PIPESTATUS[0]} (e.g. $PIPESTATUS array).
NOTE: that really requires /bin/bash shebang (e.g. not working on dash 
and busybox sh, thus CI will depend on bash), also will not work on zsh 
which uses $pipestatus array (lower case) :(. We prefer to avoid bash 
(unlike kernel developers) for a good reason (bash incompatibility 
between versions, need to install bash in container, also if arrays are 
needed it's a question whether use shell scripting), but it's mainly due 
the need tests (LTP shell API and tests) to be portable, it could be 
used in tools (with /bin/bash shebang).

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
> +                [ "$patch_id" ] && set_patch_state "$patch_id" 
> "$state"

FYI if you ever wish to use '-e' in a script, construct [ ... ] && ... 
will be broken with it.
It would have to be [ ... ] || ... (or use if  ...; then ...; fi).

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
> +                get_checks "$patch_id" | while IFS= read -r check_id; 
> do
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

FYI echo switches are known to have non-portable edge cases, which 
printf does not have, but this works (ok to use). Using printf would be 
simpler:

printf >"$output"

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
== is a bashism, please use =
> +
> +        local state="fail"
> +        [ "$result" == "success" ] && state="success"
And here as well.

We have checkbashisms part of make check, but that's for our LTP build 
system directories, here you must call it directly:

$ checkbashisms ci/tools/patchwork.sh
possible bashism in ci/tools/patchwork.sh line 135 (should be 'b = a'):
         [ "$result" == "cancelled" ] && return
possible bashism in ci/tools/patchwork.sh line 138 (should be 'b = a'):
         [ "$result" == "success" ] && state="success"


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

I see you don't want to support running whole script in once for 
debugging.

Using '' would allow it (up to you of course, as most of comments):
''|state)

Kind regards,
Petr

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
> +        exit 1
> +        ;;
> +esac
> 
> --
> 2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
