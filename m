Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498F8C433F5
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 10:45:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E18673C627E
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 11:45:04 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35EF83C4E59
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 11:44:55 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C995A601095
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 11:44:54 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1403B212B5;
 Tue, 30 Nov 2021 10:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638269094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Eo32JDZ2Wvwy4dkvUdYruRe+dmZ2QO2PqUGZZRi+XLc=;
 b=BCoQfbeu0+zp1EwIeFi4avVRiov1QpC6mFlbvsTUWFnVPySmUYjyVhP7FXzKMF+LDJRSR7
 LDLYDfTBcL+W0uSOGY1gB/YcbC5ejhRPoSHOBE4nIjwBZXf4HSKQlqEElIB7jpK/7vAihu
 i8cigIHefff+TySn0EZupq+GK97cMBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638269094;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Eo32JDZ2Wvwy4dkvUdYruRe+dmZ2QO2PqUGZZRi+XLc=;
 b=8CFgS7vwrC8v+mnmTFl3vt7LUtaG8OTrK4LtmP3h72CLnDVQO6qDB43Nz5ttCQNKNv3g7F
 bNR3CakXA2VByYDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F3A9813C44;
 Tue, 30 Nov 2021 10:44:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7xFCOqUApmGmPgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 30 Nov 2021 10:44:53 +0000
Date: Tue, 30 Nov 2021 11:46:05 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <YaYA7T+HrErmmJMf@yuki>
References: <20211130100934.1674-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211130100934.1674-1-andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Add common.h utilities for aiodio tests
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
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Common utilities for aiodio tests.
> + */

There is no point in using the docparse comments in headers, these are
only parsed in tests.

Also the header should include guards here:

#ifndef AIODIO_COMMON_H__
#define AIODIO_COMMON_H__

> +#include <stdlib.h>
> +#include "tst_test.h"
> +
> +static char *check_zero(char *buf, int size)
> +{
> +	char *p;
> +
> +	p = buf;
> +
> +	while (size > 0) {
> +		if (*buf != 0) {
> +			tst_res(TINFO,
> +				"non zero buffer at buf[%lu] => 0x%02x,%02x,%02x,%02x",
> +				buf - p, (unsigned int)buf[0],
> +				size > 1 ? (unsigned int)buf[1] : 0,
> +				size > 2 ? (unsigned int)buf[2] : 0,
> +				size > 3 ? (unsigned int)buf[3] : 0);
> +			tst_res(TINFO, "buf %p, p %p", buf, p);
> +			return buf;
> +		}
> +		buf++;
> +		size--;
> +	}
> +
> +	return 0;
> +}
> +
> +static void io_append(const char *path, char pattern, int flags, size_t bs, size_t bcount)
> +{
> +	int fd;
> +	size_t i;
> +	char *bufptr;
> +
> +	bufptr = SAFE_MEMALIGN(getpagesize(), bs);
> +	memset(bufptr, pattern, bs);
> +
> +	fd = SAFE_OPEN(path, flags, 0666);
> +
> +	for (i = 0; i < bcount; i++)
> +		SAFE_WRITE(1, fd, bufptr, bs);
> +
> +	free(bufptr);
> +	SAFE_CLOSE(fd);
> +}

And the guards should end here with:

#endif /* AIODIO_COMMON_H__ */

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
