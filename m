Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC7ECAC5A7
	for <ltp@archiver.kernel.org>; Mon, 22 Sep 2025 07:48:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E69B33CDE2F
	for <ltp@archiver.kernel.org>; Mon, 22 Sep 2025 09:48:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8FC0C3C02B1
 for <ltp@lists.linux.it>; Mon, 22 Sep 2025 09:48:14 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E9B32600840
 for <ltp@lists.linux.it>; Mon, 22 Sep 2025 09:48:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 879141F8B0;
 Mon, 22 Sep 2025 07:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758527292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=caToymICFvB/anM3xw0hU87zVw+AlAElEVUxP0SIMq4=;
 b=Lyyjv7IjXomMIkT7gnlTCYyz0aNC5HmYY6K463jun5hh4oi1mcvh2cffoFt3Kruk0b8fb6
 4kbNkx/mTnU6vGVaDcINe99HLgyJ02PBieg/VUcgjBtScoWpGgRHxT/Ag5N4fNfDEvrsXS
 oedn945XU/Gjtkzupy5j8QrKhvTvR2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758527292;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=caToymICFvB/anM3xw0hU87zVw+AlAElEVUxP0SIMq4=;
 b=QP7HNVyVW+mCvLOSavQGoGu3EAvHWsvH+/aepUD0hukNwWMDXDwfRELTlLd/ri6Y2EDi4C
 DySfACR6CWHDSgBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758527292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=caToymICFvB/anM3xw0hU87zVw+AlAElEVUxP0SIMq4=;
 b=Lyyjv7IjXomMIkT7gnlTCYyz0aNC5HmYY6K463jun5hh4oi1mcvh2cffoFt3Kruk0b8fb6
 4kbNkx/mTnU6vGVaDcINe99HLgyJ02PBieg/VUcgjBtScoWpGgRHxT/Ag5N4fNfDEvrsXS
 oedn945XU/Gjtkzupy5j8QrKhvTvR2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758527292;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=caToymICFvB/anM3xw0hU87zVw+AlAElEVUxP0SIMq4=;
 b=QP7HNVyVW+mCvLOSavQGoGu3EAvHWsvH+/aepUD0hukNwWMDXDwfRELTlLd/ri6Y2EDi4C
 DySfACR6CWHDSgBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 77EB31388C;
 Mon, 22 Sep 2025 07:48:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mo7tGzz/0GgMBQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 22 Sep 2025 07:48:12 +0000
Date: Mon, 22 Sep 2025 09:48:56 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Mark Wielaard <mark@klomp.org>
Message-ID: <aND_aLgsukouVATL@yuki.lan>
References: <20250918152640.1146279-1-mark@klomp.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250918152640.1146279-1-mark@klomp.org>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_THREE(0.00)[3]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mmap04: Make sure the scanf address format is at
 least 8 hex chars
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
Cc: Martin Cermak <mcermak@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> The addresses in /proc/self/maps are at least 8 hex chars. Zeros are
> added to the front of the address when shorted (both on 32bit and
> 64bit systems.
> 
> Under valgrind the mmaps used in kernel/syscalls/mmap/mmap04.c come
> out very low in the address space and might be shorter than 8 hex
> chars. This causes the scanf to fail:
> mmap04.c:62: TBROK: Expected 1 conversions got 0 FILE '/proc/self/maps'

I guess I do not understand the problem here. The PRIxPTR translates to
"x", "lx", or "llx" depending on architecture and as far as I can tell
the %x modifier handles leading zeroes just fine.

> Fix this by using "%08" PRIxPTR when creating the fmt used.

Unfortunately this is not universally true. For example the vsyscall
page is mapped at very high address on x86_64:

ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0                  [vsyscall]

> Signed-off-by: Mark Wielaard <mark@klomp.org>
> ---
>  testcases/kernel/syscalls/mmap/mmap04.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/mmap/mmap04.c b/testcases/kernel/syscalls/mmap/mmap04.c
> index 4a050b7b50da..5b28180df29b 100644
> --- a/testcases/kernel/syscalls/mmap/mmap04.c
> +++ b/testcases/kernel/syscalls/mmap/mmap04.c
> @@ -58,7 +58,8 @@ static void run(unsigned int i)
>  
>  	addr2 = SAFE_MMAP(addr1 + pagesize, pagesize, tc->prot, tc->flags | MAP_FIXED, -1, 0);
>  
> -	sprintf(fmt, "%" PRIxPTR "-%%*x %%s", (uintptr_t)addr2);
> +	/* A /proc/self/maps address is at least 8 hex (left zero padded) */
> +	sprintf(fmt, "%08" PRIxPTR "-%%*x %%s", (uintptr_t)addr2);
>  	SAFE_FILE_LINES_SCANF("/proc/self/maps", fmt, perms);
>  
>  	if (!strcmp(perms, tc->exp_perms)) {
> -- 
> 2.51.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
