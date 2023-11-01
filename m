Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7ECC4332F
	for <ltp@archiver.kernel.org>; Wed,  1 Nov 2023 10:34:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E059D3CD4F7
	for <ltp@archiver.kernel.org>; Wed,  1 Nov 2023 11:34:33 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 378BC3C9916
 for <ltp@lists.linux.it>; Wed,  1 Nov 2023 11:34:24 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4827A201107
 for <ltp@lists.linux.it>; Wed,  1 Nov 2023 11:34:22 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4A7951F74D;
 Wed,  1 Nov 2023 10:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698834862;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uMyZv4ONzf1TR+F2MbHV05JSbYp7aZqBVRF2L15S3Uo=;
 b=vaDOaPy6MnQV0IiqhZTrpCKNe3SZlMo7cP9AzzHCtV1r241jwvMNXN5pNbOjPOowjyd7jV
 otjZxhiAfZvu8UF4kSX6T/Zjvm4WhdN76SN/rhKwSW0PA+cWkfcnz2bYlt/OM15HNBcXRZ
 ky6SDOUmnjPooOEyTtO3IMPhJ32HE50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698834862;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uMyZv4ONzf1TR+F2MbHV05JSbYp7aZqBVRF2L15S3Uo=;
 b=UDOZF51oxpadkmdITzJIZ+0s6a4J6K1jAsSnGHzdoWpgcRvJ4eBsp5fCieOsNUL2zUZq0+
 IWdJCQU0DvWY64Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A8251348D;
 Wed,  1 Nov 2023 10:34:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AfQtCa4pQmWmIwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 01 Nov 2023 10:34:22 +0000
Date: Wed, 1 Nov 2023 11:34:20 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20231101103420.GC884786@pevik>
References: <20231030110107.4528-1-andrea.cervesato@suse.de>
 <20231030110107.4528-2-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231030110107.4528-2-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] Rewrite fsx-linux test
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
> +++ b/testcases/kernel/fs/fsx-linux/fsx-linux.c
> @@ -1,1353 +1,392 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (C) 1991, NeXT Computer, Inc.  All Rights Reserverd.
> - * Copyright (c) 1998-2001 Apple Computer, Inc. All rights reserved.
> - *
> - * @APPLE_LICENSE_HEADER_START@
> - *
> - * The contents of this file constitute Original Code as defined in and
> - * are subject to the Apple Public Source License Version 1.1 (the
> - * "License").  You may not use this file except in compliance with the
> - * License.  Please obtain a copy of the License at
> - * http://www.apple.com/publicsource and read it before using this file.

I wonder if we can switch from APSL-1.1 to GPL-2.0-or-later
https://spdx.org/licenses/APSL-1.1.html

"This is a complete rewrite of the old test." may justify that.

> - *
> - * This Original Code and all software distributed under the License are
> - * distributed on an "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, EITHER
> - * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
> - * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE OR NON-INFRINGEMENT.  Please see the
> - * License for the specific language governing rights and limitations
> - * under the License.
> - *
> - * @APPLE_LICENSE_HEADER_END@
...

> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#if defined(_UWIN) || defined(__linux__)

I would also consider moving (and rename) the file to testcases/kernel/fs/fsx/fsx.c.
We don't care about _UWIN any more.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
