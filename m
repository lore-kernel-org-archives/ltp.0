Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC5CC369B2
	for <ltp@archiver.kernel.org>; Mon, 14 Apr 2025 14:03:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 50E1F3CB70E
	for <ltp@archiver.kernel.org>; Mon, 14 Apr 2025 16:03:17 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 09F8A3CB699
 for <ltp@lists.linux.it>; Mon, 14 Apr 2025 16:03:00 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9E4B16007A5
 for <ltp@lists.linux.it>; Mon, 14 Apr 2025 16:02:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 85D791F38A;
 Mon, 14 Apr 2025 14:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744639378;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YGkcjdGUo+SHymPpbT1ODMMyM/WN/VvHGSKdginub0E=;
 b=F53oInNzHQ2RCYVmPSq9j/YpWoWk+cTq83HNm8P2kOWgThIvikYsgV3PAuKcDmI12NQ5x2
 RjTFYrGvUdVYKocWAZzd95v9/b6Uc0rMPpbAiHfIvdeWtNb3twI4uhBRJwZFJT3MPmA08p
 ocJUNJCT7YRayFrcP58zQ3Xc8JSnKWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744639378;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YGkcjdGUo+SHymPpbT1ODMMyM/WN/VvHGSKdginub0E=;
 b=OB3KpLzrGtGKRItwONMt9djk7iRMbypaFA8RD8OrAurzyYjJC7kpO7umF+VLs81lnGZj1L
 kZNHMHkhRAONh1Ag==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=F53oInNz;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OB3KpLzr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744639378;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YGkcjdGUo+SHymPpbT1ODMMyM/WN/VvHGSKdginub0E=;
 b=F53oInNzHQ2RCYVmPSq9j/YpWoWk+cTq83HNm8P2kOWgThIvikYsgV3PAuKcDmI12NQ5x2
 RjTFYrGvUdVYKocWAZzd95v9/b6Uc0rMPpbAiHfIvdeWtNb3twI4uhBRJwZFJT3MPmA08p
 ocJUNJCT7YRayFrcP58zQ3Xc8JSnKWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744639378;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YGkcjdGUo+SHymPpbT1ODMMyM/WN/VvHGSKdginub0E=;
 b=OB3KpLzrGtGKRItwONMt9djk7iRMbypaFA8RD8OrAurzyYjJC7kpO7umF+VLs81lnGZj1L
 kZNHMHkhRAONh1Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D711136A7;
 Mon, 14 Apr 2025 14:02:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dj6ZGZIV/WdfCQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 14 Apr 2025 14:02:58 +0000
Date: Mon, 14 Apr 2025 16:02:57 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20250414140257.GB443040@pevik>
References: <20250411114326.526-1-andrea.cervesato@suse.de>
 <20250411114326.526-3-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250411114326.526-3-andrea.cervesato@suse.de>
X-Rspamd-Queue-Id: 85D791F38A
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[ozlabs.org:url,suse.cz:replyto,suse.cz:dkim];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 2/4] ci: add patchwork communication script
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

Generally LGTM, few notes below.
Feel free to ignore them, note at '-e' and '-z "$run" -o' (at the end) are bugs
worth to be fixed.

> Add a script to communicate with patchwork. Available commands are:

> - state: change patch-series state
> - check: send a tests report to patchwork
> - verify: will print a list of new patch-series which has not been
>   tested in the past hour (by default)

> The script can be configured defining:

> - PATCHWORK_URL: patchwork url to communicate with
> - PATCHWORK_TOKEN: patchwork authentication token
> - PATCHWORK_SINCE: timespan in seconds where we want to fetch
>   patch-series

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  ci/tools/patchwork.sh | 197 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 197 insertions(+)
>  create mode 100755 ci/tools/patchwork.sh

> diff --git a/ci/tools/patchwork.sh b/ci/tools/patchwork.sh
> new file mode 100755
> index 000000000..d43b7fd61
> --- /dev/null
> +++ b/ci/tools/patchwork.sh

+1 for having the script in tools directory (the ci/ directory is kept for
distro installation scripts, which can be reused by the others).

> @@ -0,0 +1,197 @@
> +#!/bin/sh -ex
-e in shebang (i.e. 'set -e') means quit after error.
This will lead to some unreachable code. If you have proper error handling, '-e'
should not be needed. Or if you want really to '-e' cause to quit early, please
drop whole error handling (it's useless). '-x' is quite verbose, it will be
visible when the code quit (just without your explanations).

see "Argument List Processing"
https://man7.org/linux/man-pages/man1/dash.1.html

or
https://www.gnu.org/software/bash/manual/bash.html#Bourne-Shell-Builtins#The-Set-Builtin-1


> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Shell script that can be used to communicate with Patchwork via REST API.
> +# It has been mainly created for CI purposes, but it can be used in the shell
> +# by satisfing minimum requirements.
typo: s/satisfing/satisfying/

> +#
> +# Copyright (c) 2025 Andrea Cervesato <andrea.cervesato@suse.com>
> +
> +command_exists() {
> +        command -v $1 >/dev/null 2>&1
Here script quit if $1 will not be found...
> +
> +        if [ $? -ne 0 ]; then
> +                echo "'$1' must be present in the system"
nit: maybe redirect error to stderr?
                   echo "'$1' must be present in the system" >&2

> +                exit 1
> +        fi
... Therefore the above code will not be shown when shebang contains '-e'.
> +}
> +
> +command_exists "curl"
> +command_exists "jq"
very minor: I would make a loop in command_exists (as done in tst_require_cmds) and call it:
command_exists curl jq

> +
> +if [ -z "$PATCHWORK_URL" ]; then
> +        PATCHWORK_URL="https://patchwork.ozlabs.org"
> +fi
> +
> +if [ -z "$PATCHWORK_SINCE" ]; then
> +        PATCHWORK_SINCE=3600
> +fi

IMHO it's more readable if global variables are defined above the functions
(i.e. before command_exists(), not in the middle of function setup.

Also all shells support :- with default parameter:

PATCHWORK_URL="${PATCHWORK_URL:-https://patchwork.ozlabs.org}"
PATCHWORK_SINCE="${PATCHWORK_SINCE:-3600}"

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
> +
> +        if [ $? -ne 0 ]; then
> +                exit 1
Again, '-e' means quit immediately after curl exit with non-zero code.

Only if you decide to remove '-e': curl has various exit codes. I was thinking
if exit the real curl exit code would be useful. OTOH the error message will be
visible, thus probably not needed.

> +        fi
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
> +        if [ $? -ne 0 ]; then
> +                exit 1
> +        fi
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
> +        if [ $? -ne 0 ]; then
> +                exit 1
> +        fi
> +}
> +
> +set_series_state() {
> +        local series_id="$1"
> +        local state="$2"
> +
> +        get_patches "$series_id" | while IFS= read -r patch_id; do
> +                if [ -n "$patch_id" ]; then
> +                        set_patch_state "$patch_id" "$state"
> +                fi
> +        done
> +}
> +
> +get_checks() {
> +        local patch_id="$1"
> +
> +        curl -k -G "$PATCHWORK_URL/api/patches/$patch_id/checks/" |
> +                jq -r '.[] | "\(.id)"'
> +
> +        if [ $? -ne 0 ]; then
> +                exit 1
> +        fi
> +}
> +
> +already_tested() {
> +        local series_id="$1"
> +
> +        get_patches "$series_id" | while IFS= read -r patch_id; do
> +                if [ ! -n "$patch_id" ]; then
> +                        continue
> +                fi
FYI: common shell shorter (works everywhere):
                   [ -n "$patch_id" ] || continue

Or even:
                   [ "$patch_id" ] || continue

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
> +        local output="series_ids.txt"
> +
> +        echo -n '' >"$output"

series_ids.txt is stored in current working directory, right? Clearer it'd be to
use mktemp (part of coreutils and busybox, probably as common as date, which we
also expect to be available, at least it's on Alpine).

That way git clone is not polluted.

> +
> +        fetch_series | while IFS=: read -r series_id series_mbox; do
> +                if [ ! -n "$series_id" ]; then
> +                        continue
> +                fi
> +
> +                tested=$(already_tested "$series_id")
> +                if [ -n "$tested" ]; then
> +                        continue
> +                fi
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
> +        if [ -n "$CC" ]; then
> +                context="${context}_${CC}"
> +        fi
> +
> +        if [ -n "$ARCH" ]; then
> +                context="${context}_${ARCH}"
> +        fi
> +
> +        local result="$4"
> +        if [ "$result" = "cancelled" ]; then
> +                return
> +        fi
> +
> +        local state="fail"
> +        if [ "$result" = "success" ]; then
> +                state="success"
> +        fi
> +
> +        get_patches "$series_id" | while IFS= read -r patch_id; do
> +                if [ -n "$patch_id" ]; then
> +                        curl -k -X POST \
> +                                -H "Authorization: Token $PATCHWORK_TOKEN" \
> +                                -F "state=$state" \
> +                                -F "context=$context" \
> +                                -F "target_url=$target_url" \
> +                                -F "description=$result" \
> +                                "$PATCHWORK_URL/api/patches/$patch_id/checks/"
This will help you to save one indent:
                   [ -z "$patch_id" ] || continue
				   curl -k -X POST \

> +
> +                        if [ $? -ne 0 ]; then
> +                                exit 1
> +                        fi
> +                fi
> +        done
> +}
> +
> +run="$1"
> +
> +if [ -z "$run" -o "$run" = "state" ]; then
> +        set_series_state "$2" "$3"
> +elif [ -z "$run" -o "$run" = "check" ]; then

'-z "$run"' is unreachable code (if $run is empty, it's run in the above if and
both elif and else blocks are skipped).

You could have something like:

case "$1" in
	state|check|verify|"") run="$1";;
	*) echo "Available commands: state, check, verify"; exit 1;;
esac

if [ -z "$run" -o "$run" = "state" ]; then
        set_series_state "$2" "$3"
fi

if [ -z "$run" -o "$run" = "check" ]; then
        send_results "$2" "$3" "$4" "$5"
fi

if [ -z "$run" -o "$run" = "verify" ]; then
        verify_new_patches
fi

Kind regards,
Petr

> +        send_results "$2" "$3" "$4" "$5"
> +elif [ -z "$run" -o "$run" = "verify" ]; then
> +        verify_new_patches
> +else
> +        echo "Available commands: state, check, verify"
> +        exit 1
> +fi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
