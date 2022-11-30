Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B709C4332F
	for <ltp@archiver.kernel.org>; Wed, 30 Nov 2022 13:48:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 494CC3CC53D
	for <ltp@archiver.kernel.org>; Wed, 30 Nov 2022 14:48:32 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6966D3CA96F
 for <ltp@lists.linux.it>; Wed, 30 Nov 2022 14:48:22 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A8DE11A0093D
 for <ltp@lists.linux.it>; Wed, 30 Nov 2022 14:48:21 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B8C541F37C;
 Wed, 30 Nov 2022 13:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669816100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q9khfg+FfdqCkThXZwzCc2PhFPkqf/28j+VXXfWk8Is=;
 b=Jrkwyzrvo1/xMoMC9BUL1CtsN7RTz7WZOFVIyh7CyQl2dzUiLsGAgUJVjZKytb4xc9sydk
 32/1TEXzQMGpXVOqMpkUsNoVbl/FTxl33BKA0o0xtuTV0Riro7Dd5Xe+sady8YYdg3B91w
 UYBv8tFKOhyFC/6aOCEWi8Jno/iF9Z4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669816100;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q9khfg+FfdqCkThXZwzCc2PhFPkqf/28j+VXXfWk8Is=;
 b=7loUM3jZs+8cnsHD7JeDAm9hgo/QBGDsH04NqkCQTcgXr12q+PEODERhbkNHFJqlkRJ9R8
 CpcDyG5c2SJqilDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A10151331F;
 Wed, 30 Nov 2022 13:48:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id O3IKJiRfh2NbaQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 30 Nov 2022 13:48:20 +0000
Date: Wed, 30 Nov 2022 14:49:39 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Message-ID: <Y4dfc6K9xvJkDbK4@yuki>
References: <20221130021901.33143-1-zhaogongyi@huawei.com>
 <20221130021901.33143-3-zhaogongyi@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221130021901.33143-3-zhaogongyi@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] lib: Replace atoi/atof with
 SAFE_STRTOL/SAFE_STRTOF
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

On Wed, Nov 30, 2022 at 10:19:01AM +0800, Zhao Gongyi via ltp wrote:
> Replace atoi/atof with SAFE_STRTOL/SAFE_STRTOF in parse_opts(),
> it is hoped to deal with the abnormal input.
> 
> Modify the requirement iterations range from '>= 0' to '> 0',
> when iterations' value equal to 0, the test will not run.
> 
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>  lib/tst_test.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index b62559d75..254229d96 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -677,15 +677,13 @@ static void parse_opts(int argc, char *argv[])
>  			print_test_tags();
>  			exit(0);
>  		case 'i':
> -			iterations = atoi(optarg);
> -			if (iterations < 0)
> -				tst_brk(TBROK, "Number of iterations (-i) must be >= 0");
> +			iterations = SAFE_STRTOL(optarg, 1, INT_MAX);
>  		break;
>  		case 'I':
>  			if (tst_test->max_runtime > 0)
> -				tst_test->max_runtime = atoi(optarg);
> +				tst_test->max_runtime = SAFE_STRTOL(optarg, 1, INT_MAX);
>  			else
> -				duration = atof(optarg);
> +				duration = SAFE_STRTOF(optarg);

Shouldn't we limit the duration to positive numbers here as well?

I guess that we should add min and max option to the SAFE_STRTOF() and
call the conversion with SAFE_STRTOF(optarg, 0.1, HUGE_VALF); here
instead.

>  		break;
>  		case 'C':
>  #ifdef UCLINUX
> --
> 2.17.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
