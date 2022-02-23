Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F6C1C433F5
	for <ltp@archiver.kernel.org>; Wed, 23 Feb 2022 13:26:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 115CE3C97E3
	for <ltp@archiver.kernel.org>; Wed, 23 Feb 2022 14:26:28 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA7353C2FBE
 for <ltp@lists.linux.it>; Wed, 23 Feb 2022 14:26:17 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1CDBE201190
 for <ltp@lists.linux.it>; Wed, 23 Feb 2022 14:26:16 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 258DD1F37D;
 Wed, 23 Feb 2022 13:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645622776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m5XagV1R4ky1VLKvgdvm0nV1I7T77KGQGp8CFNAXD2I=;
 b=D0qy5ghpSIhgsqKBDr0mpSAcsXUp789F4sjbCMsNZXv4VWv/mpHvSoy5IXsGQUDoWuN9ua
 939E8HOTlL8WbVVtNeT0CBhTg7NE7SQKiSN7VOgqqqjcWzkpw6+yMEYZKrmPh/qEK89I+d
 h0NxbHJxCNWDnVgpzoMCbyigXFupLfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645622776;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m5XagV1R4ky1VLKvgdvm0nV1I7T77KGQGp8CFNAXD2I=;
 b=8rEteKVRgg4fFg2F35/ur3YEV4Dy1SyOVCfVE94XuUDVXPeFvcHG8d6AiEVAZXq3vvGDaw
 pccEV7hIasoNDBCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0F9BF13D70;
 Wed, 23 Feb 2022 13:26:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Vd3HAvg1FmItKQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 23 Feb 2022 13:26:16 +0000
Date: Wed, 23 Feb 2022 14:28:29 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YhY2fZlfhv++XkMh@yuki>
References: <1645519272-2733-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1645519272-2733-3-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1645519272-2733-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/7] lib/tst_safe_pidfd: Add SAFE_PIDFD_OPEN
 macro
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
> + * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
> + * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
> + */
> +
> +#ifndef TST_SAFE_PIDFD_H__
> +#define TST_SAFE_PIDFD_H__
> +
> +#include <unistd.h>
> +#include "lapi/pidfd.h"
> +
> +int safe_pidfd_open(const char *file, const int lineno, pid_t pid,
> +		    unsigned int flags);
> +
> +#define SAFE_PIDFD_OPEN(pid, flags) \
> +	safe_pidfd_open(__FILE__, __LINE__, (pid), (flags))

Is there a reason why we start a new header instead of adding this into
the tst_safe_macros.h?


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
