Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB03C433FE
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 22:08:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D29B33CAF0D
	for <ltp@archiver.kernel.org>; Fri, 14 Oct 2022 00:08:14 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 04C8B3C2E4F
 for <ltp@lists.linux.it>; Fri, 14 Oct 2022 00:08:03 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4AFC91A0049E
 for <ltp@lists.linux.it>; Fri, 14 Oct 2022 00:08:02 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 13BDE21B60;
 Thu, 13 Oct 2022 22:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665698882;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S0vSmMOIK+R1GWDc6LJ/bfg2NINxLU3WRHuF0+fMcS4=;
 b=r1ig58YQotm47mkSBt4dlOlU5JmY2M+gIx/JNcxHh1WtZvexhatCdtUGQ3R3wxB4CK/J8f
 igZLTmjPTWNRshwGZsmrvzdbsuaABw1CwQm1uQqAjGdAtZUN0GLHAqJU4aGw9z0oYKYPUS
 IS5yLHJlIdD2UVQoxYxf9PsbbUwbhFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665698882;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S0vSmMOIK+R1GWDc6LJ/bfg2NINxLU3WRHuF0+fMcS4=;
 b=o7ntdyZyxqGvgotxRgAzQgZQNEKBKAwanoY5Ag2ainuIQal/eL0AwiAwIl2bH1ifWANc8g
 2eiFKAPf60cornCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DA42D139F3;
 Thu, 13 Oct 2022 22:08:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qHF9MkGMSGP9XAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 13 Oct 2022 22:08:01 +0000
Date: Fri, 14 Oct 2022 00:08:00 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Y0iMQEXsQbkNMwWf@pevik>
References: <20221013154935.20461-1-mdoucha@suse.cz>
 <20221013154935.20461-3-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221013154935.20461-3-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/4] Move fanotify fallback constants and structs
 to LAPI header
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

Hi Martin,

although it will be used only by tests in testcases/kernel/syscalls/fanotify/,
it's cleaner to follow LTP approach.

Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

...
> --- /dev/null
> +++ b/include/lapi/fanotify.h
> @@ -0,0 +1,210 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (c) 2012-2020 Linux Test Project.  All Rights Reserved.
FAN_FS_ERROR has been added in 3db153665 ("syscalls/fanotify22: Introduce FAN_FS_ERROR test")
which is 2022. Can be changed before merge.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
