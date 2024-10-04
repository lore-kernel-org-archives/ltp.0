Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDFACFA750
	for <ltp@archiver.kernel.org>; Fri,  4 Oct 2024 08:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1728029973; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=iCGiM3aew05XM8o1rzV5HUTotEJnWkvcomyYjxOfMTs=;
 b=pNcC2v82Q0RsiPuH8B8QGUSLSRp5oeRlQ/TvmCpH0f2ETleOfBELUIkNGpZVG0wHwkSEi
 dGnIcCkFh20wDOHzU2dT14nVmkxkjezEe/E9OzojIdwVtXmCuCjweLYDnoTop6Z2TYcDwHl
 guDGfcr7N65SWEmPmhdxk62moi/IJjU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 309D03C6156
	for <ltp@archiver.kernel.org>; Fri,  4 Oct 2024 10:19:33 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B7E43C6147
 for <ltp@lists.linux.it>; Fri,  4 Oct 2024 10:19:13 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9E94C1400244
 for <ltp@lists.linux.it>; Fri,  4 Oct 2024 10:19:11 +0200 (CEST)
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5398b589032so2974794e87.1
 for <ltp@lists.linux.it>; Fri, 04 Oct 2024 01:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1728029951; x=1728634751; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eBPzYpNWs58iLW+c/MiA8LqhoAz+51G5DITcDL95+GA=;
 b=TRtTGmRQz8OyFu6dOOAbe5EP8eOrUm8yfaKjXF07mQA4dLS3qKw1+eDOK0DEalrRm3
 N5a7kzGTYYXKItx77f+KS5bDCtCBci36X1JkMqEbAdiN4nVme04NhMWUnLvvk3JS01bh
 AL2dTMVZSmSZf4k+ZqU3rX2HnmAHpevtKns/N8HauLWb/4VAHuvqe5GCq1GajhXu4dC3
 W449bz8S49cH9psynGdPsQ3cbfjorrK1jBf1FuAhx76yH1OZXaWxwmxEUnpeZRgYnAyO
 X5hywbtLfKTW4y6/GfK7StvZdoie/XNGoaShyuy1vIWq9HT574th4+YjKRufy3yOPw7q
 wcvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728029951; x=1728634751;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eBPzYpNWs58iLW+c/MiA8LqhoAz+51G5DITcDL95+GA=;
 b=LjihD0Fh2Qu+L4zB9MD9gmvEl6hdZnpis9cRj8TotnoEwM/ArAvufu2663YcU6FnYn
 8qlrRgo5OXZVx0Xag0CEi0ryicSmZjXnKXUQa+DD51ythFyZ2cLLobz7t3psCYaIsFRu
 0W2v1e26VaQSL2prNUls5r7xf2qixMZZxy/0Uh1W5FiODvi1vlEFJo/8g8GzOV25DoCs
 IB1SMQ4XNbT1PrIr5HfpmOgIVdo84tvI/ccc9LmEQBBXmCaBtJlRSDu64Mx9bMUY+l3v
 S61zTiUGtpxxCqYr7058FZZrYPJS7/jcg3Am7a0loVaJuBD51GsGUK3QbRtkTn2x4bY8
 5gbw==
X-Gm-Message-State: AOJu0YwA3q9x50iyBjMxgp/TFCc6itqsA5dhVhAFGIfVf4cAJ2FSt82+
 8CmHbdngIRm+HOzSycm81EcYvOilJygyvabHS+svSfnIgFYI6zkdXv5LOGKFJ+0=
X-Google-Smtp-Source: AGHT+IHIfJCJSwkQImbo7C7PSzt+iDIHyn5hAl0btvYjl8gGL2CUsevYYI1w1e9tka4STtXNq0ZqLg==
X-Received: by 2002:a05:6512:33ca:b0:536:a4f1:d214 with SMTP id
 2adb3069b0e04-539ab86693emr1912555e87.19.1728029950777; 
 Fri, 04 Oct 2024 01:19:10 -0700 (PDT)
Received: from [192.168.178.49] ([178.20.91.138])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9910286fd8sm189271266b.27.2024.10.04.01.19.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 01:19:10 -0700 (PDT)
Message-ID: <6cac9a7d-3a8c-4502-bd4a-23be491cf0ab@suse.com>
Date: Fri, 4 Oct 2024 10:19:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240909-listmount_statmount-v4-0-39558204ddf0@suse.com>
 <20240909-listmount_statmount-v4-13-39558204ddf0@suse.com>
 <Zv6rklWkNJaT8uvJ@yuki.lan>
Content-Language: en-US
In-Reply-To: <Zv6rklWkNJaT8uvJ@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 13/13] Add statmount07 test
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

Hi!

On 10/3/24 16:34, Cyril Hrubis wrote:
> Hi!
>> +static struct statmount *st_mount;
>> +static struct statmount *st_mount_null;
>> +static uint64_t mnt_id;
>> +static uint64_t mnt_id_dont_exist = -1;
>> +static size_t buff_size;
>> +static size_t buff_size_invalid = -1;
> I suppose that we can as well add buff_size_zero, I would expected
> getting EINVAL from such test.
That seems to be a valid value, since I get PASS. Kernel bug?
> Otherwise:
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>
Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
