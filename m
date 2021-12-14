Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF0BC433EF
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 11:08:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2DC063C8BC0
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 12:08:55 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B95C3C8B02
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 12:08:46 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C651C200FE0
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 12:08:45 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CEF5521114;
 Tue, 14 Dec 2021 11:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639480124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y+mC9BBQGKYDLSKDQVqREMSsiFjtwQWoWnQ6Oi8H+k0=;
 b=M2P4YtUcG7Yf1okOKoMceVlwi3LqbPtSDFHDC9Eb7Lu3GXxWdOa5aqorOHaFVvIpJ6elus
 B+tB6DP4jlKVOw9y5opwgr+P+SPxxfiZtZ+a+99Rn9AE9FcwuDhTk//BSUoetDpKtBkEjk
 ZTGC8pllmiQC0lP5Az9f05oXGPLYyU4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639480124;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y+mC9BBQGKYDLSKDQVqREMSsiFjtwQWoWnQ6Oi8H+k0=;
 b=4wWn+ZpF107x/6gXCWSj9aC+s+Cj5BPFrjaMa7XQeIjDNkCWUTUT8WlRPNxjUcUpYCsd7O
 zU9pPOn1PKYookBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B132113CF5;
 Tue, 14 Dec 2021 11:08:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IxROKjx7uGHmYQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 14 Dec 2021 11:08:44 +0000
Date: Tue, 14 Dec 2021 12:10:09 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <Ybh7kab6r/+WJgx+@yuki>
References: <20211214090648.14292-1-rpalethorpe@suse.com>
 <20211214090648.14292-4-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211214090648.14292-4-rpalethorpe@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/4] memcontrol01: Import first memcg kselftest
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
> +// SPDX-License-Identifier: GPL-2.0
> +/*\
> + *
> + * [Description]
> + *
> + * Conversion of first kselftest in cgroup/test_memcontrol.c.

Can we please have a better description of the test here?

> + */
> +#define _GNU_SOURCE
> +
> +#include <stdio.h>
> +
> +#include "tst_test.h"
> +#include "tst_cgroup.h"
> +
> +static const struct tst_cgroup_group *cg_test;
> +static struct tst_cgroup_group *parent, *child;
> +static struct tst_cgroup_group *parent2, *child2;
> +
> +/*
> + * This test creates two nested cgroups with and without enabling
> + * the memory controller.

I guess that this part of the comment should really be in the
description right?


Other than that the test is really straightforward:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
