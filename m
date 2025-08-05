Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B5FC87FCB
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 09:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754386812; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=avepEhDLrmOgoUZzJb0m5ySb8BywYgOkKGZM6oeWeB4=;
 b=gV+g4Q0ZsWQSwKfqBFZSSkxsizhTDbYnu4yZoplV6oheZpZWzWrxvAaLqMSdclemG+9ia
 kGYUe3QETGoepfZxEpsA7zfwZ39qQiLxO38OYYBJh2Vi4JpVPThFDlac8zbnwdojvmRCGCf
 qGshwXOYmioUO7rc7+CWB2iVLQ+D4Eo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2AB8A3C7F6B
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 11:40:12 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8735D3C1C2D
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 11:39:49 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 98C631A0091C
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 11:39:48 +0200 (CEST)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-af9180a11bcso1125148266b.0
 for <ltp@lists.linux.it>; Tue, 05 Aug 2025 02:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1754386788; x=1754991588; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=csZVEEPFOb8ekjyBL8PIEVHhLpz6ZHMewKiIDjRM4vY=;
 b=dfqR6D+01w8qVSZ1/W24oxlVOeDLv/JWNXHKmt/W9d+qvJfZ41vbDVONQUMtnM181A
 8zrzUtoTi3jlNl43gg0ss0EN71nkyPMZ6jd5Mxg8SH5YT0EBGvY26OLNeEdv/dUp/DGR
 VBjL2sq7eKJJwW7/5k8Zpnkeu15XA9UTVcyNChYUiw9J0eMTilD9ovMnBudz1nvnX3uF
 YXfjxRGcBy0zyCqMz21uOtls+DATxLk6HdqTpCASGmkkLq//xXXR45mG0cbsQG3KqU4a
 iBezBdtLJXkce69B884qpx1NNk4t0Cy+Lp1onREGKwtAV7hP+x+iIfF/u+XDZdogLsZl
 1ygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754386788; x=1754991588;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=csZVEEPFOb8ekjyBL8PIEVHhLpz6ZHMewKiIDjRM4vY=;
 b=phcXow1Ukb8sO9gm/ZLxth9f5G/KXjTP9JE119wm8RGRzXgXaUkWLFlNQsQOBqhndl
 /imSP8feHDFAFx9buRnaxCxHPZAUVXMl7iXxXhyMQEKkl7QW4ARdZjUUxfR6ty8wd6sv
 to7cIW1zRx2OKTEzEg2WzeuQyNV5XSeVF7hcjoofSAzCxHzzahX6NO77/LGwj0X00pKx
 sYPLnzGc5Tj33YKX/8REr8C69Aa9WCuQlfp6VPSy4fDgFM6FM3OqdDh8XEKmGHpvt7Cv
 tNs1gtmBJgjpPl0UHL3c/q574OrN9M17tw6HS4ACOEx235M8uXvfkTExh9p7FUKTDht9
 3Q9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/bq4E8797zkd4pX++vRQPiEpGhGxQlfQirbjfYzvnzdvhRsDudBAHjqUbPgSdVRkZR5w=@lists.linux.it
X-Gm-Message-State: AOJu0YxHnUHW+8+r7r3DIvDXt/Yz353W3Mf6HYg8ei/JO/uLsk1qpx/j
 Rps+CsWhlC8KowwoNcstcy6Ss1NWShuNRvQ3c4QmXXsmMoyqCnyioxSatxAtZxg8bLZ/2qJOES/
 EzfVU
X-Gm-Gg: ASbGncuD4XnV0vv+O123Fvbbbx0a3Qo9YoapQCY33LrX6gmPgcKJ6w1g2lxuPdt3QjX
 zsScj8wJie+6CXnvQtgJQGl3sYS9V7LCHfhbYen0RUVMZfXVOWxkIDifMBvtR+5BgpPPURtTYSM
 Yej7JH+k1Ms4jLh9cFVfLPCOJvwA6Yq70+mG+QfHaFoSq2Lv+IU+Z7NvYHCV+sEYhwoX/OZBwVP
 cKVhBZJmfBdBJzodmgg8Ys9gLtM8g+LYPlLmnp1bWJc5Uigjn+s/Mt53YdG83R6YDhpuSzBoggl
 z5Y5j8igct1yrIuxQjiORCmlZbFUPHg5jULo0qhHazSwrLuV2A0Yf1KkoxRuvVCAZaUi1trZZIa
 x1ptyaF0dQQhsoouTAoXRHyUh2qAvUBTXHg==
X-Google-Smtp-Source: AGHT+IEkpJLUpJk+bBDZIod41BnUOcQ9oC0TDOAsoZdtbVGfWLqSv+2lnWqfd7izxglrN9Ydid/6dQ==
X-Received: by 2002:a17:906:478c:b0:af9:7025:7d5a with SMTP id
 a640c23a62f3a-af97d325d91mr322318966b.18.1754386787759; 
 Tue, 05 Aug 2025 02:39:47 -0700 (PDT)
Received: from [192.168.1.91] ([151.71.162.118])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af91a0a3149sm872644266b.38.2025.08.05.02.39.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Aug 2025 02:39:47 -0700 (PDT)
Message-ID: <982022cf-4d39-4b7c-8ce2-1616497a57eb@suse.com>
Date: Tue, 5 Aug 2025 11:39:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jan Stancek <jstancek@redhat.com>, ltp@lists.linux.it
References: <39ee7abdee12e22074b40d46775d69d37725b932.1754386027.git.jstancek@redhat.com>
Content-Language: en-US
In-Reply-To: <39ee7abdee12e22074b40d46775d69d37725b932.1754386027.git.jstancek@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/epoll_ctl04: add ELOOP to expected errnos
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

Thanks, it looks good.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
