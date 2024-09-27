Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD541CEBF8C
	for <ltp@archiver.kernel.org>; Fri, 27 Sep 2024 10:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1727432616; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=HCqsOg501zqs0hSMv/bDZPgQ8QA7QbL0OTnEanvh3IU=;
 b=PFRIMzA2b865zzJzQoAlDZFA0EcbMfqyf5N31LWU/QA5goP51R3dubhYWY9gXstL9FJXx
 nLOKSTMveo83ZZUTaVfUkM20LxPvx0R2cwtT8e5Vgfg7+j+QD2QHYpRwF20Ysh5NotZj6iA
 G1J81Rx+JBjpmxfOgCUo4dZWTypf8YE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5651A3C4FEC
	for <ltp@archiver.kernel.org>; Fri, 27 Sep 2024 12:23:36 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED4EA3C4F93
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 12:23:15 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4850614104E2
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 12:23:15 +0200 (CEST)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a8a6d1766a7so253905766b.3
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 03:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1727432594; x=1728037394; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CLFnQetKRLi2AebxsPWiPqwINYtLBm13EgScja85guw=;
 b=X/Bo64QKCw+6Nci70Wc9Z/Y9kxxauFQyAv7Co5/QmB2HCkhvTfpvamOFZWESzfRkMp
 GqUld2ZtAmc/hSjcj17Ord8kL2Efkbg3vcFR+8vf8yXQq/F/y+wMh2awlPLQ26DaLoE3
 WdIuDPgejppUwXWI9zrx/kx/Vcbz0eOcUuURgdtg7NQHW2TtZU/YQCv69X6tWg3Vfcw6
 WSCZKAf0xtKqVjx/1HN282icjmrj9aMl5lcR4Do3R/0e0Z9jIf9tWP9QMlkcPZ1xDyAo
 o9mdTUvBg2+CGgAyzAEsxtBVMewANzkafsMjGvJPy2SRrf07gW99o+1rDR7169XumkjD
 gBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727432594; x=1728037394;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CLFnQetKRLi2AebxsPWiPqwINYtLBm13EgScja85guw=;
 b=oD9O6os5m1lAkw0h3SwRcguW/P80MUQwhxF5XCINtvbt4WJfOyUg4xYapIcgFSV6Fk
 7fos4mf/h+A0DQvRx9alnBMlLe9bGhMQXOjChNXILf4z7t5GqD8xK+ONYc6sZ7z6QQFo
 is/sF32R/ED/mmriXc2Xhu/IZ2uxfkPgSwC3xA4P+QwtB3uRELt3Tr2RdoIYeN+WPQcj
 O9bkP0TmXr81nUT8rNn105l0SXLNz3jaVn8du8KhavDKhphuAYluNq1xUF/0sTcQBRVo
 gzTeeGAznKIGt28yAJXpBLwQDGTfnGg8b54aCyaAYHfKuRR8XXLEyM4JgA8UC2p0SRk6
 jP2A==
X-Gm-Message-State: AOJu0Yz6KxtlEuBWAVxslTjjJQ0NzboSB06RtXHdr5WwfXpuTJ5ymA/X
 +6VbeJvDBRJfIKh+gXa37xbgov981Zm+OvgFxlE4p5cN0ckNmaAVJ/4YayPRR6k=
X-Google-Smtp-Source: AGHT+IEIgdxSjNlWbOI7LvYeBlmvnTlvL3uXcuqnVFMy+rfRYwC+dy/9IMfIrCYIJZ/txGPK/QrPhQ==
X-Received: by 2002:a17:907:3e1c:b0:a8d:495b:c52d with SMTP id
 a640c23a62f3a-a93c4969f43mr224006066b.33.1727432594540; 
 Fri, 27 Sep 2024 03:23:14 -0700 (PDT)
Received: from [10.232.133.5] ([88.128.90.47])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93c277c056sm116301466b.33.2024.09.27.03.23.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Sep 2024 03:23:14 -0700 (PDT)
Message-ID: <44a80f59-0520-41cd-bcd0-e12f64f4ee4c@suse.com>
Date: Fri, 27 Sep 2024 12:23:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <ZtWLSQSSqmh0tn13@yuki.lan> <ZvZu7HoQf5IR1r4K@yuki.lan>
 <70567f32-0e4e-489d-8904-a5ff094b3ab9@suse.com> <ZvZ8e1DzCvsdJFE2@yuki.lan>
Content-Language: en-US
In-Reply-To: <ZvZ8e1DzCvsdJFE2@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preparations
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

Done.

Andrea

On 9/27/24 11:35, Cyril Hrubis wrote:
> Hi!
>> this can be added to the release without impacts. It's actually a devs thing
>>
>> https://patchwork.ozlabs.org/project/ltp/patch/20240919121909.15025-1-andrea.cervesato@suse.de/
> Feel free to push this patch with my ack.
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
