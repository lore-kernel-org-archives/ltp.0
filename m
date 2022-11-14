Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98938C433FE
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 12:10:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2BA623CD225
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 13:10:38 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D53053CD213
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 13:10:28 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 70F2E600731
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 13:10:27 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 75EC621FA7
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 12:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1668427827;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pmutF0eXSaMArhb0FK0Fk6I3CWQH2XN0zwd/3MnfEQ0=;
 b=qxzmMLCqwmjb456Q4wrMsNu5fd/gs+ll08h/tVMxb24FY/54GKjx6x+wQRIH7hMVHLi1Do
 ipLcjpe68aATNue0LZ/PSw5kMIyJNXA8gu7pLTL19zdtSArGExJynUWd6qSOsZWwsPD8iH
 gXpnOL7g/fGzMXGpWGecHdiS9y5hdE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1668427827;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pmutF0eXSaMArhb0FK0Fk6I3CWQH2XN0zwd/3MnfEQ0=;
 b=A7V3XFvDz5AOt9LQ4dtLkw41hSq6Pv4TtsS7bv6bsrpGmALHuUDdirz7KmYg6eOuvPulgH
 CNCRRuikZsHi9vDA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 46DB02C141;
 Mon, 14 Nov 2022 12:10:27 +0000 (UTC)
References: <20221111170410.16350-1-pvorel@suse.cz>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 14 Nov 2022 12:10:02 +0000
Organization: Linux Private Site
In-reply-to: <20221111170410.16350-1-pvorel@suse.cz>
Message-ID: <87y1sdspn1.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] runtest/mm: Use the default value for -p
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

Petr Vorel <pvorel@suse.cz> writes:

> Test rewrite in 88321bfff introduced reasonable default value for -p
> option "number of mapping children" (nproc -1 in range <1, 20>), let's
> use it, instead of forcing -p 20.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Acked-by: Richard Palethorpe <rpalethorpe@suse.com>

> ---
>  runtest/mm | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/runtest/mm b/runtest/mm
> index 51302258a..f288fed36 100644
> --- a/runtest/mm
> +++ b/runtest/mm
> @@ -41,7 +41,7 @@ shmt10 shmt10
>  shm_test01	shm_test -l 10 -t 2
>  mallocstress01	mallocstress
>  
> -mmapstress01 mmapstress01 -p 20
> +mmapstress01 mmapstress01
>  mmapstress02 mmapstress02
>  mmapstress03 mmapstress03
>  mmapstress04 mmapstress04
> -- 
> 2.38.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
