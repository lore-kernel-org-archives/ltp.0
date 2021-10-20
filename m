Return-Path: <SRS0=xZdR=PI=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DA1C433EF
	for <ltp@archiver.kernel.org>; Wed, 20 Oct 2021 07:07:28 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ECF4600CC
	for <ltp@archiver.kernel.org>; Wed, 20 Oct 2021 07:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4ECF4600CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 262253C4F60
	for <ltp@archiver.kernel.org>; Wed, 20 Oct 2021 09:07:25 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 358423C1B57
 for <ltp@lists.linux.it>; Wed, 20 Oct 2021 09:07:14 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 23636201094
 for <ltp@lists.linux.it>; Wed, 20 Oct 2021 09:07:13 +0200 (CEST)
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 293C93F4BA
 for <ltp@lists.linux.it>; Wed, 20 Oct 2021 07:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1634713633;
 bh=GLuPr8IN2DLgkb0AhnD5ZMCE55O31f3H9i4jEIqYcLE=;
 h=Subject:To:References:From:Message-ID:Date:MIME-Version:
 In-Reply-To:Content-Type;
 b=OQJTtSzpqShQRkexzFybgzELBJW8a/yb5lwlvqsGUDB0GGnkpCgsM6YrBP4r5WkJh
 RMq3SuDedsxpQO/LVthPonUrgyZgCZy949ekQznyWrVNSHkf54tkUMWtLd+l/5d2aM
 pbEM4PsTvZi9kYW/fV9Q+u+LTP366pV/0Z6p6yWhcEHesONMpVd/oeZ0Jq0QNM7xD8
 7wBcnSvWehgrZAVVr6mC1/cmVfy7ljwOf2qfui93l237dRrA6N9xBMgo2f4Sb7cQdo
 489TyavjzK7AfNdZVzjE7yLmTBFQP8HjMlfCC559P7hrVoXMFN/xHL9sYKzV2Wy7Ij
 +vsVRYR9807gg==
Received: by mail-lf1-f72.google.com with SMTP id
 d12-20020a0565123d0c00b003fdb52f1cdcso2733015lfv.4
 for <ltp@lists.linux.it>; Wed, 20 Oct 2021 00:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GLuPr8IN2DLgkb0AhnD5ZMCE55O31f3H9i4jEIqYcLE=;
 b=P7PusmPaYQ8ry1adHqHHKn/gX0pnS61Q1yAWqOgmjkQWSpCGsKhImwZ5g23023Htj0
 0CIOJTPq6SSJT0n/u+7SxCRz3TjTBMN0x6ZaSIfUHCgs5BkqzSgJOxl4VoEFtAKm4cox
 f+mvCI1cCFxEKPK8sCS/nlRU0GRgmJojVHrIcDY7IE9hnoTF4S7KSBPiz1NHV4XIS5XV
 QSukWL7n+x62G0NjCYok4YTL0Cj4n+OFeRWNLko52yVOPWF5vQOC1LuYUhoYNxpNjSDW
 6n2Bw8EZwLUxMhnS2MEwTNwBcjHX81vdgFBdYJKl9tjC9kJ3Wc8jngCtlXUHrzsERnl3
 QFvw==
X-Gm-Message-State: AOAM532yIUdiD0CGpdw6xtEQYx/0yPg9/nF1Hf4QfJ0Ek3EsQIaCWjgc
 /q/UMoCFQ/XBkrf5usC8iyAo6REVP19JHmKmvCH+zdl8LYuyYoC1snhZyo+kif9gH93r4gR3TM+
 emgiQk3KWeIWqpu5wfU3QvhHBUeeQ
X-Received: by 2002:a19:c1c4:: with SMTP id
 r187mr10455044lff.360.1634713632153; 
 Wed, 20 Oct 2021 00:07:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkxw3MazZaIp1Di16z+CBz4FvRUPkbZUmMnSGB5RUvYaZrfLMWNLKaJLecfN7J/yE/cs8Fjg==
X-Received: by 2002:a19:c1c4:: with SMTP id
 r187mr10455034lff.360.1634713631971; 
 Wed, 20 Oct 2021 00:07:11 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
 by smtp.gmail.com with ESMTPSA id v6sm126057ljg.121.2021.10.20.00.07.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Oct 2021 00:07:11 -0700 (PDT)
To: "liuxp11@chinatelecom.cn" <liuxp11@chinatelecom.cn>,
 ltp <ltp@lists.linux.it>
References: <20211020063220.5885-1-krzysztof.kozlowski@canonical.com>
 <202110201459177524146@chinatelecom.cn>
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <9f9105ac-a544-2caf-f88f-c9529cf81119@canonical.com>
Date: Wed, 20 Oct 2021 09:07:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <202110201459177524146@chinatelecom.cn>
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib: memutils: respect minimum memory
 watermark when polluting memory
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 20/10/2021 08:59, liuxp11@chinatelecom.cn wrote:
> Hi, 
> Why not to directly read minimum memory watermark from /proc/sys/vm/min_free_kbytes?
> 

Because it has different purpose, different values and won't achieve the
same result as we want to achieve here (pollute maximum allowed memory)?

P.S. Could you not top-post? Also you broke quoted email to some
huge-multi-spaced-something:
https://lists.linux.it/pipermail/ltp/2021-October/025524.html

Best regards,
Krzysztof

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
