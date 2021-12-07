Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD95C433F5
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 14:12:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E86053C5967
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 15:12:28 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E5A33C04BA
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 15:12:19 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DC909600707
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 15:12:18 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 2FDBC1FD56
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 14:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1638886338;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0B0XKulzkvuhzjsIgqAkWCg8qYVCuvvELF2TE05c8W8=;
 b=nKAa4mEakqirNf+dmTAAuH1gDPSCp114uQZ7APBOgAM4pDUOpxaVw3pu365oB6gA9Wn/zA
 vFKwS4SKgOLR/2BbYEw9DrjyEO4mN/vdz0N9cT3cJ8aePc/5qFcUwfZqPs4IRqGU0VbEU9
 UcpvcKA4us/OnIcB64wTOkttvYQ0MgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1638886338;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0B0XKulzkvuhzjsIgqAkWCg8qYVCuvvELF2TE05c8W8=;
 b=nJubJBSYlxr9BnNX+wYCt/N3Haz55YTTp3Zhrf9E1Y6GO/81jHKdT4YM6N1+CkWoUoUyf1
 P08EjKR1a4AdPFDQ==
Received: from g78 (unknown [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id DC451A3B83;
 Tue,  7 Dec 2021 14:12:17 +0000 (UTC)
References: <20211130114527.5942-1-chrubis@suse.cz>
 <20211207125420.32538-1-rpalethorpe@suse.com> <Ya9as97Bo46XvDtO@yuki>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 07 Dec 2021 14:09:56 +0000
In-reply-to: <Ya9as97Bo46XvDtO@yuki>
Message-ID: <87fsr4bj26.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] check: Deprecated API symbols
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
>> The old API represents a big source of complication. It invalidates a
>> lot of assumptions we can make when writing checks specifically for
>> the new API.
>> 
>> Cyril proposed ignoring these symbols altogether in a previous
>> patch. This is a counter proposal to print a warning, but then abandon
>> checking the symbol any further.
>> 
>> The reasoning is that ignoring them altogether might hide errors. Also
>> the existence of the old API may be a surprise to new developers. This
>> change will alert them that a test needs updating and that it is not
>> to be used as a reference.
>> 
>> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>
> Sounds good to me:
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Thanks, pushed!

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
