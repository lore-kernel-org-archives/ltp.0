Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE636C3DA4A
	for <ltp@archiver.kernel.org>; Fri,  9 Aug 2024 08:45:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 73F073D20AD
	for <ltp@archiver.kernel.org>; Fri,  9 Aug 2024 10:45:47 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3916C3CE53D
 for <ltp@lists.linux.it>; Fri,  9 Aug 2024 10:45:31 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DE82360073C
 for <ltp@lists.linux.it>; Fri,  9 Aug 2024 10:45:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1161C1FF2B;
 Fri,  9 Aug 2024 08:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1723193129;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Oz5XCnVr+FypmPJEi6pU3uS+tGEs8F1XHmRysZEquuY=;
 b=YrrCG85G8Qb8E+h/NhhaTJeTXEdavYtv4tbxKOt59Jf9fHmRNOB0Ubf7jkiUhVIVdB7Ty1
 46yY+orol74LHaFqgoQFjihQENwWWqLR/D8fGvVITSouz49bTMYw97vClfKRkLqcibK0MS
 maaW+1xO/NFAtCXrekeZ3rYEWTCbxZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1723193129;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Oz5XCnVr+FypmPJEi6pU3uS+tGEs8F1XHmRysZEquuY=;
 b=CdUseHQt5X7QYOiicdQU8xOaaDEDNCd1MWVWPHCgXO5A145opCKTcdQXB0wSf8ZgJMTmzc
 CuIoU232PLNGVADg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1723193129;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Oz5XCnVr+FypmPJEi6pU3uS+tGEs8F1XHmRysZEquuY=;
 b=YrrCG85G8Qb8E+h/NhhaTJeTXEdavYtv4tbxKOt59Jf9fHmRNOB0Ubf7jkiUhVIVdB7Ty1
 46yY+orol74LHaFqgoQFjihQENwWWqLR/D8fGvVITSouz49bTMYw97vClfKRkLqcibK0MS
 maaW+1xO/NFAtCXrekeZ3rYEWTCbxZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1723193129;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Oz5XCnVr+FypmPJEi6pU3uS+tGEs8F1XHmRysZEquuY=;
 b=CdUseHQt5X7QYOiicdQU8xOaaDEDNCd1MWVWPHCgXO5A145opCKTcdQXB0wSf8ZgJMTmzc
 CuIoU232PLNGVADg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3B7513A7D;
 Fri,  9 Aug 2024 08:45:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Z68nNijXtWaTKQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 09 Aug 2024 08:45:28 +0000
Date: Fri, 9 Aug 2024 10:45:27 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ma Xinjian <maxj.fnst@fujitsu.com>
Message-ID: <20240809084527.GA337675@pevik>
References: <20240809073010.793324-1-maxj.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240809073010.793324-1-maxj.fnst@fujitsu.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] cgroup_fj_common.sh: Do not disable systemd
 related cgroup subsystems
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

Hi Ma,

> The cpu, io, memory, and pids subsystems under the root cgroup cannot be disabled
> because they are used for systemd. Currently, the test of cpu and memory subsystems
> in cgroup_fj_function.sh and cgroup_fj_stress.sh will report the error
> "echo: write error: device or resource busy".

Could you please share a bit of info on which system it fails. Do you use cgroup v1?

Kind regards,
Petr

> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
> ---
>  .../kernel/controllers/cgroup_fj/cgroup_fj_common.sh      | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

> diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
> index e866641ba..153d351d7 100755
> --- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
> +++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
> @@ -77,7 +77,13 @@ common_cleanup()

>      cgroup_cleanup

> -    [ "$cgroup_version" = "2" ] && ROD echo "-$subsystem" \> "/sys/fs/cgroup/cgroup.subtree_control"
> +    if [ "$cgroup_version" = "2" ]; then
> +        case "$subsystem" in
> +        cpu|io|memory|pids)
> +            :;;
> +        *) ROD echo "-$subsystem" \> "/sys/fs/cgroup/cgroup.subtree_control";;
> +        esac
> +    fi
>  }

>  . cgroup_lib.sh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
