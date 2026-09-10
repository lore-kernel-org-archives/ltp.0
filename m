Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BA5C79F9F
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 19:07:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 18CBD3E30D4
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 21:07:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C22D23C2024
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 21:07:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6EDCD1A00114
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 21:07:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0B2231FE82;
 Thu, 10 Sep 2026 19:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789067240;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jZl8fsLySrOUhQYMDXjqq52Rxjrdq+id2eWJaQcQK24=;
 b=HnamSHRaYkbNsf4Sf0PzuNdmomilg4Balf0pQ2iFTa5WvjVnuWp/YHLByEThDWMhhc9Q8a
 ZF4aDn3MCduuzgjxs0rhbahB+KNnZYgxjHe7YOfZqRkrsdnMv3jLXIv1JygL7EfgTsZfI2
 4eimMS1TzsZVbKDoUlklIc6sFOIpQmA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789067240;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jZl8fsLySrOUhQYMDXjqq52Rxjrdq+id2eWJaQcQK24=;
 b=BD+4DRcNN1AqTESxsQmtSmHn6xyYTc4teu4UXaTXQKerDntSM9Iv3HhcDE91nYhCXY+iX0
 qr9NWtOJg57tETCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789067236;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jZl8fsLySrOUhQYMDXjqq52Rxjrdq+id2eWJaQcQK24=;
 b=Vu8ZF6idj6ShFtbdMMnwy9CBISdgmlKnbueUJ1xuPsVDqjGyPXLGfzLazHqig0M160ppRq
 FEDVD79E4u9tajjC74L3bPcCXlh8hGSUu3edg8TVM1OPZ4Gmz6UzSbeEDacCbCynN0h743
 3C5JE+WSw7fNJ3M5TofoF7btb8E5RVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789067236;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jZl8fsLySrOUhQYMDXjqq52Rxjrdq+id2eWJaQcQK24=;
 b=lJMctzgM4m/IBlG4/VtD6XJZlTEpUjjj5VkMgbHNPmsVGQzHUPSI7+4fdM3V7mLVjy1vrV
 XuuLaQeLDn5CP/AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5CF4D13180;
 Thu, 10 Sep 2026 19:07:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Xx8fEuP/omoDcAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 10 Sep 2026 19:07:15 +0000
Date: Thu, 10 Sep 2026 21:07:13 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260910190713.GA255237@pevik>
References: <20260910-fix_documentation-v1-0-44313069bbe8@suse.com>
 <20260910-fix_documentation-v1-1-44313069bbe8@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260910-fix_documentation-v1-1-44313069bbe8@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,sourceware.org:url,musl-libc.org:url,imap1.dmz-prg2.suse.org:helo];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 TO_DN_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/9] doc: Fix examples and generated links
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

Good catches, thanks!

Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
>          'inotify_add_watch': f'{ltp_syscalls_path}/inotify',
>          'inotify_init': f'{ltp_syscalls_path}/inotify',
>          'inotify_rm_watch': f'{ltp_syscalls_path}/inotify',
> @@ -293,7 +293,7 @@ def _generate_tags_table(tags):
>          "linux-git": "https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=",
>          "linux-stable-git": "https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=",
>          "glibc-git": "https://sourceware.org/git/?p=glibc.git;a=commit;h=",
> -        "musl-git": "https://git.musl-libc.org/cgit/musl/commit/src/linux/clone.c?id=",
> +        "musl-git": "https://git.musl-libc.org/cgit/musl/commit/?id=",
Interestingly, the old link also works (cgit v1.2.1 apparently ignores any path
after /commit/ when there is id parameter), but it's of course good to fix it.

>          "CVE": cve_url + 'CVE-',
>      }

> diff --git a/doc/developers/api_shell_tests.rst b/doc/developers/api_shell_tests.rst
> index 937ffee2e..22cab6803 100644
> --- a/doc/developers/api_shell_tests.rst
> +++ b/doc/developers/api_shell_tests.rst
> @@ -41,10 +41,11 @@ when it's empty.
>     #  "needs_root": true,
>     #  "needs_tmpdir": true,
>     #  "needs_kconfigs": ["CONFIG_NUMA=y"],
> -   #  "tags": {
> +   #  "tags": [
>     #   ["linux-git", "432fd03240fa"]
Could you, please, change  before merge this line to:
      #   ["linux-git", "cf01fb9985e8deb25ccf0ea54d916b8871ae0e62"]

(1) longer hash 2) hash which actually exists in kernel tree.)
thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
