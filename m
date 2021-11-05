Return-Path: <SRS0=uAqx=PY=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41067C433EF
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 14:24:54 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DBD06044F
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 14:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4DBD06044F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 874073C7507
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 15:24:51 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9593E3C559D
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 15:24:42 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 00012201103
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 15:24:41 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 4221F218A4
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 14:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636122281;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UOTat3JUXo9U4rPJSxhIyDNYlkVn1/IBpTHrl3RQpmg=;
 b=JJ/iUVVjFfs3o18f1ftDQjImujsvLZE3AO3d85Vo03/spQ0wWmh7eiY1ZzDG3F8KOdWWHS
 a493F1ZE84LQiLmIZWEIfxhFdBZ8mLTWaRXj1SnXwp6FKT9W/B1y50tRcsTotXmWCcyLIg
 lhxtPIms4wTaXyu7tUEOggvsaBn2pS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636122281;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UOTat3JUXo9U4rPJSxhIyDNYlkVn1/IBpTHrl3RQpmg=;
 b=bxXuKLmz5kY9zug6dYtBiBoLMzg7rYyvw9HxpE68VnbHTZO5syW1FZexS1W7MERHhtAWBJ
 y1YDMfOca53/SDAw==
Received: from g78 (unknown [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 127B62C150;
 Fri,  5 Nov 2021 14:24:41 +0000 (UTC)
References: <20211105140425.8272-1-chrubis@suse.cz>
User-agent: mu4e 1.6.5; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 05 Nov 2021 14:24:01 +0000
In-reply-to: <20211105140425.8272-1-chrubis@suse.cz>
Message-ID: <87wnlm7k9j.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] metadata: Ignore system macros
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

> Ingore all macros that start with underscore. Unless we do that we get
> several thousands of __NR_foo macros and the hash table cannot keep up.
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

> ---
>  metadata/metaparse.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/metadata/metaparse.c b/metadata/metaparse.c
> index b38550550..f71d8628d 100644
> --- a/metadata/metaparse.c
> +++ b/metadata/metaparse.c
> @@ -624,6 +624,9 @@ static void parse_macro(FILE *f)
>  
>  	macro_get_val(f, val, sizeof(val));
>  
> +	if (name[0] == '_')
> +		return;
> +
>  	ENTRY e = {
>  		.key = strdup(name),
>  		.data = strdup(val),
> -- 
> 2.32.0


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
