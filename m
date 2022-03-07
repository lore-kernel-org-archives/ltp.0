Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB94DC433EF
	for <ltp@archiver.kernel.org>; Mon,  7 Mar 2022 09:29:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C7C63C1BBA
	for <ltp@archiver.kernel.org>; Mon,  7 Mar 2022 10:29:01 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA56E3C07C7
 for <ltp@lists.linux.it>; Mon,  7 Mar 2022 10:28:51 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 23F1160085E
 for <ltp@lists.linux.it>; Mon,  7 Mar 2022 10:28:50 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3C5801F37D;
 Mon,  7 Mar 2022 09:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646645330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=82hnUYKnD89VV0FkJ1CdJ4Xkg97Om6S5KugT5TrBJUo=;
 b=e0ufTBCxGs0qOdxlkP5aOgKCfGS8a990VdzMa8S6fcxoP+/hCP02m+2R6jvYQA+MqUSfr/
 fA1U0/QUjt1mLeeM2QwSuHpp+YRnghyAGikOfoqq2kdY5fkigkRcvmHGSSZEZDvgR6Khif
 5ZK8zaLYftyVIM5WnRRN5V2GHfBzPH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646645330;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=82hnUYKnD89VV0FkJ1CdJ4Xkg97Om6S5KugT5TrBJUo=;
 b=aQSn1d/a3JMuXzKMW0MpYP1EMtAPPLGI3SF7vx1PgK6C4bj4WYFgysvddSq9ie6es+IfHH
 JoVMN55j38Hii4BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 28B6B13A84;
 Mon,  7 Mar 2022 09:28:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id K+yjCVLQJWITDgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 07 Mar 2022 09:28:50 +0000
Date: Mon, 7 Mar 2022 10:31:09 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <YiXQ3XZJbP4/Gs1f@yuki>
References: <20220201093954.1660-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220201093954.1660-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Check for maximum available pids in
 dio_sparse.c
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

Hi!
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
> ---
> In v2 setup message for children has been moved from TCONF to TINFO.
> And other small fixes.

Please send the small fixes in a separate patch.

>  testcases/kernel/io/ltp-aiodio/dio_sparse.c | 26 +++++++++++++++++----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/testcases/kernel/io/ltp-aiodio/dio_sparse.c b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
> index 0039daa8d..1da1ae37f 100644
> --- a/testcases/kernel/io/ltp-aiodio/dio_sparse.c
> +++ b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
> @@ -54,14 +54,29 @@ static void dio_sparse(int fd, int align, long long fs, int ws, long long off)
>  		w = SAFE_WRITE(0, fd, bufptr, ws);
>  		i += w;
>  	}
> +
> +	free(bufptr);
>  }
>  
>  static void setup(void)
>  {
>  	struct stat sb;
> +	int max_pids;
> +
> +	if (tst_parse_int(str_numchildren, &numchildren, 1, INT_MAX)) {
> +		tst_brk(TBROK, "Invalid number of children '%s'",
> +			str_numchildren);
> +	}
>  
> -	if (tst_parse_int(str_numchildren, &numchildren, 1, INT_MAX))
> -		tst_brk(TBROK, "Invalid number of children '%s'", str_numchildren);
> +	max_pids = tst_get_free_pids();
> +	if (numchildren > max_pids) {
> +		numchildren = max_pids;
> +
> +		tst_res(TINFO,
> +			"Number of children reduced to %d due to system "
> +			"limitations",
> +			numchildren);
> +	}

Can we put this piece of code into a some common place and use it in all
the I/O tests?

I guess that we can as well add a function parse_numchildren() into
common.h that would call tst_parse_int() and then apply the limits and
use that in all the tests...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
