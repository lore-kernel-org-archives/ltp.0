Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF23C369AB
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 17:36:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA9B63CB923
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 19:36:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F17573C0229
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 19:35:44 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0C3FA1000421
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 19:35:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6218A1F461;
 Tue, 15 Apr 2025 17:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744738542;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DLWCMPQmHU+T1mKja9V1cwh8Uv3C2q1x3rzTP3aRXe8=;
 b=s5dOx8jBsfvJ6Mfj2pRti3nSgkNV26pveff0kVGFKI7vrcroQ51CgeROaf+fVnvFTK7rIX
 ogk0YT9SYuw20qBZU8kvE9wkCI2nqqMQGrRujuOViT9iYvELm2XaHj8nlXdXnScdFm0Sje
 ZzLwlsVXcCrXzDQ+q6BxPZHEPd5jD40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744738542;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DLWCMPQmHU+T1mKja9V1cwh8Uv3C2q1x3rzTP3aRXe8=;
 b=WYxp4rpRVFjZrkdQGFW+qiiBkMSZVIoBEYdpHx6TFHt4KXCvReDv/q4r4lcNCi9fohI7Y2
 cANpXne2BfTHRKAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=s5dOx8jB;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WYxp4rpR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744738542;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DLWCMPQmHU+T1mKja9V1cwh8Uv3C2q1x3rzTP3aRXe8=;
 b=s5dOx8jBsfvJ6Mfj2pRti3nSgkNV26pveff0kVGFKI7vrcroQ51CgeROaf+fVnvFTK7rIX
 ogk0YT9SYuw20qBZU8kvE9wkCI2nqqMQGrRujuOViT9iYvELm2XaHj8nlXdXnScdFm0Sje
 ZzLwlsVXcCrXzDQ+q6BxPZHEPd5jD40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744738542;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DLWCMPQmHU+T1mKja9V1cwh8Uv3C2q1x3rzTP3aRXe8=;
 b=WYxp4rpRVFjZrkdQGFW+qiiBkMSZVIoBEYdpHx6TFHt4KXCvReDv/q4r4lcNCi9fohI7Y2
 cANpXne2BfTHRKAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 33D5D137A5;
 Tue, 15 Apr 2025 17:35:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xWGgCO6Y/me+dQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 15 Apr 2025 17:35:42 +0000
Date: Tue, 15 Apr 2025 19:35:35 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20250415173535.GA520691@pevik>
References: <20250415-patchwork_ci-v7-0-bc0b9adca971@suse.com>
 <20250415-patchwork_ci-v7-2-bc0b9adca971@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250415-patchwork_ci-v7-2-bc0b9adca971@suse.com>
X-Rspamd-Queue-Id: 6218A1F461
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[4]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 2/4] ci: add patchwork communication script
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

...
> +fetch_series() {
> +        local current_time=$(date +%s)
> +        local since_time=$(expr $current_time - $PATCHWORK_SINCE)
> +        local date=$(date -u -d @$since_time +"%Y-%m-%dT%H:%M:%SZ")
> +        local stdout=$(curl -k -G "$PATCHWORK_URL/api/events/" \
> +                --data "category=series-completed" \
> +                --data "project=ltp" \
> +                --data "state=new" \
> +                --data "since=$date" \
> +                --data "archive=no")
> +
> +        [ $? -eq 0 ] || exit 1

You may have noticed in tst_test.sh, that local variable never uses $(...).
It assign single value, but never call $(...). This is for a reason.

Try:

$ cat foo.sh
#!/bin/sh

foo()
{
    local foo=$(aasfd_command_which_fails)

    [ $? -eq 0 ] || exit 1
    echo "run after"
}

bar()
{
    local foo

    foo=$(aasfd_command_which_fails)

    [ $? -eq 0 ] || exit 1
    echo "will not run after"
}

foo
bar

---
$ bash ./foo.sh
./foo.sh: line 5: aasfd_command_which_fails: command not found
run after
./foo.sh: line 15: aasfd_command_which_fails: command not found

What happen? $? is assigned from result of local keyword,
it overwrite previous result from $(...). Note even '#!/bin/sh -e'
would not cause it to fail early.

(Deliberately test with bash to demonstrate local behaves oddly not even in dash
or 'busybox sh' but even with bash. And yes, given how many errors we caught
with this script and generate_arch.sh and generate_syscalls.sh due shell strange
syntax and behavior makes me wonder if we really want to use shell scripts for
anything longer than 5 lines.)

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
