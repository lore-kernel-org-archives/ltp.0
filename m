Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D990C4332F
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 12:08:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 25DF63CD230
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 13:08:06 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 296353CD213
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 13:07:57 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5EE6A200935
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 13:07:56 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id A2E7D2274E
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 12:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1668427675;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9WwWUyVrczl1Izbw7ZMXd+h+r8bZj3ve389kK2g4byo=;
 b=c14fyZw5QiNL79+avbC8zWXiN1jVyimepUBkKJRVPDaHF6DkzUC6m0H29o/64t5xxhiUe8
 iaqlg7UI/k++zYPDzhAmqvWDwPOwCYxK4S/+RJNGJSOT1rhdOF0BidjD0dLXRfkR7iznxJ
 C2vfTfz7CDkZ9dwQmNyNOt3kWZvG6Nw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1668427675;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9WwWUyVrczl1Izbw7ZMXd+h+r8bZj3ve389kK2g4byo=;
 b=EPrexPuImG4WqrgBfslUOszyDjVZG4/jg9R0oDnYquoXcKWfVt1Th2/a3bmzsfCMbAKkk/
 u8D3/nivB9mJXgCA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 77D982C141;
 Mon, 14 Nov 2022 12:07:55 +0000 (UTC)
References: <20221110145429.8158-1-pvorel@suse.cz>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 14 Nov 2022 12:05:53 +0000
Organization: Linux Private Site
In-reply-to: <20221110145429.8158-1-pvorel@suse.cz>
Message-ID: <8735alu4bp.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] README.md: Document IRC
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

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> changes v1->v2
> * s/on/at/
>
> Kind regards,
> Petr
>
>  README.md | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/README.md b/README.md
> index d45d1ee44..89b2640c1 100644
> --- a/README.md
> +++ b/README.md
> @@ -22,6 +22,9 @@ http://lists.linux.it/listinfo/ltp
>  LTP mailing list is archived at:
>  https://lore.kernel.org/ltp/
>  
> +IRC
> +#ltp at https://libera.chat/[irc.libera.chat]

Won't the # make it a top level heading?

https://daringfireball.net/projects/markdown/syntax#header

> +
>  The git repository is located at GitHub at:
>  https://github.com/linux-test-project/ltp
>  
> -- 
> 2.38.0


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
