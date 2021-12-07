Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CEEC433F5
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 11:44:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 46E573C4D92
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 12:44:16 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 418AF3C042D
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 12:44:07 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 78185200DAA
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 12:44:06 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id ADC6C21B3A
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 11:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1638877445;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1yh5AB8SU1n2pwoGtvocXRx/5vaK1fcvBuaQF8YLxUU=;
 b=cpdk8S5AVmk2y6tdyz0TluZRatlzlOYXKOEre6E0YmAr1QU0eALvVtuR6A+keEVBiua3ZM
 VXY9X1HjRuth4I5EeMw2zMQ29y0yD+NipZeRt4fFOOvUQC2eyneSH7oP57KWlEi2Swzqrb
 x6spJ1XKYjsiORqEWS6T4irRiuG8o+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1638877445;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1yh5AB8SU1n2pwoGtvocXRx/5vaK1fcvBuaQF8YLxUU=;
 b=v7h73COzJ7PoEuHWTLGFSn6hN+sLy7eyk5uJ0nOOLyDKg8pXYHGBp7jK1vYA+iYrydcEkV
 9Iw51TymOyu5JoAw==
Received: from g78 (unknown [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 68FCBA3B83;
 Tue,  7 Dec 2021 11:44:05 +0000 (UTC)
References: <20211207102904.6011-1-rpalethorpe@suse.com>
 <20211207102904.6011-3-rpalethorpe@suse.com> <Ya89l6N6nGtPEiu/@yuki>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 07 Dec 2021 11:31:49 +0000
In-reply-to: <Ya89l6N6nGtPEiu/@yuki>
Message-ID: <871r2od4hq.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] getrusage03,
 setsockopt03: Add sentinel value to tags
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
> Looks obviously fine:
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Pushed! Thanks!

>
> Also good catch, this really shows that the automation is worth the
> effort.

I hope so and perhaps this can be generalised by creating an attribute
e.g. (null_terminated) which could be upstreamed to Sparse. Then
eventually it might be adopted by compilers.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
