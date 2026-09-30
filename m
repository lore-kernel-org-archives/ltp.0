Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E94CA5FC7
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 14:42:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA49B3E5E11
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 16:42:17 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4DC263E1A5A
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 16:42:01 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A4EFB1A0043E
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 16:41:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5BA9E21E51;
 Wed, 30 Sep 2026 14:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790779312;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tTLBQQko7VOV85LcxJ2PnSGT6BqSWmWEb1Qbzo7dA7Y=;
 b=ZF6l4qn3rlQNr2jKz/1bVCacZizg0i91XgH8yoHe3T19JfwmzmIZAsQ1aXUWKybhBiPU91
 ww5LLwmpkkuUZMEUHVEWDZ7qkG3jEmHtIFi2qwqMZ+vHwo2m1O7X1z1ZzDBMvGpgDHE+V9
 zvywNqW9zXIAYGneU7GKWmoal0czZxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790779312;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tTLBQQko7VOV85LcxJ2PnSGT6BqSWmWEb1Qbzo7dA7Y=;
 b=WDDaxdZL1A6FZHqsEG+jQRCF50Pe6PB402ajj87GFHNjx8VO633Ozd80juIbfucJ+sRLY5
 kbmDziCYbh0wKbAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790779308;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tTLBQQko7VOV85LcxJ2PnSGT6BqSWmWEb1Qbzo7dA7Y=;
 b=Z0JnZLyBEKCPyj8cNtK94ScGEeei8wtzqAVfZYxjFH0JD80VFKwkcq1OipIhL2Q8wFLNyn
 Fsxl+Kyb5C03H40PhNbZjwbHZbmE5g5a3XaRxqok0lMD0xgkpnWmbHcA+Y0NYLQjRxGH8g
 8wdw3DKjZQuWlwa1Dman5F6EvXd7amM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790779308;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tTLBQQko7VOV85LcxJ2PnSGT6BqSWmWEb1Qbzo7dA7Y=;
 b=+r6TXF8ohpGbd3pNOwoTu+q8rdWlBygprV939+HEx5oCvQ0extXt1tKYqFKQX4GxKy/jYK
 j5aTqYq+fBHOonAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 127BA136AD;
 Wed, 30 Sep 2026 14:41:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id slCONKsfvWrXBwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 30 Sep 2026 14:41:48 +0000
Date: Wed, 30 Sep 2026 16:41:46 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260930144146.GB2729765@pevik>
References: <20260930-fix_generate_syscalls-v1-0-fccaef437fa1@suse.com>
 <20260930-fix_generate_syscalls-v1-2-fccaef437fa1@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260930-fix_generate_syscalls-v1-2-fccaef437fa1@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; TO_DN_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,generate_arch.sh:url,suse.cz:email,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] syscalls: Update numbers to Linux v7.3-rc5
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> Update architecture syscall tables up to Linux v7.3-rc5 using the
> updated generate_arch.sh script. This adds clone3 on sparc/sparc64,
> uprobe on x86_64, and new generic syscalls (listns, rseq_slice_yield,
> fchroot), while preserving legacy syscall numbers.

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  include/lapi/syscalls/arc.in         | 3 +++
>  include/lapi/syscalls/arm.in         | 4 ++++
>  include/lapi/syscalls/arm64.in       | 3 +++
>  include/lapi/syscalls/i386.in        | 6 ++++++
>  include/lapi/syscalls/loongarch64.in | 3 +++
>  include/lapi/syscalls/mips64.in      | 3 +++
>  include/lapi/syscalls/mips64n32.in   | 3 +++
>  include/lapi/syscalls/mipso32.in     | 7 +++++--
>  include/lapi/syscalls/parisc.in      | 4 ++++
>  include/lapi/syscalls/powerpc.in     | 7 +++++++
>  include/lapi/syscalls/powerpc64.in   | 7 +++++++
>  include/lapi/syscalls/s390x.in       | 4 ++++
>  include/lapi/syscalls/sh.in          | 4 ++++
>  include/lapi/syscalls/sparc.in       | 5 +++++
>  include/lapi/syscalls/sparc64.in     | 5 +++++
>  include/lapi/syscalls/x86_64.in      | 4 ++++
>  16 files changed, 70 insertions(+), 2 deletions(-)

LGTM, thanks! Smaller diff is really better
Reviewed-by: Petr Vorel <pvorel@suse.cz>

> diff --git a/include/lapi/syscalls/arc.in b/include/lapi/syscalls/arc.in
> index 0f0fbef6b..96b14c1b9 100644
> --- a/include/lapi/syscalls/arc.in
> +++ b/include/lapi/syscalls/arc.in
> @@ -347,3 +347,6 @@ removexattrat 466
>  open_tree_attr 467
>  file_getattr 468
>  file_setattr 469
> +listns 470
> +rseq_slice_yield 471
> +fchroot 472
> diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
> index d0238dec5..5b6047bd2 100644
> --- a/include/lapi/syscalls/arm.in
> +++ b/include/lapi/syscalls/arm.in
> @@ -96,6 +96,7 @@ delete_module 129
>  quotactl 131
>  getpgid 132
>  fchdir 133
> +bdflush 134

At least this one was added here due your fixes in the first patch, because this
should have been here before:

git show b48c7236b13cb5 arch/arm/tools/syscall.tbl # v5.15-rc1
-134    common  bdflush                 sys_bdflush
+134    common  bdflush                 sys_ni_syscall

This commit added it for 15 archs (of 17 at the time).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
