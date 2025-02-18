Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436A8C021AA
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 15:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739892083; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=ON5waKZL0R/nnD2zOJrEkmjKxUUx2FDM5W1IbAqt7Ic=;
 b=dFhEd7/JlesFxvw89kLhI3N/cZh1Yb91Ik89yzc2ZpfwJ89AL3OtX/jMUIOC/CexaPcch
 wy2UbrKxDmklYRyWKw5TTmylZ0yPwDthxVjmvIyr/WbvaFclMnAb5uvHqQaFXD6mrhu3mUI
 nBAFr+dpNuMWmiADIQQ8CDOKP6VK/k4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A90193C9CEF
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 16:21:23 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D4B9F3C0722
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 16:21:02 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7209C61BCE0
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 16:21:02 +0100 (CET)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-abb7a6ee2deso478169166b.0
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 07:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1739892062; x=1740496862; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lzJF0lYw/+iRerIIECdy4cKz4Fl3lVn/Q7Oud5cp9D8=;
 b=PhPIWJJpKTT2c+HNbfo/F+vhPnnllQdEhY4t8zxayEa8ZBo1QLw6dt0NuawNzzgEET
 89WSR+F2Jrqe6n4mZ+MCPxoRXqcQDbIdrJBK0BK9gz0lGO5W0M5fwIfeBURb5VLzqYWa
 8jRQFwxZrqJSOLOjMVpfIpOp23342RJ+WeHBHpQcHpYDN1J4ndCi5aX+UHLdJGzhSA9T
 LEI8CWNNfvP6zj8bXSMwei+x1qN/G4N43ozOp4chpCpt+09ud0C6NWIIW5THHnGnnzBK
 tRPk/kYA9ReaQo6fjM6b2mrW2aUaRgFuvroDY2svdKTIKx0QWuqujO1ZSw7tON77pV95
 cqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739892062; x=1740496862;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lzJF0lYw/+iRerIIECdy4cKz4Fl3lVn/Q7Oud5cp9D8=;
 b=l9k60gpa7VdPqFDt4BQkR02/jz3vH1HsVV2ZQe1dRYL5x75Y3lyFo08iFBvNu20nu6
 Fc7OxvSBbG6UWywS84yTW5h83PGbtzwRlpFYqYMrM9qEeXDMsy00EcoyDKKbIiwg+9iB
 ODPhdVZRdZ2mxv18qvKY3R/hzT3UJa7QyIAcckqPdf7/zB9wRtkZYd0NRTV5zpbRmmN+
 nKDIUwOnmOTc4J+/ZPXdMW167Ezawru2CMyzfYByB+r4nPlwPIQq7CA5ahiPdzMtlQ55
 c7loCpzcHjdBtV85p55fNELF9+aNaRA2IVbkqSCsYqh4+ICNmdyUkeFS143tLGJQkNvh
 D11g==
X-Gm-Message-State: AOJu0YyewzjbDAw0ny1EMEmqKnnBebjSCHrLV7Q3u5xjdXy+jAp42nCH
 GfUj6W7g3E06XR/pT4JW9zelJRdc1u/Os+2+fKJKZD9rHwddRO4EtBCSqcEJdrk=
X-Gm-Gg: ASbGncv7r4f75GICzYM1KawALOxqdh2uisjYDhgzPT4UNzJFieQkce3Ua8BEw1rGh6h
 C61as+7sJvTmuq84iMqijiK0XrkFQdSmoJhI9/cxo5rsCp7SO6xZ63nxUj3c4k10G+9W2bEje1w
 /ZI9ccsj8p7D4UghAMY4BLMz9YTlWWsTEw80aUgKe8Own/Wd/eyLPLTMl+aKHLmuVa/8hD32O6O
 ij+W5CMazjXeyGYqBRgIRyt5ZxpyRen00mGrUPHQ5HyUXeDnnk924QeB2abTbJCEDaNGVlcXmuZ
 Zchn7514Bh78G4WHSJOquENraQ==
X-Google-Smtp-Source: AGHT+IGL/0sUI50ZdMl2b+8P6hiBAAGGEOnK743ND0jv0CuJGKiTnwGnhamYtMS0aS3hqj9eXgSsMQ==
X-Received: by 2002:a17:907:c1b:b0:ab2:db7b:5db3 with SMTP id
 a640c23a62f3a-abb70e37954mr1575662066b.54.1739892061842; 
 Tue, 18 Feb 2025 07:21:01 -0800 (PST)
Received: from [10.232.133.75] ([88.128.90.10])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abbbbc95288sm130032466b.158.2025.02.18.07.21.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 07:21:01 -0800 (PST)
Message-ID: <fe303b19-c50a-48ed-9d16-4b4d9fcb6990@suse.com>
Date: Tue, 18 Feb 2025 16:20:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250212125457.19014-1-andrea.cervesato@suse.de>
 <20250212130446.GB2036911@pevik>
Content-Language: en-US
In-Reply-To: <20250212130446.GB2036911@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] tools: upgrade kirk to version 1.5
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged thanks

Andrea

On 2/12/25 14:04, Petr Vorel wrote:
> Hi Andrea,
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Thanks!
>
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
