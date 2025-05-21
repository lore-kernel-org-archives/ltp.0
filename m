Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B55C54E65
	for <ltp@archiver.kernel.org>; Wed, 21 May 2025 09:38:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9607C3CC7C3
	for <ltp@archiver.kernel.org>; Wed, 21 May 2025 11:38:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F278F3CC7A7
 for <ltp@lists.linux.it>; Wed, 21 May 2025 11:37:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F3ABA602992
 for <ltp@lists.linux.it>; Wed, 21 May 2025 11:37:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A67EA2292A;
 Wed, 21 May 2025 09:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747820264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+Xj2jCFMdZ6XEj9QLeue/0HHyiRWfmlwhUaFt26veTg=;
 b=bV61ZYJYO/9O98ZVKid/yHDwu0U+o6aWH2BwkRbx2rXt9bX0MGng+BMiWn/vnUue6fOy3q
 Wo+MntFNYa5or72tgYsoV3fac+uOi5OcnjmizldyG/wQ208EvHVTAWimB9J3XIIUbCPq0t
 3d95dz4C5ukbDwfTrer+m/fn+Yftz6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747820264;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+Xj2jCFMdZ6XEj9QLeue/0HHyiRWfmlwhUaFt26veTg=;
 b=VRY3k92n1xLWOHF8KprnflA1tfZ6fEjVoCUozehmRJmKf4J60iGrJJY1eLM6NIVkteYwcY
 VXwWiSBmsW8h5iBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747820264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+Xj2jCFMdZ6XEj9QLeue/0HHyiRWfmlwhUaFt26veTg=;
 b=bV61ZYJYO/9O98ZVKid/yHDwu0U+o6aWH2BwkRbx2rXt9bX0MGng+BMiWn/vnUue6fOy3q
 Wo+MntFNYa5or72tgYsoV3fac+uOi5OcnjmizldyG/wQ208EvHVTAWimB9J3XIIUbCPq0t
 3d95dz4C5ukbDwfTrer+m/fn+Yftz6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747820264;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+Xj2jCFMdZ6XEj9QLeue/0HHyiRWfmlwhUaFt26veTg=;
 b=VRY3k92n1xLWOHF8KprnflA1tfZ6fEjVoCUozehmRJmKf4J60iGrJJY1eLM6NIVkteYwcY
 VXwWiSBmsW8h5iBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B88C13888;
 Wed, 21 May 2025 09:37:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Mt1ZJeieLWg9QgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 21 May 2025 09:37:44 +0000
Date: Wed, 21 May 2025 11:37:31 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Polensky <japo@linux.ibm.com>
Message-ID: <aC2e24S2FzFRM5-N@rei>
References: <20250513165640.185122-1-japo@linux.ibm.com>
 <20250513165640.185122-2-japo@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250513165640.185122-2-japo@linux.ibm.com>
X-Spamd-Result: default: False [-0.80 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH v1 1/2] safe_macros.c: Fix missing ro flag for
 FUSE NTFS mounts
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
> diff --git a/lib/safe_macros.c b/lib/safe_macros.c
> index 6946cc5bcb94..1270b17af8f4 100644
> --- a/lib/safe_macros.c
> +++ b/lib/safe_macros.c
> @@ -942,10 +942,15 @@ int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
>  	 */
>  	if (possibly_fuse(filesystemtype)) {
>  		char buf[1024];
> +		const char* mount_fmt;
> 
>  		tst_resm_(file, lineno, TINFO, "Trying FUSE...");
> -		snprintf(buf, sizeof(buf), "mount.%s '%s' '%s'",
> -			filesystemtype, source, target);
> +		if (!strcmp(filesystemtype, "ntfs") && mountflags & MS_RDONLY)

Do we need to limit this to "ntfs"? I suppose that for other FUSE
filesystems would have the same problem, e.g. exfat.

Other than this the patch looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
