Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F000910ED659
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 11:07:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B74A3CFFAB
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 12:07:09 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7977A3C3212
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 12:06:50 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E9F9A601D77
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 12:06:46 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DABC54D310;
 Fri, 27 Mar 2026 11:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774609606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=66k4OmOVeFjzr4zoRLFvGUuLKUXso3rMrjbP1JD15bA=;
 b=LmxC7jhi2C+hp7+1i4/WJxzAxnDgDwfLo9ObJ/iGUcEhU3TEbWhGdf9yQebd4F74MyvK2B
 2jqbZg5a7yz6+YSMMAgl0MFc5l1GCE20ZB+hJjk89QApQTHJS5V/pM6eMpqJuVEX9pUG+W
 /dGY0AohaG4tEn5MBG7+MPtGhodM/CQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774609606;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=66k4OmOVeFjzr4zoRLFvGUuLKUXso3rMrjbP1JD15bA=;
 b=c3WtJKLGFNTjwzSDHsNqa1I+z4uwEuZW8syUM5G1hHWIOD3wrsscuARfbJHTXq0u0ZEUPl
 sSI7yXQgYiW5lmCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774609605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=66k4OmOVeFjzr4zoRLFvGUuLKUXso3rMrjbP1JD15bA=;
 b=B1rvsNpkqwI7KQ36yab0UPcU97IcCi/lpiG5uvYPuGlgebWZULJa7dXExbMrE7h4vdMRcL
 eW8jeHoaDeClui4/m0ibjf2uEcrbVEEk8+unkPM3lqjx5pFuN3L+DJeiCzchyt+SiugOci
 vTqiiuIrWU8AClYK5/YRZpAASOCUssA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774609605;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=66k4OmOVeFjzr4zoRLFvGUuLKUXso3rMrjbP1JD15bA=;
 b=yl1mGsejMcrVJAm89uTQ+5L7phlK2q0BR1l37mIsdz0936S58Gz835bOEtYAGeVExaojpm
 kzT+x0lxniuwZZDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C81064A0A2;
 Fri, 27 Mar 2026 11:06:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TZAdL8Vkxmm+AwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 27 Mar 2026 11:06:45 +0000
Date: Fri, 27 Mar 2026 12:06:47 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <acZkx8nI77zUx3go@yuki.lan>
References: <20260326144006.3035-1-chrubis@suse.cz>
 <acYrmGE0yu07rJsn@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <acYrmGE0yu07rJsn@redhat.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_kconfig: Add runtime checks
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
> It would be great to have a description for the feature:
> 
> Something maybe like:
> 
>  "Currently, LTP Kconfig parsing logic only checks if a feature was
>   enabled during kernel compilation (e.g., CONFIG_USER_NS=y). However,
>   some kernel features can be compiled in but disabled at runtime via
>   kernel command-line parameter or sysctls. When this happens, tests
>   relying on these Kconfig variables attempt to run and fail, rather
>   than being gracefully skipped.
>   
>   This patch introduces a runtime check mechanism for Kconfig variables.
>   When a monitored CONFIG_* variable is parsed as 'y' or 'm', the framework
>   now executes an associated runtime check function. If the runtime check
>   fails, the framework logs an info message and internally overrides the
>   variable's state to 'n'. This allows the existing LTP dependency logic
>   to properly skip tests that require the disabled feature."

Ah, sorry I've fixed the code but kept the description single line, I
will fix that.

> Also, add test_kconfig04.c in newlib_tests/ to verify this works?

I've added a new config variable to newlib_tests/test_kconfig.c (it does
not show in the output unless you boot with namespaces disabled).

If you do and run it:

$ ./test_kconfig
tst_kconfig.c:90: TINFO: Parsing kernel config '/lib/modules/6.16.0/build/.config'
tst_kconfig.c:138: TINFO: CONFIG_USER_NS=y present but disabled at runtime
...
tst_kconfig.c:566: TINFO: Constraint 'CONFIG_USER_NS' not satisfied!
tst_kconfig.c:512: TINFO: Variables:
tst_kconfig.c:530: TINFO:  CONFIG_USER_NS=n
tst_test.c:1461: TCONF: Aborting due to unsuitable kernel config, see above!


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
