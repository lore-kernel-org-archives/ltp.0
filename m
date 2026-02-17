Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC347E909A3
	for <ltp@archiver.kernel.org>; Tue, 17 Feb 2026 13:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771335765; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=V2RhiuP6f7oSGVEMjOYq6rOjyRtlhnRqJGKnnrVlDuc=;
 b=fuygoNttjSIWrufhIqxfLhZi8etxB0Og0M/SM7cp+cCa3RxNMSKG6DBDpjtnZZ2t3FUTY
 xsRK6OrFr2f0YEunc/uigKSmMQt9n1ll9akQyIlhotwB6q3zl+NS0g6gmJDsMy0gPboy2EN
 kxu1DaRdBuKUMsz81YynBDOCx0OKqro=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 729933D0619
	for <ltp@archiver.kernel.org>; Tue, 17 Feb 2026 14:42:45 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 06CCE3CC816
 for <ltp@lists.linux.it>; Tue, 17 Feb 2026 14:42:21 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 723FF2003B3
 for <ltp@lists.linux.it>; Tue, 17 Feb 2026 14:42:21 +0100 (CET)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43591b55727so4789765f8f.3
 for <ltp@lists.linux.it>; Tue, 17 Feb 2026 05:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771335741; x=1771940541; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ld+Ac8CPF1A+yL2ZVcQdoh7c5JcvcbBPXOOzBwfC9+M=;
 b=H3RSBLy13y431CoteXqAbJTFVU0ZvGltdwEzNTkqINE1c6YmCQW/imEE+KymlW7uDI
 oP6WWzCm4vdun/bneRP21BXh2DYbQw5L5KgFQ0ZUMLiObgpIrgq7aSYm/v9/eezmqWXe
 RguR4j5xGideruLU89s1cDhcthQgMGpMg5dLY/g1Y6npwsHMuXAdZmEJh+yW9XdPbVS9
 XeGmevfwM0m6Et2oIxD3RjlqCjF831A5daaxacTaFTOkbXdCbquMVLEnIWauBp6sGKEe
 8QxIM9CzE+xHHnyrTrKNPx2JS8rN+HCbi5WyXnS4xA15/5/YsPVNCnP0xZiDM6DpVoQe
 T1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771335741; x=1771940541;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ld+Ac8CPF1A+yL2ZVcQdoh7c5JcvcbBPXOOzBwfC9+M=;
 b=E6qgQjpB8DMhF9gJZ5km3Fd79/1aorF7hoeEl4eL5kcAI7ZLPIvOkw5IGi07nKU0tX
 pKWVPrzoC32X2Mj41LMq8AkPrnoWcwz1Mq1ZkzhD9H217jM0OszbCyIadtxbIeGjRKLm
 38RO89bFxRBweZwoODEyXMbL21W6HQUtg/cX82eEFnmivEd3L7HU7pCbrMeKYvhS88Hu
 OGfixfFTgI71XK44/NB9twDssmXj7OxX2y5E2CxcIfB0Ug9gJFFquwuVORCrRyv603zC
 qTJXvS8IZC/SoPNu+6I9MqOVXuUTy/QmjqYXpa2kLT59dNdJSXRdsuizQ26csRj5SK3V
 YCcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmfhHFwdao5JrnP9IYjGWklfWdZEfY41Hi20EOYeUtlbCWel5h/rgo3BBc9/aJN7mbvF8=@lists.linux.it
X-Gm-Message-State: AOJu0YwshWWjXBjgPiRVZtIL5X4FoDGeygr2FN0WkguzdMZkduHonMx/
 GP3p21TRbdcDgndXjgSvIwxh8YZHtyz8KM9V1EXycIraqjQQAI/oLQX9IZWk/1gjbmgL8dLrm6w
 qneeCzwQ=
X-Gm-Gg: AZuq6aJaQuyPTsY/GyQuB12UpoYurK73wvpI80TS0aWBT77ULPLERVzM6mjtBJsYKw3
 VE698yS7vqI6fump5IXXdvCkq6qGBkbdYlb4uVZalV96x/Axg8WQOI5WqU4QTbfJdZIXNQTx/qq
 sOVKB+pcGRhN8U8wDArDcClqcfF2Nx7r5odU2ymdpvvyCPJU3fTH5Gy0sYsm2F2iM1MMRANxAQ8
 MZCOeGUX4u0MCi27DHULXpAapRWKCM9Ss0ZoL5x6aup3+2gFfCMuxfXW+eUBECx7gdaE04qzNsU
 nQQd+R0eXlTgfESni42Ql9Y5GuvMYnH7/o7M4dWNe6XwIN9kRWcMZkJSAPAy52l4dil5AqL6+Qc
 FzfXB1CWHpYYLX1Qi3JJwYYtPQGL+KQcjrX0eaG5xnlD+mNFaPVxW+c+u559adC7sIClEAnWBPZ
 /wLYmluWGuZTfYNSAGMUqqQUifUf8AJxIoLMWWIF2oss2xbvFFFB4zVPfboh60i1Ccj+3wc9u1Y
 XDcLQlJeRKj8o2kU+w=
X-Received: by 2002:a05:6000:1883:b0:432:5b81:480 with SMTP id
 ffacd0b85a97d-4379db61fe2mr22143107f8f.24.1771335740637; 
 Tue, 17 Feb 2026 05:42:20 -0800 (PST)
Received: from localhost
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac8209sm36469120f8f.30.2026.02.17.05.42.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Feb 2026 05:42:20 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 17 Feb 2026 14:42:19 +0100
Message-Id: <DGHA452V46ZQ.1WJ56YNH91QUB@suse.com>
To: "Martin Doucha" <mdoucha@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260213145200.23935-1-mdoucha@suse.cz>
In-Reply-To: <20260213145200.23935-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] readahead02: Always allow at least 100ms for
 cache to fill
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

>  	if (do_readahead) {
>  		do {
> +			cached_prev = get_file_cached_bytes(fname, fsize);
> +			tst_res(TDEBUG, "Per-file cached: %lu kB",
> +				cached_prev / 1024);

This should be %zu. The rest LGTM

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
