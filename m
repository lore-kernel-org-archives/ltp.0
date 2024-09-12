Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1902EED609
	for <ltp@archiver.kernel.org>; Thu, 12 Sep 2024 14:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1726151014; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=o/KYsUIXW02lfKEX++bYydZRr96gWqKZdZVoPMW2g8Y=;
 b=ncbHMkTA/uNx1uOiwIE7Z9cBtaPp8rrbiiRBctIx+KTi81My3vU1H/SpvqSUAlnhssggZ
 GBNnOicMVmDpxTSeaoCHpXREmVpbEPAkwGIjbU7BUzJO1GXKV8v+08NZ57TtGeQggKIdjk4
 d+6iG/0K2uhyzR0UcOdoXZGCSoyUi7c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 084AA3C266E
	for <ltp@archiver.kernel.org>; Thu, 12 Sep 2024 16:23:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 850733C2403
 for <ltp@lists.linux.it>; Thu, 12 Sep 2024 16:23:13 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 651B4600702
 for <ltp@lists.linux.it>; Thu, 12 Sep 2024 16:23:12 +0200 (CEST)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a8d24f98215so155085166b.1
 for <ltp@lists.linux.it>; Thu, 12 Sep 2024 07:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1726150992; x=1726755792; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TTaZS/zyRpHLTrnjSytN3lHS4RBmdjCosO+9/RnNlvE=;
 b=fT4ldtsfZyqqv1cJtfgKjVBU/gFiJVINqAENNn/2LyhbQk66c7aFOq0XDVlAo2aXKB
 om12Lftj6/QNF8Mn4xfShZkdWNryjQJebo87h0qE1J4TtnWU8MQmnRj02HjPeXT5BpDN
 ImeCvrhMhKhtxcCw3yIv1+fsTmfN7z05hWAQ5g4kZfl+U77Sgdw1mDvMFGUUPgIOF8fh
 ay1CEngWGgzPlfi8pPq6h760D/w3ewzcBIbkr69e7c/cY/mrcpFQpt/ACSznN4sgL1mn
 sKcO9tSDztC6hTs0+eMl/meJdf/BvcHo2TzZ+c3ls8w2AJ3y6bXubKVXOzhoJKVea6PD
 vHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726150992; x=1726755792;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TTaZS/zyRpHLTrnjSytN3lHS4RBmdjCosO+9/RnNlvE=;
 b=J6VUtDnB277XiThHRT2vqBtMRkUlYW6Ui3AfDZWBRi6Wa1fZop5M/3lq+IYUerWov4
 34Y4ScSHOeEYQSpdgsirYzyKcUr9YOmuOaon6Hz3E4V61/PwMhdEO5HYuKeJo4MrIKu5
 38nDId6fDr6J/dKIgustOS/dDFcwrmPU1NodAPUlvwO4ymnTBWqvkHoGDKLaWLz7mNjE
 FC7JykrFF+aINrV9AhpMxzT6ABv2ceXZVHWDT9vJwNILGNDIfLE9GDoxQSAMI6I9aur3
 UGs+oemfDd8Xn2BH3bh+Q4EX+ng14ty/4CnRODY4IQ+d5cMqI61/Kq4F8kILze6c73vY
 F6SA==
X-Gm-Message-State: AOJu0Yx1uJdCL+B57HYwL7pRKjcFwjcj6c+tsxIIJtQG7PnUeEx+p2xO
 q+3EN0lb/WtxgdNBdYC/URAw5Cgb1oxJ8STkbfOaZUUkDQAkla/rzFy9yWZUoQs=
X-Google-Smtp-Source: AGHT+IEejyfAoiSvSQOI+TwJeCc897E3Vs+E+1tN7o9BZ+DBm7X3l3Ipk6c0czw32B5qs3eoDU3rHg==
X-Received: by 2002:a17:907:e283:b0:a8d:2b7a:ff44 with SMTP id
 a640c23a62f3a-a90295a39eemr288591466b.32.1726150990967; 
 Thu, 12 Sep 2024 07:23:10 -0700 (PDT)
Received: from [192.168.178.49] ([212.86.36.216])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9012cf16absm202487066b.147.2024.09.12.07.23.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2024 07:23:10 -0700 (PDT)
Message-ID: <5fe6c61d-611b-474e-8082-dbbb39a12b73@suse.com>
Date: Thu, 12 Sep 2024 16:23:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240912135303.10034-1-andrea.cervesato@suse.de>
 <ZuL3HQproV1RK_uH@yuki.lan>
Content-Language: en-US
In-Reply-To: <ZuL3HQproV1RK_uH@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8] Refactor fork05 using new LTP API
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

Pushed, thanks

Andrea

On 9/12/24 16:13, Cyril Hrubis wrote:
> Hi!
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
