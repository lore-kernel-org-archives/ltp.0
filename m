Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A071C35FFF
	for <ltp@archiver.kernel.org>; Tue, 17 Sep 2024 12:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1726575799; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=MoeMxgBXRrPofUARry4D2qvS1qH1K6AjR97XAvQ7Ttc=;
 b=pleQ2J+qv5y40Dbw8sNBilJhzoMy4afTzUosVl94Yvs59d4/ZGGj9IHUdHlz7abRdV06Q
 sK9VEv1+zKxOvlXJU3QVlGcYR5HHNUbAovEUdf7ANodf9/M2+Jt8R0lQBA29/hKaI30VdDF
 3v5jYOj2i+vO3KLVY4dtfIOtKjrjvFo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D3E93C2DF6
	for <ltp@archiver.kernel.org>; Tue, 17 Sep 2024 14:23:19 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 940E43C0729
 for <ltp@lists.linux.it>; Tue, 17 Sep 2024 14:22:58 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0ACD82001D1
 for <ltp@lists.linux.it>; Tue, 17 Sep 2024 14:22:56 +0200 (CEST)
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2f7ba97ebaaso324141fa.2
 for <ltp@lists.linux.it>; Tue, 17 Sep 2024 05:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1726575776; x=1727180576; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lbJtxQafDnp3kwr6WO2EYxpGsV62nrJGQu2ykOKw4GA=;
 b=GwHPUqQHblXOjbGwGSc5zE98B6DA6miNePRzNO4DgjALvWG2mJIhUDGw+zmZSjhsLj
 SelGcQMtQvHfUlQMG9eNMDwUSg4JzLSv6m+hgGO/whObpxrr0fD/QJUmWXDUdfOOHdno
 CJy0RtubdNN/83y9C/zBWvDzErXcfDXk/pEg/RO2mcSOCnexsJxMwbz7FmqYYD7615hU
 nUiXAUOxraTWif8POE7FXKRC5CF9On9X+Vouf2Q76CmyJa5qgLoSQgPxWoVSrkzh9SIQ
 ZDgcl7SjRNyZw6mgq3IaxTHY2uqUmoZ9H+JKpHNTJwQHMUuweSKyi1o55w2kv2Q7i5O5
 otvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726575776; x=1727180576;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lbJtxQafDnp3kwr6WO2EYxpGsV62nrJGQu2ykOKw4GA=;
 b=aoP/CAn124rB9Z1R56YHjbwzf/lDMj9MGt0w1J7Fdt6qIvYiEoCAyP6a3nppcrr08k
 LYneFet0w7+Hizo0NvJxqMQ4M0p7K6hbg82qvNlhUEWmlQ/sC/2qiM+C1s2LDSowc9j6
 d+3w0g0m658GgsUc07tIwHyjiDuUfHiz/ltyKS1ZSWTaV2tEUSFaa5LBau8N7PYP+LYI
 Etp1T0suFnWbb0EQHGqyehucJxIEsEo8r6mI9mwSduLZi8wAge1SrPC5nsg98V+A6gNq
 Mq13VHAQvjQo4KMXNjQJL5kU0H09nl7wM2c1GVFj0k54yfn2JJ47vZtU2GXz0j/TReYX
 Eliw==
X-Gm-Message-State: AOJu0YzKEWrJBLiBpRa5t1XGH1fPBd/zDFYlgmCsUlelOUKr746mQtv9
 nduFO/eAzeQDMloF3ZXDhKeCcLZ5yMTSca464UvawmCQ5kI9I1LBBDwD0UgfCNjv2FP+QQX534e
 YLz0=
X-Google-Smtp-Source: AGHT+IFROLNJpL98Ewe7GkwjP/NEuvD19me5bjy1pbNPxDOOGxw1HbyDey5sheb1sZRP//E/rnB3rA==
X-Received: by 2002:a2e:a585:0:b0:2f4:50c:ab55 with SMTP id
 38308e7fff4ca-2f787dbf600mr89019271fa.16.1726575775332; 
 Tue, 17 Sep 2024 05:22:55 -0700 (PDT)
Received: from [10.232.133.5] ([88.128.90.60])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dbb9caafc4sm9294016a91.30.2024.09.17.05.22.52
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Sep 2024 05:22:54 -0700 (PDT)
Message-ID: <ec341aef-8b50-457b-902d-624103e8583e@suse.com>
Date: Tue, 17 Sep 2024 14:22:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <20240917082543.27125-1-chrubis@suse.cz>
Content-Language: en-US
In-Reply-To: <20240917082543.27125-1-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Disable failure hints before we actually run the
 test
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

LGTM

Acked-by: Andrea Cervesato <andrea.cervesato@mailbox.org>

On 9/17/24 10:25, Cyril Hrubis wrote:
> This is patch based on a suggestion from Peter Vorel:
>
> http://patchwork.ozlabs.org/project/ltp/patch/20240527202858.350200-2-pvorel@suse.cz/
>
> Peter proposed not to print failure hints (the tags) if we fail to
> acquire the device. This patch extends it for the whole test library
> intialization and enables the failure hints right before we jump into
> the test function.
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>   lib/tst_test.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 918bee2a1..3a71330b8 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -899,6 +899,8 @@ static void print_failure_hint(const char *tag, const char *hint,
>   	}
>   }
>   
> +static int show_failure_hints;
> +
>   /* update also docparse/testinfo.pl */
>   static void print_failure_hints(void)
>   {
> @@ -919,7 +921,8 @@ static void do_exit(int ret)
>   
>   		if (results->failed) {
>   			ret |= TFAIL;
> -			print_failure_hints();
> +			if (show_failure_hints)
> +				print_failure_hints();
>   		}
>   
>   		if (results->skipped && !results->passed)
> @@ -930,7 +933,8 @@ static void do_exit(int ret)
>   
>   		if (results->broken) {
>   			ret |= TBROK;
> -			print_failure_hints();
> +			if (show_failure_hints)
> +				print_failure_hints();
>   		}
>   
>   		fprintf(stderr, "\nSummary:\n");
> @@ -1871,6 +1875,8 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
>   	if (tst_test->test_variants)
>   		test_variants = tst_test->test_variants;
>   
> +	show_failure_hints = 1;
> +
>   	for (tst_variant = 0; tst_variant < test_variants; tst_variant++) {
>   		if (tst_test->all_filesystems || count_fs_descs() > 1)
>   			ret |= run_tcases_per_fs();

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
