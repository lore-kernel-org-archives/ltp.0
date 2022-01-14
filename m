Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AE1C433F5
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 14:16:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6575E3C9545
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 15:16:50 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3A5733C58A8
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 15:16:39 +0100 (CET)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 34131100138E
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 15:16:38 +0100 (CET)
Received: from [192.168.178.40] (unknown [188.192.100.83])
 by mail.jv-coder.de (Postfix) with ESMTPSA id E425F9F69A;
 Fri, 14 Jan 2022 14:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1642169798; bh=Av7LTTjqGcxplvQ7OCMVWAGBwalSDBIyX9T6wCLMyjM=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=rWcv9H7c8XLHbIA5FmhC3TZx9mW+amnmPgYwLBn/hcKINhg3uiqRzQc6UF5J87XBO
 sfXJ2HoFeqncS/5iHdSxPhozCZTrUMUQljyzaBQcqcWbtTLEWIUZGZRYhq0Q/YBvv/
 5hKkByeCHaUlT5+eslhmN4FOS7XwloVgxoej/TAM=
Message-ID: <95394feb-6474-d1ca-13d8-3d1c35e781b9@jv-coder.de>
Date: Fri, 14 Jan 2022 15:16:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>
References: <20220114125513.895-1-pvorel@suse.cz> <YeGEunEuwPvNFxyS@yuki>
From: Joerg Vehlow <lkml@jv-coder.de>
In-Reply-To: <YeGEunEuwPvNFxyS@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] configure.ac: Fix summary for disabled
 metadata
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

Hi

Am 1/14/2022 um 3:12 PM schrieb Cyril Hrubis:
> Hi!
>> Previously with --disable-metadata output didn't mention that metadata
>> are disabled and printed config which was not used. Now:
>>
>> $ ./configure --disable-metadata
> 
> Slightly off topic, should we rename this to --disable-docparse or
> --disable-autodoc?
> 
> Since we split the metadata generator from the documentation and the
> metadata are now genereated unconditionally...
> 

I would love that and I would reintroduce disable-metadata in that case,
to completely disable it.
The question is: Will this break some builds because of semantic changes?

Joerg

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
