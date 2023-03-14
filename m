Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3FBC6FD1C
	for <ltp@archiver.kernel.org>; Tue, 14 Mar 2023 13:21:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BDB813CD50B
	for <ltp@archiver.kernel.org>; Tue, 14 Mar 2023 14:21:06 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D116A3CAD42
 for <ltp@lists.linux.it>; Tue, 14 Mar 2023 14:20:57 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 610561400C5F
 for <ltp@lists.linux.it>; Tue, 14 Mar 2023 14:20:57 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id DA27321CB2;
 Tue, 14 Mar 2023 13:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1678800056;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VmHqn6tEhKy71zw4KBKhzRI25YhkUNcRIbvsmVA/EHU=;
 b=p0lxsqo1yc5yZWyfJ34ZwbADLJAgkTAqMOTJYVOXw1E5apWcHMYykib2EzqyagQZ9ZS1h1
 GBrnldCpNzDA3SnoMUGjIyBNHCWqTj/fYX1d0RfGrnWVR5EdCasT3Ud9E1Y4BkEQ4VWj3H
 em58JVZi0MF7t2ro2FXIWBYO3Pkjrws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1678800056;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VmHqn6tEhKy71zw4KBKhzRI25YhkUNcRIbvsmVA/EHU=;
 b=mPAtTITQer9lZS4VQIq80+T/7hDJzOrsdiztyfDxFo0y74anTJgtboDMKZFtBf7/pVikJl
 K7Ztx7hVKEsZceBw==
Received: from g78 (rpalethorpe.udp.ovpn1.nue.suse.de [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 0DF842C141;
 Tue, 14 Mar 2023 13:20:55 +0000 (UTC)
References: <20230311023343.25177-1-wegao@suse.com>
 <20230312004420.16457-1-wegao@suse.com> <ZA7qq15aeKS+ZeJR@yuki>
 <20230313122100.GA12608@localhost> <ZA8Y+O7QFfVB0/62@yuki>
 <20230313134624.GA9783@localhost> <ZA8t7hVYRmF+I9k0@yuki>
 <20230314053151.GA22202@localhost> <ZBAtCbeSVH0/l137@rei>
 <87pm9b67gc.fsf@suse.de> <ZBA7H+TYMN9OBzjm@yuki>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 Mar 2023 13:10:43 +0000
Organization: Linux Private Site
In-reply-to: <ZBA7H+TYMN9OBzjm@yuki>
Message-ID: <87h6un5v0t.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] madvise11.c:Check loadable module before rmmod
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
>> > Sounds like a bug that shoudl be fixed, we probably need to create two
>> > search strings, one with dashes and one with underscores and try to
>> > strstr() both.
>> 
>> Could we not check kconfig for builtin modules?
>
> Are we 100% sure that the module-name always translates to
> CONFIG_MODULE_NAME?

I'm fairly sure this is not the case because I have spent quite some
time trying to match modules with their configuration parameters.

I had not considered trying that, but specifying the module names and
config parameters separately.

>
> I would say that we are a bit safer if we use the same files the rest of
> the tooling uses e.g. depmod, dracut etc.

I suppose that copying the logic from depmod would be safest.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
