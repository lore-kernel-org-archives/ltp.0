Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF16C02183
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 09:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736846141; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=qtqIKUJY7JJc2Bj1SGM7kbZOrzLNEGs3GELpsLj3jGU=;
 b=DXf/1LR6it4biAuhY/KtOY+cUu4x5srGMGpM5xl6MKOTaJViWTs8lPOpzJ8mu4FxUKRDj
 5uN/1VyzAO9keq2t7qvR4fjYu0U2VNwW3QMIAH2orElZiu/lA8AbBfOvYQ9M++QKnuoiaDp
 ZxeFLCGs08EnRfhu9oDOcB26Z+9rvXo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0275F3C7A25
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 10:15:41 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C65E23C0B87
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 10:15:19 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 998FA65BE38
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 10:15:18 +0100 (CET)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43635796b48so32154445e9.0
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 01:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1736846117; x=1737450917; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KO0tFv8Hq7/dRSmUnj2B2raR1DMzyU4UL3t34rpZRHU=;
 b=Npd2HaI02uGGmXDzjN8vFzi52qezmVrGkG0a/xY2SYt3QULtdjnImlCH7r2qbb87mU
 gfcRf7T+wXHJ9SDGzV6zwpW1sXf6DFeUxDBAQpH3qnlekX9JiW6v8Z4+mtFqpJSKt/21
 tyszop0lQ/7OuC8Hv575DgFw7D0/VB4OxsZGMBAgov+b0IP988/rGVxrwXXpKOCfjQU/
 PdNw9zluBdR3F6GISX2xSEDy0x45LXTH/AdBSbkxn+zOddIQiJqfvHxlK6qOnPYJVoOG
 glkcOLNgjSy/U0BgGZVOTrRA31J2Qp56tCQ0bORlwaCYkdklkC3G8phvQKlfovrH3Ijy
 kqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736846117; x=1737450917;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KO0tFv8Hq7/dRSmUnj2B2raR1DMzyU4UL3t34rpZRHU=;
 b=S+p41IfbQwXAlk68iPBhX9gOGwgYUd3Hf1W9fQq0Q7y5criz5d9c/fCzerwq4SYn7l
 sSqhHAR6he1o3Z9zwloNyPimmyePiBE24hEj2iiFHGbGo1xJa+xNb7mJjkpDvH0QmQuf
 yiMRPZ2Y3YcN3rv3/nNUALjMkiPnWKvXfrApFqA7hc/K28p0nroZlZvC1RS+ZYxwhgtQ
 JXKvv0QFvEcU6A+0QuYDGHdhN8zKGp+F/cOcQYIM2TZmSpwAyLiMr6WKWHX/RdvHjV+B
 8AfuZoreg58XTt2JBMLpAdjjIYTUiigTH2r8f+EYaZk9EJTsAtHnGXrmmut0eK8W2NTx
 RolA==
X-Gm-Message-State: AOJu0YzaaWOeJ7XzStip2sDzxvWG6R7U+zoK5xkWYgbX/ajYAiKZc0A1
 LwnJYzJ/sLfNlnQZ82tBJnO0Tq4dsHra5T5pzWM5xjBcdX4mJ1tdb4FUM4KJYFCiF04jM4WIHgs
 DOx0=
X-Gm-Gg: ASbGncuwpcx+Po7p7glA1fObitc/W14ZEGHR0qf1sc8MiM4h5bhJSRWRI3FxnPAvmQO
 nfFCMLV9EKVDaUTY0p7Qz0dd2gGAlY009QAOxSL28IRsF5Pn6aGECAwgRjblM9ef/yUhZ4NnzsX
 eMTAEgvkEcS9FjB8CBGPaOfd6ALjB4qvK5l2bCnNrt75amCv3qHwSnZzSsmqqHRVgV5kvJjsIE/
 yDrnaGX9RXMlxjB7uPIiWHEBfq8XC25xFsisDjauQWEHCKvgUkrQJczN4HJ0JzfFAS4DfwY3U/i
 qgvc2SlCKgHJnIzo9UOMcEdKuCVq9AuYG8UId0u+0sWKYv+9JYuPQxEG11SJ745byjcezgXnFV2
 qzQ23/1zu1oLWOqMopn8=
X-Google-Smtp-Source: AGHT+IGNzrAdZ+fHo4RORTHDfu1iTFV1iv2E/MpaIan5YxxAvt1EA770+joA3skuD5uFs5dJTZB4vg==
X-Received: by 2002:a05:600c:2282:b0:434:e65e:457b with SMTP id
 5b1f17b1804b1-436e880fc75mr184576475e9.3.1736846117646; 
 Tue, 14 Jan 2025 01:15:17 -0800 (PST)
Received: from ?IPV6:2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4?
 (p200300ef2f2b3f007ee622e7e7efafd4.dip0.t-ipconnect.de.
 [2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9e37d7fsm167195595e9.32.2025.01.14.01.15.17
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 01:15:17 -0800 (PST)
Message-ID: <469ef970-50b7-44d7-9e3c-149906d06425@suse.com>
Date: Tue, 14 Jan 2025 10:15:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <20250113-add_b4-config-v1-1-d0c14d9dfac6@suse.com>
 <Z4YqUBBRK_BmHrQz@yuki.lan>
Content-Language: en-US
In-Reply-To: <Z4YqUBBRK_BmHrQz@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add .b4-config file
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

Pushed thanks!

Andrea

On 1/14/25 10:11, Cyril Hrubis wrote:
> Hi!
> Acked-by: Cyril Hrubis <chrubis@suse.cz>
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
