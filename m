Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 008B3C25B78
	for <ltp@archiver.kernel.org>; Tue, 28 May 2024 06:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1716876222; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=W/V0m04goGbe9wrErozGYxFjbvA04iDeph8da19GTWg=;
 b=PcK2o1+i3j0w6Rvefn6AoAUJ/ndIMQKH8uw2A+YXE8g8XaTwIw/e6TLJk8aKLEZNKhryv
 gqwI/3eAr9p90mblqEYPRXyrbwKIYPDDfO6jkIjDBZhgR+GaL3KXUGz78p6g+6cpQEmxRmm
 T4hbmn2CObQOdA03wCJ9pdRaFJAEP0E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 64B023D04B5
	for <ltp@archiver.kernel.org>; Tue, 28 May 2024 08:03:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF27E3CFCD7
 for <ltp@lists.linux.it>; Tue, 28 May 2024 08:03:18 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2D1C5200DB8
 for <ltp@lists.linux.it>; Tue, 28 May 2024 08:03:17 +0200 (CEST)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a6267778b3aso32193366b.3
 for <ltp@lists.linux.it>; Mon, 27 May 2024 23:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1716876196; x=1717480996; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QYwxfucIRjBjGOXPaRIUEUoIg9rwkUR7CqJr7DZM+xY=;
 b=Rx7tNR5w+RSz6RThc4lQsSbG6kzGv1jYVnVrETX2Z6xC0P5UlE9dDwKUJkVZxj3pQY
 t1kqGZV1FlTiZ5C28DbbTqsm+jD4jmwBY4giRG99fVdLxwnxFirFm3Atfh9QdKqpsnyG
 M30gQEgeZTok4AER5j8vwzQXQeh141neYXSMJTCpdC5b8ke/3765SzPvtBqOG0cqdYxJ
 qt2WfteC5uptqmAKboPDizC/iNURhJz6StGKGX07d4k1HGGFhGQaM8zx+ZBfr/IwenTo
 DxkqoZXsVSy7rxAcKQwVYy/G0UsaE3JXSbdz+71SIbpWv6hQCHnixAsJDagFnC5rdy8C
 NJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716876196; x=1717480996;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QYwxfucIRjBjGOXPaRIUEUoIg9rwkUR7CqJr7DZM+xY=;
 b=b0XkPbGA7010dfYcj8vaWTk2DzqlisTrCLmLkUUIlU08ncO056JS94JsxLs0l82Fao
 p1BB3n0PO1CTdKukZr67QkNMBkZ0EZbpMAoCI7kltFWngSnwdAUhGTQVrM/wTlYTz0J6
 TDu2DqqnvT66+A60gPnJ1Oi2suocqRKm+C1D5+XdiFDxPFUokJDiQFLWSyh8170EvljV
 RUQIR1hAPsRLN59X5Ed/Pe9QGz4Sag/xT8KuSIfV0q1R4/N6x5orhO6qnMrQRa82HfcD
 8dViKJTq5+TIo/o7JgnuC1JDF96DP0A9zUcSN7xCg3TAjcfpKFS1/qNzOo5orCv8GWgx
 W+4w==
X-Gm-Message-State: AOJu0YzBqjdwezE718oaQ4z/0IHCYUoQ79+K4H7I6WAjQo8njQz33bs1
 PkC58YnBUktDVUs0bq2dufYRJL2UbGDxjLFOxPpIZbiOy30QJheZWlyPuZFVZ6i6Be7CNQl/JRr
 v
X-Google-Smtp-Source: AGHT+IEL5WugzM3UQ0AcpRnXgdkQrDms0X96gVwZIy+uNUfz2NxO+dNB7P17oXIMvZBI8JEAgJSbxw==
X-Received: by 2002:a17:906:bca:b0:a59:a0eb:aeb0 with SMTP id
 a640c23a62f3a-a62646d56b6mr714284566b.36.1716876195869; 
 Mon, 27 May 2024 23:03:15 -0700 (PDT)
Received: from [192.168.1.29] ([151.51.162.26])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a631220b5b4sm133910966b.5.2024.05.27.23.03.15
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 23:03:15 -0700 (PDT)
Message-ID: <b4cbc988-1616-428a-af96-f278cb4fc1e6@suse.com>
Date: Tue, 28 May 2024 08:03:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <20240527202858.350200-1-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20240527202858.350200-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] tst_device: Print info about acquiring device
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

Hi!

Good idea

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

On 5/27/24 22:28, Petr Vorel wrote:
> Print how much space is being acquired. Also print hint on ENOSPC.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   lib/tst_device.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/lib/tst_device.c b/lib/tst_device.c
> index d659b54cf..635b39d08 100644
> --- a/lib/tst_device.c
> +++ b/lib/tst_device.c
> @@ -289,8 +289,10 @@ const char *tst_acquire_loop_device(unsigned int size, const char *filename)
>   {
>   	unsigned int acq_dev_size = size ? size : DEV_SIZE_MB;
>   
> +	tst_resm(TINFO, "Acquiring loop device %u MB", acq_dev_size);
>   	if (tst_prealloc_file(filename, 1024 * 1024, acq_dev_size)) {
> -		tst_resm(TWARN | TERRNO, "Failed to create %s", filename);
> +		tst_resm(TWARN | TERRNO, "Failed to create %s%s", filename,
> +			 errno == ENOSPC ? " (not enough space in $TMPDIR?)" : "");
>   		return NULL;
>   	}
>   

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
