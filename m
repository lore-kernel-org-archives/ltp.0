Return-Path: <SRS0=zuCx=QD=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E53C433F5
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 08:43:10 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5482761A56
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 08:43:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5482761A56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7AE8A3C87AF
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 09:43:07 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 670023C86E6
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 09:42:57 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DA97C1000410
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 09:42:56 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id DDE3021763
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 08:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637052175;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/Z5BuGtK0rprFLws8DXGRo0MDRVeJXsIn52dTwfJs7Q=;
 b=UJlUOl1d73JAQN0KnSAw+ncgMA3cdRWbKJVCvsvvNCF2Nne1uc2vEoLPPjO65CsEuXxBvh
 +fpuKI2+dQVs/ZzntiQ3FiD/xAqJZzUJ4+XAGSm9+75G6bQxXjdy0vV4dMXedb6qRDkEXF
 luYGH7B+w8dJESRzbvYklvPDaJEdL+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637052175;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/Z5BuGtK0rprFLws8DXGRo0MDRVeJXsIn52dTwfJs7Q=;
 b=Fgqu8X23Ubr5/jKudFfwVWsvdUdajWaajEy8YhoH2G7zOOuXELW+7skLlxedk7nFKhvZAj
 7/Ivf6A/WF2wYaCw==
Received: from g78 (unknown [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id AA99DA3B81;
 Tue, 16 Nov 2021 08:42:55 +0000 (UTC)
References: <20211115152029.22552-1-rpalethorpe@suse.com>
 <20211115152029.22552-2-rpalethorpe@suse.com> <YZKF1iObIFC8DRGy@yuki>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Nov 2021 08:41:50 +0000
In-reply-to: <YZKF1iObIFC8DRGy@yuki>
Message-ID: <87y25obieo.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] lib: Add .skip_in_compat flag
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
>> +	if (tst_test->skip_in_compat && TST_ABI != tst_kernel_bits())
>> +		tst_brk(TCONF, "Running in 32-bit compat mode");
>                                 ^
> 				Not supported
>
> I think that the message as you wrote it may be slightly confusing.
>
>
> Other than that it looks good:
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Thanks, I will fix that up before merging.


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
