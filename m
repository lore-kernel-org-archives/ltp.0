Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9BD9C4345F
	for <ltp@archiver.kernel.org>; Thu, 18 Apr 2024 13:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1713448489; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=e6iG31X061VoE0CqbfDlyiclg1kKwdSUqwYr+Hzu070=;
 b=JbiTxShRy2eHm9pBcpsqpRYBdeUfcqO4x27Yi51D44Ql8meZgqnNdX/Pjkzqi4273MRH7
 6ItClKVkOkr36PzV2mf3ZFVisfBEO1S7nS1dfTykdSdzgcG5/WRGQu8M6m6XRxJeiXN5x5b
 tYibNzetL4FlKYezdzjU42x7sGmuMSw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B33983CFC09
	for <ltp@archiver.kernel.org>; Thu, 18 Apr 2024 15:54:49 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 409793CFBFB
 for <ltp@lists.linux.it>; Thu, 18 Apr 2024 15:54:29 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4F9486025D5
 for <ltp@lists.linux.it>; Thu, 18 Apr 2024 15:54:28 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-418bbc690e1so7679245e9.2
 for <ltp@lists.linux.it>; Thu, 18 Apr 2024 06:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1713448468; x=1714053268; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xVrBjPfBKu1ZhsRD96dfMFMBvzqBLG+Y503jkArV/Aw=;
 b=ZpvwJh4lMzDR/1Um1UVedlhXsf+IqfZCwLuzZhRGSjZ9ONtHrjS8FzDQmZDFXAXf/l
 /dg+tujG5rMd1NktOhx8F9ptqIUfXJlNYdemlskrJdgyBqW7Jmi6HYvzr3YiUC89MwSR
 HBA7RzgzK7omeIT4UjvPOGBSGFgYSoi2gNkc0Mz+bmcjI32mLbHlAKCT5L1PLTw2QsQY
 Xpb5kYqy1A4EtIFkiHZbdMGZiS/Dp/6yrdjFFv/09yTWOHFTcW5dM1YX+P/55AhhsMM7
 XRi8x4b9bmm2tFbp1nlEi82rZXArbHFI1uYDKwygrhLTS2iXOqEmJuMJnBDP7XyHdJPU
 OmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713448468; x=1714053268;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xVrBjPfBKu1ZhsRD96dfMFMBvzqBLG+Y503jkArV/Aw=;
 b=Tj17+M1eNmuuJP/WKf/HYoYOlY/Fgt4wmJEDzwVxYOzGGA2AJiWTnUTdhYVWblmlXa
 dWv9Jt7HLR2s4TV70iXkYkoET44vicREBY2OPtpDMokq+aSjtn81n7hBo1AW374g5nEl
 HbKvFUDiy+R7j/QvOJcFwMHHycgjV0vY/MQDnia4Zdd9kz46iyTbvVTBjiYXUybOAw8P
 Z1tQAxe6Q63WhTqWQ6cAZFVhKys4Z+p9PF0dXfEXHgL877VodY3Caah2mnnfTozYMcb9
 AA33CcI2rxTctS8bQOBcN4f1ylr0114G8za5ooXWMMnoQVjTtC+UGRWqvHpIeplIHH+z
 +3Pw==
X-Gm-Message-State: AOJu0Ywp3dC3GPRIcD7OpIfFMNXQMIaZmHzjMxn7jiwMObAJp34Yw7Uc
 OzB+JDPH6k2tlA81QL7vMXPvoD8yoh8qEB5Ot0EDSbkpMuxKLhX/mraani806VI=
X-Google-Smtp-Source: AGHT+IE7T0AotaKStVrdjvqa/wg4iyJ/g0Vi5kFNySzH+AdCnXir9eEc2BV+Gj31D0tA+L/U6gn9dw==
X-Received: by 2002:a05:600c:5106:b0:418:58ac:7477 with SMTP id
 o6-20020a05600c510600b0041858ac7477mr2133491wms.30.1713448467705; 
 Thu, 18 Apr 2024 06:54:27 -0700 (PDT)
Received: from [192.168.178.40] ([178.20.92.8])
 by smtp.gmail.com with ESMTPSA id
 bi11-20020a05600c3d8b00b00418effbc4f7sm1414026wmb.38.2024.04.18.06.54.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 06:54:27 -0700 (PDT)
Message-ID: <24edfce9-81c6-4880-ae8c-ad8f40a56507@suse.com>
Date: Thu, 18 Apr 2024 15:54:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>
References: <b5872e1e-723f-4444-ae9c-39fd8b9d39fd@suse.com>
 <20240418113204.GA70047@pevik> <ZiENKCoyPNerXCwJ@yuki>
Content-Language: en-US
In-Reply-To: <ZiENKCoyPNerXCwJ@yuki>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Open monthly meeting 8th of May 09:00 UTC
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

ok I suggest to skip the LTP monthly meeting. We can do it the 5th of June.

Regards,
Andrea

On 4/18/24 14:08, Cyril Hrubis wrote:
> Hi!
>> 8th May is a public holiday in the Czech Republic. I guess some of us will not
>> be available in the call (definitely not me). Could we postpone a week later?
>> (although it would work for me, there might be people taking 2 days of vacation
>> on following Thursday and Friday).
> I will not be around at 8th May either.
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
