Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6032EC433EF
	for <ltp@archiver.kernel.org>; Mon, 25 Apr 2022 11:23:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 48FF03C4D6B
	for <ltp@archiver.kernel.org>; Mon, 25 Apr 2022 13:23:45 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 23F883C12C4
 for <ltp@lists.linux.it>; Mon, 25 Apr 2022 13:23:34 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9FD49200342
 for <ltp@lists.linux.it>; Mon, 25 Apr 2022 13:23:33 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B156A1F388;
 Mon, 25 Apr 2022 11:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1650885812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R5wtBbOaRrRxjWFLmF940jLqTKZrgZOqjXnEtU3LFA0=;
 b=X6iFmGF4Pi2JmbuCk6HjgBIiaeimBGvznXZh6ee7OVI9SkglfE+HcygRl3TIwKyVLF/hdn
 gJUedOTNzVvNo63gUYNQA0d+QlbelqqOX877A48+/tIaeLjv0BMEcsJOvb1qRhrh1EeX1x
 nSLIpXNWLUWmFSZyjvFgBxBXR1Mvajc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1650885812;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R5wtBbOaRrRxjWFLmF940jLqTKZrgZOqjXnEtU3LFA0=;
 b=fCXkWOEbVyfh8Av9yZ72/OGvJU331/yKeXqwKO6yor8L+Pwr3pybw7z40anJEcAvfXtWnN
 m6bUF7vQi5DT01CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C9D913AE1;
 Mon, 25 Apr 2022 11:23:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Z6jeJLSEZmJrTgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 25 Apr 2022 11:23:32 +0000
Date: Mon, 25 Apr 2022 13:23:06 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YmaEmnRY9CNL9+Bu@rei>
References: <20220425092118.21619-1-rpalethorpe@suse.com>
 <YmZrVzxghAnmxIud@rei> <YmaBJM8piHx4Juay@pevik>
 <YmaBfMmDa4O/Lc2N@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YmaBfMmDa4O/Lc2N@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sighold02: Fix muslc builds by removing __SIGRTMIN
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Ah, looking at the code "if (sig >= __SIGRTMIN && sig < SIGRTMIN)",
> we need both underscore and non-underscore.

This is code to actually skip signals used internally by libc, so
anything between 32 and SIGRTMIN. It's pretty safe to hardcode the first
value to 32 since that is the number of signals allocated by kernel
which is not going to change.

I guess that we can add something as SIGRTMIN_KERN or SIGRTMIN_BASE and
define it to 32 in some LTP header instead of hardcoding 32 into
testcases, which would be way better than misusing glibc internal
__SIGRTMIN.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
