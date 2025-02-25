Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165E3C021B2
	for <ltp@archiver.kernel.org>; Tue, 25 Feb 2025 15:03:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DB033C9C61
	for <ltp@archiver.kernel.org>; Tue, 25 Feb 2025 16:03:09 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE3583C98CB
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 16:02:50 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0E408623AB6
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 16:02:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C8C7221165;
 Tue, 25 Feb 2025 15:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740495768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=39XtltMgl80Ru9wfbSLuWelXixb4cE1xaEc8OGGejuI=;
 b=LJj/dQ2zpx3CJp9k/weXxWIK5dD1niAnjDr6fJOVIVNqT0sCKmeEPV70JwfvLbylGvHutx
 fxklWysPn4Y+2XmP3Q/bpjVB65RXnqiOxatFGNzkcurKNymYkgbjHz4b4+3rspZ4b6i4ie
 +IZUPL/sljcoyjI00yKoNbUYzjPOfP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740495768;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=39XtltMgl80Ru9wfbSLuWelXixb4cE1xaEc8OGGejuI=;
 b=9zAa7gV8bqz94MWV9fAiXZWhptkMK9ERJeS0j6tlNDV4RaNIh6SzjyC/Y3qI0AS/tH4ocZ
 pzyedCug+sIJWwCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740495768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=39XtltMgl80Ru9wfbSLuWelXixb4cE1xaEc8OGGejuI=;
 b=LJj/dQ2zpx3CJp9k/weXxWIK5dD1niAnjDr6fJOVIVNqT0sCKmeEPV70JwfvLbylGvHutx
 fxklWysPn4Y+2XmP3Q/bpjVB65RXnqiOxatFGNzkcurKNymYkgbjHz4b4+3rspZ4b6i4ie
 +IZUPL/sljcoyjI00yKoNbUYzjPOfP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740495768;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=39XtltMgl80Ru9wfbSLuWelXixb4cE1xaEc8OGGejuI=;
 b=9zAa7gV8bqz94MWV9fAiXZWhptkMK9ERJeS0j6tlNDV4RaNIh6SzjyC/Y3qI0AS/tH4ocZ
 pzyedCug+sIJWwCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B65CA13332;
 Tue, 25 Feb 2025 15:02:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MOKyK5jbvWctJAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 25 Feb 2025 15:02:48 +0000
Date: Tue, 25 Feb 2025 16:02:56 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Z73boLXE2usA_-5S@yuki.lan>
References: <20250210-mmap_suite_refactoring-v2-0-6edea3a4363a@suse.com>
 <20250210-mmap_suite_refactoring-v2-4-6edea3a4363a@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250210-mmap_suite_refactoring-v2-4-6edea3a4363a@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/8] Cleanup mmap17 test
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
Cc: rbm@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> -/*
> - * Test mmap with MAP_FIXED_NOREPLACE flag
> +/*\
> + * [Description]

This shouldn't be there I now.

> - * We are testing the MAP_FIXED_NOREPLACE flag of mmap() syscall. To check
> + * Verify MAP_FIXED_NOREPLACE flag for the mmap() syscall and check
>   * if an attempt to mmap at an exisiting mapping fails with EEXIST.

This should be really just:

Verify that MAP_FIXED_NOREPLACE does not replace existing mapping and
fails with EEXIST.

> + * [Algorithm]
> + *
>   * The code allocates a free address by passing NULL to first mmap call
> - * Then tries to mmap with the same address using MAP_FIXED_NOREPLACE flag
> + * then tries to mmap with the same address using MAP_FIXED_NOREPLACE flag
>   * and the mapping fails as expected.

Do we really need that part? I think that the test itself is so simple
that the single sentence above describes it completely.

>   */
>  
> -#include <stdio.h>
> -#include <fcntl.h>
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <unistd.h>
> -#include <errno.h>
> -#include <string.h>
> -#include <stdlib.h>
> -#include "lapi/mmap.h"
>  #include "tst_test.h"
>  
>  static int fd_file1;

And since you are touching the test we do not free the mapped address in
the case of -i parameter. So need to move the SAFE_MUNMAP() to the test
setup().

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
