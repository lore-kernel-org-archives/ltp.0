Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56525C47258
	for <ltp@archiver.kernel.org>; Wed, 17 Jan 2024 09:37:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 94C893CE2F7
	for <ltp@archiver.kernel.org>; Wed, 17 Jan 2024 10:37:32 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F15E53CC959
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 10:37:17 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EF1E025732B
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 10:37:16 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DFCC521F97;
 Wed, 17 Jan 2024 09:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705484235;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wJICeZykxnTcOHzMJLEBEk85hARJrHlWNjyWiULp9Do=;
 b=JQs55Tdmr1kwTbNpHIAl8cGEAMmdaPikvGw3HDQB4CGxvH88buBITyE3O5BPar+KOk9vv9
 3QeW/Ntvrs5PheFUPdztrWUA7cQPCgHLC9FDVQDLSfc1shxMWsfFvU4mxmybhu+ICRvu7w
 jfUpDX/Fm4/6I6eTpJZeGRQxHyp6o94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705484235;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wJICeZykxnTcOHzMJLEBEk85hARJrHlWNjyWiULp9Do=;
 b=mJYKHLDTpTXEynNYobZ0X80jq/vP034rm7Y5x7XTU2M+XRMho++gDMo4EREGxR6lBzylAv
 YFUXBQA/wSr95qDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705484233;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wJICeZykxnTcOHzMJLEBEk85hARJrHlWNjyWiULp9Do=;
 b=WyDzU5Gs33GVdIQqnRZoNUjaUElj+8leP4hFqWeohCaJc26ebnsMp/ZEMvmGC8umn+YFPJ
 ox7LYSf7lyB/lq7qqJgos6Hk27U6tYizuHEEJHgF1noctXaDqFtcsbiluZ83UBuCFeEVQ4
 DkWVtrj+TzqKDdGn1L0ZR8Xbz6S2JKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705484233;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wJICeZykxnTcOHzMJLEBEk85hARJrHlWNjyWiULp9Do=;
 b=c5+GDegC9CuSA9cbnlVLNs4bc3CV4Az3jrKplTqt4U38WxFhiu44tVPO3l0OdiG3i5v+sW
 Ri6/j5EYOCq4zpCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2E47137EB;
 Wed, 17 Jan 2024 09:37:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6v64Lsmfp2XzHgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 17 Jan 2024 09:37:13 +0000
Date: Wed, 17 Jan 2024 10:37:12 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ice_yangxiao@163.com
Message-ID: <20240117093712.GC2665992@pevik>
References: <20240113144940.133746-1-ice_yangxiao@163.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240113144940.133746-1-ice_yangxiao@163.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.50 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FREEMAIL_ENVRCPT(0.00)[163.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.997];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,fujitsu.com:email];
 FREEMAIL_TO(0.00)[163.com]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] syscalls/preadv: Make make check happy
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

Hi Xiao Yang,

> From: Xiao Yang <yangx.jy@fujitsu.com>

> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  testcases/kernel/syscalls/preadv/preadv.h   | 19 ++------
>  testcases/kernel/syscalls/preadv/preadv01.c | 26 +++++------
>  testcases/kernel/syscalls/preadv/preadv02.c | 50 ++++++++++-----------
>  3 files changed, 42 insertions(+), 53 deletions(-)

> diff --git a/testcases/kernel/syscalls/preadv/preadv.h b/testcases/kernel/syscalls/preadv/preadv.h
> index 73466a9aa..c3e9e5f19 100644
> --- a/testcases/kernel/syscalls/preadv/preadv.h
> +++ b/testcases/kernel/syscalls/preadv/preadv.h
> @@ -1,18 +1,7 @@
> -/*
> -* Copyright (c) 2015 Fujitsu Ltd.
> -* Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> -*
> -* This program is free software; you can redistribute it and/or modify it
> -* under the terms of version 2 of the GNU General Public License as
> -* published by the Free Software Foundation.
> -*
> -* This program is distributed in the hope that it would be useful, but
> -* WITHOUT ANY WARRANTY; without even the implied warranty of
> -* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> -*
> -* You should have received a copy of the GNU General Public License
> -* alone with this program.
> -*/
> +/* SPDX-License-Identifier: GPL-2.0-or-later
So you relicense from GPL v2 only to GPL v2+. You're the author, so you can do
it (normally we shouldn't relicense). But maybe note that at the commit message?
Thanks!

> + * Copyright (c) 2015 Fujitsu Ltd.
nit: maybe add LTP copyright?
* Copyright (c) Linux Test Project, 2016-2017

> + * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> + */

>  #ifndef PREADV_H
>  #define PREADV_H
> diff --git a/testcases/kernel/syscalls/preadv/preadv01.c b/testcases/kernel/syscalls/preadv/preadv01.c
> index 62f9296f2..aba4748a5 100644
> --- a/testcases/kernel/syscalls/preadv/preadv01.c
> +++ b/testcases/kernel/syscalls/preadv/preadv01.c
> @@ -1,17 +1,17 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> -* Copyright (c) 2015 Fujitsu Ltd.
> -* Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> -*/
> + * Copyright (c) 2015 Fujitsu Ltd.
nit: maybe add LTP copyright?
* Copyright (c) Linux Test Project, 2016-2022
> + * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> + */

>  /*
> -* Test Name: preadv01
> -*
> -* Test Description:
> -* Testcase to check the basic functionality of the preadv(2).
> -* Preadv(2) should succeed to read the expected content of data
> -* and after reading the file, the file offset is not changed.
> -*/
> + * Test Name: preadv01

Could you please convert to the docparse? Something like this:

/*\
 * [Description]

 * Testcase to check the basic functionality of the preadv(2).

 * preadv(2) should succeed to read the expected content of data
 * and after reading the file, the file offset is not changed.
 */

> + *
> + * Test Description:
> + * Testcase to check the basic functionality of the preadv(2).
> + * Preadv(2) should succeed to read the expected content of data
> + * and after reading the file, the file offset is not changed.
> + */

>  #define _GNU_SOURCE

> @@ -38,7 +38,7 @@ static struct tcase {
>  	{1, CHUNK*3/2, CHUNK/2, 'b'}
>  };

> -void verify_preadv(unsigned int n)
> +static void verify_preadv(unsigned int n)
>  {
>  	int i;
>  	char *vec;
> @@ -81,7 +81,7 @@ void verify_preadv(unsigned int n)
>  		 "with content '%c' expectedly", tc->size, tc->content);
>  }

> -void setup(void)
> +static void setup(void)
>  {
>  	char buf[CHUNK];

> @@ -94,7 +94,7 @@ void setup(void)
>  	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, sizeof(buf));
>  }

> -void cleanup(void)
> +static void cleanup(void)
>  {
>  	if (fd > 0)
>  		SAFE_CLOSE(fd);
> diff --git a/testcases/kernel/syscalls/preadv/preadv02.c b/testcases/kernel/syscalls/preadv/preadv02.c
> index 500059e42..65d4795d6 100644
> --- a/testcases/kernel/syscalls/preadv/preadv02.c
> +++ b/testcases/kernel/syscalls/preadv/preadv02.c
> @@ -1,32 +1,32 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> -* Copyright (c) 2015-2016 Fujitsu Ltd.
> -* Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> -*/
> + * Copyright (c) 2015-2016 Fujitsu Ltd.
> + * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> + */

>  /*
> + * Test Name: preadv02
nit: remove this ^ (useless)

Again, add docparse + simplify docs a bit:

/*\
 * [Description]
 *
 * Test basic error handling of the preadv(2) syscall.
 *
 * 1) preadv(2) fails if iov_len is invalid (EINVAL)
 * 2) preadv(2) fails if the vector count iovcnt is less than zero (EINVAL).
 * 3) preadv(2) fails if offset is negative (EINVAL).
 * 4) preadv(2) fails when attempts to read into a invalid address (EFAULT).
 * 5) preadv(2) fails if file descriptor is invalid (EBADF).
 * 6) preadv(2) fails if file descriptor is not open for reading (EBADF).
 * 7) preadv(2) fails when fd refers to a directory (EISDIR).
 * 8) preadv(2) fails if fd is associated with a pipe (ESPIPE).
 */

With this, you can add my:
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> + *
> + * Description:
> + * 1) preadv(2) fails if iov_len is invalid.
> + * 2) preadv(2) fails if the vector count iovcnt is less than zero.
> + * 3) preadv(2) fails if offset is negative.
> + * 4) preadv(2) fails when attempts to read into a invalid address.
> + * 5) preadv(2) fails if file descriptor is invalid.
> + * 6) preadv(2) fails if file descriptor is not open for reading.
> + * 7) preadv(2) fails when fd refers to a directory.
> + * 8) preadv(2) fails if fd is associated with a pipe.
> + *
> + * Expected Result:
> + * 1) preadv(2) should return -1 and set errno to EINVAL.
> + * 2) preadv(2) should return -1 and set errno to EINVAL.
> + * 3) preadv(2) should return -1 and set errno to EINVAL.
> + * 4) preadv(2) should return -1 and set errno to EFAULT.
> + * 5) preadv(2) should return -1 and set errno to EBADF.
> + * 6) preadv(2) should return -1 and set errno to EBADF.
> + * 7) preadv(2) should return -1 and set errno to EISDIR.
> + * 8) preadv(2) should return -1 and set errno to ESPIPE.
> + */

>  #define _GNU_SOURCE

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
