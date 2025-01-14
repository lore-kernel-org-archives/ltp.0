Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F64E77188
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 12:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736856147; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=iCvmuG/2UnBjRtU3ftxdKJ1FmK10nYcYSoLimCvkyUQ=;
 b=aTkQeocOn7Idf1VHCCDyjjgo9gRYCGwzPbpC+Edtnr0Af3EB1iNrczw9YIRRnUgpqUoCA
 p11NsxlnPKW8Xsh04sTc6jmJUH7AukwK2vZMS/41rDu1ZVgHyRPqigO6E0TFJt9fva7MojW
 hmwg3r1t5qWiWyE6bqZsTIfzDxU4fHI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F03333C7A14
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 13:02:26 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9EE4F3C184E
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 13:02:06 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 329B11436EBC
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 13:02:05 +0100 (CET)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso37383155e9.0
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 04:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1736856124; x=1737460924; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hgS3qnV57s5pCsgSYH0GWAieQMhvjsEoOae9kPEz8TU=;
 b=AA2rSksjN4cGSR29/TGmhnBx4pDI71NpvMqrxX8yPWMbHL2ditpZEpS3mg6Mk3ZEuB
 g9Fw5FvH6z6fffV9+7STAVtL47y3YTpKFJ6dqb/p2M3OtaAgDpM38XoMjQO6E+iZmYTU
 ofR3aQGBCT5mj3ipZINNwD/Mp6zJpXWZ3p7YN4LJcgNjUG+RAZrvsbVTlncKnt9Qzj8r
 1sZHWDJ7VbCD+vy2IykP8nSXHndYlUMl7otRzm4IJPELLObETbL8kxoIiOHZA7ZjG1L5
 1ld5zwD7Uj1qfbbfChi/SBH1C6gn8Akzs4kShLuX+gMC1Asiiics/ufpydT1JHEU9j4K
 hf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736856124; x=1737460924;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hgS3qnV57s5pCsgSYH0GWAieQMhvjsEoOae9kPEz8TU=;
 b=xUsKfBgeQRZ+4V0d/MWGxoX965moMNrTfJI8gkEvkjg5IDLZYXWbIi+SneA7vl0PXi
 ZjZglyF89XLal6X5a8xSA3OhWM9mmHOZgnze9er56+Lg4PSmbz4FM+EfAzMcHJgPzVrs
 zd7l7dxKZdtm7rSR97oomCQkq4YKVBmBLUj8p54bA2dVOF5ZbZezRrZd2kswcypVrl/6
 TYZToTYUzBtwY3KehBmhqXmyd/rFmxJLqrJMf/mlRsUHmFbZOzpNtPlUswuTyfqEd7s5
 YvJSpITAhtIgQgadlg33WS+sDdv888kOv0pKXaUr9/l9frp8NeJ30vPi1wU+MBf3tHHz
 djWA==
X-Gm-Message-State: AOJu0YxMrAFd/b3q6A5z89JFPqQ9GtvlOnoWKrlMl50zsIeQVJqbdzWP
 ij3qLekBoCD0CcxdZNS7pv4vitH7pibaBkvpYOZUzMoKu0oOZiOSzqwCHHweTqkneCwgqIlV6tk
 Gi44=
X-Gm-Gg: ASbGncvarUKdtxqPi0VBY11Zl+3XZOeZMIPM4S8ZKUwywhTAV7BbZfuZPv+nU5e3PAR
 yPycWbuKCmLonYiMj9MVqTzG5udsm9P2F0MGoIzM6pCco7AQMBtbpofhQ9hYs1hCXhEvU+xEd2a
 aqJZ5VfemVeYXo0JyV/ohXeoSG2gy2IswbXK9KSG7Oj/xEdsvYOtOM6ZKIkWpwxB/ulCm+/IUkL
 w4hoAfcSa2Mgf0OV5/daJDBEx5Bx3QvNaBPH6DeR2rALU1lRV9tJor6wJWXZnnsS/U=
X-Google-Smtp-Source: AGHT+IGWuQRv8ZmJ4+0Y3PL269ClaSoj0uw6plnF8cDv1b9Fgl0DlToyB1nxencwThoB1ftVyER8yQ==
X-Received: by 2002:a05:600c:1da0:b0:434:a923:9310 with SMTP id
 5b1f17b1804b1-436e26a1b4amr238410375e9.15.1736856124450; 
 Tue, 14 Jan 2025 04:02:04 -0800 (PST)
Received: from [10.232.133.36] ([88.128.90.43])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9e6263fsm177469515e9.39.2025.01.14.04.02.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 04:02:04 -0800 (PST)
Message-ID: <dba720b8-db5e-4d95-abfb-3032cb95d119@suse.com>
Date: Tue, 14 Jan 2025 13:02:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20240516112016.309145-1-pvorel@suse.cz>
 <20240516112016.309145-2-pvorel@suse.cz>
 <9d23569c-06fe-40e2-ab49-7ad19fae4be3@suse.com>
 <20240516144336.GA317330@pevik>
Content-Language: en-US
In-Reply-To: <20240516144336.GA317330@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] doc: Convert more C API info
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

Hi Petr,

sorry for the delay. Feel free to push this patch.

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

On 5/16/24 16:43, Petr Vorel wrote:
> Yes, that's preferred. But in many parts of the docs there is some info for
> developing new tests and other for developing library. Sometimes even third
> place: "maintainer checklist".
>
> Kind regards,
> Petr
Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
