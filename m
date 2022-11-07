Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55AFAC4332F
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 12:13:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FEA23CD9E6
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 13:13:39 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF9923C0181
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 13:13:29 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B3BB96006C3
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 13:13:28 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id C19B3225E4;
 Mon,  7 Nov 2022 12:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1667823207;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ifhS0zTVXU8PsQjGiheOtVqJOo8J+iYFnDEDkLMxij0=;
 b=1xNVIsuI1+WSB0Y18mCAGApT+TvakwSaWnW8C0BfQbOrma8FICvkVFnajxbYQkuZL36XUz
 LBL50QuzzMV9jfr5Yiv+8eVnpkeHzBFodunTis6NB47v8zrwtwdXEQwQ5z7th1Sgeyq2T2
 PYFEgNhZkh5rahWPeLAtxjvdXq6IlFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1667823207;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ifhS0zTVXU8PsQjGiheOtVqJOo8J+iYFnDEDkLMxij0=;
 b=lAttWBjERlNb9VZDsOmTipQpnWCVCTz0/g2oZNW3hqcue5nf936qAQhywGrXWVNiaIbOZa
 IddRRRiR/k1BghDQ==
Received: from UNKNOWN (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id E20FC2C141;
 Mon,  7 Nov 2022 12:13:26 +0000 (UTC)
References: <20221025121853.3590372-1-liwang@redhat.com>
 <CAEemH2ciCbmVhVtm+oMV2JqnWf10qK-GAZNp1bZOiC2ks4cnuQ@mail.gmail.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Mon, 07 Nov 2022 12:11:23 +0000
Organization: Linux Private Site
In-reply-to: <CAEemH2ciCbmVhVtm+oMV2JqnWf10qK-GAZNp1bZOiC2ks4cnuQ@mail.gmail.com>
Message-ID: <87r0yfvu6y.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] setitimer01: add interval timer test
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

Hello Li,

Li Wang <liwang@redhat.com> writes:

> Plz ignore this patch, it needs code rebase after Anderea's work:
>
>     b606a7c7d setitimer01: Fix checking of setitimer() parameters
>
> -- 
> Regards,
> Li Wang

I'll set to "changes requested" in patchwork. Plase can you update Patchwork in the future?

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
