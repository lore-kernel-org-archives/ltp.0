Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4169BC433EF
	for <ltp@archiver.kernel.org>; Wed, 24 Nov 2021 10:01:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 162AD3C30CA
	for <ltp@archiver.kernel.org>; Wed, 24 Nov 2021 11:01:52 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B6E043C0894
 for <ltp@lists.linux.it>; Wed, 24 Nov 2021 11:01:42 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 233171401623
 for <ltp@lists.linux.it>; Wed, 24 Nov 2021 11:01:41 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 6F8F51FD37;
 Wed, 24 Nov 2021 10:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637748101;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7OsCo2OF21LKPKwnMrZpXBeeazyz+HH9jIj3Fs1Dibs=;
 b=sSzkUoMUoZwJAGWhaKmweipe/sV3El7PUmK/UCPREXtG31Qy+P+b26kA4qmIrmkyTF0efa
 upWdyMXuD8MqaIuCHA6PhOcVIULy9yMV8C6uDgdvhu1mbWDDRKPyjDH7m3L9JiuStetg0j
 lbHpcd5Qe4eokV5yYlq7gmoYt8SFU74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637748101;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7OsCo2OF21LKPKwnMrZpXBeeazyz+HH9jIj3Fs1Dibs=;
 b=cLqllqtKjghz3ucAjc/Fm0quGGMY9RJe3xzy0Fq9rB6zyIBVjGaANjSuLNy1zaCgIfWxGO
 MXNIGrhAY6l5aVDA==
Received: from g78 (unknown [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 3FD74A3B8C;
 Wed, 24 Nov 2021 10:01:41 +0000 (UTC)
References: <20211123124348.31073-1-rpalethorpe@suse.com>
 <20211123124348.31073-2-rpalethorpe@suse.com>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: ltp@lists.linux.it
Date: Wed, 24 Nov 2021 10:00:31 +0000
In-reply-to: <20211123124348.31073-2-rpalethorpe@suse.com>
Message-ID: <87pmqplvnf.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] tools/sparse: Add static check
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Richard Palethorpe <rpalethorpe@suse.com> writes:

> This was adapted from Sparse's inbuilt check_duplicates (-Wdecl). The
> original check appears to print a warning whenever a symbol is
> non-static, but has no prototype. It appears to work because library
> symbols are usually declared first in a header file and then again
> with their definition in a source file.
>
> The LTP version also checks for the various library prefixes, but
> should otherwise be the same.
>
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
>  tools/sparse/sparse-ltp.c | 53 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/tools/sparse/sparse-ltp.c b/tools/sparse/sparse-ltp.c
> index 45874e8eb..73725d191 100644
> --- a/tools/sparse/sparse-ltp.c
> +++ b/tools/sparse/sparse-ltp.c
> @@ -82,6 +82,57 @@ static void do_entrypoint_checks(struct entrypoint *ep)
>  	} END_FOR_EACH_PTR(bb);
>  }
>  
> +/* Check for LTP-003 and LTP-004
> + *
> + * Try to find cases where the static keyword was forgotten.
> + */
> +static void check_symbol_visibility(struct symbol *sym)
> +{
> +	struct symbol *next = sym;

Ooops, we don't need next anymore.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
