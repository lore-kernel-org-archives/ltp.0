Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3028C433F5
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 11:25:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A010B3C8D12
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 12:25:57 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 67CFD3C7621
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 12:25:48 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A042220101B
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 12:25:47 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id D01732112A
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 11:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1639481146;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6QOIi4CL0hYohfhbmGzjiYnKKOA6hmTk741/F/4D0z0=;
 b=u0unK6HmhfXXfOxC6brTJdNRI7lqgo/BRH0j/uBKQOh99eaVai2Sc9frMGtJ0XOHHfVjZY
 kkCGw/3cgFmUjBrWsIzEkZLua6WpRtKsX+Gta9KK9necPq5ru53E3ZWF+kompEAavvhXoH
 7IRgxHSJaosH2f4BtQXxrGaPM5sF8uQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1639481146;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6QOIi4CL0hYohfhbmGzjiYnKKOA6hmTk741/F/4D0z0=;
 b=JKpYLEBe/Yw42G+UaMiLgb01mwEiSeHd+qmrmPTmas3nmeltItTq2Tl/gyOfI5EigHhNry
 csMeTaZt0undHOBg==
Received: from g78 (unknown [10.163.24.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 9E2AAA3B84;
 Tue, 14 Dec 2021 11:25:46 +0000 (UTC)
References: <20211214090648.14292-1-rpalethorpe@suse.com>
 <20211214090648.14292-5-rpalethorpe@suse.com> <Ybh8vUPDA8a0oBOC@yuki>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 Dec 2021 11:22:30 +0000
In-reply-to: <Ybh8vUPDA8a0oBOC@yuki>
Message-ID: <87czlza0n9.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/4] scripts/coccinelle: Helper for converting
 CGroup selftests
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> +@@
>> +expression cg;
>> +@@
>> +
>> +... when != TST_CGROUP_VER(...)
>> +
>> +- SAFE_CGROUP_PRINT(cg, "cgroup.subtree_control", "+memory");
>> ++ if (TST_CGROUP_VER(cg, "memory") != TST_CGROUP_V1)
>> ++    SAFE_CGROUP_PRINT(cg, "cgroup.subtree_control", "+memory");
>
> I guess that here we operat on already partially converted code right?

Correct, in general cg_write is converted to safe_cgroup_print. Then we
have this special rule for subtree_control to introduce the version
check (if there isn't one already present).

>
>
> Other than this the rest is really straightforward:
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
