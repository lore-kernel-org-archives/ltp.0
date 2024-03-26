Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4B3C54E67
	for <ltp@archiver.kernel.org>; Tue, 26 Mar 2024 07:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1711439754; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=8cacEWG0e81/RSw1P0CPQoVwmREgga1/4+CUlg74g0w=;
 b=ODLkujidvZo8iWfJ7E5HjFzJv3kdQu8OLs9OXrbbHe7ygjiggJAaSszNd+aMQPXsOCEVt
 R5b8t4i7xQZEd9PBdnSiJ1hf1K5OeVcMsqw44BQmZveDTZAbt9JTqX22GjL3719dTlJONqv
 guTkaA+rEHaXh5oJ090h6qXP6beBP/w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 68D223CE524
	for <ltp@archiver.kernel.org>; Tue, 26 Mar 2024 08:55:54 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F6F53C7CB4
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 08:55:33 +0100 (CET)
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com
 [IPv6:2a00:1450:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A2E83140120D
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 08:55:32 +0100 (CET)
Received: by mail-ej1-x644.google.com with SMTP id
 a640c23a62f3a-a474c4faf5eso255021666b.2
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 00:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1711439731; x=1712044531; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RSbOF3p0uJplCq4Ov8uvI6ZNGJT44TufKgyz258YXGY=;
 b=chM2sMwO58SxjF8Gyf9+R/dBPLH+ndz0IL70ZhUqqntCnEZxvux5Cr4hjtek3mirtS
 Z5X294aGuVI2DK96QpwF2kmPbYEpZvH2fyX/RFVUW7CZTxHsKFvvfuPZMl3YNY6z9D1R
 SewyuT7NGVaWRvXe9ZhlmGQ1nIkglgZt3WcAGrheaHSySFIw+ii5Hjlpius4VUgZJkdG
 DAnM5VYJpmaiDNfbEvE/KWXZsPFKuo3D5E/vTM/7/VZj9EaWclkqwP07hrSHlNg067L8
 2YS/zL//EF/GFgvxCocw2DYeCN+abbimykNi7ZYilVUlDMApYKNTNPz5Dlq3MYjOJhsq
 epTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711439731; x=1712044531;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RSbOF3p0uJplCq4Ov8uvI6ZNGJT44TufKgyz258YXGY=;
 b=GzI6TofeYPzA3Wlq2kSbdgysKxBmbrBGti9LXhG3OdEXnQZ1PtNACL/M78eaABwAN+
 jS8r2pWeBKX3vViGZBCU/VSLn0Cp4L+iuExXKIreOWJ1hT8uYDsSour8kHm4/7sItU7L
 83ENaDwA7KsO+iFbYr3z/QGoME3feLZummA32AYVS5Kc4BXCiGisq6IB8jVJlFO4XRV3
 l4Q9Z4M2JyEC4BCVyiZgkemZOO0zgGKAICmzgYewMvOHjr56Q60toMzVsCe4D6aAsBGN
 v/X07dgrDODzXiE2tFCksONWAlo0aAyZShNnL54ApHHFYMJFUUcc+BgHig8tczyRK0R9
 ULJA==
X-Gm-Message-State: AOJu0YzW+D8opVrXYIl/P6msJniM2UZ91PiCBF7D/0NIEEEXe9kuNp2E
 q8aLoXtlKignoXvHmYtkOBIuk9i4+U+rZPpmgt3lu5J+xQ/PG6jaC9JDWm498faUESORiNWbXsU
 SsLuVy0In+cQ=
X-Google-Smtp-Source: AGHT+IEz5y6mGLj8l9x58B/BFJGVl1hLUPlcG4uzs8MvBFTl9vSe7FFDAwk4kew8K7I5lImoiDRs8g==
X-Received: by 2002:a17:907:8694:b0:a47:4d61:de44 with SMTP id
 qa20-20020a170907869400b00a474d61de44mr5544983ejc.55.1711439731370; 
 Tue, 26 Mar 2024 00:55:31 -0700 (PDT)
Received: from [192.168.178.40] ([212.86.62.247])
 by smtp.gmail.com with ESMTPSA id
 t4-20020a1709066bc400b00a46f95f5849sm3929245ejs.106.2024.03.26.00.55.31
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 00:55:31 -0700 (PDT)
Message-ID: <36d410f8-1946-4a0f-8c30-9810994954ed@suse.com>
Date: Tue, 26 Mar 2024 08:55:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
References: <fd34e495-75cd-4db2-bbf6-975f3697cd51@suse.com>
In-Reply-To: <fd34e495-75cd-4db2-bbf6-975f3697cd51@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Open monthly meeting 4th of April 09:00 UTC
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

Hi all!

Possible discussions for the meeting:
- current project status
- new LTP documentation website
- API documentation

Please, feel free to add more topics :-)


On 3/26/24 08:53, Andrea Cervesato wrote:
> Hello everyone,
>
> this is a friendly reminder for the LTP mailing list about monthly 
> meeting.
> As previously discussed.
>
> Next meeting will be on the 4th of April 09:00 UTC.
> Platform: https://meet.google.com/jon-gytf-uei
>
> Thank you,
> Andrea
>
Andrea Cervesato


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
